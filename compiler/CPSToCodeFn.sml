(* cpstocode/cpstocode.sml *)

functor CPSToCodeFn(structure MakeString : MAKESTRING
		    structure Util : UTIL
		    structure CPS : CPS
		    structure CPSUsages : CPS_USAGES
		    structure CPSFVars : CPS_FVARS
		    structure Code : CODE
		    sharing CPS = CPSUsages.CPS = CPSFVars.CPS
		    sharing CPS.ConRep = Code.ConRep
		      ) : CPSTOCODE =
  struct

    structure CPS = CPS
    structure Code = Code

    fun bug s = Util.bug("CPSToCode."^s)

    (* manage the set of imported external procedures *)

    local
      val code_xlabs = ref([]:Code.label list)
    in
      fun zap_xlabs() = code_xlabs := []
      fun record_xlab(lab) =
	let fun loop([]) = code_xlabs := lab :: !code_xlabs
	      | loop(lab'::labs) = if lab=lab' then () else loop labs
	in
	  loop(!code_xlabs)
	end
      fun get_xlabs() =
	let val xlabs = !code_xlabs in code_xlabs := []; xlabs end
    end

    (* manage the set of imported external values *)

    local
      val code_xvals = ref([]:Code.label list)
    in
      fun zap_xvals() = code_xvals := []
      fun record_xval(lab) =
	let fun loop([]) = code_xvals := lab :: !code_xvals
	      | loop(lab'::labs) = if lab=lab' then () else loop labs
	in
	  loop(!code_xvals)
	end
      fun get_xvals() =
	let val xvals = !code_xvals in code_xvals := []; xvals end
    end

    (* manage the set of label definitions to be emitted for the current module *)

    val code_labdefs = ref([]:Code.labdef list)
    fun zap_labdefs() = code_labdefs := []
    fun push_labdef(globalP, label, varHP, nalloc, nargs, code) =
      let val labdef = Code.LABDEF{globalP=globalP, label=label, varHP=varHP,
				   nalloc=nalloc, nargs=nargs, code=code}
      in
	code_labdefs := labdef :: !code_labdefs
      end
    fun get_labdefs() =
      let val labdefs = !code_labdefs in zap_labdefs(); labdefs end

    (* generate names for non-qualified labels in the current module
     * local names must never collide with global ones; we handle this by
     * mangling in a "." instead in the name (see trans_longid). 
     * we guarantee that label name used here is unique!
     *)
    val code_modname = ref ""
    fun mkShortLabel name = Code.mklab(!code_modname ^ "." ^ name)

    (* manage the set of literals to be constructed for the current module *)

    val code_litdefs = ref([]:(Code.litname * Code.litdef) list)
    val nr_litdefs = ref 0
    fun zap_litdefs() = (code_litdefs := []; nr_litdefs := 0)
    fun find_litdef(litdef') =
      let fun litdef_equal(Code.REALld r1, Code.REALld r2) = Real.==(r1, r2)
	    | litdef_equal(Code.STRINGld s1, Code.STRINGld s2) = s1 = s2
	    | litdef_equal(Code.STRUCTld(con1,lrs1), Code.STRUCTld(con2,lrs2)) =
		(con1 = con2) andalso (lrs1 = lrs2)
	    | litdef_equal(_, _) = false
	  fun loop((litname,litdef)::litdefs) =
		if litdef_equal(litdef',litdef) then litname else loop litdefs
	    | loop([]) =
		let val litname = Code.LITNAME(!nr_litdefs)
		in
		  nr_litdefs := !nr_litdefs + 1;
		  code_litdefs := (litname,litdef') :: !code_litdefs;
		  litname
		end
      in
	loop(!code_litdefs)
      end
    fun litdef2litref litdef =
      let val litname = find_litdef(litdef)
      in
	case litdef
	  of Code.REALld _	=> Code.REALlr litname
	   | Code.STRINGld _	=> Code.STRINGlr litname
	   | Code.STRUCTld _	=> Code.STRUCTlr litname
      end
    fun get_litdefs() =
      let val litdefs = rev(!code_litdefs) in zap_litdefs(); litdefs end

    (* translate a CPS.Proc reference to a Code.Label *)

    fun trans_longid(CPS.LONGID{module, name}) = module^"."^name

    fun trans_proc(CPS.LOCAL_REL(CPS.DEF{name,...})) = Code.mklab(trans_longid name)
      | trans_proc(CPS.EXTERN_REL(longid,_)) =
	  let val lab = Code.mklab(trans_longid longid)
	  in
	    record_xlab lab;
	    lab
	  end

    (* translate a CPS.Constant to a Code.LitRef *)

    fun trans_const(CPS.INTcon i) = Code.INTlr i
      | trans_const(CPS.HDRcon{len,con}) = Code.HDRlr{len=len,con=con}
      | trans_const(CPS.REALcon r) = litdef2litref(Code.REALld r)
      | trans_const(CPS.STRINGcon s) = litdef2litref(Code.STRINGld s)

    (* translate a CPS.Literal to a Code.LitRef *)

    fun trans_lit(CPS.CONSTlit c) = trans_const c
      | trans_lit(CPS.PROClit proc) = Code.LABELlr(trans_proc proc)
      | trans_lit(CPS.STRUCTlit(con, lits)) =
	  litdef2litref(Code.STRUCTld(con, map trans_lit lits))
      | trans_lit(CPS.EXTERNlit longid) =
	  let val lab = Code.mklab(trans_longid longid)
	  in
	    record_xval lab;
	    Code.EXTERNlr lab
	  end

    (* translate a CPS variable to a local Code variable *)

    fun new_lvar() = Code.LVAR(Util.tick())
    fun trans_lvar(CPS.VAR{tag,...}) = Code.LVAR tag
    fun trans_var var = Code.LOCvar(trans_lvar var)

    (* construct the equivalent of Code.OFFSET(v, i) *)

    fun mkOFFSET(v, 0) = v
      | mkOFFSET(v, i) = Code.OFFSET(v, i)

    (* store `fvars' at `sp[off]' .. `sp[off+length fvars]' in reverse order *)

    fun push_fvars(valSP, off, fvars, code) =
      let fun loop([], _, code) = code
	    | loop(var::vars, off, code) =
		loop(vars, off+1,
		     Code.mkSTORE(Code.OFFSET(valSP, off),
				  Code.VAR(trans_var var),
				  code))
      in
	loop(fvars, off, code)
      end

    (* load `fvars' from `ptr[off]' .. `ptr[off-length fvars]' in reverse order *)

    fun fetch_fvars(varPtr, off, fvars, code) =
      let fun loop([], _, code) = code
	    | loop(var::vars, off, code) =
		loop(vars, off-1,
		     Code.mkBIND(SOME(trans_var var),
				 Code.FETCH(Code.OFFSET(Code.VAR varPtr, off)),
				 code))
      in
		loop(fvars, off, code)
      end

    (* pop the activation record and bind sp *)

    fun pop_fvars(varSP, varPtr, n, code) =	(* sp = ptr + n *)
      Code.mkBIND(SOME varSP, Code.OFFSET(Code.VAR varPtr, n), code)

    (* Give some indication as to why Vector.sub failed..
     * XXX: Eventually we should fix the stack discipline so that
     * parameter passing on the stack becomes possible.
     *)
    fun tooManyArgs() =
      bug("tooManyArgs: Sorry, this compiler is limited to " ^
	  Int.toString(Vector.length Code.intraArgs) ^
	  " formal/actual parameters")

    (* bind the formal parameters of a procedure value or procedure continuation *)

    fun bind_proc_args(var_star, code) =
      let fun loop([], _) = code
	    | loop(var::var_star, argno) =
		Code.mkBIND(SOME(trans_var var),
			    Code.VAR(Vector.sub(Code.intraArgs, argno)),
			    loop(var_star, argno + 1))
      in
		loop(var_star, 0) handle General.Subscript => tooManyArgs()
      end

    (* continuation utilities *)

    fun lk2ap(CPS.FClk) = Code.VAR Code.intraFC
      | lk2ap(CPS.SClk _) = Code.VAR Code.intraSC

    fun lk2formals(CPS.FClk) = []
      | lk2formals(CPS.SClk{v_tvs,...}) = v_tvs

    fun lk2name(CPS.FClk,   partOf) = partOf^"_failureContLam"
      | lk2name(CPS.SClk _, partOf) = partOf^"_successContLam"

    (* compute the heap allocation needs of an expression *)

    fun size_prim(CPS.MKSTRUCTp(_, te_star)) = 1 + length te_star
      | size_prim(_) = 0

    fun size_exp(CPS.EXP r) =
      case !r
	of CPS.AppFCe _			=> 0
	 | CPS.AppSCe _			=> 0
	 | CPS.AppPVe _			=> 0
	 | CPS.LetLABe(_, exp)		=> size_exp exp
	 | CPS.AppLABe _		=> 0
	 | CPS.RESTOREe(_, exp)		=> size_exp exp
	 | CPS.LETe(_, _, exp)		=> size_exp exp
	 | CPS.PRIMe(_, prim, exp)	=> size_prim prim + size_exp exp
	 | CPS.SWITCHe(_, cases, def)	=>
	    List.foldl max_size_case (sizeDefault def) cases

    and sizeDefault(NONE) = 0
      | sizeDefault(SOME exp) = size_exp exp

    and max_size_case ((_,exp), sz) = Int.max(sz, size_exp exp)

    (* translate unary/binary primops to labels *)

    fun trans_unary(unop, te) =
      let fun call(lab) = Code.CALL(lab, [te])
      in
	case unop
	  of CPS.FETCH off 	=> Code.FETCH(mkOFFSET(Code.UNTAGPTR te, off))
	   | CPS.BOOL_NOT	=> call Code.primBOOL_NOT
	   | CPS.INT_NEG	=> call Code.primINT_NEG
	   | CPS.INT_ABS	=> call Code.primINT_ABS
      end

    fun trans_binary(CPS.EQUAL)		= Code.primEQUAL
      | trans_binary(CPS.BOOL_AND)	= Code.primBOOL_AND
      | trans_binary(CPS.BOOL_OR)	= Code.primBOOL_OR
      | trans_binary(CPS.INT_ADD)	= Code.primINT_ADD
      | trans_binary(CPS.INT_SUB)	= Code.primINT_SUB
      | trans_binary(CPS.INT_MUL)	= Code.primINT_MUL
      | trans_binary(CPS.INT_DIV)	= Code.primINT_DIV
      | trans_binary(CPS.INT_MOD)	= Code.primINT_MOD
      | trans_binary(CPS.INT_MAX)	= Code.primINT_MAX
      | trans_binary(CPS.INT_MIN)	= Code.primINT_MIN
      | trans_binary(CPS.INT_LT)	= Code.primINT_LT
      | trans_binary(CPS.INT_LE)	= Code.primINT_LE
      | trans_binary(CPS.INT_EQ)	= Code.primINT_EQ
      | trans_binary(CPS.INT_NE)	= Code.primINT_NE
      | trans_binary(CPS.INT_GE)	= Code.primINT_GE
      | trans_binary(CPS.INT_GT)	= Code.primINT_GT

    (* translate a CPS.Constant to a Code.CaseTag *)

    fun trans_casetag(CPS.INTcon i) = Code.INTct i
      | trans_casetag(CPS.HDRcon{len,con}) = Code.HDRct{len=len,con=con}
      | trans_casetag(CPS.REALcon r)	= Code.REALct r
      | trans_casetag(CPS.STRINGcon s)	= Code.STRINGct s

    (* bind outgoing arguments *)

    fun bind_args(vars, args, code) =
      let fun loop([], _, code) = code
	    | loop(arg::args, argno, code) =
		loop(args, argno+1,
		     Code.mkBIND(SOME(Vector.sub(vars, argno)), arg, code))
      in
	loop(args, 0, code) handle General.Subscript => tooManyArgs()
      end

    (* translate a TrivExp *)

    fun trans_te'(te', valSP, offSP, cont) =
      case te'
	of CPS.VARte(var)	=> cont(Code.VAR(trans_var var), offSP)
	 | CPS.QUOTEte(lit)	=> cont(Code.LITERAL(trans_lit lit), offSP)
	 | CPS.LAMte{tag,fvars,kind,body,partOf}	=>
	      let val lab = mkShortLabel((lk2name(kind,partOf)) ^ (MakeString.icvt tag))
		  and nfvars = length (!fvars)
		  and formals = lk2formals kind
		  and varHP = new_lvar()
		  and varSP = trans_var(CPS.newVar())
		  val offSP = offSP - nfvars - 1
		  val valKont = Code.OFFSET(valSP, offSP)
		  val varAP = trans_var(CPS.newVar())
	      in
		push_labdef(false, lab, varHP, size_exp body, length formals,
			    Code.mkBIND(SOME varAP, lk2ap kind,
			    fetch_fvars(varAP, nfvars, rev(!fvars),
			    pop_fvars(varSP, varAP, nfvars+1,
			    bind_proc_args(formals,
			    trans_exp(body,
				      Code.VAR varSP, 0,
				      Code.VAR(Code.LOCvar varHP), 0))))));
		push_fvars(valSP, offSP + 1, !fvars,
		Code.mkSTORE(valKont, Code.LITERAL(Code.LABELlr lab),
		cont(valKont, offSP)))
	      end

    and trans_te(te, valSP, offSP, cont) =
      trans_te'(CPS.getTE te, valSP, offSP, cont)

    and trans_args(args, valSP, offSP, cont) =
      let fun loop([], val_args, offSP) = cont(rev val_args, offSP)
	    | loop(arg::args, val_args, offSP) =
		trans_te(arg, valSP, offSP, fn(val_arg, offSP) =>
		loop(args, val_arg::val_args, offSP))
      in
	loop(args, [], offSP)
      end

    and trans_prim(prim, valSP, offSP, valHP, offHP, cont) =
      case prim
	of CPS.MARKERp		=> cont(Code.CALL(Code.primMARKER,[]), offSP, offHP)
	 | CPS.MKSTRUCTp(con, te_star) =>
	    let fun loop([], offSP, offHP') =
		      cont(Code.TAGPTR(mkOFFSET(valHP, offHP)), offSP, offHP')
		  | loop(te::te_star, offSP, offHP') =
		      trans_te(te, valSP, offSP, fn(te',offSP) =>
		      Code.mkSTORE(Code.OFFSET(valHP, offHP'), te',
		      loop(te_star, offSP, offHP' + 1)))
	    in
	      Code.mkSTORE(mkOFFSET(valHP, offHP),
			   Code.LITERAL(Code.HDRlr{len=length te_star, con=con}),
	      loop(te_star, offSP, offHP + 1))
	    end
	 | CPS.UNARYp(unop, te)	=>
	    trans_te(te, valSP, offSP, fn(te',offSP') =>
	    cont(trans_unary(unop, te'), offSP', offHP))
	 | CPS.BINARYp(binop, te1, te2)	=>
	    trans_te(te1, valSP, offSP, fn(te1',offSP1) =>
	    trans_te(te2, valSP, offSP1, fn(te2',offSP2) =>
	    cont(Code.CALL(trans_binary binop, [te1',te2']), offSP2, offHP)))

    and trans_exp'(exp', valSP, offSP, valHP, offHP) =	(* -> Code.Code *)
      case exp'
	of CPS.AppFCe(te_fc)	=>
	    trans_te(te_fc, valSP, offSP, fn(val_fc', offSP) =>
	    Code.mkBIND(SOME Code.intraFC, val_fc',
	    Code.mkBIND(SOME Code.intraSP, mkOFFSET(valSP, offSP),
	    Code.mkGOTO(Code.VALUEg(Code.FETCH val_fc'), 0))))
	 | CPS.AppSCe{sc, args}	=> 
	    trans_args(args, valSP, offSP, fn(val_args', offSP) =>
	    trans_te(sc, valSP, offSP, fn(val_sc', offSP) =>
	    bind_args(Code.intraArgs, val_args',
	    Code.mkBIND(SOME Code.intraSC, val_sc',
	    Code.mkBIND(SOME Code.intraSP, mkOFFSET(valSP, offSP),
	    Code.mkGOTO(Code.VALUEg(Code.FETCH val_sc'),
			List.length val_args'))))))
	 | CPS.AppPVe{pv, args, fc, sc}	=> 
	    trans_args(args, valSP, offSP, fn(val_args', offSP) =>
	    trans_te(fc, valSP, offSP, fn(val_fc', offSP) =>
	    trans_te(sc, valSP, offSP, fn(val_sc', offSP) =>
	    case CPS.getTE pv
	      of CPS.QUOTEte(CPS.PROClit(proc as CPS.LOCAL_REL _))	=>
		  let val lab = trans_proc proc
		  in
		    bind_args(Code.intraArgs, val_args',
		    Code.mkBIND(SOME Code.intraFC, val_fc',
		    Code.mkBIND(SOME Code.intraSC, val_sc',
		    Code.mkBIND(SOME Code.intraSP, mkOFFSET(valSP, offSP),
		    Code.mkGOTO(Code.LOCALg lab, List.length val_args')))))
		  end
	       | CPS.QUOTEte(CPS.PROClit(proc as CPS.EXTERN_REL _))	=>
		  let val lab = trans_proc proc
		  in
		    bind_args(Code.interArgs, val_args',
		    Code.mkBIND(SOME Code.interFC, val_fc',
		    Code.mkBIND(SOME Code.interSC, val_sc',
		    Code.mkBIND(SOME Code.interSP, mkOFFSET(valSP, offSP),
		    Code.mkGOTO(Code.EXTERNg lab, List.length val_args')))))
		  end
	       | _	=>
		  trans_te(pv, valSP, offSP, fn(val_pv', offSP) =>
		  bind_args(Code.intraArgs, val_args',
		  Code.mkBIND(SOME Code.intraFC, val_fc',
		  Code.mkBIND(SOME Code.intraSC, val_sc',
		  Code.mkBIND(SOME Code.intraSP, mkOFFSET(valSP, offSP),
		  Code.mkGOTO(Code.VALUEg val_pv', List.length val_args'))))))
		  )))
	 | CPS.LetLABe(CPS.LAB{tag, fvars, bvars, body,partOf,...}, exp)	=>
	    let val varHP = new_lvar()
		and varSP = trans_var(CPS.newVar())
		and formals = !fvars @ bvars
		and lab = mkShortLabel(partOf^"_label"^(MakeString.icvt tag))
	    in
	      push_labdef(false, lab, varHP, size_exp body, length formals,
			  Code.mkBIND(SOME varSP, Code.VAR Code.intraSP,
			  bind_proc_args(formals,
			  trans_exp(body,
				    Code.VAR varSP, 0,
				    Code.VAR(Code.LOCvar varHP), 0))));
	      trans_exp(exp, valSP, offSP, valHP, offHP)
	    end
	 | CPS.AppLABe(CPS.LAB{tag, fvars, partOf, ...}, t_star)		=>
	    let val t_star = (map CPS.mkVARte (!fvars)) @ t_star
		and lab = mkShortLabel(partOf^"_label"^(MakeString.icvt tag))
	    in
	      trans_args(t_star, valSP, offSP, fn(val_args', offSP) =>
	      bind_args(Code.intraArgs, val_args',
	      Code.mkBIND(SOME Code.intraSP, mkOFFSET(valSP, offSP),
	      Code.mkGOTO(Code.LOCALg lab, List.length val_args'))))
	    end
	 | CPS.RESTOREe(te, exp)	=>
	    trans_te(te, valSP, offSP, fn(te',offSP) =>
	    Code.mkBIND(NONE, Code.CALL(Code.primUNWIND, [te']),
	    trans_exp(exp, valSP, offSP, valHP, offHP)))
	 | CPS.LETe(var, te, exp)	=>
	    trans_te(te, valSP, offSP, fn(te',offSP) =>
	    Code.mkBIND(SOME(trans_var var), te',
	    trans_exp(exp, valSP, offSP, valHP, offHP)))
	 | CPS.PRIMe(var, prim, exp)	=>
	    trans_prim(prim,valSP,offSP,valHP,offHP, fn (value,offSP,offHP) =>
	    Code.mkBIND(SOME(trans_var var), value,
	    trans_exp(exp, valSP, offSP, valHP, offHP)))
	 | CPS.SWITCHe(_,[],NONE) => bug "trans_exp': SWITCH(_,[],NONE)"
	 | CPS.SWITCHe(_,[],SOME exp) => trans_exp(exp,valSP,offSP,valHP,offHP)
	 | CPS.SWITCHe(te, cases, default)	=>
	    trans_te(te, valSP, offSP, fn(te',offSP) =>
	    Code.mkSWITCH(te',
			  map (trans_case valSP offSP valHP offHP) cases,
			  transDefault(default, valSP, offSP, valHP, offHP)))

    and transDefault(SOME exp, valSP, offSP, valHP, offHP) =
	  SOME(trans_exp(exp, valSP, offSP, valHP, offHP))
      | transDefault(NONE, _, _, _, _) = NONE

    and trans_case valSP offSP valHP offHP (tag,exp) =
      (trans_casetag tag, trans_exp(exp, valSP, offSP, valHP, offHP))

    and trans_exp(CPS.EXP r, valSP, offSP, valHP, offHP) =
      trans_exp'(!r, valSP, offSP, valHP, offHP)

    fun trans_def(CPS.DEF{name,uses,v_tvs,v_fc,v_sc,body,...}) =
      if !uses = 0 then ()
      else
	let val varHP = new_lvar()
	    and varSP = trans_var(CPS.newVar())
	    and lab = Code.mklab(trans_longid name)
	in
	  push_labdef(!uses < 0, lab, varHP, size_exp body, length v_tvs,
		      Code.mkBIND(SOME(trans_var v_sc), Code.VAR Code.intraSC,
		      Code.mkBIND(SOME(trans_var v_fc), Code.VAR Code.intraFC,
		      Code.mkBIND(SOME varSP, Code.VAR Code.intraSP,
		      bind_proc_args(v_tvs,
		      trans_exp(body,
				Code.VAR varSP, 0,
				Code.VAR(Code.LOCvar varHP), 0))))))
	end

    fun trans_ctor(longid,rep) = (trans_longid longid, rep)

    fun trans_value(longid,lit) = (Code.mklab(trans_longid longid), trans_lit lit)

    fun zap_everything() =
      (zap_labdefs(); zap_litdefs(); zap_xlabs(); zap_xvals(); code_modname := "")

    fun translate module =
      (let val _ = zap_everything()
	   val (module as CPS.MODULE{name,ctors,xmods,values,defines}) =
	     CPSUsages.update module
	   val _ = code_modname := name
	   val _ = CPSFVars.update module
	   val values = map trans_value values
	   val _ = List.app trans_def defines
       in
	 Code.MODULE{modname=name, ctors=map trans_ctor ctors, xmods=xmods,
		     xvals=get_xvals(),values=values,
		     xlabs=get_xlabs(),litdefs=get_litdefs(),labdefs=get_labdefs()}
       end)
      handle e => (zap_everything(); raise e)

  end (* functor CPSToCodeFn *)
