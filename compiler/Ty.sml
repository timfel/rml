(* static/ty.sml *)

structure Ty : TY =
  struct

    datatype tynameeq
      = NEVER
      | MAYBE
      | ALWAYS
    datatype tyname
      = TYNAME of {modid: string,
		   tycon: string,
		   eq: tynameeq ref}	(* patchable *)
    datatype ty
      = VAR of tyvar
      | TUPLE of ty list
      | REL of ty list * ty list
      | CONS of ty list * tyname
    and tyvar
      = RIGID of string
      | FREE of {tag: int ref,		(* patchable *)
		 eq: bool,
		 subst: ty option ref}	(* patchable *)

    (* tyvar utils *)

    fun makeTyvar eq = FREE{tag = ref ~1, eq = eq, subst = ref NONE}
    fun newTyvar() = makeTyvar false

    (* dereferencing instantiated type variables w/o path compression *)

    fun deref(VAR(FREE{subst=ref(SOME ty),...})) = deref ty
      | deref ty = ty

    (* printing types *)

    fun say s = TextIO.output(TextIO.stdErr, s)
    fun say1 ch = TextIO.output1(TextIO.stdErr, ch)

    val alphaCounter = ref ~1

    fun radix26 i =
      (if i > 25 then radix26(i div 26 - 1) else ();
       say1(Char.chr(97 + i mod 26)))

    fun printTyname(TYNAME{modid,tycon,...}) =
      (if modid = "RML" then () else (say modid; say1 #".");
       say tycon)

    fun printSeq(lst, printfn, lparen, rparen, sep) =
      let fun loop([]) = say rparen
	    | loop(x::xs) = (say1 sep; printfn x; loop xs)
      in
	case lst
	  of []		=> (say lparen; say rparen)
	   | [x]	=> printfn x
	   | (x::xs)	=> (say lparen; printfn x; loop xs)
      end

    fun printTyvar(RIGID s) = (say1 #"'"; say s)
      | printTyvar(FREE{tag=r, ...}) =
	  (say1 #"'";
	   if !r < 0 then (alphaCounter := !alphaCounter + 1; r := !alphaCounter)
	   else ();
	   radix26(!r))

    fun printTypeNoParens ty = printTypeDispatch(ty, false)

    and printTyseq tyseq = printSeq(tyseq, printTypeNoParens, "(", ")", #",")

    and printAtomicType ty = printTypeDispatch(ty, true)

    and printTypeDispatch(ty, needParens) =
      case deref ty
	of VAR tyvar		=> printTyvar tyvar
	 | TUPLE tys		=>
	    (if needParens then say1 #"(" else ();
	     printSeq(tys, printAtomicType, "", "", #"*");
	     if needParens then say1 #")" else ())
	 | REL(domtys,codtys)	=>
	    (if needParens then say1 #"(" else ();
	     printTyseq domtys;
	     say " => ";
	     printTyseq codtys;
	     if needParens then say1 #")" else ())
	 | CONS(tys,t)	=>
	    (case tys
	       of []	=> ()
		| [ty]	=> (printAtomicType ty; say1 #" ")
		| _	=> (printTyseq tys; say1 #" ");
	     printTyname t)

    fun printType ty = (alphaCounter := ~1; printTypeNoParens ty)
    val printType' = printTypeNoParens

    (* adrpo 2004-12-08 - collecting types *)
    fun sayOs (os,s) = TextIO.output(os, s)
    fun say1Os (os,ch) = TextIO.output1(os, ch)

    fun radix26Os(os, i) =
      (if i > 25 then radix26Os(os, i div 26 - 1) else ();
       say1Os(os,Char.chr(97 + i mod 26)))

    fun printTynameOs(os, currentModid, TYNAME{modid,tycon,...}) =
      (
       if (modid = "RML" orelse modid = currentModid) 
       then () 
       else (sayOs (os, modid); say1Os(os, #".")
      );
      sayOs(os, tycon))

    fun printSeqOs(os, modid, lst, printfn, lparen, rparen, sep) =
      let   fun parensOnREL(x) =
			(
			    case deref x of 
					 REL (_,_) => (sayOs(os,lparen); printfn(os,modid,x); sayOs(os,rparen))
					 | _ => printfn(os,modid,x)
			)
			fun loop([]) = sayOs(os, rparen)
			| loop(x::xs) = (say1Os(os, sep); parensOnREL(x); loop xs)
      in
	case lst
	  of []		=> (sayOs(os,lparen); sayOs(os,rparen))
	   | [x]	=>  parensOnREL(x)
	   | (x::xs)	=> (sayOs(os, lparen); parensOnREL(x); loop xs)
      end

    fun printTyvarOs(os,RIGID s) = (say1Os(os,#"'"); sayOs(os, s))
      | printTyvarOs(os,FREE{tag=r, ...}) =
	  (say1Os(os, #"'");
	   if !r < 0 then (alphaCounter := !alphaCounter + 1; r := !alphaCounter)
	   else ();
	   radix26Os(os,!r))

    fun printTypeNoParensOs(os, modid, ty) = printTypeDispatchOs(os, modid, ty, false)

    and printTyseqOs(os, modid, tyseq) = printSeqOs(os, modid, tyseq, printTypeNoParensOs, "(", ")", #",")

    and printAtomicTypeOs(os, modid, ty) = printTypeDispatchOs(os, modid, ty, true)

    and printTypeDispatchOs(os, modid, ty, needParens) =
      case deref ty
		of VAR tyvar		=> printTyvarOs(os, tyvar)
		| TUPLE tys		=>
			(if needParens then say1Os(os, #"(") else ();
			printSeqOs(os, modid, tys, printAtomicTypeOs, "", "", #"*");
			if needParens then say1Os(os, #")") else ())
		| REL(domtys,codtys)	=>
			(
			if needParens then say1Os(os,#"(") else ();
			printTyseqOs(os, modid, domtys);
			sayOs(os, " => "); 
			printTyseqOs(os, modid, codtys); 
			if needParens then say1Os(os, #")") else ())
		| CONS(tys,t)	=>
			(case tys
				of []	=> ()
				| [ty]	=> (printAtomicTypeOs(os, modid, ty); say1Os(os, #" "))
				| _	=> (printTyseqOs(os, modid, tys); say1Os(os, #" "));
				printTynameOs(os, modid, t))

    fun printTypeOs(SOME(os), modid, ty) = (alphaCounter := ~1; printTypeNoParensOs(os, modid, ty))
      | printTypeOs(NONE, _, ty) = ()


    (* equality *)

    fun admitsEq(ty, ignoreTyvars) =
      let fun check ty =
	    case deref ty
	      of VAR tyvar =>
		  (ignoreTyvars orelse
		   case tyvar
		     of RIGID name => String.sub(name,0) = #"'"	(* EtyVar *)
		      | FREE{eq,subst,...} =>
			 (if eq then () else subst := SOME(VAR(makeTyvar true));
			  true))
	       | TUPLE tys => List.all check tys
	       | REL(_,_) => false
	       | CONS(tys,TYNAME{eq,...}) =>
		  case !eq
		    of ALWAYS => true
		     | MAYBE => List.all check tys
		     | NEVER => false
      in
		check ty
      end

    (* error reporting *)

    datatype tyerr_explanation
      = TY_ERROR of ty * string
      | TY_INST of tyvar * ty * string
      | TY_DIFFER of ty * ty * string
    exception TypeError of tyerr_explanation

    fun tyErr(ty, why) =
      raise TypeError(TY_ERROR(ty, why))

    fun tyErrInst(tyvar, ty, why) =
      raise TypeError(TY_INST(tyvar, ty, why))

    fun tyErrDiffer(ty1, ty2, why) = 
      raise TypeError(TY_DIFFER(ty1, ty2, why))

    (* equality-check *)

    fun mustAdmitEq ty =
      if admitsEq(ty, false) then ()
      else tyErr(ty, "does not admit equality")

    (* occurs-check *)

    fun mustNotOccurIn(tyvar1, ty2) =
      let fun check ty =
	    case deref ty
	      of VAR tyvar		=>
		  if tyvar1 <> tyvar then ()
		  else tyErrInst(tyvar1, ty2,
				 "a circular type would result (occur-check)")
	       | TUPLE tys		=> List.app check tys
	       | REL(domtys,codtys)	=>
		  (List.app check domtys; List.app check codtys)
	       | CONS(tys,_)		=> List.app check tys
      in
	check ty2
      end

    (* unification *)

    fun bindTyvar(tyvar1 as RIGID _, ty2) =
	  tyErrInst(tyvar1, ty2, "the type variable is explicit")
      | bindTyvar(tyvar1 as FREE{eq,subst,...}, ty2) =
	  (mustNotOccurIn(tyvar1, ty2);
	   if eq andalso not(admitsEq(ty2, false)) then
	     tyErrInst(tyvar1, ty2, "the type does not admit equality")
	   else ();
	   subst := SOME ty2)

    fun unifyTyvars(RIGID _, ty1, tyvar2, _) = bindTyvar(tyvar2, ty1)
      | unifyTyvars(tyvar1, _, RIGID _, ty2) = bindTyvar(tyvar1, ty2)
      | unifyTyvars(FREE{eq=eq1,subst=subst1,...}, ty1,
		    FREE{eq=eq2,subst=subst2,...}, ty2) =
	  if eq1 then subst2 := SOME ty1 else subst1 := SOME ty2

    fun unify(ty1, ty2) = unify2(deref ty1, deref ty2)

    and unify2(ty1 as VAR(tyvar1), ty2 as VAR(tyvar2)) =
	  if tyvar1 = tyvar2 then () else unifyTyvars(tyvar1, ty1, tyvar2, ty2)
      | unify2(VAR(tyvar1), ty2) = bindTyvar(tyvar1, ty2)
      | unify2(ty1, VAR(tyvar2)) = bindTyvar(tyvar2, ty1)
      | unify2(ty1 as TUPLE(tys1), ty2 as TUPLE(tys2)) =
	  unify3(tys1, tys2, ty1, ty2, "tuple components")
      | unify2(ty1 as REL(domtys1,codtys1), ty2 as REL(domtys2,codtys2)) =
	  (unify3(domtys1, domtys2, ty1, ty2, "relation arguments");
	   unify3(codtys1, codtys2, ty1, ty2, "relation results"))
      | unify2(ty1 as CONS(tys1,t1), ty2 as CONS(tys2,t2)) =
	  let fun tynameEq(t1, t2) =
		(* Note that the eq attribute must be ignored, since the tyname
		 * from an abstract type spec may have a different eq attribute
		 * than the tyname from the implementation datbind.
		 *)
		let val TYNAME{modid=modid1,tycon=tycon1,...} = t1
		    val TYNAME{modid=modid2,tycon=tycon2,...} = t2
		in
		  (modid1 = modid2) andalso (tycon1 = tycon2)
		end
	  in
	    if tynameEq(t1, t2) then unify3(tys1, tys2, ty1, ty2, "type arguments")
	    else tyErrDiffer(ty1, ty2, "type names")
	  end
      | unify2(ty1, ty2) = tyErrDiffer(ty1, ty2, "kinds")

    and unify3(tys1, tys2, ty1, ty2, kind) =
      let fun loop([], []) = ()
	    | loop(ty1::tys1, ty2::tys2) = (unify(ty1, ty2); loop(tys1, tys2))
	    | loop(_, _) = tyErrDiffer(ty1, ty2, "number of "^kind)
      in
		loop(tys1, tys2)
      end

  end (* structure Ty *)
