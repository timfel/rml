(* FrontEndFn.sml *)

functor FrontEndFn(
	structure Cache: CACHE
	structure Control: CONTROL
	structure Absyn: ABSYN
	structure StatElab : STAT_ELAB where type repository = Cache.repository
	structure RMLParse : RML_PARSE where type repository = Cache.repository
	structure MODParse : MOD_PARSE where type repository = Cache.repository
	structure AbsynPrint : ABSYN_PRINT
	structure AbsynPersist : ABSYN_PERSIST where type repository = Cache.repository
	structure Util : UTIL
	structure Reorder : REORDER
	structure MOToRML : MOTORML where type repository = Cache.repository
	structure Instrument : ABSYN_INSTRUMENTED
	sharing   AbsynPrint.Absyn = AbsynPersist.Absyn = Cache.Absyn = StatElab.Absyn = 
	          RMLParse.Absyn = MODParse.Absyn
	sharing type Reorder.Absyn.module = Cache.Absyn.module
	sharing type MODParse.Absyn.module = RMLParse.Absyn.module
	sharing type MOToRML.Absyn.modelica = Cache.Absyn.modelica
	sharing type MOToRML.Absyn.module = Cache.Absyn.module
	sharing type AbsynPersist.Absyn.serialized = Cache.Absyn.serialized
	sharing type Instrument.Absyn.module = Cache.Absyn.module = AbsynPrint.Absyn.module = AbsynPersist.Absyn.module
	sharing type StatElab.Absyn.module = Cache.Absyn.module
	) : FRONTEND =
  struct

	structure Absyn   = Cache.Absyn
	structure Absyn   = RMLParse.Absyn
	structure Absyn   = MODParse.Absyn
	structure Absyn   = AbsynPersist.Absyn
	structure StrDict = Cache.StrDict 
	
    structure Cache   = Cache
    structure Control = Control
    
    type repository = Cache.repository

	val debugFlag = false
	fun debug s = if (debugFlag) then Util.outStdErr ("FrontEndFn."^s) else ()    
	
	fun bug  s = Util.bug("FrontEndFn."^s)
	
	fun warn s = Util.warn(s)

	fun sayErr s = Util.outStdErr(s)

    (* generates the AST representation *)
    fun doAst((prefix, ext), astModule) =
    let val fileName = Control.joinBaseExt(prefix, ext)
		val interfaceFile = Control.getFileName(fileName, Control.INTERFACE_FILE)
		val serializationFile = Control.getFileName(fileName, Control.SERIALIZATION_FILE)
    in
       if !Control.emitAst (* check if we should dump the AST *)
       then Control.withOutput AbsynPrint.printModule astModule (prefix ^ ".ast")
       else ();
       if !Control.emitDebug (* check if we should dump the DEBUG instrumented AST *)
       then Control.withOutput AbsynPrint.printModule astModule (prefix ^ ".dbg")
       else ()       
    end

    (* instrument  *)
    fun doInstrument(prefix, astModule) =
       if !Control.doDebug then Instrument.instrument(prefix, astModule)
       else astModule

	fun filterImportList(visibility,[]) = []
	|	filterImportList(visibility,(str,v)::rest) = 
		if (visibility = v)	
		then str::filterImportList(visibility, rest)
		else filterImportList(visibility, rest) 
			

	fun allImportList(imports) = 
			filterImportList(Cache.PUBLIC,imports) @ 
			filterImportList(Cache.PROTECTED,imports)   @
			filterImportList(Cache.BOTH,imports)
			
	fun publicImportList(imports) = 
			filterImportList(Cache.PUBLIC,imports) @ filterImportList(Cache.BOTH,imports)
	fun protectedImportList(imports) = 
			filterImportList(Cache.PROTECTED,imports) @ filterImportList(Cache.BOTH,imports)

	fun getImportList(imports) =
	let	fun pr(str, (pos1,pos2,visibility), others) = (str,visibility)::others
		val importList = StrDict.fold(pr, [], imports)
	in
		importList
	end

	fun getImports(file, repository) =
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
		val imports = 
			case (entryRML, entrySRZ) of
				(SOME(entryR),_) => 
					if Cache.hasRML_M(entryR) 
					then Cache.getImports(Cache.rmlM_info(entryR)) 
					else bug("getImports!")
			|	(NONE,SOME(entryS)) =>
					if Cache.hasSRZ_M(entryS) 
					then Cache.getImports(Cache.srzM_info(entryS))
					else bug("getImports!")
			|	(NONE,NONE) => 
				(case entryMOD of
					SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
				|	NONE => bug("getImports!"))
			
	in
		imports
	end


	fun getInterfaceImports(file, repository) =
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val imports = 
			case (entryRML, entrySRZ) of
				(SOME(entryR),SOME(entryS)) => 
					if Cache.hasRML_I(entryR) 
					then Cache.getImports(Cache.rmlI_info(entryR)) 
					else if Cache.hasSRZ_I(entryS) 
						 then Cache.getImports(Cache.srzI_info(entryS))
						 else bug("getInterfaceImports!")
			|	(SOME(entryR),_) =>
					if Cache.hasRML_I(entryR) 
					then Cache.getImports(Cache.rmlI_info(entryR)) 
					else bug("getInterfaceImports!")
			|	(_,SOME(entryS)) =>
					if Cache.hasSRZ_I(entryS)
					then Cache.getImports(Cache.srzI_info(entryS))
						 else bug("getInterfaceImports!")
			|	(_,_) => bug("getInterfaceImports:"^file)
	in
		publicImportList(getImportList(imports))
	end

	fun getMODImports(file, repository, interfaceOnly) =
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
		val imports = 
			case (entryRML, entrySRZ) of
				(SOME(entryR),SOME(entryS)) => 
					if Cache.hasRML_M(entryR) 
					then Cache.getImports(Cache.rmlM_info(entryR)) 
					else 
					if Cache.hasRML_I(entryR) 
					then Cache.getImports(Cache.rmlI_info(entryR)) 
					else 
					if Cache.hasSRZ_M(entryS) 
					then Cache.getImports(Cache.srzM_info(entryS))
					else 
					if Cache.hasSRZ_I(entryS) 
					then Cache.getImports(Cache.srzI_info(entryS))
					else 
					(case entryMOD of
						SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
					|	NONE => bug("getMODImports!"))
			|	(SOME(entryR),_) =>
					if Cache.hasRML_M(entryR) 
					then Cache.getImports(Cache.rmlM_info(entryR)) 
					else 
					if Cache.hasRML_I(entryR) 
					then Cache.getImports(Cache.rmlI_info(entryR)) 
					else (case entryMOD of
								SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
							  | NONE => bug("getMODImports!"))
			|	(_,SOME(entryS)) =>
					if Cache.hasSRZ_M(entryS) 
					then Cache.getImports(Cache.srzM_info(entryS))
					else 
					if Cache.hasSRZ_I(entryS) 
					then Cache.getImports(Cache.srzI_info(entryS))
					else (case entryMOD of
							SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
						  | NONE => bug("getMODImports!"))
			|	(_,_) => (case entryMOD of
								SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
							  | NONE => bug("getMODImports!"))
		val importList = getImportList(imports) 	
	in
		if interfaceOnly
		then publicImportList(importList)
		else allImportList(importList)
	end
	
	fun getModuleImports(file, repository) =
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val imports = 
			case (entryRML, entrySRZ) of
				(SOME(entryR),SOME(entryS)) => 
					if Cache.hasRML_M(entryR) 
					then Cache.getImports(Cache.rmlM_info(entryR)) 
					else if Cache.hasSRZ_M(entryS) 
						 then Cache.getImports(Cache.srzM_info(entryS))
						 else bug("getModuleImports!")
			|	(SOME(entryR),_) =>
					if Cache.hasRML_M(entryR) 
					then Cache.getImports(Cache.rmlM_info(entryR)) 
					else bug("getModuleImports!")
			|	(_,SOME(entryS)) =>
					if Cache.hasSRZ_M(entryS)
					then Cache.getImports(Cache.srzM_info(entryS))
						 else bug("getModuleImports!")
			|	(_,_) => bug("getModuleImports!")
	in
		allImportList(getImportList(imports))
	end
	
	fun loadRMLSerializedOrParse func1 func2 (file, repository) =
	(* 
	if Control.isSerializedFileValid(file)
	then 
	(
		debug("loadRMLSerializedOrParse: reading serialization of : "^file^"\n");
		let val Absyn.SRZ_FILE(_, Absyn.SERIALIZED(_, SOME(module))) = 
					func1(
					Control.getFileName(file, Control.SERIALIZATION_FILE),
					repository)
		in
			module
		end
	)
	else 
	*)
	let val Absyn.RML_FILE(_,module) = func2(file, repository)
	in
		debug("loadRMLSerializedOrParse: parsing : "^file^"\n");		 
		module
	end
	
	fun getModuleIdent(file, repository) =
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
		val moduleId =
			case (entryRML, entrySRZ, entryMOD) of
				(SOME(entryR),_,_)       => Cache.getModId(entryR) 
			|	(NONE,SOME(entryS),_)    => Cache.getModId(entryS)
			|	(NONE,NONE,SOME(entryM)) =>	Cache.getModId(entryM)
			|	(NONE,NONE,NONE)         =>	bug("getModId!")
	in
		moduleId
	end

	fun getExternals(file, repository) =
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
		val externals =
			case (entryRML, entrySRZ, entryMOD) of
				(SOME(entryR),_,_) => 
					if Cache.hasRML_M(entryR) 
					then Cache.getExternals(Cache.rmlM_info(entryR)) 
					else 
					if Cache.hasRML_I(entryR) 
					then Cache.getExternals(Cache.rmlI_info(entryR)) 
					else bug("getExternals!")					 
			|	(NONE,SOME(entryS),_) =>
					if Cache.hasSRZ_M(entryS) 
					then Cache.getExternals(Cache.srzM_info(entryS))
					else 
					if Cache.hasSRZ_I(entryS) 
					then Cache.getExternals(Cache.srzI_info(entryS))
					else bug("getExternals!")
			|	(NONE,NONE,SOME(entryM)) =>
					Cache.getExternals(Cache.srzM_info(entryM))
			|	(NONE,NONE,NONE) => bug("getExternals!")
	in
		externals
	end

	
    fun warnUnusedImports(file, currentModuleDependencies, repository) =
    let val imports = getImports(file, repository)
		fun apply x = (x, Absyn.identName (getModuleIdent(x, repository)))
		val dependencyModuleIds = ref (map apply currentModuleDependencies)
		val externals = getExternals(file, repository)
		fun verify(str, _,  dict) = 
			let fun loop([]) = []
				|	loop((f,hd)::rest) = 
					if (String.isPrefix hd str)
					then loop(rest)                 (* if is there ignore it *)
					else (f,hd)::loop(rest) (* if is not there, keep it and move forward *)
			in
				dependencyModuleIds := loop(!dependencyModuleIds); () 
			end
		val _ = StrDict.fold(verify, (), externals)
		fun loopUnused([]) = ()
		|	loopUnused((f,moduleId)::rest) =
			if moduleId <> "RML" (* ignore RML *)
			then
			let val ((sp,sl,sc),(ep,el,ec)) = 
						case StrDict.find(imports,f) of
							SOME(pos1,pos2,_) => (pos1,pos2)
						|	NONE => bug("warnUnusedImports.loopUnused!")
			in
				sayErr(
					 file^":"^
					(Int.toString sl)^"."^
					(Int.toString sc)^"-"^
					(Int.toString el)^"."^
					(Int.toString ec)^" ");
				warn("unused imported module: "^moduleId(*^" in import: "^f*));
				loopUnused(rest)
			end
			else loopUnused(rest)
    in
		loopUnused(!dependencyModuleIds)
    end	

	fun loadRMLInterface(file, repository) =	
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val apply = loadRMLSerializedOrParse AbsynPersist.parseInterface RMLParse.parseInterface
		val module = 
			case (entryRML, entrySRZ) of
				(NONE, NONE) => apply (file,repository)
			|	(SOME(entryR),SOME(entryS)) => 
					if Cache.hasRML_I(entryR) 
					then Cache.rmlI(entryR) 
					else if Cache.hasSRZ_I(entryS) 
						 then Cache.srzI(entryS)
						 else apply ( file, repository )
			|	(SOME(entryR),_) =>
					if Cache.hasRML_I(entryR) 
					then Cache.rmlI(entryR) 
					else apply ( file, repository )
			|	(_,SOME(entryS)) =>
					if Cache.hasSRZ_I(entryS) 
					then Cache.srzI(entryS)
					else apply ( file, repository )
		fun loop([],r) = ()
		|	loop(x::rest,r) = (loadRMLInterface(x,r); loop(rest,r))
	in
		loop(getInterfaceImports(file, repository), repository)
	end

	fun loadRMLFile(file, repository) =	
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val apply = loadRMLSerializedOrParse AbsynPersist.parseModule RMLParse.parseModule
		val module = 
			case (entryRML, entrySRZ) of
				(NONE, NONE) => apply (file,repository)
			|	(SOME(entryR),SOME(entryS)) => 
					if Cache.hasRML_M(entryR) 
					then Cache.rmlM(entryR) 
					else if Cache.hasSRZ_M(entryS) 
						 then Cache.srzM(entryS)
						 else apply( file, repository )
			|	(SOME(entryR),_) =>
					if Cache.hasRML_M(entryR) 
					then Cache.rmlM(entryR) 
					else apply( file, repository )
			|	(_,SOME(entryS)) =>
					if Cache.hasSRZ_M(entryS) 
					then Cache.srzM(entryS)
					else apply( file, repository )
		val currentModuleDependencies = getModuleImports(file, repository)
		fun loop([],r) = ()
		|	loop(x::rest,r) = (loadRMLInterface(x,r); loop(rest,r))
	in
		loop(currentModuleDependencies,repository);
		
		let val interfaceFile = Control.getFileName(file, Control.INTERFACE_FILE)
			val serializationFile = Control.getFileName(file, Control.SERIALIZATION_FILE)
		in 
			(* dump the interface *)
			if not(!Control.dumpInterface) andalso Control.isInterfaceFileValid(file)   
			then ()
			else Control.withOutput AbsynPrint.printInterface module interfaceFile
		end;
		
		(module, currentModuleDependencies)
	end

	fun	printDependencies(file, depends) = 
		let fun pr x = print (x^" ")
		in
		 print ("File: "^file^" ["); 
		 map pr depends;
		 print "]\n" 
		end
		
	fun	printAlready(file, depends) = 
		let fun pr x = print (x^" ")
		in
		 print ("Already: "^file^" ["); 
		 map pr depends;
		 print "]\n" 
		end

	fun loadTranslate(file, repository, alreadyLoaded, translateNeeded) =
	if List.exists (fn y => y = file) (!alreadyLoaded)
	then ()
	else 
	(* load it *)
	let fun loop([],r) = ()
		|	loop(x::rest,r) = (loadTranslate(x,r,alreadyLoaded, translateNeeded); loop(rest,r))	 
	in
		let val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
			val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
			val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
			val _ = 
				case (entryMOD, entryRML, entrySRZ) of
					(NONE,NONE,NONE) => (* not loaded, just parse *)
					let val srz = loadSerializedMODFile(file, repository, true (* only Interface *))
					in 
						case srz of
							NONE => (* last alternative *)
							(
								debug("loadTranslate: parsing: "^file^"\n");
								MODParse.parseModule(file, repository); 
								translateNeeded := file::(!translateNeeded);
								()
							)
						|	SOME(_) => 
							(debug("loadTranslate: serialization of: "^file^"\n"))
					end
				|	(_,_,_) => ( (* already loaded *))
			val _ = alreadyLoaded := file::(!alreadyLoaded)
		in
			loop(getMODImports(file, repository, false),repository); ()
		end
	end	

	
	and translate(file, SOME(module), repository, alreadyLoaded, translateNeeded) = 
	let fun loop([],r) = ()
		|	loop(x::rest,r) = (loadTranslate(x,r,alreadyLoaded,translateNeeded); loop(rest,r))
		val imports = getMODImports(file, repository, true)
		val _ = loop(imports,repository);
	in
		module
	end
	|	translate(file, NONE, repository, alreadyLoaded, translateNeeded) =
	let fun loop([],r) = ()
		|	loop(x::rest,r) = (loadTranslate(x,r,alreadyLoaded,translateNeeded); loop(rest,r))	 
	in
		debug("translate: translating: "^file^"\n");  	
		let val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
			val Absyn.MOD_FILE(_,parsedMODModule) = 
				case entryMOD of
					NONE => MODParse.parseModule(file, repository)
				|	SOME(entryM) => Absyn.MOD_FILE(file,Cache.modM(entryM))
			val imports = getMODImports(file, repository, false)
			val _ = loop(imports,repository);
			val translated = 
					Reorder.reorderModule( 
						MOToRML.transformMOToRML(parsedMODModule, imports, repository) )
			val interfaceFile = Control.getFileName(file, Control.INTERFACE_FILE)
			val serializationFile = Control.getFileName(file, Control.SERIALIZATION_FILE)
			in 
				(* dump the interface *)
				if not(!Control.dumpInterface) andalso Control.isInterfaceFileValid(file)   
				then ()
				else Control.withOutput AbsynPrint.printInterface translated interfaceFile;
				(* dump the serialization *)
				case Control.fileType file of
						Control.MO_FILE (* dump .srz only if is .mo file and the .srz is dirty *)
						=> if Control.isSerializedFileValid(file)
						then ()
						else Control.withOutput AbsynPersist.serializeModule translated serializationFile
				|	_ => ();
				(*
				if Control.isSerializedInterfaceValid(fileName) 
				then ()
				else Control.withOutput AbsynPrint.printInterface astModule interfaceFile;
				if Control.isSerializedModuleValid(fileName) then ()
				else Control.withOutput AbsynPrint.printModule astModule moduleFile;
				*)
				translated
			end
	end

	and loadSerializedMODFile (file, repository, loadInterface) = 
	if Control.isSerializedFileValid(file)
	then 
	(
		debug("loadSerialized: reading serialization of : "^file^"\n");
		let val Absyn.SRZ_FILE(_, Absyn.SERIALIZED(_, SOME(module))) =
				if loadInterface 
				then 
					AbsynPersist.parseInterface(
					Control.getFileName(file, Control.SERIALIZATION_FILE),
					repository)
				else
					AbsynPersist.parseModule(
					Control.getFileName(file, Control.SERIALIZATION_FILE),
					repository)
		in
			SOME(module)
		end
	)
	else NONE

	and loadMODFile(file, repository, alreadyTranslated, loadInterfaceOnly) = 
	let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
		val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
		val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
		val translateNeeded = ref []
		val alreadyLoaded = ref []		
		val isSRZ = ref false 
		fun apply (f,r,loadInterfaceOnly) = 
			let val	module = loadSerializedMODFile(file, repository, loadInterfaceOnly);
				val is_SRZ = (case module of NONE    => false |	SOME(_) => true)
				val isSRZ = ref is_SRZ
				val translatedModule = 
						translate(
							file, 
							module, 
							repository, 
							alreadyLoaded,
							translateNeeded);
				val _ = alreadyTranslated := file::(!alreadyTranslated)
			in
				(* update RML cache *)
				if (!isSRZ) then ()
				else
					let val entry = Cache.getEntry(repository, Cache.modCache, file)
						val Cache.ENTRY{moduleId,program=
								SOME(Cache.INFO{
										imports,
										externals,
										restrictions,
										reordered,
										elaborated,...}),...} = entry
					in
					Cache.insert(
							repository, 
							Cache.rmlCache,
							file,
							Cache.makeEntry(
							let val fileInfo =
								Cache.makeFileInfo(
									Absyn.RML_FILE(file,translatedModule),
									imports,
									externals,
									restrictions,
									ref true, (* reordered *)
									ref false (* elaborated *)
									)
							in
								(moduleId,SOME(fileInfo), NONE)
							end
							))			
					end;
				translatedModule
			end
		val module = 
			if loadInterfaceOnly
			then
			case (entryRML, entrySRZ) of
				(NONE, NONE) => apply (file,repository, loadInterfaceOnly)
			|	(SOME(entryR),SOME(entryS)) => 
					if Cache.hasRML_M(entryR) 
					then Cache.rmlM(entryR) 
					else
					if Cache.hasRML_I(entryR) 
					then Cache.rmlI(entryR) 					
					else 
					if Cache.hasSRZ_M(entryS) 
					then Cache.srzM(entryS)
					else 
					if Cache.hasSRZ_I(entryS) 
					then Cache.srzI(entryS)
					else apply( file, repository, loadInterfaceOnly)
			|	(SOME(entryR),_) =>
					if Cache.hasRML_M(entryR) 
					then Cache.rmlM(entryR) 
					else 
					if Cache.hasRML_I(entryR) 
					then Cache.rmlI(entryR) 					
					else apply( file, repository, loadInterfaceOnly)
			|	(_,SOME(entryS)) =>
					if Cache.hasSRZ_M(entryS) 
					then Cache.srzM(entryS)
					else 
					if Cache.hasSRZ_I(entryS) 
					then Cache.srzI(entryS)
					else apply( file, repository, loadInterfaceOnly)
			else
			case (entryRML, entrySRZ) of
				(NONE, NONE) => apply (file,repository, loadInterfaceOnly)
			|	(SOME(entryR),SOME(entryS)) => 
					if Cache.hasRML_M(entryR) 
					then Cache.rmlM(entryR) 
					else if Cache.hasSRZ_M(entryS) 
						 then Cache.srzM(entryS)
						 else apply( file, repository, loadInterfaceOnly)
			|	(SOME(entryR),_) =>
					if Cache.hasRML_M(entryR) 
					then Cache.rmlM(entryR) 
					else apply( file, repository, loadInterfaceOnly)
			|	(_,SOME(entryS)) =>
					if Cache.hasSRZ_M(entryS) 
					then Cache.srzM(entryS)
					else apply( file, repository, loadInterfaceOnly)
		fun loop([],r) = ()
		|	loop(x::rest,r) = 
			if List.exists (fn y => y = x) (!alreadyTranslated)
			then loop(rest,r)
			else 
			let in
			  debug ("loadMODFile: Translating Additional:"^x^"\n"); 
			  loadMODFile(x, r, alreadyTranslated, true); loop(rest,r)
			end
		val currentModuleDependencies = getMODImports(file, repository, false)
		val dependencies = currentModuleDependencies @(!translateNeeded)
		(*
		val _ = printDependencies(file, dependencies)
		val _ = printAlready(file, !alreadyTranslated) 
		*)
	in
		loop(dependencies,repository); 

		(module, currentModuleDependencies)
	end	
	
    (* parse a module *)
    and parse repository ((prefix, ext)) =
    let val file = OS.Path.joinBaseExt {base = prefix, ext = ext}
		val _ = debug ("Main file to parse: "^file^"\n")
		val alreadyTranslated = ref []
		val (module, currentModuleDependencies) =
		case (Control.fileType file) of 
			Control.RML_FILE => 
			loadRMLFile ( file, repository )
		|	Control.MO_FILE  => 
			loadMODFile ( file, repository, alreadyTranslated, false)
		|	_ => Util.error("FrontEndFn.parse: unknown file type:"^file)
    in
		(* all dependencies are loaded! see about includes! *)
		(*
		if !Control.dumpDepends orelse !Control.dumpInterface
		then ()
		else
		*) 
		warnUnusedImports(file, currentModuleDependencies, repository);
    
 		module
	end

    (* statically elaborate a module (typecheck) *)
    fun checkModule((prefix, ext), module, repository) = 
		if !Control.emitRdb
		then Control.withOutputOption StatElab.checkModule (module,repository) (prefix ^ ".rdb")
		else StatElab.checkModule(NONE, (module, repository))


    fun processFile((prefix, ext), repository) =
      let	val fileName = OS.Path.joinBaseExt {base = prefix, ext = ext}
			val astModule = parse repository (prefix, ext) (* parse ONLY the file *)
	  in	  
		if !Control.dumpDepends (* should we dump the dependency ? *)
		then 
			let	val fileNameO = OS.Path.joinBaseExt {base = prefix, ext = SOME("o")}
			in	  
				print fileNameO; print ": "; print fileName; print " ";
				Control.withOutputStream AbsynPrint.printDependencies astModule TextIO.stdOut;
				print "\n";
				NONE
			end
		else
			if !Control.dumpInterface (* should we dump the interface? *)
			then (* do so! *)
			(
			Control.withOutputStream AbsynPrint.printInterface astModule TextIO.stdOut;
			NONE
			)
			else (* normal compilation path *)
				let	(* do debug Instrumentation if specified so! *)
					val astModule = doInstrument( fileName, astModule )
					(* print the AST if required by -East *)
					val _ = doAst((prefix, ext), astModule)
					(* check the module = static elaboration *)
					val _ = checkModule((prefix, ext), astModule, repository)
				in
				  if !Control.onlyTypeCheck then NONE else SOME(astModule)
				end
      end
    (* statically elaborate an entire program (typecheck) *)
    fun checkProgram(modseq, repository) = 
		if !Control.emitRdb
		then Control.withOutputOption StatElab.checkProgram (modseq, repository) ("_all_.rdb")
		else StatElab.checkProgram (NONE, (modseq, repository))
    
	fun processProgram(prefixes, repository) =
    let val modseq = map (parse repository) prefixes 
  	    val _ = checkProgram(modseq, repository)
    in
	  modseq
    end  
    
    (*
    fun warnUnusedImports(imports, externals) =
    let fun pr(str, (pos1,pos2), others) = (str,pos1,pos2)::others
		val importList = ref (StrDict.fold(pr, [], !imports))
		fun verify(str, _,  dict) = 
		let fun loop([]) = []
			|	loop((hd,pos1,pos2)::rest) = 
				if (String.isPrefix hd str)
				then loop(rest)                 (* if is there ignore it *)
				else (hd,pos1,pos2)::loop(rest) (* if is not there, keep it and move forward *)
		in
			importList := loop(!importList); () 
		end
		val _ = StrDict.fold(verify, (), !externals)
		fun loopUnused([]) = ()
		|	loopUnused((import,pos1,pos2)::rest) =
			(
				Util.warn("unused import: "^import,pos1,pos2);
				loopUnused(rest)
			)
    in
		loopUnused(!importList)
    end
    	
    fun prImports   (imports)   = 
    let fun pr(str, _,  dict) = print (" ["^str^"]")
    in
	   print "\nImports:\n";
	   StrDict.fold(pr, (), !imports);
	   print "\n"
	end    
	
    fun prExternals (externals) = 
    let fun pr(str, _,  dict) = print (" ["^str^"]")
    in
	   print "\nExternal:";
	   StrDict.fold(pr, (), !externals);
	   print "\n"
	end    
    *)
         
  end (* functor FrontEndFn *)

