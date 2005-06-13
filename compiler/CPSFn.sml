(* cps/cps.sml *)

functor CPSFn(structure Util : UTIL
	      structure ConRep : CONREP
		) : CPS =
  struct

    structure ConRep	= ConRep

    datatype longid	= LONGID of {module: string, name: string}

    datatype constant	= INTcon of int
			| HDRcon of {len: int, con: int}
			| REALcon of real
			| STRINGcon of string

    datatype unop	= FETCH of int
			| BOOL_NOT | INT_NEG | INT_ABS

    datatype binop	= EQUAL
			| BOOL_AND | BOOL_OR
			| INT_ADD | INT_SUB | INT_MUL | INT_DIV
			| INT_MOD | INT_MAX | INT_MIN | INT_LT
			| INT_LE | INT_EQ | INT_NE | INT_GE | INT_GT

    datatype var	= VAR of {	tag	: int,
					uses	: int ref,
					subst	: trivexp' option ref	}

    and lamkind		= FClk
			| SClk of {v_tvs: var list}

    and literal		= CONSTlit of constant
			| STRUCTlit of int * literal list
			| PROClit of proc
			| EXTERNlit of longid

    and proc		= EXTERN_REL of longid * ({args:trivexp list, fc:trivexp, sc:trivexp} -> exp' option) option
			| LOCAL_REL of def

    and label		= LAB of {	tag	: int,
					uses	: int ref,
					fvars	: var list ref,
					bvars	: var list,
					body	: exp	}

    and trivexp'	= VARte of var
			| LAMte of {	tag	: int,
					fvars	: var list ref,
					kind	: lamkind,
					body	: exp	}
			| QUOTEte of literal

    and trivexp		= TE of trivexp' ref

    and primapp		= MARKERp
			| MKSTRUCTp of int * trivexp list
			| UNARYp of unop * trivexp
			| BINARYp of binop * trivexp * trivexp

    and exp'		= AppFCe of trivexp
			| AppSCe of {sc:trivexp, args:trivexp list}
			| AppPVe of {pv:trivexp, args:trivexp list, fc:trivexp, sc:trivexp}
			| LetLABe of label * exp
			| AppLABe of label * trivexp list
			| RESTOREe of trivexp * exp
			| LETe of var * trivexp * exp
			| PRIMe of var * primapp * exp
			| SWITCHe of trivexp * (constant * exp) list * exp option

    and exp		= EXP of exp' ref

    and def		= DEF of {	name	: longid,
					uses	: int ref,
					v_tvs	: var list,
					v_fc	: var,
					v_sc	: var,
					body	: exp	}

    datatype module	= MODULE of {	name	: string,
					ctors	: (longid * ConRep.conrep) list,
					xmods	: string list,
					values	: (longid * literal) list,
					defines	: def list	}

    fun constEqual(INTcon i1, INTcon i2) = i1 = i2
      | constEqual(HDRcon{len=len1,con=con1}, HDRcon{len=len2,con=con2}) =
	  (len1 = len2) andalso (con1 = con2)
      | constEqual(REALcon r1, REALcon r2) = Real.==(r1, r2)
      | constEqual(STRINGcon s1, STRINGcon s2) = s1 = s2
      | constEqual(_, _) = false

    fun prune_te'(te) =
      case te
	of VARte(VAR{subst,...})	=>
	    (case !subst
	       of NONE			=> te
		| SOME te'		=>
		    let val te'' = prune_te' te'
		    in
		      subst := SOME te'';
		      te''
		    end)
	 | _				=> te

    fun getTE' te =
      let fun pruneTE(te as (TE r)) = (r := prune_te'(!r); te)
	  fun untagTE(TE r) = r
      in
	untagTE(pruneTE te)
      end

    fun getTE te = !(getTE' te)

    fun getExp(EXP r) = !r

    fun newDef{name, args, fc, sc, body} =
      DEF{name=name, uses=ref 1, v_tvs=args, v_fc=fc, v_sc=sc, body=body}

    fun newVar() =
      VAR{tag=Util.tick(), uses=ref 0, subst=ref NONE}

    fun newLam(kind, body) =
      TE(ref(LAMte{tag=Util.tick(), fvars=ref[], kind=kind, body=body}))

    fun newLab(bvars, body) =
      LAB{tag=Util.tick(), uses=ref 0, fvars=ref [], bvars=bvars, body=body}

    fun mkVARte(v) = TE(ref(VARte v))
    fun mkQUOTEte(lit) = TE(ref(QUOTEte lit))

    fun mkAppFCe(t_fc) = EXP(ref(AppFCe(t_fc)))
    fun mkAppSCe{sc,args} = EXP(ref(AppSCe{sc=sc,args=args}))
    fun mkAppPVe{pv,args,fc,sc} = EXP(ref(AppPVe{pv=pv,args=args,fc=fc,sc=sc}))
    fun mkLetLABe(lab,e) = EXP(ref(LetLABe(lab,e)))
    fun mkAppLABe(lab,t_star) = EXP(ref(AppLABe(lab,t_star)))
    fun mkRESTOREe(t,e) = EXP(ref(RESTOREe(t,e)))
    fun mkLETe(v,t,e) = EXP(ref(LETe(v,t,e)))
    fun mkPRIMe(v,p,e) = EXP(ref(PRIMe(v,p,e)))
    fun mkSWITCHe(t,cases,def) = EXP(ref(SWITCHe(t,cases,def)))

  end (* functor CPSFn *)
