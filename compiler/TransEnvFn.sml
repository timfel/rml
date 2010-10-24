(* foltocps/transenv.sml *)

functor TransEnvFn(structure Util : UTIL
       structure StrDict : STR_DICT
       structure CPS : CPS
         ) : TRANSENV =
  struct

    structure StrDict  = StrDict
    structure ConRep  = CPS.ConRep
    structure CPS    = CPS

    datatype translation = DEF of {def: CPS.def, tieknot: unit->unit}
             | LIT of CPS.literal
             | CON of {rep: ConRep.conrep, nrcons: int}
             | VAR of CPS.trivexp

    fun bug s = Util.bug("TransEnv."^s)

    fun unary_arg [x]  = x
      | unary_arg _  = bug "unary_arg"

    fun binary_args [x,y]= (x,y)
      | binary_args _  = bug "binary_args"

    (* This is a bloody awful hack! *)
    fun new_var() =
      let val (var as CPS.VAR{uses,...}) = CPS.newVar(CPS.dummyLongIdent)
      in
       uses := 10;
       var
      end

    fun mk_unary_inliner unop =
      fn{args, fc=_, sc} =>
       let val pos = CPS.ConRep.dummyInfo
           val name = CPS.ConRep.dummyLongIdent
           val varx = new_var()
           and varz = new_var()
           val e = CPS.LETe(varx, unary_arg args,
                     CPS.mkPRIMe(varz, CPS.UNARYp(unop, CPS.mkVARte varx),
                     CPS.mkAppSCe{sc=sc,args=[CPS.mkVARte varz], name=name, pos=pos}))
       in
         SOME e
       end
    
    val int_int_inliner =
      fn{args, fc=_, sc} =>
        let val pos = CPS.ConRep.dummyInfo
            val name = CPS.ConRep.dummyLongIdent    
            val varx = new_var()
            val e = CPS.LETe(varx, unary_arg args,
                      CPS.mkAppSCe{sc=sc,args=[CPS.mkVARte varx], name=name, pos=pos})
        in
          SOME e
        end
    
    fun mk_binary_inliner binop =
      fn{args, fc=_, sc} =>
        let val pos = CPS.ConRep.dummyInfo
            val name = CPS.ConRep.dummyLongIdent    
            val varx = new_var()
            and vary = new_var()
            and varz = new_var()
            and (arg1,arg2) = binary_args args
            val e = CPS.LETe(varx, arg1,
                      CPS.mkLETe(vary, arg2,
                        CPS.mkPRIMe(varz, CPS.BINARYp(binop,CPS.mkVARte varx,CPS.mkVARte vary),
                        CPS.mkAppSCe{sc=sc,args=[CPS.mkVARte varz], name=name, pos=pos})))
            in
              SOME e
            end
    
    fun mk_divmod_inliner binop =
      fn{args, fc, sc} =>
        let val pos = CPS.ConRep.dummyInfo
            val name = CPS.ConRep.dummyLongIdent    
            val varx = new_var()
            and vary = new_var()
            and varz = new_var()
            val valx = CPS.mkVARte varx
            and valy = CPS.mkVARte vary  
            and valz = CPS.mkVARte varz
            and (arg1,arg2) = binary_args args
            val e0 = CPS.mkLETe(varx, arg1,
                       CPS.mkPRIMe(varz, CPS.BINARYp(binop,valx,valy),
                       CPS.mkAppSCe{sc=sc,args=[valz],name=name,pos=pos}))
            val e = CPS.LETe(vary, arg2, 
                      CPS.mkSWITCHe(
                         valy, 
                         [(CPS.INTcon 0, CPS.mkAppFCe{fc=fc,name=name,pos=pos})], 
                         SOME e0))
        in
          SOME e
        end
    
    fun mkId(str) = CPS.makeIdent(str, CPS.dummyInfo)
    fun mkLongId(str1, str2) = ConRep.LONGID{module=SOME(mkId(str1)), name=mkId(str2)}

    val tenv0 =
    let 
      fun bind(te, name, proc) = 
        StrDict.insert(te, name, LIT(CPS.PROClit proc))
      
      fun extern(te, name) =
        bind(te, 
             name, 
             CPS.EXTERN_REL(
               ConRep.LONGID{module=SOME(mkId("RML")), name=mkId(name)}, 
               NONE))
      
      fun inline(te, name, inliner) =
        bind(te, 
             name, 
             CPS.EXTERN_REL(
               ConRep.LONGID{module=SOME(mkId("RML")), name=mkId(name)}, 
               SOME inliner))
      
      fun extern2(te, name1, name2) = 
        let val te = extern(te, name1) 
            val te = extern(te, name2)
        in
          te
        end
      
      fun inline2(te, name1, name2, inliner) = 
        let val te = inline(te, name1, inliner)
            val te = inline(te, name2, inliner)
        in
          te
        end
      
      val te = StrDict.empty

      (* options *)
      val te = StrDict.insert(te, 
                              "NONE", 
                              CON{rep=ConRep.BOX{arity=0,tag=0,name=mkLongId("RML", "NONE")}, 
                              nrcons=2})
      
      val te = StrDict.insert(te, 
                              "SOME", 
                              CON{rep=ConRep.BOX{arity=1,tag=1,name=mkLongId("RML", "SOME")}, 
                              nrcons=2})

      (* misc functions *)
      val te = extern(te, "clock")
      val te = extern(te, "print")
      val te = extern(te, "tick")
      val te = extern(te, "unique")
      
      (* roots *)
      val te = extern2(te, "set_global_root",   "setGlobalRoot")
      val te = extern2(te, "get_global_root",   "getGlobalRoot")

      (* references *)
      val te = inline2(te, "reference_eq",      "referenceEq",      mk_binary_inliner CPS.REF_EQ)
      val te = inline2(te, "reference_integer", "referenceInteger", mk_unary_inliner CPS.REF_INT)
      val te = extern2(te, "reference_update",  "referenceUpdate")
      val te = extern2(te, "reference_setnth",  "referenceSetNth")
      val te = extern2(te, "reference_share",   "referenceShare")
      
      (* values *)
      val te = inline2(te, "value_constructor", "valueConstructor", mk_unary_inliner  CPS.VAL_CONSTR)
      val te = inline2(te, "value_slots",       "valueSlots",       mk_unary_inliner  CPS.VAL_SLOTS)
      val te = inline2(te, "value_eq",          "valueEq",          mk_binary_inliner CPS.VAL_EQ)
      val te = inline2(te, "value_match",       "valueMatch",       mk_binary_inliner CPS.VAL_MATCH)

      (* if expressions *)
      val te = extern2(te, "if_exp", "ifExp")

      (* booleans *)
      val te = StrDict.insert(te, "false", CON{rep=ConRep.INT 0, nrcons=2})
      val te = StrDict.insert(te, "true",  CON{rep=ConRep.INT 1, nrcons=2})

      val te = inline2(te, "bool_and", "boolAnd", mk_binary_inliner CPS.BOOL_AND)
      val te = inline2(te, "bool_not", "boolNot", mk_unary_inliner CPS.BOOL_NOT)
      val te = inline2(te, "bool_or",  "boolOr",  mk_binary_inliner CPS.BOOL_OR)
      val te = inline2(te, "bool_eq",  "boolEq",  mk_binary_inliner CPS.BOOL_EQ)

      (* characters *)
      val te = inline2(te, "char_int", "charInt", int_int_inliner)
      val te = inline2(te, "int_char", "intChar", int_int_inliner)
      val te = inline2(te, "char_eq",  "charEq",  mk_binary_inliner CPS.CHAR_EQ)
      
      (* string characters *)
      val te = extern2(te, "string_char_int", "stringCharInt")
      val te = extern2(te, "int_string_char", "intStringChar")

      (* strings *)
      val te = extern2(te, "string_append",             "stringAppend")
      val te = extern2(te, "string_int",                "stringInt")
      val te = extern2(te, "string_list",               "stringList")
      val te = extern2(te, "string_length",             "stringLength")
      val te = extern2(te, "string_nth",                "stringNth")
      val te = extern2(te, "string_nth_string_char",    "stringNthStringChar")
      val te = extern2(te, "string_get",                "stringGet")
      val te = extern2(te, "string_get_string_char",    "stringGetStringChar")
      val te = extern2(te, "string_setnth",             "stringSetNth")
      val te = extern2(te, "string_setnth_string_char", "stringSetNthStringChar")
      val te = extern2(te, "string_update",             "stringUpdate")
      val te = extern2(te, "string_update_string_char", "stringUpdateStringChar")
      val te = extern2(te, "string_compare",            "stringCompare")
      val te = extern2(te, "string_append_list",        "stringAppendList")
      val te = inline2(te, "string_equal",              "stringEqual",    mk_binary_inliner CPS.STRING_EQ)
      val te = inline2(te, "string_eq",                 "stringEq",       mk_binary_inliner CPS.STRING_EQ)
      (* hash functions *)
      val te = inline2(te, "string_hash",               "stringHash",     mk_unary_inliner CPS.STRING_HASH)
      val te = inline2(te, "string_hash_djb2",          "stringHashDjb2", mk_unary_inliner CPS.STRING_HASH_DJB2)
      val te = inline2(te, "string_hash_sdbm",          "stringHashSdbm", mk_unary_inliner CPS.STRING_HASH_SDBM)
      
      (* immutable vectors *)
      val te = extern2(te, "vector_length", "vectorLength")
      val te = extern2(te, "vector_nth",    "vectorNth")
      val te = extern2(te, "vector_get",    "vectorGet")
      val te = extern2(te, "vector_list",   "vectorList")
      val te = extern2(te, "vector_setnth", "vectorSetNth")
      val te = extern2(te, "vector_update", "vectorUpdate")
      val te = extern2(te, "vector_create", "vectorCreate")
      val te = extern2(te, "vector_add",    "vectorAdd")
      val te = extern2(te, "vector_array",  "vectorArray")
      val te = extern2(te, "vector_copy",   "vectorCopy")
      
      (* mutable arrays *)
      val te = extern2(te, "array_length", "arrayLength")
      val te = extern2(te, "array_nth",    "arrayNth")
      val te = extern2(te, "array_get",    "arrayGet")
      val te = extern2(te, "array_list",   "arrayList")
      val te = extern2(te, "array_setnth", "arraySetNth")
      val te = extern2(te, "array_update", "arrayUpdate")
      val te = extern2(te, "array_create", "arrayCreate")
      val te = extern2(te, "array_add",    "arrayAdd")
      val te = extern2(te, "array_vector", "arrayVector")
      val te = extern2(te, "array_copy",   "arrayCopy")
      
      (* integers *)
      val te = inline2(te, "int_add",        "intAdd",       mk_binary_inliner CPS.INT_ADD)
      val te = inline2(te, "int_sub",        "intSub",       mk_binary_inliner CPS.INT_SUB)
      val te = inline2(te, "int_mul",        "intMul",       mk_binary_inliner CPS.INT_MUL)
      val te = inline2(te, "int_div",        "intDiv",       mk_divmod_inliner CPS.INT_DIV)
      val te = inline2(te, "int_mod",        "intMod",       mk_divmod_inliner CPS.INT_MOD)
      val te = inline2(te, "int_abs",        "intAbs",       mk_unary_inliner CPS.INT_ABS)
      val te = inline2(te, "int_neg",        "intNeg",       mk_unary_inliner CPS.INT_NEG)
      val te = inline2(te, "int_max",        "intMax",       mk_binary_inliner CPS.INT_MAX)
      val te = inline2(te, "int_min",        "intMin",       mk_binary_inliner CPS.INT_MIN)
      val te = inline2(te, "int_lt",         "intLt",        mk_binary_inliner CPS.INT_LT)
      val te = inline2(te, "int_le",         "intLe",        mk_binary_inliner CPS.INT_LE)
      val te = inline2(te, "int_eq",         "intEq",        mk_binary_inliner CPS.INT_EQ)
      val te = inline2(te, "int_ne",         "intNe",        mk_binary_inliner CPS.INT_NE)
      val te = inline2(te, "int_ge",         "intGe",        mk_binary_inliner CPS.INT_GE)
      val te = inline2(te, "int_gt",         "intGt",        mk_binary_inliner CPS.INT_GT)
      val te = extern2(te, "int_real",       "intReal")
      val te = extern2(te, "int_string",     "intString")
      val te = inline2(te, "int_bit_not",    "intBitNot",    mk_unary_inliner CPS.INT_BIT_NOT)
      val te = inline2(te, "int_bit_and",    "intBitAnd",    mk_binary_inliner CPS.INT_BIT_AND)
      val te = inline2(te, "int_bit_or",     "intBitOr",     mk_binary_inliner CPS.INT_BIT_OR)
      val te = inline2(te, "int_bit_xor",    "intBitXor",    mk_binary_inliner CPS.INT_BIT_XOR)
      val te = inline2(te, "int_bit_lshift", "intBitLShift", mk_binary_inliner CPS.INT_BIT_LSHIFT)
      val te = inline2(te, "int_bit_rshift", "intBitRShift", mk_binary_inliner CPS.INT_BIT_RSHIFT)


      (* reals *)
      val te = extern2(te, "real_add",    "realAdd")
      val te = extern2(te, "real_sub",    "realSub")
      val te = extern2(te, "real_mul",    "realMul")
      val te = extern2(te, "real_div",    "realDiv")
      val te = extern2(te, "real_mod",    "realMod")
      val te = extern2(te, "real_abs",    "realAbs")
      val te = extern2(te, "real_neg",    "realNeg")
      val te = extern2(te, "real_cos",    "realCos")
      val te = extern2(te, "real_sin",    "realSin")
      val te = extern2(te, "real_atan",   "realAtan")
      val te = extern2(te, "real_exp",    "realExp")
      val te = extern2(te, "real_ln",     "realLn")
      val te = extern2(te, "real_floor",  "realFloor")
      val te = extern2(te, "real_int",    "realInt")
      val te = extern2(te, "real_pow",    "realPow")
      val te = extern2(te, "real_sqrt",   "realSqrt")
      val te = extern2(te, "real_max",    "realMax")
      val te = extern2(te, "real_min",    "realMin")
      val te = extern2(te, "real_lt",     "realLt")
      val te = extern2(te, "real_le",     "realLe")    
      val te = extern2(te, "real_ne",     "realNe")
      val te = extern2(te, "real_ge",     "realGe")
      val te = extern2(te, "real_gt",     "realGt")
      val te = extern2(te, "real_string", "realString")
      val te = extern2(te, "real_asin",   "realAsin")
      val te = extern2(te, "real_acos",   "realAcos")
      val te = extern2(te, "real_atan2",  "realAtan2")
      val te = extern2(te, "real_cosh",   "realCosh")
      val te = extern2(te, "real_log",    "realLog")
      val te = extern2(te, "real_log10",  "realLog10")
      val te = extern2(te, "real_sinh",   "realSinh")
      val te = extern2(te, "real_tanh",   "realTanh")
      val te = inline2(te, "real_eq",     "realEq", mk_binary_inliner CPS.REAL_EQ)
      
      (* lists *)
      val te = StrDict.insert(te, 
                              "nil", 
                              CON{rep=ConRep.BOX{arity=0,tag=0,name=mkLongId("RML", "nil")}, 
                              nrcons=2})
      val te = StrDict.insert(te, 
                              "cons", 
                              CON{rep=ConRep.BOX{arity=2,tag=1,name=mkLongId("RML", "cons")}, 
                              nrcons=2})
      
      val te = extern2(te, "list_append",              "listAppend")
      val te = extern2(te, "list_delete",              "listDelete")
      val te = extern2(te, "list_length",              "listLength")
      val te = extern2(te, "list_member",              "listMember")
      val te = extern2(te, "list_nth",                 "listNth")
      val te = extern2(te, "list_get",                 "listGet")
      val te = extern2(te, "list_reverse",             "listReverse")
      val te = extern2(te, "list_string",              "listString")
      val te = extern2(te, "string_char_list_string",  "stringCharListString")
      val te = extern2(te, "string_list_string_char",  "stringListStringChar")
      val te = extern2(te, "list_vector",              "listVector")
      val te = extern2(te, "list_array",               "listArray")
      (* not working yet
      val te = extern2(te, "list_map",                 "listMap")
      *)

      (* logical variables *)
      val te = extern2(te, "lvar_get", "lvarGet")
      val te = extern2(te, "lvar_new", "lvarNew")
      val te = extern2(te, "lvar_set", "lvarSet")
      
      (* debug *)
      val te = extern(te, "debug")
      val te = extern(te, "debug_print")
      val te = extern(te, "debug_show_depth")    
      
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
