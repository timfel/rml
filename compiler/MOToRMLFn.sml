
(* MOToRMLFn.sml *)

functor MOToRMLFn(
        structure Absyn      : ABSYN
        structure Control    : CONTROL
        structure Util       : UTIL
        structure AbsynPrint : ABSYN_PRINT
        structure StrDict    : STR_DICT
        structure Cache      : CACHE
        sharing type AbsynPrint.Absyn.module = Cache.Absyn.module
        sharing type AbsynPrint.Absyn.goal = Cache.Absyn.goal
        ) : MOTORML =
  struct

    structure Absyn   = Cache.Absyn
    structure StrDict = Cache.StrDict
    structure Cache   =  Cache
    
    type repository = Cache.repository

    fun bug s = Util.bug("MOToRMLFn."^s)

fun transformMOToRML(modelica, imports, repository) =
let val Absyn.PROGRAM(_,_,interface as 
        Absyn.INTERFACE({modid=current_modid,source,...}, infoI), info) = modelica
    
    fun getBugLoc(Absyn.INFO(sp, ep)) =
    let 
       val {fileName, sline, scolumn, eline, ecolumn} = Absyn.Source.getLoc (source, sp, ep)
       val (prefix, file, ext) = Control.pathFileExtSplit(fileName)
       val fileName = Control.joinFileExt(file, ext)
    in
       ("\n"^fileName^":"^
       (Int.toString sline)^"."^(Int.toString scolumn)^"-"^
       (Int.toString eline)^"."^(Int.toString ecolumn)^" ")    
    end
    
    exception MetaModelicaToRMLTranslation
    fun errorAt(info, msg) = 
        (Util.outStdErr(getBugLoc(info)^"Error: "^msg^"\n"); raise MetaModelicaToRMLTranslation)   
        
    fun errorAtFunction(info, msg, function) = 
        (Util.outStdErr(getBugLoc(info)^"Error: "^msg^" [MOToRMLFn."^function^"]\n"); raise MetaModelicaToRMLTranslation)

    val debugFlag = false
    fun debug s = if (debugFlag) then Util.outStdErr("MOToRMLFn."^s) else ()
    
    val modidRML = SOME(Absyn.rmlIdent "RML")

    fun warn s = Util.warn("MOToRMLFn."^s)
    fun warnAt(info, msg) = 
        Util.outStdErr(getBugLoc(info)^"Warning: "^msg^"\n")
        
    fun warnAtFunction(info, msg, function) = 
        Util.outStdErr(getBugLoc(info)^"Warning: "^msg^" [MOToRMLFn."^function^"]\n")

        
    fun L(x) = (Int.toString (List.length x))    

    fun getShortId(Absyn.LONGID(NONE, ident, _)) = ident
    |    getShortId(Absyn.LONGID(_,_,info)) = 
            errorAtFunction(info, "unexpected qualified identifier", "getShortId")

    fun mkCtxInfo(Absyn.INFO(loc1,loc2),Absyn.INFO(loc3,loc4)) =
        Absyn.INFO(loc1,loc4)

    fun getStringLoc(Absyn.INFO(sp, ep)) =
    let 
       val {fileName, sline, scolumn, eline, ecolumn} = Absyn.Source.getLoc (source, sp, ep)
       val (prefix, file, ext) = Control.pathFileExtSplit(fileName)
       val fileName = Control.joinFileExt(file, ext)
    in
        " file: "^fileName^":"^
        (Int.toString sline)^"."^
        (Int.toString scolumn)^"."^
        (Int.toString eline)^"."^
        (Int.toString ecolumn)
    end

    fun prLoc(Absyn.INFO(sp, ep)) =
    let 
       val {fileName, sline, scolumn, eline, ecolumn} = Absyn.Source.getLoc (source, sp, ep)
       val (prefix, file, ext) = Control.pathFileExtSplit(fileName)
       val fileName = Control.joinFileExt(file, ext)
    in
        debug (" file: "^fileName^":"^
        (Int.toString sline)^"."^(Int.toString scolumn)^"."^(Int.toString eline)^"."^(Int.toString ecolumn)^
        "\n")
    end
              
    fun prIdentAndLoc(Absyn.IDENT(identstr, info)) =
    (
        debug("IDENT("^identstr^")\n");
        prLoc(info)
    )

    (* make a name like r_RECORDNAME_u__m_MODULETYPENAME *)
    fun mkIDForConstOfConstantRec(id1 as Absyn.IDENT(_, info), id2) = 
        Absyn.IDENT("r_"^Absyn.identName(id1)^"_u_TMP_m_"^Absyn.identName(id2), info);
    
    fun constructProperANDgoalChain(g) = g
    (* 
     * make AND(AND(g11, g12), g2) into AND(g11, AND(g12, g2))
     *)
    (* disabled for now
    fun constructProperANDgoalChain(g as Absyn.CALLgoal _) = g
    |   constructProperANDgoalChain(g as Absyn.EQUALgoal _) = g
    |   constructProperANDgoalChain(g as Absyn.LETgoal _) = g
    |   constructProperANDgoalChain(g as Absyn.NOTgoal _) = g
    |   constructProperANDgoalChain(g as Absyn.IFgoal _) = g
    |   constructProperANDgoalChain(Absyn.ANDgoal(g1 as Absyn.CALLgoal _, g2, i)) = 
          Absyn.ANDgoal(g1, constructProperANDgoalChain(g2), i)
    |   constructProperANDgoalChain(Absyn.ANDgoal(g1 as Absyn.EQUALgoal _, g2, i)) = 
          Absyn.ANDgoal(g1, constructProperANDgoalChain(g2), i)
    |   constructProperANDgoalChain(Absyn.ANDgoal(g1 as Absyn.LETgoal _, g2, i)) = 
          Absyn.ANDgoal(g1, constructProperANDgoalChain(g2), i)
    |   constructProperANDgoalChain(Absyn.ANDgoal(g1 as Absyn.NOTgoal _, g2, i)) = 
          Absyn.ANDgoal(g1, constructProperANDgoalChain(g2), i)
    |   constructProperANDgoalChain(Absyn.ANDgoal(g1 as Absyn.IFgoal _, g2, i)) = 
          Absyn.ANDgoal(g1, constructProperANDgoalChain(g2), i)
    |   constructProperANDgoalChain(Absyn.ANDgoal(Absyn.ANDgoal(g11, g12, i1), g2, i)) = 
         constructProperANDgoalChain(
           Absyn.ANDgoal(
             constructProperANDgoalChain(g11),
             Absyn.ANDgoal(
               constructProperANDgoalChain(g12),
               constructProperANDgoalChain(g2), i1),
             i))
    *)

    fun constructProperANDgoalChainOpt(SOME(g)) = SOME(constructProperANDgoalChain(g))
    |   constructProperANDgoalChainOpt(NONE) = NONE
    
    fun getTemp() = "temp_t_"^Int.toString(Util.tick())
     
    fun mklst(xlst, xnil, xcons, info) =
    let fun loop([], rest) = rest
        |    loop(x::xlst, rest) = loop(xlst, xcons(x,rest,info))
    in
        loop(rev xlst, xnil(info))
    end
     
    fun modidRML(info)= Absyn.IDENT("RML", info)
    fun modidRML(info) = SOME(Absyn.IDENT("RML", info))
    fun id_cons(info) = Absyn.LONGID(modidRML (info), Absyn.IDENT("cons",info), info)
    fun ctor_cons(info) = SOME (id_cons(info))
    fun id_nil(info) = Absyn.LONGID(modidRML info, Absyn.IDENT("nil",info), info)

    fun exp_nil(info) = Absyn.CONexp(id_nil(info), info)
    fun exp_cons(e,es,info) = Absyn.STRUCTexp(ctor_cons(info), [e,es], info)
    fun mkexplst(lst,info) = mklst(lst, exp_nil, exp_cons, info)

    fun pat_nil(info) = Absyn.CONpat(id_nil(info), info)
    fun pat_cons(p,ps,info) = Absyn.STRUCTpat(ctor_cons(info), [p,ps], ref [], info)
    fun mkpatlst(lst,info) = mklst(lst, pat_nil, pat_cons, info)

    datatype kind        = CON | FUN | FUNTYPE
    (* datatype valvalue    = VAL of {k: kind, v: int} *)

    datatype funcKind    = EXTERNAL_FUNCTION | NORMAL_FUNCTION | TYPE_FUNCTION

    fun  isPattern(exps) =
    let fun is_present(Absyn.NAMEDARG(SOME(ident), exp, infoNamedArg)) = true
        |    is_present(Absyn.NAMEDARG(NONE, exp, infoNamedArg)) = false
    in
        if List.exists is_present exps 
        then true
        else false
    end

    fun removeTyVarDuplicates([]) = []
    |    removeTyVarDuplicates(tyvar::tyvars) =
        let fun is_there(x) = (Absyn.identName x = Absyn.identName tyvar)
        in 
          if List.exists is_there tyvars
          then removeTyVarDuplicates(tyvars)
          else tyvar::removeTyVarDuplicates(tyvars)
        end        

    fun removeVARTyVarDuplicates([]) = []
    |    removeVARTyVarDuplicates((tyvar as Absyn.VARty(id1, _))::tyvars) =
        let fun is_there(Absyn.VARty(id2, _)) = (Absyn.identName id1 = Absyn.identName id2)
            |    is_there(_) = false
        in 
          if List.exists is_there tyvars
          then removeVARTyVarDuplicates(tyvars)
          else tyvar::removeVARTyVarDuplicates(tyvars)
        end
    |    removeVARTyVarDuplicates(x::tyvars) = x::removeVARTyVarDuplicates(tyvars)
    

    fun getBindingFromDec (Absyn.TYPEdec ([x], _)) = [x]
    |    getBindingFromDec (_) = []  

    fun getBindingFromSpec(Absyn.TYPEspec([x], _)) = [x] 
    |    getBindingFromSpec (_) = []  

    fun getTyBindings(specs, decs) =
    (
    List.concat ((List.map getBindingFromDec decs) @ (List.map getBindingFromSpec specs))
    )
    
    fun getTyBinding(lid, bindtylist) = 
        let fun loop(lid, []) = NONE
            |   loop(lid, Absyn.TYPBIND(tyvars, ident, ty, _)::rest) =
                if (Absyn.lidentName lid = Absyn.identName ident)
                then SOME(ty)
                else loop(lid, rest)
    in
      loop(lid, bindtylist)
    end

    fun getDataBindingFromDec (Absyn.DATAdec ([x], _, _)) = [x]
    |    getDataBindingFromDec (_) = []  

    fun getDataBindingFromSpec(Absyn.DATAspec([x], _, _)) = [x] 
    |    getDataBindingFromSpec (_) = []  

    fun getDataBindings(specs, decs) =
    (
    List.concat ((List.map getDataBindingFromDec decs) @ (List.map getDataBindingFromSpec specs))
    )

    fun getDataBinding(lid, databindlist) = 
        let fun loop(lid, []) = []
            |   loop(lid, Absyn.DATBIND(tyvars, ident, _, info)::rest) =
                if (Absyn.lidentName lid = Absyn.identName ident)
                then (map (fn x => Absyn.VARty(x, info)) tyvars)
                else loop(lid, rest)
    in
      loop(lid, databindlist)
    end

    fun getSeq(lst, getfn, bindtylist) =
      let fun loop([]) = []
        | loop(x::xs) = (getfn(x, bindtylist)) @ (loop xs)
      in
        case lst of 
            []        => []
        |    [x]    => getfn(x, bindtylist)
        |    (x::xs)    => getfn(x, bindtylist) @ (loop xs)
      end

    fun getTyVar(ty, bindtylist) = getTypeDispatch(ty, bindtylist)

    and getTyseq(tyseq, bindtylist) = getSeq(tyseq, getTyVar, bindtylist)
    (*
    datatype ty    = VARty of tyvar * info
                | CONSty of ty list * longid * info
                | TUPLEty of ty list * info
                | RELty of ty list * ty list * info     
                | NAMEDty of ident * ty * info
    *)

    and getTypeDispatch(ty, bindtylist) =
      case ty
        of x as Absyn.VARty(tyvar, _) => [tyvar]
        | Absyn.TUPLEty(tys, _)          => 
            getSeq(tys, getTyVar, bindtylist)
        | Absyn.RELty(domtys, codtys, _)      => 
            (getTyseq(domtys, bindtylist)) @ (getTyseq(codtys, bindtylist))
        | Absyn.CONSty(tys, lid, _)    =>
        (
            (case tys
            of []    => []
            | [ty]    => getTyVar(ty, bindtylist)
            | _    => getTyseq(tys, bindtylist)
            ) 
            @ 
            (case getTyBinding(lid, bindtylist) of
                SOME(ty) => getTyVar(ty, bindtylist)
            |    NONE => []
            )
        )
        | Absyn.NAMEDty(id, ty, _) => getTypeDispatch(ty,bindtylist)
            

    fun getVARTYSeq(lst, getVARTYfn, bindtylist) =
      let fun loop([]) = []
        | loop(x::xs) = (getVARTYfn(x, bindtylist)) @ (loop xs)
      in
        case lst of 
            []        => []
        |    [x]    => getVARTYfn(x, bindtylist)
        |    (x::xs)    => getVARTYfn(x, bindtylist) @ (loop xs)
      end

    fun getVARTYTyVar(ty, bindtylist) = getVARTYTypeDispatch(ty, bindtylist)

    and getVARTYTyseq(tyseq, bindtylist) = getVARTYSeq(tyseq, getVARTYTyVar, bindtylist)
    (*
    datatype ty    = VARty of tyvar * info
                | CONSty of ty list * longid * info
                | TUPLEty of ty list * info
                | RELty of ty list * ty list * info    
                | NAMEDty of ident * ty * info
    *)

    and getVARTYTypeDispatch(ty, bindtylist) =
      case ty
        of x as Absyn.VARty(tyvar, _) => [x]
        | Absyn.TUPLEty(tys, _)          => 
            getVARTYSeq(tys, getVARTYTyVar, bindtylist)
        | Absyn.RELty(domtys, codtys, _)      => 
            (getVARTYTyseq(domtys, bindtylist)) @ (getVARTYTyseq(codtys, bindtylist))
        | Absyn.CONSty(tys, lid, _)    =>
        (
            (case tys
            of []    => []
            | [ty]    => getVARTYTyVar(ty, bindtylist)
            | _    => getVARTYTyseq(tys, bindtylist)
            ) 
            @ 
            (case getTyBinding(lid, bindtylist) of
                SOME(ty) => getVARTYTyVar(ty, bindtylist)
            |    NONE => []
            )
        )    
        | Absyn.NAMEDty(id, ty, _) => getVARTYTypeDispatch(ty,bindtylist)


    fun setSeq(lst, setfn, bindtylist) =
      let fun loop([]) = []
        | loop(x::xs) = (setfn(x, bindtylist)) :: (loop xs)
      in
        case lst of 
            []        => []
        |    [x]    => [setfn(x, bindtylist)]
        |    (x::xs)    => setfn(x, bindtylist) :: (loop xs)
      end

    fun setTyVar(ty, bindtylist) = setTypeDispatch(ty, bindtylist)

    and setTyseq(tyseq, bindtylist) = setSeq(tyseq, setTyVar, bindtylist)
    (*
    datatype ty    = VARty of tyvar * info
                | CONSty of ty list * longid * info
                | TUPLEty of ty list * info
                | RELty of ty list * ty list * info     
    *)

    and setTypeDispatch(ty, bindtylist) =
      case ty
        of x as Absyn.VARty(tyvar, _) => x
        | Absyn.TUPLEty(tys, info)      => 
            Absyn.TUPLEty(setSeq(tys, setTyVar, bindtylist), info)
        | Absyn.RELty(domtys, codtys, info) => 
            Absyn.RELty(setTyseq(domtys, bindtylist), setTyseq(codtys, bindtylist), info)
        | Absyn.CONSty(tys, lid, info)    =>
        (
            case tys of 
                []    => Absyn.CONSty(
                        (case getTyBinding(lid, bindtylist) of
                            NONE => []
                        |    SOME(ty) => 
                            removeVARTyVarDuplicates(getVARTYTyVar(ty, bindtylist))), 
                        lid, info)
            | [ty]    => Absyn.CONSty([setTyVar(ty, bindtylist)], lid, info)
            | _        => Absyn.CONSty(setTyseq(tys, bindtylist), lid, info)
             
        )    
        | Absyn.NAMEDty(id, ty, i) => Absyn.NAMEDty(id, setTypeDispatch(ty,bindtylist), i)
    
    fun getPathLastIdent(Absyn.QUALIFIED(_, x, _)) = getPathLastIdent(x)
    |    getPathLastIdent(Absyn.PATHIDENT(id, _)) = id
    (*
    |    getPathLastIdent(Absyn.TYPEVARIABLE(id, info)) = 
            errorAtFunction(info, "unexpected type variable", "getPathLastIdent")    
    *)

    (* what can we find in a package/uniontype/function/functiontype/record *) 
    (* TODO LATER! collect all this info!
    datatype visibility = PUBLIC
                        | PROTECTED
                        | LOCAL
                        
    datatype range = RANGE of int * int * int * int (* local visibility of match/case/else *)
    (* if there is a range then is always local declaration *)
    
    datatype scope = SCOPE of (Absyn.ident * visibility) list * range option
        
    datatype vardecl  = VARDECL of Absyn.ElementAttributes *
                                   Absyn.ident * (* variable identifier *)
                                   Absyn.exp option * (* variable initialization *)
                                   Absyn.ty * (* variable type *)
                                   Absyn.info (* variable position *)
    
    datatype construct = CoB of scope * (* scope *)
                                Absyn.conbind      (* constructors   *)
                       | TyB of scope * (* scope *)
                                Absyn.typbind      (* type bindings  *)
                       | TyV of scope * (* scope *)
                                Absyn.tyvar        (* type variables *)
                         (* match clauses  *)        
                       | CLAUSE of scope * (* scope *)
                                   vardecl list * (* local variable declarations in this clause *)
                                   Absyn.clause *   (* clause *)
                                   Absyn.info   (* position *)
                         (* variables and constants not declared as input/output *)
                       | VAR of scope * 
                                vardecl
                       | INTy of scope * 
                                 Absyn.ty * (* type input *) 
                                 vardecl   (* variable name & properties *)
                       | OUTTy of scope * (* scope *)
                                  Absyn.ty * (* type output *) 
                                  vardecl (* variable name & properties *)
                       | ALGORITHM of scope * 
                                      Absyn.clause * Absyn.info      (* algorithms != match *)
                       | FUNC     of scope *               (* scope  *) 
                                     Absyn.ident *           (* name   *)
                                     construct list           (* in/out *)
                       | EXTERNAL of scope * 
                                     string
                       | REL of scope *
                                Absyn.ident * 
                                Absyn.ty * 
                                Absyn.clause option * 
                                Absyn.info *
                                funcKind
    *)
    (* what can we find in a package/uniontype/function/functiontype/record *)     
    datatype construct = CoB of Absyn.conbind      (* constructors   *)
                       | TyB of Absyn.typbind      (* type bindings  *)
                       | TyV of Absyn.tyvar        (* type variables *)
                       | MATCHexp of Absyn.exp *    (* the expression in the match *)
                                     Absyn.info *
                                     Absyn.pat *    (* the result of the match *)
                                     Absyn.info
                         (* match clauses  *)        
                       | CLAUSE of Absyn.clause *   (* clause *)
                                   Absyn.info   (* position *)
                         (* variables and constants not declared as input/output *)
                       | VAL of Absyn.ident * (* variable identifier *)
                                Absyn.exp option * (* variable initialization *)
                                Absyn.ty option * (* variable type *)
                                Absyn.attr * (* variable attributes *)
                                Absyn.info * (* variable position *)
                                Absyn.ident option (* scope *)
                       | INTy of Absyn.ty * (* type input *) 
                                 Absyn.ident * (* variable name *)
                                 Absyn.attr (* variable attributes *)                                 
                       | OUTTy of Absyn.ty * (* type output *) 
                                  Absyn.ident * (* variable name *)
                                  Absyn.attr (* variable attributes *)                                  
                       | ALGORITHM of Absyn.clause * Absyn.info * Absyn.info     (* algorithms != match *)
                       | FUNC of Absyn.ident option *  (* scope  *) 
                                     Absyn.ident *           (* name   *)
                                     construct list *         (* in/out *)
                                     funcKind                 (* function or function type! *)
                       | EXTERNAL of string
                       | REL of Absyn.ident * 
                                Absyn.ty * 
                                Absyn.clause option * 
                                (Absyn.ident * Absyn.ty option * Absyn.exp option * Absyn.attr) list * (* local variables *)
                                (Absyn.exp *  (* match expression *)
                                 Absyn.info * (* match info *) 
                                 Absyn.pat *  (* match return expression *)
                                 Absyn.info) option * (* match info *)
                                Absyn.info *
                                funcKind  
                                
    type constructs = construct list

     (* only 1 DOT please *)
    fun cref2Ident(Absyn.CREF_QUAL(ident1, _, Absyn.CREF_IDENT(ident2, _, _), info)) = 
        Absyn.LONGID(SOME(ident1), ident2, info)
    | cref2Ident(Absyn.CREF_IDENT(ident, _,  info)) = 
        Absyn.LONGID(NONE, ident, info)
    | cref2Ident(Absyn.CREF_QUAL(_, _, _, info)) = 
        errorAtFunction(info, "only one DOT in component reference is allowed", "cref2Ident")
                
    val rmlEnvironmentConstructors = ["NONE","nil","cons","list","SOME"]
    
    val rmlEnvironmentRelations = 
      [
      (* roots *)
      "set_global_root",   "setGlobalRoot",
      "get_global_root",   "getGlobalRoot",

      (* references *)
      "reference_eq",      "referenceEq",
      "reference_integer", "referenceInteger",
      "reference_update",  "referenceUpdate",
      "reference_setnth",  "referenceSetNth",
      "reference_share",   "referenceShare",
      
      (* values *)
      "value_constructor", "valueConstructor",
      "value_slots",       "valueSlots",
      "value_eq",          "valueEq",
      "value_match",       "valueMatch",
      "value_hash",        "valueHash",
      "value_hash_mod",    "valueHashMod",

      (* booleans *)
      "bool_and",    "boolAnd",
      "bool_not",    "boolNot",
      "bool_or",     "boolOr",
      "bool_eq",     "boolEq",
      "bool_string", "boolString",
      
      (* characters *)
      "char_int", "charInt",
      "string_char_int", "stringCharInt",
      
      (* integers *)
      "int_abs",         "intAbs",
      "int_add",         "intAdd",
      "int_char",        "intChar",
      "int_string_char", "intStringChar",
      "int_div",         "intDiv",
      "int_eq",          "intEq",
      "int_ge",          "intGe",
      "int_gt",          "intGt",
      "int_le",          "intLe",
      "int_lt",          "intLt",
      "int_max",         "intMax",
      "int_min",         "intMin",
      "int_mod",         "intMod",
      "int_mul",         "intMul",
      "int_ne",          "intNe",
      "int_neg",         "intNeg",
      "int_real",        "intReal",
      "int_string",      "intString",
      "int_sub",         "intSub",
      "int_bit_not",     "intBitNot",
      "int_bit_and",     "intBitAnd",
      "int_bit_or",      "intBitOr",
      "int_bit_xor",     "intBitXor",
      "int_bit_lshift",  "intBitLShift",
      "int_bit_rshift",  "intBitRShift",
      
      (* lists *)
      "list_empty",              "listEmpty",
      "list_append",             "listAppend",
      "list_delete",             "listDelete",
      "list_length",             "listLength",
      "list_member",             "listMember",
      "list_nth",                "listNth",
      "list_get",                "listGet", 
      "list_reverse",            "listReverse", 
      "list_string",             "listString",
      "string_char_list_string", "stringCharListString",
      "string_list_string_char", "stringListStringChar",
      "list_vector",             "listVector",
      "list_array",              "listArray",
      "list_append_usafe",       "listAppendUnsafe",
      (*
      "list_map",                "listMap",
      *)
      
      (* logical variables *)
      "lvar_get", "listGet",
      "lvar_new", "lvarNew",
      "lvar_set", "lvarSet",

      (* reals *)
      "real_abs",    "realAbs",
      "real_add",    "realAdd",
      "real_atan",   "realAtan",
      "real_cos",    "realCos",
      "real_div",    "realDiv",
      "real_eq",     "realEq",
      "real_exp",    "realExp",
      "real_floor",  "realFloor",
      "real_ceil",   "realCeil",
      "real_ge",     "realGe",
      "real_gt",     "realGt",
      "real_int",    "realInt",
      "real_le",     "realLe",
      "real_ln",     "realLn",
      "real_lt",     "realLt",
      "real_max",    "realMax",
      "real_min",    "realMin",
      "real_mod",    "realMod",
      "real_mul",    "realMul",
      "real_ne",     "realNe",
      "real_neg",    "realNeg",
      "real_pow",    "realPow",
      "real_sin",    "realSin",
      "real_sqrt",   "realSqrt",
      "real_string", "realString",
      "real_sub",    "realSub",
      "real_asin",   "realAsin",
      "real_acos",   "realAcos",
      "real_atan2",  "realAtan2",
      "real_cosh",   "realCosh",
      "real_log",    "realLog",
      "real_log10",  "realLog10",
      "real_sinh",   "realSinh",
      "real_tanh",   "realTanh",
      
      (* strings *)
      "string_append",             "stringAppend",
      "string_int",                "stringInt",
      "string_length",             "stringLength",
      "string_list",               "stringList",
      "string_nth",                "stringNth",
      "string_nth_string_char",    "stringNthStringChar",
      "string_get",                "stringGet",
      "string_get_string_char",    "stringGetStringChar",
      "string_setnth",             "stringSetNth",
      "string_setnth_string_char", "stringSetNthStringChar",
      "string_update",             "stringUpdate",
      "string_update_string_char", "stringUpdateStringChar",
      "string_equal",              "stringEqual",
      "string_eq",                 "stringEq",
      "string_compare",            "stringCompare",
      "string_append_list",        "stringAppendList",
      "string_delimit_list",        "stringDelimitList",
      "string_hash",               "stringHash",
      "string_hash_djb2",          "stringHashDjb2",
      "string_hash_sdbm",           "stringHashSdbm",
      
      (* immutable vectors *)
      "vector_length", "vectorLength",
      "vector_list",   "vectorList",
      "vector_nth",    "vectorNth",
      "vector_get",    "vectorGet",
      "vector_setnth", "vectorSetNth",
      "vector_update", "vectorUpdate",
      "vector_create", "vectorCreate",
      "vector_add",    "vectorAdd",
      "vector_array",  "vectorArray",
      "vector_copy",   "vectorCopy",
      
      (* mutable arrays *)      
      "array_length",  "arrayLength",
      "array_list",    "arrayList",
      "array_nth",     "arrayNth",
      "array_get",     "arrayGet",
      "array_setnth",  "arraySetNth",
      "array_update",  "arrayUpdate",
      "array_create",  "arrayCreate",
      "array_add",     "arrayAdd",
      "array_vector",  "arrayVector",
      "array_copy",    "arrayCopy",

      (* if expressions *)
      "if_exp", "ifExp",
      (* misc *)
      "clock", 
      "print", 
      "tick", 
      "unique", 
      "enable_trace",  "enableTrace",
      "disable_trace", "disableTrace",
      "setStackOverflowSignal",
      (* debug *)
      "debug", "debug_print", "debug_show_depth", 
      "debug_push_in01", "debug_push_in02", "debug_push_in03", "debug_push_in04", "debug_push_in05", "debug_push_in06", 
      "debug_push_in07", "debug_push_in08", "debug_push_in09", "debug_push_in10", "debug_push_in11", "debug_push_in12", 
      "debug_push_in13", "debug_push_in14", "debug_push_in15", "debug_push_in16", 
      "debug_push_out01", "debug_push_out02", "debug_push_out03", "debug_push_out04", "debug_push_out05", "debug_push_out06", 
      "debug_push_out07", "debug_push_out08", "debug_push_out09", "debug_push_out10", "debug_push_out11", "debug_push_out12", 
      "debug_push_out13", "debug_push_out14", "debug_push_out15", "debug_push_out16"
    ]    


    fun getMODRestrictions(file, repository) =
    let val entryRML = Cache.getCacheEntry(repository, Cache.rmlCache, file)
        val entrySRZ = Cache.getCacheEntry(repository, Cache.srzCache, file)
        val entryMOD = Cache.getCacheEntry(repository, Cache.modCache, file)
        val externals = 
            case (entryRML, entrySRZ) of
                (SOME(entryR),SOME(entryS)) => 
                    if Cache.hasRML_M(entryR) 
                    then (Cache.getModId(entryR),Cache.getRestrictions(Cache.rmlM_info(entryR)))
                    else
                    if Cache.hasRML_I(entryR) 
                    then (Cache.getModId(entryR),Cache.getRestrictions(Cache.rmlI_info(entryR)))
                    else 
                    if Cache.hasSRZ_M(entryS) 
                    then (Cache.getModId(entryS),Cache.getRestrictions(Cache.srzM_info(entryS)))
                    else 
                    if Cache.hasSRZ_I(entryS) 
                    then (Cache.getModId(entryS),Cache.getRestrictions(Cache.srzI_info(entryS)))
                    else (case entryMOD of
                                SOME(entryM) => 
                                    (Cache.getModId(entryM),Cache.getRestrictions(Cache.modM_info(entryM)))
                              | NONE => bug("getMODRestrictions!"))
            |    (SOME(entryR),_) =>
                    if Cache.hasRML_M(entryR) 
                    then (Cache.getModId(entryR),Cache.getRestrictions(Cache.rmlM_info(entryR)))
                    else 
                    if Cache.hasRML_I(entryR) 
                    then (Cache.getModId(entryR),Cache.getRestrictions(Cache.rmlI_info(entryR)))
                    else (case entryMOD of
                                SOME(entryM) => 
                                    (Cache.getModId(entryM),Cache.getRestrictions(Cache.modM_info(entryM)))
                              | NONE => bug("getMODRestrictions!"))
            |    (_,SOME(entryS)) =>
                    if Cache.hasSRZ_M(entryS)
                    then (Cache.getModId(entryS),Cache.getRestrictions(Cache.srzM_info(entryS)))
                    else 
                    if Cache.hasSRZ_I(entryS) 
                    then (Cache.getModId(entryS),Cache.getRestrictions(Cache.srzI_info(entryS)))
                    else (case entryMOD of
                                SOME(entryM) => 
                                    (Cache.getModId(entryM),Cache.getRestrictions(Cache.modM_info(entryM)))
                              | NONE => bug("getMODRestrictions!"))
            |    (_,_) => (case entryMOD of
                                SOME(entryM) => 
                                    (Cache.getModId(entryM),Cache.getRestrictions(Cache.modM_info(entryM)))
                              | NONE => bug("getMODRestrictions!"))
    in
        externals
    end
            
    val currModIdFileName = Absyn.Source.getFileName(source)
    
    val translatingThen = ref false        (* this one tells me if 
                                           I'm translating case ... then (THIS_PART)
                                           because if i do, then tuples are tuples
                                           not expressions!!! *)
                                           
    val globalEnv = 
        let    val pk = StrDict.empty
            val    se = StrDict.empty
            fun insert(old, [], restr) = old
            |    insert(old, x::rest, restr) = 
                    StrDict.insert(insert(old,rest,restr), x, restr)
            val se = insert(
                        se, 
                        rmlEnvironmentConstructors, 
                        Absyn.R_RECORD(Absyn.dummyInfo))
            val se = insert(
                        se, 
                        rmlEnvironmentRelations, 
                        Absyn.R_FUNCTION(Absyn.dummyInfo))
            val pk = StrDict.insert(pk, "RML", se)
            fun loop(old,[],_) = old
            |    loop(old,import::rest,onlyPublic) =
                let val (importModId, externals) = getMODRestrictions(import, repository)
                    val importModuleDict = ref StrDict.empty
                    fun prExternals (old,externals) = 
                    let fun pr(str, (Cache.FUN,visibility),  dict) =
                        (
                            case visibility of 
                                Cache.PUBLIC =>
                                (
                                debug ("Inserting: "^str^" as public function\n");
                                importModuleDict := 
                                StrDict.insert(!importModuleDict, str, Absyn.R_FUNCTION(Absyn.dummyInfo))
                                )
                            |    Cache.BOTH =>
                                (
                                debug ("Inserting: "^str^" as public function\n");
                                importModuleDict := 
                                StrDict.insert(!importModuleDict, str, Absyn.R_FUNCTION(Absyn.dummyInfo))
                                )                                
                            |    Cache.PROTECTED =>
                                if onlyPublic
                                then ()
                                else
                                (
                                debug ("Inserting: "^str^" as protected function\n");
                                importModuleDict := 
                                StrDict.insert(!importModuleDict, str, Absyn.R_FUNCTION(Absyn.dummyInfo))
                                )                                
                        )
                        |     pr(str, (Cache.REC,visibility),  dict) =
                            case visibility of 
                                Cache.PUBLIC =>
                                (
                                debug ("Inserting: "^str^" as public record\n");
                                importModuleDict := 
                                StrDict.insert(!importModuleDict, str, Absyn.R_RECORD(Absyn.dummyInfo))
                                )
                            |    Cache.BOTH =>
                                (
                                debug ("Inserting: "^str^" as public record\n");
                                importModuleDict := 
                                StrDict.insert(!importModuleDict, str, Absyn.R_RECORD(Absyn.dummyInfo))
                                )
                            |    Cache.PROTECTED =>
                                if onlyPublic
                                then ()
                                else
                                (
                                debug ("Inserting: "^str^" as protected record\n");
                                importModuleDict := 
                                StrDict.insert(!importModuleDict, str, Absyn.R_RECORD(Absyn.dummyInfo))
                                )                                
                    in
                        StrDict.fold(pr, (), externals)
                    end
                    val _ = prExternals(!importModuleDict,externals)
                in
                    StrDict.insert(
                        loop(old,rest,onlyPublic),
                        Absyn.identName importModId,!importModuleDict)
                end    
            val pk = loop(loop(pk, imports, true), [currModIdFileName], false)
            (*
            fun insertPackages(old, []) = old
            |    insertPackages(old, Absyn.PACKAGE(id_mod, externalDecl)::rest) =
                let val se = StrDict.empty
                    fun insertDecls(oldD, []) = oldD
                    |    insertDecls(oldD, Absyn.CLASS(id, _, _, _, restriction, _, _)::restd) =
                            StrDict.insert(insertDecls(oldD,restd), Absyn.identName id, restriction)
                    val se = insertDecls(se, externalDecl)
                in
                    StrDict.insert(insertPackages(old, rest), Absyn.identName id_mod, se)
                end
            val pk = insertPackages(pk, externalDeclarations)
            *)
        in
          pk
        end    
    
    val localEnv = ref StrDict.empty
    
    (*
    fun getPackageDecl([], id) = []
    |    getPackageDecl(Absyn.PACKAGE(id_mod, externalDecl)::rest, id) = 
        if (Absyn.identName id_mod) = (Absyn.identName id) 
        then (debug (" in package: "^(Absyn.identName id)); externalDecl)
        else getPackageDecl(rest, id)      
    *)
        
    fun getRMLEnvironmentRestriction(Absyn.IDENT(x, info)) =
    let 
    in
        case StrDict.find(globalEnv, "RML") of
            SOME(dict) => StrDict.find(dict, x)
        |    NONE       => bug("getRMLEnvironmentRestriction: could not find the RML environment!")
    end
    
    (* for external declarations *)
    fun lookupLIdent(longId as Absyn.LONGID(SOME(mod_id), shortId, _)) = 
        let val strModId   = Absyn.identName mod_id
            val strShortId = Absyn.identName shortId
        in
            (* print ("\nSearching for "^strShortId^" in "^strModId); *)
            case StrDict.find(globalEnv, strModId) of
                SOME(dict) => StrDict.find(dict, strShortId)
            |    NONE       => NONE
        end
    |   lookupLIdent(longId as Absyn.LONGID(NONE, shortId, _)) = 
        let val strModId   = Absyn.identName current_modid
            val strShortId = Absyn.identName shortId
            val modEnv = StrDict.find(globalEnv, strModId)
        in
            case StrDict.find(!localEnv, strShortId) of
                NONE =>
                (
                case modEnv of
                    SOME(dict) => 
                    (
                        case StrDict.find(dict, strShortId) of
                            NONE => getRMLEnvironmentRestriction(shortId)
                        |        x => x
                    )
                |    NONE       => getRMLEnvironmentRestriction(shortId)
                )
            |    x => NONE
        end
    
    fun appendSD((s1, d1), (s2, d2)) = ((s1 @ s2), (d1 @ d2))
    
    fun getS((s, d)) = s
    fun getD((s, d)) = d
    
     (* only 1 DOT please *)
    fun path2Ident(Absyn.QUALIFIED(ident1, Absyn.PATHIDENT(ident2, _), info)) = 
        Absyn.LONGID(SOME(ident1), ident2, info)
    | path2Ident(Absyn.PATHIDENT(ident, info)) = 
        Absyn.LONGID(NONE, ident, info)
    (*
    | path2Ident(Absyn.TYPEVARIABLE(ident, info)) =
        Absyn.LONGID(NONE, ident, info)
    *)
    | path2Ident(Absyn.QUALIFIED(_, _, info)) = 
        errorAtFunction(info, "only one DOT in path is allowed","path2Ident")
            
    fun caseType(Absyn.IDENT("Real", info))    = Absyn.IDENT("real", info)
      | caseType(Absyn.IDENT("Integer", info)) = Absyn.IDENT("int", info)
      | caseType(Absyn.IDENT("String", info))  = Absyn.IDENT("string", info)
      | caseType(Absyn.IDENT("Boolean", info)) = Absyn.IDENT("bool", info)
      | caseType(x) = x         
      
    fun getComplexType(path, ty) = 
        case path of 
            Absyn.PATHIDENT(Absyn.IDENT("$TUPLE", _), _) => 
            (
                ty
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("Tuple", _), _) => 
            (
                ty
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("tuple", _), _) => 
            (
                ty
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("$LIST", info), _) => 
            (
                    Absyn.CONSty(
                        [ty], 
                        Absyn.LONGID(
                            NONE, 
                            Absyn.IDENT("list", info), 
                            info),
                        info)
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("list", info), _) => 
            (
                    Absyn.CONSty(
                        [ty], 
                        Absyn.LONGID(
                            NONE, 
                            Absyn.IDENT("list", info), 
                            info),
                        info)
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("List", info), _) => 
            (
                    Absyn.CONSty(
                        [ty], 
                        Absyn.LONGID(
                            NONE, 
                            Absyn.IDENT("list", info), 
                            info),
                        info)
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("Option", info), _) => 
            (
                    Absyn.CONSty(
                        [ty], 
                        Absyn.LONGID(
                            NONE, 
                            Absyn.IDENT("option", info), 
                            info),
                        info)
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("option", info), _) => 
            (
                    Absyn.CONSty(
                        [ty], 
                        Absyn.LONGID(
                            NONE, 
                            Absyn.IDENT("option", info), 
                            info),
                        info)
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("$ARRAY", info), _) => 
            (
                    Absyn.CONSty(
                        [ty], 
                        Absyn.LONGID(
                            NONE, 
                            Absyn.IDENT("array", info), 
                            info),
                        info)
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("array", info), _) => 
            (
                    Absyn.CONSty(
                        [ty], 
                        Absyn.LONGID(
                            NONE, 
                            Absyn.IDENT("array", info), 
                            info),
                        info)
            )
         |  Absyn.PATHIDENT(Absyn.IDENT("Array", info), _) => 
            (
                    Absyn.CONSty(
                        [ty], 
                        Absyn.LONGID(
                            NONE, 
                            Absyn.IDENT("array", info), 
                            info),
                        info)
            )
         | x => (* USER DEFINED!!!, not a TUPLE!!! *)
            (
               let val t = case(ty) of
                             Absyn.TUPLEty(tlst, _) => tlst
                           | _ => [ty]
               in
                 Absyn.CONSty(t, path2Ident x, Absyn.lidentCtxInfo(path2Ident x))
               end
            )         
                
    fun getTypeFromPath(Absyn.QUALIFIED(ident1, Absyn.PATHIDENT(ident2, _), info)) = 
        Absyn.CONSty([], Absyn.LONGID(SOME(caseType(ident1)), caseType(ident2), info), info)
    | getTypeFromPath(Absyn.PATHIDENT(ident as Absyn.IDENT(_, info), _)) = 
        Absyn.CONSty([], Absyn.LONGID(NONE, caseType(ident), info), info)
    | getTypeFromPath(Absyn.QUALIFIED(_, _, info)) = 
        errorAtFunction(info, "only one DOT in path is allowed","getTypeFromPath")
      
    fun getType(Absyn.TPATH(path, info)) = 
        getTypeFromPath(path)
    | getType(Absyn.TCOMPLEX(path, [], info)) =
        errorAtFunction(info, "type list cannot be empty!", "getType")
    | getType(Absyn.TCOMPLEX(path, typeSpecLst, info)) =
        let val ty = buildTypes(typeSpecLst)
        in 
            getComplexType(path, ty)
        end     

    and buildTypes(typeSpecLst) = 
        if List.length typeSpecLst = 1
        then getType(List.last typeSpecLst)
        else if (List.length typeSpecLst > 1)
             then Absyn.TUPLEty(map getType typeSpecLst, Absyn.dummyInfo)
             else bug("buildTypes - type cannot be empty!")    

    fun getVarTysFromList([]) = []
    |    getVarTysFromList(x::rest) = getVarTys(x) @ getVarTysFromList(rest)
             
    and getVarTys(x as Absyn.VARty(tyvar, _)) = [tyvar]
    |    getVarTys(Absyn.TUPLEty(list, _)) = getVarTysFromList(list)
    |    getVarTys(Absyn.CONSty(list, _, _)) = getVarTysFromList(list)
    |    getVarTys(Absyn.RELty(list1, list2, _)) = 
            getVarTysFromList(list1) @ getVarTysFromList(list2)
    |    getVarTys(Absyn.NAMEDty(_, ty, _)) = getVarTys(ty) 

    fun getDerivedType(identclass, typeSpec) = 
    let val ty = getType(typeSpec)
        val vartys = getVarTys ty
    in 
        Absyn.TYPBIND(
            vartys,
            identclass,
            ty,Absyn.identCtxInfo(identclass))
    end      
    
    fun fixNamedTypes([],ty) = []
    |    fixNamedTypes(Absyn.COMPONENTITEM(Absyn.COMPONENT(id,_,info),_,_)::rest,ty) = 
            Absyn.NAMEDty(id, ty, info) :: fixNamedTypes(rest, ty)
    

    fun getTypesFromRecords([]) = []
        | getTypesFromRecords(x::rest) = 
            let fun loop ([]) = [] 
                | loop(Absyn.ELEMENTITEM(
                            Absyn.ELEMENT(_,_,_,
                                ident, 
                                elementSpec as Absyn.COMPONENTS(_, typeSpec, components, _),
                                info, 
                                _),
                            infoElmItem)::elems) =
                    let val ty =  getType(typeSpec)
                    in 
                        fixNamedTypes(components,ty) @ loop(elems)
                    end
                | loop(Absyn.ANNOTATIONITEM(_,info)::rest) = 
                    (warnAtFunction(info, "ignoring annotation", "getTypes.loop"); loop(rest))
                | loop(Absyn.ELEMENTITEM(_, info)::rest) =
                    (loop(rest))
            in
              case x of
                  Absyn.PUBLIC(elementItems, _) => loop(elementItems) @ getTypesFromRecords(rest)
                | Absyn.PROTECTED(elementItems, _) => loop(elementItems) @ getTypesFromRecords(rest)
                | Absyn.EQUATIONS(_, info) => 
                    errorAtFunction(info, "equation sections are not allowed in records", "getTypesFromRecords")
                | Absyn.ALGORITHMS(algorithmItems, info) => 
                    errorAtFunction(info, "algorithm sections are not allowed in records", "getTypesFromRecords")                
                | Absyn.EXTERNAL(_,_,_,info) => 
                    errorAtFunction(info, "external function declaration sections are not allowed in records", "getTypesFromRecords")                
            end
                                            
    (* returns either a conbind or a typbind or a typevariabile *)                        
    fun sweepRecords([], uid) = []
        (* 
           normal case: constructor declarations
            record Z types end Z;
        *)                    
        (* 
            replaceable type Type_a; type variables
        *)            
        | sweepRecords( 
            Absyn.ELEMENTITEM(
                Absyn.ELEMENT(_,_,_,
                    ident, 
                    elementSpec as Absyn.CLASSDEF(_, class as 
                                Absyn.CLASS(
                                    identclass,
                                    partial,
                                    final,
                                    encapsulated,
                                    Absyn.R_TYPEVARIABLE(_),
                                    classdef as Absyn.PARTS([], _, _),
                                _),
                    _), 
                    info, 
                    _),
                _)::rest, uid) = 
                (debug("sweepRecords\n");
                 let val Absyn.IDENT(idstr, tmpInfo) = identclass
                     val varty = Absyn.IDENT("'"^idstr, tmpInfo)
                     val tyvar = Absyn.VARty(varty, tmpInfo)
                     val tybind = Absyn.TYPBIND([varty],identclass,tyvar,tmpInfo)
                 in 
                  TyV(varty)::(TyB(tybind)::sweepRecords(rest, uid))
                 end)        
        | sweepRecords(
            Absyn.ELEMENTITEM(
                Absyn.ELEMENT(_,_,_,
                    ident, 
                    elementSpec as Absyn.CLASSDEF(_, class as 
                                Absyn.CLASS(
                                    identclass,
                                    partial,
                                    final,
                                    encapsulated,
                                    Absyn.R_RECORD(_),
                                    classdef as Absyn.PARTS(classparts, _, _),
                                    _), _), 
                    info, 
                    _),
                _)::rest, uid) = 
            let val types = getTypesFromRecords(classparts)
            in
                debug("sweepRecords\n");
                if (List.length types = 0)
                then CoB(Absyn.CONcb(identclass, uid, current_modid,
                        Absyn.identCtxInfo identclass))::sweepRecords(rest, uid)
                else CoB(Absyn.CTORcb(identclass, types, 
                        Absyn.identCtxInfo identclass))::sweepRecords(rest, uid)
            end
        (* 
                type X = option<Type>            -> option type
                type O = list<Type>              -> list type
                type Y = record<Type,Type,Type>  -> tuple type
                type Z = Tree<Type>              -> uniontype with replaceable type variables
                type K = TypeSpec[:] -> _MMARRAY_<TypeSpec>
        *)   
        (* arrays: TypeSpec[:] are represented as ARRAY<TypeSpec> *)
        | sweepRecords( 
            Absyn.ELEMENTITEM(
                Absyn.ELEMENT(_,_,_,
                    ident, 
                    elementSpec as Absyn.CLASSDEF(_, class as 
                                Absyn.CLASS(
                                    identclass,
                                    partial,
                                    final,
                                    encapsulated,
                                    Absyn.R_TYPE(_),
                                    classdef,
                                _),
                    _), 
                    info, 
                    _),
                _)::rest, uid) = 
            (debug("sweepRecords\n");
             case classdef of
                (* list, option, record, polymorphic *)
                 Absyn.DERIVED(typeSpec,    _, _, _, infoDerived) =>  
                 TyB((getDerivedType(identclass, typeSpec)))
                 ::sweepRecords(rest, uid)
             | _ => errorAtFunction(info,"derived class definition expected!", "sweepRecords")
             )
        | sweepRecords(Absyn.ELEMENTITEM(_, info)::rest, uid) = 
            (warnAtFunction(info, "ignored element in uniontype!", "sweepRecords");
             sweepRecords(rest, uid))
        | sweepRecords(Absyn.ANNOTATIONITEM(_, info)::rest, uid) = 
            (warnAtFunction(info, "ignored annotation in uniontype!", "sweepRecords");
             sweepRecords(rest, uid))


    fun getTyVars([]) = []
    |    getTyVars(x::rest) = 
            case x of 
                TyV(y) => y::getTyVars(rest)
            |    _ => getTyVars(rest)
            
    fun getCons([]) = []
    |   getCons(x::rest) = 
            case x of 
                CoB(y) => y::getCons(rest)
            |    _ => getCons(rest)
    
    fun buildConstantsForConstantConstructors([], _) = ([], [])
    |   buildConstantsForConstantConstructors(CoB(Absyn.CONcb(id_record, id_uniontype, id_module, info))::rest, isPublic) = 
        let
           val name = mkIDForConstOfConstantRec(id_record, id_module)
           val ty = Absyn.CONSty([], Absyn.LONGID(NONE, id_uniontype, info), info)
           val fullRecName = 
                Absyn.LONGID(
                   if (Absyn.identName id_module) = (Absyn.identName current_modid) 
                   then NONE 
                   else SOME(id_module), 
                   id_record, info)
           val exp = Absyn.IDENTexp(fullRecName, ref(Absyn.STRUCTexp(NONE, [], info)), info)
           val valDec  = Absyn.VALdec (name, exp, info)
           val valSpec = Absyn.VALspec(name, ty, info)
           val (valDecs, valSpecs) = buildConstantsForConstantConstructors(rest, isPublic)
        in
          (valDec::valDecs, if isPublic then valSpec::valSpecs else valSpecs)
        end
    |   buildConstantsForConstantConstructors(_::rest, isPublic) = buildConstantsForConstantConstructors(rest, isPublic)
            
    fun getTypsSpec([]) = []
    |    getTypsSpec(x::rest) = 
            case x of 
                TyB(y) => Absyn.TYPEspec([y], Absyn.dummyInfo)::getTypsSpec(rest)
            |    _ => getTypsSpec(rest)

    fun getTypsDec([]) = []
    |    getTypsDec(x::rest) = 
            case x of 
                TyB(y) => Absyn.TYPEdec([y], Absyn.dummyInfo)::getTypsDec(rest)
            |    _ => getTypsDec(rest)


    fun findTyVar([], lid) = NONE
    |   findTyVar(x::rest, lid) =
        if (Absyn.identName(x) = "'" ^ Absyn.lidentName(lid))
        then SOME(x)
        else findTyVar(rest, lid)

    fun fixTypeVar(ty, tyVarLst) = 
        let 
         val [x] = fixTypeVars([ty], tyVarLst)
        in
          x
        end

    (* in uniontype we have:
       the name of the type variable without its type variable,
       so here we add it.
     *)
    and fixTypeVars([],  _) = []
    |   fixTypeVars(Absyn.CONSty([], lid,  info)::rest, tyVarlst) = 
        (case (findTyVar(tyVarlst, lid)) of
          SOME(x) => Absyn.CONSty([Absyn.VARty(x, info)], lid,  info)
        | NONE => Absyn.CONSty([], lid,  info))
        ::fixTypeVars(rest, tyVarlst)
    |   fixTypeVars(Absyn.CONSty(lst, lid,  info)::rest, tyVarlst) = 
        Absyn.CONSty(fixTypeVars(lst, tyVarlst), lid,  info)::fixTypeVars(rest, tyVarlst)
    |   fixTypeVars(Absyn.TUPLEty(lst, info)::rest, tyVarlst) = 
        Absyn.TUPLEty(fixTypeVars(lst, tyVarlst), info)::fixTypeVars(rest, tyVarlst)
    |   fixTypeVars(Absyn.RELty(input, output, info)::rest, tyVarlst) = 
        Absyn.RELty(fixTypeVars(input, tyVarlst), fixTypeVars(output, tyVarlst), info)::fixTypeVars(rest, tyVarlst)
    |   fixTypeVars(Absyn.NAMEDty(id, ty, info)::rest, tyVarlst) = 
        Absyn.NAMEDty(id, fixTypeVar(ty, tyVarlst), info)::fixTypeVars(rest, tyVarlst)

    fun fixTypeVariablesInCons([], _) = []
    |   fixTypeVariablesInCons(Absyn.CTORcb(id, tys, info)::rest, tyVarLst) =
        Absyn.CTORcb(id, fixTypeVars(tys, tyVarLst), info)::fixTypeVariablesInCons(rest, tyVarLst)
    |   fixTypeVariablesInCons(x::rest, tyVarLst) =
        x::fixTypeVariablesInCons(rest, tyVarLst)

    fun fixCONBIND([], _) = []
    |   fixCONBIND(Absyn.CTORcb(id, tys, info)::rest, bindlist) =
        Absyn.CTORcb(id, setTyseq(tys, bindlist), info)::fixCONBIND(rest, bindlist)
    |   fixCONBIND(x::rest, bindlist) =
        x::fixCONBIND(rest, bindlist)

    fun getCONBINDTyVar([], _) = []
    |   getCONBINDTyVar(Absyn.CTORcb(id, tys, info)::rest, bindlist) =
        getTyseq(tys, bindlist) @ getCONBINDTyVar(rest, bindlist)
    |   getCONBINDTyVar(x::rest, bindlist) = getCONBINDTyVar(rest, bindlist)
           
    (* this one looks inside uniontype for constructors/types/type variables *)        
    fun buildConstructors([], uid) = []
    |    buildConstructors(Absyn.PUBLIC(elementItems, _)::rest, uid) = 
            sweepRecords(elementItems, uid) @ buildConstructors(rest, uid)
    |    buildConstructors(Absyn.PROTECTED(elementItems, _)::rest, uid) = 
            sweepRecords(elementItems, uid) @ buildConstructors(rest, uid)
    |    buildConstructors(Absyn.EQUATIONS(_, info)::rest, uid) = 
            errorAtFunction(info, "equation sections are not allowed in uniontypes", "getTypesFromRecords")
    |    buildConstructors(Absyn.ALGORITHMS(algorithmItems, info)::rest, uid) =
            errorAtFunction(info, "algorithm sections are not allowed in uniontypes", "getTypesFromRecords")
    |    buildConstructors(Absyn.EXTERNAL(_,_,_,info)::rest, uid) =
            errorAtFunction(info, "external function declaration sections are not allowed in uniontypes", "getTypesFromRecords")                
                    
    fun buildDatatype (ident as Absyn.IDENT(name, info), classdef, isPublic, specs, decs) = 
        let val classparts = case classdef of
                              Absyn.PARTS(classparts, _, _) => classparts
                              | _ => 
                                errorAtFunction(
                                    info, 
                                    "only public and protected elements are allowed in uniontypes", 
                                    "buildDatatype")                
            val contytyvar_list = buildConstructors(classparts, ident)
            val tyspecs = getTypsSpec(contytyvar_list)
            val tydecs = getTypsDec(contytyvar_list)
            val cons = getCons(contytyvar_list)
            val tyvars = getTyVars(contytyvar_list)
            val (valdecs, valspecs) = buildConstantsForConstantConstructors(contytyvar_list, isPublic)
        in
            debug("buildDatatype: specs\n");
            (
            specs @
            (
            if (isPublic = true) 
            then tyspecs @ [ Absyn.DATAspec([Absyn.DATBIND(tyvars, ident, cons, info)], [], info) ] @ valspecs
            else []
            ),
            decs @
            (
            if (isPublic = false) 
            then tydecs @ [ Absyn.DATAdec([Absyn.DATBIND(tyvars, ident, cons, info)], [], info)  ] @ valdecs
            else valdecs
            )             
            )
        end
        
    fun getExpTypeAsStr(Absyn.BINARY(Exp1, Operator, Exp2, info)) = 
        ("Absyn.BINARY at "^getStringLoc(info))
    | getExpTypeAsStr(Absyn.UNARY(Operator, Exp, info)) =
        ("Absyn.UNARY at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.RELATION(Exp1,Operator,Exp2, info)) =
        ("Absyn.RELATION at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.LUNARY(Operator, Exp, info)) =
        ("Absyn.LUNARY at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.LBINARY(Exp1, Operator,Exp2, info)) = 
        ("Absyn.LBINARY at "^getStringLoc(info))     
    | getExpTypeAsStr(i as Absyn.INTEGER(x, info)) = 
        ("Absyn.INTEGER at "^getStringLoc(info))     
    | getExpTypeAsStr(r as Absyn.REAL(x, info)) = 
        ("Absyn.REAL at "^getStringLoc(info))     
    | getExpTypeAsStr(s as Absyn.STRING(x, info)) = 
        ("Absyn.STRING at "^getStringLoc(info))     
    | getExpTypeAsStr(b as Absyn.BOOL(x, info)) = 
        ("Absyn.BOOL at "^getStringLoc(info))     
    | getExpTypeAsStr(cref as Absyn.CREF(x, info)) =
        ("Absyn.CREF at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.CALL(cref, fargs, info)) =
        ("Absyn.CALL at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.TUPLE(fargs, info)) = 
        ("Absyn.TUPLE at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.MSTRUCTexp(path, fargs, info)) =
        ("Absyn.MSTRUCTexp at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.ARRAY(fargs, info)) =
        ("Absyn.ARRAY at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.IFEXP(a, b, c, d, info)) =     
        ("Absyn.IFEXP at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.MATRIX(x, info)) =
        ("Absyn.MATRIX at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.RANGE(x, y, z, info)) =
        ("Absyn.RANGE at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.END(info)) =
        ("Absyn.END at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.MWILDexp(info)) = 
        ("Absyn.MWILDexp at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.MBINDexp(_,_,info)) = 
        ("Absyn.MBINDexp at "^getStringLoc(info))     
    | getExpTypeAsStr(Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, comment, info)) =
        ("Absyn.MATCHexp at "^getStringLoc(info))     
    (****************** RELATIONS ************************)    (****************** RELATIONS ************************)
    (****************** RELATIONS ************************)    (****************** RELATIONS ************************)
    (****************** RELATIONS ************************)    (****************** RELATIONS ************************)


    fun dummyEq(str, infoEq) = 
        let val goal = Absyn.CALLgoal(
            Absyn.LONGID(NONE, Absyn.IDENT("print", infoEq), infoEq),
            [Absyn.LITexp(Absyn.SCONlit("stuff", infoEq), infoEq)],
            [], ref [],
            infoEq)
        in
            debug(str);
            (goal, infoEq)
        end            

    fun dummyFail(str, info) =    
        let
           val result = Absyn.FAIL(info)
        in
         debug(str);
         (result,  NONE,  info)    
        end

  (** Modelica+ Patterns vs. RML patterns
   Pattern = MWILDpat of info
            | MLITpat of Exp * info
            | MCONpat of Path * info
            | MSTRUCTpat of Path option * Pattern list * info
            | MBINDpat of var * Pattern * info
            | MIDENTpat of ident * Pattern ref * info
    pat = WILDpat of info
        | LITpat of lit * info
        | CONpat of longid * info
        | STRUCTpat of longid option * pat list * info
        | BINDpat of var * pat * info
        | IDENTpat of ident * pat ref * info      
    **)
    
    fun makeExpLiteral(Absyn.INTEGER(icon, info), infoLit) = Absyn.ICONlit(icon, info) 
    | makeExpLiteral(Absyn.REAL(rcon, info), infoLit) = Absyn.RCONlit(rcon, info) 
    | makeExpLiteral(Absyn.STRING(scon, info),infoLit) = Absyn.SCONlit(scon, info)
    (* Not used in MetaModelica
    | makeExpLiteral(Absyn.CHAR(ccon, info), infoLit) = Absyn.CCONlit(ccon, info)
    *)
    | makeExpLiteral(_, infoLit) = 
        errorAtFunction(infoLit, "unexpected literal expression!", "makeExpLiteral")         

        
    fun translateExpToPatIdent(info, Absyn.CREF(Absyn.CREF_IDENT(ident, _, infoId), infoCref)) =  
        (
        debug("translateExpToPatIdent: ");
        prIdentAndLoc ident;
        Absyn.IDENTpat(
            ident,
            ref(Absyn.WILDpat(Absyn.dummyInfo)),
            infoCref)        
        )
    |    translateExpToPatIdent(info, 
        Absyn.CREF(
            Absyn.CREF_QUAL(ident1, _, 
                Absyn.CREF_IDENT(ident2, _, infoId), infoCref), _)) =  
        (
        debug("translateExpToPatIdent: ");
        Absyn.CONpat(
            Absyn.LONGID(SOME(ident1), ident2, infoId), 
            infoCref)        
        )
    |    translateExpToPatIdent(info, _) = 
            errorAtFunction(info, "unexpected pattern expression", "translateExpToPatIdent")

    fun getNArgs(Absyn.FUNCTIONARGS(namedarglist, _)) = namedarglist
    |    getNArgs(Absyn.FOR_ITER_FARG(_, _, info)) = 
            errorAtFunction(info, "for iterators not implemented", "getNArgs") 

    fun translateExpToPat(Absyn.UNARY(Operator, Exp, info)) = 
        (
            case Operator of
                (* integer operators *)
                  Absyn.UPLUS(_)       => 
                  (
                    case Exp of
                        Absyn.INTEGER(x, info) => Absyn.LITpat(makeExpLiteral(Exp, info), info)
                      | _ => errorAtFunction(info, "unary integer plus operator applied to non-integer", "translateExpToPat")
                  )                  
                | Absyn.UMINUS(_)      =>
                  (
                    case Exp of
                        Absyn.INTEGER(x, info) => 
                            Absyn.LITpat(makeExpLiteral(Absyn.INTEGER(~x, info), info), info)
                      | _ => errorAtFunction(info, "unary integer minus operator applied to non-integer", "translateExpToPat")
                  )                  
                (* real operators *)
                | Absyn.UPLUS_REAL(_)  => 
                  (
                    case Exp of
                        Absyn.REAL(x, info) => Absyn.LITpat(makeExpLiteral(Exp, info), info)
                      | _ => errorAtFunction(info, "unary real plus operator applied to non-real", "translateExpToPat")
                  )                  
                | Absyn.UMINUS_REAL(_) => 
                  (
                    case Exp of
                        Absyn.REAL(x, info) => 
                            Absyn.LITpat(makeExpLiteral(Absyn.REAL(~x, info), info), info)
                      | _ => errorAtFunction(info, "unary real minus operator applied to non-real", "translateExpToPat")
                  )                                  
                | _ => errorAtFunction(info, "unexpected unary operator", "translateExpToPat") 
        )
    (* Not used in MetaModelica
    | translateExpToPat(c as Absyn.CHAR(x, info)) = 
        Absyn.LITpat(makeExpLiteral(c, info), info)
    *)
    | translateExpToPat(i as Absyn.INTEGER(x, info)) = 
        Absyn.LITpat(makeExpLiteral(i, info), info)
    | translateExpToPat(r as Absyn.REAL(x, info)) = 
        Absyn.LITpat(makeExpLiteral(r, info), info)
    | translateExpToPat(s as Absyn.STRING(x, info)) = 
        Absyn.LITpat(makeExpLiteral(s, info), info)
    | translateExpToPat(b as Absyn.BOOL(x, info)) = 
      (
        if x 
        then 
        Absyn.IDENTpat(
            Absyn.IDENT("true", info), 
            ref(Absyn.STRUCTpat(NONE, [], ref [], info)),
            info)        
        else 
        Absyn.IDENTpat(
            Absyn.IDENT("false", info), 
            ref(Absyn.STRUCTpat(NONE, [], ref [], info)),
            info)        
      )                
    | translateExpToPat(cref as Absyn.CREF(x, info)) =
        translateExpToPatIdent(info, cref)
    | translateExpToPat(Absyn.ARRAY(fargs, info)) = 
        mkpatlst (map translateExpFuncArgToPat (getNArgs fargs),info)
    | translateExpToPat(Absyn.TUPLE(fargs, info)) = 
        let val pat_seq = (getNArgs fargs)
        in
            Absyn.STRUCTpat(NONE, map translateExpFuncArgToPat pat_seq, ref [], info)
        end
    | translateExpToPat(Absyn.MSTRUCTexp(path, fargs, info)) =
        (
        case path of
            NONE    => Absyn.STRUCTpat(NONE, [], ref [], info)
        |    SOME(p) => Absyn.STRUCTpat(
                        ctor_cons info,
                        map translateExpFuncArgToPat (getNArgs fargs),
                        ref [], 
                        info)
        )
    | translateExpToPat(Absyn.CALL(cref, Absyn.FUNCTIONARGS([], _), info)) =
        let val lid = cref2Ident(cref)
        in
          (*
          case lid of
            Absyn.LONGID(NONE, _, _) => 
          *)
          translateExpToPatIdent(info, Absyn.CREF(cref, info))
          (*| _ => Absyn.CONpat(lid, info)*)
        end
    | translateExpToPat(Absyn.CALL(cref, fargs, info)) =
        let val lid = cref2Ident(cref)
        in
          Absyn.STRUCTpat(SOME(lid), map translateExpFuncArgToPat (getNArgs fargs), ref [], info)
        end
    | translateExpToPat(Absyn.MBINDexp(ident, expr, info)) =
        (
            Absyn.BINDpat(ident, translateExpToPat(expr), info)
        )
    | translateExpToPat(Absyn.MWILDexp(info)) = 
        Absyn.WILDpat(info)
    (* -- from here on, we cannot make them into patterns *)
    | translateExpToPat(Absyn.MATRIX(x, info)) =
        errorAtFunction(info, "matrix expressions are not supported in pattern", "translateExpToPat")
    | translateExpToPat(Absyn.RANGE(x, y, z, info)) =
        errorAtFunction(info, "range expressions are not supported in pattern", "translateExpToPat")
    | translateExpToPat(Absyn.END(info)) =
        errorAtFunction(info, "end expression not supported in pattern", "translateExpToPat")
    | translateExpToPat(Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, comment, info)) =
        errorAtFunction(info, "match/matchcontinue expressions are not supported in pattern", "translateExpToPat")
    |    translateExpToPat(Absyn.BINARY(Exp1, Operator, Exp2, info)) =
        errorAtFunction(info, "binary expressions are not supported in pattern", "translateExpToPat")
    | translateExpToPat(Absyn.RELATION(Exp1,Operator,Exp2, info)) =
        errorAtFunction(info, "relational expressions are not supported in pattern", "translateExpToPat")
    | translateExpToPat(Absyn.LUNARY(Operator, Exp, info)) =
        errorAtFunction(info, "logical unary expressions are not supported in pattern", "translateExpToPat")
    | translateExpToPat(Absyn.LBINARY(Exp1, Operator,Exp2, info)) = 
        errorAtFunction(info, "logical binary expressions are not supported in pattern", "translateExpToPat")
    | translateExpToPat(Absyn.IFEXP(a, b, c, d, info)) =     
        errorAtFunction(info, "if expressions are not supported in pattern", "translateExpToPat")

    and translateExpFuncArgToPat(Absyn.NAMEDARG(ident_option, exp, infoNamedArg)) = 
        (
        case ident_option of
            NONE => translateExpToPat(exp)
        |    SOME(ident) => 
            (
              Absyn.NAMEDpat(ident, translateExpToPat(exp), infoNamedArg) 
            )
        )

    fun translateExpIdent(info, Absyn.CREF(x, infoCref)) =  
        let val lid = cref2Ident(x)
            val Absyn.LONGID(_, ident, _) = lid
        in
        debug("translateExpIdent: ");
        prIdentAndLoc ident;
        Absyn.IDENTexp(
            lid, (* Absyn.LONGID(NONE, ident, infoId) *) 
            ref(Absyn.STRUCTexp(NONE,[], infoCref)),
            infoCref)        
        end
    |    translateExpIdent(info, _) = 
        errorAtFunction(info, "component reference expected", "translateExpIdent")
                    
    (* 
       look in MOToRML.sml for a version of this function that deals with
       things like expressions after the then part: "then v1+v2"
    *)
     
    (* 
    Expressions can appear in things like:
    - rel(seq_exp) => seq_pat 
      seq_pat = rel(seq_exp)
      (_, _) = call(exps)
    - let pat = exp
      pat = exp
    - var = exp
      equality(var = exp)
    - not g
      failure (g)
    *)
        
    fun getExp  (Absyn.RETURN([exp], _), goal, info) = exp
    |    getExp (_, goal, info) = bug("getExp: This shouldn't happen. RETURN([exp],...) expected!")
    
    fun getExps (Absyn.RETURN([exp], _), goal, info) = (exp, goal, info)
    |    getExps (_, goal, info) = bug("getExps: This shouldn't happen. RETURN([exp],...) expected!")
    
    fun getGoals((exp, goal, info)) = (goal, info)

    fun getSomeGoals([]) = []
    |   getSomeGoals((SOME(goal), info)::parts) = (goal, info)::getSomeGoals(parts)
    |   getSomeGoals((NONE, _)::parts) = getSomeGoals(parts)    
    
    fun getResults ((exp, goal, info)) = exp
    
    fun constructGoals([]) = bug("constructGoals.  This shouldn't happen. The goal list is empty!")
    |    constructGoals((goal, info)::[]) = goal
    |    constructGoals((goal, info)::goals) =
            Absyn.ANDgoal(goal, constructGoals(goals), info) 
            
    fun printGoal(SOME(goal)) =
        (
        Util.outStdErr(" Goal:\n       ");
        Control.withOut AbsynPrint.printGoal goal
        )
    |    printGoal(NONE) =
        (
        Util.outStdErr(" Goal:\n       NONE")
        )
            
    fun translateExp(Absyn.BINARY(Exp1, Operator, Exp2, info)) =
        let val idop = 
            case Operator of
            (* integer operators *)
              Absyn.ADD(_)        => "int_add"
            | Absyn.SUB(_)        => "int_sub"
            | Absyn.MUL(_)        => "int_mul"  
            | Absyn.DIV(_)        => "int_div"    
            (* real operators *)            
            | Absyn.ADD_REAL(_)   => "real_add"
            | Absyn.SUB_REAL(_)   => "real_sub"
            | Absyn.MUL_REAL(_)   => "real_mul"  
            | Absyn.DIV_REAL(_)   => "real_div"    
            | Absyn.POW_REAL(_)   => "real_pow"
            (* string operators *)
            | Absyn.ADD_STRING(_) => "string_append"
            (* list operators *)
            | Absyn.ADD_LIST(_)   => "list_append"
            | _ => errorAtFunction(info, "unexpected arithmetic binary operator", "translateExp") 
           val resstr = getTemp()
           val result = Absyn.RETURN(
                            [Absyn.IDENTexp(
                                Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
                                ref(Absyn.STRUCTexp(NONE,[], info)),
                                info)], 
                            info)
           val (result1, goal1, info1) = translateExp(Exp1)
           val (result2, goal2, info2) = translateExp(Exp2)
           val exp1 = getExp(result1, goal1, info1)
           val exp2 = getExp(result2, goal2, info2)
           val lastGoal = 
                  SOME(Absyn.CALLgoal(
                        Absyn.LONGID(NONE,
                            Absyn.makeIdent(idop, info), 
                            info),
                        [exp1, exp2],
                        [Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
                                        ref(Absyn.WILDpat(info)), 
                                        info)],
                        ref [],
                        info))           
           val goals = getSomeGoals([(goal1,info1),(goal2,info2),(lastGoal,info)])
           val joinedGoals = constructGoals(goals)
           val g = SOME(joinedGoals)
        in
         debug("translateExp-Binary: "^idop^"() => "^resstr^"\n");
         (result, g, info)
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
                | _ => errorAtFunction(info, "unexpected arithmetic unary operator", "translateExp") 
           val resstr = getTemp()
           val result = Absyn.RETURN(
                [Absyn.IDENTexp( 
                    Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info), 
                    ref(Absyn.STRUCTexp(NONE,[], info)),
                    info)], 
                info)
           val (result1, goal1, info1) = translateExp(Exp)
           val exp1 = getExp(result1, goal1, info1)
           val lastGoal = 
                  SOME(
                  Absyn.CALLgoal(
                        Absyn.LONGID(NONE,
                            Absyn.makeIdent(idop, info),
                            info),
                            [exp1],
                        [Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
                                        ref(Absyn.WILDpat(info)), 
                                        info)],
                        ref [],
                        info)
                 )           
           val goals = getSomeGoals([(goal1,info1),(lastGoal,info)])
           val joinedGoals = constructGoals(goals)
           val g = SOME(joinedGoals)
        in
         debug("translateExp-Unary\n");                 
         (result, g, info)
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
            (* string operators *)
            | Absyn.EQEQ_STRING(_)    => "string_equal"  
            | _ => errorAtFunction(info, "unexpected relational binary operator", "translateExp")
           val resstr = getTemp()
           val result = Absyn.RETURN(
                            [Absyn.IDENTexp(
                                Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
                                ref(Absyn.STRUCTexp(NONE,[], info)),
                                info)], 
                            info)
           val (result1, goal1, info1) = translateExp(Exp1)
           val (result2, goal2, info2) = translateExp(Exp2)
           val exp1 = getExp(result1, goal1, info1)
           val exp2 = getExp(result2, goal2, info2)
           val lastGoal = 
                  SOME(
                  Absyn.CALLgoal(
                        Absyn.LONGID(NONE,
                            Absyn.makeIdent(idop, info), 
                            info),
                            [exp1, exp2],
                        [Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
                                        ref(Absyn.WILDpat(info)), 
                                        info)],
                        ref [],
                        info))           
           val goals = getSomeGoals([(goal1,info1),(goal2,info2),(lastGoal,info)])
           val joinedGoals = constructGoals(goals)
           val g = SOME(joinedGoals)
        in
         debug("translateExp-RelationalBinary\n");
         (result, g, info)
        end    
    | translateExp(Absyn.LUNARY(Operator, Exp, info)) =
        let val idop = 
            case Operator of
                (* logical boolean unary operator *)
                  Absyn.NOT(_)       => "bool_not"
                | _ => errorAtFunction(info, "unexpected logical unary operator", "translateExp")
           val resstr = getTemp()
           val result = Absyn.RETURN(
                [Absyn.IDENTexp( 
                    Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info), 
                    ref(Absyn.STRUCTexp(NONE,[], info)),
                    info)], 
                info)
           val (result1, goal1, info1) = translateExp(Exp)
           val exp1 = getExp(result1, goal1, info1)
           val lastGoal = 
                      SOME(
                      Absyn.CALLgoal(
                            Absyn.LONGID(NONE,
                                Absyn.makeIdent(idop, info),
                                info),
                                [exp1],
                            [Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
                                            ref(Absyn.WILDpat(info)), 
                                            info)],
                            ref [],
                            info))           
           val goals = getSomeGoals([(goal1,info1),(lastGoal,info)])
           val joinedGoals = constructGoals(goals)
           val g = SOME(joinedGoals)
        in
         debug("translateExp-LogicalUnary\n");                 
         (result, g, info)
        end
    | translateExp(Absyn.LBINARY(Exp1, Operator,Exp2, info)) = 
        let val idop = 
            case Operator of
              Absyn.AND(_) => "bool_and"  
            | Absyn.OR(_)  => "bool_or" 
            | _ => errorAtFunction(info, "unexpected logical binary operator", "translateExp")
           val resstr = getTemp()
           val result = Absyn.RETURN(
                            [Absyn.IDENTexp(
                                Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
                                ref(Absyn.STRUCTexp(NONE,[], info)),
                                info)], 
                            info)
           val (result1, goal1, info1) = translateExp(Exp1)
           val (result2, goal2, info2) = translateExp(Exp2)
           val exp1 = getExp(result1, goal1, info1)
           val exp2 = getExp(result2, goal2, info2)
           val lastGoal = 
                  SOME(
                  Absyn.CALLgoal(
                        Absyn.LONGID(NONE,
                            Absyn.makeIdent(idop, info), 
                            info),
                        [exp1, exp2],
                        [Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
                                        ref(Absyn.WILDpat(info)), 
                                        info)],
                        ref [],
                        info)
                  )           
           val goals = getSomeGoals([(goal1,info1),(goal2,info2),(lastGoal,info)])
           val joinedGoals = constructGoals(goals)
           val g = SOME(joinedGoals)                            
        in
         debug("translateExp-LogicalBinary\n");
         (result, g, info)
        end
    (* Not used in MetaModelica
    | translateExp(c as Absyn.CHAR(x, info)) = 
        ( Absyn.RETURN([Absyn.LITexp(makeExpLiteral(c, info), info)], info), NONE, info)
    *)
    | translateExp(i as Absyn.INTEGER(x, info)) = 
        ( Absyn.RETURN([Absyn.LITexp(makeExpLiteral(i, info), info)], info), NONE, info)
    | translateExp(r as Absyn.REAL(x, info)) = 
        ( Absyn.RETURN([Absyn.LITexp(makeExpLiteral(r, info), info)], info), NONE, info)
    | translateExp(s as Absyn.STRING(x, info)) = 
        ( Absyn.RETURN([Absyn.LITexp(makeExpLiteral(s, info), info)], info), NONE, info)
    | translateExp(b as Absyn.BOOL(x, info)) = 
        ( Absyn.RETURN([
                if x
                then Absyn.IDENTexp(
                        Absyn.LONGID(NONE, Absyn.IDENT("true", info), info), 
                        ref(Absyn.STRUCTexp(NONE,[], info)),
                        info)
                else Absyn.IDENTexp(
                        Absyn.LONGID(NONE, Absyn.IDENT("false", info), info), 
                        ref(Absyn.STRUCTexp(NONE,[], info)),
                        info)
                ], info), NONE, info)
    | translateExp(cref as Absyn.CREF(x, info)) =
        let val result = Absyn.RETURN([translateExpIdent(info,cref)], info)
        in 
            debug("translateExp: CREF\n");
            (result, NONE, info) 
        end
    | translateExp(Absyn.CALL(cref, FunctionArgs as Absyn.FUNCTIONARGS(Exps as [], infoFArgs), info)) =
        let val lid = cref2Ident(cref)
        in
          if Absyn.lidentName lid = "fail"
          then (Absyn.FAIL(info), NONE, info)
          else let val restr = lookupLIdent(lid)  
                in
                case restr of 
                    SOME(Absyn.R_FUNCTION(_)) => 
                    let val resstr = getTemp()
                        val result = Absyn.RETURN(
                                            [Absyn.IDENTexp(
                                                Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
                                                ref(Absyn.STRUCTexp(NONE,[], info)),
                                                info)], 
                                            info)                
                        val resexplist = map getExps (map translateExpFuncArg Exps)
                        val reslist = map getResults resexplist
                        val goals = getSomeGoals(map getGoals resexplist)
                        val pat = [Absyn.IDENTpat(Absyn.makeIdent(resstr, info), ref(Absyn.WILDpat(info)), info)]
                        val lastGoal = 
                            if (Absyn.lidentName lid = "fill")
                            then Absyn.CALLgoal(
                                    Absyn.LONGID(NONE,Absyn.makeIdent("arrayCreate", Absyn.lidentCtxInfo(lid)), Absyn.lidentCtxInfo(lid)), 
                                    List.rev reslist,
                                    pat,
                                    ref [],
                                    info)                                
                            else Absyn.CALLgoal(lid, reslist, pat, ref [], info)
                    in
                        if ((List.length goals) = 0)
                        then (result, SOME(lastGoal), info)
                        else (result, SOME(Absyn.ANDgoal(constructGoals(goals), lastGoal, info)), info)
                    end
                |   SOME(Absyn.R_RECORD(_)) => (* record *)
                    let (* use defined constant for constant records *)
                       val lid = case lid of 
                                    Absyn.LONGID(SOME(id1), id2, inf) => 
                                       Absyn.LONGID(SOME(id1), mkIDForConstOfConstantRec(id2, id1), inf)
                                 |  Absyn.LONGID(NONE, id2, inf) =>
                                       if Absyn.identName id2 = "NONE" 
                                       then lid
                                       else Absyn.LONGID(NONE, mkIDForConstOfConstantRec(id2, current_modid), inf)
                    in
                    (
                    Absyn.RETURN([Absyn.IDENTexp(lid, ref(Absyn.STRUCTexp(NONE,[], info)), info)], info),
                    NONE,
                    info
                    )
                    end
                |   _ => (* who knows! *)
                    (
                    Absyn.RETURN([Absyn.IDENTexp(lid, ref(Absyn.STRUCTexp(NONE,[], info)), info)], info),
                    NONE,
                    info
                    )
                end
        end
    | translateExp(Absyn.CALL(cref, FunctionArgs as Absyn.FUNCTIONARGS(Exps, infoFArgs), info)) =
        let val lid = cref2Ident(cref)
        in
          if Absyn.lidentName lid = "fail"
          then (Absyn.FAIL(info), NONE, info)
          else let val restr = lookupLIdent(lid)  
                in
                case restr of 
                    SOME(Absyn.R_FUNCTION(_)) => 
                    let val resstr = getTemp()
                        val result = Absyn.RETURN(
                                            [Absyn.IDENTexp(
                                                Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
                                                ref(Absyn.STRUCTexp(NONE,[], info)),
                                                info)], 
                                            info)                
                        val resexplist = map getExps (map translateExpFuncArg Exps)
                        val reslist = map getResults resexplist
                        val goals = getSomeGoals(map getGoals resexplist)
                        val pat = [Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
                                    ref(Absyn.WILDpat(info)), 
                                    info)]                        
                        val lastGoal = 
                            if (Absyn.lidentName lid = "fill")
                            then Absyn.CALLgoal(
                                            Absyn.LONGID(NONE,
                                                Absyn.makeIdent(
                                                    "arrayCreate", 
                                                    Absyn.lidentCtxInfo(lid)),
                                                Absyn.lidentCtxInfo(lid)), 
                                            List.rev reslist,
                                            pat,
                                            ref [],
                                            info)                                
                            else Absyn.CALLgoal(lid, reslist, pat, ref [], info)                    
                    in
                        if ((List.length goals) = 0)
                        then ( result, SOME(lastGoal), info )
                        else (result, SOME( Absyn.ANDgoal(constructGoals(goals), lastGoal, info)),info)
                    end
                | _ =>
                    (
                    Absyn.RETURN([
                    Absyn.STRUCTexp(
                        SOME lid, 
                        map getExp (map translateExpFuncArg (getNArgs FunctionArgs)), 
                        info)],
                    info),
                    NONE,
                    info
                    )                
                end
        end
    | translateExp(Absyn.TUPLE(fargs, info)) = 
        let val exp_seq = (getNArgs fargs)
            val results = (map translateExpFuncArg exp_seq)
            val exps = map getExp results
            val goals = getSomeGoals(map getGoals results)
            val g = if List.length goals = 0 then NONE else SOME(constructGoals(goals))
        in
            (
            Absyn.RETURN([
            if !translatingThen = false (* we are in expressions, this: (x) IS NOT a tuple!! *)
            then
                if List.length exps = 1 (* this is no tuple *)
                then List.hd exps
                else Absyn.STRUCTexp(NONE, exps, info)
            else  (* we are in patterns, this: (x) IS a tuple!! *)
                Absyn.STRUCTexp(NONE, exps, info)
            ], info),
            g,
            info
            )
        end
    | translateExp(Absyn.MSTRUCTexp(path, fargs, info)) =
        (
        Absyn.RETURN([(
        case path of
            NONE    => Absyn.STRUCTexp(NONE, [], info)
        |    SOME(p) => Absyn.STRUCTexp(
                        ctor_cons info,
                        map getExp (map translateExpFuncArg (getNArgs fargs)), 
                        info)
        )], info),
        NONE,
        info
        )
    | translateExp(Absyn.ARRAY(fargs, info)) =
        (
        Absyn.RETURN([ 
        mkexplst (map getExp (map translateExpFuncArg (getNArgs fargs)), info)
        ], info),
        NONE,
        info
        )
    | translateExp(Absyn.IFEXP(a, b, c, [], info)) =
      let val _ = 
            if debugFlag 
            then Util.outStdErr("\nAbsyn.IFEXP("^getExpTypeAsStr(a)^","^getExpTypeAsStr(b)^","^getExpTypeAsStr(c)^")\n")
            else ()
          val resstr = getTemp()
          val result = Absyn.RETURN(
							          [Absyn.IDENTexp(
								          Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
								          ref(Absyn.STRUCTexp(NONE,[], info)),
								          info)], 
							          info)		
          val pat = Absyn.IDENTpat(
                                Absyn.makeIdent(resstr, info),
                                ref(Absyn.WILDpat(info)), 
                                info)
          val (result1, goal1, info1) = translateExp(a)
          (* bind the result of the condition expression to resstrCond! *)
          val resstrCond = getTemp()
          val patCond = Absyn.IDENTpat(
                                Absyn.makeIdent(resstrCond, info1),
                                ref(Absyn.WILDpat(info1)),
                                info1)
          val identCond = Absyn.IDENTexp(
                                Absyn.LONGID(NONE, Absyn.makeIdent(resstrCond, info1), info1),
                                ref(Absyn.STRUCTexp(NONE,[], info1)),
                                info1)

          val (result2, goal2, info2) = translateExp(b)
          val (result3, goal3, info3) = translateExp(c)
          val exp1 = getExp(result1, goal1, info1)
          val exp2 = getExp(result2, goal2, info2)
          val exp3 = getExp(result3, goal3, info3)          
          val condGoal = case goal1 of 
                        SOME(Absyn.CALLgoal(lid, exps, pats, _, infoC)) (* was a call, bind it to patCond! *)
                        => Absyn.CALLgoal(lid, exps, [patCond], ref [], info1)
                    |    NONE => Absyn.LETgoal(patCond, exp1, info1) (* was an expression, bind it to patCond! *)
                    |    SOME(g) => Absyn.ANDgoal(g, Absyn.LETgoal(patCond, exp1, info1), info1)
          val thenGoal = case goal2 of 
                        SOME(Absyn.CALLgoal(lid, exps, pats, _, infoC)) (* was a call, try to make it equal result *)
                        => Absyn.CALLgoal(lid, exps, [pat], ref [], info2)
                    |    NONE => Absyn.LETgoal(pat, exp2, info3) (* was an expression, asign it to the result! *)
                    |    SOME(g) => Absyn.ANDgoal(g, Absyn.LETgoal(pat, exp2, info2), info2)  
                    
          val elseGoal = case goal3 of 
                        SOME(Absyn.CALLgoal(lid, exps, pats, _, infoC)) (* was a call, try to make it equal result *)
                        => Absyn.CALLgoal(lid, exps, [pat], ref [], info2)
                    |    NONE => Absyn.LETgoal(pat, exp3, info3) (* was an expression, asign it to the result! *)
                    |    SOME(g) => Absyn.ANDgoal(g, Absyn.LETgoal(pat, exp3, info3), info3)
          val lastGoal = Absyn.ANDgoal(condGoal, Absyn.IFgoal(identCond, thenGoal, elseGoal, info), info)
          (*
          val _ = (Util.outStdErr("\nCumulative:"); printGoal(SOME(lastGoal));
                                    Util.outStdErr("\nCond:");  printExp(identCond);
                                    Util.outStdErr("\nThen:");  printGoal(SOME(thenGoal));
                                    Util.outStdErr("\nElse:");  printGoal(SOME(elseGoal)))
          *)
      in
            (result, SOME(lastGoal), info)
      end        
      (*
      let val _ = 
            if debugFlag 
            then Util.outStdErr("\nAbsyn.IFEXP("^getExpTypeAsStr(a)^","^getExpTypeAsStr(b)^","^getExpTypeAsStr(c)^")\n")
            else ()
          val resstr = getTemp()
          val result = Absyn.RETURN(
                            [Absyn.IDENTexp(
                                Absyn.LONGID(NONE, Absyn.makeIdent(resstr, info), info),
                                ref(Absyn.STRUCTexp(NONE,[], Absyn.dummyInfo)),
                                info)], 
                            info)                
          val (result1, goal1, info1) = translateExp(a)
          val (result2, goal2, info2) = translateExp(b)
          val (result3, goal3, info3) = translateExp(c)
          val pat = [Absyn.IDENTpat(Absyn.makeIdent(resstr, info), 
                    ref(Absyn.WILDpat(info)), 
                    info)]                        
          val exp1 = getExp(result1, goal1, info1)
          val exp2 = getExp(result2, goal2, info2)
          val exp3 = getExp(result3, goal3, info3)
          val lastGoal = SOME(Absyn.CALLgoal(
                            Absyn.LONGID(modidRML info1,
                                Absyn.makeIdent(
                                    "if_exp", 
                                    info1),
                                info2), 
                            [exp1,exp2,exp3],
                            pat,
                            ref [],
                            info))
          val goals = getSomeGoals([(goal1,info1),(goal2,info2),(goal3,info3),(lastGoal,info)])
          val joinedGoals = constructGoals(goals)
          val g = SOME(joinedGoals)
          val _ = if debugFlag then (Util.outStdErr("\nCumulative:"); printGoal(g);
                                    Util.outStdErr("\nSeparate1:");  printGoal(goal1);
                                    Util.outStdErr("\nSeparate2:");  printGoal(goal2);
                                    Util.outStdErr("\nSeparate3:");  printGoal(goal3))
                               else ()
      in
            (result, g,    info)
       end
     *)        
    | translateExp(Absyn.IFEXP(a, b, c, d, info)) =        
        errorAtFunction(info, "currently MetaModelica supports only if expressions of the form: if exp then exp else exp", "translateExp")
    | translateExp(Absyn.MATRIX(x, info)) =
        errorAtFunction(info, "unexpected if expression matrix expression", "translateExp")    
    | translateExp(Absyn.RANGE(x, y, z, info)) =
        errorAtFunction(info, "unexpected range expression", "translateExp")        
    | translateExp(Absyn.END(info)) =
        errorAtFunction(info, "unexpected end expression", "translateExp")        
    | translateExp(Absyn.MWILDexp(info)) = 
        errorAtFunction(info, "unexpected wild expression", "translateExp")        
    | translateExp(Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, comment, info)) =
        errorAtFunction(info, "unexpected match expression", "translateExp")        
    | translateExp(_) =
        bug("translateExp: unexpected expression")

    and translateExpFuncArg(Absyn.NAMEDARG(NONE, exp, infoNamedArg)) = 
        translateExp(exp)
    |    translateExpFuncArg(Absyn.NAMEDARG(_, _, info)) = 
        errorAtFunction(info, "unexpected named argument in expression", "translateExpFuncArg")
        
            
    fun transformPattern(pattern) = 
        case pattern of
          Absyn.MWILDpat(info)      => Absyn.WILDpat(info)
        | Absyn.MLITpat(Exp, info)  => Absyn.LITpat(makeExpLiteral(Exp, info), info)
        | Absyn.MCONpat(path, info) => Absyn.CONpat(path2Ident(path), info)
        | Absyn.MSTRUCTpat(path, patterns, info) => 
                (case path of 
                    SOME(path') => Absyn.STRUCTpat(SOME(path2Ident(path')), extractPatterns(patterns), ref [], info)
                    | NONE => Absyn.STRUCTpat(NONE, extractPatterns(patterns), ref [], info))
        | Absyn.MBINDpat(var, pat, info) => Absyn.BINDpat(var, transformPattern(pat), info)
        | Absyn.MNAMEDARGpat(var, pat, info) => 
            Absyn.NAMEDpat(var,transformPattern(pat),info)
        | Absyn.MIDENTpat(ident, ref(pat), info) => 
            Absyn.IDENTpat(ident, ref(transformPattern(pat)), info)
        
    and extractPatterns(patterns) = 
         map transformPattern patterns

    fun translateValExp(exp) = 
    let val (result, goal, info) = translateExp(exp)
    in
        case result of
            Absyn.RETURN([x], info) => x
        |    _ => 
            errorAtFunction(info, "unexpected expression at initialization", "translateValExp")
    end

    
    fun makeExpFromMod(Absyn.CLASSMOD(_, NONE, info)) = 
        errorAtFunction(
            info, 
            "only component declaration of the form: [constant] TypeName x [= expression]; are allowed", 
            "makeExpFromMod")
    |    makeExpFromMod(Absyn.CLASSMOD(_, SOME(mexp), info)) =
         translateValExp(mexp)

    fun getExpFromModication(modif) =         
    let val exp = 
            case modif of
                NONE => NONE
            |    SOME(modification) => SOME(makeExpFromMod(modification))
    in
        exp
    end
    

        
    fun translateEqualsEquation(exp1, exp2, infoEq) =
    (
        debug("translateEqualsEquation: ["^getExpTypeAsStr(exp1)^"] = ["^getExpTypeAsStr(exp2)^"\n");
        case (exp1, exp2) of 
           (_, Absyn.BINARY(exp21, oper, exp22, infoBin)) 
                =>
                let val (result, goal, info) = translateExp(exp2)
                in
                    case goal of 
                        SOME(Absyn.CALLgoal(lid, exps, pats, _, infoEq)) 
                        => (Absyn.CALLgoal(lid, exps, [translateExpToPat exp1], ref [], infoEq), infoEq)
                    |    SOME(g) 
                        => (Absyn.ANDgoal(g, 
                                Absyn.LETgoal(translateExpToPat exp1, getExp((result, goal, info)), infoBin), infoEq),
                            infoEq)
                    |    _ => bug("translateEqualsEquation: BINARY, expected SOME(goal) from translateExp")
                end            
        |    (_, Absyn.UNARY(oper, exp21, infoUnary)) 
                =>
                let val (result, goal, info) = translateExp(exp2)
                in
                    case goal of 
                        SOME(Absyn.CALLgoal(lid, exps, pats, _, infoEq)) 
                        => (Absyn.CALLgoal(lid, exps, [translateExpToPat exp1], ref [], infoEq), infoEq)
                    |    SOME(g) => 
                            (Absyn.ANDgoal(g, 
                                Absyn.LETgoal(
                                    translateExpToPat exp1, 
                                    getExp((result, goal, info)),
                                    infoUnary),
                            infoEq),
                            infoEq)
                    |    _ => bug("translateEqualsEquation: UNARY, expected SOME(goal) from translateExp")
                end            

        (*
        | (Absyn.CREF(ComponentRef1 as Absyn.CREF_IDENT(ident1, _, infoId1), infoExp1),
           Absyn.CALL(ComponentRef2 as Absyn.CREF_IDENT(ident2, _, infoId2),  
                                   FunctionArgs as Absyn.FUNCTIONARGS(Exps, infoFArgs),
                                   infoExp2)) 
                =>
                let val goal = Absyn.CALLgoal(
                    Absyn.LONGID(NONE, ident2, infoId2),
                    map getExp (map translateExpFuncArg Exps),
                    [translateExpToPatIdent(infoExp1, exp1)],
                    ref [], 
                    infoEq)
                in
                    (goal, infoEq)
                end    
        *)
        (* (x ==. y) = true *)
        | (Absyn.TUPLE(Absyn.FUNCTIONARGS([Absyn.NAMEDARG(NONE, exprel as Absyn.RELATION(_), _)], _), _), _) 
                =>
                let val pat = translateExpToPat exp2
                    val (result, goal, info) = translateExp(exprel)
                in
                    (case goal of
                        SOME(Absyn.CALLgoal(id, exps, pats, ref_pat, info)) 
                        => Absyn.CALLgoal(id, exps, [pat], ref_pat, info)
                    |    SOME(g) 
                        =>  Absyn.ANDgoal(g, Absyn.LETgoal(translateExpToPat exp2, getExp((result, goal, info)), infoEq), infoEq)
                    |    _ => 
                    errorAtFunction(
                        infoEq,
                        "expected equation form: output expression list = function call;",
                        "translateEqualsEquation")
                    , infoEq)
                end        
        (* x ==. y = true *)                
        | (exprel as Absyn.RELATION(_), _) 
                =>
                let val pat = translateExpToPat exp2
                    val (result, goal, info) = translateExp(exprel)
                in
                    (case goal of
                        SOME(Absyn.CALLgoal(id, exps, pats, ref_pat, info)) =>
                            Absyn.CALLgoal(id, exps, [pat], ref_pat, info)
                    |    SOME(g) => 
                            Absyn.ANDgoal(g, Absyn.LETgoal(translateExpToPat exp2, getExp((result, goal, info)), infoEq),
                            infoEq)
                    |    _ => 
                    errorAtFunction(
                        infoEq,
                        "expected equation form: output expression list = function call;",
                        "translateEqualsEquation")
                    , infoEq)
                end                        
        (* z == (x > y) *)        
        | (_, Absyn.TUPLE(Absyn.FUNCTIONARGS([Absyn.NAMEDARG(NONE, exprel as Absyn.RELATION(_), _)], _), _)) 
                =>
                let val pat = translateExpToPat exp1
                    val (result, goal, info) = translateExp(exprel)
                in
                    (case goal of
                        SOME(Absyn.CALLgoal(id, exps, pats, ref_pat, info)) 
                        => Absyn.CALLgoal(id, exps, [pat], ref_pat, info)
                    |    SOME(g) 
                        => Absyn.ANDgoal(g, Absyn.LETgoal(translateExpToPat exp1, getExp((result, goal, info)), infoEq), infoEq)
                    |    _ => 
                    errorAtFunction(
                        infoEq,
                        "expected equation form: output expression list = function call;",
                        "translateEqualsEquation")
                    , infoEq)
                end                
        (* z == x > y *)        
        | (_, exprel as Absyn.RELATION(_)) 
                =>
                let val pat = translateExpToPat exp1
                    val (result, goal, info) = translateExp(exprel)
                in
                    (case goal of
                        SOME(Absyn.CALLgoal(id, exps, pats, ref_pat, info)) 
                        => Absyn.CALLgoal(id, exps, [pat], ref_pat, info)
                    |    SOME(g) 
                        => Absyn.ANDgoal(g, Absyn.LETgoal(translateExpToPat exp1, getExp((result, goal, info)),infoEq),infoEq)
                    |    _ => 
                    errorAtFunction(
                        infoEq,
                        "expected equation form: output expression list = function call;",
                        "translateEqualsEquation")
                    , infoEq)
                end                
        | (_, Absyn.CALL(cref, FunctionArgs as Absyn.FUNCTIONARGS(Exps, infoFArgs), infoExp2)) 
                =>
                let val lid   = cref2Ident(cref)
                    val restr = lookupLIdent(lid)  
                in
                    case restr of 
                        SOME(Absyn.R_FUNCTION(_)) => 
                        let val pat = translateExpToPat exp1
                            val resexplist = map getExps (map translateExpFuncArg Exps)
                            val reslist = map getResults resexplist
                            val goals = getSomeGoals(map getGoals resexplist)
                            val lastGoal = 
                                if (Absyn.lidentName lid = "fill")
                                then Absyn.CALLgoal(
                                                Absyn.LONGID(NONE,
                                                    Absyn.makeIdent(
                                                        "arrayCreate", 
                                                        Absyn.lidentCtxInfo(lid)),
                                                    Absyn.lidentCtxInfo(lid)), 
                                                List.rev reslist,
                                                case pat of
                                                Absyn.STRUCTpat(NONE, pat_list, _, _) => pat_list
                                                | _ => [pat],
                                                ref [],
                                                infoEq)                                
                                else Absyn.CALLgoal(
                                                lid, 
                                                reslist,
                                                case pat of
                                                Absyn.STRUCTpat(NONE, pat_list, _, _) => pat_list
                                                | _ => [pat],
                                                ref [],
                                                infoEq)
                        in
                            if ((List.length goals) = 0)
                            then (lastGoal, infoEq)
                            else (Absyn.ANDgoal(constructGoals(goals), lastGoal, infoEq), infoEq)
                        end
                    |   SOME(Absyn.R_RECORD(_)) => (* let goal *)
                        let 
                            val goal = Absyn.LETgoal(translateExpToPat exp1, getExp(translateExp exp2), infoEq)
                        in
                            (goal, infoEq)
                        end
                    |    NONE => (* try a callgoal *)
                        let val pat = translateExpToPat exp1
                            val resexplist = map getExps (map translateExpFuncArg Exps)
                            val reslist = map getResults resexplist
                            val goals = getSomeGoals(map getGoals resexplist)
                            val lastGoal = 
                                if (Absyn.lidentName lid = "fill")
                                then Absyn.CALLgoal(
                                                Absyn.LONGID(NONE,
                                                    Absyn.makeIdent(
                                                        "arrayCreate", 
                                                        Absyn.lidentCtxInfo(lid)),
                                                    Absyn.lidentCtxInfo(lid)),
                                                List.rev reslist,
                                                case pat of
                                                Absyn.STRUCTpat(NONE, pat_list, _, _) => pat_list
                                                | _ => [pat],
                                                ref [],
                                                infoEq)                                
                                else Absyn.CALLgoal(
                                                lid, 
                                                reslist,
                                                case pat of
                                                Absyn.STRUCTpat(NONE, pat_list, _, _) => pat_list
                                                | _ => [pat],
                                                ref [],
                                                infoEq)
                        in
                            if ((List.length goals) = 0)
                            then 
                            (
                            lastGoal,
                            infoEq
                            )
                            else
                            let 
                            in
                                (
                                Absyn.ANDgoal(
                                    constructGoals(goals), 
                                    lastGoal, 
                                    infoEq), 
                                infoEq
                                )
                            end
                        end
                    |   _ => 
                    errorAtFunction(
                        infoEq,
                        "expected equation form: _ = function call;",
                        "translateEqualsEquation")
                end                            
        | (_, _) => (* if nothing worked try a LETgoal *)
                let val (res, g, info) = translateExp(exp2)
                    val goal = 
                            Absyn.LETgoal(translateExpToPat exp1, getExp((res, g, info)), infoEq)
                in
                    (case g of 
                       NONE => goal 
                     | SOME(gl) => Absyn.ANDgoal(gl, goal, infoEq), infoEq)
                end        
    )
    
    fun buildGoalz(Absyn.EQUATIONITEM(equation, _, info)) =
    (
        debug("buildGoalz\n"); 
        (case equation of 
             (* v1 = func(functionargs) *)
              Absyn.EQ_EQUALS(exp1, exp2, infoEq) =>
                translateEqualsEquation(exp1, exp2, infoEq)
            | Absyn.EQ_NORETCALL(ComponentRef,  
                                 FunctionArgs as Absyn.FUNCTIONARGS(Exps, infoFArgs),
                                 infoEq) => 
                let val exp1 = 
                        Absyn.MSTRUCTexp(
                            NONE,   
                            Absyn.FUNCTIONARGS([], infoEq),                
                            infoEq)
                    val exp2 = Absyn.CALL(ComponentRef, FunctionArgs, infoEq)                
                in
                  translateEqualsEquation(exp1, exp2, infoEq)
                end                                       
            | Absyn.EQ_FAILURE(eq, info) =>
                let val (goal, infoEq) = buildGoalz(Absyn.EQUATIONITEM(eq, NONE, info))
                in
                 (Absyn.NOTgoal(goal, info),info)
                end
            | Absyn.EQ_EQUALITY(Absyn.EQ_EQUALS(Absyn.CREF(cref, _), exp2, infoEq), info) => 
                (
                Absyn.EQUALgoal(getShortId(cref2Ident cref), getExp(translateExp(exp2)), info),
                info
                )
            | Absyn.EQ_IF(cond, thenBranch, [], elseBranch, info) => (* no elseif! *)
                      let val (result1, goal1, info1) = translateExp(cond)
                          (* bind the result of the condition expression to resstrCond! *)
                          val resstrCond = getTemp()
                          val patCond = Absyn.IDENTpat(
                                                Absyn.makeIdent(resstrCond, info1),
                                                ref(Absyn.WILDpat(info1)), 
                                                info1)
                          val identCond = Absyn.IDENTexp(
                                                Absyn.LONGID(NONE, Absyn.makeIdent(resstrCond, info1), info1),
                                                ref(Absyn.STRUCTexp(NONE,[], info1)),
                                                info1)
                          val exp1 = getExp(result1, goal1, info1)
                          val condGoal = case goal1 of 
                                        SOME(Absyn.CALLgoal(lid, exps, pats, _, infoC)) (* was a call, bind it to patCond! *)
                                        => Absyn.CALLgoal(lid, exps, [patCond], ref [], info1)
                                    |    NONE => Absyn.LETgoal(patCond, exp1, info1) (* was an expression, bind it to patCond! *)
                                    |    SOME(g) => Absyn.ANDgoal(g, Absyn.LETgoal(patCond, exp1, info1), info1)
                          val (thenGoal, infoThen) = buildNonEmptyGoals(thenBranch, Absyn.MWILDexp(info), info)
                          val (elseGoal, infoElse) = buildNonEmptyGoals(elseBranch, Absyn.MWILDexp(info), info)
                          val lastGoal = Absyn.ANDgoal(condGoal, Absyn.IFgoal(identCond, thenGoal, elseGoal, info), info)
                          (*
                          val _ = (Util.outStdErr("\nCumulative:"); printGoal(SOME(lastGoal));
                                                    Util.outStdErr("\nThen:");  printGoal(SOME(thenGoal));
                                                    Util.outStdErr("\nElse:");  printGoal(SOME(elseGoal)))
                          *)
                      in
                            (lastGoal, info)
                      end        

                (* errorAtFunction(info,"unexpected if equation","buildGoalz") *)
            | Absyn.EQ_CONNECT(_, _, info) =>
                errorAtFunction(info,"unexpected connect equation","buildGoalz")
            | Absyn.EQ_FOR(_, _, info) =>
                errorAtFunction(info,"unexpected for equation","buildGoalz")
            | Absyn.EQ_WHEN_E(_, _, _, info) =>
                errorAtFunction(info,"unexpected when equation","buildGoalz")
            | _ =>     
                errorAtFunction(info,"unexpected equation","buildGoalz")
        )
    )
    |   buildGoalz(Absyn.EQUATIONITEMANN(_, info)) = 
            errorAtFunction(info,"unexpected annotation","buildGoalz")

    and buildNonEmptyGoals(x::nil, exp, infoGoal) = buildGoalz(x)
    |   buildNonEmptyGoals(x::rest, exp,  infoGoal) =
        let val (goal1, info1) = buildGoalz(x)
            val (goal2, info2) = buildNonEmptyGoals(rest, exp, infoGoal)
        in
            (
            Absyn.ANDgoal(goal1, goal2, mkCtxInfo(info1, info2)), 
            mkCtxInfo(info1, info2)
            )
        end    
    |    buildNonEmptyGoals([], exp, infoGoal) = 
      let   
         val dummyExp = Absyn.LITexp(Absyn.ICONlit(1, info), info)
         val dummyGoal = Absyn.LETgoal(Absyn.WILDpat(infoGoal), dummyExp, infoGoal) (* make a dummy goal! *)
      in
         (dummyGoal, infoGoal)
         (* errorAtFunction(infoGoal, "empty equation list", "buildNonEmptyGoals") *)
      end
                            
    (* axiom *)
    fun buildGoal([], exp, infoGoal) =
        let val (result, goal, info) = 
                let val _ = translatingThen := true; (* signaling we ARE translating then part *)
                    val x = translateExp(exp)
                    val _ = translatingThen := false; (* signaling we are NOT translating then part *)
                in x end
        in 
            case goal of 
                SOME(g) => 
                    (goal, 
                    case result of
                        Absyn.RETURN([Absyn.STRUCTexp(NONE, explst, _)], infoz)
                        => Absyn.RETURN(explst, infoz)
                    | _ => result, info)
              |    NONE => 
                    (NONE,                     
                        case result of
                        Absyn.RETURN([Absyn.STRUCTexp(NONE, explst, _)], infoz)
                        => Absyn.RETURN(explst, infoz)
                        | _ => result, info)
        end 
    (* normal rule *)
    | buildGoal(seq_eq, exp, infoGoal) = 
        let val (result, goal2, info2) = 
                let val _ = translatingThen := true; (* signaling we ARE translating then part *)
                    val x = translateExp(exp)
                    val _ = translatingThen := false; (* signaling we are NOT translating then part *)
                in x end
            val (goal1, info1) = buildNonEmptyGoals(seq_eq, exp, infoGoal)
        in 
            case goal2 of 
                SOME(g2) => 
                    (SOME(Absyn.ANDgoal(
                        goal1, 
                        g2,
                        mkCtxInfo(info1, info2))), 
                        case result of
                        Absyn.RETURN([Absyn.STRUCTexp(NONE, explst, _)], infoz)
                        => Absyn.RETURN(explst, infoz)
                        | _ => result,
                    mkCtxInfo(info1, info2))
              |    NONE => 
                    (SOME(goal1),                     
                    case result of
                        Absyn.RETURN([Absyn.STRUCTexp(NONE, explst, _)], infoz)
                        => Absyn.RETURN(explst, infoz)
                        | _ => result, info1)
        end

    
    fun constructWildPatternList(Absyn.MSTRUCTexp(NONE, Absyn.FUNCTIONARGS([], i1), i2), _) = []
    |    constructWildPatternList(Absyn.TUPLE(Absyn.FUNCTIONARGS(expressions, i1), info), _) =
        let fun apply_wild x = Absyn.WILDpat(info)
        in 
            if List.length expressions = 0
            then []            
            else map apply_wild expressions
        end
    |   constructWildPatternList(_, info) = [Absyn.WILDpat(info)]


    fun transformAttr(Absyn.ATTR(variability, direction, info), visibility) =
    let val public = ref visibility
        val final  = ref false
        val var    = ref false
        val param  = ref false
        val const  = ref false
        val input  = ref false
        val output = ref false
        val bidir  = ref false
    in
        case variability of
            Absyn.VAR      =>  var   := true
        |    Absyn.PARAM(_) =>  param := true
        |    Absyn.CONST(_) =>  const := true; 
        case direction of
            Absyn.INPUT(_)  => input  := true 
        |    Absyn.OUTPUT(_) => output := true
        |    Absyn.BIDIR(_)  => bidir  := true;
        Absyn.ATTRIBUTES{
            public=public, final=final, var=var, 
            param=param, const=const, input=input, 
            output=output, bidir=bidir}
    end

    fun getLocalVarsFromElementSpec(
        Absyn.COMPONENTS(
            elementAttributes,typeSpec (* Type *),
            componentItemList,_), visibility) = 
        let val typ = getType(typeSpec)
            fun get(Absyn.COMPONENTITEM(Absyn.COMPONENT(id,modif,_), _, _)) = 
                (
                (*print ("Local : "^(Absyn.identName id)^" at "^(getStringLoc(Absyn.identCtxInfo id))^"\n");*)
                localEnv := 
                    StrDict.insert(
                        !localEnv, 
                        Absyn.identName id, 
                        Absyn.R_ENUMERATION(info));                
                (id, SOME(typ), getExpFromModication(modif), transformAttr(elementAttributes, visibility))
                )
        in  
            map get componentItemList
        end
    |    getLocalVarsFromElementSpec(_, _) = []

    fun makeVarList(components, attr, tySpec, visibility, scope) = 
    let val ty = getType(tySpec)
        fun get(Absyn.COMPONENTITEM(Absyn.COMPONENT(id,modif,info), _, _)) = 
        let val attributes = transformAttr(attr, visibility)
        in
            localEnv := 
                StrDict.insert(
                    !localEnv, 
                    Absyn.identName id, 
                    Absyn.R_ENUMERATION(info));
            VAL(id, getExpFromModication(modif), SOME(ty), attributes, info, scope)
        end
    in
        map get components        
    end

    fun getLocalVars([], visibility) = ([])
    |    getLocalVars(Absyn.ELEMENTITEM(Absyn.ELEMENT(_,_,_,_,elementSpec,_,_), _)::rest, visibility) =
            getLocalVarsFromElementSpec(elementSpec, visibility) @ getLocalVars(rest, visibility)
    |    getLocalVars(_::rest, visibility) = getLocalVars(rest, visibility)
                        

    fun getInTy([]) = []
    |    getInTy(h::rest) = 
    (
        case h of 
            INTy(x, id, _)  => (* Absyn.NAMEDty(id,x,Absyn.identCtxInfo(id)) *) x :: getInTy(rest)
        |    _ => getInTy(rest)
     )

    fun getOutTy([]) = []
    |    getOutTy(h::rest) = 
    (
        case h of 
            OUTTy(x, id, _)  => (* Absyn.NAMEDty(id,x,Absyn.identCtxInfo(id)) *) x :: getOutTy(rest)
        |    _ => getOutTy(rest)
     )

    fun getInPat([]) = []
    |    getInPat(h::rest) = 
    (
        case h of 
            INTy(_, id, _)  =>         
                Absyn.IDENTpat(
                    id, 
                    ref(Absyn.WILDpat(Absyn.dummyInfo)), 
                    Absyn.identCtxInfo id):: getInPat(rest)
        |    _ => getInPat(rest)
     )

    fun getOutRes([]) = []
    |    getOutRes(h::rest) = 
    (
        case h of 
            OUTTy(_, id, _)  =>         
            Absyn.IDENTexp(
                Absyn.LONGID(
                    NONE, 
                    id, 
                    Absyn.identCtxInfo id),  
                ref(Absyn.STRUCTexp(NONE,[], Absyn.dummyInfo)),
                Absyn.identCtxInfo id) 
            :: getOutRes(rest)
        |    _ => getOutRes(rest)
     )

    fun constructRelationTy([]) = Absyn.RELty([], [], Absyn.dummyInfo)
    |   constructRelationTy(resultlist) =
        (
        debug("constructRelationTy\n"); 
        Absyn.RELty(getInTy resultlist, getOutTy resultlist, Absyn.dummyInfo) 
        )      
                    
    fun constructClausePattern([]) = [Absyn.STRUCTpat(NONE, [], ref [], Absyn.dummyInfo)]
    |   constructClausePattern(resultlist) =
        let 
        in
         debug("constructClausePattern\n"); 
         getInPat resultlist 
        end      

    fun constructClauseResult([], info) = 
        Absyn.RETURN(
            [Absyn.STRUCTexp(NONE, [], info)],
            info)
    |   constructClauseResult(resultlist, info) =
        let 
        in
         debug("constructClauseResult\n"); 
         Absyn.RETURN(getOutRes resultlist,  info)
        end      
        
    fun getInfoFromPat(Absyn.WILDpat(info)) = info
      | getInfoFromPat(Absyn.LITpat(lit, info)) = info
      | getInfoFromPat(Absyn.CONpat(longcon, info)) = info
      | getInfoFromPat(Absyn.STRUCTpat(ctor, pat_star, _, info)) = info
      | getInfoFromPat(Absyn.BINDpat(var, pat, info)) = info
      | getInfoFromPat(Absyn.IDENTpat(id, _, info)) = info
      | getInfoFromPat(Absyn.NAMEDpat(id, pat, info)) = info

    fun isPresentStar(id, pat_star) =
          let fun loop([]) = false
              |    loop(x::rest) = 
                  isPresent(id, x) orelse loop(rest)
          in
              loop(pat_star)
          end

    and isPresent(id, Absyn.WILDpat(info)) = false
      | isPresent(id, Absyn.LITpat(lit, info)) = false
      | isPresent(id, Absyn.CONpat(longcon, info)) = false
      | isPresent(id, Absyn.STRUCTpat(ctor, pat_star, _, info)) = 
          isPresentStar(id, pat_star)
      | isPresent(id, Absyn.BINDpat(var, pat, info)) = (* adpro: 2012-09-25 add check of the inside pattern too *)
          (Absyn.identName id = Absyn.identName var) orelse isPresent(id, pat)
      | isPresent(id, Absyn.IDENTpat(id2, _, info)) = 
          (Absyn.identName id = Absyn.identName id2)
      | isPresent(id, Absyn.NAMEDpat(id2, pat, info)) = 
          (* adpro: 2012-09-25 DO NOT CARE IF id is present as named pattern, i.e. X(id = ...)
                    just check the damn pattern, not the name of the component *)
          (* (Absyn.identName id = Absyn.identName id2) orelse *) isPresent(id, pat)

    fun getExpFromNarg(Absyn.NAMEDARG(NONE, Absyn.CREF(cr, i) , infoNamedArg)) = cr
    |    getExpFromNarg(Absyn.NAMEDARG(_, exp, i)) =
        errorAtFunction(i, "only unqualified variables are alowed in match/matchcontinue!", "cref2Id")
    
    fun cref2Id(Absyn.CREF_IDENT(ident, _,  info), i) = ident
    |    cref2Id(_, i) = 
        errorAtFunction(i, "only unqualified variables are alowed in match/matchcontinue!", "cref2Id")

    fun mkPats([], [], _, im, ic) = []
    |   mkPats([], _, _, im, ic) =
        let
        in
            errorAtFunction(ic, 
                "number of patterns in the case is BIGGER than the number of variables in the match expression!", 
                "buildPatterns") handle e => ();
            errorAtFunction(im, 
                "this match expression!", 
                "buildPatterns")
        end
    |   mkPats(_, [], _, im, ic) =
        let
        in
            errorAtFunction(ic, 
                "number of patterns in the case is SMALLER than the number of variables in the match expression!", 
                "buildClauses") handle e => ();
            errorAtFunction(im, 
                "this match expression!", 
                "buildPatterns")
        end                                
    |    mkPats(i::irest, p::prest, pats, im, ic) = 
        let val id1=cref2Id(getExpFromNarg(i), im)
        in 
            if (isPresentStar(id1, pats)) (* we have the id in one of the patterns, we don't care! *)
            then p::mkPats(irest, prest, pats, im, ic)
            else case p of
                    Absyn.IDENTpat(id2, _, i2) => 
                    if (Absyn.identName id1 = Absyn.identName id2)
                    then Absyn.BINDpat(id2, Absyn.WILDpat(i2), getInfoFromPat p)::mkPats(irest, prest, pats, im, ic)
                    else Absyn.BINDpat(id1, p, getInfoFromPat p)::mkPats(irest, prest, pats, im, ic)
                |    _ => Absyn.BINDpat(id1, p, getInfoFromPat p)::mkPats(irest, prest, pats, im, ic)
        end

    fun mkPats2(i, p, im, ic) = mkPats(i, p, p, im, ic)

    fun buildPatterns(e, p, im, ic) = 
        let
        in
            case e of
                Absyn.TUPLE(Absyn.FUNCTIONARGS(expressions, i1), i2) =>
                mkPats2(expressions, p, im, ic)
            |    Absyn.MSTRUCTexp(NONE,   Absyn.FUNCTIONARGS(expressions, _), _) =>
                mkPats2(expressions, p, im, ic)
            |    Absyn.CREF(Absyn.CREF_IDENT(ident, arrdim, info), _) => 
                mkPats2([Absyn.NAMEDARG(NONE, e, info)], p, im, ic)
            |    _ => errorAtFunction(
                            im, 
                            "invalid expression in the match/matchcontinue!", 
                            "buildPatterns")
        end

    fun buildClauses(ident, mathType, matchExp, 
            Absyn.CASE(
                patterns,
                localdecls,
                Absyn.EQUATIONS(equations, infoEquations),
                exp,
                _,
                infoCase)::nil, elems, infoMatch) =
        let 
            val rmlPatterns = extractPatterns(patterns)
            val nrOfRmlPats = List.length rmlPatterns
            val rmlPatFixed = buildPatterns(matchExp, rmlPatterns, infoMatch, infoCase)
            (* TODO! check this! 
            val _ = if nrOfPats <> nrOfRmlPats
                    then errorAtFunction(
                            infoCase, 
                            "number of patterns in the case is not equal with the number of variables in the match expression!", 
                            "buildClauses")
                    else ()
            *)
            val (goal, result, info) = buildGoal(equations, exp, infoCase)
            (*
            val _ = print("Case locals:"^L(localdecls)^" at "^(getStringLoc(infoCase))^"\n")
            *)
            val localMatchVars = getLocalVars(elems, false)
            val localCaseVars  = getLocalVars(localdecls, false)
        in 
            (
            Absyn.CLAUSE1(
                constructProperANDgoalChainOpt(goal), 
                ident,
                rmlPatFixed,
                result, 
                ref [],
                localMatchVars @ localCaseVars, 
                (* at the end the most local ones as it will overwrite the env dict *) 
                infoCase), 
            infoCase)
        end
    |   buildClauses(ident, mathType, matchExp, 
            Absyn.ELSE(
                localdecls,
                Absyn.EQUATIONS(equations, infoEquations),
                exp,
                _,
                infoElse)::nil, elems, infoMatch) =
        let val (goal, result, info) = buildGoal(equations, exp, infoElse)
            (*
            val _ = print("Case locals:"^L(localdecls)^" at "^(getStringLoc(infoElse))^"\n")
            *)
            val localMatchVars = getLocalVars(elems, false)
            val localCaseVars = getLocalVars(localdecls, false)
            val wpl = constructWildPatternList(matchExp, infoElse)
            val rmlPatFixed = buildPatterns(matchExp, wpl, infoMatch, infoElse)
        in 
            (
            Absyn.CLAUSE1(
                constructProperANDgoalChainOpt(goal), 
                ident,
                rmlPatFixed,
                result, 
                ref [], 
                localMatchVars @ localCaseVars, 
                (* at the end the most local ones as it will overwrite the env dict *) 
                infoElse), 
            infoElse)
        end
    | buildClauses(ident, matchType as Absyn.MATCHCONTINUE, matchExp, x::rest, elems, infoMatch) =
        let val (c1, infoc1) = buildClauses(ident, matchType, matchExp, [x],  elems, infoMatch)
            val (c2, infoc2) = buildClauses(ident, matchType, matchExp, rest, elems, infoMatch)
        in
        (
        Absyn.CLAUSE2(
            c1, 
            c2, 
            mkCtxInfo(infoc1, infoc2)),
        mkCtxInfo(infoc1, infoc2)
        )
        end
    | buildClauses(ident, matchType as Absyn.MATCH, matchExp, x::rest, elems, infoMatch) =
        let val (c1, infoc1) = buildClauses(ident, matchType, matchExp, [x],  elems, infoMatch)
            val (c2, infoc2) = buildClauses(ident, matchType, matchExp, rest, elems, infoMatch)
        in
        (
        Absyn.CLAUSE3(
            c1, 
            c2, 
            mkCtxInfo(infoc1, infoc2)),
        mkCtxInfo(infoc1, infoc2)
        )
        end
    | buildClauses(ident, matchType, matchExp, [], elems, infoMatch) = 
        errorAtFunction(infoMatch, "at least one case should be present in the match.", "buildClauses")


    fun sweepFUNCTYPES([]) = []
    |   sweepFUNCTYPES((x as FUNC(_))::rest) = x::sweepFUNCTYPES(rest)
    |   sweepFUNCTYPES(_::rest) = sweepFUNCTYPES(rest)

    fun constructClause(ident,
            Absyn.ALGORITHMITEM(
                Absyn.ALG_ASSIGN(
                    _,
                    Absyn.MATCHexp(
                    MatchType, (* match type, not ignored since 2010-09-16, transformed into Absyn.CLAUSE3 *)
                    Exp, 
                    ElementItems,
                    Cases,
                    comment,
                    infoMatch),
                    _),
                _,
                infoAlgItem)) =
          let val (clause', _) = buildClauses(ident, MatchType, Exp, Cases, ElementItems, infoMatch)
              val elemz = sweepFUNCTYPES(splitElements(ident, ElementItems, false))
          in 
            debug("constructClause: ");
            prIdentAndLoc ident;
            elemz @ [CLAUSE(clause', infoAlgItem)]
          end
    | constructClause(ident,
            Absyn.ALGORITHMITEM(
                Absyn.ALG_TUPLE_ASSIGN(
                    _,
                    Absyn.MATCHexp(
                    MatchType, (* match type, not ignored since 2010-09-16, transformed into Absyn.CLAUSE3 *)
                    Exp, 
                    ElementItems, 
                    Cases,
                    comment,
                    infoMatch),
                    _),
                _,
                infoAlgItem)) =
          let val (clause', _) = buildClauses(ident, MatchType, Exp, Cases, ElementItems, infoMatch)
              val elemz = sweepFUNCTYPES(splitElements(ident, ElementItems, false))
          in 
            debug("constructClause: ");
            prIdentAndLoc ident;
            elemz @ [CLAUSE(clause', infoAlgItem)]
          end          
    | constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_IF(_, _, _, _, info), _, _))     = 
        (warnAtFunction(info,"ignored if algorithm statement","constructClause"); [])
    | constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_FOR(_, _, _), _, info))          = 
        (warnAtFunction(info,"ignored for algorithm statement","constructClause"); [])
    | constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_WHILE(_, _, _), _, _))        = 
        (warnAtFunction(info,"ignored while algorithm statement","constructClause"); [])
    | constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_WHEN_A(_, _, _, _), _, _))    = 
        (warnAtFunction(info,"ignored when algorithm statement","constructClause"); [])
    | constructClause(ident, Absyn.ALGORITHMITEM(Absyn.ALG_NORETCALL(_, _, _), _, _))    = 
        (warnAtFunction(info,"ignored no return call algorithm statement","constructClause"); [])
    | constructClause(ident, Absyn.ALGORITHMITEMANN(_, info)) = 
        (warnAtFunction(info,"ignored annotation","constructClause"); [])
    | constructClause(ident, Absyn.ALGORITHMITEM(_,_,info)) = 
        (warnAtFunction(info,"unexpected stuff","constructClause"); [])
    

    and    transformAlgorithmToEquation(infoAlg, Absyn.ALG_ASSIGN(Exp1, Exp2, info)) =
            Absyn.EQ_EQUALS(Exp1, Exp2, info)
    |    transformAlgorithmToEquation(infoAlg, Absyn.ALG_TUPLE_ASSIGN(Exp1, Exp2, info)) = 
            Absyn.EQ_EQUALS(Exp1, Exp2, info)
    |    transformAlgorithmToEquation(infoAlg, Absyn.ALG_NORETCALL(ComponentRef, FunctionArgs, info)) =
            Absyn.EQ_NORETCALL(ComponentRef, FunctionArgs, info)
    |    transformAlgorithmToEquation(infoAlg, Absyn.ALG_FAILURE(Algorithm, info)) =
            Absyn.EQ_FAILURE(transformAlgorithmToEquation(infoAlg,Algorithm), info)
    |    transformAlgorithmToEquation(infoAlg, Absyn.ALG_EQUALITY(Algorithm, info)) =
            Absyn.EQ_EQUALITY(transformAlgorithmToEquation(infoAlg,Algorithm), info)
    |   transformAlgorithmToEquation(infoAlg, _) = 
            errorAtFunction(
                infoAlg,
                "only assign, no return call, failure, and equality statements are supported!", 
                "transformAlgorithmToEquation")
    
    and transformAlgorithmsToEquations([]) = []
    |    transformAlgorithmsToEquations(Absyn.ALGORITHMITEM(x, comment, info)::rest) =
            Absyn.EQUATIONITEM(transformAlgorithmToEquation(info, x), comment, info)::transformAlgorithmsToEquations(rest)
    |    transformAlgorithmsToEquations(_::rest) = transformAlgorithmsToEquations(rest)

    (* normal algorithms not including MACHexp so localvars in clause is [] *)
    and constructAlgorithms(ident, algItems, infoAlgItems) = 
    let val equations = transformAlgorithmsToEquations(algItems)
        val infoReturn = case List.last equations of Absyn.EQUATIONITEM(_, _, infoLast) => infoLast
        val (goal, result, info) = 
                buildGoal(
                    equations, 
                    Absyn.MSTRUCTexp(
                        NONE,   
                        Absyn.FUNCTIONARGS(
                            [], 
                            infoReturn),
                        infoReturn), 
                    infoAlgItems)
    in
        [ALGORITHM(Absyn.CLAUSE1(constructProperANDgoalChainOpt(goal), ident, [], result, ref [], [] (* localvars *), info), info, infoReturn)]
    end

    and applyConstructClause(ident, x, infoAlgItems, rest, Exp, resultExp) =
    let val (result1, goal1, info1) = translateExp(Exp)
        val patResult = translateExpToPat(resultExp)
        val _ = case goal1 of 
                    NONE => ()
                |    SOME(_) => warnAtFunction(
                                    info1, 
                                    "the the match/matchcontinue expression must contain only identifiers!", 
                                    "applyConstructClause")
        val matchExp = getExp(result1, goal1, info1)
    in
    (if List.length rest > 0
     then warnAtFunction(
            infoAlgItems, 
            "only the first algorithm statement translated, the following are ignored!", 
            "constructClauses") 
     else ();
        [MATCHexp(matchExp, info1, patResult, info1)] @ constructClause(ident, x)
        (* @ constructClauses(ident, rest, infoAlgItems) *) ) 
    end

    and constructClauses(ident, [], infoAlgItems) = []
    |    constructClauses(ident, x::rest, infoAlgItems) =
        (
          case x of 
            (* if first one is a match take it*)
            Absyn.ALGORITHMITEM(Absyn.ALG_ASSIGN(resultExp, Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, comment, info), _),_,_) 
                =>     applyConstructClause(ident, x, infoAlgItems, rest, Exp, resultExp)
            (* if first one is a match take it*)
          |    Absyn.ALGORITHMITEM(Absyn.ALG_TUPLE_ASSIGN(resultExp, Absyn.MATCHexp(MatchType, Exp, ElementItemList, CaseList, comment, info), _),_,_)
                =>     applyConstructClause(ident, x, infoAlgItems, rest, Exp, resultExp)
            (* if is not a match construct then is a simple algorithm section *)
          | Absyn.ALGORITHMITEM(_, _, infoAlgItems) => constructAlgorithms(ident, x::rest, infoAlgItems)
          | Absyn.ALGORITHMITEMANN(_, info) =>
            (
                warnAtFunction(info, "ingored annotation", "constructClauses"); 
                constructClauses(ident, rest, infoAlgItems)
            )                    
        )
        
    (* 
    this function splits elements into:
    input, output, type, functype, replaceable types,
    and variables 
    *)
    and splitElements(f_ident, [], visibility) = []
    |    splitElements(f_ident, elementItem::rest, visibility) = 
        (
        case elementItem of
            Absyn.ELEMENTITEM(
                Absyn.ELEMENT(_,_,_,
                    ident, 
                    elementSpec as 
                        Absyn.CLASSDEF(_, 
                            class as 
                                Absyn.CLASS(
                                    identclass,
                                    partial,
                                    final,
                                    encapsulated,
                                    restriction,
                                    classdef as Absyn.PARTS(classparts, _, _),
                                _),
                        _), 
                    info, 
                    _),
                    _) => 
            (* 
            CLASSDEF test for: 
               - replaceable type Type_a;
               - function Functype
                  replaceable type Xtype = list<Type_a>
                  replaceable type Ytype = list<Type_b>                   
                  input  XType x;
                  output YType y;
                 end Functype;
            *)
            (
            case restriction of
                Absyn.R_TYPEVARIABLE(_) =>
                (
                 (* collect the type variable *) 
                 let val Absyn.IDENT(idstr, tmpInfo) = identclass
                     val varty = Absyn.IDENT("'"^idstr, tmpInfo)
                     val tyvar = Absyn.VARty(varty,tmpInfo)
                     val tybind = Absyn.TYPBIND([varty],identclass,tyvar,tmpInfo)
                 in 
                  TyV(varty)::(TyB(tybind)::splitElements(f_ident, rest, visibility))
                 end
                )
            |    Absyn.R_FUNCTION(_) =>
                (
                    (* 
                        collect everything in a FUNCTYPE
                    *)
                    FUNC(
                        SOME(f_ident), 
                        identclass, 
                        buildRelationSpecAndDec(identclass, classparts),
                        NORMAL_FUNCTION)::
                    splitElements(f_ident, rest, visibility)
            )
            |    Absyn.R_FUNCTION_TYPE(_) =>
                (
                    (* 
                        collect everything in a FUNC
                    *)
                    FUNC(
                        SOME(f_ident), 
                        identclass, 
                        buildRelationSpecAndDec(identclass, classparts),
                        TYPE_FUNCTION)::
                    splitElements(f_ident, rest, visibility)
            )
            |    Absyn.R_TYPE(info) =>
                (
                    if (List.length classparts > 0)
                    then errorAtFunction(info, "types cannot have parts!", "splitElements") 
                    else
                    (* collect the type *) 
                    TyV(identclass)::splitElements(f_ident, rest, visibility) 
                )            
            |   _ => splitElements(f_ident, rest, visibility) 
            )
        |    Absyn.ELEMENTITEM(
                Absyn.ELEMENT(_,_,_,
                    ident, 
                    elementSpec as Absyn.CLASSDEF(_, class as 
                                Absyn.CLASS(
                                    identclass,
                                    partial,
                                    final,
                                    encapsulated,
                                    _,
                                    classdef,
                                _),
                    _), 
                    info, 
                    _),
                _) => 
            (debug("splitElements\n");
             case classdef of
                (* list, Option, tuple, polymorphic *)
                 Absyn.DERIVED(typeSpec, _, _, _, infoDerived)    => 
                 TyB(getDerivedType(identclass, typeSpec))
                ::splitElements(f_ident, rest, visibility)
            | _ => errorAtFunction(info, "derived class definition expected", "splitElements")
             )
        |    Absyn.ELEMENTITEM(
                Absyn.ELEMENT(_,_,_,
                    ident, 
                    ementSpec as Absyn.COMPONENTS(
                        attr as Absyn.ATTR(
                            variability, 
                            direction, _), path, components, _),
                    info, 
                    _),
                    _) => 
            (*
            COMPONENTS test for:
            input  Path component;
            output Path component;
            Path component;  
            *)
            let 
                fun createTypeFromComponents(_, []) = []
                |    createTypeFromComponents(0, Absyn.COMPONENTITEM(Absyn.COMPONENT(ident, _, _), _, _)::rest) =
                    OUTTy(getType(path), ident, transformAttr(attr, visibility))::createTypeFromComponents(0, rest)
                |   createTypeFromComponents(1, Absyn.COMPONENTITEM(Absyn.COMPONENT(ident, _, _), _, _)::rest) = 
                    INTy(getType(path), ident, transformAttr(attr, visibility))::createTypeFromComponents(1, rest)
            in
                case direction of
                    Absyn.INPUT(infoInput)  => 
                        createTypeFromComponents(1, components) @ splitElements(f_ident, rest, visibility) 
                |    Absyn.OUTPUT(infoInput) => 
                        createTypeFromComponents(0, components) @ splitElements(f_ident, rest, visibility)
                (* other components we don't care about it now! *)
                |   Absyn.BIDIR(infoBidir) => (* TODO! COLLECT THESE! *)
                        makeVarList(components, attr, path, visibility, SOME(f_ident)) @ 
                        splitElements(f_ident, rest, visibility)
            end
        | _ => splitElements(f_ident, rest, visibility)
        )
        
    (* this function builds Specifications and Declarations out of a function *)      
    and buildRelationSpecAndDec(ident, []) = 
        (debug("buildRelationSpecAndDec: classparts: 0\n"); [])
        | buildRelationSpecAndDec(ident, classpart::rest) = 
          (
              debug ("buildRelationSpecAndDec: classparts: "^L(rest)^"\n");
            case classpart of
            Absyn.PUBLIC(elementItems, _) => 
                splitElements(ident, elementItems, true) @ buildRelationSpecAndDec(ident, rest)
            | Absyn.PROTECTED(elementItems, _) => 
                splitElements(ident, elementItems, false) @ buildRelationSpecAndDec(ident, rest)
            | Absyn.ALGORITHMS(algorithmItems, infoAlgItems) => 
                constructClauses(ident, algorithmItems, infoAlgItems) @ buildRelationSpecAndDec(ident, rest)
            | Absyn.EXTERNAL(externalDecl, _, _, info) =>
                EXTERNAL("C")::buildRelationSpecAndDec(ident, rest)
            | Absyn.EQUATIONS(_,  info)
                => errorAtFunction(info,
                    "expected public/protected/local elements or an algorithm section",
                    "buildRelationSpecAndDec")    
          )

    fun sweepCLAUSE([]) = []
    |   sweepCLAUSE(clause::classparts) =
        case clause of
              x as CLAUSE(clause, info) => [x]
            | _ => sweepCLAUSE(classparts)

    fun sweepALGORITHM([]) = []
    |   sweepALGORITHM(clause::classparts) =
        case clause of
              x as ALGORITHM(clause, _, _) => [x]
            | _ => sweepALGORITHM(classparts)

    fun sweepVARIABLES([]) = []
    |   sweepVARIABLES(var::rest) =
    (
        case var of
            VAL(id, exp, ty, attr, info, scope) => (id, ty, exp, attr)::sweepVARIABLES(rest)
        |    INTy(ty, id, attr) => (id, SOME(ty), NONE, attr)::sweepVARIABLES(rest)
        |    OUTTy(ty, id, attr) => (id, SOME(ty), NONE, attr)::sweepVARIABLES(rest)
        |    _ => sweepVARIABLES(rest)
    )
    fun sweepMATCHexp([]) = []
    |   sweepMATCHexp(match::rest) =
    (
        case match of
              MATCHexp(matchExp, infoMatchExp, resultMatchExp, infoResultMatchExp) => 
              (matchExp, infoMatchExp, resultMatchExp, infoResultMatchExp)::sweepMATCHexp(rest)
            | _ => sweepMATCHexp(rest)
    )
    
    fun checkMatchAgainstFunctionType(_, _) = ()
    (*
    fun checkMatchAgainstFunctionType(NONE, ty) = ()
    |   checkMatchAgainstFunctionType(
             SOME(MATCHexp(matchExp, infoMatchExp, resultMatchExp, infoResultMatchExp)), 
             ty as Ty.REL(inputs, outputs)) = 
        let
          
        in
          
        end
    *)
    
    (* 
       returns (rels, binds) 
       FunctionTypes SHOULD BE AUGMENTED WITH THE FUNCTION NAME 
       function func
        function FuncType1
          in  x;
          out y;
        end FuncType1;
       end func;
       -> func_FuncType1
    *)
    fun constructRelationsAndDatatypes(ident_, [], kind) = ([], [])     
    |   constructRelationsAndDatatypes(ident, resultlist, kind) = 
            let val clauseList = sweepCLAUSE(resultlist)
                val algList = sweepALGORITHM(resultlist)
                val ty = constructRelationTy(resultlist)
                val variables = sweepVARIABLES(resultlist)
                val matchExps = sweepMATCHexp(resultlist)
                val matchExps = if List.length matchExps >= 1
                                then SOME(List.hd matchExps)
                                else NONE
                val _ = checkMatchAgainstFunctionType(matchExps, ty)
                val (rels, binds) =    
                    if (List.length clauseList >= 1)
                    then
                        let val (clause, infoClause) =
                                case List.hd clauseList of
                                    CLAUSE(clause, infoClause) => (clause, infoClause)
                                |    _ => bug ("constructRelationsAndDatatypes: expected clause here") 
                        in
                         ([REL(ident, ty, SOME(clause), variables, matchExps, infoClause, kind)], resultlist)
                        end
                    else (* no clause in this relation => external or functype *)
                        if (List.length algList >= 1)
                        then
                            let val (clause, infoClause, infoReturn) = 
                                    case List.hd algList of
                                        ALGORITHM(clause, infoClause, infoReturn) => (clause, infoClause, infoReturn)
                                    |    _ => bug ("constructRelationsAndDatatypes: expected ALG clause here") 
                                val res = constructClauseResult(resultlist, infoReturn)
                                val pats = constructClausePattern(resultlist)
                                val clause_good = 
                                    case clause of 
                                        Absyn.CLAUSE1(goal, relid, _, _, _, vars, infoC) 
                                        => Absyn.CLAUSE1(constructProperANDgoalChainOpt(goal), relid, pats, res, ref [], vars, infoC)
                                    |    _ => bug ("constructRelationsAndDatatypes: we should not have multiple clauses here") 
                            in
                            ([REL(ident, ty, SOME(clause_good), variables, matchExps, infoClause, kind)], resultlist)
                            end
                        else (* no clause in this relation => external or functype *)
                        let val relLst = [REL(ident, ty, NONE, variables, matchExps, Absyn.identCtxInfo ident, kind)]
                        in
                          (relLst, resultlist)
                        end
            in
                debug("constructRelationsAndDatatypes\n");
                (rels, binds)
            end

    fun fixSpecs([]) = []
    |    fixSpecs(REL(ident, ty, NONE, _, _, info, NORMAL_FUNCTION)::rest) = Absyn.RELspec(ident, ty, info) :: fixSpecs(rest)
    |    fixSpecs(REL(ident, ty, NONE, _, _, info, EXTERNAL_FUNCTION)::rest) = Absyn.RELspec(ident, ty, info) :: fixSpecs(rest)
    |    fixSpecs(REL(ident, ty, NONE, _, _, info, TYPE_FUNCTION)::rest) = (* Absyn.RELspec(ident, ty, info) :: *) fixSpecs(rest) (* ignore if is a type function *)
    |    fixSpecs(REL(ident, ty, SOME(clause), _, _, info, _)::rest) = Absyn.RELspec(ident, ty, info) :: fixSpecs(rest)
    |    fixSpecs(_::rest) = fixSpecs(rest)
    
    fun fixDecs([]) = []
    |    fixDecs(REL(ident, ty, NONE, variables, _, info, _)::rest) = fixDecs(rest)
    |    fixDecs(REL(ident, ty, SOME(clause), variables, matchExps, info,_)::rest) = Absyn.RELBIND(ident, SOME(ty), clause, variables, matchExps, info)::fixDecs(rest)
    |    fixDecs(_::rest) = fixDecs(rest)

    fun fixSpecBinds([]) = []
    | fixSpecBinds(TyB(x)::rest) = Absyn.TYPEspec([x], Absyn.dummyInfo)::fixSpecBinds(rest)
    | fixSpecBinds(VAL(id, exp_opt, ty_opt, attr, info, scope)::rest) = 
    let val Absyn.ATTRIBUTES{const,...} = attr
    in
        if !const
        then 
        case ty_opt of 
            SOME(ty) => Absyn.VALspec(id, ty, info)::fixSpecBinds(rest)
        |    NONE => fixSpecBinds(rest)
        else fixSpecBinds(rest)
    end
    | fixSpecBinds(FUNC(_, reltypeid, constructs, TYPE_FUNCTION)::rest) = 
        Absyn.TYPEspec(
            [Absyn.TYPBIND([], reltypeid, constructRelationTy(constructs), Absyn.identCtxInfo reltypeid)], 
            Absyn.identCtxInfo reltypeid)::(fixSpecBinds(constructs) @ fixSpecBinds(rest))
    | fixSpecBinds(_::rest) = fixSpecBinds(rest)

    fun isPresentInSpecs([], _) = false
    |    isPresentInSpecs(spec::specs, x as TyB(Absyn.TYPBIND(_, id_bind, _, _))) = 
        (
        case spec of
            Absyn.TYPEspec([Absyn.TYPBIND(_, id_spec, _, _)], _) =>
            if Absyn.identName id_spec = Absyn.identName id_bind
            then (debug("isPresentInSpecs: "^(Absyn.identName id_spec)); true)
            else isPresentInSpecs(specs, x)
        |    _ => isPresentInSpecs(specs, x)
        )
    |    isPresentInSpecs(_::specs, x) = isPresentInSpecs(specs, x) 

    (*
    fun isPresentInDecs([], _) = false
    |    isPresentInDecs(dec::decs, x as TyB(Absyn.TYPBIND(_, id_bind, _, _))) = 
        (
        case dec of
            Absyn.TYPEdec([Absyn.TYPBIND(_, id_dec, _, _)], _) =>
            if Absyn.identName id_spec = Absyn.identName id_bind
            then (debug("isPresentInDecs: "^(Absyn.identName id_dec)); true)
            else isPresentInDecs(specs, x)
        |    _ => isPresentInDecs(specs, x)
        )
    *)
        
    fun removeFromDec([],  _) = []
    |    removeFromDec(dec::decs, x as TyB(Absyn.TYPBIND(_, id_bind, _, _))) =
        (
        case dec of
            Absyn.TYPEdec([Absyn.TYPBIND(_, id_dec, _, _)], _) =>
            if Absyn.identName id_dec = Absyn.identName id_bind
            then removeFromDec(decs, x)
            else dec::removeFromDec(decs, x)
        |    _ => dec::removeFromDec(decs, x)
        )
    |    removeFromDec(_::decs, x) = removeFromDec(decs, x)
            
            
    fun getIdentFromTySpec(Absyn.TYPEspec([Absyn.TYPBIND(_, Absyn.IDENT(id, _), _, _)], _) ) = id
    |   getIdentFromTySpec(_) = 
        bug("getIdentFromTySpec - unexpected value")
    fun getIdentFromTyDec(Absyn.TYPEdec([Absyn.TYPBIND(_, Absyn.IDENT(id, _), _, _)], _) ) = id
    |   getIdentFromTyDec(_) = 
        bug("getIdentFromTyDec - unexpected value")
            
    fun removeDecsSpecsDuplicates([], _) = []
    |    removeDecsSpecsDuplicates(dec::decs, specs) =
        let fun is_there(spec as Absyn.TYPEspec(_)) = 
                (case dec of
                    Absyn.TYPEdec(_) => 
                    (case spec of
                        Absyn.TYPEspec(_) => getIdentFromTyDec(dec) = getIdentFromTySpec(spec)
                    |   _ => false
                    )
                |    _ => false)
            |    is_there(_) = false
        in 
          if List.exists is_there specs
          then removeDecsSpecsDuplicates(decs, specs)
          else dec::removeDecsSpecsDuplicates(decs, specs)
        end
            
    fun fixDecBinds(specs, []) = []
    | fixDecBinds(specs, (z as TyB(x))::rest) = 
        if isPresentInSpecs(specs, z) 
        then fixDecBinds(specs, rest)
        else Absyn.TYPEdec([x], Absyn.dummyInfo)::fixDecBinds(specs, rest)
    | fixDecBinds(specs, VAL(id, exp_opt, ty_opt, attr, info, scope)::rest) = 
    (
        case exp_opt of 
            SOME(exp) => Absyn.VALdec(id, exp, info)::fixDecBinds(specs, rest)
        |    NONE => fixDecBinds(specs, rest)
    )
    | fixDecBinds(specs, FUNC(_, ftypeid, constructs, TYPE_FUNCTION)::rest) = 
        Absyn.TYPEdec(
            [Absyn.TYPBIND([], ftypeid, constructRelationTy(constructs), Absyn.identCtxInfo ftypeid)], 
            Absyn.identCtxInfo ftypeid)::(fixDecBinds(specs, constructs) @ fixDecBinds(specs, rest))        
    | fixDecBinds(specs, _::rest) = fixDecBinds(specs, rest)

    
    fun augmentSpecsAndDecs(specs, decs, rels, binds, isPublic) =
    (        
        debug("augmentSpecsAndDecs - binds: "^L(binds)^"\n");
        (    
        specs @ 
        (
        if (isPublic = true) 
        then (fixSpecBinds(binds) @ (fixSpecs rels))
        else []
        ),
        decs  @    
        (
        if (isPublic = false)
        then (fixDecBinds(specs, binds))
        else []
        )
        @
        [ Absyn.RELdec(fixDecs(rels), Absyn.dummyInfo) ]
        )
    )
    
    fun concatIds(
            Absyn.IDENT(name1, info1), 
            Absyn.IDENT(name2, info2)) = Absyn.IDENT(name1^"."^name2, info2) 

    fun concatLIds(
            Absyn.IDENT(name1, info1), 
            Absyn.LONGID(NONE, 
                Absyn.IDENT(name2, info2), info3)) = 
                (
                    debug ("\n...concat.."^name1^" with "^name2);
                    Absyn.LONGID(NONE, 
                        Absyn.IDENT(name1^"."^name2, info2), 
                        info3)
                )
    |    concatLIds(_, _) = bug("concatLIds(id, longid) got bad arguments")


    fun fixTypeScope (ident, ftypeident) ty = 
    let val strFId = Absyn.identName ftypeident
    in
        case ty of 
            Absyn.VARty(_) => ty
        |    Absyn.CONSty(tylist, longid, info) => 
            Absyn.CONSty(
                map (fixTypeScope (ident, ftypeident)) tylist, 
                if strFId = Absyn.lidentName longid
                then concatLIds(ident, longid)
                else longid, 
                info)
        |    Absyn.TUPLEty(tylist, info) => 
            Absyn.TUPLEty(map (fixTypeScope (ident, ftypeident)) tylist, info)
        |    Absyn.RELty(tylist1, tylist2, info) =>
            Absyn.RELty(
            map (fixTypeScope (ident, ftypeident)) tylist1, 
            map (fixTypeScope (ident, ftypeident)) tylist2, 
            info)
        |    Absyn.NAMEDty(ident, ty,  info) => 
            Absyn.NAMEDty(ident, (fixTypeScope (ident, ftypeident)) ty,  info)
    end

    fun fixClauseLocalVariables(id, fid, Absyn.CLAUSE1(g, i, p, res, rp, varlist, info)) =
    let fun fix(x as (i, SOME(ty), exp, attr)) = 
                (i, SOME(fixTypeScope (id, fid) ty), exp, attr)
        |    fix(x as (i, NONE, exp, attr)) = x
    in
        Absyn.CLAUSE1(constructProperANDgoalChainOpt(g), i, p, res, rp, map fix varlist, info)
    end             
    |    fixClauseLocalVariables(id, fid, Absyn.CLAUSE2(c1, c2, info)) = 
        Absyn.CLAUSE2(
            fixClauseLocalVariables(id, fid, c1), 
            fixClauseLocalVariables(id, fid, c2), info)
    |    fixClauseLocalVariables(id, fid, Absyn.CLAUSE3(c1, c2, info)) = 
        Absyn.CLAUSE3(
            fixClauseLocalVariables(id, fid, c1), 
            fixClauseLocalVariables(id, fid, c2), info)
        
        
    fun fixFuncTypeScope (ident, ftypeident) (x as INTy(ty, cId, attr)) = 
            INTy(fixTypeScope (ident, ftypeident) ty, cId, attr)
    |    fixFuncTypeScope (ident, ftypeident) (x as OUTTy(ty, cId, attr)) = 
            OUTTy(fixTypeScope (ident, ftypeident) ty, cId, attr)
    (* search into ty for function name. if you find it, fix it! *)
    |    fixFuncTypeScope (ident, ftypeident) (x as TyB(Absyn.TYPBIND(tyv, id, ty, cId))) = 
    (
        TyB(Absyn.TYPBIND(tyv, id, (fixTypeScope (ident, ftypeident)) ty, cId))
    )
    (* TODO! search into UNIONTYPE/RECORS for functionames in ty and fix it! *)
    |   fixFuncTypeScope(ident, ftypeident) (x) = 
        let
        in
        case x of
            ALGORITHM(clause, info, infoResult) 
            => ALGORITHM(fixClauseLocalVariables(ident, ftypeident, clause), info, infoResult)
        |    CLAUSE(clause, info)
            => CLAUSE(fixClauseLocalVariables(ident, ftypeident, clause), info)
        |    VAL(id, exp, SOME(ty), attr, info, ident_option) =>
            VAL(id, exp, SOME((fixTypeScope (ident, ftypeident)) ty), attr, info, ident_option)
        |    REL(idR, tyR, clauseR, varlist, matchexps, info, kind) =>
            let fun fix(x as (i, SOME(ty), exp, attr)) = 
                        (i, SOME((fixTypeScope (ident, ftypeident)) ty), exp, attr)
                |    fix(x as (i, NONE, exp, attr)) = x
            in
                REL(idR, tyR, 
                case clauseR of 
                    SOME(clause) => 
                    SOME(fixClauseLocalVariables(ident, ftypeident, clause))
                |    NONE => NONE,
                map fix varlist, matchexps, info, kind)
            end
        |    _ => x
        end

        
    fun fixScope(id, front, []) = front
    |    fixScope(id, front, part::rest) =
    (
    case part of 
        FUNC(SOME(relationid), functypeid, constructs, fKind) => 
            let val fixedFront = List.map (fixFuncTypeScope (id, functypeid)) front
                val fixedRest  = List.map (fixFuncTypeScope (id, functypeid)) rest 
                val fixedPart  = FUNC(NONE, concatIds(relationid, functypeid), constructs, fKind)
            in
                fixScope(id, fixedFront@[fixedPart], fixedRest)
            end            
    |    _ => fixScope(id, front@[part], rest)
    )
    (* handle functions:
       - function ident external "C" end ident; // external functions
       - function ident 
           components;
           types;
          algorithm
           ...
         end ident;
    *)
    fun buildRelation (ident, classdef, isPublic, specs, decs, kind) = 
        let val _ = localEnv := StrDict.empty
            val classparts' = case classdef of
                              Absyn.PARTS(classparts, _, _) => classparts
                            | Absyn.DERIVED(_,_,_,_, info) => 
                                errorAtFunction(info, "derived functions not supported", "buildRelation")
                            | Absyn.ENUMERATION(_, _, info) => 
                                errorAtFunction(info, "enumeration is not supported", "buildRelation")
            val resultlist = buildRelationSpecAndDec(ident, classparts')
            val resultList = fixScope(ident, [], resultlist)
            val resultList = case kind of
                              TYPE_FUNCTION => [ FUNC(NONE, ident, resultList, TYPE_FUNCTION) ]
                            | _ => resultList
            val (rels, datbinds) = constructRelationsAndDatatypes(ident, resultList, kind)
            val (specs', decs') = augmentSpecsAndDecs(specs, decs, rels, datbinds, isPublic)
        in
            debug("buildRelation - specs: "^L(specs')^", decs: "^L(decs')^"\n");
            (specs', removeDecsSpecsDuplicates(decs', specs'))
        end

    fun buildRecord  (ident, eX, isPublic, specs, decs) = 
    let val info = Absyn.identCtxInfo ident
        val contytyvar_list = buildConstructors([Absyn.PUBLIC([eX],info)], ident)
        val tyspecs = getTypsSpec(contytyvar_list)
        val tydecs = getTypsDec(contytyvar_list)
        val cons = getCons(contytyvar_list)
        val tyvars = getTyVars(contytyvar_list)
        val (valdecs, valspecs) = buildConstantsForConstantConstructors(contytyvar_list, isPublic)
    in
        debug("buildRecord: specs\n");
        (
        specs @
        (
        if (isPublic = true)
        then tyspecs @ [ Absyn.DATAspec([Absyn.DATBIND(tyvars, ident, cons, info)], [], info) ] @ valspecs
        else []
        ),
        decs @
        (
        if (isPublic = false)
        then tydecs @ [ Absyn.DATAdec([Absyn.DATBIND(tyvars, ident, cons, info)], [], info) ] @ valdecs
        else valdecs
        )
        )
    end
        
    fun (* type variables *)
        sweepTypes(Absyn.CLASS(
                        identclass,
                        partial,
                        final,
                        encapsulated,
                        Absyn.R_TYPEVARIABLE(_),
                        classdef as Absyn.PARTS([], _, _),
                    _)) = 
        (debug ("sweepTypes\n");
         let val Absyn.IDENT(idstr, tmpInfo) = identclass
             val varty = Absyn.IDENT("'"^idstr, tmpInfo)
             val tyvar = Absyn.VARty(varty,tmpInfo)
             val tybind = Absyn.TYPBIND([varty],identclass,tyvar,tmpInfo)
         in 
           TyV(varty)::[TyB(tybind)]
         end
         )        
        (* type declarations 
           type = IDENT<TYPE list>, 
           ex: type T1 = record<Typ1,Typ2>; DERIVED_TYPE
               type T2 = list<Typ3>;        DERIVED_TYPE
               type T3 = T2[:];             DERIVED array/vector here
        *)            
        | sweepTypes(Absyn.CLASS(
                        identclass,
                        partial,
                        final,
                        encapsulated,
                        _,
                        classdef,
                    info)) = 
            (debug ("sweepTypes\n");
             case classdef of
                (* list, option, record, polymorphic *)
                 Absyn.DERIVED(typeSpec, _, _, _, infoDerived)    => 
                 [TyB(getDerivedType(identclass, typeSpec))]
                 (* array / vector *)
             |   _ => errorAtFunction(info, "derived type expected", "sweepTypes")
             )
    
    fun walkCompList([], ty, _, _) = []
    |    walkCompList(
        Absyn.COMPONENTITEM(
            Absyn.COMPONENT(id, modif, info), _, _)::components, ty, attr, visibility) =
        let val exp = getExpFromModication(modif)
        in 
         VAL(id, exp, SOME(ty), transformAttr(attr, visibility), info, NONE)::
         walkCompList(components, ty, attr, visibility)
        end
    
    fun fixSpecsAndDecs([], isPublic, s, d) = (s, d)
    |    fixSpecsAndDecs(VAL(id, exp_opt, SOME(ty), attr, info, scope)::rest, isPublic, s, d) = 
        let val Absyn.ATTRIBUTES{const,...} = attr
        in
            if !const
            then 
            case (exp_opt) of 
                SOME(exp) => 
                    fixSpecsAndDecs(rest, isPublic,
                        s @ (if (isPublic = true) then [Absyn.VALspec(id, ty, info)] else []), 
                        d @ [Absyn.VALdec(id, exp, info)])
            |    NONE     => 
                errorAtFunction(info, "expression expected", "fixSpecsAndDecs")
            else fixSpecsAndDecs(rest, isPublic, s, d)        
        end
    |    fixSpecsAndDecs(VAL(_, _, _, _, info, scope)::rest, isPublic, s, d) =
            errorAtFunction(info, "expression and type expected", "fixSpecsAndDecs")
    |    fixSpecsAndDecs(_::rest, isPublic, s, d) = fixSpecsAndDecs(rest, isPublic, s, d)

    fun createValDecls(Absyn.COMPONENTS(elemAttr, Path, CompList, info), isPublic, specs, decs) =
        let val typ = getType(Path)
        in        
            fixSpecsAndDecs(walkCompList(CompList, typ, elemAttr, isPublic), isPublic, specs, decs)        
        end
    |    createValDecls(Absyn.CLASSDEF(_, _, info), isPublic, specs, decs) =
            errorAtFunction(info,"component declaration expected", "createValDecls")
    |    createValDecls(Absyn.EXTENDS(_, _, info), isPublic, specs, decs) = 
            errorAtFunction(info,"component declaration expected", "createValDecls")
    |    createValDecls(Absyn.IMPORT(_, _, info), isPublic, specs, decs) = 
            errorAtFunction(info,"component declaration expected", "createValDecls")
    
    fun buildType (class, isPublic, specs, decs) =
        let val tytyvar = sweepTypes(class)
            val (tyspecs, tydecs, tyvars) = 
                    (getTypsSpec(tytyvar), 
                    getTypsDec(tytyvar),
                    getTyVars(tytyvar))
        in (* we ignore tyvars here, we don't need them *)
        (
        specs @ (if (isPublic = true)  then tyspecs else []), 
        decs  @ (if (isPublic = false) then tydecs  else [])
        )
        end
    
    fun walkClass(eX, class, isPublic, (specs, decs)) = 
        let val _ = debug("walkClass entry\n")
            val Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info) = class
            val sd = case restriction of
                          Absyn.R_RECORD(_) =>        ( buildRecord  (ident, eX, isPublic, specs, decs) )
                        | Absyn.R_TYPE(_)   =>        ( buildType    (class, isPublic, specs, decs) )
                        | Absyn.R_TYPEVARIABLE(_) =>  ( buildType    (class, isPublic, specs, decs) )                        
                        | Absyn.R_FUNCTION(_) =>      ( buildRelation(ident, classdef, isPublic, specs, decs, NORMAL_FUNCTION) )
                        | Absyn.R_FUNCTION_TYPE(_) => ( buildRelation(ident, classdef, isPublic, specs, decs, TYPE_FUNCTION) )
                        | Absyn.R_UNIONTYPE(_) =>     ( buildDatatype(ident, classdef, isPublic, specs, decs) )
                        | _ => 
                        errorAtFunction(
                            info, 
                            "expected record|type|function|uniontype!", 
                            "walkClass")
        in
          appendSD(sd, ([], [])) 
        end        
        
    and sweepTopElements([], isPublic, sd) = sd
        | sweepTopElements(
            (eX as Absyn.ELEMENTITEM(Absyn.ELEMENT(_,_,_,ident, elementSpec, info, _),_))::rest, isPublic, (specs, decs)) = 
            (
            debug("sweepTopElements: "^(Absyn.identName ident)^" rest: "^L(rest)^"\n");
            (case  elementSpec of 
                Absyn.CLASSDEF(_, class, _) => 
                    ( 
                      debug("sweepTopElements -> CLASSDEF\n");
                      sweepTopElements(rest, isPublic, walkClass(eX, class, isPublic, (specs, decs)))
                    )
              | c as Absyn.COMPONENTS(_) => 
                    ( 
                    debug("sweepTopElements -> COMPONENTS\n"); 
                    appendSD(createValDecls(c, isPublic, specs, decs), sweepTopElements(rest, isPublic, ([], [])))
                    )
              | Absyn.IMPORT(import, _ , info) =>
                        let    val path = 
                            case import of
                              Absyn.QUAL_IMPORT(path, importInfo) => path
                            | _ => 
                                errorAtFunction(
                                    info, 
                                    "only qualified imports are available in metamodelica", 
                                    "sweepTopElements")
                            val id = getPathLastIdent(path)
                            val importFile = ((Absyn.identName id)^".mo")
                            val x = (importFile, ref(Absyn.dummyInterface), info)
                        in  
                         (
                         debug("sweepTopElements -> IMPORT: "^importFile^"\n");
                         appendSD((
                         specs @ (if (isPublic = true) then [Absyn.WITHspec(x)] else []), 
                         decs @ (if (isPublic = false) then [Absyn.WITHdec(x)] else [])),
                                  sweepTopElements(rest, isPublic, ([], [])))
                         )
                        end
              | _ => errorAtFunction(
                        info, 
                        "only class definitions, components and imports are possible in the top package in metamodelica", 
                        "sweepTopElements"))
            )
        | sweepTopElements(Absyn.ANNOTATIONITEM(_, info)::rest, isPublic, (specs, decs)) = 
            (warnAtFunction(info, "ignoring annotation", "sweepTopElements"); 
             appendSD((specs,decs), sweepTopElements(rest, isPublic, ([], []))))

    and walkTop([Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info)], (specs, decs)) =
        let val _ = 
                case restriction of
                          Absyn.R_PACKAGE(_)  =>  ()
                        | _ => 
                            errorAtFunction(
                                info, 
                                "in metamodelica just ONE top enclosing package for all elements is allowed", 
                                "walkTop")
            val classparts' = 
                    case classdef of
                        Absyn.PARTS(classparts, _, _) => classparts
                      | _ => 
                        errorAtFunction(
                            info, 
                            "the top enclosing package cannot be of enumeration/derived class type", 
                            "walkTop")
                      
            fun sweepElems([], (s, d)) = (s, d)
              | sweepElems(classpart::rest, (s, d)) = 
                (case classpart of
                Absyn.PUBLIC(elementItems, _)      =>  
                    (* appendSD(sweepTopElements(elementItems, true, (s, d)), sweepElems(rest, ([],[]))) *)
                    sweepElems(rest, sweepTopElements(elementItems, true, (s, d)))
                | Absyn.PROTECTED(elementItems, _) =>  
                    (* appendSD(sweepTopElements(elementItems, false, (s, d)), sweepElems(rest, ([],[]))) *)
                    sweepElems(rest, sweepTopElements(elementItems, false, (s, d)))                    
                | _ =>     
                    errorAtFunction(
                        info, 
                        "the top enclosing package can contain only public or protected elements", 
                        "walkTop"))                
        in
           debug("walkTop\n"); 
           sweepElems(classparts', (specs, decs))
        end    
      | walkTop(_, (specs, decs)) = 
        bug("walkTop - You MUST have ONE top (package|model|class|function) that encloses all other elements!")


    fun removeSpecsDuplicates([]) = []
    |    removeSpecsDuplicates(spec::specs) =
        let fun is_there(x as Absyn.TYPEspec(_)) = 
                (case spec of
                    Absyn.TYPEspec(_) => getIdentFromTySpec(x) = getIdentFromTySpec(spec)
                |    _ => false)
            |    is_there(_) = false
        in 
          if List.exists is_there specs
          then removeSpecsDuplicates(specs)
          else spec::removeSpecsDuplicates(specs)
        end    

    fun removeDecsDuplicates([]) = []
    |    removeDecsDuplicates(dec::decs) =
        let fun is_there(x as Absyn.TYPEdec(_)) = 
                (case dec of
                    Absyn.TYPEdec(_) => getIdentFromTyDec(x) = getIdentFromTyDec(dec)
                |    _ => false)
            |    is_there(_) = false
        in 
          if List.exists is_there decs
          then removeDecsDuplicates(decs)
          else dec::removeDecsDuplicates(decs)
        end        

    fun removeSpecsDecsDuplicates([], _) = []
    |    removeSpecsDecsDuplicates(spec::specs, decs) =
        let fun is_there(dec as Absyn.TYPEdec(_)) = 
                (case dec of
                    Absyn.TYPEdec(_) => 
                    (case spec of
                        Absyn.TYPEspec(_) => getIdentFromTyDec(dec) = getIdentFromTySpec(spec)
                    |   _ => false
                    )
                |    _ => false)
            |    is_there(_) = false
        in 
          if List.exists is_there decs
          then removeSpecsDecsDuplicates(specs, decs)
          else spec::removeSpecsDecsDuplicates(specs, decs)
        end    

    fun fixSpecsWithTyVar([], bindlist) = []
    |    fixSpecsWithTyVar(
            Absyn.TYPEspec(
                [Absyn.TYPBIND(tyvarlist, lid, ty, infoTB)], 
                infoTS)::rest, bindlist) =
        Absyn.TYPEspec(
            [Absyn.TYPBIND(
                removeTyVarDuplicates(tyvarlist @ getTyVar(ty, bindlist)), lid, 
                setTyVar(ty, bindlist), 
                infoTB)], 
                infoTS)::fixSpecsWithTyVar(rest, bindlist)
    |   fixSpecsWithTyVar(
            Absyn.DATAspec(
                [Absyn.DATBIND(tyvarlist1, lid1, conlst, infoDB)], 
                zz,
                infoTS)::rest, bindlist) =
        Absyn.DATAspec(
            [Absyn.DATBIND(
                removeTyVarDuplicates(tyvarlist1 @ getCONBINDTyVar(conlst, bindlist)), lid1, 
                fixCONBIND(conlst, bindlist), 
                infoDB)], 
                zz,
                infoTS)::fixSpecsWithTyVar(rest, bindlist)
    |   fixSpecsWithTyVar(
            Absyn.VALspec(ident, ty, info)::rest, bindlist) =
        Absyn.VALspec(ident, setTyVar(ty, bindlist), info)::fixSpecsWithTyVar(rest, bindlist)
    | fixSpecsWithTyVar(x::rest, bindlist) = x::fixSpecsWithTyVar(rest, bindlist)

    fun fixDecsWithTyVar([], bindlist) = []
    |    fixDecsWithTyVar(
            Absyn.TYPEdec(
                [Absyn.TYPBIND(tyvarlist, lid, ty, infoTB)], 
                infoTD)::rest, bindlist) =
        Absyn.TYPEdec(
            [Absyn.TYPBIND(
                removeTyVarDuplicates(tyvarlist @ getTyVar(ty, bindlist)), lid, 
                setTyVar(ty, bindlist), infoTB)], 
                infoTD)::fixDecsWithTyVar(rest, bindlist)
    | fixDecsWithTyVar(
        Absyn.DATAdec(
                [Absyn.DATBIND(tyvarlist1, lid1, conlst, infoDB)], 
                zz,
                infoTS)::rest, bindlist) =
        Absyn.DATAdec(
            [Absyn.DATBIND(
                removeTyVarDuplicates(tyvarlist1 @ getCONBINDTyVar(conlst, bindlist)), lid1, 
                fixCONBIND(conlst, bindlist), 
                infoDB)], 
                zz,
                infoTS)::fixDecsWithTyVar(rest, bindlist)
    |    fixDecsWithTyVar(x::rest, bindlist) = x::fixDecsWithTyVar(rest, bindlist)


    fun fixRELSpecsWithTyVar([], bindlist) = []
    |    fixRELSpecsWithTyVar(Absyn.RELspec(ident, ty, info)::rest, bindlist) =
        Absyn.RELspec(ident, 
            if (List.length (getTyVar(ty, bindlist)) > 0) 
            then setTyVar(ty, bindlist)
            else ty, info)
        ::fixRELSpecsWithTyVar(rest, bindlist)
    |    fixRELSpecsWithTyVar(x::rest, bindlist) = x::fixRELSpecsWithTyVar(rest, bindlist)


    fun fixTypeVariablesInLocalVars([], bindlist) = []
    |    fixTypeVariablesInLocalVars((id, SOME(ty), exp, attr)::rest, bindlist) = 
    let
    in
        (id, SOME(setTyVar(ty, bindlist)), exp, attr)::fixTypeVariablesInLocalVars(rest, bindlist)
    end
    |    fixTypeVariablesInLocalVars(x::rest, bindlist) = x::fixTypeVariablesInLocalVars(rest, bindlist)
    
    fun fixTypeVariablesInClause(Absyn.CLAUSE1(g, id, pl, rs, plr, localVars, info), bindlist) = 
        Absyn.CLAUSE1(constructProperANDgoalChainOpt(g), id, pl, rs, plr, fixTypeVariablesInLocalVars(localVars, bindlist), info)        
    |    fixTypeVariablesInClause(Absyn.CLAUSE2(c1, c2, info), bindlist) =
        Absyn.CLAUSE2(
            fixTypeVariablesInClause(c1, bindlist), 
            fixTypeVariablesInClause(c2, bindlist), 
            info)
    |    fixTypeVariablesInClause(Absyn.CLAUSE3(c1, c2, info), bindlist) =
        Absyn.CLAUSE3(
            fixTypeVariablesInClause(c1, bindlist), 
            fixTypeVariablesInClause(c2, bindlist), 
            info)

    fun fixRELBINDSDecsWithTyVar([], bindlist) = []
    |    fixRELBINDSDecsWithTyVar(Absyn.RELBIND(ident, ty_opt, clause, x, y, info)::rest, bindlist) =
        let val x = fixTypeVariablesInLocalVars(x, bindlist)
            val clause = fixTypeVariablesInClause(clause, bindlist)
        in
        case ty_opt of
            NONE => 
                Absyn.RELBIND(ident, NONE, clause, x, y, info)::
                fixRELBINDSDecsWithTyVar(rest, bindlist)
        |    SOME(ty) => 
                Absyn.RELBIND(ident, SOME(setTyVar(ty, bindlist)), clause, x, y, info)::
                fixRELBINDSDecsWithTyVar(rest, bindlist)
        end

    fun fixRELDecsWithTyVar([], bindlist) = []
    |    fixRELDecsWithTyVar(Absyn.RELdec(reldecs, info)::rest, bindlist) =
        Absyn.RELdec(fixRELBINDSDecsWithTyVar(reldecs, bindlist), info)::
        fixRELDecsWithTyVar(rest, bindlist)
    |    fixRELDecsWithTyVar(x::rest, bindlist) = x::fixRELDecsWithTyVar(rest, bindlist)


    fun fixSpecsConstantsType([], dlist) = []
    |   fixSpecsConstantsType(Absyn.VALspec(id, Absyn.CONSty([], longid, ii), info)::rest, dlist) = 
        let 
           val x = Absyn.VALspec(id, Absyn.CONSty(getDataBinding(longid, dlist), longid, ii), info)
        in
          x::fixSpecsConstantsType(rest, dlist)
        end
    |   fixSpecsConstantsType(x::rest, dlist) = x::fixSpecsConstantsType(rest, dlist)

    fun fixTypeVariables(specs, decs) = 
    let val bindlist = getTyBindings(specs, decs)
        val _ = debug("fixTypeVariables: bindlist:"^L(bindlist)^"\n")
        val (specs, decs) = ( fixRELSpecsWithTyVar(fixSpecsWithTyVar(specs, bindlist), bindlist), fixRELDecsWithTyVar(fixDecsWithTyVar(decs, bindlist),  bindlist) )
        val datatypeLst = getDataBindings(specs, decs)
    in
    (
        (fixSpecsConstantsType(specs, datatypeLst), decs)
    )
    end
    
    fun moveTypeAliasesToSpecs(specs, []) = specs
    |    moveTypeAliasesToSpecs(specs, dec::decs) = 
        let 
        in 
        case dec of (* no type variables, only lidz *)
            Absyn.TYPEdec(
                x as [Absyn.TYPBIND([], lid1, Absyn.CONSty([], lid2, _), _)], info) => 
                    moveTypeAliasesToSpecs(Absyn.TYPEspec(x, info)::specs, decs)
            |   _ => moveTypeAliasesToSpecs(specs, decs)
        end

    fun sweepTopElementsImports([], isPublic, sd) = sd
        | sweepTopElementsImports(
            Absyn.ELEMENTITEM(Absyn.ELEMENT(_,_,_,ident, elementSpec, info, _),_)::rest, isPublic, (specs, decs)) = 
            (
            debug("sweepTopElementsImports: "^(Absyn.identName ident)^" rest: "^L(rest)^"\n");
            (case  elementSpec of 
               Absyn.IMPORT(import, _, info) =>
                        let    val path = 
                            case import of
                              Absyn.QUAL_IMPORT(path, importInfo) => path
                            | _ => 
                                errorAtFunction(
                                    info, 
                                    "only qualified imports are available in metamodelica", 
                                    "sweepTopElementsImports")
                            val id = getPathLastIdent(path)
                            val importFile = ((Absyn.identName id)^".mo")
                            val x = (importFile, ref(Absyn.dummyInterface), info)
                        in  
                         (
                         debug("sweepTopElementsImports -> IMPORT: "^importFile^"\n");
                         appendSD((
                         specs @ (if (isPublic = true) then [Absyn.WITHspec(x)] else []), 
                         decs @ (if (isPublic = false) then [Absyn.WITHdec(x)] else [])),
                                  sweepTopElementsImports(rest, isPublic, ([], [])))
                         )
                        end
              | _ => appendSD((specs,decs), sweepTopElementsImports(rest, isPublic, ([], [])))
                         )
            )
        | sweepTopElementsImports(Absyn.ANNOTATIONITEM(_, info)::rest, isPublic, (specs, decs)) = 
            (warnAtFunction(info, "ignoring annotation", "sweepTopElementsImports"); 
             appendSD((specs,decs), sweepTopElements(rest, isPublic, ([], []))))

    and walkTopImports([Absyn.CLASS(ident,partial,final,encapsulated,restriction,classdef,info)], (specs, decs)) =
        let val _ = 
                case restriction of
                  Absyn.R_PACKAGE(_)  =>  ()
                | _ =>
                    errorAtFunction(
                        info, 
                        "in metamodelica just ONE top enclosing package for all elements is allowed", 
                        "walkTop")
            val classparts' = 
                    case classdef of
                        Absyn.PARTS(classparts, _, _) => classparts
                      | _ => 
                        errorAtFunction(
                            info, 
                            "the top enclosing package cannot be of enumeration/derived class type", 
                            "walkTop")
            fun sweepElems([], (s, d)) = (s, d)
              | sweepElems(classpart::rest, (s, d)) = 
                case classpart of
                Absyn.PUBLIC(elementItems, _)      =>  
                    (* appendSD(sweepTopElementsImports(elementItems, true, (s, d)), sweepElems(rest, ([],[]))) *)
                    sweepElems(rest, sweepTopElementsImports(elementItems, true, (s, d)))
                | Absyn.PROTECTED(elementItems, _) =>  
                    (* appendSD(sweepTopElementsImports(elementItems, false, (s, d)), sweepElems(rest, ([],[]))) *)
                    sweepElems(rest, sweepTopElementsImports(elementItems, false, (s, d)))                    
                | _ => 
                    errorAtFunction(
                        info, 
                        "the top enclosing package can contain only public or protected elements", 
                        "walkTopImports")
        in
           debug("walkTopImports\n"); 
           sweepElems(classparts', (specs, decs))
        end    
      | walkTopImports(_, (specs, decs)) = 
        bug("walkTopImports - You MUST have ONE top (package|model|class|function) that encloses all other elements!")


    fun buildInterfaceAndDecs(Absyn.PROGRAM(classes, within, interface, info)) =
    (*
    if !Control.dumpDepends 
    then
        let val _ = if (List.length classes <> 1)
                    then errorAtFunction(
                            info, 
                            "You MUST have only ONE top (package|model|class|function) that encloses all other elements!",
                            "buildInterfaceAndDecs")
                    else ()
            val (specs, decs) = walkTopImports(classes, ([] (* specs *), [] (* decs *)) )
            val Absyn.INTERFACE({modid,source,...}, infoI) = interface
        in 
          debug ("buildInterfaceAndDecs - specs: "^L(specs)^
                ", decs: "^L(decs)^"\n");                  
          (Absyn.INTERFACE({
            modid=modid, 
            specs=specs, 
            source=source}, infoI), decs) 
        end    
    else
    *)
        let val _ = if (List.length classes <> 1)
                    then errorAtFunction(
                            info, 
                            "You MUST have only ONE top (package|model|class|function) that encloses all other elements!",
                            "buildInterfaceAndDecs")
                    else ()
            val (specs, decs) = walkTop(classes, ([] (* specs *), [] (* decs *)) )
            val Absyn.INTERFACE({modid,source,...}, infoI) = interface
            val uniqueSpecs  = removeSpecsDuplicates(specs)
            val uniqueDecs   = removeDecsDuplicates(decs)
            (*val aliasesSpecs = moveTypeAliasesToSpecs(uniqueSpecs, uniqueDecs)*) 
            val aliasesDecs  = removeDecsSpecsDuplicates(uniqueDecs, uniqueSpecs(*aliasesSpecs*))
            val (specs', decs') = 
                fixTypeVariables(removeSpecsDecsDuplicates(uniqueSpecs(*aliasesSpecs*), aliasesDecs),
                                 aliasesDecs)
        in 
          debug ("buildInterfaceAndDecs - specs: "^L(specs)^", decs: "^L(decs)^"\n");                  
          (Absyn.INTERFACE({modid=modid, specs=specs', source=source}, infoI), decs') 
        end
        
    fun buildInfo(Absyn.PROGRAM(_, _, _, info)) = info
    
    val (interface, decs) = buildInterfaceAndDecs(modelica) 
    val Absyn.INTERFACE({modid,source,...}, infoI) = interface
    val module = Absyn.MODULE(interface, decs, buildInfo(modelica))

in
       module         
end    
            
             
  end (* functor MOToRMLFn *)
