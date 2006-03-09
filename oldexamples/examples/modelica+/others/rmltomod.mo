String: absyn.rmlString: String: String: String: RecordString: String: RecordString: vectorString: recordString: ?String: NoFileString: in_valueString: out_value1String: in_value1String: intString: IntegerString: realString: RealString: boolString: BooleanString: stringString: StringString: listString: ListString: vectorString: VectorString: optionString: OptionString: consString: Exp?String: Expression unknown..String: consString: failString: xString: xString: dummyString: in_valueString: out_valueString: (* Non-Supported transformation *)
package RMLToMod
  function get_rml_id
  algorithm 
    match in_value1
        String name;
        Info info;
        String prefix;
        case Absyn.RMLSHORTID(name,info)            then name;
        case Absyn.RMLLONGID(prefix,name)            then name;
    end match;
  end get_rml_id;
  function get_path
  algorithm 
    match in_value1
        String name;
        Info info;
        String prefix;
        case Absyn.RMLSHORTID(name,info)            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLLONGID(prefix,name)            then #UNKNOWN EXPRESSION#;
    end match;
  end get_path;
  function get_specialtypetuple_id
  algorithm 
    match in_value1
        String lid;
        RMLType last;
        String fid;
        String rid;
        String tid;
        RMLType first;
        RMLTypeList rest;
        case             then "";
        case cons(last,)
          equation 
            get_specialtype_id(last, "") = lid;
            then lid;
        case cons(first,rest)
          equation 
            get_specialtype_id(first, "") = fid;
            get_specialtypetuple_id(rest) = rid;
            string_append(fid, rid) = tid;
            then tid;
    end match;
  end get_specialtypetuple_id;
  function get_specialtype_id
  algorithm 
    match in_value1
        case (Absyn.RMLTYPE_TYCONS(cons(last,),nid),id)
          equation 
            get_rml_id(nid) = mid;
            transform_id(mid) = cid;
            string_append(cid, id) = tid;
            get_specialtype_id(last, tid) = fid;
            then fid;
        case (Absyn.RMLTYPE_USERDEFINED(nid),id)
          equation 
            get_rml_id(nid) = mid;
            transform_id(mid) = cid;
            string_append(cid, id) = tid;
            then tid;
        case (Absyn.RMLTYPE_TUPLE(typelist),id)
          equation 
            get_specialtypetuple_id(typelist) = tid;
            string_append(tid, "Record") = fid;
            string_append(fid, id) = cid;
            then cid;
        case (Absyn.RMLTYPE_TYCONS(,nid),id)
          equation 
            get_rml_id(nid) = mid;
            transform_id(mid) = cid;
            string_append(cid, id) = tid;
            then tid;
    end match;
  end get_specialtype_id;
  function get_record_id
  algorithm 
    match in_value1
        case Absyn.RMLTYPE_TYCONS(cons(last,),id)
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cid;
            get_specialtype_id(last, cid) = fid;
            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLTYPE_USERDEFINED(id)
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cid;
            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLTYPE_TYCONS(,id)
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cid;
            then #UNKNOWN EXPRESSION#;
    end match;
  end get_record_id;
  function is_unique
  algorithm 
    match in_value1
        Boolean a;
        'a id;
        dummy list;
        case (id,list)
          equation 
            list_member(id, list) = b;
            bool_not(b) = a;
            then a;
        case (_,_)            then false;
    end match;
  end is_unique;
  function get_specialtypes_lst
  algorithm 
    match in_value1
        'a uniques;
        dummy ltypes;
        'a nlu;
        'a last;
        'a lu;
        dummy ftypes;
        'a funiques;
        dummy rtypes;
        'a nuniques;
        dummy type_list;
        'a first;
        dummy rest;
        case (,uniques)            then (#UNKNOWN EXPRESSION#,uniques);
        case (cons(last,),lu)
          equation 
            get_specialtypes(last, lu) = (ltypes,nlu);
            then (ltypes,nlu);
        case (cons(first,rest),uniques)
          equation 
            get_specialtypes(first, uniques) = (ftypes,funiques);
            get_specialtypes_lst(rest, funiques) = (rtypes,nuniques);
            list_append(ftypes, rtypes) = type_list;
            then (type_list,nuniques);
    end match;
  end get_specialtypes_lst;
  function get_specialtypes
  algorithm 
    match in_value1
        String mid;
        String cmid;
        String clid;
        String spec_id;
        String type_id;
        ClassDef derived;
        case (Absyn.RMLTYPE_TYCONS(cons(last,),id),uniques)
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cmid;
            get_specialtype_id(last, cmid) = type_id;
            is_unique(type_id, uniques) = true;
            get_specialtype_id(last, "") = spec_id;
            get_specialtype(mid, spec_id) = derived;
            create_class(type_id, R_TYPE, derived) = class;
            create_standard_elementitem(#UNKNOWN EXPRESSION#) = elementitem;
            get_specialtypes(last, #UNKNOWN EXPRESSION#) = (elast,nuniques);
            list_append(elast, #UNKNOWN EXPRESSION#) = specialtypes;
            then (specialtypes,nuniques);
        case (Absyn.RMLTYPE_TYCONS(cons(last,),id),uniques)
          equation 
            get_specialtypes(last, uniques) = (elast,nuniques);
            then (elast,nuniques);
        case (Absyn.RMLTYPE_TUPLE(typelist),uniques)
          equation 
            get_specialtypes_lst(typelist, uniques) = (specialtypes_sub,nuniques);
            get_specialtypetuple_id(typelist) = tuple_id;
            string_append(tuple_id, "Record") = type_id;
            is_unique(type_id, nuniques) = true;
            get_specialtype_record(typelist) = derived;
            create_class(type_id, R_TYPE, derived) = class;
            create_standard_elementitem(#UNKNOWN EXPRESSION#) = elementitem;
            list_append(specialtypes_sub, #UNKNOWN EXPRESSION#) = specialtypes;
            then (specialtypes,#UNKNOWN EXPRESSION#);
        case (Absyn.RMLTYPE_TYCONS(cons(Absyn.RMLTYPE_USERDEFINED(lid),),id),uniques)
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cmid;
            get_rml_id(lid) = clid;
            transform_id(clid) = spec_id;
            string_append(spec_id, cmid) = type_id;
            is_unique(type_id, uniques) = true;
            get_specialtype(mid, spec_id) = derived;
            create_class(type_id, R_TYPE, derived) = class;
            create_standard_elementitem(#UNKNOWN EXPRESSION#) = specialtypes;
            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case (_,uniques)            then (#UNKNOWN EXPRESSION#,uniques);
    end match;
  end get_specialtypes;
  function get_specialtype
  algorithm 
    match in_value1
        String spec_type;
        String spec_id;
        case (spec_type,spec_id)
          equation 
spec_type = "vector";
            then #UNKNOWN EXPRESSION#;
        case (spec_type,spec_id)            then #UNKNOWN EXPRESSION#;
    end match;
  end get_specialtype;
  function get_record_ides
  algorithm 
    match in_value1
        Path rid;
        RMLType last;
        case             then #UNKNOWN EXPRESSION#;
        case cons(last,)
          equation 
            get_record_id(last) = rid;
            then #UNKNOWN EXPRESSION#;
        case cons(first,rest)
          equation 
            get_record_id(first) = frid;
            get_record_ides(rest) = rrid;
            then #UNKNOWN EXPRESSION#;
    end match;
  end get_record_ides;
  function get_specialtype_record
  algorithm 
    match in_value1
        PathList pathlist;
        RMLTypeList typelist;
        case typelist
          equation 
            get_record_ides(typelist) = pathlist;
            then #UNKNOWN EXPRESSION#;
    end match;
  end get_specialtype_record;
  function create_classdef
  algorithm 
    match in_value1
        String id;
        Restriction restriction;
        case (id,(restriction,classparts))
          equation 
            create_class_parts(id, restriction, classparts) = class;
            then #UNKNOWN EXPRESSION#;
    end match;
  end create_classdef;
  function create_class_parts
  algorithm 
    match in_value1
        case (id,(restriction,classparts))            then #UNKNOWN EXPRESSION#;
    end match;
  end create_class_parts;
  function create_class
  algorithm 
    match in_value1
        String id;
        Restriction restriction;
        ClassDef classdef;
        case (id,(restriction,classdef))            then #UNKNOWN EXPRESSION#;
    end match;
  end create_class;
  function create_elementitem_list
  algorithm 
    match in_value1
        case             then #UNKNOWN EXPRESSION#;
        case cons(first,rest)
          equation 
            create_standard_elementitem(#UNKNOWN EXPRESSION#) = efirst;
            create_elementitem_list(rest) = erest;
            then #UNKNOWN EXPRESSION#;
    end match;
  end create_elementitem_list;
  function create_standard_elementitem
  algorithm 
    match in_value1
        case elementspec            then #UNKNOWN EXPRESSION#;
    end match;
  end create_standard_elementitem;
  function create_standard_algorithmitem
  algorithm 
    match in_value1
        case algorithm            then #UNKNOWN EXPRESSION#;
    end match;
  end create_standard_algorithmitem;
  function create_algorithm_inputs
  algorithm 
    match in_value1
        Integer i;
        Integer max;
        'a lst;
        Integer ic;
        String istr;
        case (i,(max,lst))
          equation 
            int_ge(i, max) = true;
            then #UNKNOWN EXPRESSION#;
        case (i,(max,lst))
          equation 
            int_add(i, 1) = ic;
            int_string(ic) = istr;
            string_append("in_value", istr) = str;
            create_algorithm_inputs(ic, max, lst) = mlst;
            list_append(#UNKNOWN EXPRESSION#, mlst) = nlst;
            then nlst;
    end match;
  end create_algorithm_inputs;
  function create_algorithm_output
  algorithm 
    match in_value1
        case 0            then NONE;
        case _            then #UNKNOWN EXPRESSION#;
    end match;
  end create_algorithm_output;
  function create_algorithm_match
  algorithm 
    match in_value1
        ComponentRefOption output;
        Integer inmax;
        Integer omax;
        ElementItemList eilist;
        case (1,(omax,(eilist,case_list)))
          equation 
            create_algorithm_output(omax) = output;
            then #UNKNOWN EXPRESSION#;
        case (inmax,(omax,(eilist,case_list)))
          equation 
            create_algorithm_inputs(0, inmax, #UNKNOWN EXPRESSION#) = input_list;
            create_algorithm_output(omax) = output;
            then #UNKNOWN EXPRESSION#;
    end match;
  end create_algorithm_match;
  function create_components
  algorithm 
    match in_value1
        String name;
        String id;
        Direction dir;
        case (name,(id,dir))            then #UNKNOWN EXPRESSION#;
    end match;
  end create_components;
  function create_standard_equationitem
  algorithm 
    match in_value1
        case equation            then #UNKNOWN EXPRESSION#;
    end match;
  end create_standard_equationitem;
  function create_functionargs
  algorithm 
    match in_value1
        ExpList exp_list;
        NamedArgList name_list;
        case (exp_list,name_list)            then #UNKNOWN EXPRESSION#;
    end match;
  end create_functionargs;
  function create_type
  algorithm 
    match in_value1
        case id            then #UNKNOWN EXPRESSION#;
    end match;
  end create_type;
  function create_cref
  algorithm 
    match in_value1
        String id;
        case id            then #UNKNOWN EXPRESSION#;
    end match;
  end create_cref;
  function transform_id
  algorithm 
    match in_value1
        String id;
        case id
          equation 
id = "int";
            then "Integer";
        case id
          equation 
id = "real";
            then "Real";
        case id
          equation 
id = "bool";
            then "Boolean";
        case id
          equation 
id = "string";
            then "String";
        case id
          equation 
id = "list";
            then "List";
        case id
          equation 
id = "vector";
            then "Vector";
        case id
          equation 
id = "option";
            then "Option";
        case id            then id;
    end match;
  end transform_id;
  function transform_literal
  algorithm 
    match in_value1
        case Absyn.RMLLIT_STRING(s)            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLLIT_INTEGER(i)            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLLIT_REAL(r)            then #UNKNOWN EXPRESSION#;
    end match;
  end transform_literal;
  function transform_expression_list
  algorithm 
    match in_value1
        case cons(last,)
          equation 
            transform_expression(last) = mlast;
            then #UNKNOWN EXPRESSION#;
        case cons(first,rest)
          equation 
            transform_expression(first) = mfirst;
            transform_expression_list(rest) = mrest;
            then #UNKNOWN EXPRESSION#;
        case             then #UNKNOWN EXPRESSION#;
    end match;
  end transform_expression_list;
  function transform_expression
  algorithm 
    match in_value1
        Path path;
        Exp mleft;
        Exp mright;
        Exp left;
        Exp right;
        Exp mexp;
        RMLLiteral lit;
        case Absyn.RMLCALL(id,args)
          equation 
            get_path(id) = path;
            transform_expression_list(args) = exp_list;
            then #UNKNOWN EXPRESSION#;
        case Absyn.RML_REFERENCE(id)
          equation 
            get_rml_id(id) = mid;
            create_cref(mid) = cref;
            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLLIST(exp_list)
          equation 
            transform_expression_list(exp_list) = mexp_list;
            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLCONS(left,right)
          equation 
            transform_expression(left) = mleft;
            transform_expression(right) = mright;
            then #UNKNOWN EXPRESSION#;
        case Absyn.BINARY(left,(op,right))
          equation 
            transform_expression(left) = mexp_left;
            transform_expression(right) = mexp_right;
            then #UNKNOWN EXPRESSION#;
        case Absyn.UNARY(op,exp)
          equation 
            transform_expression(exp) = mexp;
            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLLIT(lit)
          equation 
            transform_literal(lit) = mexp;
            then mexp;
        case RMLNIL            then #UNKNOWN EXPRESSION#;
        case x
          equation 
debug_print("Exp?", x);
print("Expression unknown..");
            then x;
    end match;
  end transform_expression;
  function transform_pattern_list
  algorithm 
    match in_value1
        case cons(last,)
          equation 
            transform_pattern(last) = (mlast,ids);
            then (#UNKNOWN EXPRESSION#,ids);
        case cons(first,rest)
          equation 
            transform_pattern(first) = (mfirst,ifirst);
            transform_pattern_list(rest) = (mrest,irest);
            list_append(ifirst, irest) = ids;
            then (#UNKNOWN EXPRESSION#,ids);
        case             then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
    end match;
  end transform_pattern_list;
  function transform_pattern
  algorithm 
    match in_value1
        String mid;
        RMLIdent id;
        case Absyn.RMLPAT_AS(id,pat)
          equation 
            get_rml_id(id) = mid;
            transform_pattern(pat) = (mpat,ids);
            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case Absyn.RMLPAT_CONS(first,rest)
          equation 
            transform_pattern(first) = (mfirst,ids1);
            transform_pattern(rest) = (mrest,ids2);
            list_append(ids1, ids2) = ids;
            then (#UNKNOWN EXPRESSION#,ids);
        case Absyn.RMLPAT_LIST(list)
          equation 
            transform_pattern_list(list) = (mpat_list,ids);
            then (#UNKNOWN EXPRESSION#,ids);
        case Absyn.RMLPAT_STRUCT(NONE,list)
          equation 
            transform_pattern_list(list) = (mpat_list,ids);
            then (#UNKNOWN EXPRESSION#,ids);
        case RMLPAT_NIL            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case Absyn.RMLPAT_STRUCT(SOME(id),patlist)
          equation 
            get_path(id) = mid;
            transform_pattern_list(patlist) = (mpat_list,ids);
            then (#UNKNOWN EXPRESSION#,ids);
        case Absyn.RMLPAT_IDENT(id)
          equation 
            get_rml_id(id) = mid;
            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case RMLPAT_WILDCARD            then (MWILDpat,#UNKNOWN EXPRESSION#);
        case Absyn.RMLPAT_LITERAL(lit)
          equation 
            transform_literal(lit) = mexp;
            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
    end match;
  end transform_pattern;
  function transform_goals
  algorithm 
    match in_value1
        case Absyn.RMLGOAL_AND(leftgoal,rightgoal)
          equation 
            transform_goal(leftgoal) = (eqleft,ids1);
            create_standard_equationitem(eqleft) = eqitem_left;
            transform_goals(rightgoal) = (restei,ids2);
            list_append(ids1, ids2) = ids;
            then (#UNKNOWN EXPRESSION#,ids);
        case x
          equation 
            transform_goal(x) = (equation,ids);
            create_standard_equationitem(equation) = eqitem;
            then (#UNKNOWN EXPRESSION#,ids);
    end match;
  end transform_goals;
  function transform_goal
  algorithm 
    match in_value1
        String mid;
        Path path;
        Pattern mpat;
        case Absyn.RMLGOAL_NOT(goal)
          equation 
            transform_goal(goal) = (equation,ids);
            then (#UNKNOWN EXPRESSION#,ids);
        case Absyn.RMLGOAL_LET(pat,exp)
          equation 
            transform_pattern(pat) = (mpat,ids);
            transform_expression(exp) = mexp;
            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case Absyn.RMLGOAL_EQUAL(id,rightexp)
          equation 
            get_rml_id(id) = mid;
            transform_expression(rightexp) = rmexp;
            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case Absyn.RMLGOAL_RELATION(id,(args,NONE))
          equation 
            get_rml_id(id) = mid;
            transform_expression_list(args) = margs;
            create_functionargs(margs, #UNKNOWN EXPRESSION#) = fargs;
            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case Absyn.RMLGOAL_RELATION(id,(args,SOME(pat)))
          equation 
            get_path(id) = path;
            transform_expression_list(args) = margs;
            create_functionargs(margs, #UNKNOWN EXPRESSION#) = fargs;
            transform_pattern(pat) = (mpat,ids);
            then (#UNKNOWN EXPRESSION#,ids);
    end match;
  end transform_goal;
  function transform_result
  algorithm 
    match in_value1
        case RMLResultFail            then #UNKNOWN EXPRESSION#;
        case RMLNoResult            then #UNKNOWN EXPRESSION#;
        case Absyn.RMLResultExp(cons(last,))
          equation 
            transform_expression(last) = exp;
            then exp;
        case Absyn.RMLResultExp(list)
          equation 
            transform_expression_list(list) = exp_list;
            then #UNKNOWN EXPRESSION#;
    end match;
  end transform_result;
  function transform_rule
  algorithm 
    match in_value1
        case Absyn.RMLRULE(id,(pattern,(SOME(goal),result)))
          equation 
            transform_goals(goal) = (equation_item_list,rml_idents1);
            transform_pattern(pattern) = (mpattern,rml_idents2);
            transform_result(result) = cresult;
            list_append(rml_idents1, rml_idents2) = rml_idents;
            then (#UNKNOWN EXPRESSION#,rml_idents);
        case Absyn.RMLRULE(id,(pattern,(NONE,result)))
          equation 
            transform_pattern(pattern) = (mpattern,rml_idents);
            transform_result(result) = cresult;
            then (#UNKNOWN EXPRESSION#,rml_idents);
    end match;
  end transform_rule;
  function transform_rule_list
  algorithm 
    match in_value1
        case             then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case cons(last,)
          equation 
            transform_rule(last) = (lastc,lasti);
            then (#UNKNOWN EXPRESSION#,lasti);
        case cons(first,rest)
          equation 
            transform_rule(first) = (firstc,firsti);
            transform_rule_list(rest) = (restc,resti);
            list_append(firsti, resti) = ids;
            then (#UNKNOWN EXPRESSION#,ids);
    end match;
  end transform_rule_list;
  function transform_type_tuple
  algorithm 
    match in_value1
        case (cons(last,),i)
          equation 
            int_add(i, 1) = ic;
            int_string(ic) = istr;
            string_append("x", istr) = cname;
            transform_type(cname, last, BIDIR) = lastei;
            then #UNKNOWN EXPRESSION#;
        case (cons(first,rest),i)
          equation 
            int_add(i, 1) = ic;
            int_string(ic) = istr;
            string_append("x", istr) = cname;
            transform_type(cname, first, BIDIR) = firstei;
            transform_type_tuple(rest, ic) = restei;
            then #UNKNOWN EXPRESSION#;
    end match;
  end transform_type_tuple;
  function transform_iotype
  algorithm 
    match in_value1
        'a name;
        'a i;
        'a dir;
        Integer ic;
        String istr;
        String cname;
        ElementItem mfirst;
        ElementItemList mrest;
        RMLType first;
        RMLTypeList rest;
        case (name,(i,(,dir)))            then #UNKNOWN EXPRESSION#;
        case (name,(i,(cons(first,rest),dir)))
          equation 
            int_add(i, 1) = ic;
            int_string(ic) = istr;
            string_append(name, istr) = cname;
            transform_type(cname, first, dir) = mfirst;
            transform_iotype(name, ic, rest, dir) = mrest;
            then #UNKNOWN EXPRESSION#;
    end match;
  end transform_iotype;
  function transform_type
  algorithm 
    match in_value1
        String name;
        Direction dir;
        case (name,(Absyn.RMLTYPE_TUPLE(cons(ftype,rest)),dir))
          equation 
            transform_type(name, ftype, dir) = elementitem;
            then elementitem;
        case (name,(Absyn.RMLTYPE_TYCONS(cons(last,),id),dir))
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cid;
            get_specialtype_id(last, cid) = special_id;
            create_components(name, special_id, dir) = components;
            create_standard_elementitem(components) = elementitem;
            then elementitem;
        case (name,(Absyn.RMLTYPE_TYCONS(,id),dir))
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cid;
            create_components(name, cid, dir) = components;
            create_standard_elementitem(components) = elementitem;
            then elementitem;
        case (name,(Absyn.RMLTYPE_TYVAR(id),dir))
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cid;
            create_components(name, cid, dir) = components;
            create_standard_elementitem(components) = elementitem;
            then elementitem;
        case (name,(Absyn.RMLTYPE_USERDEFINED(id),dir))
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cid;
            create_components(name, cid, dir) = components;
            create_standard_elementitem(components) = elementitem;
            then elementitem;
        case (name,(_,dir))
          equation 
            create_components(name, "dummy", dir) = components;
            create_standard_elementitem(components) = elementitem;
            then elementitem;
    end match;
  end transform_type;
  function transform_dtmember
  algorithm 
    match in_value1
        ElementItemList special_types;
        StringList nuniques;
        ElementItemList components;
        String mid;
        ElementSpec classdef;
        ElementItem elementitem;
        RMLIdent id;
        RMLTypeList typelist;
        StringList uniques;
        case (Absyn.DTCONS(id,),uniques)
          equation 
            get_rml_id(id) = mid;
            create_classdef(mid, R_RECORD, #UNKNOWN EXPRESSION#) = classdef;
            create_standard_elementitem(classdef) = elementitem;
            then (elementitem,#UNKNOWN EXPRESSION#,uniques);
        case (Absyn.DTCONS(id,typelist),uniques)
          equation 
            get_specialtypes_lst(typelist, uniques) = (special_types,nuniques);
            transform_type_tuple(typelist, 0) = components;
            get_rml_id(id) = mid;
            create_classdef(mid, R_RECORD, #UNKNOWN EXPRESSION#) = classdef;
            create_standard_elementitem(classdef) = elementitem;
            then (elementitem,special_types,nuniques);
    end match;
  end transform_dtmember;
  function transform_dtmember_list
  algorithm 
    match in_value1
        ElementItemList type_list;
        DTMember first;
        DTMemberList rest;
        case (cons(last,),ul)
          equation 
            transform_dtmember(last, ul) = (lastrecord,(lspec,nlu));
            then (#UNKNOWN EXPRESSION#,lspec,nlu);
        case (cons(first,rest),uniques)
          equation 
            transform_dtmember(first, uniques) = (firstrecord,(fspec,funiques));
            transform_dtmember_list(rest, funiques) = (restrecord,(rspec,runiques));
            list_append(fspec, rspec) = type_list;
            then (#UNKNOWN EXPRESSION#,type_list,runiques);
    end match;
  end transform_dtmember_list;
  function transform_decl_signature
  algorithm 
    match in_value1
        case Absyn.RMLTYPE_SIGNATURE(Absyn.CALLSIGN(intypes,outtypes))
          equation 
            transform_iotype("in_value", 0, intypes, INPUT) = mintypes;
            transform_iotype("out_value", 0, outtypes, OUTPUT) = mouttypes;
            list_append(mintypes, mouttypes) = inout_types;
            list_length(mintypes) = inlength;
            list_length(mouttypes) = outlength;
            then (inout_types,inlength,outlength);
    end match;
  end transform_decl_signature;
  function add_type
  algorithm 
    match in_value1
        StringList decls;
        case (Absyn.RMLSHORTID(varname,Absyn.INFO(filename,(ls,(cs,(le,ce))))),(decls,Absyn.RMLDB_VAR(dbfilename,(Absyn.RMLSHORTID(dbvar,_),(_,(Absyn.RMLDB_RANGE(dbls,(dbcs,(dble,dbce))),(_,the_type)))))))
          equation 
varname = dbvar;
            int_ge(cs, dbcs) = true;
            int_ge(dbce, cs) = true;
            int_ge(ls, dbls) = true;
            int_ge(dble, ls) = true;
            is_unique(varname, decls) = true;
            transform_type(varname, the_type, BIDIR) = eitem;
            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
    end match;
  end add_type;
  function get_type
  algorithm 
    match in_value1
        'a rmlident;
        'a decls;
        StringList fdecls;
        ElementItemList feitem;
        RMLDbElement fpdb;
        StringList rdecls;
        ElementItemList reitem;
        RMLDbElementList rpdb;
        case (rmlident,(decls,))            then (decls,#UNKNOWN EXPRESSION#);
        case (rmlident,(decls,cons(fpdb,_)))
          equation 
            add_type(rmlident, decls, fpdb) = (fdecls,feitem);
            then (fdecls,feitem);
        case (rmlident,(decls,cons(_,rpdb)))
          equation 
            get_type(rmlident, decls, rpdb) = (rdecls,reitem);
            then (rdecls,reitem);
    end match;
  end get_type;
  function get_local_decl
  algorithm 
    match in_value1
        StringList fdecl;
        ElementItemList feitem;
        dummy rdecls;
        ElementItemList reitems;
        ElementItemList eitems;
        RMLIdent first;
        RMLIdentList rest;
        StringList decls;
        RMLDbElementList pdb;
        case (,(_,_))            then (#UNKNOWN EXPRESSION#,#UNKNOWN EXPRESSION#);
        case (cons(first,rest),(decls,pdb))
          equation 
            get_type(first, decls, pdb) = (fdecl,feitem);
            get_local_decl(rest, fdecl, pdb) = (rdecls,reitems);
            list_append(feitem, reitems) = eitems;
            then (rdecls,eitems);
    end match;
  end get_local_decl;
  function transform_rmldecl
  algorithm 
    match in_value1
        ElementItemList in_out_decl;
        Integer il;
        Integer ol;
        CaseList case_list;
        RMLIdentList rml_idents;
        ElementItemList local_decl;
        Algorithm algorithm;
        AlgorithmItem ai;
        String mid;
        RMLIdent id;
        RMLType sign;
        RMLRuleList rules;
        RMLDbElementList pdb;
        ElementItemList recorddef;
        ElementItemList typedef;
        StringList uniques;
        ElementItemList def_lst;
        Class class;
        RMLTypeList type_list;
        DTMemberList dtmlist;
        case (Absyn.RELATION_DEFINITION(id,(SOME(sign),rules)),pdb)
          equation 
            transform_decl_signature(sign) = (in_out_decl,(il,ol));
            transform_rule_list(rules) = (case_list,rml_idents);
            get_local_decl(rml_idents, #UNKNOWN EXPRESSION#, pdb) = (_,local_decl);
            create_algorithm_match(il, ol, local_decl, case_list) = algorithm;
            create_standard_algorithmitem(algorithm) = ai;
            get_rml_id(id) = mid;
            create_class_parts(mid, R_FUNCTION, #UNKNOWN EXPRESSION#) = class;
            then #UNKNOWN EXPRESSION#;
        case (Absyn.RELATION_DEFINITION(id,(NONE,rules)),pdb)
          equation 
            transform_rule_list(rules) = (case_list,rml_idents);
            get_local_decl(rml_idents, #UNKNOWN EXPRESSION#, pdb) = (_,local_decl);
            create_algorithm_match(1, 0, local_decl, case_list) = algorithm;
            create_standard_algorithmitem(algorithm) = ai;
            get_rml_id(id) = mid;
            create_class_parts(mid, R_FUNCTION, #UNKNOWN EXPRESSION#) = class;
            then #UNKNOWN EXPRESSION#;
        case (Absyn.DATATYPEDECL(Absyn.DATATYPE(type_list,(id,dtmlist))),pdb)
          equation 
            transform_dtmember_list(dtmlist, #UNKNOWN EXPRESSION#) = (recorddef,(typedef,uniques));
            list_append(typedef, recorddef) = def_lst;
            get_rml_id(id) = mid;
            create_class_parts(mid, R_UNIONTYPE, #UNKNOWN EXPRESSION#) = class;
            then #UNKNOWN EXPRESSION#;
        case (Absyn.TYPE(type_id,Absyn.RMLTYPE_TUPLE(cons(Absyn.RMLTYPE_USERDEFINED(id),_))),pdb)
          equation 
            get_rml_id(id) = mid;
            transform_id(mid) = cid;
            create_type(cid) = derived;
            get_rml_id(type_id) = mtype_id;
            create_class(mtype_id, R_TYPE, derived) = class;
            then #UNKNOWN EXPRESSION#;
        case (Absyn.TYPE(type_id,Absyn.RMLTYPE_TUPLE(cons(x,_))),pdb)
          equation 
            get_specialtypes_lst(#UNKNOWN EXPRESSION#, #UNKNOWN EXPRESSION#) = (special_types,nuniques);
            getClasses(special_types) = classes;
            get_rml_id(type_id) = mtype_id;
            list_reverse(classes) = rclasses;
let cons(first,rest) = #UNKNOWN EXPRESSION#;
let Absyn.CLASS(classident,(partial,(final,(encapsulated,(restriction,classdef))))) = #UNKNOWN EXPRESSION#;
let fixed = #UNKNOWN EXPRESSION#;
let rfixed_classes = #UNKNOWN EXPRESSION#;
            list_reverse(rfixed_classes) = classes;
            then classes;
    end match;
  end transform_rmldecl;
  function getClasses
  algorithm 
    match in_value1
        ClassList classes;
        Class class;
        ElementItemList rest;
        case cons(Absyn.ELEMENTITEM(Absyn.ELEMENT(_,(_,(_,(_,(Absyn.CLASSDEF(_,class),(_,(_,_)))))))),rest)
          equation 
            getClasses(rest) = classes;
            then #UNKNOWN EXPRESSION#;
        case             then #UNKNOWN EXPRESSION#;
    end match;
  end getClasses;
  function transform_rmldecl_list
  algorithm 
    match in_value1
        ClassList classes_last;
        RMLDecl last;
        RMLDbElementList pdb;
        ClassList classes_first;
        ClassList classes_rest;
        RMLDecl first;
        RMLDeclList rest;
        RMLDeclList a;
        RMLDbElementList b;
        case (cons(last,),pdb)
          equation 
            transform_rmldecl(last, pdb) = classes_last;
            then classes_last;
        case (cons(first,rest),pdb)
          equation 
            transform_rmldecl(first, pdb) = classes_first;
            transform_rmldecl_list(rest, pdb) = classes_rest;
            list_append(classes_first, classes_rest) = classes;
            then classes;
        case (,_)            then #UNKNOWN EXPRESSION#;
        case (a,b)            then #UNKNOWN EXPRESSION#;
    end match;
  end transform_rmldecl_list;
  function transform_interfaces
  algorithm 
    match in_value1
        RMLDeclList x;
        RMLDbElementList pdb;
        case (x,pdb)
          equation 
            transform_rmldecl_list(x, pdb) = ast;
            then ast;
    end match;
  end transform_interfaces;
  function transform_definitions
  algorithm 
    match in_value1
        RMLDeclList x;
        RMLDbElementList pdb;
        case (x,pdb)
          equation 
            transform_rmldecl_list(x, pdb) = ast;
            then ast;
    end match;
  end transform_definitions;
  function transform
  algorithm 
    match in_value1
        String mid;
        RMLIdent id;
        RMLDeclList iflist;
        Program ast;
        RMLDbElementList pdb;
        case (Absyn.RML_FILE(id,(iflist,deflist)),pdb)
          equation 
            transform_interfaces(iflist, pdb) = classlist1;
            transform_definitions(deflist, pdb) = classlist2;
            list_append(classlist1, classlist2) = classlist;
            create_elementitem_list(classlist) = elist;
            get_rml_id(id) = mid;
            create_class_parts(mid, R_PACKAGE, #UNKNOWN EXPRESSION#) = class;
            then #UNKNOWN EXPRESSION#;
        case (ast,pdb)
          equation 
print("(* Non-Supported transformation *)
");
            then ast;
    end match;
  end transform;
end RMLToMod;

