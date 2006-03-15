(* fol/fol-optim.sml *)

functor FOLOptimFn(structure Util : UTIL
		   structure FOLPrint : FOL_PRINT
		   structure FOLUnify : FOL_UNIFY
		   sharing type FOLPrint.FOL.module = FOLUnify.FOL.module
		     ) : FOL_OPTIM =
  struct

    structure FOL = FOLUnify.FOL

    fun bug s = Util.bug("FOLOptim."^s)

    (*
     * Inference rules for normalizing negated conjunctions.
     * Since a negation never produces any visible bindings,
     * we remove useless binding operations from the tail.
     *
     * relation mk_not =
     *	axiom	mk_not(SOME C) => NOT C
     *	axiom	mk_not(NONE) => NOT(MATCH[])
     * end
     *
     * relation norm_not_conj =
     *	axiom	norm_not_conj(BIND(_,_)) => NONE
     *	axiom	norm_not_conj(MATCH[..(v,(v',WILD))..]) => NONE
     *
     *	rule	norm_not_conj C2 => SOME C2'
     *		----------------
     *		norm_not_conj(AND(C1,C2)) => SOME(AND(C1,C2'))
     *
     *	rule	norm_not_conj C2 => NONE &
     *		norm_not_conj C1 => C1'opt
     *		----------------
     *		norm_not_conj(AND(C1,C2)) => C1'opt
     *
     *	rule	norm_not_conj C => C'opt &
     *		mk_not C'opt => C''
     *		----------------
     *		norm_not_conj(NOT C) => SOME C''
     * default
     *  axiom	norm_not_conj C => SOME C
     * end
     *)

    fun mkNot(SOME conj) = FOL.NOT conj
      | mkNot(NONE) = FOL.NOT(FOL.MATCH[])

    fun isWild(_, FOL.PAT(_, FOL.WILDpat)) = true
      | isWild(_, FOL.PAT(_, _)) = false

    fun normNotConj(FOL.BIND(_,_)) = NONE
      | normNotConj(conj as FOL.CALL(_,_,_)) = SOME conj
      | normNotConj(conj as FOL.EQUAL(_,_)) = SOME conj
      | normNotConj(conj as FOL.MATCH mrules) =
	  if List.all isWild mrules then NONE else SOME conj
      | normNotConj(FOL.AND(conj1,conj2)) =
	  (case normNotConj conj2
	     of SOME conj2' => SOME(FOL.AND(conj1,conj2'))
	      | NONE => normNotConj conj1)
      | normNotConj(FOL.NOT conj) = SOME(mkNot(normNotConj conj))

    (*
     * Inference rules for normalizing conjunctions.
     *
     * relation mk_and =
     *  rule	mk_and(C2,C3) => C4
     *		----------------
     *		mk_and(AND(C1,C2),C3) => AND(C1,C4)
     * default
     *	axiom	mk_and(C1,C2) => AND(C1,C2)
     * end
     *
     * relation norm_conj =
     *	rule	norm_conj C1 => C1' &
     *		norm_conj C2 => C2' &
     *		mk_and(C1,C2) => C3
     *		----------------
     *		norm_conj(AND(C1,C2)) => C3
     *
     *	rule	norm_conj C => C' &
     *		norm_not_conj C' => C''opt &
     *		mk_not C''opt => C''
     *		----------------
     *		norm_conj(NOT C) => C''
     * default
     *	axiom	norm_conj C => C
     * end
     *)

    fun mkAnd(c1, c2) =
      case c1
	of FOL.AND(c1a,c1b) => FOL.AND(c1a, mkAnd(c1b, c2))
	 | _ => FOL.AND(c1, c2)

    fun normConj(FOL.AND(c1,c2)) = mkAnd(normConj c1, normConj c2)
      | normConj(FOL.NOT conj) = mkNot(normNotConj(normConj conj))
      | normConj conj = conj

    (*
     * Normalizing rules for disjunctive forms:
     * ANDTHEN(MATCH([(v1,p1),...,(vn,pn)]), d)
     * ==> CASE([v1,...,vn], [([p1,...,pn], d)])
     * ANDTHEN(AND(c1a, c1b), d2)
     * ==> ANDTHEN(c1a, ANDTHEN(c1b, d2))
     * CASE([], [([],d1),...,([],dn)])
     * ==> ORELSE(d1, ORELSE(..., ORELSE(..., dn)...))
     * CASE(vars, [...,(pats,d1),...,(pats',d2),...])	if pats=pats'
     * ==> CASE(vars, [...,(pats,ORELSE(d1,d2)),...,...])
     * ORELSE(ORELSE(d1a,d1b), d2)
     * ==> ORELSE(d1a, ORELSE(d1b,d2))
     * ORELSE(ANDTHEN(c1a,d1b), ANDTHEN(c2a,d2b))	if c1a=c2a
     * ==> ANDTHEN(c1a, ORELSE(d1b,d2b))
     * ORELSE(ANDTHEN(c1a,d1b), ANDTHEN(NOT(c2a'),d2b))	if c1a=c2a'
     * ==> COND(c1a, d1b, d2b)
     * ORELSE(ANDTHEN(NOT(c1a'),d1b), ANDTHEN(c2a,d2b))	if c1a'=c2a
     * ==> COND(c1a', d2b, d1b)
     * ORELSE(CASE(vars1,cases1), CASE(vars2,cases2))	if vars1=vars2
     * ==> CASE(vars1, cases1@cases2)
     *)

    (*
     * N.B.: Rule (4) of the original FOL-TRS is too optimistic.
     * It is necessary to carefully `bubble' a rule up until EITHER
     * an equivalent match is found, in which case they are joined,
     * OR a similar (either less or more general) match is found,
     * in which case the bubble MUST stop.
     *)

    (* similarPat(p1,p2) is true if p1 subsumes p2 or p2 subsumes p1 *)
    fun similarPat(FOL.PAT(_,p1), FOL.PAT(_,p2)) = similarPat'(p1,p2)
    and similarPat'(FOL.WILDpat, _) = true
      | similarPat'(_, FOL.WILDpat) = true
      | similarPat'(FOL.LITpat l1, FOL.LITpat l2) = FOL.litEqual(l1, l2)
      | similarPat'(FOL.CONpat c1, FOL.CONpat c2) = c1 = c2
      | similarPat'(FOL.STRUCTpat(c1,ps1), FOL.STRUCTpat(c2,ps2)) =
	  c1 = c2 andalso similarPats(ps1, ps2)
      | similarPat'(_, _) = false
    and similarPats([], []) = true
      | similarPats(p1::ps1, p2::ps2) =
	  similarPat(p1,p2) andalso similarPats(ps1,ps2)
      | similarPats(_, _) = false

    fun mkCond(c1, d2, d3) = FOL.COND(c1, d2, d3)
    
    (* Adrian Pop, 
       + adrpo@ida.liu.se, 
       + http://www.ida.liu.se/~adrpo,
       + date: 2005-01-19 
       + remove the instrumented code when unifying
         things like FOL.NOT(goals)=goals
       + this helps turning things like below into a conditional:
         rule x ...
              ------
              z(pat)
         rule not(x) ...
              ----------
              z(pat)      
     *)
     fun isDebugCall( FOL.CALL( vref as FOL.GVAR( FOL.LONGID(SOME("RML"), debug)), _, _ ) ) =
		   (String.isPrefix "debug" debug)
       | isDebugCall( _ ) = false
     
     fun removeDebugCalls(z as FOL.AND(c1 as FOL.CALL(_,_,_),c2)) = 
		(if isDebugCall(c1) 
		 then removeDebugCalls(c2) 
		 else case c2 
		      of FOL.CALL(_,_,_) => 
		         if isDebugCall(c2)
				 then removeDebugCalls(c1) 
				 else FOL.AND(removeDebugCalls(c1), removeDebugCalls(c2))
			  | _ =>  FOL.AND(removeDebugCalls(c1), removeDebugCalls(c2)))
        | removeDebugCalls(rest) = rest 

    fun mkAndThen(c1, d2) =
      case c1
	of FOL.MATCH(mrules) =>
	    mkCase(map #1 mrules, [(map #2 mrules, d2)])
	 | FOL.AND(c1a,c1b) => mkAndThen(c1a, mkAndThen(c1b, d2))
	 | _ => FOL.ANDTHEN(c1, d2)

    and mkCase(_, []) = bug "mkCase(_,[])"
      | mkCase([], (_,d1)::cases) =
	  let fun join(d1, []) = d1
		| join(d1, (_,d2)::cases) = mkOrElse(d1, join(d2, cases))
	  in
	    join(d1, cases)
	  end
      | mkCase(vars, cases) =
	  let fun bubble(casej, []) = [casej]
		| bubble(casej, abovej as (casei :: abovei)) =
		    let val (patsj,dj) = casej
			and (patsi,di) = casei
		    in
		      if FOLUnify.unifyPatLists(patsi, patsj) then
			(patsi, mkOrElse(di,dj)) :: abovei
		      else if similarPats(patsi, patsj) then casej :: abovej
		      else casei :: bubble(casej, abovei)
		    end
	  in
	    FOL.CASE(vars, List.rev(List.foldl bubble [] cases))
	  end

    and mkOrElse(d1 as FOL.ANDTHEN(c1a,d1b as FOL.ANDTHEN(c1a',d1b')), d2 as FOL.ANDTHEN(c2a as FOL.NOT(c2a'),d2b)) =
        if (isDebugCall(c1a) andalso FOLUnify.unifyConjs(c1a', c2a'))
        then mkAndThen(c1a, mkCond(c1a', d1b', d2b))
        else FOL.ORELSE(d1, d2)
     | mkOrElse(d1 as FOL.ANDTHEN(c2a as FOL.NOT(c2a'),d2b), d2 as FOL.ANDTHEN(c1a,d1b as FOL.ANDTHEN(c1a',d1b'))) =
        if (isDebugCall(c1a) andalso FOLUnify.unifyConjs(c1a', c2a'))
        then mkAndThen(c1a, mkCond(c1a', d1b', d2b))
        else FOL.ORELSE(d1, d2)       
     | mkOrElse(d1,d2) = 
      case d1
		of FOL.ORELSE(d1a,d1b) => mkOrElse(d1a, mkOrElse(d1b, d2))
		| FOL.ANDTHEN(c1a,d1b) =>
	    (case d2
	       of FOL.ANDTHEN(c2a,d2b) =>
		    (if FOLUnify.unifyConjs(c1a, c2a)
		     then
		       mkAndThen(c1a, mkOrElse(d1b, d2b))
		     else
		       case c1a
				of FOL.NOT(c1a') =>
			    if FOLUnify.unifyConjs(c1a', c2a) 
			    then
			      mkCond(c1a', d2b, d1b)
			    else FOL.ORELSE(d1, d2)
			  | _ =>
			     case c2a
			       of FOL.NOT(c2a') =>
				   if FOLUnify.unifyConjs(c2a', c1a) 
				   then
				     mkCond(c1a, d1b, d2b)
				   else FOL.ORELSE(d1, d2)
				| _ => FOL.ORELSE(d1, d2))
		| _ => FOL.ORELSE(d1, d2))
	 | FOL.CASE(vars1,cases1) =>
	    (case d2
	       of FOL.CASE(vars2,cases2) =>
		    if FOLUnify.equalVarLists(vars1,vars2) then
		      mkCase(vars1, cases1@cases2)
		    else FOL.ORELSE(d1, d2)
		| _ => FOL.ORELSE(d1, d2))
	 | _ => FOL.ORELSE(d1, d2)

    fun normDisj(d as FOL.RETURN(_)) = d
      | normDisj(d as FOL.FAIL) = d
      | normDisj(FOL.ORELSE(d1,d2)) = mkOrElse(normDisj d1, normDisj d2)
      | normDisj(FOL.ANDTHEN(c1,d2)) = mkAndThen(normConj c1, normDisj d2)
      | normDisj(FOL.COND(c1,d2,d3)) = mkCond(normConj c1, normDisj d2, normDisj d3)
      | normDisj(FOL.CASE(vars,cases)) = mkCase(vars, map normCase cases)

    and normCase(pats, d) = (pats, normDisj d)

    fun normRel(FOL.REL(name, formals, disj)) =
      FOL.REL(name, formals, normDisj disj)

    fun normDec(FOL.RELdec rels) = FOL.RELdec(map normRel rels)
      | normDec dec = dec

    fun normModule(FOL.MODULE(exports, declarations)) =
      FOL.MODULE(exports, map normDec declarations)
 
 (* adrpo 2004-11-27 print ONLY the result after FOL optimization 
		  val _ = FOLPrint.printModule(os, m)
 *)
    fun optimize(SOME os, m) =
	  let val m = normModule m
	      val _ = FOLPrint.printModule(os, m)
	  in
	    m
	  end
      | optimize(NONE, m) = normModule m

  end (* functor FOLOptimFn *)
