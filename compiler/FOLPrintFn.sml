(* fol/fol-print.sml *)

functor FOLPrintFn(structure MakeString : MAKESTRING
		   structure Util : UTIL
		   structure PP : PP
		   structure FOLUsages : FOL_USAGES
		     ) : FOL_PRINT =
  struct

    structure FOL = FOLUsages.FOL

    fun prStr(pp, str) = PP.emit(pp, PP.STRING str)
    fun prBlank(pp) = PP.emit(pp, PP.BREAK{blankSpace=1, offset=0})
    fun prNewLine(pp) = PP.emit(pp, PP.lineBreak)

    fun prLongId(pp, FOL.LONGID(id_opt, id)) =
      ((case id_opt of SOME id' => (prStr(pp, id'); prStr(pp, ".")) | NONE => ());
       prStr(pp, id))

    fun prList pp pr xs =
      (PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=1});
       prStr(pp, "[");
       (case xs
	  of x::xs => (pr pp x; List.app (fn x => (prBlank(pp); pr pp x)) xs)
	   | [] => ());
       prStr(pp, "]");
       PP.emit(pp, PP.END))

    fun prVar pp var =
      let val FOL.VAR{name,uses,...} = FOL.deref var
      in
	prStr(pp, name^":"^MakeString.icvt(!uses))
      end
    fun prVars pp vars = prList pp prVar vars
    fun prBlankVar pp var = (prBlank(pp); prVar pp var)

    fun prLit(pp, FOL.ICON i) = prStr(pp, MakeString.icvt i)
      | prLit(pp, FOL.RCON r) = prStr(pp, MakeString.rcvt r)
      | prLit(pp, FOL.SCON s) = prStr(pp, MakeString.scvt s)

    fun prVarRef pp (FOL.GVAR lid) = prLongId(pp, lid)
      | prVarRef pp (FOL.BVAR var) = prVar pp var

    fun prExp pp =
      let fun p(FOL.LITexp(lit)) = prLit(pp, lit)
	    | p(FOL.CONexp(longcon)) = prLongId(pp, longcon)
	    | p(FOL.VARexp vref) = prVarRef pp vref
	    | p(FOL.STRUCTexp(longcon_opt, exps)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.INCONSISTENT, offset=8});
		 prStr(pp, "(STRUCT ");
		 (case longcon_opt
		    of SOME longcon => prLongId(pp, longcon)
		     | NONE => prStr(pp, "-"));
		 prBlank(pp);
		 prList pp prExp exps;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
      in
	p
      end
    fun prExps pp exps = prList pp prExp exps

    fun prPat pp =
      let fun p'(FOL.WILDpat) = prStr(pp, "(WILD)")
	    | p'(FOL.LITpat(lit)) = prLit(pp, lit)
	    | p'(FOL.CONpat(longcon)) = prLongId(pp, longcon)
	    | p'(FOL.STRUCTpat(longcon_opt, pats)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.INCONSISTENT, offset=8});
		 prStr(pp, "(STRUCT ");
		 (case longcon_opt
		    of SOME longcon => prLongId(pp, longcon)
		     | NONE => prStr(pp, "-"));
		 prBlank(pp);
		 prList pp prPat pats;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	  fun p(FOL.PAT(var, pat')) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=6});
		 prStr(pp, "(AS ");
		 prVar pp var;
		 prBlank(pp);
		 p' pat';
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
      in
	p
      end
    fun prPats pp pats = prList pp prPat pats

    fun prMRule pp (var,pat) =
      (PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=1});
       prStr(pp, "(");
       prVar pp var;
       prBlank(pp);
       prPat pp pat;
       prStr(pp, ")");
       PP.emit(pp, PP.END))

    fun prConj pp =
      let fun p(FOL.CALL(vref, exps, vars)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=6});
		 prStr(pp, "(CALL ");
		 prVarRef pp vref;
		 prBlank(pp);
		 prExps pp exps;
		 prBlank(pp);
		 prVars pp vars;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.MATCH(mrules)) =
	        (PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=7});
		 prStr(pp, "(MATCH ");
		 prList pp prMRule mrules;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.EQUAL(var, exp)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=7});
		 prStr(pp, "(EQUAL ");
		 prVar pp var;
		 prBlank(pp);
		 prExp pp exp;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.BIND(var, exp)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=7});
		 prStr(pp, "(BIND ");
		 prVar pp var;
		 prBlank(pp);
		 prExp pp exp;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.NOT(c)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=5});
		 prStr(pp, "(NOT ");
		 p c;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.AND(c1, c2)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=5});
		 prStr(pp, "(AND ");
		 p c1;
		 prBlank(pp);
		 p c2;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
      in
	p
      end

    fun prDisj pp =
      let fun p(FOL.RETURN(exps)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.INCONSISTENT, offset=8});
		 prStr(pp, "(RETURN ");
		 prExps pp exps;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.FAIL) = prStr(pp, "(FAIL)")
	    | p(FOL.ORELSE(d1, d2)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=8});
		 prStr(pp, "(ORELSE ");
		 p d1;
		 prBlank(pp);
		 p d2;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.ANDTHEN(c, d)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=9});
		 prStr(pp, "(ANDTHEN ");
		 prConj pp c;
		 prBlank(pp);
		 p d;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.COND(c, d1, d2)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=6});
		 prStr(pp, "(COND ");
		 prConj pp c;
		 prBlank(pp);
		 p d1;
		 prBlank(pp);
		 p d2;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	    | p(FOL.CASE(vars, cases)) =
		(PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=6});
		 prStr(pp, "(CASE ");
		 prVars pp vars;
		 List.app prCase cases;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
	  and prCase(pats,disj) =
		(prBlank(pp);
		 PP.emit(pp, PP.BEGIN{breakType=PP.CONSISTENT, offset=1});
		 prStr(pp, "(");
		 prPats pp pats;
		 prBlank(pp);
		 p disj;
		 prStr(pp, ")");
		 PP.emit(pp, PP.END))
      in
	p
      end

    fun prRelDef pp (FOL.REL(id, vars, disj)) =
      (prNewLine(pp);
       prStr(pp, "(define (");
       PP.emit(pp, PP.BEGIN{breakType=PP.INCONSISTENT, offset=0});
       prStr(pp, id);
       List.app (prBlankVar pp) vars;
       prStr(pp, ")");
       PP.emit(pp, PP.END);
       prNewLine(pp);
       PP.emit(pp, PP.BEGIN{breakType=PP.INCONSISTENT, offset=2});
       prStr(pp, "  ");
       prDisj pp disj;
       prStr(pp, ")");
       PP.emit(pp, PP.END);
       prNewLine(pp))

   (* adrpo - start *)
    fun prCon pp (FOL.CONcd(id)) = prStr(pp, id)
      | prCon pp (FOL.CTORcd(id, num)) = prStr(pp, id^":"^MakeString.icvt(num))
    
    fun prCons pp cons = prList pp prCon cons
    fun prConDesc pp cons = (prBlank(pp); prCons pp cons)

      
    fun prDatDef pp (FOL.DATDESC(id, condesc)) =
      (prNewLine(pp);
       prStr(pp, "(define (");
       PP.emit(pp, PP.BEGIN{breakType=PP.INCONSISTENT, offset=0});
       prStr(pp, id);
       prConDesc pp condesc;
       prStr(pp, ")");
       PP.emit(pp, PP.END);
       prNewLine(pp))
   (* adrpo - end *)

    fun prDec pp (FOL.RELdec rels) = List.app (prRelDef pp) rels
      | prDec pp (FOL.VALdec(id,exp)) =
	  (prNewLine(pp);
	   prStr(pp, "(define ");
	   prStr(pp, id);
	   PP.emit(pp, PP.BEGIN{breakType=PP.INCONSISTENT,
				offset= ~(6 + String.size id)});
	   prBlank(pp);
	   prExp pp exp;
	   prStr(pp, ")");
	   PP.emit(pp, PP.END);
	   prNewLine(pp))
(* adrpo - start *)	   
      | prDec pp (FOL.DATAdec datdesc) = List.app (prDatDef pp) datdesc
      | prDec _ _ = ()
      
      
    fun prSpec pp (FOL.DATAspec datdesc) = List.app (prDatDef pp) datdesc
      | prSpec _ _ = ()      
(* adrpo - end *)

    fun prModule(pp, FOL.MODULE(FOL.INTERFACE(id,specs), decs)) =
      (prStr(pp, "(MODULE "); prStr(pp, id); prStr(pp, ")"); prNewLine(pp);
       (* adrpo - start *) 
       List.app (prSpec pp) specs; 
       (* adrpo - end *)
       List.app (prDec pp) decs)

    fun printModule(os, module) =
      let val pp = PP.init(os, 80)
	  val _ = FOLUsages.update module  
      in
		PP.emit(pp, PP.BEGIN{offset=0, breakType=PP.CONSISTENT});
		prModule(pp, module);
		PP.emit(pp, PP.END);
		PP.close(pp)
      end

  end (* functor FOLPrintFn *)
