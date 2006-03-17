(* absyntofol/absyntofol.sml *)

functor AbsynToFOLFn(structure StrDict : STR_DICT
		     structure Util : UTIL
		     structure Absyn : ABSYN
		     structure FOL : FOL
		       ) : ABSYNTOFOL =
  struct

    structure Absyn = Absyn
    structure FOL = FOL

    fun newvars i =
      let fun loop(i, vars) =
	    if i < 1 then vars else loop(i-1, FOL.newvar() :: vars)
      in
		loop(i, [])
      end

    fun cnvId id = Absyn.identName id
    fun cnvModidOpt(NONE) = NONE
      | cnvModidOpt(SOME modid) = SOME(cnvId modid)
    fun cnvLongid(Absyn.LONGID(modidOpt, id, _)) =
      let val modidOpt = cnvModidOpt modidOpt
	  val id = cnvId id
      in
		FOL.LONGID(modidOpt, id)
      end
    fun cnvLongidOpt(NONE) = NONE
      | cnvLongidOpt(SOME longid) = SOME(cnvLongid longid)

    fun cnvLit(Absyn.CCONlit(c, _)) = FOL.ICON(Char.ord c)
      | cnvLit(Absyn.ICONlit(i, _)) = FOL.ICON i
      | cnvLit(Absyn.RCONlit(r, _)) = FOL.RCON r
      | cnvLit(Absyn.SCONlit(s, _)) = FOL.SCON s

	(* adrpo --
    fun prVar var =
      let val FOL.VAR{name,uses,...} = FOL.deref var
      in
		print name
      end
      
    fun prLongId(FOL.LONGID(id_opt, id)) =
      ((case id_opt of SOME id' => (print (id'^".")) | NONE => ());
       print (id))
      
    fun printIdVar(id, var) = (print (cnvId id); print "-"; prVar(var); print "\n")
	
	fun printIdLongId(id, longid) = (print (cnvId id); print "-"; prLongId(cnvLongid longid); print "\n")
	adrpo -- end *)	
	
    fun makeVRef(longid as Absyn.LONGID(modidOpt, id, _), VE) =
      case modidOpt
		of SOME _ => FOL.GVAR(cnvLongid longid)
		| NONE =>
			case StrDict.find(VE, cnvId id)
			of SOME var =>  ( (* printIdVar(id, var); *) FOL.BVAR var)
			| NONE => ( (* printIdLongId(id, longid); *) FOL.GVAR(cnvLongid longid))

    fun cnvExp(Absyn.LITexp(lit, _), _) = FOL.LITexp(cnvLit lit)
      | cnvExp(Absyn.CONexp(longcon, _), _) = FOL.CONexp(cnvLongid longcon)
      | cnvExp(Absyn.VARexp(longvar, _), VE) = FOL.VARexp(makeVRef(longvar, VE))
      | cnvExp(Absyn.STRUCTexp(longconOpt, exps, _), VE) =
	  FOL.STRUCTexp(cnvLongidOpt longconOpt, cnvExps(exps, VE))
      | cnvExp(Absyn.IDENTexp(_, r, _), VE) = cnvExp(!r, VE)

    and cnvExps(exps, VE) = map (fn exp => cnvExp(exp, VE)) exps

    fun cnvPat(pat, VE) =
      let val var = FOL.newvar()
	  val (pat', VE') = cnvPat'(pat, var, VE)
      in
		(FOL.PAT(var, pat'), VE')
      end

    and cnvPat'(Absyn.WILDpat _, _, VE) = (FOL.WILDpat, VE)
      | cnvPat'(Absyn.LITpat(lit, _), _, VE) = (FOL.LITpat(cnvLit lit), VE)
      | cnvPat'(Absyn.CONpat(longcon, _), _, VE) = (FOL.CONpat(cnvLongid longcon), VE)
      | cnvPat'(Absyn.STRUCTpat(longconOpt, pats, ref(pats_positional), _), _, VE) =
	  let val (pats', VE') = (* fixed the named arguments to positional *)
			if List.length pats_positional = 0 
			then cnvPats(pats, VE) 
			else cnvPats(pats_positional, VE)
	      val longconOpt = cnvLongidOpt longconOpt
	  in
	    (FOL.STRUCTpat(longconOpt, pats'), VE')
	  end
      | cnvPat'(Absyn.BINDpat(id, pat, _), var, VE) =
		cnvPat'(pat, var, StrDict.insert(VE, cnvId id, var))
      | cnvPat'(Absyn.IDENTpat(_, r, _), var, VE) = cnvPat'(!r, var, VE)
      | cnvPat'(Absyn.NAMEDpat(id, pat, _), var, VE) = cnvPat'(pat, var, VE)

    and cnvPats(pats, VE) =
      let fun loop([], pats', VE) = (List.rev pats', VE)
	    | loop(pat::pats, pats', VE) =
		let val (pat', VE) = cnvPat(pat, VE)
		in
		  loop(pats, pat'::pats', VE)
		end
      in
		loop(pats, [], VE)
      end

    fun cnvGoal(Absyn.CALLgoal(longvar, exps, pats, ref(pats_positional), _), VE) =
	  let val vref = makeVRef(longvar, VE)
	      val exps' = cnvExps(exps, VE)
	      val (pats', VE) = (* fixed the named arguments to positional *)
			if List.length pats_positional = 0 
			then cnvPats(pats, VE)
			else cnvPats(pats_positional, VE)
	      and vars = newvars(
				if List.length pats_positional = 0 
				then List.length pats 
				else List.length pats_positional)
	  in
	    (FOL.AND(FOL.CALL(vref, exps', vars),
		     FOL.MATCH(ListPair.zip(vars, pats'))),
	     VE)
	  end
      | cnvGoal(Absyn.EQUALgoal(id, exp, _), VE) =
	  let val exp = cnvExp(exp, VE)
	      val id = cnvId id
	  in
	    case StrDict.find(VE, id)	(*XXX: implicit let crap*)
	      of SOME var => (FOL.EQUAL(var, exp), VE)
	       | NONE =>
		  let val var = FOL.newvar()
		  in
		    (FOL.BIND(var, exp), StrDict.insert(VE, id, var))
		  end
	  end
      | cnvGoal(Absyn.LETgoal(pat, exp, _, _), VE) =
	  let val exp' = cnvExp(exp, VE)
	      val (pat', VE) = cnvPat(pat, VE)
	      val var = FOL.newvar()
	  in
	    (FOL.AND(FOL.BIND(var, exp'), FOL.MATCH([(var, pat')])), VE)
	  end
      | cnvGoal(Absyn.NOTgoal(g, _), VE) =
	  let val (conj, VE) = cnvGoal(g, VE)
	  in
	    (FOL.NOT conj, VE)
	  end
      | cnvGoal(Absyn.ANDgoal(g1, g2, _), VE) =
	  let val (conj1, VE) = cnvGoal(g1, VE)
	      val (conj2, VE) = cnvGoal(g2, VE)
	  in
	    (FOL.AND(conj1, conj2), VE)
	  end

    fun cnvClause vars =
      let fun mkdisj(Absyn.CLAUSE1(goalOpt, _, pats, result, ref(pats_positional), _)) =
		let val (pats', VE) = (* fixed the named arguments to positional *)
			if List.length pats_positional = 0 
			then cnvPats(pats, StrDict.empty)
			else cnvPats(pats_positional, StrDict.empty)
		    fun return VE =
		      case result
			of Absyn.RETURN(exps, _) => FOL.RETURN(cnvExps(exps, VE))
			 | Absyn.FAIL _ => FOL.FAIL
		    val body = case goalOpt
				 of SOME goal =>
				      let val (conj, VE) = cnvGoal(goal, VE)
				      in
					FOL.ANDTHEN(conj, return VE)
				      end
				  | NONE => return VE
		in
		  FOL.ANDTHEN(FOL.MATCH(ListPair.zip(vars, pats')), body)
		end
	    | mkdisj(Absyn.CLAUSE2(cl1, cl2, _)) = FOL.ORELSE(mkdisj cl1, mkdisj cl2)
      in
		mkdisj
      end

    fun clauseArity(Absyn.CLAUSE1(_, _, pats, _, ref(pats_positional), _)) = 
			if List.length pats_positional = 0 (* fixed the named arguments to positional *)
			then List.length pats
			else List.length pats_positional
      | clauseArity(Absyn.CLAUSE2(cl1, _, _)) = clauseArity cl1

    fun cnvRelBind (Absyn.RELBIND(var, _, cl, _)) =
      let val vars = newvars(clauseArity cl)
      in
		FOL.REL(cnvId var, vars, cnvClause vars cl)
      end

    fun cnvConBind(Absyn.CONcb(con, _)) = FOL.CONcd(cnvId con)
      | cnvConBind(Absyn.CTORcb(con, tys, _)) = FOL.CTORcd(cnvId con, List.length tys)
    fun cnvDatBind(Absyn.DATBIND(_, tycon, conbinds, _)) =
      FOL.DATDESC(cnvId tycon, map cnvConBind conbinds)

    fun cnvSpecs specs =
      let fun cnvSpec(spec, specs) =
	    case spec
	      of Absyn.WITHspec(_, ri, _) => FOL.WITHspec(cnvInterface(!ri))::specs
	       | Absyn.ABSTYPEspec _ => specs
	       | Absyn.TYPEspec _ => specs
	       | Absyn.DATAspec(datbinds, _, _) =>
			 FOL.DATAspec(map cnvDatBind datbinds)::specs
	       | Absyn.VALspec(var, _, _) => FOL.VALspec(cnvId var)::specs
	       | Absyn.RELspec(var, _, _) => FOL.RELspec(cnvId var)::specs
      in
		List.rev(List.foldl cnvSpec [] specs)
      end

    and cnvInterface(Absyn.INTERFACE({modid,specs,...}, _)) =
      FOL.INTERFACE(cnvId modid, cnvSpecs specs)

    fun cnvDecs decs =
      let fun cnvDec(dec, decs) =
	    case dec
	      of Absyn.WITHdec(_, ri, _) => FOL.WITHdec(cnvInterface(!ri))::decs
	       | Absyn.TYPEdec _ => decs
	       | Absyn.DATAdec(datbinds, _, _) =>
			 FOL.DATAdec(map cnvDatBind datbinds)::decs
	       | Absyn.VALdec(var, exp, _) =>
			 FOL.VALdec(cnvId var, cnvExp(exp, StrDict.empty))::decs
	       | Absyn.RELdec(relbinds, _) =>
			 FOL.RELdec(map cnvRelBind relbinds)::decs
      in
		List.rev(List.foldl cnvDec [] decs)
      end

    fun translate(Absyn.MODULE(interface, decs, _)) =
      FOL.MODULE(cnvInterface interface, cnvDecs decs)

  end (* functor AbsynToFOLFn *)
