
(* MOToMOFn.sml *)

functor MOToMOFn(
			   structure Absyn : ABSYN
		       structure Control  : CONTROL
		       structure Util     : UTIL
			 ) : MOTOMO =
  struct

    structure Absyn = Absyn
    structure IdentDict = Absyn.IdentDict

    datatype kind	    = CON | FUN | FUNTYPE
    datatype valvalue	= VAL of {k: kind, v: int}

    fun bug s = Util.bug("MOToMOFn."^s)

	fun warn s = print  ("\nWARNING: MOToMOFn."^s^"\n\n")
	
	val debugFlag = false
	fun debug s = if (debugFlag) then print ("MOToMOFn."^s) else ()
	
	fun L(x) = (Int.toString (List.length x))		
	
	fun getPathLastIdent(Absyn.QUALIFIED(_, x, _)) = getPathLastIdent(x)
	|	getPathLastIdent(Absyn.PATHIDENT(id, _)) = id
	|	getPathLastIdent(_) = bug("getPathLastIdent: identifier of qualified identifier expected")
	
	fun getImportLastIdent(Absyn.QUAL_IMPORT(path, _)) = getPathLastIdent(path)
	|   getImportLastIdent(_) = bug("getImportLastIdent - only qualified imports are handled!")
		
	fun sweepTopElements([], importFiles) = importFiles
		| sweepTopElements(
			Absyn.ELEMENTITEM(Absyn.ELEMENT(_,_,_,ident, elementSpec, info, NONE),_)::rest, importFiles) = 
			(
			debug ("sweepTopElements: "^(Absyn.identName ident)^" rest: "^L(rest)^"\n");
			(case  elementSpec of 
			   Absyn.IMPORT(import, _ ,_) =>
						let val importFile = (Absyn.identName (getImportLastIdent(import)))^".mo" 
						in  
						 (
						 debug ("sweepTopElements -> IMPORT:"^importFile^"\n");
						 importFiles @ (importFile :: sweepTopElements(rest, []))
						 )
						end
			  | _ => importFiles @ sweepTopElements(rest, []))
			)
		| sweepTopElements(_, importFiles) = bug("sweepTopElements - only class definitions, components and imports handled in the top part!")

	fun walkTop([Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info)], importFiles) =
		let val _ = 
				case restriction of
			   	  Absyn.R_CLASS(_)  =>  ()
				| Absyn.R_MODEL(_)    =>  ()
				| Absyn.R_PACKAGE(_)  =>  ()
				| Absyn.R_FUNCTION(_) =>  ()
				| _ => bug("walkTop - You MUST have ONE top (package|model|class|function) that encloses all other elements!")
			val classparts' = 
					case classdef of
						Absyn.PARTS(classparts, _, _) => classparts
					  | _ => bug("walkTop - other classparts than PARTS are not handled in the top part!")
			fun sweepElems([], importFiles) = importFiles
			  | sweepElems(classpart::rest, importFiles) = 
				case classpart of
				Absyn.PUBLIC(elementItems, _)      =>  
					sweepTopElements(elementItems, importFiles) @ sweepElems(rest, [])
				| Absyn.PROTECTED(elementItems, _) =>  
					sweepTopElements(elementItems, importFiles) @ sweepElems(rest, []) 
				| _ => bug("walkTop - only PUBLIC/PROTECTED are handled in the top part!")					
		in
		   debug("walkTop\n"); 
		   sweepElems(classparts', importFiles)
		end	
	  | walkTop(_, importFiles) = bug("walkTop - You MUST have ONE top (package|model|class|function) that encloses all other elements!")

	fun collectImportFiles(Absyn.PROGRAM(classes, within, interface, info)) =
		(
		debug("collectImportFiles\n");
		walkTop(classes, [] (* importFiles *))
		)
			
    fun getImports(Absyn.MODELICA(program, _)) = 
		(debug("getImports\n"); collectImportFiles(program))

    fun mo2imports(modelica) = 
	   let val importFiles = getImports(modelica)
	   in
		 debug("mo2imports\n");	   
	     (importFiles, modelica)
	   end
	
	
	fun getRecordConstructors(Absyn.MODELICA(program, _)) =
	let (* returns the record constructors only *)
		fun sweepRecords([]) = []
		|   sweepRecords(
				Absyn.ELEMENTITEM(
					Absyn.ELEMENT(_,_,_,
						ident, 
						elementSpec as Absyn.CLASSDEF(_, class as 
									Absyn.CLASS(
										identclass,
										partial,
										final,
										encapsulated,
										_,
										classdef as Absyn.PARTS(classparts, _, _),
										_), _), 
						info, 
						NONE),
					_)::rest) = class::sweepRecords(rest)
		|   sweepRecords(_::rest) = sweepRecords(rest)
			   
		(* this one looks inside uniontype for constructors *)			
		fun getRecords([]) = []
			| getRecords(Absyn.PUBLIC(elementItems, _)::rest) = 
				sweepRecords(elementItems) @ getRecords(rest)
			| getRecords(Absyn.PROTECTED(elementItems, _)::rest) = 
				sweepRecords(elementItems) @ getRecords(rest)
			| getRecords(_) = bug("getRecords - only PUBLIC and PROTECTED are handled in UNIONTYPE ")	
						
		fun collectRecords (classdef, recordConstructors) = 
			let val classparts = case classdef of
								Absyn.PARTS(classparts, _, _) => classparts
								| _ => bug("buildDatatype - other classparts than PARTS are not handled in the UNIONTYPE ")
				val recordList = getRecords(classparts)
			in
				recordConstructors @ recordList
			end
					
		fun walkClasses(class::rest, recordConstructors) = 
			let val _ = debug("walkClasses entry\n")
				val Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info) = class
				val recConst = case restriction of
							  Absyn.R_FUNCTION(_)  =>     [class]
							| Absyn.R_UNIONTYPE(_) =>     collectRecords(classdef, recordConstructors)
							| _ => []
			in
			 debug("walkClasses ["^L(rest)^"]\n");		
			 recConst @ walkClasses(rest, []) 
			end		
		| walkClasses([], recordConstructors) = (debug("walkClasses [0]\n"); recordConstructors)
			
		and sweepTopElements([], recordConstructors) = recordConstructors
			| sweepTopElements(
				Absyn.ELEMENTITEM(Absyn.ELEMENT(_,_,_,ident, elementSpec, info, NONE),_)::rest, recordConstructors) = 
				(
					debug ("sweepTopElements: "^(Absyn.identName ident)^" rest: "^L(rest)^"\n");
					(case  elementSpec of 
						Absyn.CLASSDEF(_, class, _) => 
							( 
							debug("sweepTopElements -> CLASSDEF\n");
							walkClasses([class], recordConstructors) @ sweepTopElements(rest, [])
							)
					| _ => recordConstructors @ sweepTopElements(rest, [])
					)
				)
			| sweepTopElements(_, recordConstructors) = 
				bug("sweepTopElements - only class definitions, components and imports handled in the top part!")

		fun walkTopPackage([Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info)], recordConstructors) =
			let val _ = 
					case restriction of
			   		Absyn.R_CLASS(_)  =>  ()
					| Absyn.R_MODEL(_)    =>  ()
					| Absyn.R_PACKAGE(_)  =>  ()
					| Absyn.R_FUNCTION(_) =>  ()
					| _ => bug("walkTop - You MUST have ONE top (package|model|class|function) that encloses all other elements!")
				val classparts' = 
						case classdef of
							Absyn.PARTS(classparts, _, _) => classparts
						| _ => bug("walkTop - other classparts than PARTS are not handled in the top part!")
				fun sweepElems([], recordConstructors) = recordConstructors
				| sweepElems(classpart::rest, recordConstructors) = 
					case classpart of
					Absyn.PUBLIC(elementItems, _)      =>  
						sweepTopElements(elementItems, recordConstructors) @ sweepElems(rest, [])
					| Absyn.PROTECTED(elementItems, _) =>  
						sweepTopElements(elementItems, recordConstructors) @ sweepElems(rest, []) 
					| _ => bug("walkTop - only PUBLIC/PROTECTED are handled in the top part!")					
			in
			debug("walkTopPackage\n"); 
			sweepElems(classparts', recordConstructors)
			end	
		| walkTopPackage(_, recordConstructors) = bug("walkTopPackage - You MUST have ONE top (package|model|class|function) that encloses all other elements!")

		fun getPackageIdent([Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info)]) =
			ident
		| getPackageIdent(_) = bug("getPackageIdent - You MUST have ONE top (package|model|class|function) that encloses all other elements!")

		fun collectRecordConstructors(Absyn.PROGRAM(classes, within, interface, info)) =
			let val recordConstructors = walkTopPackage(classes, [] (* record constructors *))
				val ident = getPackageIdent(classes)
			in
			  [Absyn.PACKAGE(ident, recordConstructors)]
			end
	in
		collectRecordConstructors(program)	
	end
	
	fun mo2recordconstructors(modelica) = getRecordConstructors(modelica)		
	
	         
  end (* functor InstrumentFn *)
