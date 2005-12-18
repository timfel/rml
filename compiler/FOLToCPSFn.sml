(* foltocps/foltocps.sml *)

functor FOLToCPSFn(structure Util : UTIL
		   structure FOLUsages : FOL_USAGES
		   structure PMC : PMC
		   structure TransEnv : TRANSENV
		   structure Control : CONTROL
		   sharing PMC.CPS = TransEnv.CPS
		     ) : FOLTOCPS =
  struct

    structure FOL = FOLUsages.FOL
    structure CPS = TransEnv.CPS
    structure StrDict = TransEnv.StrDict

    structure ConRep = TransEnv.ConRep	(* = CPS.ConRep *)

    fun bug s = Util.bug("FOLToCPS."^s)

    type tenv = TransEnv.translation StrDict.dict

    fun lookupModid(ME, modid) =
      case StrDict.find(ME, modid)
	of SOME x => x
	 | NONE => bug("lookupModid: "^modid)

    fun lookupVar(TE, var) =	(* here, TE = translation environment *)
      case StrDict.find(TE, var)
	of SOME x => x
	 | NONE => bug("lookupVar: "^var)

    fun lookup_longid ME TE (FOL.LONGID(modid_opt,var)) =
      let val TE = case modid_opt
		     of SOME modid => lookupModid(ME, modid)
		      | NONE => TE
      in
		lookupVar(TE, var)
      end

    fun getCtor(TransEnv.CON{rep,nrcons,...}) = (rep,nrcons)
      | getCtor _ = bug "getCtor"
    fun get_ctor_rep(TransEnv.CON{rep,...}) = rep
      | get_ctor_rep(_) = bug "get_ctor_rep"

    fun get_var(TransEnv.VAR(CPS.TE(ref(CPS.VARte var)))) = var
      | get_var(_) = bug "get_var"

    fun conrep2lit(ConRep.BOX{arity=0,tag}) = CPS.STRUCTlit(tag,[])
      | conrep2lit(ConRep.INT tag) = CPS.CONSTlit(CPS.INTcon tag)
      | conrep2lit(_) = bug "conrep2lit"

    fun translation2lit(TransEnv.DEF{def,...}) = CPS.PROClit(CPS.LOCAL_REL def)
      | translation2lit(TransEnv.LIT lit) = lit
      | translation2lit(TransEnv.CON{rep,...}) = conrep2lit rep
      | translation2lit(TransEnv.VAR _) = bug "translation2lit: VAR"

    fun translation2te(TransEnv.VAR te) = te
      | translation2te bnd = CPS.mkQUOTEte(translation2lit bnd)

    fun lit2con(FOL.ICON i) = CPS.INTcon i
      | lit2con(FOL.RCON r) = CPS.REALcon r
      | lit2con(FOL.SCON s) = CPS.STRINGcon s

    (* evaluate expression
     * to simplify things, expressions are first translated to a (direct)
     * form which makes values explicit; this form is then CPS-converted
     *)
    datatype Exp	= LEAFexp of CPS.trivexp
			| STRUCTexp of int * Exp list

    fun QUOTEexp lit = LEAFexp(CPS.mkQUOTEte lit)

    (* "()" becomes "0" *)
    fun mkSTRUCTexp(0, []) = QUOTEexp(CPS.CONSTlit(CPS.INTcon 0))
      | mkSTRUCTexp(con, exps) = STRUCTexp(con, exps)

    fun encode_exp_constant rep = QUOTEexp(conrep2lit rep)

    fun var_name var = let val FOL.VAR{name,...} = FOL.deref var in name end

    fun encode_exp menv tenv exp =
      case exp
	of FOL.LITexp(lit)	=> QUOTEexp(CPS.CONSTlit(lit2con lit))
	 | FOL.CONexp(longcon)		=>
	     encode_exp_constant(get_ctor_rep(lookup_longid menv tenv longcon))
	 | FOL.VARexp(FOL.GVAR longid)	=>
	     QUOTEexp(translation2lit(lookup_longid menv tenv longid))
	 | FOL.VARexp(FOL.BVAR var)	=>
	     LEAFexp(translation2te(lookupVar(tenv, var_name var)))
	 | FOL.STRUCTexp(longctor_opt, exps)	=>
	     let val exps = map (encode_exp menv tenv) exps
	     in
	       case longctor_opt
		 of NONE				=> mkSTRUCTexp(0, exps)
		  | SOME longctor			=>
		      let fun bad() = bug "encode_exp: bad constructor"
		      in
			case get_ctor_rep(lookup_longid menv tenv longctor)
			  of ConRep.TRANSPARENT		=>
			      (case exps
				 of [exp]		=> exp
				  | _			=> bad())
			   | ConRep.BOX{tag,...}	=> STRUCTexp(tag, exps)
			   | _				=> bad()
		      end
	     end

    datatype ECont = EC of CPS.trivexp -> CPS.exp
    fun app_ec (EC econt) te = econt te
    datatype ESCont = ESC of CPS.trivexp list -> CPS.exp
    fun app_esc (ESC escont) te_star = escont te_star

    fun bind_var(tenv, var, te) =
      let val FOL.VAR{name, uses, ...} = FOL.deref var
      in
	case !uses
	  of 0	=> tenv
	   | _	=> StrDict.insert(tenv, name, TransEnv.VAR te)
      end

    fun cps_exp (LEAFexp te) ec			= app_ec ec te
      | cps_exp (STRUCTexp(con,exp_star)) ec	=
	  let val esc = ESC(fn te_star =>
			    let val v = CPS.newVar()
			    in
			      CPS.mkPRIMe(v, CPS.MKSTRUCTp(con, te_star),
					  app_ec ec (CPS.mkVARte v))
			    end)
	  in
	    cps_exp_star exp_star esc
	  end

    and cps_exp_star exp_star esc =
      let fun loop([], rev_te_star) = app_esc esc (rev rev_te_star)
	    | loop(exp::exp_star, rev_te_star) =
		cps_exp exp (EC(fn te => loop(exp_star, te::rev_te_star)))
      in
	loop(exp_star, [])
      end

    fun eval exp menv tenv ec = cps_exp (encode_exp menv tenv exp) ec

    fun eval_star exp_star menv tenv esc =
      cps_exp_star (map (encode_exp menv tenv) exp_star) esc

    (* translation functions *)

    fun mkTUPLEpat [] = PMC.WILDpat
      | mkTUPLEpat pats = PMC.STRUCTpat{ncons=1,con=0,pats=pats}

    fun pat_vars(FOL.PAT(var, pat'), vars) =
      let val FOL.VAR{uses,name,...} = FOL.deref var
      in
	pat'_vars(pat', if !uses > 0 then name::vars else vars)
      end

    and pat'_vars(FOL.STRUCTpat(_, pats), vars) = pats_vars(pats, vars)
      | pat'_vars(_, vars) = vars

    and pats_vars(pats, vars) = List.foldl pat_vars vars pats

    fun encode_pat menv tenv =
      let fun e(FOL.PAT(var, pat')) =
	    let val FOL.VAR{uses,name,...} = FOL.deref var
		val pat = e' pat'
	    in
	      if !uses > 0 then
		PMC.BINDpat(get_var(lookupVar(tenv, name)), pat)
	      else pat
	    end
	  and e'(FOL.WILDpat)				= PMC.WILDpat
	    | e'(FOL.LITpat lit)			= PMC.LITpat(lit2con lit)
	    | e'(FOL.CONpat longcon)			=
		let val (rep,nrcons) = getCtor(lookup_longid menv tenv longcon)
		in
		  case rep
		    of ConRep.BOX{arity=0,tag} =>
			PMC.STRUCTpat{ncons=nrcons,con=tag,pats=[]}
		     | ConRep.INT tag => PMC.CONpat{ncons=nrcons,con=tag}
		     | _ => bug "encode_pat: impossible constant constructor"
		end
	    | e'(FOL.STRUCTpat(longctor_opt, pats))	=
		let val pats = map e pats
		in
		  case longctor_opt
		    of NONE				=> mkTUPLEpat pats
		     | SOME longctor			=>
			let fun bad() = bug "encode_pat: bad constructor"
			    val (rep,nrcons) = getCtor(lookup_longid menv tenv longctor)
			in
			  case rep
			    of ConRep.TRANSPARENT	=>
				(case pats
				   of [pat]		=> pat
				    | _			=> bad())
			     | ConRep.BOX{tag,arity}	=>
				if arity = length pats then
				  PMC.STRUCTpat{ncons=nrcons,con=tag,pats=pats}
				else bad()
			     | _			=> bad()
			end
		end
      in
	e
      end

    fun bind_name(name, tenv) =
      StrDict.insert(tenv, name, TransEnv.VAR(CPS.mkVARte(CPS.newVar())))

    fun trans_pats menv tenv pats =
      let val tenv = List.foldl bind_name tenv (pats_vars(pats, []))
      in
	(map (encode_pat menv tenv) pats, tenv)
      end

    fun Q vref menv tenv =
      let val trans = case vref
			of FOL.GVAR lid => lookup_longid menv tenv lid
			 | FOL.BVAR var => lookupVar(tenv, var_name var)
      in
	translation2te trans
      end

    datatype GCont = GC of tenv -> CPS.trivexp -> CPS.exp
    fun app_gc (GC gc) tenv t_fc = gc tenv t_fc

    fun C conj menv tenv t_fc gc =
      case conj
	of FOL.CALL(q, exps, vars)	=>
	    eval_star exps menv tenv
	      (ESC(fn t_star =>
		   let val v_sc = CPS.newVar()
		       and vars' = map (fn _ => CPS.newVar()) vars
		       val t_sc = CPS.mkVARte v_sc
		       and tenv' = List.foldl (fn((var,var'),tenv) => bind_var(tenv, var, CPS.mkVARte var'))
					      tenv
					      (ListPair.zip(vars, vars'))
		       val lam_sc = CPS.newLam(CPS.SClk{v_tvs=vars'},
						app_gc gc tenv' t_fc)
		   in
		     CPS.mkLETe(v_sc, lam_sc,
		     CPS.mkAppPVe{pv=Q q menv tenv, args=t_star, fc=t_fc, sc=t_sc})
		   end))
	 | FOL.MATCH(mrules)		=>
	    let val vars = map (fn(var,_) => get_var(lookupVar(tenv, var_name var)))
			       mrules
		val (pats,tenv) = trans_pats menv tenv (map #2 mrules)
	    in
	      PMC.pmc(vars, [(pats, app_gc gc tenv)], t_fc,
		      !Control.warnNonExhaustive)
	    end
	 | FOL.EQUAL(var, exp)		=>
	    eval exp menv tenv
	      (EC(fn te2 =>
		  let val v = CPS.newVar()
		      val te1 = translation2te(lookupVar(tenv, var_name var))
		  in
		    CPS.mkPRIMe(v, CPS.BINARYp(CPS.EQUAL, te1, te2),
		    CPS.mkSWITCHe(CPS.mkVARte v,
				  [(CPS.INTcon 0, CPS.mkAppFCe t_fc)],
				  SOME(app_gc gc tenv t_fc)))
		  end))
	 | FOL.BIND(var, exp)		=>
	    eval exp menv tenv
	      (EC(fn te =>
		  let val v = CPS.newVar()
		      val tenv = bind_var(tenv, var, CPS.mkVARte v)
		  in
		    CPS.mkLETe(v, te, app_gc gc tenv t_fc)
		  end))
	 | FOL.NOT(conj)		=>
	    let val v_tp = CPS.newVar()
		and v_fc' = CPS.newVar()
		val gc' = GC(fn _ => fn fc' => CPS.mkAppFCe(t_fc))
		and lam_fc' =
		  CPS.newLam(CPS.FClk,
			      CPS.mkRESTOREe(CPS.mkVARte v_tp,
					     app_gc gc tenv t_fc))
	    in
	      CPS.mkPRIMe(v_tp, CPS.MARKERp,
	      CPS.mkLETe(v_fc', lam_fc',
	      C conj menv tenv (CPS.mkVARte v_fc') gc'))
	    end
	 | FOL.AND(conj1, conj2)	=>
	    C conj1 menv tenv t_fc
	      (GC(fn tenv' => fn t_fc' => C conj2 menv tenv' t_fc' gc))

    fun D disj menv tenv t_fc t_sc =
      case disj
	of FOL.RETURN(exps)		=>
	    eval_star exps menv tenv
	      (ESC(fn t_star => CPS.mkAppSCe{sc=t_sc, args=t_star}))
	 | FOL.FAIL => CPS.mkAppFCe t_fc
	 | FOL.ORELSE(disj1, disj2)	=>
	    let val v_tp = CPS.newVar()
		and v_fc' = CPS.newVar()
		val lam_fc' = CPS.newLam(CPS.FClk,
					  CPS.mkRESTOREe(CPS.mkVARte v_tp,
					  D disj2 menv tenv t_fc t_sc))
	    in
	      CPS.mkPRIMe(v_tp, CPS.MARKERp,
	      CPS.mkLETe(v_fc', lam_fc',
	      D disj1 menv tenv (CPS.mkVARte v_fc') t_sc))
	    end
	 | FOL.ANDTHEN(conj1, disj2)	=>
	    C conj1 menv tenv t_fc
	      (GC(fn tenv' => fn t_fc' => D disj2 menv tenv' t_fc' t_sc))
	 | FOL.COND(conj1, disj2, disj3)=>
	    let val v_tp = CPS.newVar()
		and v_fc' = CPS.newVar()
		val lam_fc' = CPS.newLam(CPS.FClk,
					  CPS.mkRESTOREe(CPS.mkVARte v_tp,
					  D disj3 menv tenv t_fc t_sc))
	    in
	      CPS.mkPRIMe(v_tp, CPS.MARKERp,
	      CPS.mkLETe(v_fc', lam_fc',
	      C conj1 menv tenv (CPS.mkVARte v_fc')
		(GC(fn tenv' => fn _ => D disj2 menv tenv' t_fc t_sc))))
	    end
	 | FOL.CASE(vars, cases)	=>
	    let val vars = map (fn var => get_var(lookupVar(tenv, var_name var)))
			       vars
		val mrules = map (fn(pats,disj) =>
				    let val (pats,tenv) = trans_pats menv tenv pats
				    in
				      (pats, fn t_fc' => D disj menv tenv t_fc' t_sc)
				    end)
				 cases
	    in
	      PMC.pmc(vars, mrules, t_fc, !Control.warnNonExhaustive)
	    end

    (* determine representation stategy for a list of conbinds *)

    datatype RepStrategy = ID | IMM | TAG

    fun repana(conbinds) =
      let fun loop([], noargs, wargs) =
		let val strategy = case wargs
				     of 0 => IMM
				      | 1 => (case noargs of 0 => ID | _ => TAG)
				      | _ => TAG
		in
		  (strategy, noargs+wargs)
		end
	    | loop((FOL.CONcd _)::conbinds, noargs, wargs) =
		loop(conbinds, noargs+1, wargs)
	    | loop((FOL.CTORcd(_,_))::conbinds, noargs, wargs) =
		loop(conbinds, noargs, wargs+1)
      in
		loop(conbinds, 0, 0)
      end

    (* analyze a datbind and enter its constructors to the translation environment *)

    datatype PreConBnd	= PCB of {name: string, rep: ConRep.conrep, nrcons: int}

    fun do_datbind(FOL.DATDESC(ident, conbinds), pre_tenv) =
      let val (strategy,nrcons) = repana(conbinds)
	  fun loop([], _, pre_tenv) = pre_tenv
	    | loop(cb::conbinds, tagno, pre_tenv) =
		let val (name,arity) =
		      case cb
			of FOL.CONcd(con) => (con, 0)
			 | FOL.CTORcd(con, arity) => (con, arity)
		    fun continue(rep) =
		      loop(conbinds, tagno+1,
			   (PCB{name=name,rep=rep,nrcons=nrcons})::pre_tenv)
		in
		  case strategy
		    of ID	=>	(* must be the only ctor in this conbind *)
			let val rep = if arity = 1 then ConRep.TRANSPARENT
				          else ConRep.BOX{arity=arity, tag=0}
			in
			  (PCB{name=name,rep=rep,nrcons=1})::pre_tenv
			end
		     | IMM	=> continue(ConRep.INT tagno)
		     | TAG	=> continue(ConRep.BOX{arity=arity, tag=tagno})
		end
      in
	   loop(conbinds, 0, pre_tenv)
      end

    fun pcb2ctor modname (PCB{name,rep,...}) =
      (CPS.LONGID{module=modname,name=name}, rep)

    fun pcb2te(PCB{name,rep,nrcons}, tenv) =
      StrDict.insert(tenv, name, TransEnv.CON{rep=rep,nrcons=nrcons})

    fun datbinds_pre_tenv(pre_tenv, datbinds) =
		List.foldl do_datbind pre_tenv datbinds

    fun datbinds_tenv(tenv, datbinds) =
      let val pre_tenv = datbinds_pre_tenv([], datbinds)
      in
		List.foldl pcb2te tenv pre_tenv
      end

    (* import the interface of a named module *)

    fun do_with(menv, FOL.INTERFACE(modid,specs)) =
      let fun enter(FOL.DATAspec datdescs, tenv) = datbinds_tenv(tenv, datdescs)
	    | enter(FOL.RELspec id, tenv) =
		let val proc = CPS.EXTERN_REL(CPS.LONGID{module=modid, name=id},NONE)
		in
		  StrDict.insert(tenv, id, TransEnv.LIT(CPS.PROClit proc))
		end
	    | enter(FOL.VALspec id, tenv) =
		let val lit = CPS.EXTERNlit(CPS.LONGID{module=modid, name=id})
		in
		  StrDict.insert(tenv, id, TransEnv.LIT lit)
		end
	    | enter(FOL.WITHspec _, tenv) = tenv
      in
		StrDict.insert(menv, modid, List.foldl enter StrDict.empty specs)
      end

    (*
     * X0: enter WITH and DATATYPE specifications from module's interface
     * X1: enter declarations from module's implementation
     * X2: mark exported procedures
     * X3: translate clauses and update the procedures' bodies
     *)

    (* X0: menv -> Absyn.spec list -> menv*(PreConBnd list) *)

    fun X0 menv spec_star =
      let fun loop([], menv, pre_tenv) = (menv,pre_tenv)
	    | loop(spec::spec_star, menv, pre_tenv) =
		case spec
		  of FOL.WITHspec interface =>
			loop(spec_star, do_with(menv,interface), pre_tenv)
		   | FOL.DATAspec datb =>
			loop(spec_star, menv, datbinds_pre_tenv(pre_tenv,datb))
		   | _				=>
			loop(spec_star, menv, pre_tenv)
      in
		loop(spec_star, menv, [])
      end

    (* X1: Absyn.ident -> menv -> tenv -> FOL.dec list -> menv*tenv *)

    fun do_rels(modname, menv, tenv, rels) =
      let val final_tenv = ref(StrDict.empty: tenv)
	  fun loop([], tenv) = (final_tenv := tenv; tenv)
	    | loop(FOL.REL(id,formals,disj)::rels, tenv) =
		let val v_fc = CPS.newVar()
		    val v_sc = CPS.newVar()
		    val v_star = map (fn _ => CPS.newVar()) formals
		    val rBody = ref(CPS.AppFCe(CPS.TE(ref(CPS.QUOTEte(CPS.CONSTlit(CPS.INTcon 0))))))
		    val def = CPS.newDef{name=CPS.LONGID{module=modname, name=id},
					  args=v_star, fc=v_fc, sc=v_sc,
					  body=CPS.EXP rBody}
		    val t_fc = CPS.mkVARte v_fc
		    val t_sc = CPS.mkVARte v_sc
		    val t_tv_star = map CPS.mkVARte v_star
		    fun tieknot() =
		      let val tenv' = List.foldl (fn((var,var'),tenv) => bind_var(tenv,var,CPS.mkVARte var'))
						 (!final_tenv)
						 (ListPair.zip(formals,v_star))
			  val body = D disj menv tenv' t_fc t_sc
		      in
			rBody := CPS.getExp body
		      end
		in
		  loop(rels,
		       StrDict.insert(tenv, id, TransEnv.DEF{def=def,tieknot=tieknot}))
		end
      in
	loop(rels, tenv)
      end

    fun exp2lit(LEAFexp(CPS.TE(ref(CPS.QUOTEte lit)))) = lit
      | exp2lit(LEAFexp(CPS.TE(ref _))) = bug "exp2lit"
      | exp2lit(STRUCTexp(con,exps)) = CPS.STRUCTlit(con, map exp2lit exps)

    fun X1 modname menv tenv dec_star =
      let fun loop([], menv, tenv) = (menv,tenv)
	    | loop(dec::dec_star, menv, tenv) =
		case dec
		  of FOL.WITHdec i	=>
			loop(dec_star, do_with(menv,i), tenv)
		   | FOL.DATAdec datb	=>
			loop(dec_star, menv, datbinds_tenv(tenv,datb))
		   | FOL.RELdec rels	=>
			loop(dec_star, menv, do_rels(modname,menv,tenv,rels))
		   | FOL.VALdec(id,exp)	=>
			let val lit = exp2lit(encode_exp menv tenv exp)
			in
			  loop(dec_star, menv, StrDict.insert(tenv,id,TransEnv.LIT lit))
			end
      in
		loop(dec_star, menv, tenv)
      end

    (* X2: tenv -> Absyn.spec -> unit *)

    fun X2 tenv =
      fn FOL.RELspec id =>
	  (case lookupVar(tenv, id)
	     of TransEnv.DEF{def=CPS.DEF{uses,...},...}	=> uses := ~1 (*infinite*)
	      | _ => bug "X2")
       | _			=> ()

    (* X3: tenv -> CPS.def list *)

    fun X3 tenv =
      let fun combine(_, TransEnv.DEF{def,tieknot}, defs) = (tieknot(); def::defs)
	    | combine(_, _, defs) = defs
      in
	    StrDict.fold(combine, [], tenv)
      end

    (* X4: menv -> string list *)

    fun X4 menv =
      let fun combine(modname, _, xmods) = modname :: xmods
      in
	    StrDict.fold(combine, [], menv)
      end

    (* X5: string -> tenv -> Absyn.spec list -> (CPS.longid * CPS.literal) list *)

    fun X5 modid tenv spec_star =
      let fun enter(FOL.VALspec id, values) =
		(case lookupVar(tenv, id)
		   of TransEnv.LIT lit	=>
			(CPS.LONGID{module=modid,name=id},lit)::values
		    | _ => bug "X5")
	    | enter(_, values) = values
      in
	List.foldl enter [] spec_star
      end

    (* translate: FOL.module -> CPS.module *)

    fun translate(m as FOL.MODULE(FOL.INTERFACE(modname,spec_star), dec_star)) =
      let val _ = FOLUsages.update m
	  val (menv,tenv) = (TransEnv.menv0,TransEnv.tenv0)	(* initial environments *)
	  val (menv,pre_tenv) = X0 menv spec_star	(* add interface specs *)
	  val tenv = List.foldl pcb2te tenv pre_tenv
	  val ctors = map (pcb2ctor modname) pre_tenv
	  val (menv,tenv) = X1 modname menv tenv dec_star	(* add implementation decls*)
	  val _ = List.app (X2 tenv) spec_star		(* mark exported procs *)
	  val defs = X3 tenv				(* translate procedures *)
	  val xmods = X4 menv				(* imported modules' names *)
	  val values = X5 modname tenv spec_star	(* exported values *)
      in
	   CPS.MODULE{name=modname,ctors=ctors,xmods=xmods,values=values,defines=defs}
      end

  end (* functor FOLToCPSFn *)
