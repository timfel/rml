
(* MOToRMLFn.sml *)

functor MOToRMLFn(
			   structure Absyn : ABSYN
		       structure Control  : CONTROL
		       structure Util     : UTIL
		       structure MOToMO   : MOTOMO
		       sharing type MOToMO.Absyn.modelica = Absyn.modelica
		       sharing type MOToMO.Absyn.Package  = Absyn.Package
			 ) : PARSE =
  struct

    structure Absyn = Absyn
    structure IdentDict = Absyn.IdentDict

    fun bug s = Util.bug("MOToRMLFn."^s)

	fun warn s = print ("\nWARNING: MOToRMLFn."^s^"\n\n")

	val debugFlag = false	
	fun debug s = if (debugFlag) then print ("MOToRMLFn."^s) else ()
	
	fun L(x) = (Int.toString (List.length x))	

	fun mklst(xlst, xnil, xcons) =
	let fun loop([], rest) = rest
		| loop(x::xlst, rest) = loop(xlst, xcons(x,rest))
	in
		loop(rev xlst, xnil)
	end


	fun getShortId(Absyn.LONGID(NONE, ident, _)) = ident
	|	getShortId(_) = bug ("getShortId: expecting a LONGID(NONE, id, _)")

	fun mkCtxInfo(
		ref(Absyn.INFO(file1,loc1,loc2,ref(Absyn.LOC(sl1,sc1,el1,ec1)))),
        ref(Absyn.INFO(file2,loc3,loc4,ref(Absyn.LOC(sl2,sc2,el2,ec2))))) =
              ref(Absyn.INFO(file1,loc1,loc4,
              ref(Absyn.LOC(sl1,sc1,el2,ec2))))

	fun getStringLoc(ref(Absyn.INFO(file, _, _, ref(Absyn.LOC(sl,sc,el,ec))))) =
	(
		" file: "^file^":"^
		(Int.toString sl)^"."^
		(Int.toString sc)^"."^
		(Int.toString el)^"."^
		(Int.toString ec)
	)

	fun prLoc(ref(Absyn.INFO(file, _, _, ref(Absyn.LOC(sl,sc,el,ec))))) =
	(
		debug (" file: "^file^":"^
		(Int.toString sl)^"."^(Int.toString sc)^"."^(Int.toString el)^"."^(Int.toString ec)^
		"\n")
	)
              
	fun prIdentAndLoc(Absyn.IDENT(identstr, info)) =
	(
		debug("IDENT("^identstr^")\n");
		prLoc(info)
	)

	fun prBugLoc(ref(Absyn.INFO(file, _, _, ref(Absyn.LOC(sl,sc,el,ec))))) =
	(
		print (" file: "^file^":"^
		(Int.toString sl)^"."^(Int.toString sc)^"."^(Int.toString el)^"."^(Int.toString ec))
	)
    
    fun getTemp() = "temp"^Int.toString(Util.tick())
     
	fun mktuplety([ty])  = ty
		| mktuplety(tyseq) = Absyn.TUPLEty(tyseq, ref(Absyn.dummyInfo)) 
	

	val modidRML = SOME(Absyn.rmlIdent "RML")
	val id_cons = Absyn.LONGID(modidRML, Absyn.rmlIdent "cons", ref(Absyn.dummyInfo))
	val ctor_cons = SOME id_cons
	val id_nil = Absyn.LONGID(modidRML, Absyn.rmlIdent "nil", ref(Absyn.dummyInfo))
	
	val pat_nil = Absyn.CONpat(id_nil, ref(Absyn.dummyInfo))
	fun pat_cons(p,ps) = Absyn.STRUCTpat(ctor_cons, [p,ps], ref(Absyn.dummyInfo))
	fun mkpatlst lst = mklst(lst, pat_nil, pat_cons)

	val exp_nil = Absyn.CONexp(id_nil, ref(Absyn.dummyInfo))
	fun exp_cons(e,es) = Absyn.STRUCTexp(ctor_cons, [e,es], ref(Absyn.dummyInfo))
	fun mkexplst lst = mklst(lst, exp_nil, exp_cons)

    datatype kind	    = CON | FUN | FUNTYPE
    (* datatype valvalue	= VAL of {k: kind, v: int} *)

	fun  isPattern(exps) =
	let fun is_present(Absyn.NAMEDARG(SOME(ident), exp, infoNamedArg)) = true
		|	is_present(Absyn.NAMEDARG(NONE, exp, infoNamedArg)) = false
	in
		if List.exists is_present exps 
		then true
		else false
	end

	fun removeTyVarDuplicates([]) = []
	|	removeTyVarDuplicates(tyvar::tyvars) =
		let fun is_there(x) = (Absyn.identName x = Absyn.identName tyvar)
		in 
		  if List.exists is_there tyvars
		  then removeTyVarDuplicates(tyvars)
		  else tyvar::removeTyVarDuplicates(tyvars)
		end		

	fun removeVARTyVarDuplicates([]) = []
	|	removeVARTyVarDuplicates((tyvar as Absyn.VARty(id1, _))::tyvars) =
		let fun is_there(Absyn.VARty(id2, _)) = (Absyn.identName id1 = Absyn.identName id2)
			|	is_there(_) = false
		in 
		  if List.exists is_there tyvars
		  then removeVARTyVarDuplicates(tyvars)
		  else tyvar::removeVARTyVarDuplicates(tyvars)
		end
	|	removeVARTyVarDuplicates(x::tyvars) = x::removeVARTyVarDuplicates(tyvars)
	

	fun getBindingFromDec (Absyn.TYPEdec ([x], _)) = [x]
	|	getBindingFromDec (_) = []  

	fun getBindingFromSpec(Absyn.TYPEspec([x], _)) = [x] 
	|	getBindingFromSpec (_) = []  

	fun getTyBindings(specs, decs) =
	(
	List.concat ((List.map getBindingFromDec  decs) @ (List.map getBindingFromSpec specs))
	)
	
	fun getTyBinding(lid, bindtylist) = 
		let fun loop(lid, []) = NONE
			|	loop(lid, Absyn.TYPBIND(tyvars, ident, ty, _)::rest) =
				if (Absyn.lidentName lid = Absyn.identName ident)
				then SOME(ty)
				else loop(lid, rest)
	in
	  loop(lid, bindtylist)
	end

    fun getSeq(lst, getfn, bindtylist) =
      let fun loop([]) = []
	    | loop(x::xs) = (getfn(x, bindtylist)) @ (loop xs)
      in
		case lst of 
			[]		=> []
		|	[x]	=> getfn(x, bindtylist)
		|	(x::xs)	=> getfn(x, bindtylist) @ (loop xs)
      end

    fun getTyVar(ty, bindtylist) = getTypeDispatch(ty, bindtylist)

    and getTyseq(tyseq, bindtylist) = getSeq(tyseq, getTyVar, bindtylist)
	(*
    datatype ty	= VARty of tyvar * info ref
				| CONSty of ty list * longid * info ref
				| TUPLEty of ty list * info ref
				| RELty of ty list * ty list * info ref	 
	*)

    and getTypeDispatch(ty, bindtylist) =
      case ty
		of x as Absyn.VARty(tyvar, _) => [tyvar]
		| Absyn.TUPLEty(tys, _)		  => 
			getSeq(tys, getTyVar, bindtylist)
		| Absyn.RELty(domtys, codtys, _)	  => 
			(getTyseq(domtys, bindtylist)) @ (getTyseq(codtys, bindtylist))
		| Absyn.CONSty(tys, lid, _)	=>
		(
			(case tys
			of []	=> []
			| [ty]	=> getTyVar(ty, bindtylist)
			| _	=> getTyseq(tys, bindtylist)
			) 
			@ 
			(case getTyBinding(lid, bindtylist) of
				SOME(ty) => getTyVar(ty, bindtylist)
			|	NONE => []
			)
		)	

    fun getVARTYSeq(lst, getVARTYfn, bindtylist) =
      let fun loop([]) = []
	    | loop(x::xs) = (getVARTYfn(x, bindtylist)) @ (loop xs)
      in
		case lst of 
			[]		=> []
		|	[x]	=> getVARTYfn(x, bindtylist)
		|	(x::xs)	=> getVARTYfn(x, bindtylist) @ (loop xs)
      end

    fun getVARTYTyVar(ty, bindtylist) = getVARTYTypeDispatch(ty, bindtylist)

    and getVARTYTyseq(tyseq, bindtylist) = getVARTYSeq(tyseq, getVARTYTyVar, bindtylist)
	(*
    datatype ty	= VARty of tyvar * info ref
				| CONSty of ty list * longid * info ref
				| TUPLEty of ty list * info ref
				| RELty of ty list * ty list * info ref	 
	*)

    and getVARTYTypeDispatch(ty, bindtylist) =
      case ty
		of x as Absyn.VARty(tyvar, _) => [x]
		| Absyn.TUPLEty(tys, _)		  => 
			getVARTYSeq(tys, getVARTYTyVar, bindtylist)
		| Absyn.RELty(domtys, codtys, _)	  => 
			(getVARTYTyseq(domtys, bindtylist)) @ (getVARTYTyseq(codtys, bindtylist))
		| Absyn.CONSty(tys, lid, _)	=>
		(
			(case tys
			of []	=> []
			| [ty]	=> getVARTYTyVar(ty, bindtylist)
			| _	=> getVARTYTyseq(tys, bindtylist)
			) 
			@ 
			(case getTyBinding(lid, bindtylist) of
				SOME(ty) => getVARTYTyVar(ty, bindtylist)
			|	NONE => []
			)
		)	


    fun setSeq(lst, setfn, bindtylist) =
      let fun loop([]) = []
	    | loop(x::xs) = (setfn(x, bindtylist)) :: (loop xs)
      in
		case lst of 
			[]		=> []
		|	[x]	=> [setfn(x, bindtylist)]
		|	(x::xs)	=> setfn(x, bindtylist) :: (loop xs)
      end

    fun setTyVar(ty, bindtylist) = setTypeDispatch(ty, bindtylist)

    and setTyseq(tyseq, bindtylist) = setSeq(tyseq, setTyVar, bindtylist)
	(*
    datatype ty	= VARty of tyvar * info ref
				| CONSty of ty list * longid * info ref
				| TUPLEty of ty list * info ref
				| RELty of ty list * ty list * info ref	 
	*)

    and setTypeDispatch(ty, bindtylist) =
      case ty
		of x as Absyn.VARty(tyvar, _) => x
		| Absyn.TUPLEty(tys, info)	  => 
			Absyn.TUPLEty(setSeq(tys, setTyVar, bindtylist), info)
		| Absyn.RELty(domtys, codtys, info) => 
			Absyn.RELty(setTyseq(domtys, bindtylist), setTyseq(codtys, bindtylist), info)
		| Absyn.CONSty(tys, lid, info)	=>
		(
			case tys of 
			    []	=> Absyn.CONSty(
						(case getTyBinding(lid, bindtylist) of
							NONE => []
						|	SOME(ty) => 
							removeVARTyVarDuplicates(getVARTYTyVar(ty, bindtylist))), 
						lid, info)
			| [ty]	=> Absyn.CONSty([setTyVar(ty, bindtylist)], lid, info)
			| _	    => Absyn.CONSty(setTyseq(tys, bindtylist), lid, info)
			 
		)	
	
	fun getPathLastIdent(Absyn.QUALIFIED(_, x, _)) = getPathLastIdent(x)
	|	getPathLastIdent(Absyn.PATHIDENT(id, _)) = id
	|	getPathLastIdent(_) = bug("getPathLastIdent: identifier of qualified identifier expected")	

    (* what can we find in a package/uniontype/function/functiontype/record *)
 
	datatype construct = CoB of Absyn.conbind (* constructors   *)
	                   | TyB of Absyn.typbind (* type bindings  *)
	                   | TyV of Absyn.tyvar   (* type variables *)
				       | CLAUSE of Absyn.clause * Absyn.info ref          (* match clauses  *)
				       | VAL of Absyn.ident * Absyn.exp option * Absyn.ty option * Absyn.info ref  (* value bindings *)
	                   | INTy of Absyn.ty  (* type inputs    *)
	                   | OUTTy of Absyn.ty (* type outputs   *)
	                   | FUNCTYPE of Absyn.ident * construct list
	                   | EXTERNAL of string
	                   | REL of Absyn.ident * Absyn.ty * Absyn.clause option * Absyn.info ref
	                   
	type constructs = construct list


	 (* only 1 DOT please *)
	fun cref2Ident(Absyn.CREF_QUAL(ident1, _, Absyn.CREF_IDENT(ident2, _, _), info)) = 
		Absyn.LONGID(SOME(ident1), ident2, info)
	| cref2Ident(Absyn.CREF_IDENT(ident, _,  info)) = 
		Absyn.LONGID(NONE, ident, info)
	| cref2Ident(Absyn.CREF_IDENT_TYPES(id, pathlist, info)) =
		(prBugLoc(info); print " "; bug ("cref2Ident - unexpected component ref"))
	| cref2Ident(Absyn.CREF_QUAL(_, _, _, info)) = 
		(prBugLoc(info); print " "; bug ("cref2Ident - we only allow one DOT in cref !"))

			
    fun mo2rmlmodule(
		Absyn.MODELICA(
			program as 
			Absyn.PROGRAM(
				_, 
				_, 
				interface as Absyn.INTERFACE({modid=current_modid,source,...}, infoI), 
				info),
			externalDeclarations)) = 
	let

	
	fun getPackageDecl([], id) = []
	|	getPackageDecl(Absyn.PACKAGE(id_mod, externalDecl)::rest, id) = 
		if (Absyn.identName id_mod) = (Absyn.identName id) 
		then externalDecl 
		else getPackageDecl(rest, id)

	fun getRestriction([], id) = NONE
	|	getRestriction(
			Absyn.CLASS(
				identclass, 
				partial, 
				final, 
				encapsulated, 
				restriction, 
				classdef, _)::rest, id) = 
		if (Absyn.identName id) = (Absyn.identName identclass)
		then SOME(restriction) 
		else getRestriction(rest, id)
	

	(* for in the same module declarations, use current_modid here *)
	fun lookupIdent(shortId) = 
		let val extDecl = getPackageDecl(externalDeclarations,current_modid)
		in
			getRestriction(extDecl, shortId)
		end
	
	(* for external declarations *)
	fun lookupLIdent(longId as Absyn.LONGID(SOME(mod_id), shortId, _)) = 
			let val extDecl = getPackageDecl(externalDeclarations, mod_id)
			in
				getRestriction(extDecl, shortId)
			end
	|   lookupLIdent(longId as Absyn.LONGID(NONE, shortId, _)) = lookupIdent(shortId)
	
	
	fun appendSD((s1, d1), (s2, d2)) = ((s1 @ s2), (d1 @ d2))
	
	fun getS((s, d)) = s
	fun getD((s, d)) = d
	
	 (* only 1 DOT please *)
	fun path2Ident(Absyn.QUALIFIED(ident1, Absyn.PATHIDENT(ident2, _), info)) = 
		Absyn.LONGID(SOME(ident1), ident2, info)
	| path2Ident(Absyn.PATHIDENT(ident, info)) = 
		Absyn.LONGID(NONE, ident, info)
	| path2Ident(Absyn.TYPEVARIABLE(ident, info)) =
		Absyn.LONGID(NONE, ident, info)
	| path2Ident(Absyn.QUALIFIED(_, _, info)) = 
		(prBugLoc(info); print " "; bug ("path2Ident - we only allow one DOT in name_path !"))
			
	fun caseType(Absyn.IDENT("Real", info))    = Absyn.IDENT("real", info)
	  | caseType(Absyn.IDENT("Integer", info)) = Absyn.IDENT("int", info)
	  | caseType(Absyn.IDENT("String", info))  = Absyn.IDENT("string", info)
	  | caseType(Absyn.IDENT("Boolean", info)) = Absyn.IDENT("bool", info)
	  | caseType(x) = x 		
	 (* only 1 DOT please *)
	fun getType(Absyn.QUALIFIED(ident1, Absyn.PATHIDENT(ident2, _), info)) = 
		Absyn.CONSty([], Absyn.LONGID(SOME(caseType(ident1)), caseType(ident2), info), info)
	| getType(Absyn.PATHIDENT(ident as Absyn.IDENT(_, info), _)) = 
		Absyn.CONSty([], Absyn.LONGID(NONE, caseType(ident), info), info)
	| getType(Absyn.TYPEVARIABLE(ident as Absyn.IDENT(_, info), _)) = 
		Absyn.VARty(caseType(ident), info)
	| getType(_) = bug ("getType - we only allow one DOT in name_path !")

	fun getTypes([]) = []
		| getTypes(x::rest) = 
			let fun loop ([]) = [] 
				| loop(Absyn.ELEMENTITEM(
							Absyn.ELEMENT(_,_,_,
								ident, 
								elementSpec as Absyn.COMPONENTS(_, path, components, _),
								info, 
								NONE),
							_)::elems) =
					let val ty =  getType(path)
						fun foo(x) = ty
					in 
						List.tabulate (List.length components, foo) @ loop(elems)
					end
				| loop(_::_) = bug("getTypes/loop: expecting ELEMENTITEM(ELEMENT(COMPONENTS(_)))")
			in
			  case x of
				  Absyn.PUBLIC(elementItems, _) => loop(elementItems) @ getTypes(rest)
				| Absyn.PROTECTED(elementItems, _) => loop(elementItems) @ getTypes(rest)
				| _ => bug ("getTypes: expecting just PUBLIC/PROTECTED")
			end
						
	fun buildTypes(path_list) = 
		if List.length path_list = 1
		then getType(List.last path_list)
		else if (List.length path_list > 1)
			 then Absyn.TUPLEty(map getType path_list, ref(Absyn.dummyInfo))
			 else bug("buildTypes - type cannot be empty")

	fun getVarTysFromList([]) = []
	|	getVarTysFromList(x::rest) = getVarTys(x) @ getVarTysFromList(rest)
			 
	and getVarTys(x as Absyn.VARty(tyvar, _)) = [tyvar]
	|	getVarTys(Absyn.TUPLEty(list, _)) = getVarTysFromList(list)
	|	getVarTys(Absyn.CONSty(list, _, _)) = getVarTysFromList(list)
	|	getVarTys(Absyn.RELty(list1, list2, _)) = 
			getVarTysFromList(list1) @ getVarTysFromList(list2)

    (* datatype typbind = TYPBIND of tyvar list * ident * ty * info ref *)

	fun getDerivedType(identclass, path, []) = 
		Absyn.TYPBIND([], 
			identclass,
			getType path, 
			ref(Absyn.identCtxInfo(identclass)))
	| getDerivedType(identclass, path, path_list) =
		let val ty = buildTypes(path_list)
		in 
		case path of 
			Absyn.PATHIDENT(Absyn.IDENT("TUPLE", _), _) => 
			(
			   Absyn.TYPBIND(
					getVarTys ty, 
					identclass,
					ty,
					ref(Absyn.identCtxInfo(identclass)))
			)
		 |  Absyn.PATHIDENT(Absyn.IDENT("LIST", info), _) => 
			(
			   Absyn.TYPBIND(
					getVarTys ty, 
					identclass,					
					Absyn.CONSty(
						[ty], 
						Absyn.LONGID(
							NONE, 
							Absyn.IDENT("list", info), 
							info),
						info),
					ref(Absyn.identCtxInfo(identclass)))
			)
		 |  Absyn.PATHIDENT(Absyn.IDENT("Option", info), _) => 
			(
			   Absyn.TYPBIND(
					getVarTys ty,
					identclass, 
					Absyn.CONSty(
						[ty], 
						Absyn.LONGID(
							NONE, 
							Absyn.IDENT("option", info), 
							info),
						info),
					ref(Absyn.identCtxInfo(identclass)))
			)
		 |  Absyn.PATHIDENT(Absyn.IDENT("ARRAY", info), _) => 
			(
			   Absyn.TYPBIND(
					getVarTys ty,
					identclass, 
					Absyn.CONSty(
						[ty], 
						Absyn.LONGID(
							NONE, 
							Absyn.IDENT("array", info), 
							info),
						info),
					ref(Absyn.identCtxInfo(identclass)))
			)
		 | x =>  
			(
			   Absyn.TYPBIND(
					getVarTys ty,
					identclass,					 
					Absyn.CONSty(
						[ty],
						path2Ident x,
						ref(Absyn.lidentCtxInfo(path2Ident x))),
					ref(Absyn.identCtxInfo(identclass)))
			)		 
		end
					
	(* returns either a conbind or a typbind or a typevariabile *)	                    
	fun sweepRecords([]) = []
        (* 
           normal case: constructor declarations
            record Z types end Z;
        *)				    
        (* 
			replaceable type Type_a; type variables
        *)			
		| sweepRecords( 
			Absyn.ELEMENTITEM(
				Absyn.ELEMENT(_,_,_,
					ident, 
					elementSpec as Absyn.CLASSDEF(_, class as 
								Absyn.CLASS(
									identclass,
									partial,
									final,
									encapsulated,
									Absyn.R_TYPEVARIABLE(_),
									classdef as Absyn.PARTS([], _, _),
								_),
					_), 
					info, 
					NONE),
				_)::rest) = (debug("sweepRecords\n"); TyV(identclass)::sweepRecords(rest))        
		| sweepRecords(
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
				_)::rest) = 
			let val types = getTypes(classparts)
			in
				debug("sweepRecords\n");
				if (List.length classparts = 0)
				then CoB(Absyn.CONcb(identclass, 
						ref(Absyn.identCtxInfo identclass)))::sweepRecords(rest)
				else CoB(Absyn.CTORcb(identclass, types, 
						ref(Absyn.identCtxInfo identclass)))::sweepRecords(rest)
			end
        (* type declarations inside uniontype
           type = IDENT<TYPE list>, 
           ex: type T1 = tuple<Typ1,Typ2>; DERIVED_TYPE
               type T2 = list<Typ3>;        DERIVED_TYPE
               type T3 = T2[:];             DERIVED array/vector here
        *)			
		| sweepRecords( 
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
									classdef,
								_),
					_), 
					info, 
					NONE),
				_)::rest) = 
			(debug("sweepRecords\n");
			 case classdef of
				(* list, option, record, polymorphic *)
 				Absyn.DERIVED_TYPE(path, path_list,	_, infoDerived) =>  
 				TyB((getDerivedType(identclass, path, path_list)))
 				::sweepRecords(rest)
 			|   Absyn.DERIVED(path, SOME([]), _, _, _, infoDerived)	=> 
 				TyB(getDerivedType(identclass, path, []))
				::sweepRecords(rest)
 				(* array / vector *)
 			|   Absyn.DERIVED(path, _, _, _, _, infoDerived)	=> 
 				TyB(getDerivedType(identclass, 
 					Absyn.PATHIDENT(Absyn.IDENT("ARRAY", ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)), 
 				 [path]))
				::sweepRecords(rest)
			| _ => bug("sweepRecords: expecting DERIVED_TYPE or DERIVED!")
 			)
		| sweepRecords(_) = bug("sweepRecords - bug in uniontype: ELEMENTITEM(ELEMENT(CLASSDEF(CLASS(PARTS(R_RECORD)))|CLASS(DERIVED_TYPE)|CLASS(R_TYPEVARIABLE)))! ")


	fun getTyVars([]) = []
	|	getTyVars(x::rest) = 
			case x of 
				TyV(y) => y::getTyVars(rest)
			|	_ => getTyVars(rest)
			
	fun getCons([]) = []
	|	getCons(x::rest) = 
			case x of 
				CoB(y) => y::getCons(rest)
			|	_ => getCons(rest)
			
	fun getTypsSpec([]) = []
	|	getTypsSpec(x::rest) = 
			case x of 
				TyB(y) => Absyn.TYPEspec([y], ref(Absyn.dummyInfo))::getTypsSpec(rest)
			|	_ => getTypsSpec(rest)

	fun getTypsDec([]) = []
	|	getTypsDec(x::rest) = 
			case x of 
				TyB(y) => Absyn.TYPEdec([y], ref(Absyn.dummyInfo))::getTypsDec(rest)
			|	_ => getTypsDec(rest)
		   
	(* this one looks inside uniontype for constructors/types/type variables *)			
	fun buildConstructors([]) = []
		| buildConstructors(Absyn.PUBLIC(elementItems, _)::rest) = 
			sweepRecords(elementItems) @ buildConstructors(rest)
		| buildConstructors(Absyn.PROTECTED(elementItems, _)::rest) = 
			sweepRecords(elementItems) @ buildConstructors(rest)
		| buildConstructors(_) = bug("buildConstructors - only PUBLIC and PROTECTED are handled in UNIONTYPE ")	
					
	fun buildDatatype (ident as Absyn.IDENT(name, info), classdef, isPublic, specs, decs) = 
		let val classparts = case classdef of
							  Absyn.PARTS(classparts, _, _) => classparts
							  | _ => bug("buildDatatype - other classparts than PARTS are not handled in the UNIONTYPE ")
			val contytyvar_list = buildConstructors(classparts)
			val (tyspecs, tydecs, cons, tyvars) = 
					(getTypsSpec(contytyvar_list),
					 getTypsDec(contytyvar_list),
					 getCons(contytyvar_list),
					 getTyVars(contytyvar_list)) 
		in
			debug("buildDatatype: specs\n");
			(
			specs @
			(
			if (isPublic = true) 
			then tyspecs @ [ Absyn.DATAspec([Absyn.DATBIND(tyvars, ident, cons, info)], [], info) ]
			else []
			),
			decs @
			(
			if (isPublic = false) 
			then tydecs @ [ Absyn.DATAdec([Absyn.DATBIND(tyvars, ident, cons, info)], [], info)  ]
			else []
			)			 
			)
		end
		
	(****************** RELATIONS ************************)	(****************** RELATIONS ************************)
	(****************** RELATIONS ************************)	(****************** RELATIONS ************************)
	(****************** RELATIONS ************************)	(****************** RELATIONS ************************)


	fun dummyEq(str, infoEq) = 
		let val goal = Absyn.CALLgoal(
			Absyn.LONGID(NONE, Absyn.IDENT("print", infoEq), infoEq),
			[Absyn.LITexp(Absyn.SCONlit("stuff", infoEq), infoEq)],
			[],
			infoEq)
		in
			debug(str);
			(goal, infoEq)
		end			

	fun dummyFail(str, info) =	
		let
		   val result = Absyn.FAIL(info)
		in
		 debug(str);
		 (result,  NONE,  info)	
		end

  (** Modelica+ Patterns vs. RML patterns
   Pattern = MWILDpat of info ref
			| MLITpat of Exp * info ref
			| MCONpat of Path * info ref
			| MSTRUCTpat of Path option * Pattern list * info ref
			| MBINDpat of var * Pattern * info ref
			| MIDENTpat of ident * Pattern ref * info ref
    pat = WILDpat of info ref
		| LITpat of lit * info ref
		| CONpat of longid * info ref
		| STRUCTpat of longid option * pat list * info ref
		| BINDpat of var * pat * info ref
		| IDENTpat of ident * pat ref * info ref	  
    **)
    
    (*
    datatype lit = CCONlit of char * info ref
				 | ICONlit of int * info ref
				 | RCONlit of real * info ref
				 | SCONlit of string * info ref
	datatype Exp = INTEGER of int
	       | REAL of real
	       | STRING of string
	       | BOOL of bool
	...    
    *)
    fun makeExpLiteral(Absyn.INTEGER(icon, info)) = Absyn.ICONlit(icon, info) 
    | makeExpLiteral(Absyn.REAL(rcon, info)) = Absyn.RCONlit(rcon, info) 
    | makeExpLiteral(Absyn.STRING(scon, info)) = Absyn.SCONlit(scon, info) 
    | makeExpLiteral(_) = bug (" unexpected literal ") 	    
    (*
    | makeExpLiteral(Absyn.BOOL(true)) = Absyn.ICONlit(1, ref(Absyn.dummyInfo))
    | makeExpLiteral(Absyn.BOOL(false)) = Absyn.ICONlit(0, ref(Absyn.dummyInfo))
    *)
	(*
  (** - Expressions *)
  datatype Operator = ADD   | SUB    | MUL     | DIV       | POW
		    | UPLUS | UMINUS
		    | AND   | OR
		    | NOT
		    | LESS  | LESSEQ | GREATER | GREATEREQ | EQUAL | NEQUAL  

  datatype Exp = CREF of ComponentRef
	       | BOOL of bool
	       | BINARY of Exp * Operator * Exp (* Binary operations, e.g. a*b *)
	       | UNARY of Operator * Exp (* Unary operations, e.g. -(x) *)
	       | LBINARY of Exp * Operator * Exp (* Logical binary operations: and, or *)
	       | LUNARY of Operator * Exp (* Logical unary operations: not *)
	       | RELATION of Exp * Operator * Exp (* Relations, e.g. a >= 0 *)
	       | IFEXP of Exp * Exp * Exp * (Exp * Exp) list  (* If expressions *)
	       | CALL of ComponentRef * FunctionArgs (* Function calls *)
	       | ARRAY of Exp list
	       | MATRIX of Exp list list
	       | RANGE of Exp * Exp option * Exp (* Range expressions, e.g. 1:10 or 1:0.5:10 *)
	       | TUPLE of Exp list (*PR.*) (* Tuples used in function calls returning several values *)
	       | END (* array access operator for last element, e.g. a[end]:=1; *)
	       | CODE of Code (* Modelica AST Code constructors *)	

    datatype exp = LITexp of lit * info ref
				 | CONexp of longid * info ref
				 | VARexp of longid * info ref
				 | STRUCTexp of longid option * exp list * info ref
				 | IDENTexp of longid * exp ref * info ref	       
	*)	
	fun translateExpToPatIdent(Absyn.CREF(Absyn.CREF_IDENT(ident, _, infoId), infoCref)) =  
		(
		debug("translateExpToPatIdent: ");
		prIdentAndLoc ident;
		Absyn.IDENTpat(
			ident,
			ref(Absyn.WILDpat(ref(Absyn.dummyInfo))),
			infoCref)		
		)
	(*
	|	translateExpToPatIdent(
			Absyn.CREF_QUAL(ident1, _, 
				Absyn.CREF_IDENT(ident2, _, infoId), infoCref)) =  
		(
		debug("translateExpToPatIdent: ");
		prIdentAndLoc ident;
		Absyn.IDENTpat(
			Absyn.LONGID(NONE, ident, infoId), 
			ref(Absyn.STRUCTpat(NONE,[], ref(Absyn.dummyInfo))),
			infoCref)		
		)
	|	translateExpToPatIdent(_) = bug("unexpected CREF pattern")
	*)	
	|	translateExpToPatIdent(_) = bug("unexpected CREF pattern")

	fun getNArgs(Absyn.FUNCTIONARGS(namedarglist, _)) = namedarglist 

	fun translateExpToPat(Absyn.UNARY(Operator, Exp, info)) = 
		(
			case Operator of
			    (* integer operators *)
				  Absyn.UPLUS(_)       => 
				  (
					case Exp of
						Absyn.INTEGER(x, info) => Absyn.LITpat(makeExpLiteral(Exp), info)
					  | _ => bug("translateExpToPat: unary INT plus applied to real")
				  )				  
				| Absyn.UMINUS(_)      =>
				  (
					case Exp of
						Absyn.INTEGER(x, info) => 
							Absyn.LITpat(makeExpLiteral(Absyn.INTEGER(~x, info)), info)
					  | _ => bug("translateExpToPat: unary INT minus applied to real")
				  )				  
				(* real operators *)
				| Absyn.UPLUS_REAL(_)  => 
				  (
					case Exp of
						Absyn.REAL(x, info) => Absyn.LITpat(makeExpLiteral(Exp), info)
					  | _ => bug("translateExpToPat: unary REAL plus applied to int")
				  )				  
				| Absyn.UMINUS_REAL(_) => 
				  (
					case Exp of
						Absyn.REAL(x, info) => 
							Absyn.LITpat(makeExpLiteral(Absyn.REAL(~x, info)), info)
					  | _ => bug("translateExpToPat: unary REAL minus applied to int")
				  )				  				
				| _ => bug("translateExpToPat: unexpected arithmetic unary operator")  
		)
	| translateExpToPat(i as Absyn.INTEGER(x, info)) = 
		Absyn.LITpat(makeExpLiteral(i), info)
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: INTEGER unexpected expression!")) *)
	| translateExpToPat(r as Absyn.REAL(x, info)) = 
		Absyn.LITpat(makeExpLiteral(r), info)
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: REAL unexpected expression!")) *)
	| translateExpToPat(s as Absyn.STRING(x, info)) = 
		Absyn.LITpat(makeExpLiteral(s), info)
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: STRING unexpected expression!")) *)
	| translateExpToPat(b as Absyn.BOOL(x, info)) = 
	  (
		if x 
		then 
		Absyn.IDENTpat(
			Absyn.IDENT("true", info), 
			ref(Absyn.STRUCTpat(NONE,[], ref(Absyn.dummyInfo))),
			info)		
		else 
		Absyn.IDENTpat(
			Absyn.IDENT("false", info), 
			ref(Absyn.STRUCTpat(NONE,[], ref(Absyn.dummyInfo))),
			info)		
	  )				
	  (* (prBugLoc(info); print "\n"; bug ("translateExpToPat: BOOL unexpected expression!")) *)
	| translateExpToPat(cref as Absyn.CREF(x, info)) =
		translateExpToPatIdent(cref)
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: CREF unexpected expression!")) *)
	| translateExpToPat(Absyn.ARRAY(fargs, info)) = 
		mkpatlst (map translateExpFuncArgToPat (getNArgs fargs))
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: ARRAY unexpected expression!")) *)
	| translateExpToPat(Absyn.TUPLE(fargs, info)) = 
		let val pat_seq = (getNArgs fargs)
		in
			if (List.length pat_seq = 1)
			then translateExpFuncArgToPat(hd pat_seq)
			else Absyn.STRUCTpat(NONE, map translateExpFuncArgToPat pat_seq, info)
		end
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: TUPLE unexpected expression!")) *)
	| translateExpToPat(Absyn.MSTRUCTexp(path, fargs, info)) =
		(
		case path of
			NONE    => Absyn.STRUCTpat(NONE, [], info)
		|	SOME(p) => Absyn.STRUCTpat(
						ctor_cons,
						map translateExpFuncArgToPat (getNArgs fargs), 
						info)
		)
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: MSTRUCTexp unexpected expression!")) *)
	| translateExpToPat(Absyn.CALL(cref, Absyn.FUNCTIONARGS([], _), info)) =
		let val lid = cref2Ident(cref)
		in
		  case lid of
		    Absyn.LONGID(NONE, _, _) => 
				translateExpToPatIdent(Absyn.CREF(cref, info))
		  | _ => Absyn.CONpat(lid, info)
		end
		(* (prBugLoc(info); print "\n"; bug (" CALL unexpected expression!")) *)
	| translateExpToPat(Absyn.CALL(cref, fargs, info)) =
		let val lid = cref2Ident(cref)
		in
		  Absyn.STRUCTpat(SOME(lid), map translateExpFuncArgToPat (getNArgs fargs), info)
		end
		(* (prBugLoc(info); print "\n"; bug (" CALL unexpected expression!")) *)
	| translateExpToPat(Absyn.MWILDexp(info)) = 
		Absyn.WILDpat(info)
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: MWILDexp unexpected expression!")) *)
	(* -- from here on, we cannot make them into patterns *)
	| translateExpToPat(Absyn.MATRIX(x, info)) =
		(prBugLoc(info); print "\n"; bug ("translateExpToPat: MATRIX unexpected expression!"))
	| translateExpToPat(Absyn.RANGE(x, y, z, info)) =
		(prBugLoc(info); print "\n"; bug ("translateExpToPat: RANGE unexpected expression!"))
	| translateExpToPat(Absyn.END(info)) =
		(prBugLoc(info); print "\n"; bug ("translateExpToPat: END unexpected expression!"))
	| translateExpToPat(Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, info)) =
		(prBugLoc(info); print "\n"; bug ("translateExpToPat: MATCHexp unexpected expression!"))
	|	translateExpToPat(Absyn.BINARY(Exp1, Operator, Exp2, info)) =
		(prBugLoc(info); print "\n"; bug("translateExpToPat: unexpected arithmetic binary operator")) 		
	| translateExpToPat(Absyn.RELATION(Exp1,Operator,Exp2, info)) =
		(prBugLoc(info); print "\n"; bug("translateExpToPat: unexpected relational binary operator")) 
	| translateExpToPat(Absyn.LUNARY(Operator, Exp, info)) =
		(prBugLoc(info); print "\n"; bug("translateExpToPat: unexpected logical unary operator")) 
	| translateExpToPat(Absyn.LBINARY(Exp1, Operator,Exp2, info)) = 
		(prBugLoc(info); print "\n"; bug("translateExpToPat: unexpected logical binary operator")) 
	| translateExpToPat(Absyn.IFEXP(a, b, c, d, info)) = 	
		(prBugLoc(info); print "\n"; bug ("translateExpToPat: IFEXP unexpected expression!"))

	and translateExpFuncArgToPat(Absyn.NAMEDARG(ident_option, exp, infoNamedArg)) = 
		(
		case ident_option of
			NONE => translateExpToPat(exp)
		|	SOME(ident) => Absyn.BINDpat(ident, translateExpToPat(exp), infoNamedArg)
		)

	fun translateExpIdent(Absyn.CREF(x, infoCref)) =  
		let val lid = cref2Ident(x)
			val Absyn.LONGID(_, ident, _) = lid
		in
		debug("translateExpIdent: ");
		prIdentAndLoc ident;
		Absyn.IDENTexp(
			lid, (* Absyn.LONGID(NONE, ident, infoId) *) 
			ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
			infoCref)		
		end
	(*
	|	translateExpIdent(Absyn.STRING(str, info)) =
		(
		debug("translateExpIdent: STRING: "^str^"\n");
		Absyn.LITexp(Absyn.SCONlit(str, info), info)		
		)	
	|	translateExpIdent(Absyn.REAL(r, info)) =
		(
		debug("translateExpIdent: REAL: "^Real.toString(r)^"\n");
		Absyn.LITexp(Absyn.RCONlit(r, info), info)		
		)	
	|	translateExpIdent(Absyn.INTEGER(i, info)) =
		(
		debug("translateExpIdent: INTEGER: "^Int.toString(i)^"\n");
		Absyn.LITexp(Absyn.ICONlit(i, info), info)		
		)	
	|	translateExpIdent(Absyn.BOOL(b, info)) =
		(
		debug("translateExpIdent: BOOL: "^"\n");
		if b 
		then 
		Absyn.IDENTexp(
			Absyn.LONGID(NONE, Absyn.IDENT("true", info), info), 
			ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
			info)		
		else 
		Absyn.IDENTexp(
			Absyn.LONGID(NONE, Absyn.IDENT("false", info), info), 
			ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
			info)		
		)			
	|   translateExpIdent(Absyn.CALL(cref, fargs, info)) = 
		(
		 debug("translateExpIdent: CALL: "^"\n");		 
		 prLoc(info);
		 Absyn.LITexp(Absyn.SCONlit("_DUMMY_STUFF_", info), info)
		)
	|   translateExpIdent(x) = 
		(
		let val info = ref(Absyn.dummyInfo)
		in
		 (* translateExp(x); *)
		 debug("translateExpIdent: CALL: "^"\n");		 
		 prLoc(info);
		 Absyn.LITexp(Absyn.SCONlit("_DUMMY_UNSUPORTED_STUFF_", info), info)
		 (* bug("translateExpIdent: CREF expected") *)
		end
		)
	*)
	|	translateExpIdent(_) = bug("translateExpIdent: CREF expected")
					
	(* 
	   look in MOToRML.sml for a version of this function that deals with
	   things like expressions after the then part: "then v1+v2"
	 *)
	 
	(* 
	Expressions can appear in things like:
	- rel(seq_exp) => seq_pat 
	  seq_pat = rel(seq_exp)
	  (_, _) = call(exps)
	- let pat = exp
	  pat = exp
	- var = exp
	  equality(var = exp)
	- not g
	  failure (g)
	*)

	(*
    datatype goal = CALLgoal of longid * exp list * pat list * info ref
				  | EQUALgoal of var * exp * info ref
				  | LETgoal of pat * exp * info ref
				  | NOTgoal of goal * info ref
				  | ANDgoal of goal * goal * info ref
	*)
		
	fun getExp(Absyn.RETURN([exp], _), goal, info) = exp
		
	fun translateExp(Absyn.BINARY(Exp1, Operator, Exp2, info)) =
		let val idop = 
			case Operator of
			(* integer operators *)
			  Absyn.ADD(_)       => "int_add"
			| Absyn.SUB(_)       => "int_sub"
			| Absyn.MUL(_)       => "int_mul"  
			| Absyn.DIV(_)       => "int_div"    
			| Absyn.POW(_)       => "int_pow"
			(* real operator *)			
			| Absyn.ADD_REAL(_)       => "real_add"
			| Absyn.SUB_REAL(_)       => "real_sub"
			| Absyn.MUL_REAL(_)       => "real_mul"  
			| Absyn.DIV_REAL(_)       => "real_div"    
			| Absyn.POW_REAL(_)       => "real_pow"
			| _ => bug("translateExp: unexpected arithmetic binary operator") 
		   val resstr = getTemp()
		   val result = Absyn.RETURN(
							[Absyn.IDENTexp(
								Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
								ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
								info)], 
							info)
		in
		 debug("translateExp-Binary\n");
		 (result, 
		  SOME(Absyn.CALLgoal(
				Absyn.LONGID(NONE,
					Absyn.makeIdent(idop, info), 
					info),
				map getExp ([translateExp(Exp1), translateExp(Exp2)]),
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				info)),
		  info)
		end
	| translateExp(Absyn.UNARY(Operator, Exp, info)) = 
		let val idop = 
			case Operator of
			    (* integer operators *)
				  Absyn.UPLUS(_)       => "int_add"
				| Absyn.UMINUS(_)      => "int_neg"
				(* real operators *)
				| Absyn.UPLUS_REAL(_)  => "real_add"				
				| Absyn.UMINUS_REAL(_) => "real_neg"
				| _ => bug("translateExp: unexpected arithmetic unary operator") 
		   val resstr = getTemp()
		   val result = Absyn.RETURN(
				[Absyn.IDENTexp( 
					Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info), 
					ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
					info)], 
				info)
		in
		 debug("translateExp-Unary\n");		 		
		 (result, 
		  SOME(
		  Absyn.CALLgoal(
				Absyn.LONGID(NONE,
					Absyn.makeIdent(idop, info),
					info),
					map getExp [translateExp(Exp)],
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				info)
		 ),
		 info)
		end
	| translateExp(Absyn.RELATION(Exp1,Operator,Exp2, info)) =
		let val idop = 
			case Operator of
		      Absyn.LESS(_)      => "int_lt"  
		    | Absyn.LESSEQ(_)    => "int_le" 
		    | Absyn.GREATER(_)   => "int_gt" 
		    | Absyn.GREATEREQ(_) => "int_ge" 
		    | Absyn.EQUAL(_)     => "int_eq" 
		    | Absyn.NEQUAL(_)    => "int_ne"  
		    (* real operators *)
		    | Absyn.LESS_REAL(_)      => "real_lt"  
		    | Absyn.LESSEQ_REAL(_)    => "real_le" 
		    | Absyn.GREATER_REAL(_)   => "real_gt" 
		    | Absyn.GREATEREQ_REAL(_) => "real_ge" 
		    | Absyn.EQUAL_REAL(_)     => "real_eq" 
		    | Absyn.NEQUAL_REAL(_)    => "real_ne"
		    | _ => bug("translateExp: unexpected relational binary operator") 
		   val resstr = getTemp()
		   val result = Absyn.RETURN(
							[Absyn.IDENTexp(
								Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
								ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
								info)], 
							info)
		in
		 debug("translateExp-RelationalBinary\n");
		 (result, 
		  SOME(
		  Absyn.CALLgoal(
				Absyn.LONGID(NONE,
					Absyn.makeIdent(idop, info), 
					info),
					map getExp ([translateExp(Exp1), translateExp(Exp2)]),
					(* [translateExpIdent(Exp1), translateExpIdent(Exp2)], *)
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				info)
		  ),
		  info)
		end	
	| translateExp(Absyn.LUNARY(Operator, Exp, info)) =
		let val idop = 
			case Operator of
			    (* logical boolean unary operator *)
				  Absyn.NOT(_)       => "bool_not"
				| _ => bug("translateExp: unexpected logical unary operator") 
		   val resstr = getTemp()
		   val result = Absyn.RETURN(
				[Absyn.IDENTexp( 
					Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info), 
					ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
					info)], 
				info)
		in
		 debug("translateExp-LogicalUnary\n");		 		
		 (result, 
		  SOME(
		  Absyn.CALLgoal(
				Absyn.LONGID(NONE,
					Absyn.makeIdent(idop, info),
					info),
					map getExp [translateExp(Exp)],
					(* [translateExpIdent(Exp)], *)
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				info)
		 ),
		 info)
		end
	| translateExp(Absyn.LBINARY(Exp1, Operator,Exp2, info)) = 
		let val idop = 
			case Operator of
		      Absyn.AND(_) => "bool_and"  
		    | Absyn.OR(_)  => "bool_or" 
		    | _ => bug("translateExp: unexpected logical binary operator") 
		   val resstr = getTemp()
		   val result = Absyn.RETURN(
							[Absyn.IDENTexp(
								Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
								ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
								info)], 
							info)
		in
		 debug("translateExp-LogicalBinary\n");
		 (result, 
		  SOME(
		  Absyn.CALLgoal(
				Absyn.LONGID(NONE,
					Absyn.makeIdent(idop, info), 
					info),
				map getExp ([translateExp(Exp1), translateExp(Exp2)]),
				(* [translateExpIdent(Exp1), translateExpIdent(Exp2)], *)
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				info)
		  ),
		  info)
		end			
	| translateExp(i as Absyn.INTEGER(x, info)) = 
		( Absyn.RETURN([Absyn.LITexp(makeExpLiteral(i), info)], info), NONE, info)
		(* (prBugLoc(info); print "\n"; bug ("translateExp: INTEGER unexpected expression!")) *)
	| translateExp(r as Absyn.REAL(x, info)) = 
		( Absyn.RETURN([Absyn.LITexp(makeExpLiteral(r), info)], info), NONE, info)
		(* (prBugLoc(info); print "\n"; bug ("translateExp: REAL unexpected expression!")) *)
	| translateExp(s as Absyn.STRING(x, info)) = 
		( Absyn.RETURN([Absyn.LITexp(makeExpLiteral(s), info)], info), NONE, info)
		(* (prBugLoc(info); print "\n"; bug ("translateExp: STRING unexpected expression!")) *)
	| translateExp(b as Absyn.BOOL(x, info)) = 
		( Absyn.RETURN([
				if x
				then Absyn.IDENTexp(
						Absyn.LONGID(NONE, Absyn.IDENT("true", info), info), 
						ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
						info)
				else Absyn.IDENTexp(
						Absyn.LONGID(NONE, Absyn.IDENT("false", info), info), 
						ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))),
						info)
				], info), NONE, info)
		(* (prBugLoc(info); print "\n"; bug ("translateExp: BOOL unexpected expression!")) *)
	| translateExp(cref as Absyn.CREF(x, info)) =
		let val result = Absyn.RETURN([translateExpIdent(cref)], info)
		in 
			debug("translateExp: CREF\n");
			(result, NONE, info) 
		end
		(* dummyFail("translateExp: CREF\n", info) *)
		(* (prBugLoc(info); print "\n"; bug ("translateExp: CREF unexpected expression!")) *)
	| translateExp(Absyn.CALL(cref, Absyn.FUNCTIONARGS([], _), info)) =
		let val lid = cref2Ident(cref)
		in
		  (
		  Absyn.RETURN([Absyn.STRUCTexp(SOME lid, [], info)], info),
		  NONE,
		  info
		  )
		end
		(* (prBugLoc(info); print "\n"; bug (" CALL unexpected expression!")) *)
	| translateExp(Absyn.CALL(cref, fargs, info)) =
		let val lid = cref2Ident(cref)
		in
		  (
		  Absyn.RETURN([
		  Absyn.STRUCTexp(SOME lid, map getExp (map translateExpFuncArg (getNArgs fargs)), info)],
		  info),
		  NONE,
		  info
		  )		
		end
		(* (prBugLoc(info); print "\n"; bug (" CALL unexpected expression!")) *)		
	| translateExp(Absyn.TUPLE(fargs, info)) = 
		let val exp_seq = (getNArgs fargs)
		in
			(
			Absyn.RETURN([
			if (List.length exp_seq = 1)
			then getExp (translateExpFuncArg(hd exp_seq))
			else Absyn.STRUCTexp(NONE, 
				 map getExp (map translateExpFuncArg exp_seq), info)], info),
			NONE,
			info
			)
		end
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: TUPLE unexpected expression!")) *)
	| translateExp(Absyn.MSTRUCTexp(path, fargs, info)) =
		(
		Absyn.RETURN([(
		case path of
			NONE    => Absyn.STRUCTexp(NONE, [], info)
		|	SOME(p) => Absyn.STRUCTexp(
						ctor_cons,
						map getExp (map translateExpFuncArg (getNArgs fargs)), 
						info)
		)], info),
		NONE,
		info
		)
		(* (prBugLoc(info); print "\n"; bug ("translateExpToPat: MSTRUCTexp unexpected expression!")) *)
	| translateExp(Absyn.ARRAY(fargs, info)) =
		(
		Absyn.RETURN([ 
		mkexplst (map getExp (map translateExpFuncArg (getNArgs fargs)))
		], info),
		NONE,
		info
		)
		(* (prBugLoc(info); print "\n"; bug ("translateExp: ARRAY unexpected expression!")) *)
	(* not supported right now! *)
	| translateExp(Absyn.IFEXP(a, b, c, d, info)) = 	
		(prBugLoc(info); print "\n"; bug ("translateExp: IFEXP unexpected expression!"))
	| translateExp(Absyn.MATRIX(x, info)) =
		(prBugLoc(info); print "\n"; bug ("translateExp: MATRIX unexpected expression!"))
	| translateExp(Absyn.RANGE(x, y, z, info)) =
		(prBugLoc(info); print "\n"; bug ("translateExp: RANGE unexpected expression!"))
	| translateExp(Absyn.END(info)) =
		(prBugLoc(info); print "\n"; bug ("translateExp: END unexpected expression!")) 
	| translateExp(Absyn.MWILDexp(info)) = 
		(prBugLoc(info); print "\n"; bug ("translateExp: MWILDexp unexpected expression!"))
	| translateExp(Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, info)) =
		(prBugLoc(info); print "\n"; bug ("translateExp: MATCHexp unexpected expression!"))

	and translateExpFuncArg(Absyn.NAMEDARG(NONE, exp, infoNamedArg)) = 
		translateExp(exp)
	|	translateExpFuncArg(Absyn.NAMEDARG(_, _, info)) = 
		(prBugLoc(info); print "\n"; bug ("translateExpFuncArg: unexpected var as pat in expression"))
		
	        
    fun transformPattern(pattern) = 
		case pattern of
		  Absyn.MWILDpat(info)      => Absyn.WILDpat(info)
		| Absyn.MLITpat(Exp, info)  => Absyn.LITpat(makeExpLiteral(Exp), info)
		| Absyn.MCONpat(path, info) => Absyn.CONpat(path2Ident(path), info)
		| Absyn.MSTRUCTpat(path, patterns, info) => 
				(case path of 
					SOME(path') => Absyn.STRUCTpat(SOME(path2Ident(path')), extractPatterns(patterns), info)
					| NONE => Absyn.STRUCTpat(NONE, extractPatterns(patterns), info))
		| Absyn.MBINDpat(var, pat, info) => Absyn.BINDpat(var, transformPattern(pat), info)
		| Absyn.MIDENTpat(ident, ref(pat), info) => Absyn.IDENTpat(ident, ref(transformPattern(pat)), info)
		
	and extractPatterns(patterns) = 
		 map transformPattern patterns

	(*
    datatype goal = CALLgoal of longid * exp list * pat list * info ref
				  | EQUALgoal of var * exp * info ref
				  | LETgoal of pat * exp * info ref
				  | NOTgoal of goal * info ref
				  | ANDgoal of goal * goal * info ref
	*)

	fun getExpTypeAsStr(Absyn.BINARY(Exp1, Operator, Exp2, info)) = 
		("Absyn.BINARY at "^getStringLoc(info))
	| getExpTypeAsStr(Absyn.UNARY(Operator, Exp, info)) =
		("Absyn.UNARY at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.RELATION(Exp1,Operator,Exp2, info)) =
		("Absyn.RELATION at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.LUNARY(Operator, Exp, info)) =
		("Absyn.LUNARY at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.LBINARY(Exp1, Operator,Exp2, info)) = 
		("Absyn.LBINARY at "^getStringLoc(info))	 
	| getExpTypeAsStr(i as Absyn.INTEGER(x, info)) = 
		("Absyn.INTEGER at "^getStringLoc(info))	 
	| getExpTypeAsStr(r as Absyn.REAL(x, info)) = 
		("Absyn.REAL at "^getStringLoc(info))	 
	| getExpTypeAsStr(s as Absyn.STRING(x, info)) = 
		("Absyn.STRING at "^getStringLoc(info))	 
	| getExpTypeAsStr(b as Absyn.BOOL(x, info)) = 
		("Absyn.BOOL at "^getStringLoc(info))	 
	| getExpTypeAsStr(cref as Absyn.CREF(x, info)) =
		("Absyn.CREF at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.CALL(cref, fargs, info)) =
		("Absyn.CALL at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.TUPLE(fargs, info)) = 
		("Absyn.TUPLE at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.MSTRUCTexp(path, fargs, info)) =
		("Absyn.MSTRUCTexp at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.ARRAY(fargs, info)) =
		("Absyn.ARRAY at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.IFEXP(a, b, c, d, info)) = 	
		("Absyn.IFEXP at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.MATRIX(x, info)) =
		("Absyn.MATRIX at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.RANGE(x, y, z, info)) =
		("Absyn.RANGE at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.END(info)) =
		("Absyn.END at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.MWILDexp(info)) = 
		("Absyn.MWILDexp at "^getStringLoc(info))	 
	| getExpTypeAsStr(Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, info)) =
		("Absyn.MATCHexp at "^getStringLoc(info))	 
	
	
	
	fun translateEqualsEquation(exp1, exp2, infoEq) =
	(
		debug("translateEqualsEquation: ["^getExpTypeAsStr(exp1)^"] = ["^getExpTypeAsStr(exp2)^"\n");
		case (exp1, exp2) of 
		(Absyn.CREF(ComponentRef1 as Absyn.CREF_IDENT(ident1, _, infoId1), infoExp1),
		 Absyn.CALL(ComponentRef2 as Absyn.CREF_IDENT(ident2, _, infoId2),  
								   FunctionArgs as Absyn.FUNCTIONARGS(Exps, infoFArgs),
								   infoExp2)) 
				=>
				let val goal = Absyn.CALLgoal(
					Absyn.LONGID(NONE, ident2, infoId2),
					map getExp (map translateExpFuncArg Exps),
					[translateExpToPatIdent exp1],
					infoEq)
				in
					(goal, infoEq)
				end	
		| (Absyn.TUPLE(
				Absyn.FUNCTIONARGS(
					[Absyn.NAMEDARG(NONE, exprel as Absyn.RELATION(_), _)],
				_),
			_), 
			_) 
				=>
				let val pat = translateExpToPat exp2
						val (result, goal, info) = translateExp(exprel)
				in
					(case goal of
						SOME(Absyn.CALLgoal(id, exps, pats, info)) =>
							Absyn.CALLgoal(id, exps, [pat], info)
					|	_ => 
					(prBugLoc(infoEq); print "\n"; bug ("translateEqualsEquation: strange equation"))
					, infoEq)
				end				
		| (_, Absyn.CALL(cref, FunctionArgs as Absyn.FUNCTIONARGS(Exps, infoFArgs), infoExp2)) 
				=>
				let val lid   = cref2Ident(cref)
					val restr = lookupLIdent(lid)  
				in
					case restr of 
						SOME(Absyn.R_FUNCTION(_)) => 
						let val pat = translateExpToPat exp1
							val goal = Absyn.CALLgoal(
							lid, 
							map getExp (map translateExpFuncArg Exps),
							case pat of
							Absyn.STRUCTpat(NONE, pat_list, _) => pat_list
							| _ => [pat]
							,
							infoEq)
						in
							(goal, infoEq)
						end
					|   SOME(Absyn.R_UNIONTYPE(_)) => (* let goal *)
						let 
							val goal = Absyn.LETgoal(
							translateExpToPat exp1, 
							getExp(translateExp exp2),
							infoEq)
						in
							(goal, infoEq)
						end
					|	NONE => (* try a callgoal *)
						let 
							val goal = Absyn.CALLgoal(
							lid, 
							map getExp (map translateExpFuncArg Exps),
							[translateExpToPat exp1],
							infoEq)
						in
							(goal, infoEq)
						end
					|   _ => (prBugLoc(infoEq); print " "; bug("translateEqualsEquation: strange equation"))
				end							
		| (_, _) => 
				let 
					val goal = Absyn.LETgoal(
					translateExpToPat exp1, 
					getExp(translateExp exp2),
					infoEq)
				in
					(goal, infoEq)
				end		
			(* dummyEq("translateEqualsEquation", infoEq) *)
			(* (prBugLoc(infoEq); print " "; bug("translateEqualsEquation")) *)
	)
	
	fun buildGoalz(Absyn.EQUATIONITEM(equation, _, info), decls, localdecls) =
	(
		debug("buildGoalz\n"); 
		(case equation of 
		     (* v1 = func(functionargs) *)
			  Absyn.EQ_EQUALS(exp1, exp2, infoEq) =>
				translateEqualsEquation(exp1, exp2, infoEq)
		    | Absyn.EQ_NORETCALL(ComponentRef,  
								 FunctionArgs as Absyn.FUNCTIONARGS(Exps, infoFArgs),
								 infoEq) => 
				let val goal = 
					case ComponentRef of
					  Absyn.CREF_IDENT(ident1, _, infoId1) => 
							Absyn.CALLgoal(
								Absyn.LONGID(NONE, ident1, infoId1),
								map getExp (map translateExpFuncArg Exps) (* FIXME! XXX Exps *),
								[],
								infoEq)
					| Absyn.CREF_QUAL(ident1, _ (* arraydim *), 
							Absyn.CREF_IDENT(ident2, _, infoId2), infoId1) =>
								Absyn.CALLgoal(
									Absyn.LONGID(SOME(ident1), ident2, infoId1),
									map getExp (map translateExpFuncArg Exps) (* FIXME! XXX Exps *),
									[],
									infoEq)
					| _ => (prBugLoc(infoEq); print " "; bug("buildGoalz: strange Identifier"))
				in
					(goal, infoEq)
				end									   
				(* (prBugLoc(info); bug("buildGoalz: unexpected NORETCALL equation")) *)
		    | Absyn.EQ_FAILURE(eq, info) =>
				let val (goal, infoEq) = buildGoalz(Absyn.EQUATIONITEM(eq, NONE, info), decls, localdecls)
				in
				(
				Absyn.NOTgoal(goal, info),
				info
				)
				end
				(* (prBugLoc(info); bug("buildGoalz: unexpected EQUALITY equation")) *)
		    | Absyn.EQ_EQUALITY(Absyn.EQ_EQUALS(Absyn.CREF(cref, _), exp2, infoEq), info) => 
				(
				(
				Absyn.EQUALgoal(getShortId(cref2Ident cref), getExp(translateExp(exp2)), info),
				info
				)
				)
				(* (prBugLoc(info); bug("buildGoalz: unexpected EQUALITY equation")) *)
			| Absyn.EQ_IF(_, _, _, _, info) =>
				(prBugLoc(info); bug("buildGoalz: unexpected IF equation"))
		    | Absyn.EQ_CONNECT(_, _, info) =>
				(prBugLoc(info); bug("buildGoalz: unexpected CONNECT equation"))
		    | Absyn.EQ_FOR(_, _, info) =>
				(prBugLoc(info); bug("buildGoalz: unexpected FOR equation"))
		    | Absyn.EQ_WHEN_E(_, _, _, info) =>
				(prBugLoc(info); bug("buildGoalz: unexpected WHEN equation"))
			| _ => (prBugLoc(info); print " "; bug("buildGoalz: unexpected equation"))
		)
	)
	|   buildGoalz(_, decls, localdecls) = 
		  bug	(" unexpected Annotation ");


	fun buildGoals(x::nil, exp, decls, localdecls) = buildGoalz(x, decls, localdecls)
	|   buildGoals(x::rest, exp, decls, localdecls) =
		let val (goal1, info1) = buildGoalz(x, decls, localdecls)
			val (goal2, info2) = buildGoals(rest, exp, decls, localdecls)
		in
			(
			Absyn.ANDgoal(goal1, goal2, mkCtxInfo(info1, info2)), 
			mkCtxInfo(info1, info2)
			)
		end	
	| buildGoals([], exp, decls, localdecls) = bug(" buildGoals - empty equation list");
							
	(* axiom *)
	fun buildGoal([], exp, decls, localdecls) =
		let val (result, goal, info) = translateExp(exp)
		in 
			case goal of 
				SOME(g) => 
					(goal, 
					case result of
						Absyn.RETURN([Absyn.STRUCTexp(NONE, explst, _)], infoz)
						=> Absyn.RETURN(explst, infoz)
					| _ => result, info)
			  |	NONE => 
					(NONE, 					
						case result of
						Absyn.RETURN([Absyn.STRUCTexp(NONE, explst, _)], infoz)
						=> Absyn.RETURN(explst, infoz)
						| _ => result, info)
		end 
	(* normal rule *)
	| buildGoal(seq_eq, exp, decls, localdecls) = 
		let val (result, goal2, info2) = translateExp(exp)
			val (goal1, info1) = buildGoals(seq_eq, exp, decls, localdecls)
		in 
			case goal2 of 
				SOME(g2) => 
					(SOME(Absyn.ANDgoal(
						goal1, 
						g2,
						mkCtxInfo(info1, info2))), 
						case result of
						Absyn.RETURN([Absyn.STRUCTexp(NONE, explst, _)], infoz)
						=> Absyn.RETURN(explst, infoz)
						| _ => result,
					mkCtxInfo(info1, info2))
			  |	NONE => 
					(SOME(goal1), 					
					case result of
						Absyn.RETURN([Absyn.STRUCTexp(NONE, explst, _)], infoz)
						=> Absyn.RETURN(explst, infoz)
						| _ => result, info1)
		end
	(*
    datatype clause	= CLAUSE1 of goal option * ident * pat list * result * info ref
					| CLAUSE2 of clause * clause * info ref 	
	*)					
	
					
	fun buildClauses(ident, 
			Absyn.CASE(
				patterns,
				localdecls,
				Absyn.EQUATIONS(equations, infoEquations),
				exp,
				_,_,
				infoCase)::nil, elems) =
		let val (goal, result, info) = buildGoal(equations, exp, elems, localdecls)
		in 
			(
			Absyn.CLAUSE1(
				goal, 
				ident,
				extractPatterns(patterns),
				result, 
				info), 
			info)
		end
	| buildClauses(ident, x::rest, elems) =
		let val (c1, infoc1) = buildClauses(ident, [x],  elems)
			val (c2, infoc2) = buildClauses(ident, rest, elems)
		in
		(
		Absyn.CLAUSE2(
			c1, 
			c2, 
			mkCtxInfo(infoc1, infoc2)),
		mkCtxInfo(infoc1, infoc2)
		)
		end
	| buildClauses(_) = bug("buildClauses: CASE expected!")
		
	fun constructClause(ident,
			Absyn.ALGORITHMITEM(
				Absyn.ALG_ASSIGN(
					_,
					Absyn.MATCHexp(
					_, (* match type, ignored for now *)
					Exp, 
					ElementItems, 
					Cases,
					infoMatch),
					_),
				_,
				infoAlgItem)) =
		  let val (clause', _) = buildClauses(ident, Cases, ElementItems)
		  in 
			debug("constructClause: ");
			prIdentAndLoc ident;
			[CLAUSE(clause', infoAlgItem)]
		  end
	| constructClause(ident,
			Absyn.ALGORITHMITEM(
				Absyn.ALG_TUPLE_ASSIGN(
					_,
					Absyn.MATCHexp(
					_, (* match type, ignored for now *)
					Exp, 
					ElementItems, 
					Cases,
					infoMatch),
					_),
				_,
				infoAlgItem)) =
		  let val (clause', _) = buildClauses(ident, Cases, ElementItems)
		  in 
			debug("constructClause: ");
			prIdentAndLoc ident;
			[CLAUSE(clause', infoAlgItem)]
		  end		  
	| constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_IF(_, _, _, _, _), _, _))     = 
		(warn "constructClause - ALG_IF found. only ALG_ASSIGN/ALG_ASSIGN_TUPLE supported, ignoring..."; [])
	| constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_FOR(_, _, _), _, _))          = 
		(warn "constructClause - ALG_FOR found. only ALG_ASSIGN/ALG_ASSIGN_TUPLE supported, ignoring..."; [])
	| constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_WHILE(_, _, _), _, _))        = 
		(warn "constructClause - ALG_WHILE found. only ALG_ASSIGN/ALG_ASSIGN_TUPLE supported, ignoring..."; [])
	| constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_WHEN_A(_, _, _, _), _, _))    = 
		(warn "constructClause - ALG_WHEN_A found. only ALG_ASSIGN/ALG_ASSIGN_TUPLE supported, ignoring..."; []) 
	| constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_NORETCALL(_, _, _), _, _))    = 
		(warn "constructClause - ALG_NORETCALL found. only ALG_ASSIGN/ALG_ASSIGN_TUPLE supported, ignoring..."; [])
	| constructClause(ident, _) = 
		(warn "constructClause - only ALGORITHMITEM handled ignoring junk..."; [])
		(* bug("constructClause - only MATCH construct is handled in algorithm sections ") *)

	(*
	fun constructClauses(ident, _) = []
	*)
	
	fun constructClauses(ident, []) = []
	|	constructClauses(ident, x::rest) =
			constructClause(ident, x) @ constructClauses(ident, rest)
	

	fun getInTy([]) = []
	|	getInTy(h::rest) = 
	(
		case h of 
			INTy(x)  => x :: getInTy(rest)
		|	_ => getInTy(rest)
 	)

	fun getOutTy([]) = []
	|	getOutTy(h::rest) = 
	(
		case h of 
			OUTTy(x)  => x :: getOutTy(rest)
		|	_ => getOutTy(rest)
 	)

	(*
	fun replaceTypes(resultlist) =
	(
	datatype construct = CoB of Absyn.conbind (* constructors   *)
	                   | TyB of Absyn.typbind (* type bindings  *)
	                   | TyV of Absyn.tyvar   (* type variables *)
				       | CLAUSE of Absyn.clause * Absyn.info ref          (* match clauses  *)
				       | VAL of Absyn.ident * Absyn.exp option * Absyn.ty option * Absyn.info ref  (* value bindings *)
	                   | INTy of Absyn.ty     (* type inputs    *)
	                   | OUTTy of Absyn.ty    (* type outputs   *)
	                   | FUNCTYPE of Absyn.ident * construct list
	                   | EXTERNAL of string
	                   | REL of Absyn.ident * Absyn.ty * Absyn.clause option * Absyn.info ref		
	)
	*)

	fun constructRelationTy([]) = Absyn.RELty([], [], ref(Absyn.dummyInfo))
	|   constructRelationTy(resultlist) =
		(
		debug("constructRelationTy\n"); 
		Absyn.RELty(getInTy resultlist, getOutTy resultlist, ref(Absyn.dummyInfo)) 
		)  	
					
	(* 
	this function splits elements into:
	input, output, type, functype, replaceable types 
	*)
	fun splitElements([]) = []
	|	splitElements(elementItem::rest) = 
		(
		case elementItem of
			Absyn.ELEMENTITEM(
				Absyn.ELEMENT(_,_,_,
					ident, 
					elementSpec as 
						Absyn.CLASSDEF(_, 
							class as 
								Absyn.CLASS(
									identclass,
									partial,
									final,
									encapsulated,
									restriction,
									classdef as Absyn.PARTS(classparts, _, _),
								_),
						_), 
					info, 
					NONE),
					_) => 
			(* 
			CLASSDEF test for: 
			   - replaceable type Type_a;
			   - function Functype
			      replaceable type Xtype = list<Type_a>
			      replaceable type Ytype = list<Type_b>			       
			      input  XType y;
			      output YType_b;
			     end Functype;
			*)
			(
			case restriction of
				Absyn.R_TYPEVARIABLE(_) =>
				(
					(* collect the type variable *) 
					TyV(identclass)::splitElements(rest) 
				)
			|	Absyn.R_FUNCTION(_) =>
				(
					(* 
						collect everything in a FUNCTYPE
					*)
					FUNCTYPE(identclass, buildRelationSpecAndDec(identclass, classparts))::splitElements(rest)
			)
			|	Absyn.R_TYPE(_) =>
				(
					(* collect the type variable *) 
					TyV(identclass)::splitElements(rest) 
				)
			
			)
		|	Absyn.ELEMENTITEM(
				Absyn.ELEMENT(_,_,_,
					ident, 
					elementSpec as Absyn.CLASSDEF(_, class as 
								Absyn.CLASS(
									identclass,
									partial,
									final,
									encapsulated,
									_,
									classdef,
								_),
					_), 
					info, 
					NONE),
				_) => 
			(debug("splitElements\n");
			 case classdef of
				(* list, Option, tuple, polymorphic *)
 				Absyn.DERIVED_TYPE(path, path_list,	_, infoDerived) =>  
 				TyB((getDerivedType(identclass, path, path_list)))
 				::splitElements(rest)
 			|   Absyn.DERIVED(path, SOME([]), _, _, _, infoDerived)	=> 
 				TyB(getDerivedType(identclass, path, []))
				::splitElements(rest) 				
 				(* array / vector *)
 			|   Absyn.DERIVED(path, _, _, _, _, infoDerived)	=> 
 				TyB(getDerivedType(identclass, 
 					Absyn.PATHIDENT(Absyn.IDENT("ARRAY", ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)), 
 				 [path]))
				::splitElements(rest)
			| _ => bug("splitElements: expecting DERIVED_TYPE or DERIVED!")
 			)
		|	Absyn.ELEMENTITEM(
				Absyn.ELEMENT(_,_,_,
					ident, 
					ementSpec as Absyn.COMPONENTS(Absyn.ATTR(_, _, direction, _, _), path, components, _),
					info, 
					NONE),
					_) => 
			(*
			COMPONENTS test for:
			input  Path component;
			output Path component;  
			*)
			(
				case direction of
					Absyn.INPUT(infoInput)  => 
					(
					case components of 
						[Absyn.COMPONENTITEM(Absyn.COMPONENT(ident, _, _, _), _, _)]
						=> INTy(getType(path))::splitElements(rest) 
					| _ => (prBugLoc(infoInput); print " "; bug("splitElements: Only ONE component in the input please"))
					)
				|	Absyn.OUTPUT(infoInput) => 
					(
					case components of 
						[Absyn.COMPONENTITEM(Absyn.COMPONENT(ident, _, _, _), _, _)] 
						=> OUTTy(getType(path))::splitElements(rest)
					| _ => (prBugLoc(infoInput); print " "; bug("splitElements: Only ONE component in the output please"))
					)
				(* other components we don't care about it now! *)
				|   _ => splitElements(rest)
			)
		)
		  
	and buildRelationSpecAndDec(ident, []) = 
		(debug("buildRelationSpecAndDec: classparts: 0\n"); [])
		| buildRelationSpecAndDec(ident, classpart::rest) = 
		  (
		  	debug ("buildRelationSpecAndDec: classparts: "^L(rest)^"\n");
			case classpart of
			Absyn.PUBLIC(elementItems, _) => 
				splitElements(elementItems) @ buildRelationSpecAndDec(ident, rest)
			| Absyn.PROTECTED(elementItems, _) => 
				splitElements(elementItems) @ buildRelationSpecAndDec(ident, rest)
			| Absyn.ALGORITHMS(algorithmItems, _) => 
				constructClauses(ident, algorithmItems) @ buildRelationSpecAndDec(ident, rest)
			| Absyn.EXTERNAL(externalDecl, _, _, info) =>
				EXTERNAL("C")::buildRelationSpecAndDec(ident, rest)
			| _ => bug("buildRelationSpecAndDec - only PUBLIC/PROTECTED/ALGORITHM/EXTERNAL are handled in FUNCTION ")	
		  )

	fun sweepCLAUSE([]) = []
	|   sweepCLAUSE(clause::classparts) =
		case clause of
			  x as CLAUSE(clause, info) => [x]
			| _ => sweepCLAUSE(classparts)

	(* returns (rels, binds) *)
	fun constructRelationsAndDatatypes(ident_, []) = ([], []) 	
	|   constructRelationsAndDatatypes(ident, resultlist) = 
			let val clauseList = sweepCLAUSE(resultlist)
				val ty = constructRelationTy(resultlist)
				val (rels, binds) =	
					if (List.length clauseList >= 1)
					then
						let val CLAUSE(clause, infoClause) = List.hd clauseList
						in
						 ([REL(ident, ty, SOME(clause), infoClause)], resultlist)
						end
					else (* no clause in this relation => external or functype *)
						([REL(ident, ty, NONE, ref(Absyn.identCtxInfo ident))], resultlist)				
			in
				debug("constructRelationsAndDatatypes\n");
				(rels, binds)
			end

	fun fixSpec(REL(ident, ty, NONE, info)) = Absyn.RELspec(ident, ty, info)
	|	fixSpec(REL(ident, ty, SOME(clause), info)) = Absyn.RELspec(ident, ty, info)			
	
	fun fixDecs([]) = []
	|	fixDecs(REL(ident, ty, NONE, info)::rest) = fixDecs(rest)
	|	fixDecs(REL(ident, ty, SOME(clause), info)::rest) = 
			Absyn.RELBIND(ident, SOME(ty), clause, info)::fixDecs(rest)

	fun fixSpecBinds([]) = []
	| fixSpecBinds(TyB(x)::rest) = Absyn.TYPEspec([x], ref(Absyn.dummyInfo))::fixSpecBinds(rest)
	| fixSpecBinds(VAL(id, exp_opt, ty_opt, info)::rest) = 
		(
		case ty_opt of 
			SOME(ty) => Absyn.VALspec(id, ty, info)::fixSpecBinds(rest)
		|	NONE => fixSpecBinds(rest)
		)
	| fixSpecBinds(FUNCTYPE(reltypeid, constructs)::rest) = 
		Absyn.TYPEspec(
			[Absyn.TYPBIND([], reltypeid, constructRelationTy(constructs), ref(Absyn.identCtxInfo reltypeid))], 
			ref(Absyn.identCtxInfo reltypeid))::(fixSpecBinds(constructs) @ fixSpecBinds(rest))
	| fixSpecBinds(_::rest) = fixSpecBinds(rest)

	fun isPresentInSpecs([], _) = false
	|	isPresentInSpecs(spec::specs, x as TyB(Absyn.TYPBIND(_, id_bind, _, _))) = 
		(
		case spec of
			Absyn.TYPEspec([Absyn.TYPBIND(_, id_spec, _, _)], _) =>
			if Absyn.identName id_spec = Absyn.identName id_bind
			then (debug("isPresentInSpecs: "^(Absyn.identName id_spec)); true)
			else isPresentInSpecs(specs, x)
		|	_ => isPresentInSpecs(specs, x)
		)

	(*
	fun isPresentInDecs([], _) = false
	|	isPresentInDecs(dec::decs, x as TyB(Absyn.TYPBIND(_, id_bind, _, _))) = 
		(
		case dec of
			Absyn.TYPEdec([Absyn.TYPBIND(_, id_dec, _, _)], _) =>
			if Absyn.identName id_spec = Absyn.identName id_bind
			then (debug("isPresentInDecs: "^(Absyn.identName id_dec)); true)
			else isPresentInDecs(specs, x)
		|	_ => isPresentInDecs(specs, x)
		)
	*)
		
	fun removeFromDec([],  _) = []
	|	removeFromDec(dec::decs, x as TyB(Absyn.TYPBIND(_, id_bind, _, _))) =
		(
		case dec of
			Absyn.TYPEdec([Absyn.TYPBIND(_, id_dec, _, _)], _) =>
			if Absyn.identName id_dec = Absyn.identName id_bind
			then removeFromDec(decs, x)
			else dec::removeFromDec(decs, x)
		|	_ => dec::removeFromDec(decs, x)
		)
			
	fun getIdentFromTySpec(Absyn.TYPEspec([Absyn.TYPBIND(_, Absyn.IDENT(id, _), _, _)], _) ) = id
	|   getIdentFromTySpec(_) = bug("getIdentFromTySpec - unexpected value")
	fun getIdentFromTyDec(Absyn.TYPEdec([Absyn.TYPBIND(_, Absyn.IDENT(id, _), _, _)], _) ) = id
	|   getIdentFromTyDec(_) = bug("getIdentFromTyDec - unexpected value")
			
	fun removeDecsSpecsDuplicates([], _) = []
	|	removeDecsSpecsDuplicates(dec::decs, specs) =
		let fun is_there(spec as Absyn.TYPEspec(_)) = 
				(case dec of
					Absyn.TYPEdec(_) => 
					(case spec of
						Absyn.TYPEspec(_) => getIdentFromTyDec(dec) = getIdentFromTySpec(spec)
					|   _ => false
					)
				|	_ => false)
			|	is_there(_) = false
		in 
		  if List.exists is_there specs
		  then removeDecsSpecsDuplicates(decs, specs)
		  else dec::removeDecsSpecsDuplicates(decs, specs)
		end				
			
	fun fixDecBinds(specs, []) = []
	| fixDecBinds(specs, (z as TyB(x))::rest) = 
		if isPresentInSpecs(specs, z) 
		then fixDecBinds(specs, rest)
		else Absyn.TYPEdec([x], ref(Absyn.dummyInfo))::fixDecBinds(specs, rest)
	| fixDecBinds(specs, VAL(id, exp_opt, ty_opt, info)::rest) = 
		(
		case exp_opt of 
			SOME(exp) => Absyn.VALdec(id, exp, info)::fixDecBinds(specs, rest)
		|	NONE => fixDecBinds(specs, rest)
		)
	| fixDecBinds(specs, FUNCTYPE(reltypeid, constructs)::rest) = 
		Absyn.TYPEdec(
			[Absyn.TYPBIND([], reltypeid, constructRelationTy(constructs), ref(Absyn.identCtxInfo reltypeid))], 
			ref(Absyn.identCtxInfo reltypeid))::(fixDecBinds(specs, constructs) @ fixDecBinds(specs, rest))		
	| fixDecBinds(specs, _::rest) = fixDecBinds(specs, rest)

	
	fun augmentSpecsAndDecs(specs, decs, rels, binds, isPublic) =
	(		
		debug("augmentSpecsAndDecs - binds: "^L(binds)^"\n");
		(	
		specs @ 
		(
		if (isPublic = true) 
		then (fixSpecBinds(binds) @ (map fixSpec rels))
		else []
		),
		decs  @	
		(
		if (isPublic = false)
		then (fixDecBinds(specs, binds))
		else []
		)
		@
		[ Absyn.RELdec(fixDecs(rels), ref(Absyn.dummyInfo)) ]
		)
	)
	
    (* handle functions:
       - function ident external "C" end ident; // external functions
       - function ident 
           components;
           types;
          algorithm
           ...
         end ident;
    *)
	fun buildRelation (ident, classdef, isPublic, specs, decs) = 
		let val classparts' = case classdef of
							  Absyn.PARTS(classparts, _, _) => classparts
							  | _ => bug("buildRelation - other classparts than PARTS are not handled in the FUNCTION ")			
			val resultlist = buildRelationSpecAndDec(ident, classparts')
			val (rels, datbinds) = constructRelationsAndDatatypes(ident, resultlist)
			val (specs', decs') = augmentSpecsAndDecs(specs, decs, rels, datbinds, isPublic)
		in
			debug("buildRelation - specs: "^L(specs')^", decs: "^L(decs')^"\n");
			(specs', removeDecsSpecsDuplicates(decs', specs'))
		end

	fun buildClass   (ident, classdef, isPublic, specs, decs) = (specs, decs)
	fun buildRecord  (ident, classdef, isPublic, specs, decs) = (specs, decs) 
	fun buildPackage (ident, classdef, isPublic, specs, decs) = (specs, decs)
	                    

	fun (* type variables *)
	    sweepTypes(Absyn.CLASS(
						identclass,
						partial,
						final,
						encapsulated,
						Absyn.R_TYPEVARIABLE(_),
						classdef as Absyn.PARTS([], _, _),
					_)) = (debug ("sweepTypes\n"); TyV(identclass))        
        (* type declarations 
           type = IDENT<TYPE list>, 
           ex: type T1 = record<Typ1,Typ2>; DERIVED_TYPE
               type T2 = list<Typ3>;        DERIVED_TYPE
               type T3 = T2[:];             DERIVED array/vector here
        *)			
		| sweepTypes(Absyn.CLASS(
						identclass,
						partial,
						final,
						encapsulated,
						_,
						classdef,
					_)) = 
			(debug ("sweepTypes\n");
			 case classdef of
				(* list, option, record, polymorphic *)
 				Absyn.DERIVED_TYPE(path, path_list,	_, infoDerived) =>  
 				TyB((getDerivedType(identclass, path, path_list)))
 			|   Absyn.DERIVED(path, SOME([]), _, _, _, infoDerived)	=> 
 				TyB(getDerivedType(identclass, path, [])) 				
 				(* array / vector *)
 			|   Absyn.DERIVED(path, _, _, _, _, infoDerived)	=> 
 				TyB(getDerivedType(identclass, 
 					Absyn.PATHIDENT(Absyn.IDENT("ARRAY", ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)), 
 				 [path]))
 			|   _ => bug("sweepTypes: unexpected AST element")
 			)


	fun translateValExp(exp) = 
	let val (result, goal, info) = translateExp(exp)
	in
		case result of
			Absyn.RETURN([x], info) => x
		|	_ => 
			(prBugLoc(info); print " "; bug("translateValExp: strange expression for val var = exp"))
	end

	
	fun makeExpFromMod(Absyn.CLASSMOD(_, NONE, info)) = 
		(prBugLoc(info); print " "; bug ("makeExpFromMod: we only allow component declaration of the form: [constant] TypeName x [= expression]"))
	|	makeExpFromMod(Absyn.CLASSMOD(_, SOME(mexp), info)) =
		 translateValExp(mexp)
	
	fun walkCompList([], ty) = []
	|	walkCompList(
		Absyn.COMPONENTITEM(
			Absyn.COMPONENT(id, arr, modif, info), _, _)::components, ty) =
		let val exp = 
				case modif of
					NONE => NONE
				|	SOME(modification) => SOME(makeExpFromMod(modification))
		in 
		 VAL(id, exp, SOME(ty), info)::walkCompList(components, ty)
		end
	
	fun fixSpecsAndDecs([], isPublic, s, d) = (s, d)
	|	fixSpecsAndDecs(VAL(id, exp_opt, SOME(ty), info)::rest, isPublic, s, d) = 
		(
		case (exp_opt) of 
			SOME(exp) => 
				fixSpecsAndDecs(rest, isPublic,
					s @ (if (isPublic = true) then [Absyn.VALspec(id, ty, info)] else []), 
					d @ [Absyn.VALdec(id, exp, info)])
		|	NONE	 => 
			(prBugLoc(info); print " "; bug("fixSpecsAndDecs: Expression needed here!"))		
		)
	|	fixSpecsAndDecs(VAL(_, _, _, info)::rest, isPublic, s, d) =
		(prBugLoc(info); print " "; bug("fixSpecsAndDecs: EXPRESSION and TYPE needed here!"))

	fun createValDecls(Absyn.COMPONENTS(ElemAttr, Path, CompList, info), isPublic, specs, decs) =
		let val typ = getType(Path)
		in		
			fixSpecsAndDecs(walkCompList(CompList, typ), isPublic, specs, decs)		
		end
	|	createValDecls(_) = bug("createValDecls: Components expected")
	
	fun buildType    (class, isPublic, specs, decs) =
	let val tytyvar = sweepTypes(class)
		val (tyspecs, tydecs, tyvars) = 
				(getTypsSpec([tytyvar]), 
				 getTypsDec([tytyvar]),
				 getTyVars([tytyvar]))
	in (* we ignore tyvars here, we don't need them *)
	  (
	  specs @ (if (isPublic = true)  then tyspecs else []), 
	  decs  @ (if (isPublic = false) then tydecs  else [])
	  )
	end
	
	fun walkClasses(class::rest, isPublic, (specs, decs)) = 
		let val _ = debug("walkClasses entry\n")
			val Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info) = class
			val sd = case restriction of
						  Absyn.R_CLASS(_)  =>       ( buildClass   (ident, classdef, isPublic, specs, decs) )
						| Absyn.R_MODEL(_)  =>       ( buildClass   (ident, classdef, isPublic, specs, decs) )
						| Absyn.R_RECORD(_) =>       ( buildRecord  (ident, classdef, isPublic, specs, decs) )
						| Absyn.R_TYPE(_)   =>       ( buildType    (class, isPublic, specs, decs) )
						| Absyn.R_TYPEVARIABLE(_) => ( buildType    (class, isPublic, specs, decs) )						
						| Absyn.R_PACKAGE(_) =>	     ( buildPackage (ident, classdef, isPublic, specs, decs) )
						| Absyn.R_FUNCTION(_) =>     ( buildRelation(ident, classdef, isPublic, specs, decs) )
						| Absyn.R_UNIONTYPE(_) =>    ( buildDatatype(ident, classdef, isPublic, specs, decs) )
						| _ => bug("walkClasses - RMLModelica+ can only handle now: CLASS|MODEL|RECORD|TYPE|PACKAGE|FUNCTION|UNIONTYPE!")
		in
		  debug("walkClasses ["^L(rest)^"]\n");		
		  appendSD(sd, walkClasses(rest, isPublic, ([], []))) 
		end		
	   | walkClasses([], isPublic, sd) = (debug("walkClasses [0]\n"); sd)
		
	and sweepTopElements([], isPublic, sd) = sd
		| sweepTopElements(
			Absyn.ELEMENTITEM(Absyn.ELEMENT(_,_,_,ident, elementSpec, info, NONE),_)::rest, isPublic, (specs, decs)) = 
			(
			debug("sweepTopElements: "^(Absyn.identName ident)^" rest: "^L(rest)^"\n");
			(case  elementSpec of 
				Absyn.CLASSDEF(_, class, _) => 
					( 
					  debug("sweepTopElements -> CLASSDEF\n");
					  (*
					  appendSD(walkClasses([class], isPublic, (specs, decs)), sweepTopElements(rest, isPublic, ([], [])))
					  *)
					  sweepTopElements(rest, isPublic, walkClasses([class], isPublic, (specs, decs)))
					)
			  | c as Absyn.COMPONENTS(_) => 
					( 
					debug("sweepTopElements -> COMPONENTS\n"); 
					appendSD(createValDecls(c, isPublic, specs, decs), sweepTopElements(rest, isPublic, ([], [])))
					)
			  | Absyn.IMPORT(import, _ ,_) =>
					(case import of
					Absyn.QUAL_IMPORT(path, _) => 
						let val id = getPathLastIdent(path)
							val importFile = ((Absyn.identName id)^".mo")
							val x = (importFile, ref(Absyn.dummyInterface), ref(Absyn.dummyInfo))
						in  
						 (
						 debug("sweepTopElements -> IMPORT: "^importFile^"\n");
						 appendSD((
						 specs @ (if (isPublic = true) then [Absyn.WITHspec(x)] else []), 
						 decs @ (if (isPublic = false) then [Absyn.WITHdec(x)] else [])),
						          sweepTopElements(rest, isPublic, ([], [])))
						 )
						end
					| _ => bug("sweepTopElements - only qualified imports are handled!")
					)
			  | _ => bug("sweepTopElements - only class definitions, components and imports handled in the top part!"))
			)
		| sweepTopElements(_, _, (specs, decs)) = bug("sweepTopElements - only class definitions, components and imports handled in the top part!")


	and walkTop([Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info)], (specs, decs)) =
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
			fun sweepElems([], (s, d)) = (s, d)
			  | sweepElems(classpart::rest, (s, d)) = 
				case classpart of
				Absyn.PUBLIC(elementItems, _)      =>  
					(* appendSD(sweepTopElements(elementItems, true, (s, d)), sweepElems(rest, ([],[]))) *)
					sweepElems(rest, sweepTopElements(elementItems, true, (s, d)))
				| Absyn.PROTECTED(elementItems, _) =>  
					(* appendSD(sweepTopElements(elementItems, false, (s, d)), sweepElems(rest, ([],[]))) *)
					sweepElems(rest, sweepTopElements(elementItems, false, (s, d)))					
				| _ => bug("walkTop - only PUBLIC/PROTECTED are handled in the top part!")					
		in
		   debug("walkTop\n"); 
		   sweepElems(classparts', (specs, decs))
		end	
	  | walkTop(_, (specs, decs)) = bug("walkTop - You MUST have ONE top (package|model|class|function) that encloses all other elements!")


	fun removeSpecsDuplicates([]) = []
	|	removeSpecsDuplicates(spec::specs) =
		let fun is_there(x as Absyn.TYPEspec(_)) = 
				(case spec of
					Absyn.TYPEspec(_) => getIdentFromTySpec(x) = getIdentFromTySpec(spec)
				|	_ => false)
			|	is_there(_) = false
		in 
		  if List.exists is_there specs
		  then removeSpecsDuplicates(specs)
		  else spec::removeSpecsDuplicates(specs)
		end	

	fun removeDecsDuplicates([]) = []
	|	removeDecsDuplicates(dec::decs) =
		let fun is_there(x as Absyn.TYPEdec(_)) = 
				(case dec of
					Absyn.TYPEdec(_) => getIdentFromTyDec(x) = getIdentFromTyDec(dec)
				|	_ => false)
			|	is_there(_) = false
		in 
		  if List.exists is_there decs
		  then removeDecsDuplicates(decs)
		  else dec::removeDecsDuplicates(decs)
		end		

	fun removeSpecsDecsDuplicates([], _) = []
	|	removeSpecsDecsDuplicates(spec::specs, decs) =
		let fun is_there(dec as Absyn.TYPEdec(_)) = 
				(case dec of
					Absyn.TYPEdec(_) => 
					(case spec of
						Absyn.TYPEspec(_) => getIdentFromTyDec(dec) = getIdentFromTySpec(spec)
					|   _ => false
					)
				|	_ => false)
			|	is_there(_) = false
		in 
		  if List.exists is_there decs
		  then removeSpecsDecsDuplicates(specs, decs)
		  else spec::removeSpecsDecsDuplicates(specs, decs)
		end	

	fun fixSpecsWithTyVar([], bindlist) = []
	|	fixSpecsWithTyVar(
			Absyn.TYPEspec(
				[Absyn.TYPBIND(tyvarlist, lid, ty, infoTB)], 
				infoTS)::rest, bindlist) =
		Absyn.TYPEspec(
			[Absyn.TYPBIND(
				removeTyVarDuplicates(tyvarlist @ getTyVar(ty, bindlist)), lid, 
				setTyVar(ty, bindlist), 
				infoTB)], 
				infoTS)::fixSpecsWithTyVar(rest, bindlist)
	|	fixSpecsWithTyVar(x::rest, bindlist) = x::fixSpecsWithTyVar(rest, bindlist)

	fun fixDecsWithTyVar([], bindlist) = []
	|	fixDecsWithTyVar(
			Absyn.TYPEdec(
				[Absyn.TYPBIND(tyvarlist, lid, ty, infoTB)], 
				infoTD)::rest, bindlist) =
		Absyn.TYPEdec(
			[Absyn.TYPBIND(
				removeTyVarDuplicates(tyvarlist @ getTyVar(ty, bindlist)), lid, 
				setTyVar(ty, bindlist), infoTB)], 
				infoTD)::fixDecsWithTyVar(rest, bindlist)
	|	fixDecsWithTyVar(x::rest, bindlist) = x::fixDecsWithTyVar(rest, bindlist)


	fun fixRELSpecsWithTyVar([], bindlist) = []
	|	fixRELSpecsWithTyVar(Absyn.RELspec(ident, ty, info)::rest, bindlist) =
		Absyn.RELspec(ident, 
			if (List.length (getTyVar(ty, bindlist)) > 0) 
			then setTyVar(ty, bindlist)
			else ty, info)
		::fixRELSpecsWithTyVar(rest, bindlist)
	|	fixRELSpecsWithTyVar(x::rest, bindlist) = x::fixRELSpecsWithTyVar(rest, bindlist)


	fun fixRELBINDSDecsWithTyVar([], bindlist) = []
	|	fixRELBINDSDecsWithTyVar(Absyn.RELBIND(ident, ty_opt, clause, info)::rest, bindlist) =
		(
		case ty_opt of
			NONE => 
				Absyn.RELBIND(ident, NONE, clause, info)::
				fixRELBINDSDecsWithTyVar(rest, bindlist)
		|	SOME(ty) => 
				Absyn.RELBIND(ident, SOME(setTyVar(ty, bindlist)), clause, info)::
				fixRELBINDSDecsWithTyVar(rest, bindlist)
		)

	fun fixRELDecsWithTyVar([], bindlist) = []
	|	fixRELDecsWithTyVar(Absyn.RELdec(reldecs, info)::rest, bindlist) =
		Absyn.RELdec(fixRELBINDSDecsWithTyVar(reldecs, bindlist), info)::
		fixRELDecsWithTyVar(rest, bindlist)
	|	fixRELDecsWithTyVar(x::rest, bindlist) = x::fixRELDecsWithTyVar(rest, bindlist)


	fun fixTypeVariables(specs, decs) = 
	let val bindlist = getTyBindings(specs, decs)
	in
	(
		debug("fixTypeVariables: bindlist:"^L(bindlist));
		(
		fixRELSpecsWithTyVar(fixSpecsWithTyVar(specs, bindlist), bindlist), 
		fixRELDecsWithTyVar(fixDecsWithTyVar(decs, bindlist),    bindlist)
		)
	)
	end
	
	fun moveTypeAliasesToSpecs(specs, []) = specs
	|	moveTypeAliasesToSpecs(specs, dec::decs) = 
		let 
		in 
		case dec of (* no type variables, only lidz *)
			Absyn.TYPEdec(
				x as [Absyn.TYPBIND([], lid1, Absyn.CONSty([], lid2, _), _)], info) => 
					moveTypeAliasesToSpecs(Absyn.TYPEspec(x, info)::specs, decs)
			|   _ => moveTypeAliasesToSpecs(specs, decs)
		end

	fun buildInterfaceAndDecs(Absyn.PROGRAM(classes, within, interface, info)) =
		let val (specs, decs) = walkTop(classes, ([] (* specs *), [] (* decs *)) )
	        val Absyn.INTERFACE({modid,source,...}, infoI) = interface
	        val uniqueSpecs  = removeSpecsDuplicates(specs)
	        val uniqueDecs   = removeDecsDuplicates(decs)
	        val aliasesSpecs = moveTypeAliasesToSpecs(uniqueSpecs, uniqueDecs) 
	        val aliasesDecs  = removeDecsSpecsDuplicates(uniqueDecs, aliasesSpecs)
	        val (specs', decs') = 
				fixTypeVariables(removeSpecsDecsDuplicates(aliasesSpecs, aliasesDecs),
								 aliasesDecs) 
		in 
		  debug ("buildInterfaceAndDecs - specs: "^L(specs)^
		        ", decs: "^L(decs)^"\n");		  		
		  (Absyn.INTERFACE({
			modid=modid, 
			specs=specs', 
			source=source}, infoI), decs') 
		end
		
	fun buildInfo(Absyn.PROGRAM(_, _, _, info)) = info
	
	val (interface, decs) = buildInterfaceAndDecs(program) 
	val Absyn.INTERFACE({modid,source,...}, infoI) = interface
	in 
		debug("mo2rmlmodule:"^(Absyn.identName modid)^"\n");		
		Absyn.MODULE(interface, decs, buildInfo(program))
		(* Absyn.MODULE(Absyn.dummyInterface, [], ref(Absyn.dummyInfo)) *)
	end
		
    fun mo2rmlinterface(modelica) = 
	   let val Absyn.MODULE(Absyn.INTERFACE({modid,specs,source}, infoI), decs, infoM) = 
			   mo2rmlmodule(modelica)
	       val interface = Absyn.INTERFACE({modid=modid,specs=specs,
					       source=source}, 
					       infoI)
	   in
		 debug("mo2rmlinterface:"^(Absyn.identName modid)^"\n");	   
	     Absyn.MODULE(interface, decs, infoM)
	   end
    
    fun parseModule    (file) = Absyn.MODULE(Absyn.dummyInterface, [], ref(Absyn.dummyInfo))
    fun parseInterface (file) = Absyn.MODULE(Absyn.dummyInterface, [], ref(Absyn.dummyInfo))

    fun mo2imports(modelica) = MOToMO.mo2imports(modelica)
	
	fun mo2recordconstructors(modelica)  = MOToMO.mo2recordconstructors(modelica)
	
	         
  end (* functor InstrumentFn *)
