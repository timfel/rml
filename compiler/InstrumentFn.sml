
(* InstrumentFn.sml *)

functor InstrumentFn(structure Absyn : ABSYN
					 structure Util : UTIL) : ABSYN_INSTRUMENTED =
  struct

    structure Absyn = Absyn
    
    fun bug s = Util.bug("Instrument."^s)

    fun instrument(fileName, m) =
    (* ------------------------------------------------------ *)
    let 
    fun prStr(s) = (s)
	fun print_sequence(b4, between, after, foo_star, print_foo) =
	let fun loop([]) = ("")
		| loop(foo::foo_star) = (between^print_foo(foo)^(loop foo_star))
	in
		b4^
		(case foo_star
			of []		=> ("")
			| (foo::foo_star)	=> (print_foo(foo)^(loop foo_star)))
		^after
	end

    fun print_parens_comma(foo_star, print_foo) =
      print_sequence("(", ",", ")", foo_star, print_foo)
	
	
	fun print_list_sequence_exp(b4, between, after, foo_star, print_foo) =
	let fun loop([]) = ("")
		| loop(Absyn.CONexp(Absyn.LONGID(SOME(Absyn.IDENT("RML",_)),Absyn.IDENT("nil",_),_),_)::nil)
			= (after)
		| loop(Absyn.STRUCTexp(
				SOME(Absyn.LONGID(SOME(Absyn.IDENT("RML", _)), 
				                  Absyn.IDENT("cons", _), _)), foo::foo_star, _)::nil)
			= (between^print_foo(foo)^(loop foo_star))
		| loop(foo::foo_star) = (between^print_foo(foo)^(loop foo_star))
	in
		b4^
		(case foo_star
			of []		=> ("")
			| (foo::foo_star)	=> (print_foo(foo)^(loop foo_star)))
	end	
	
    fun print_list_comma_exp(foo_star, print_foo) =
      print_list_sequence_exp("[", ",", "]", foo_star, print_foo)

    (*
    RML.debug("main.rml",34,9,34,24,"apply","let:[[j,m]=lli") => () &
    let RML.cons(RML.cons(j,m),RML.nil) = lli &
    let [j::m] = lli &
    *)

	fun print_list_sequence_pat(b4, between, after, foo_star, print_foo) =
	let fun loop([]) = ("")
		| loop(Absyn.CONpat(Absyn.LONGID(SOME(Absyn.IDENT("RML",_)),Absyn.IDENT("nil",_),_),_)::nil)
			= ("nil")
		| loop(Absyn.STRUCTpat(
				SOME(Absyn.LONGID(SOME(Absyn.IDENT("RML", _)), 
				                  Absyn.IDENT("cons", _), _)), foo::foo_star, _)::nil)
			= (case foo_star of
			    (Absyn.STRUCTpat(
				SOME(Absyn.LONGID(SOME(Absyn.IDENT("RML", _)), 
				                  Absyn.IDENT("cons", _), _)),_,_)::nil) => (between^print_foo(foo)^(loop foo_star))
				 | (_) => (print_foo(foo)^"::"^(loop foo_star)))									
		| loop(foo::foo_star) = (between^print_foo(foo)^(loop foo_star))
	in
		b4^
		(case foo_star
			of []		=> ("")
			| (foo::foo_star)	=> (print_foo(foo)^(loop foo_star)))
		^after
	end	
	
    fun print_list_comma_pat(foo_star, print_foo) =
      print_list_sequence_pat("[", ",", "]", foo_star, print_foo)

    fun print_list([], _) = ("")
      | print_list(foo_star, print_foo) =
	  print_parens_comma(foo_star, print_foo)

    fun print_ident(id) = Absyn.identName id

    fun print_longid(Absyn.LONGID(modname, ident, _)) =
      (case modname
	  of SOME ident'=> (print_ident(ident') ^ "." ^ print_ident(ident))
	   | NONE		=> (print_ident(ident)))

    fun print_longid_info(Absyn.LONGID(modname, ident, _)) = 
		let val Absyn.INFO(file,_,_,
						   ref(Absyn.LOC(sline,scolumn,eline,ecolumn))) = 
						   Absyn.identCtxInfo ident
		in
		(case modname
			of SOME ident'=> (print_ident(ident') ^ "." ^ print_ident(ident))
			| NONE		=> (print_ident(ident))^("|"^file^":"^
				(Int.toString sline)^"."^
				(Int.toString scolumn)^"."^
				(Int.toString eline)^"."^
				(Int.toString ecolumn))
		)
	  end

	   
    fun print_lit(lit) = Absyn.litString lit

    fun print_scon(s) = MakeString.scvt s
    
    fun print_ctor_opt(NONE) = ("")
      | print_ctor_opt(SOME longctor) = print_longid(longctor)
    
	val modidRML = SOME(Absyn.rmlIdent "RML")
	val debug = Absyn.LONGID(modidRML, Absyn.rmlIdent "debug", ref(Absyn.dummyInfo))
	val show = Absyn.LONGID(modidRML, Absyn.rmlIdent "debug_push_vars", ref(Absyn.dummyInfo))
	val id_cons = Absyn.LONGID(modidRML, Absyn.rmlIdent "cons", ref(Absyn.dummyInfo))
	val ctor_cons = SOME id_cons
	val dummyDebugVar = Absyn.LITexp(Absyn.SCONlit("-", ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo))
	val dummyMatch = Absyn.LITexp(Absyn.SCONlit("<- match", ref(Absyn.dummyInfo)), 
								  ref(Absyn.dummyInfo))
								  
    fun getStrNr(x) =
		if (x < 10) 
		then Int.toString(0)^Int.toString(x)
		else Int.toString(x)
		
	fun getPush(direction, arity)
		= Absyn.LONGID(
			modidRML, 
			Absyn.rmlIdent ("debug_push_"^direction^getStrNr(arity)), 
			ref(Absyn.dummyInfo))
	
	fun makeTuple(x, y) = Absyn.STRUCTexp(NONE, x :: y, ref(Absyn.dummyInfo))
	fun makeSingleTuple(x) = Absyn.STRUCTexp(NONE, x, ref(Absyn.dummyInfo))
	
	fun addDummyParams(foo, nelts) =
		if (nelts = 0) 
		then foo 
		else addDummyParams(foo @ [makeTuple(dummyDebugVar, [dummyDebugVar])], nelts-1) (* add one more to the list *)

	(* check if we have more than 32 parameters to show *)
    fun checkParams(foo) = 
    let val llength = List.length foo
    in
		if (llength > 32)
		then
			bug("checkParams: this debugger handles only 32 variables between goals")
		else
			[makeSingleTuple(addDummyParams(foo, 32-llength))]
	end      		

    fun getExpAsString(Absyn.LITexp(lit, _)) = (Absyn.litString lit)
      | getExpAsString(Absyn.CONexp(longid, _)) = (print_longid(longid))
      | getExpAsString(Absyn.VARexp(longid, _)) = (print_longid(*_info*)(longid))
      | getExpAsString(Absyn.STRUCTexp(
				SOME(Absyn.LONGID(SOME(Absyn.IDENT("RML", _)), Absyn.IDENT("cons", _), _)), exp_star, _)) =
						(print_list_comma_exp(exp_star, getExpAsString))      
      | getExpAsString(Absyn.STRUCTexp(ctor, exp_star, _)) =
				(print_ctor_opt(ctor)^print_parens_comma(exp_star, getExpAsString))				
      | getExpAsString(Absyn.IDENTexp(longid, _, _)) = (print_longid(*_info*)(longid))

	fun getExpAST(exp) = 
		Absyn.LITexp(Absyn.SCONlit(getExpAsString(exp), ref(Absyn.dummyInfo)),
			ref(Absyn.dummyInfo))

	fun makeTupleList(nil, func) = []
		| makeTupleList(foo::nil, func) = [makeTuple(func(foo), [foo])]
		| makeTupleList(foo::rest, func) = 
			[makeTuple(func(foo), [foo])] @ makeTupleList(rest, func) 						
		
	(*
    fun printVars(foo) = 
		Absyn.CALLgoal(
			show, 
			checkParams(makeTupleList(foo, getExpAST)), 
			[], 
			ref(Absyn.dummyInfo))
	*)

	fun makeParamList(nil, func) = []
		| makeParamList(foo::nil, func) = [func(foo), foo]
		| makeParamList(foo::rest, func) = 
			[func(foo), foo] @ makeParamList(rest, func) 							
	
    fun printVars(foo, direction) =
    let val llength = List.length foo
    in
		if llength = 0
		then Absyn.CALLgoal(getPush(direction, 1), [dummyDebugVar, dummyDebugVar], 
			 [], ref(Absyn.dummyInfo))
		else
			if llength < 17
			then Absyn.CALLgoal(getPush(direction, llength), makeParamList(foo, getExpAST), 
				[], ref(Absyn.dummyInfo))
			else Absyn.ANDgoal(
					printVars(List.take(foo, 16), direction),
					printVars(List.drop(foo, 16), direction),
					ref(Absyn.dummyInfo))
	end

    fun getPatAsString(Absyn.WILDpat _) = ("_")
      | getPatAsString(Absyn.LITpat(lit, _)) = print_lit(lit)
      | getPatAsString(Absyn.CONpat(longcon, _)) = print_longid(longcon)
      (*| getPatAsString(Absyn.STRUCTpat(
				SOME(Absyn.LONGID(SOME(Absyn.IDENT("RML", _)), Absyn.IDENT("cons", _), _)), pat_star, _)) =
						(print_list_comma_pat(pat_star, getPatAsString)) *)
      | getPatAsString(Absyn.STRUCTpat(ctor, pat_star, _)) =
		(print_ctor_opt(ctor)^print_parens_comma(pat_star, getPatAsString))
      | getPatAsString(Absyn.BINDpat(var, pat, _)) =
		(print_ident(var)^" as "^getPatAsString(pat))
      | getPatAsString(Absyn.IDENTpat(id, _, _)) = print_ident(id)

    fun getExpsFromPat(Absyn.WILDpat _) = []
      | getExpsFromPat(Absyn.LITpat(lit, infoLIT)) = [Absyn.LITexp(lit, infoLIT)]
      | getExpsFromPat(Absyn.CONpat(longcon, infoCON)) = [Absyn.CONexp(longcon, infoCON)]
      | getExpsFromPat(Absyn.STRUCTpat(ctor, pat_star, _)) = getExpsFromPatStar pat_star
      | getExpsFromPat(Absyn.BINDpat(var, pat, infoBIND)) = 
			Absyn.IDENTexp(Absyn.LONGID(NONE, var, ref(Absyn.dummyInfo)), 
				ref(Absyn.STRUCTexp(NONE, [], ref(Absyn.dummyInfo))),
				infoBIND)::(getExpsFromPat pat)
      | getExpsFromPat(Absyn.IDENTpat(id as Absyn.IDENT(_, infoID), _, infoIDENT)) = 
			[Absyn.IDENTexp(Absyn.LONGID(NONE, id, infoID), 
			 ref(Absyn.STRUCTexp(NONE, [], ref(Absyn.dummyInfo))),
			 infoIDENT)]
	and getExpsFromPatStar(foo::foo_star) = getExpsFromPat(foo) @ (getExpsFromPatStar foo_star)
	  | getExpsFromPatStar(nil) = []
					
    fun printPats(foo, direction) = printVars(getExpsFromPatStar foo, direction)
    	
    fun getResultExps(Absyn.RETURN(exps, _)) = (exps)
      | getResultExps(Absyn.FAIL (_)) = 
			[Absyn.LITexp(
				Absyn.SCONlit("fail", ref(Absyn.dummyInfo)),
				ref(Absyn.dummyInfo))]

    fun getPositionFromResult(Absyn.RETURN(exps, ref(Absyn.INFO(_, _, _, locRETURN)))) = (locRETURN)
      | getPositionFromResult(Absyn.FAIL (ref(Absyn.INFO(_, _,_, locFAIL)))) = (locFAIL)
						
	fun makeExp(
			relIdent as Absyn.IDENT(stringIdent, _), 
			ref(Absyn.LOC(sline, scolumn, eline, ecolumn)), 
			strGoal) =
		[Absyn.LITexp(Absyn.SCONlit(fileName, ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)),
		 Absyn.LITexp(Absyn.ICONlit(sline, ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)),
		 Absyn.LITexp(Absyn.ICONlit(scolumn, ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)),		 
		 Absyn.LITexp(Absyn.ICONlit(eline,ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)),
		 Absyn.LITexp(Absyn.ICONlit(ecolumn,ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)),		 
		 Absyn.LITexp(Absyn.SCONlit(stringIdent, ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo)),
		 Absyn.LITexp(Absyn.SCONlit(strGoal, ref(Absyn.dummyInfo)), ref(Absyn.dummyInfo))] 
		 
	(* adrpo added 2004-11-20 *)
	(* only instrument in front, needed for last goal in a rulse
	   instrumentation which should not be instrumented after the goal (tail recursiveness) *)
    fun instrumentGoalOnlyInFront(
   		Absyn.CALLgoal(longid, exp_star, pat_star, infoCALL as ref(Absyn.INFO(filename, startpos, endpos, locCALL))), 
		relIdent, result) = 
	    Absyn.ANDgoal(
			if List.length exp_star > 0
			then
			Absyn.ANDgoal(
				printVars(exp_star, "in"), (* push in variables of next goal *)
				Absyn.CALLgoal(
					debug, 
					makeExp(
						relIdent, 
						locCALL,
						"call:"^print_longid(longid)^
						print_parens_comma(exp_star, getExpAsString)^" => "
						^print_parens_comma(pat_star, getPatAsString)), 
						[],
						ref(Absyn.dummyInfo)), 
				ref(Absyn.dummyInfo))
			else
				Absyn.CALLgoal(
					debug, 
					makeExp(
						relIdent, 
						locCALL,
						"call:"^print_longid(longid)^
						print_parens_comma(exp_star, getExpAsString)^" => "
						^print_parens_comma(pat_star, getPatAsString)), 
						[],
						ref(Absyn.dummyInfo)),
			Absyn.CALLgoal(longid, exp_star, pat_star, infoCALL), 
			ref(Absyn.dummyInfo)) 
      | instrumentGoalOnlyInFront(Absyn.EQUALgoal(
								var1, 
								exp2, 
								infoEQUAL as ref(Absyn.INFO(filename, startpos, endpos, locEQUAL))), 
						relIdent, result) =
	    Absyn.ANDgoal(
		 Absyn.ANDgoal(
			Absyn.CALLgoal(debug, 
				makeExp(relIdent, locEQUAL, 
					"equal:"^print_ident(var1)^"="^getExpAsString(exp2)), 
				[],	ref(Absyn.dummyInfo)),
			printVars([
				Absyn.IDENTexp(Absyn.LONGID(NONE,var1, ref(Absyn.dummyInfo)), 
				ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))), 
				ref(Absyn.dummyInfo)), exp2], "in"),
			ref(Absyn.dummyInfo)),				
		 Absyn.EQUALgoal(var1, exp2, infoEQUAL),
		 ref(Absyn.dummyInfo))
      | instrumentGoalOnlyInFront(
			Absyn.LETgoal(
				pat, 
				exp, 
				infoLET as ref(Absyn.INFO(filename, startpos, endpos, locLET))), 
				relIdent, result) =
	    Absyn.ANDgoal(
			Absyn.CALLgoal(
				debug, 
				makeExp(relIdent, locLET, "let:"^getPatAsString(pat)^"="^getExpAsString(exp)), 
				[],
				ref(Absyn.dummyInfo)),
			Absyn.LETgoal(pat, exp, infoLET), 
			ref(Absyn.dummyInfo) )
      | instrumentGoalOnlyInFront(
			Absyn.NOTgoal(
				g, 
				infoNOT as ref(Absyn.INFO(filename, startpos, endpos, locNOT))), 
				relIdent, result) =
	    Absyn.ANDgoal(
			Absyn.CALLgoal(
				debug, 
				makeExp(relIdent, locNOT, "not:"), 
				[],
				ref(Absyn.dummyInfo)),
			Absyn.NOTgoal(
				(* instrumentGoalOnlyInFront(g, relIdent, result), *)
				g,
				infoNOT),
			ref(Absyn.dummyInfo))
	  (* this shouldn't happen, but let's be safe *)
      | instrumentGoalOnlyInFront(Absyn.ANDgoal(g1,g2,infoAND), relIdent, result) =  
			(
			 bug("instrumentGoalOnlyInFront: [warning] ANDgoal found when it shouldn't be there!\n"); 
			 Absyn.ANDgoal(g1, g2,ref(Absyn.dummyInfo))
			)				  		 

    fun instrumentGoal(
		Absyn.CALLgoal(longid, exp_star, pat_star, infoCALL as ref(Absyn.INFO(filename, startpos, endpos, locCALL))), 
		relIdent, result) =
	    Absyn.ANDgoal(
			if (List.length exp_star > 0)
			then 
			Absyn.ANDgoal(
				printVars(exp_star,"in"),			
				Absyn.CALLgoal(
					debug, 
					makeExp(
						relIdent, 
						locCALL,
						"call:"^print_longid(longid)^
						print_parens_comma(exp_star, getExpAsString)^" => "
						^print_parens_comma(pat_star, getPatAsString)), 
						[],
						ref(Absyn.dummyInfo)), 
				ref(Absyn.dummyInfo))
			else 
				Absyn.CALLgoal(
					debug, 
					makeExp(
						relIdent, 
						locCALL,
						"call:"^print_longid(longid)^
						print_parens_comma(exp_star, getExpAsString)^" => "
						^print_parens_comma(pat_star, getPatAsString)), 
						[],
						ref(Absyn.dummyInfo)),
			(if List.length pat_star > 0
			then Absyn.ANDgoal(
					Absyn.CALLgoal(longid, exp_star, pat_star, infoCALL),
						printPats(pat_star,"out"),
						ref(Absyn.dummyInfo))
			else Absyn.CALLgoal(longid, exp_star, pat_star, infoCALL)), 
			ref(Absyn.dummyInfo) )
      | instrumentGoal(Absyn.EQUALgoal(
								var1, 
								exp2, 
								infoEQUAL as ref(Absyn.INFO(filename, startpos, endpos, locEQUAL))), 
						relIdent, result) =
	    Absyn.ANDgoal(
		 Absyn.ANDgoal(
			Absyn.CALLgoal(debug, 
				makeExp(relIdent, locEQUAL, 
					"equal:"^print_ident(var1)^"="^getExpAsString(exp2)), 
				[],	ref(Absyn.dummyInfo)),
			printVars([
				Absyn.IDENTexp(Absyn.LONGID(NONE, var1, ref(Absyn.dummyInfo)), 
				ref(Absyn.STRUCTexp(NONE,[], ref(Absyn.dummyInfo))), 
				ref(Absyn.dummyInfo)), exp2], "in"),
			ref(Absyn.dummyInfo)),				
		 Absyn.EQUALgoal(var1, exp2, infoEQUAL),
		 ref(Absyn.dummyInfo))
      | instrumentGoal(
			Absyn.LETgoal(
				pat, 
				exp, 
				infoLET as ref(Absyn.INFO(filename, startpos, endpos, locLET))), 
				relIdent, result) =
	    Absyn.ANDgoal(
			Absyn.CALLgoal(
				debug, 
				makeExp(relIdent, locLET, "let:"^getPatAsString(pat)^"="^getExpAsString(exp)), 
				[],
				ref(Absyn.dummyInfo)),
			Absyn.ANDgoal(
				Absyn.LETgoal(pat, exp, infoLET), 
				Absyn.ANDgoal(
					printPats([pat], "out"), 
					printVars([exp], "out"), ref(Absyn.dummyInfo)),
				ref(Absyn.dummyInfo) ), 
			ref(Absyn.dummyInfo) )
      | instrumentGoal(
			Absyn.NOTgoal(
				g, 
				infoNOT as ref(Absyn.INFO(filename, startpos, endpos, locNOT))), 
				relIdent, result) =
	    Absyn.ANDgoal(
			Absyn.CALLgoal(
				debug, 
				makeExp(relIdent, locNOT, "not:"), 
				[],
				ref(Absyn.dummyInfo)),
			Absyn.NOTgoal(
				(*instrumentGoal(g, relIdent, result), *)
				g,
				infoNOT),
			ref(Absyn.dummyInfo))	  
      | instrumentGoal(Absyn.ANDgoal(g1, g2 as Absyn.ANDgoal(g3, g4, _), infoAND), relIdent, result) =
      		Absyn.ANDgoal(
      			instrumentGoal(g1, relIdent, result), 
      			instrumentGoal(g2, relIdent, result),
      			infoAND)      		
      | instrumentGoal(
			Absyn.ANDgoal(
				g1, 
				g2, 
				infoAND), 
				relIdent, 
				result) =  
			Absyn.ANDgoal(
      				instrumentGoal(g1, relIdent, result), 
					instrumentGoalOnlyInFront(g2, relIdent, result),
					ref(Absyn.dummyInfo))
		(* adrpo 2004-11-20 result shouldn't be displayed as it will interfere with recursive tailcall 
		   XXX fix to be only if last is Absyn.CALLgoal(relname, xxx)  			
			let val locRESULT = getPositionFromResult(result)
				val result_exp = getResultExps result
			in 
      			Absyn.ANDgoal(
      				instrumentGoal(g1, relIdent, result), 
      				Absyn.ANDgoal(
      					instrumentGoal(g2, relIdent, result),
      					Absyn.ANDgoal(
							Absyn.CALLgoal(
								debug, 
								makeExp(
									relIdent, 
									locRESULT, 
									"return:"^print_parens_comma(result_exp, getExpAsString)), 
									[], 
									ref(Absyn.dummyInfo)),
							printVars(result_exp),
							ref(Absyn.dummyInfo)),
						ref(Absyn.dummyInfo)),
      				ref(Absyn.dummyInfo))
			end
			*)
			
    fun instrumentGoals(NONE, relIdent as Absyn.IDENT(stringIdent, _), locGOAL, pat_star, result) = 
		let val resultExps = getResultExps result 
		in
		SOME(
			 if List.length resultExps > 0
			 then
			 Absyn.ANDgoal(
				if List.length pat_star > 0 andalso List.length (getExpsFromPatStar pat_star) > 0
				then
				Absyn.ANDgoal(
					printPats(pat_star,"in"), 	
					Absyn.CALLgoal(
						debug, 
						makeExp(relIdent, locGOAL, 
							"axiom:"^stringIdent^
							 print_parens_comma(pat_star, getPatAsString)^" => "^
							 print_parens_comma(getResultExps result, getExpAsString)), 
						[],
						ref(Absyn.dummyInfo)),
					ref(Absyn.dummyInfo))
				else
					Absyn.CALLgoal(
						debug, 
						makeExp(relIdent, locGOAL, 
							"axiom:"^stringIdent^
							 print_parens_comma(pat_star, getPatAsString)^" => "^
							 print_parens_comma(resultExps, getExpAsString)), 
						[],
						ref(Absyn.dummyInfo)),
				printVars(resultExps, "out"),
				ref(Absyn.dummyInfo))
			else
				if List.length pat_star > 0
				then
				Absyn.ANDgoal(
					printPats(pat_star,"in"), 	
					Absyn.CALLgoal(
						debug, 
						makeExp(relIdent, locGOAL, 
							"axiom:"^stringIdent^
							 print_parens_comma(pat_star, getPatAsString)^" => "^
							 print_parens_comma(getResultExps result, getExpAsString)), 
						[],
						ref(Absyn.dummyInfo)),
					ref(Absyn.dummyInfo))
				else
					Absyn.CALLgoal(
						debug, 
						makeExp(relIdent, locGOAL, 
							"axiom:"^stringIdent^
							 print_parens_comma(pat_star, getPatAsString)^" => "^
							 print_parens_comma(resultExps, getExpAsString)), 
						[],
						ref(Absyn.dummyInfo))
		)
		end
	  | instrumentGoals(SOME goal, relIdent, locGOAL, pat_star, result) = 
		SOME(instrumentGoal(goal, relIdent, result))
			(*Absyn.ANDgoal(
					printPats(pat_star, "in"),		
					instrumentGoal(goal, relIdent, result),
					ref(Absyn.dummyInfo)))*)

    fun instrumentClause(
			Absyn.CLAUSE1(
				g_opt, 
				id,
				pat_star, result,
				infoCLAUSE1 as ref(Absyn.INFO(_, _, _, locCLAUSE1))), 
				relIdent) =
		Absyn.CLAUSE1(
			instrumentGoals(
				g_opt, 
				relIdent, 
				locCLAUSE1, 
				pat_star, 
				result), 
			id, pat_star, result, infoCLAUSE1)
      | instrumentClause(Absyn.CLAUSE2(cl1,cl2, infoCLAUSE2), relIdent) =
	    Absyn.CLAUSE2(
			instrumentClause(cl1, relIdent), 
			instrumentClause(cl2, relIdent),
			infoCLAUSE2)
       
    fun instrumentRel(Absyn.RELBIND(ident, ty_op, clause, infoRELBIND)) = 
       Absyn.RELBIND(ident, ty_op, instrumentClause(clause, ident), infoRELBIND)
    
    fun instrumentDec(Absyn.RELdec(rels, infoREL)) = Absyn.RELdec(map instrumentRel rels, infoREL)
      | instrumentDec dec = dec 

    fun instrumentModule(Absyn.MODULE(
		interface, 
		declarations, infoMODULE)) =
      Absyn.MODULE(interface, map instrumentDec declarations, infoMODULE)
      in 
		let val m = instrumentModule m
		in
			m
		end
	  end 
  end (* functor InstrumentFn *)