(*

    fun parseModule    file = 
	(* see if there is a serialized file *)
	let val serializedOK = Control.isSerializedFileValid(file)
	in
		if (serializedOK andalso !Control.dumpDepends andalso !Control.dumpInterface) orelse 
		   (serializedOK andalso !Control.dumpDepends = false andalso !Control.dumpInterface = false)
		then 
		(
		debug("parseModule: reading serialization of : "^file^"\n");
		let val Absyn.SERIALIZED(_, SOME(module)) = 
		        AbsynPersist.parseModule(Control.getFileName(file, Control.SERIALIZATION_FILE))
		in
		  module
		end
		)
		else 
		let val _ = debug("parsing main file: "^file^"\n");
			val (importList, modelica) = mo2imports(parse(Tokens.START_MODELICA,  file))
			val Absyn.MODELICA(program, _) = modelica		
		    fun loop([]) = []
		    |   loop(importFile::rest) =
				 (
				 debug("parsing imported file: "^importFile^"\n");		    
				 mo2recordconstructors(parse(Tokens.START_MODELICA, importFile)) @ loop(rest)
				 )
			val recordConstructors = 
				if !Control.dumpInterface = false
				then loop(importList)
				else []
		in
		  mo2rmlmodule(Absyn.MODELICA(program, mo2recordconstructors(modelica) @ recordConstructors))
		end
	end
		
    fun parseInterface file = 
		if Control.isSerializedFileValid(file) andalso !Control.dumpInterface = false
		then 
		(
		debug("parseInterface : reading serialization of "^file^"\n");
		let val Absyn.SERIALIZED(_, SOME(module)) = 
		        AbsynPersist.parseInterface(Control.getFileName(file, Control.SERIALIZATION_FILE))
		in
		  module
		end		
		)
		else 
		let val _ = debug("parsing interface of file: "^file^"\n");
		in
			mo2rmlinterface (parse(Tokens.START_MODELICA,  file))
		end

*)