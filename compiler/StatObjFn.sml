(* static/statobj.sml *)

functor StatObjFn(
    structure Absyn : ABSYN
    structure TyFcn : TY_FCN
    structure TyScheme : TY_SCHEME
    structure Control  : CONTROL
    sharing TyFcn.Ty = TyScheme.Ty
    sharing type Absyn.IdentDict.Key.ord_key = Absyn.ident    
) : STAT_OBJ =
  struct

    structure Absyn     = Absyn
    structure IdentDict = Absyn.IdentDict
    structure Ty        = TyFcn.Ty
    structure TyFcn     = TyFcn
    structure TyScheme  = TyScheme

    datatype valkind    = CON | VAR | REL
                        
    datatype valstr     = VALSTR of 
                           {
                             vk: valkind, 
                             sigma: TyScheme.tyscheme, 
                             localVE: valstr Absyn.IdentDict.dict,
                             global: bool
                           }
                       
    datatype tystr      = TYSTR of 
                           {
                             theta: TyFcn.tyfcn,
                             abstract: bool
                           }
                        
    datatype modstr     = MODSTR of 
                           {
                             TE: tystr IdentDict.dict,
                             VE: valstr IdentDict.dict,
                             source: Absyn.Source.source
                           }

    (* standard type names *)
    val t_bool   =  Ty.TYNAME{modid="RML",tycon="bool",eq=ref Ty.MAYBE}
    val t_char   =  Ty.TYNAME{modid="RML",tycon="char",eq=ref Ty.MAYBE}
    val t_int    =  Ty.TYNAME{modid="RML",tycon="int",eq=ref Ty.MAYBE}
    val t_list   =  Ty.TYNAME{modid="RML",tycon="list",eq=ref Ty.MAYBE}
    val t_lvar   =  Ty.TYNAME{modid="RML",tycon="lvar",eq=ref Ty.ALWAYS}
    val t_option =  Ty.TYNAME{modid="RML",tycon="option",eq=ref Ty.MAYBE}
    val t_real   =  Ty.TYNAME{modid="RML",tycon="real",eq=ref Ty.MAYBE}
    val t_string =  Ty.TYNAME{modid="RML",tycon="string",eq=ref Ty.MAYBE}
    val t_vector =  Ty.TYNAME{modid="RML",tycon="vector",eq=ref Ty.MAYBE}
    val t_array  =  Ty.TYNAME{modid="RML",tycon="array",eq=ref Ty.MAYBE}
    
    (* standard atomic types *)
    val tau_bool    =  Ty.CONS([], t_bool,   NONE)
    val tau_char    =  Ty.CONS([], t_char,   NONE)
    val tau_int     =  Ty.CONS([], t_int,    NONE)
    val tau_real    =  Ty.CONS([], t_real,   NONE)
    val tau_string  =  Ty.CONS([], t_string, NONE)

    (* some standard types *)
    val alpha             = Ty.RIGID "a"
    val tau_alpha         = Ty.VAR(alpha, NONE)

    val beta              = Ty.RIGID "b"
    val tau_beta          = Ty.VAR(beta,  NONE)

    val tau_alpha_list    = Ty.CONS([tau_alpha], t_list,   NONE)
    val tau_beta_list     = Ty.CONS([tau_beta],  t_list,   NONE)
    val tau_alpha_lvar    = Ty.CONS([tau_alpha], t_lvar,   NONE)
    val tau_alpha_option  = Ty.CONS([tau_alpha], t_option, NONE)
    val tau_alpha_vector  = Ty.CONS([tau_alpha], t_vector, NONE)
    val tau_alpha_array   = Ty.CONS([tau_alpha], t_array,  NONE)
    val tau_char_list     = Ty.CONS([tau_char],  t_list,   NONE)
    val tau_string_list   = Ty.CONS([tau_string], t_list,  NONE)
    val eqalpha           = Ty.RIGID "'a"
    val tau_eqalpha       = Ty.VAR(eqalpha, NONE)
    val tau_eqalpha_list  = Ty.CONS([tau_eqalpha], t_list, NONE)
    val tau_debug_param   = [tau_string, tau_alpha]
    
    fun getFreshTau(x) = 
        [
         tau_string, 
         Ty.VAR(
           Ty.RIGID("rmldb_var_x"^Int.toString(x)),
           NONE)
        ]
    
    fun makeParameterTyList(foo, nelts) =
        if (nelts = 0) 
        then foo
        else makeParameterTyList(foo @ getFreshTau(nelts), nelts-1) (* add one more to the list *)
    
    (* Source object for the standard environment *)
    val sourceInit =
      Absyn.Source.SOURCE(
        ref(Absyn.Source.ArraySourceMap.new("(pervasive RML environment)",Absyn.Source.getCurrentDate())))

    (* standard value environment *)
    val VE_init =
    let 
      fun bind(VE, id, tau, vk) =
      let 
        val sigma = TyScheme.genAll tau
        val id = Absyn.rmlIdent id
      in
        IdentDict.insert(
          VE, 
          id, 
          VALSTR{vk=vk, sigma=sigma, localVE=IdentDict.empty, global=true}
        )
      end
      
      fun bindRel(VE, var, domtaus, codtaus) =
          bind(VE, var, Ty.REL(domtaus,codtaus,NONE), REL)
      
      fun bindRel2(VE, var1, var2,  domtaus, codtaus) =
      let val VE = bind(VE, var1, Ty.REL(domtaus,codtaus,NONE), REL)
          val VE = bind(VE, var2, Ty.REL(domtaus,codtaus,NONE), REL)
      in
        VE
      end

      fun bindCon(VE, con, tau) = bind(VE, con, tau, CON)
      
      val VE = IdentDict.empty
      
      (* options *)
      val VE = bindCon(VE, "NONE", tau_alpha_option)
      val VE = bindCon(VE, "SOME", Ty.REL([tau_alpha], [tau_alpha_option], NONE))

      (* misc functions *)
      val VE = bindRel(VE,  "clock", [], [tau_real])
      val VE = bindRel(VE,  "print", [tau_string], [])
      val VE = bindRel(VE,  "tick",  [], [tau_int])
      val VE = bindRel(VE,  "setStackOverflowSignal",  [tau_bool], [tau_bool])
      val VE = bindRel(VE,  "unique",  [tau_int], [tau_int])
      val VE = bindRel2(VE,  "enable_trace",  "enableTrace",  [], [])
      val VE = bindRel2(VE,  "disable_trace", "disableTrace", [], [])

      (* roots *)
      val VE = bindRel2(VE, "set_global_root",   "setGlobalRoot",      [tau_int, tau_alpha], [])
      val VE = bindRel2(VE, "get_global_root",   "getGlobalRoot",      [tau_int], [tau_alpha])

      (* references *)
      val VE = bindRel2(VE, "reference_eq",      "referenceEq",      [tau_alpha, tau_alpha], [tau_bool])
      val VE = bindRel2(VE, "reference_integer", "referenceInteger", [tau_alpha], [tau_int])
      val VE = bindRel2(VE, "reference_update",  "referenceUpdate",  [tau_alpha, tau_int, tau_beta], [tau_alpha])
      val VE = bindRel2(VE, "reference_setnth",  "referenceSetNth",  [tau_alpha, tau_int, tau_beta], [tau_alpha])
      val VE = bindRel2(VE, "reference_share",   "referenceShare",   [tau_alpha, tau_alpha], [])

      (* values *)
      val VE = bindRel2(VE, "value_constructor", "valueConstructor", [tau_alpha], [tau_int])
      val VE = bindRel2(VE, "value_slots",       "valueSlots",       [tau_alpha], [tau_int])
      val VE = bindRel2(VE, "value_eq",          "valueEq",          [tau_alpha, tau_alpha], [tau_bool])
      val VE = bindRel2(VE, "value_match",       "valueMatch",       [tau_alpha, tau_alpha], [tau_bool])
      val VE = bindRel2(VE, "value_hash",        "valueHash",        [tau_alpha], [tau_int])
      val VE = bindRel2(VE, "value_hash_mod",    "valueHashMod",     [tau_alpha, tau_int], [tau_int])
      
      (* if expressions *)
      val VE = bindRel2(VE, "if_exp", "ifExp", [tau_bool, tau_alpha, tau_alpha], [tau_alpha])
      
      (* booleans *)
      val VE = bindCon(VE, "false", tau_bool)
      val VE = bindCon(VE, "true",  tau_bool)
      val VE = bindRel2(VE, "bool_and",     "boolAnd", [tau_bool, tau_bool], [tau_bool])
      val VE = bindRel2(VE, "bool_not",     "boolNot", [tau_bool], [tau_bool])
      val VE = bindRel2(VE, "bool_or",      "boolOr",  [tau_bool, tau_bool], [tau_bool])
      val VE = bindRel2(VE, "bool_eq",      "boolEq",  [tau_bool, tau_bool], [tau_bool])
      val VE = bindRel2(VE, "bool_string",  "boolString",  [tau_bool], [tau_string])
      
      (* characters *)
      val VE = bindRel2(VE, "char_int",        "charInt",       [tau_char], [tau_int])
      val VE = bindRel2(VE, "string_char_int", "stringCharInt", [tau_string], [tau_int])
      val VE = bindRel2(VE, "char_eq",         "charEq",        [tau_char, tau_char], [tau_bool])
      
      (* integers *)
      val VE = bindRel2(VE, "int_abs",         "intAbs",        [tau_int], [tau_int])
      val VE = bindRel2(VE, "int_add",         "intAdd",        [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_char",        "intChar",       [tau_int], [tau_char])
      val VE = bindRel2(VE, "int_string_char", "intStringChar", [tau_int], [tau_string])
      val VE = bindRel2(VE, "int_div",         "intDiv",        [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_eq",          "intEq",         [tau_int, tau_int], [tau_bool])
      val VE = bindRel2(VE, "int_ge",          "intGe",         [tau_int, tau_int], [tau_bool])
      val VE = bindRel2(VE, "int_gt",          "intGt",         [tau_int, tau_int], [tau_bool])
      val VE = bindRel2(VE, "int_le",          "intLe",         [tau_int, tau_int], [tau_bool])
      val VE = bindRel2(VE, "int_lt",          "intLt",         [tau_int, tau_int], [tau_bool])
      val VE = bindRel2(VE, "int_max",         "intMax",        [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_min",         "intMin",        [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_mod",         "intMod",        [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_mul",         "intMul",        [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_ne",          "intNe",         [tau_int, tau_int], [tau_bool])
      val VE = bindRel2(VE, "int_neg",         "intNeg",        [tau_int], [tau_int])
      val VE = bindRel2(VE, "int_real",        "intReal",       [tau_int], [tau_real])
      val VE = bindRel2(VE, "int_string",      "intString",     [tau_int], [tau_string])
      val VE = bindRel2(VE, "int_sub",         "intSub",        [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_bit_not",     "intBitNot",     [tau_int], [tau_int])
      val VE = bindRel2(VE, "int_bit_and",     "intBitAnd",     [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_bit_or",      "intBitOr",      [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_bit_xor",     "intBitXor",     [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_bit_lshift",  "intBitLShift",  [tau_int, tau_int], [tau_int])
      val VE = bindRel2(VE, "int_bit_rshift",  "intBitRShift",  [tau_int, tau_int], [tau_int])
      
      (* lists *)
      val VE = bindCon(VE, "cons",Ty.REL([tau_alpha,tau_alpha_list],[tau_alpha_list],NONE))
      val VE = bindCon(VE, "nil",tau_alpha_list)
      
      val VE = bindRel2(VE, "list_append",             "listAppend",           [tau_alpha_list, tau_alpha_list], [tau_alpha_list])
      val VE = bindRel2(VE, "list_delete",             "listDelete",           [tau_alpha_list, tau_int], [tau_alpha_list])
      val VE = bindRel2(VE, "list_length",             "listLength",           [tau_alpha_list], [tau_int])
      val VE = bindRel2(VE, "list_member",             "listMember",           [tau_eqalpha, tau_eqalpha_list], [tau_bool])
      val VE = bindRel2(VE, "list_nth",                "listNth",              [tau_alpha_list, tau_int], [tau_alpha])
      val VE = bindRel2(VE, "list_get",                "listGet",              [tau_alpha_list, tau_int], [tau_alpha])
      val VE = bindRel2(VE, "list_reverse",            "listReverse",          [tau_alpha_list], [tau_alpha_list])
      val VE = bindRel2(VE, "list_string",             "listString",           [tau_char_list], [tau_string])
      val VE = bindRel2(VE, "string_char_list_string", "stringCharListString", [tau_string_list], [tau_string])      
      val VE = bindRel2(VE, "string_list_string_char", "stringListStringChar", [tau_string], [tau_string_list])
      val VE = bindRel2(VE, "list_vector",             "listVector",           [tau_alpha_list], [tau_alpha_vector])
      val VE = bindRel2(VE, "list_array",              "listArray",            [tau_alpha_list], [tau_alpha_array])
      val VE = bindRel2(VE, "list_append_usafe",       "listAppendUnsafe",     [tau_alpha_list, tau_alpha_list], [tau_alpha_list])
      (* not working yet
      val VE = bindRel2(VE, "list_map",                "listMap",              [tau_alpha_list, Ty.REL([tau_alpha], [tau_beta], NONE)], [tau_beta_list])
      *)


      (* logical variables *)
      val VE = bindRel2(VE, "lvar_get", "lvarGet", [tau_alpha_lvar], [tau_alpha_option])
      val VE = bindRel2(VE, "lvar_new", "lvarNew", [], [tau_alpha_lvar])
      val VE = bindRel2(VE, "lvar_set", "lvarSet", [tau_alpha_lvar, tau_alpha], [])
      
      (* reals *)
      val VE = bindRel2(VE, "real_abs",    "realAbs",    [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_add",    "realAdd",    [tau_real, tau_real], [tau_real])
      val VE = bindRel2(VE, "real_atan",   "realAtan",   [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_cos",    "realCos",    [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_div",    "realDiv",    [tau_real, tau_real], [tau_real])
      val VE = bindRel2(VE, "real_eq",     "realEq",     [tau_real, tau_real], [tau_bool])
      val VE = bindRel2(VE, "real_exp",    "realExp",    [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_floor",  "realFloor",  [tau_real],[tau_real])
      val VE = bindRel2(VE, "real_ceil",   "realCeil",   [tau_real],[tau_real])
      val VE = bindRel2(VE, "real_ge",     "realGe",     [tau_real, tau_real], [tau_bool])
      val VE = bindRel2(VE, "real_gt",     "realGt",     [tau_real, tau_real], [tau_bool])
      val VE = bindRel2(VE, "real_int",    "realInt",    [tau_real], [tau_int])
      val VE = bindRel2(VE, "real_le",     "realLe",     [tau_real, tau_real], [tau_bool])
      val VE = bindRel2(VE, "real_ln",     "realLn",     [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_lt",     "realLt",     [tau_real, tau_real], [tau_bool])
      val VE = bindRel2(VE, "real_max",    "realMax",    [tau_real, tau_real], [tau_real])
      val VE = bindRel2(VE, "real_min",    "realMin",    [tau_real, tau_real], [tau_real])
      val VE = bindRel2(VE, "real_mod",    "realMod",    [tau_real, tau_real], [tau_real])
      val VE = bindRel2(VE, "real_mul",    "realMul",    [tau_real, tau_real], [tau_real])
      val VE = bindRel2(VE, "real_ne",     "realNe",     [tau_real, tau_real], [tau_bool])
      val VE = bindRel2(VE, "real_neg",    "realNeg",    [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_pow",    "realPow",    [tau_real, tau_real], [tau_real])
      val VE = bindRel2(VE, "real_sin",    "realSin",    [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_sqrt",   "realSqrt",   [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_string", "realString", [tau_real], [tau_string])
      val VE = bindRel2(VE, "real_sub",    "realSub",    [tau_real, tau_real], [tau_real])
      val VE = bindRel2(VE, "real_asin",   "realAsin",   [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_acos",   "realAcos",   [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_atan2",  "realAtan2",  [tau_real,tau_real], [tau_real])
      val VE = bindRel2(VE, "real_cosh",   "realCosh",   [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_log",    "realLog",    [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_log10",  "realLog10",  [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_sinh",   "realSinh",   [tau_real], [tau_real])
      val VE = bindRel2(VE, "real_tanh",   "realTanh",   [tau_real], [tau_real])
      
      (* strings *)
      val VE = bindRel2(VE, "string_append",             "stringAppend",           [tau_string, tau_string], [tau_string])
      val VE = bindRel2(VE, "string_int",                "stringInt",              [tau_string], [tau_int])
      val VE = bindRel2(VE, "string_length",             "stringLength",           [tau_string], [tau_int])
      val VE = bindRel2(VE, "string_list",               "stringList",             [tau_string], [tau_char_list])
      val VE = bindRel2(VE, "string_nth",                "stringNth",              [tau_string, tau_int], [tau_char])
      val VE = bindRel2(VE, "string_nth_string_char",    "stringNthStringChar",    [tau_string, tau_int], [tau_string])
      val VE = bindRel2(VE, "string_get",                "stringGet",              [tau_string, tau_int], [tau_char])
      val VE = bindRel2(VE, "string_get_string_char",    "stringGetStringChar",    [tau_string, tau_int], [tau_string])
      val VE = bindRel2(VE, "string_setnth",             "stringSetNth",           [tau_string, tau_int, tau_char], [tau_string])
      val VE = bindRel2(VE, "string_setnth_string_char", "stringSetNthStringChar", [tau_string, tau_int, tau_string], [tau_string])
      val VE = bindRel2(VE, "string_update",             "stringUpdate",           [tau_string, tau_int, tau_char], [tau_string])      
      val VE = bindRel2(VE, "string_update_string_char", "stringUpdateStringChar", [tau_string, tau_int, tau_string], [tau_string])
      val VE = bindRel2(VE, "string_equal",               "stringEqual",           [tau_string, tau_string], [tau_bool])
      val VE = bindRel2(VE, "string_eq",                  "stringEq",              [tau_string, tau_string], [tau_bool])
      val VE = bindRel2(VE, "string_compare",             "stringCompare",         [tau_string, tau_string], [tau_int])
      val VE = bindRel2(VE, "string_append_list",         "stringAppendList",      [tau_string_list], [tau_string])
      val VE = bindRel2(VE, "string_delimit_list",        "stringDelimitList",     [tau_string_list, tau_string], [tau_string])
      (* hash functions *)
      val VE = bindRel2(VE, "string_hash",                "stringHash",            [tau_string], [tau_int])
      val VE = bindRel2(VE, "string_hash_djb2",           "stringHashDjb2",        [tau_string], [tau_int])
      val VE = bindRel2(VE, "string_hash_sdbm",           "stringHashSdbm",        [tau_string], [tau_int])
            
      (* immutable vectors *)
      val VE = bindRel2(VE, "vector_length", "vectorLength", [tau_alpha_vector], [tau_int])
      val VE = bindRel2(VE, "vector_list",   "vectorList",   [tau_alpha_vector], [tau_alpha_list])
      val VE = bindRel2(VE, "vector_nth",    "vectorNth",    [tau_alpha_vector, tau_int], [tau_alpha])
      val VE = bindRel2(VE, "vector_get",    "vectorGet",    [tau_alpha_vector, tau_int], [tau_alpha])
      val VE = bindRel2(VE, "vector_setnth", "vectorSetNth", [tau_alpha_vector, tau_int, tau_alpha], [tau_alpha_vector])
      val VE = bindRel2(VE, "vector_update", "vectorUpdate", [tau_alpha_vector, tau_int, tau_alpha], [tau_alpha_vector])
      val VE = bindRel2(VE, "vector_create", "vectorCreate", [tau_int,tau_alpha], [tau_alpha_vector])
      val VE = bindRel2(VE, "vector_add",    "vectorAdd",    [tau_alpha_vector, tau_alpha], [tau_alpha_vector])
      val VE = bindRel2(VE, "vector_array",  "vectorArray",  [tau_alpha_vector], [tau_alpha_array])
      val VE = bindRel2(VE, "vector_copy",   "vectorCopy",   [tau_alpha_vector], [tau_alpha_vector])

      (* mutable arrays *)      
      val VE = bindRel2(VE, "array_length", "arrayLength", [tau_alpha_array], [tau_int])
      val VE = bindRel2(VE, "array_list",   "arrayList",   [tau_alpha_array], [tau_alpha_list])
      val VE = bindRel2(VE, "array_nth",    "arrayNth",    [tau_alpha_array, tau_int], [tau_alpha])
      val VE = bindRel2(VE, "array_get",    "arrayGet",    [tau_alpha_array, tau_int], [tau_alpha])      
      val VE = bindRel2(VE, "array_setnth", "arraySetNth", [tau_alpha_array, tau_int, tau_alpha], [tau_alpha_array])
      val VE = bindRel2(VE, "array_update", "arrayUpdate", [tau_alpha_array, tau_int, tau_alpha], [tau_alpha_array])      
      val VE = bindRel2(VE, "array_create", "arrayCreate", [tau_int, tau_alpha], [tau_alpha_array])
      val VE = bindRel2(VE, "array_add",    "arrayAdd",    [tau_alpha_array, tau_alpha], [tau_alpha_array])
      val VE = bindRel2(VE, "array_vector", "arrayVector", [tau_alpha_array], [tau_alpha_vector])
      val VE = bindRel2(VE, "array_copy",   "arrayCopy",   [tau_alpha_array], [tau_alpha_array])
      
      (* debug *)
      (* adrpo added *)
      (* the debug buildin function takes 7 arguments
       * file name
       * sline, scolumn, eline, ecolumn
       * relation
       * goal as string
       * values of the previous term (if exists) [32 tuples for now]
       * parameters of the next term (if exists) [32 tuples for now]
       *)
      val VE = bindRel(VE, "debug", 
                [
                 tau_string,        (* filename *) 
                 tau_int,           (* sline *)
                 tau_int,           (* scolumn *)
                 tau_int,           (* eline *)
                 tau_int,           (* ecolumn *)
                 tau_string,        (* relation *)
                 tau_string         (* goal *)
                ],[])
      val VE = bindRel(VE, "debug_print", tau_debug_param, [])
      val VE = bindRel(VE, "debug_show_depth", [tau_int], [])
      val VE = bindRel(VE, "debug_push_in01", makeParameterTyList([], 1), [])
      val VE = bindRel(VE, "debug_push_in02", makeParameterTyList([], 2), [])
      val VE = bindRel(VE, "debug_push_in03", makeParameterTyList([], 3), [])
      val VE = bindRel(VE, "debug_push_in04", makeParameterTyList([], 4), [])      
      val VE = bindRel(VE, "debug_push_in05", makeParameterTyList([], 5), [])
      val VE = bindRel(VE, "debug_push_in06", makeParameterTyList([], 6), [])
      val VE = bindRel(VE, "debug_push_in07", makeParameterTyList([], 7), [])
      val VE = bindRel(VE, "debug_push_in08", makeParameterTyList([], 8), [])
      val VE = bindRel(VE, "debug_push_in09", makeParameterTyList([], 9), [])
      val VE = bindRel(VE, "debug_push_in10", makeParameterTyList([],10), [])
      val VE = bindRel(VE, "debug_push_in11", makeParameterTyList([],11), [])
      val VE = bindRel(VE, "debug_push_in12", makeParameterTyList([],12), [])
      val VE = bindRel(VE, "debug_push_in13", makeParameterTyList([],13), [])
      val VE = bindRel(VE, "debug_push_in14", makeParameterTyList([],14), [])
      val VE = bindRel(VE, "debug_push_in15", makeParameterTyList([],15), [])
      val VE = bindRel(VE, "debug_push_in16", makeParameterTyList([],16), [])
       
      val VE = bindRel(VE, "debug_push_out01", tau_debug_param, [])
      val VE = bindRel(VE, "debug_push_out02", makeParameterTyList([], 2), [])
      val VE = bindRel(VE, "debug_push_out03", makeParameterTyList([], 3), [])
      val VE = bindRel(VE, "debug_push_out04", makeParameterTyList([], 4), [])      
      val VE = bindRel(VE, "debug_push_out05", makeParameterTyList([], 5), [])
      val VE = bindRel(VE, "debug_push_out06", makeParameterTyList([], 6), [])
      val VE = bindRel(VE, "debug_push_out07", makeParameterTyList([], 7), [])
      val VE = bindRel(VE, "debug_push_out08", makeParameterTyList([], 8), [])
      val VE = bindRel(VE, "debug_push_out09", makeParameterTyList([], 9), [])
      val VE = bindRel(VE, "debug_push_out10", makeParameterTyList([],10), [])
      val VE = bindRel(VE, "debug_push_out11", makeParameterTyList([],11), [])
      val VE = bindRel(VE, "debug_push_out12", makeParameterTyList([],12), [])
      val VE = bindRel(VE, "debug_push_out13", makeParameterTyList([],13), [])
      val VE = bindRel(VE, "debug_push_out14", makeParameterTyList([],14), [])
      val VE = bindRel(VE, "debug_push_out15", makeParameterTyList([],15), [])
      val VE = bindRel(VE, "debug_push_out16", makeParameterTyList([],16), [])
    in
      VE
    end

    (* standard type environment *)
    val TE_init =
      let 
        
        fun bind(TE, tycon, theta) =
        let 
          val tystr = TYSTR{theta=theta, abstract=false}
          val tycon = Absyn.rmlIdent tycon
        in
          IdentDict.insert(TE, tycon, tystr)
        end
      
        val TE = IdentDict.empty
        val TE = bind(TE,"bool",   TyFcn.lambda([],      tau_bool))
        val TE = bind(TE,"char",   TyFcn.lambda([],      tau_char))
        val TE = bind(TE,"int",    TyFcn.lambda([],      tau_int))
        val TE = bind(TE,"list",   TyFcn.lambda([alpha], tau_alpha_list))
        val TE = bind(TE,"lvar",   TyFcn.lambda([alpha], tau_alpha_lvar))
        val TE = bind(TE,"option", TyFcn.lambda([alpha], tau_alpha_option))
        val TE = bind(TE,"real",   TyFcn.lambda([],      tau_real))
        val TE = bind(TE,"string", TyFcn.lambda([],      tau_string))
        val TE = bind(TE,"vector", TyFcn.lambda([alpha], tau_alpha_vector))
        val TE = bind(TE,"array",  TyFcn.lambda([alpha], tau_alpha_array))      
      in
        TE
      end

    (* standard module environment *)
    val ME_init =
      let 
        val modstr = MODSTR{TE=TE_init, VE=VE_init, source=sourceInit}
        val modid = Absyn.rmlIdent "RML"
      in
        IdentDict.insert(IdentDict.empty, modid, modstr)
      end

  end (* functor StatObjFn *)
