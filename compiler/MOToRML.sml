(* MOToRML.sml *)

structure MOToRML = 
		MOToRMLFn(structure Absyn = Absyn
				  structure Control = Control
				  structure Util = Util
				  structure MOToMO = MOToMO);


	(*	
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
				[translateExpIdent(Exp1), translateExpIdent(Exp2)],
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				_,
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
				[translateExpIdent(Exp)],
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				ref [],
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
				[translateExpIdent(Exp1), translateExpIdent(Exp2)],
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				ref [], 
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
				[translateExpIdent(Exp)],
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				ref [],
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
				[translateExpIdent(Exp1), translateExpIdent(Exp2)],
				[Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
								ref(Absyn.WILDpat(info)), 
								info)],
				ref [],
				info)
		  ),
		  info)
		end			
	| translateExp(Absyn.CALL(cref, fargs, info)) =
		let
		   val result = Absyn.FAIL(info)
		in
		 debug("translateExp-LogicalBinary\n");
		 (result,  NONE,  info)	
		end
		(* (prBugLoc(info); print "\n"; bug (" CALL unexpected expression!")) *)
	| translateExp(i as Absyn.INTEGER(x, info)) = 
		(* (makeExpLiteral(i), NONE, info) *)
		(prBugLoc(info); print "\n"; bug (" INTEGER unexpected expression!")) 
	| translateExp(r as Absyn.REAL(x, info)) = 
		(* (makeExpLiteral(r), NONE, info) *)
		(prBugLoc(info); print "\n"; bug (" REAL unexpected expression!")) 
	| translateExp(s as Absyn.STRING(x, info)) = 
		(* (makeExpLiteral(s), NONE, info) *)
		(prBugLoc(info); print "\n"; bug (" STRING unexpected expression!")) 
	| translateExp(b as Absyn.BOOL(x, info)) = 
		(* (makeExpLiteral(b), NONE, info) *)
		(prBugLoc(info); print "\n"; bug (" BOOL unexpected expression!")) 
	| translateExp(Absyn.CREF(x, info)) = 
		(prBugLoc(info); print "\n"; bug (" CREF unexpected expression!"))
	| translateExp(Absyn.IFEXP(a, b, c, d, info)) = 
		(prBugLoc(info); print "\n"; bug (" IFEXP unexpected expression!"))
	| translateExp(Absyn.ARRAY(fargs, info)) = 
		(prBugLoc(info); print "\n"; bug (" ARRAY unexpected expression!"))
	| translateExp(Absyn.MATRIX(x, info)) =
		(prBugLoc(info); print "\n"; bug (" MATRIX unexpected expression!"))
	| translateExp(Absyn.RANGE(x, y, z, info)) =
		(prBugLoc(info); print "\n"; bug (" RANGE unexpected expression!"))
	| translateExp(Absyn.TUPLE(fargs, info)) = 
		(prBugLoc(info); print "\n"; bug (" TUPLE unexpected expression!"))
	| translateExp(Absyn.END(info)) =
		(prBugLoc(info); print "\n"; bug (" END unexpected expression!"))
	| translateExp(Absyn.MSTRUCTexp(path, explist, info)) =
		(prBugLoc(info); print "\n"; bug (" MSTRUCTexp unexpected expression!"))
	| translateExp(Absyn.MWILDexp(info)) = 
		(prBugLoc(info); print "\n"; bug (" MWILDexp unexpected expression!"))
	| translateExp(Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, info)) =
		(prBugLoc(info); print "\n"; bug (" MATCHexp unexpected expression!"))
	*)
