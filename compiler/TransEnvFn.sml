(* foltocps/transenv.sml *)

functor TransEnvFn(structure Util : UTIL
		   structure StrDict : STR_DICT
		   structure CPS : CPS
		     ) : TRANSENV =
  struct

    structure StrDict	= StrDict
    structure ConRep	= CPS.ConRep
    structure CPS	= CPS

    datatype translation= DEF of {def: CPS.def, tieknot: unit->unit}
			| LIT of CPS.literal
			| CON of {rep: ConRep.conrep, nrcons: int}
			| VAR of CPS.trivexp

    fun bug s = Util.bug("TransEnv."^s)

    fun unary_arg [x]	= x
      | unary_arg _	= bug "unary_arg"

    fun binary_args[x,y]= (x,y)
      | binary_args _	= bug "binary_args"

    (* This is a bloody awful hack! *)

    fun new_var() =
      let val (var as CPS.VAR{uses,...}) = CPS.newVar()
      in
	uses := 10;
	var
      end

    fun mk_unary_inliner unop =
      fn{args, fc=_, sc} =>
	let val varx = new_var()
	    and varz = new_var()
	    val e = CPS.LETe(varx, unary_arg args,
		    CPS.mkPRIMe(varz, CPS.UNARYp(unop, CPS.mkVARte varx),
		    CPS.mkAppSCe{sc=sc,args=[CPS.mkVARte varz]}))
	in
	  SOME e
	end

    val int_int_inliner =
      fn{args, fc=_, sc} =>
	let val varx = new_var()
	    val e = CPS.LETe(varx, unary_arg args,
		    CPS.mkAppSCe{sc=sc,args=[CPS.mkVARte varx]})
	in
	  SOME e
	end

    fun mk_binary_inliner binop =
      fn{args, fc=_, sc} =>
	let val varx = new_var()
	    and vary = new_var()
	    and varz = new_var()
	    and (arg1,arg2) = binary_args args
	    val e = CPS.LETe(varx, arg1,
		    CPS.mkLETe(vary, arg2,
		    CPS.mkPRIMe(varz, CPS.BINARYp(binop,CPS.mkVARte varx,CPS.mkVARte vary),
		    CPS.mkAppSCe{sc=sc,args=[CPS.mkVARte varz]})))
	in
	  SOME e
	end

    fun mk_divmod_inliner binop =
      fn{args, fc, sc} =>
	let val varx = new_var()
	    and vary = new_var()
	    and varz = new_var()
	    val valx = CPS.mkVARte varx
	    and valy = CPS.mkVARte vary	
	    and valz = CPS.mkVARte varz
	    and (arg1,arg2) = binary_args args
	    val e0 = CPS.mkLETe(varx, arg1,
		     CPS.mkPRIMe(varz, CPS.BINARYp(binop,valx,valy),
		     CPS.mkAppSCe{sc=sc,args=[valz]}))
	    val e = CPS.LETe(vary, arg2,
		    CPS.mkSWITCHe(valy,
				  [(CPS.INTcon 0,
				    CPS.mkAppFCe fc)],
				  SOME e0))
	in
	  SOME e
	end

    val tenv0 =
      let fun bind(te, name, proc) =
	    StrDict.insert(te, name, LIT(CPS.PROClit proc))
	  fun extern(te, name) =
	    bind(te, name, CPS.EXTERN_REL(CPS.LONGID{module="RML", name=name}, NONE))
	  fun inline(te, name, inliner) =
	    bind(te, name, CPS.EXTERN_REL(CPS.LONGID{module="RML", name=name}, SOME inliner))
	  val te = StrDict.empty
	  (* booleans *)
	  val te = StrDict.insert(te, "false", CON{rep=ConRep.INT 0, nrcons=2})
	  val te = StrDict.insert(te, "true", CON{rep=ConRep.INT 1, nrcons=2})
	  val te = inline(te, "bool_and", mk_binary_inliner CPS.BOOL_AND)
	  val te = inline(te, "bool_not", mk_unary_inliner CPS.BOOL_NOT)
	  val te = inline(te, "bool_or", mk_binary_inliner CPS.BOOL_OR)
	  (* options *)
	  val te = StrDict.insert(te, "NONE", CON{rep=ConRep.BOX{arity=0,tag=0}, nrcons=2})
	  val te = StrDict.insert(te, "SOME", CON{rep=ConRep.BOX{arity=1,tag=1}, nrcons=2})
	  (* characters *)
	  val te = inline(te, "char_int", int_int_inliner)
	  val te = inline(te, "int_char", int_int_inliner)
	  (* strings *)
	  val te = extern(te, "string_int")
	  val te = extern(te, "string_list")
	  val te = extern(te, "list_string")
	  val te = extern(te, "string_length")
	  val te = extern(te, "string_nth")
	  val te = extern(te, "string_append")
	  (* immutable vectors *)
	  val te = extern(te, "vector_length")
	  val te = extern(te, "vector_nth")
	  val te = extern(te, "vector_list")
	  val te = extern(te, "list_vector")
	  val te = extern(te, "vector_setnth")
	  val te = extern(te, "vector_update")	  
	  val te = extern(te, "vector_create")
      val te = extern(te, "vector_add")
      val te = extern(te, "vector_array")

	  (* mutable arrays *)
	  val te = extern(te, "array_length")
	  val te = extern(te, "array_nth")
	  val te = extern(te, "array_list")
	  val te = extern(te, "list_array")
	  val te = extern(te, "array_setnth")
	  val te = extern(te, "array_update")	  
	  val te = extern(te, "array_create")
      val te = extern(te, "array_add")	  
      val te = extern(te, "array_vector")
      	  
	  (* integers *)
	  val te = inline(te, "int_add", mk_binary_inliner CPS.INT_ADD)
	  val te = inline(te, "int_sub", mk_binary_inliner CPS.INT_SUB)
	  val te = inline(te, "int_mul", mk_binary_inliner CPS.INT_MUL)
	  val te = inline(te, "int_div", mk_divmod_inliner CPS.INT_DIV)
	  val te = inline(te, "int_mod", mk_divmod_inliner CPS.INT_MOD)
	  val te = inline(te, "int_abs", mk_unary_inliner CPS.INT_ABS)
	  val te = inline(te, "int_neg", mk_unary_inliner CPS.INT_NEG)
	  val te = inline(te, "int_max", mk_binary_inliner CPS.INT_MAX)
	  val te = inline(te, "int_min", mk_binary_inliner CPS.INT_MIN)
	  val te = inline(te, "int_lt", mk_binary_inliner CPS.INT_LT)
	  val te = inline(te, "int_le", mk_binary_inliner CPS.INT_LE)
	  val te = inline(te, "int_eq", mk_binary_inliner CPS.INT_EQ)
	  val te = inline(te, "int_ne", mk_binary_inliner CPS.INT_NE)
	  val te = inline(te, "int_ge", mk_binary_inliner CPS.INT_GE)
	  val te = inline(te, "int_gt", mk_binary_inliner CPS.INT_GT)
	  val te = extern(te, "int_real")
	  val te = extern(te, "int_string")
	  (* reals *)
	  val te = extern(te, "real_add")
	  val te = extern(te, "real_sub")
	  val te = extern(te, "real_mul")
	  val te = extern(te, "real_div")
	  val te = extern(te, "real_mod")
	  val te = extern(te, "real_abs")
	  val te = extern(te, "real_neg")
	  val te = extern(te, "real_cos")
	  val te = extern(te, "real_sin")
	  val te = extern(te, "real_atan")
	  val te = extern(te, "real_exp")
	  val te = extern(te, "real_ln")
	  val te = extern(te, "real_floor")
	  val te = extern(te, "real_int")
	  val te = extern(te, "real_pow")
	  val te = extern(te, "real_sqrt")
	  val te = extern(te, "real_max")
	  val te = extern(te, "real_min")
	  val te = extern(te, "real_lt")
	  val te = extern(te, "real_le")
	  val te = extern(te, "real_eq")
	  val te = extern(te, "real_ne")
	  val te = extern(te, "real_ge")
	  val te = extern(te, "real_gt")
	  val te = extern(te, "real_string")
	  (* lists *)
	  val te = StrDict.insert(te, "nil", CON{rep=ConRep.BOX{arity=0,tag=0}, nrcons=2})
	  val te = StrDict.insert(te, "cons", CON{rep=ConRep.BOX{arity=2,tag=1}, nrcons=2})
	  val te = extern(te, "list_append")
	  val te = extern(te, "list_reverse")
	  val te = extern(te, "list_length")
	  val te = extern(te, "list_member")
	  val te = extern(te, "list_nth")
	  val te = extern(te, "list_delete")
	  (* logical variables *)
	  val te = extern(te, "lvar_get")
	  val te = extern(te, "lvar_new")
	  val te = extern(te, "lvar_set")
	  (* misc *)
	  val te = extern(te, "clock")
	  val te = extern(te, "print")
	  val te = extern(te, "tick")
	  (* debug *)
	  val te = extern(te, "debug")
	  val te = extern(te, "debug_print")
	  val te = extern(te, "debug_push_vars")
	  (* specific methods for dealing with different parameter arity *)
	  val te = extern(te, "debug_push_in01")
	  val te = extern(te, "debug_push_in02")
	  val te = extern(te, "debug_push_in03")
	  val te = extern(te, "debug_push_in04")
	  val te = extern(te, "debug_push_in05")
	  val te = extern(te, "debug_push_in06")
	  val te = extern(te, "debug_push_in07")
	  val te = extern(te, "debug_push_in08")
	  val te = extern(te, "debug_push_in09")
	  val te = extern(te, "debug_push_in10")
	  val te = extern(te, "debug_push_in11")
	  val te = extern(te, "debug_push_in12")
	  val te = extern(te, "debug_push_in13")
	  val te = extern(te, "debug_push_in14")
	  val te = extern(te, "debug_push_in15")
	  val te = extern(te, "debug_push_in16")
	  (* specific methods for dealing with different parameter arity *)
	  val te = extern(te, "debug_push_out01")
	  val te = extern(te, "debug_push_out02")
	  val te = extern(te, "debug_push_out03")
	  val te = extern(te, "debug_push_out04")
	  val te = extern(te, "debug_push_out05")
	  val te = extern(te, "debug_push_out06")
	  val te = extern(te, "debug_push_out07")
	  val te = extern(te, "debug_push_out08")
	  val te = extern(te, "debug_push_out09")
	  val te = extern(te, "debug_push_out10")
	  val te = extern(te, "debug_push_out11")
	  val te = extern(te, "debug_push_out12")
	  val te = extern(te, "debug_push_out13")
	  val te = extern(te, "debug_push_out14")
	  val te = extern(te, "debug_push_out15")
	  val te = extern(te, "debug_push_out16")
	  
	  
      in
		te
      end

    val menv0 = StrDict.insert(StrDict.empty, "RML", tenv0)

  end (* functor TransEnvFn *)
