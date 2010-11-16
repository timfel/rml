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

    fun bug  s = Util.bug("FrontEndFn."^s)
    fun warn s = Util.warn(s)
    fun sayErr s = Util.outStdErr(s)
  
    fun debug s = if (!Control.importLoadOrder) then Util.outStdErr ("FrontEndFn."^s) else ()  

    (* generates the AST representation *)
    fun doAst((prefix, fileName, ext), astModule) =
    let val fullFileName = Control.joinPathFileExt(prefix, fileName, ext)
    val interfaceFile = Control.getFullFileName(!Control.oTDir, fileName, Control.INTERFACE_FILE)
    val serializationFile = Control.getFullFileName(!Control.oTDir, fileName, Control.SERIALIZATION_FILE)
    in
       if !Control.emitAst (* check if we should dump the AST *)
       then Control.withOutput AbsynPrint.printModule astModule (!Control.oTDir, fileName, SOME("ast"))
       else ();
       if !Control.emitDebug (* check if we should dump the DEBUG instrumented AST *)
       then Control.withOutput AbsynPrint.printModule astModule (!Control.oTDir, fileName, SOME("dbg"))
       else ()
    end

    (* instrument - adrpo 2006-12-27 not done here anymore
    fun doInstrument(fileName, astModule) =
       if !Control.doDebug 
       then Instrument.instrument(fileName, astModule)
       else astModule
    *)

  fun filterImportList(visibility,[]) = []
  |  filterImportList(visibility,(str,v)::rest) = 
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
  let  fun pr(str, (pos1,pos2,visibility), others) = (str,visibility)::others
    val importList = StrDict.fold(pr, [], imports)
  in
    importList
  end

  fun getImports((prefix, fileName, ext), repository) =
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
    val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
    val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
    val imports = 
      case (entryRML, entrySRZ) of
        (SOME(entryR),_) => 
          if Cache.hasRML_M(entryR) 
          then Cache.getImports(Cache.rmlM_info(entryR)) 
          else bug("getImports!")
      |  (NONE,SOME(entryS)) =>
          if Cache.hasSRZ_M(entryS) 
          then Cache.getImports(Cache.srzM_info(entryS))
          else bug("getImports!")
      |  (NONE,NONE) => 
        (case entryMOD of
          SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
        |  NONE => bug("getImports!"))
      
  in
    imports
  end


  fun getInterfaceImports((prefix, fileName, ext), repository) =
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
    val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
    val imports = 
      case (entryRML, entrySRZ) of
        (SOME(entryR),SOME(entryS)) => 
          if Cache.hasRML_I(entryR) 
          then Cache.getImports(Cache.rmlI_info(entryR)) 
          else if Cache.hasSRZ_I(entryS) 
             then Cache.getImports(Cache.srzI_info(entryS))
             else bug("getInterfaceImports!")
      |  (SOME(entryR),_) =>
          if Cache.hasRML_I(entryR) 
          then Cache.getImports(Cache.rmlI_info(entryR)) 
          else bug("getInterfaceImports!")
      |  (_,SOME(entryS)) =>
          if Cache.hasSRZ_I(entryS)
          then Cache.getImports(Cache.srzI_info(entryS))
             else bug("getInterfaceImports!")
      |  (_,_) => bug("getInterfaceImports:"^file)
  in
    publicImportList(getImportList(imports))
  end

  fun getMODImports((prefix, fileName, ext), repository, interfaceOnly) =
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
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
          |  NONE => bug("getMODImports!"))
      |  (SOME(entryR),_) =>
          if Cache.hasRML_M(entryR) 
          then Cache.getImports(Cache.rmlM_info(entryR)) 
          else 
          if Cache.hasRML_I(entryR) 
          then Cache.getImports(Cache.rmlI_info(entryR)) 
          else (case entryMOD of
                SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
                | NONE => bug("getMODImports!"))
      |  (_,SOME(entryS)) =>
          if Cache.hasSRZ_M(entryS) 
          then Cache.getImports(Cache.srzM_info(entryS))
          else 
          if Cache.hasSRZ_I(entryS) 
          then Cache.getImports(Cache.srzI_info(entryS))
          else (case entryMOD of
              SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
              | NONE => bug("getMODImports!"))
      |  (_,_) => (case entryMOD of
                SOME(entryM) => Cache.getImports(Cache.modM_info(entryM))
                | NONE => bug("getMODImports!"))
    val importList = getImportList(imports)   
  in
    if interfaceOnly
    then publicImportList(importList)
    else allImportList(importList)
  end
  
  fun getModuleImports((prefix, fileName, ext), repository) =
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
    val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
    val imports = 
      case (entryRML, entrySRZ) of
        (SOME(entryR),SOME(entryS)) => 
          if Cache.hasRML_M(entryR) 
          then Cache.getImports(Cache.rmlM_info(entryR)) 
          else if Cache.hasSRZ_M(entryS) 
             then Cache.getImports(Cache.srzM_info(entryS))
             else bug("getModuleImports!")
      |  (SOME(entryR),_) =>
          if Cache.hasRML_M(entryR) 
          then Cache.getImports(Cache.rmlM_info(entryR)) 
          else bug("getModuleImports!")
      |  (_,SOME(entryS)) =>
          if Cache.hasSRZ_M(entryS)
          then Cache.getImports(Cache.srzM_info(entryS))
             else bug("getModuleImports!")
      |  (_,_) => bug("getModuleImports!")
  in
    allImportList(getImportList(imports))
  end
  
  fun loadRMLSerializedOrParse func1 func2 (file, repository) =
  let val Absyn.RML_FILE(_,module) = func2(file, repository)
  in
    debug("loadRMLSerializedOrParse: parsing : "^file^"\n");     
    module
  end
  
  fun getModuleIdent((prefix, fileName, ext), repository) =
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
    val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
    val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
    val moduleId =
      case (entryRML, entrySRZ, entryMOD) of
         (SOME(entryR),_,_)       => Cache.getModId(entryR) 
      |  (NONE,SOME(entryS),_)    => Cache.getModId(entryS)
      |  (NONE,NONE,SOME(entryM)) =>  Cache.getModId(entryM)
      |  (NONE,NONE,NONE)         =>  bug("getModId!")
  in
    moduleId
  end

  fun getExternals((prefix, fileName, ext), repository) =
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
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
      |  (NONE,SOME(entryS),_) =>
          if Cache.hasSRZ_M(entryS) 
          then Cache.getExternals(Cache.srzM_info(entryS))
          else 
          if Cache.hasSRZ_I(entryS) 
          then Cache.getExternals(Cache.srzI_info(entryS))
          else bug("getExternals!")
      |  (NONE,NONE,SOME(entryM)) =>
          Cache.getExternals(Cache.srzM_info(entryM))
      |  (NONE,NONE,NONE) => bug("getExternals!")
  in
    externals
  end

  
  fun warnUnusedImports((prefix, fileName, ext), currentModuleDependencies, repository) =
  let 
    val file = Control.joinFileExt(fileName, ext)
    val imports = getImports((prefix, fileName, ext), repository)
    fun apply x = 
         let
           val (f, e) = Control.splitFileExt(x)
         in
           (x, Absyn.identName (getModuleIdent((prefix, f, e), repository)))
         end
    val dependencyModuleIds = ref (map apply currentModuleDependencies)
    val externals = getExternals((prefix, fileName, ext), repository)
    fun verify(str, _,  dict) = 
      let fun loop([]) = []
          |   loop((f,hd)::rest) = 
              if (String.isPrefix hd str)
              then loop(rest)         (* if is there ignore it *)
              else (f,hd)::loop(rest) (* if is not there, keep it and move forward *)
      in
        dependencyModuleIds := loop(!dependencyModuleIds); () 
      end
    val _ = StrDict.fold(verify, (), externals)
    fun loopUnused([]) = ()
    |   loopUnused((f,moduleId)::rest) =
        if moduleId <> "RML" (* ignore RML *)
        then
        let 
           val ((sp,sl,sc),(ep,el,ec)) = 
            case StrDict.find(imports,f) of
              SOME(pos1,pos2,_) => (pos1,pos2)
            |  NONE => bug("warnUnusedImports.loopUnused!")
        in
          if !Control.disableWarnings
          then ()
          else
          (
          sayErr(file^":"^
                 (Int.toString sl)^"."^
                 (Int.toString sc)^"-"^
                 (Int.toString el)^"."^
                 (Int.toString ec)^" ");
                 warn("unused imported module: "^moduleId(*^" in import: "^f*))
          );
          loopUnused(rest)
        end
        else loopUnused(rest)
  in
    loopUnused(!dependencyModuleIds)
  end  

  fun loadRMLInterface((prefix, fileName, ext), repository) =  
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
    val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
    val apply = loadRMLSerializedOrParse AbsynPersist.parseInterface RMLParse.parseInterface
    val module = 
      case (entryRML, entrySRZ) of
        (NONE, NONE) => apply (file,repository)
      |  (SOME(entryR),SOME(entryS)) => 
          if Cache.hasRML_I(entryR) 
          then Cache.rmlI(entryR) 
          else if Cache.hasSRZ_I(entryS) 
             then Cache.srzI(entryS)
             else apply ( file, repository )
      |  (SOME(entryR),_) =>
          if Cache.hasRML_I(entryR) 
          then Cache.rmlI(entryR) 
          else apply ( file, repository )
      |  (_,SOME(entryS)) =>
          if Cache.hasSRZ_I(entryS) 
          then Cache.srzI(entryS)
          else apply ( file, repository )
    fun loop([],r) = ()
    |   loop(x::rest,r) = 
        let
           val (f, e) = Control.splitFileExt(x)
        in
          loadRMLInterface((prefix, f, e), r); 
          loop(rest,r)
        end
  in
    loop(getInterfaceImports((prefix, fileName, ext), repository), repository)
  end

  fun loadRMLFile((prefix, fileName, ext), repository) =  
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
    val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
    val apply = loadRMLSerializedOrParse AbsynPersist.parseModule RMLParse.parseModule
    val module = 
      case (entryRML, entrySRZ) of
        (NONE, NONE) => apply (file,repository)
      |  (SOME(entryR),SOME(entryS)) => 
          if Cache.hasRML_M(entryR) 
          then Cache.rmlM(entryR) 
          else if Cache.hasSRZ_M(entryS) 
             then Cache.srzM(entryS)
             else apply( file, repository )
      |  (SOME(entryR),_) =>
          if Cache.hasRML_M(entryR) 
          then Cache.rmlM(entryR) 
          else apply( file, repository )
      |  (_,SOME(entryS)) =>
          if Cache.hasSRZ_M(entryS) 
          then Cache.srzM(entryS)
          else apply( file, repository )
    val currentModuleDependencies = getModuleImports((prefix, fileName, ext), repository)
    fun loop([],r) = ()
    |   loop(x::rest,r) = 
        let
          val (f, e) = Control.splitFileExt(x) 
        in
          loadRMLInterface((prefix, f, e), r); 
          loop(rest,r)
        end
  in
    loop(currentModuleDependencies,repository);
    (module, currentModuleDependencies)
  end

  fun  printDependencies(file, depends) = 
    let fun pr x = print (x^" ")
    in
     print ("File: "^file^" ["); 
     map pr depends;
     print "]\n" 
    end
    
  fun  printAlready(file, depends) = 
    let fun pr x = print (x^" ")
    in
     print ("Already: "^file^" ["); 
     map pr depends;
     print "]\n" 
    end

  fun loadTranslate((prefix, fileName, ext), repository, alreadyLoaded, translateNeeded) =
  let  
    val file = Control.joinFileExt(fileName, ext)
  in
    if List.exists (fn y => y = file) (!alreadyLoaded)
    then ()
    else (* load it *)
    let 
      fun loop([],r) = ()
      |   loop(x::rest,r) = 
          let
            val (f, e) = Control.splitFileExt(x)
          in
            loadTranslate((prefix, f, e), r, alreadyLoaded, translateNeeded); 
            loop(rest,r)
          end
      val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
      val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
      val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
      val _ = 
        case (entryMOD, entryRML, entrySRZ) of
          (NONE,NONE,NONE) => (* not loaded, just parse *)
          let val srz = loadSerializedMODFile((prefix, fileName, ext), repository, true (* only Interface *))
          in 
            case srz of
              NONE => (* last alternative *)
              (
                debug("loadTranslate: parsing: "^file^"\n");
                MODParse.parseModule(file, repository); 
                translateNeeded := file::(!translateNeeded);
                ()
              )
            |  SOME(_) => 
              (debug("loadTranslate: serialization of: "^file^"\n"))
          end
        |  (_,_,_) => ( (* already loaded *))
      val _ = alreadyLoaded := file::(!alreadyLoaded)
    in
      loop(getMODImports((prefix, fileName, ext), repository, false),repository); ()
    end
  end

  
  and translate((prefix, fileName, ext), SOME(module), repository, alreadyLoaded, translateNeeded) = 
     let 
       val file = Control.joinFileExt(fileName, ext)
       fun loop([],r) = ()
       |   loop(x::rest,r) = 
           let
             val (f, e) = Control.splitFileExt(x)
           in 
             loadTranslate((prefix, f, e), r, alreadyLoaded, translateNeeded); 
             loop(rest,r)
           end
       val imports = getMODImports((prefix, fileName, ext), repository, true)
       val _ = loop(imports,repository);
     in
       module
     end
  |  translate((prefix, fileName, ext), NONE, repository, alreadyLoaded, translateNeeded) =
     let 
         val file = Control.joinFileExt(fileName, ext)
         val fullFileName = Control.joinPathFileExt(prefix, fileName, ext)
         fun loop([],r) = ()
         |  loop(x::rest,r) = 
            let
              val (f, e) = Control.splitFileExt(x)
            in
              loadTranslate((prefix, f, e), r, alreadyLoaded, translateNeeded); 
              loop(rest,r)
            end
     in
       debug("translate: translating: "^file^"\n");    
       let val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
           val Absyn.MOD_FILE(_,parsedMODModule) = 
               case entryMOD of
                  NONE => MODParse.parseModule(fullFileName, repository)
               |  SOME(entryM) => Absyn.MOD_FILE(file,Cache.modM(entryM))
           val imports = getMODImports((prefix, fileName, ext), repository, false)
           val _ = loop(imports,repository);
           val translated = Reorder.reorderModule( MOToRML.transformMOToRML(parsedMODModule, imports, repository) )
           val interfaceFile = Control.getFullFileName(!Control.oTDir, fileName, Control.INTERFACE_FILE)
           val serializationFile = (!Control.oTDir, fileName, SOME(Control.getFileExt(Control.SERIALIZATION_FILE)))
       in 
         (* dump the serialization *)
         case Control.fileType file of
            Control.MO_FILE (* dump .srz only if is .mo file and the .srz is dirty *)
               => if Control.isSerializedFileValid(prefix, fileName, ext)
                  then ()
                  else Control.withOutput AbsynPersist.serializeModule translated serializationFile
         |  _ => ();
         translated
       end
     end

  and loadSerializedMODFile ((prefix, fileName, ext), repository, loadInterface) = 
  if Control.isSerializedFileValid(prefix, fileName, ext)
  then 
    let 
        val fullFileName = Control.getFullFileName(!Control.oTDir, fileName, Control.SERIALIZATION_FILE)
        val _ = debug("loadSerialized: reading serialization of : "^fullFileName^"\n")
        val Absyn.SRZ_FILE(_, Absyn.SERIALIZED(_, SOME(module))) =
        if loadInterface 
        then AbsynPersist.parseInterface(fullFileName, repository)
        else AbsynPersist.parseModule(fullFileName, repository)
     in
      SOME(module)
    end
  else NONE

  and loadMODFile((prefix, fileName, ext), repository, alreadyTranslated, alreadyLoaded, loadInterfaceOnly) = 
  let 
    val file = Control.joinFileExt(fileName, ext)
    val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
    val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
    val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
    val translateNeeded : string list ref = ref []
    val _ = alreadyLoaded = ref []
    val isSRZ = ref false 
    fun apply (f,r,loadInterfaceOnly) = 
      let val  module = loadSerializedMODFile((prefix, fileName, ext), repository, loadInterfaceOnly);
        val is_SRZ = (case module of NONE    => false |  SOME(_) => true)
        val isSRZ = ref is_SRZ
        val translatedModule = translate((prefix, fileName, ext), module, repository, alreadyLoaded, translateNeeded);
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
          Cache.insert(repository, Cache.rmlCache, file,
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
        (NONE, NONE) => apply (file, repository, loadInterfaceOnly)
      |  (SOME(entryR),SOME(entryS)) => 
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
      |  (SOME(entryR),_) =>
          if Cache.hasRML_M(entryR) 
          then Cache.rmlM(entryR) 
          else 
          if Cache.hasRML_I(entryR) 
          then Cache.rmlI(entryR)           
          else apply( file, repository, loadInterfaceOnly)
      |  (_,SOME(entryS)) =>
          if Cache.hasSRZ_M(entryS) 
          then Cache.srzM(entryS)
          else 
          if Cache.hasSRZ_I(entryS) 
          then Cache.srzI(entryS)
          else apply( file, repository, loadInterfaceOnly)
      else
      case (entryRML, entrySRZ) of
        (NONE, NONE) => apply (file, repository, loadInterfaceOnly)
      |  (SOME(entryR),SOME(entryS)) => 
          if Cache.hasRML_M(entryR) 
          then Cache.rmlM(entryR) 
          else if Cache.hasSRZ_M(entryS) 
             then Cache.srzM(entryS)
             else apply( file, repository, loadInterfaceOnly)
      |  (SOME(entryR),_) =>
          if Cache.hasRML_M(entryR) 
          then Cache.rmlM(entryR) 
          else apply( file, repository, loadInterfaceOnly)
      |  (_,SOME(entryS)) =>
          if Cache.hasSRZ_M(entryS) 
          then Cache.srzM(entryS)
          else apply( file, repository, loadInterfaceOnly)
    fun loop([],r) = ()
    |   loop(x::rest,r) = 
        let
           val (f, e) = Control.splitFileExt(x)
        in
          if List.exists (fn y => y = x) (!alreadyTranslated)
          then loop(rest,r)
          else 
            let 
            in
              debug ("loadMODFile: Translating Additional:"^x^"\n"); 
              loadMODFile((prefix, f, e), r, alreadyTranslated, alreadyLoaded, true); loop(rest,r)
           end
        end
    val currentModuleDependencies = getMODImports((prefix, fileName, ext), repository, false)
    
    fun append([]) = ()
    |  append(x::rest) = 
       if List.exists (fn y => (x = y)) (!translateNeeded)
       then append(rest)
       else (translateNeeded := x :: (!translateNeeded); append(rest))
    
    val _ = append(currentModuleDependencies)
    val dependencies = !translateNeeded
    (*
    val _ = printDependencies(file, dependencies)
    val _ = printAlready(file, !alreadyTranslated) 
    *)

  in
    loop(dependencies, repository); 
    (module, currentModuleDependencies)
  end  
  
    (* parse a module and its dependencies *)
    fun parse repository (prefix, fileName, ext) =
    let 
      val fullFileName = Control.joinPathFileExt(prefix, fileName, ext)
      val _ = debug ("parse: Main file to parse: "^fullFileName^"\n")
      val alreadyTranslated = ref []
      val alreadyLoaded : string list ref = ref []
      val (module, currentModuleDependencies) =
      case (Control.fileType fullFileName) of 
         Control.RML_FILE => loadRMLFile ( (prefix, fileName, ext), repository )
      |  Control.MO_FILE  => loadMODFile ( (prefix, fileName, ext), repository, alreadyTranslated, alreadyLoaded, false)
      |  _ => Util.error("FrontEndFn.parse: unknown file type:"^fullFileName)
    in
      (* all dependencies are loaded! see about includes! *)
      warnUnusedImports((prefix, fileName, ext), currentModuleDependencies, repository);
      module
    end

    (* parse a file only *)
    fun parseMinimal repository ((prefix, fileName, ext), onlyImports) =
    let 
      val fullFileName = Control.joinPathFileExt(prefix, fileName, ext)
      val _ = debug ("parseMinimal: Main file to parse: "^fullFileName^"\n")
      val module =
         case (Control.fileType fullFileName) of 
           Control.RML_FILE => 
             SOME(loadRMLSerializedOrParse AbsynPersist.parseModule 
               RMLParse.parseModule (fullFileName, repository))
        |  Control.MO_FILE  => 
             let val module =
                 if onlyImports
                 then let val Absyn.MOD_FILE(_,parsedMODModule) = MODParse.parseModule(fullFileName, repository)
                      in 
                        NONE 
                      end
                 else
                     case loadSerializedMODFile((prefix, fileName, ext), repository, false) of
                        SOME(m) => SOME(m)
                     |  NONE => 
                        let 
                          val Absyn.MOD_FILE(_,parsedMODModule) = MODParse.parseModule(fullFileName, repository)
                        in
                          SOME(Reorder.reorderModule( 
                                 MOToRML.transformMOToRML(
                                   parsedMODModule, [], repository) ))
                        end
      in
        module
      end
    |  _ => Util.error("FrontEndFn.parseMinimal: unknown file type:"^fullFileName)
    in
     module
  end
  
  fun printImports(os,imports) =
  let 
      fun prStr file = 
      let
        val (f, e) = Control.splitFileExt(file)
      in
        TextIO.output(os, Control.getFullFileName(!Control.oTDir, f, Control.INTERFACE_FILE)); 
        TextIO.output(os, " ")
      end
  in 
    map prStr imports; ()
  end

  fun dumpDepends(prefix, fileName, ext, repository) = 
  let
    val fullFileName = Control.joinPathFileExt(prefix, fileName, ext)
    val fullFileNameC = Control.joinPathFileExt(!Control.oTDir, fileName, SOME("c"))
    val _ = parseMinimal repository ((prefix, fileName, ext), true) (* parse ONLY the file *)
    val imports = getMODImports((prefix, fileName, ext), repository, false)
  in    
    print fullFileNameC; print ": "; print fullFileName; print " ";
    Control.withOutputStream printImports imports TextIO.stdOut;
    print "\n";
    NONE
  end

  fun dumpInterface(prefix, fileName, ext, repository) =   
  let  
    val fullFileName = Control.joinPathFileExt(prefix, fileName, ext)
    val SOME(astModule) = parseMinimal repository ((prefix, fileName, ext), false) (* parse ONLY the file *)
  in 
    Control.withOutputStream AbsynPrint.printInterface astModule TextIO.stdOut;
    NONE
  end
  
  (* statically elaborate a module (typecheck) *)
  fun checkModule((prefix, fileName, ext), module, repository) = 
    if !Control.emitRdb
    then Control.withOutputOption StatElab.checkModule (module,repository) (!Control.oTDir, fileName, SOME("rdb"))
    else StatElab.checkModule(NONE, (module, repository))
  
  fun processFile((prefix, fileName, ext), repository) =
    let 
      val fullFileName = Control.joinPathFileExt(prefix, fileName, ext)
    in    
      case(!Control.dumpDepends,   (* should we dump the dependency ? *)
           !Control.dumpInterface) (* should we dump the interface  ? *)
      of (true, _) => dumpDepends(prefix, fileName, ext, repository)
      |  (_, true) => dumpInterface(prefix, fileName, ext, repository)
      |  (_, _)    => (* normal compilation path *)
        let  (* do debug Instrumentation if specified so! *)
          val astModule = parse repository (prefix, fileName, ext) (* parse everything! *)
          (*
          adrpo - 2006-12-27 do not instrument here anymore! 
          val astModule = doInstrument(fileName, astModule )
          *)
          (* print the AST if required by -East *)
          val _ = doAst((prefix, fileName, ext), astModule)
          (* check the module = static elaboration *)
          val _ = checkModule((prefix, fileName, ext), astModule, repository)
        in
          if !Control.onlyTypeCheck 
          then NONE 
          else SOME(astModule)
        end
      end
    
    (* statically elaborate an entire program (typecheck) *)
    fun checkProgram(modseq, repository) = 
    if !Control.emitRdb
    then 
        Control.withOutputOption StatElab.checkProgram (modseq, repository) 
        (!Control.oTDir, "program", SOME("all.rdb"))
    else 
        StatElab.checkProgram (NONE, (modseq, repository))
    
  fun processProgram(prefixes, repository) =
    let val modseq = map (parse repository) prefixes 
        val _ = checkProgram(modseq, repository)
    in
    modseq
    end  
             
  end (* functor FrontEndFn *)

