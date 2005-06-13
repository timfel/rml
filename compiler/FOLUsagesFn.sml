(* fol/fol-usages.sml *)

functor FOLUsagesFn(structure Util : UTIL
		    structure FOL : FOL
		      ) : FOL_USAGES =
  struct

    structure FOL = FOL

    fun zapVar var =
      let val FOL.VAR{uses,...} = FOL.deref var
      in
	uses := 0
      end

    fun incVar var =
      let val FOL.VAR{uses,...} = FOL.deref var
      in
	uses := !uses + 1
      end

    fun doPat'(FOL.STRUCTpat(_, pats)) = List.app doPat pats
      | doPat'(_) = ()
    and doPat(FOL.PAT(var, pat)) = (zapVar var; doPat' pat)

    fun doVarRef(FOL.BVAR var) = incVar var
      | doVarRef(_) = ()

    fun doExp(FOL.VARexp vref) = doVarRef vref
      | doExp(FOL.STRUCTexp(_, exps)) = List.app doExp exps
      | doExp(_) = ()

    fun doMRule(var, pat) = (incVar var; doPat pat)

    fun doConj(FOL.CALL(vref, exps, vars)) =
	  (doVarRef vref; List.app doExp exps; List.app zapVar vars)
      | doConj(FOL.MATCH mrules) = List.app doMRule mrules
      | doConj(FOL.EQUAL(var, exp)) = (doExp exp; incVar var)
      | doConj(FOL.BIND(var, exp)) = (doExp exp; zapVar var)
      | doConj(FOL.NOT conj) = doConj conj
      | doConj(FOL.AND(c1, c2)) = (doConj c1; doConj c2)

    fun doDisj(FOL.RETURN exps) = List.app doExp exps
      | doDisj(FOL.FAIL) = ()
      | doDisj(FOL.ORELSE(d1, d2)) = (doDisj d1; doDisj d2)
      | doDisj(FOL.ANDTHEN(c1, d2)) = (doConj c1; doDisj d2)
      | doDisj(FOL.COND(c1, d2, d3)) = (doConj c1; doDisj d2; doDisj d3)
      | doDisj(FOL.CASE(vars, cases)) =
	  (List.app incVar vars; List.app doCase cases)

    and doCase(pats, disj) = (List.app doPat pats; doDisj disj)

    fun doRel(FOL.REL(_,vars,disj)) = (List.app zapVar vars; doDisj disj)

    fun doDec(FOL.RELdec rels) = List.app doRel rels
      | doDec(_) = ()

    fun update(FOL.MODULE(_, decs)) = List.app doDec decs

  end (* functor FOLUsagesFn *)
