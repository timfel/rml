package Scheme " scheme.rml "
import types;

type CombList = list<Comb>;

uniontype Comb
  record QUOTE
    Types.Type x1;
  end QUOTE;
  record BOUND
    Integer x1;
  end BOUND;
  record MKCONS
    CombList x1;
    Types.TyName x2;
  end MKCONS;
end Comb;

type TypesTyNameList = list<Types.TyName>;

type TypesTyNameListOption = Option<TypesTyNameList>;

type AlphaScheme = tuple<Boolean,TypesTyNameListOption>;

type AlphaSchemeList = list<AlphaScheme>;

uniontype Scheme
  record SCHEME
    AlphaSchemeList x1;
    Comb x2;
  end SCHEME;
end Scheme;
import util;

protected function mkbvalphas " INSTANTIATION "
  input TupleBooleanStringListOptionList in_tuplebooleanstringlistoptionlist;
  input Integer in_integer;
  output TypesAlphaList out_typesalphalist;
protected 
  type StringList = list<String>;
  type StringListOption = Option<StringList>;
  type TupleBooleanStringListOption = tuple<Boolean,StringListOption>;
  type TupleBooleanStringListOptionList = list<TupleBooleanStringListOption>;
  type TypesAlphaList = list<Types.Alpha>;
algorithm 
  out_typesalphalist:=
  matchcontinue (in_tuplebooleanstringlistoptionlist,in_integer)
    local
      TypesAlphaList alphas;
      Types.Alpha alpha;
      Boolean eq;
      StringListOption ovld;
      TupleBooleanStringListOptionList bvars;
      Integer lev;
    case ({},_) then {}; 
    case ((eq,ovld) :: bvars,lev)
      equation 
        alphas = mkbvalphas(bvars, lev);
        alpha = Types.mkAlpha(lev, eq, ovld); then alpha :: alphas;
  end matchcontinue;
end mkbvalphas;

protected function mkbvtys
  input TypesAlphaList in_typesalphalist;
  output TypesTypeList out_typestypelist;
protected 
  type TypesAlphaList = list<Types.Alpha>;
  type TypesTypeList = list<Types.Type>;
algorithm 
  out_typestypelist:=
  matchcontinue (in_typesalphalist)
    local
      TypesTypeList tys;
      Types.Alpha alpha;
      TypesAlphaList alphas;
    case ({}) then {}; 
    case (alpha :: alphas)
      equation 
        tys = mkbvtys(alphas); then Types.VAR(alpha) :: tys;
  end matchcontinue;
end mkbvtys;

protected function inst2
  input Comb in_comb;
  input TypesTypeVector in_typestypevector;
  output Types.Type out_type;
protected 
  type TypesTypeVector = Types.Type[:];
algorithm 
  out_type:=
  matchcontinue (in_comb,in_typestypevector)
    local
      type TypesTypeList = list<Types.Type>;
      Types.Type ty;
      Integer i;
      TypesTypeVector bvars;
      TypesTypeList tys;
      CombList cs;
      String tyname;
    case (QUOTE(ty),_) then ty; 
    case (BOUND(i),bvars) then bvars[i + 1]; 
    case (MKCONS(cs,tyname),bvars)
      equation 
        tys = inst3(cs, bvars); then Types.CONS(tys,tyname);
  end matchcontinue;
end inst2;

protected function inst3
  input CombList in_comblist;
  input TypesTypeVector in_typestypevector;
  output TypesTypeList out_typestypelist;
protected 
  type TypesTypeVector = Types.Type[:];
  type TypesTypeList = list<Types.Type>;
algorithm 
  out_typestypelist:=
  matchcontinue (in_comblist,in_typestypevector)
    local
      Types.Type ty;
      TypesTypeList tys;
      Comb c;
      CombList cs;
      TypesTypeVector bvars;
    case ({},_) then {}; 
    case (c :: cs,bvars)
      equation 
        ty = inst2(c, bvars);
        tys = inst3(cs, bvars); then ty :: tys;
  end matchcontinue;
end inst3;

public function inst
  input Scheme in_scheme;
  input Integer in_integer;
  output TypesAlphaList out_typesalphalist;
  output Types.Type out_type;
protected 
  type TypesAlphaList = list<Types.Alpha>;
algorithm 
  (out_typesalphalist,out_type):=
  matchcontinue (in_scheme,in_integer)
    local
      type TypesTypeList = list<Types.Type>;
      type TypesTypeVector = Types.Type[:];
      type StringList = list<String>;
      type StringListOption = Option<StringList>;
      type TupleBooleanStringListOption = tuple<Boolean,StringListOption>;
      type TupleBooleanStringListOptionList = list<TupleBooleanStringListOption>;
      TypesAlphaList alphas;
      TypesTypeList tys;
      TypesTypeVector tys_1;
      Types.Type ty;
      TupleBooleanStringListOptionList bvars;
      Comb comb;
      Integer lev;
    case (SCHEME(bvars,comb),lev)
      equation 
        alphas = mkbvalphas(bvars, lev);
        tys = mkbvtys(alphas);
        tys_1 = list_vector(tys);
        ty = inst2(comb, tys_1); then (alphas,ty);
  end matchcontinue;
end inst;

protected function all_quotes " GENERALIZATION "
  input CombList in_comblist;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_comblist)
    local CombList cs;
    case {} then true; 
    case (QUOTE(_) :: cs)
      equation 
        all_quotes(cs); then true;
  end matchcontinue;
end all_quotes;

protected function unquote_all
  input CombList in_comblist;
  output TypesTypeList out_typestypelist;
protected 
  type TypesTypeList = list<Types.Type>;
algorithm 
  out_typestypelist:=
  matchcontinue (in_comblist)
    local
      TypesTypeList tys;
      Types.Type ty;
      CombList cs;
    case {} then {}; 
    case (QUOTE(ty) :: cs)
      equation 
        tys = unquote_all(cs); then ty :: tys;
  end matchcontinue;
end unquote_all;

protected function mkcons
  input CombList in_comblist;
  input String in_string;
  output Comb out_comb;
algorithm 
  out_comb:=
  matchcontinue (in_comblist,in_string)
    local
      type TypesTypeList = list<Types.Type>;
      TypesTypeList tys;
      CombList cs;
      String tyname;
    case (cs,tyname)
      equation 
        all_quotes(cs);
        tys = unquote_all(cs); then QUOTE(Types.CONS(tys,tyname));
    case (cs,tyname)
      equation 
        failure(all_quotes(cs)); then MKCONS(cs,tyname);
  end matchcontinue;
end mkcons;

protected function next_off
  input TupleType_aIntegerList in_tupletype_aintegerlist;
  output Integer out_integer;
protected 
  replaceable type Type_a;
  type TupleType_aInteger = tuple<Type_a,Integer>;
  type TupleType_aIntegerList = list<TupleType_aInteger>;
algorithm 
  out_integer:=
  matchcontinue (in_tupletype_aintegerlist)
    local Integer off;
    case {} then 0;  " domain of vector_nth is {0,nelts-1} "
    case ((_,off) :: _) then off + 1;  " domain of vector_nth is {0,nelts-1} "
  end matchcontinue;
end next_off;

protected function gen_bound
  input Type_a in_type_a;
  input TupleType_aIntegerList in_tupletype_aintegerlist;
  output TupleType_aIntegerList out_tupletype_aintegerlist;
  output Comb out_comb;
protected 
  replaceable type Type_a;
  type TupleType_aInteger = tuple<Type_a,Integer>;
  type TupleType_aIntegerList = list<TupleType_aInteger>;
algorithm 
  (out_tupletype_aintegerlist,out_comb):=
  matchcontinue (in_type_a,in_tupletype_aintegerlist)
    local
      Integer off;
      Type_a alpha;
      TupleType_aIntegerList bvars_in;
    case (alpha,bvars_in)
      equation 
        SOME(off) = Util.bound(bvars_in, alpha); then (bvars_in,BOUND(off));
    case (alpha,bvars_in)
      equation 
        NONE = Util.bound(bvars_in, alpha);
        off = next_off(bvars_in); then ((alpha,off) :: bvars_in,BOUND(off));
  end matchcontinue;
end gen_bound;

protected function cannot_gen
  input Types.Alpha in_alpha;
  input Integer in_integer;
  output Boolean out_boolean;
algorithm 
  out_boolean:=
  matchcontinue (in_alpha,in_integer)
    local Integer lev,limit;
    case (Types.ALPHA(_,_,_,SOME(_),_),_) then true; 
    case (Types.ALPHA(_,lev,_,NONE,_),limit) then (lev <= limit); 
  end matchcontinue;
end cannot_gen;

protected function gen_alpha
  input Types.Alpha in_alpha;
  input TupleTypesAlphaIntegerList in_tupletypesalphaintegerlist;
  input Integer in_integer;
  output TupleTypesAlphaIntegerList out_tupletypesalphaintegerlist;
  output Comb out_comb;
protected 
  type TupleTypesAlphaInteger = tuple<TypesAlpha,Integer>;
  type TupleTypesAlphaIntegerList = list<TupleTypesAlphaInteger>;
algorithm 
  (out_tupletypesalphaintegerlist,out_comb):=
  matchcontinue (in_alpha,in_tupletypesalphaintegerlist,in_integer)
    local
      replaceable type Type_a;
      Types.Alpha alpha;
      Type_a bvars_in;
      Integer limit;
      TupleTypesAlphaIntegerList bvars_out;
      Comb comb;
    case (alpha,bvars_in,limit)
      equation 
        true = cannot_gen(alpha, limit); then (bvars_in,QUOTE(Types.VAR(alpha)));
    case (alpha,bvars_in,limit)
      local TupleTypesAlphaIntegerList bvars_in;
      equation 
        false = cannot_gen(alpha, limit);
        (bvars_out,comb) = gen_bound(alpha, bvars_in); then (bvars_out,comb);
  end matchcontinue;
end gen_alpha;

protected function gen1
  input Types.Type in_type;
  input TupleTypesAlphaIntegerList in_tupletypesalphaintegerlist;
  input Integer in_integer;
  output TupleTypesAlphaIntegerList out_tupletypesalphaintegerlist;
  output Comb out_comb;
protected 
  type TupleTypesAlphaInteger = tuple<TypesAlpha,Integer>;
  type TupleTypesAlphaIntegerList = list<TupleTypesAlphaInteger>;
algorithm 
  (out_tupletypesalphaintegerlist,out_comb):=
  matchcontinue (in_type,in_tupletypesalphaintegerlist,in_integer)
    local
      replaceable type Type_a;
      Types.Type ty_1,ty;
      Type_a bvars_out,c,bvars_in,limit;
    case (ty,bvars_in,limit)
      equation 
        ty_1 = Types.deref(ty);
        (bvars_out,c) = gen2(ty_1, bvars_in, limit); then (bvars_out,c);
  end matchcontinue;
end gen1;

protected function gen2
  input Types.Type in_type;
  input TupleTypesAlphaIntegerList in_tupletypesalphaintegerlist;
  input Integer in_integer;
  output TupleTypesAlphaIntegerList out_tupletypesalphaintegerlist;
  output Comb out_comb;
protected 
  type TupleTypesAlphaInteger = tuple<TypesAlpha,Integer>;
  type TupleTypesAlphaIntegerList = list<TupleTypesAlphaInteger>;
algorithm 
  (out_tupletypesalphaintegerlist,out_comb):=
  matchcontinue (in_type,in_tupletypesalphaintegerlist,in_integer)
    local
      type TypesTypeList = list<Types.Type>;
      TupleTypesAlphaIntegerList bvars_out,bvars_in;
      Comb c;
      Types.Alpha alpha;
      Integer limit;
      CombList cs;
      TypesTypeList tys;
      String tyname;
    case (Types.VAR(alpha),bvars_in,limit)
      equation 
        (bvars_out,c) = gen_alpha(alpha, bvars_in, limit); then (bvars_out,c);
    case (Types.CONS(tys,tyname),bvars_in,limit)
      equation 
        (bvars_out,cs) = gen3(tys, bvars_in, limit);
        c = mkcons(cs, tyname); then (bvars_out,c);
  end matchcontinue;
end gen2;

protected function gen3
  input TypesTypeList in_typestypelist;
  input TupleTypesAlphaIntegerList in_tupletypesalphaintegerlist;
  input Integer in_integer;
  output TupleTypesAlphaIntegerList out_tupletypesalphaintegerlist;
  output CombList out_comblist;
protected 
  type TypesTypeList = list<Types.Type>;
  type TupleTypesAlphaInteger = tuple<TypesAlpha,Integer>;
  type TupleTypesAlphaIntegerList = list<TupleTypesAlphaInteger>;
algorithm 
  (out_tupletypesalphaintegerlist,out_comblist):=
  matchcontinue (in_typestypelist,in_tupletypesalphaintegerlist,in_integer)
    local
      replaceable type Type_a;
      type VType_aList = list<Type_a>;
      Type_a bvars_in,bvars_tmp,bvars_out,c,limit;
      VType_aList cs;
      Types.Type ty;
      TypesTypeList tys;
    case ({},bvars_in,_) then (bvars_in,{}); 
    case (ty :: tys,bvars_in,limit)
      equation 
        (bvars_tmp,cs) = gen3(tys, bvars_in, limit);
        (bvars_out,c) = gen1(ty, bvars_tmp, limit); then (bvars_out,c :: cs);
  end matchcontinue;
end gen3;

protected function gen_bvars
  input TupleTypesAlphaType_aList in_tupletypesalphatype_alist;
  input TupleBooleanStringListOptionList in_tuplebooleanstringlistoptionlist;
  output TupleBooleanStringListOptionList out_tuplebooleanstringlistoptionlist;
protected 
  replaceable type Type_a;
  type TupleTypesAlphaType_a = tuple<TypesAlpha,Type_a>;
  type TupleTypesAlphaType_aList = list<TupleTypesAlphaType_a>;
  type StringList = list<String>;
  type StringListOption = Option<StringList>;
  type TupleBooleanStringListOption = tuple<Boolean,StringListOption>;
  type TupleBooleanStringListOptionList = list<TupleBooleanStringListOption>;
algorithm 
  out_tuplebooleanstringlistoptionlist:=
  matchcontinue (in_tupletypesalphatype_alist,in_tuplebooleanstringlistoptionlist)
    local
      Type_a info;
      TupleBooleanStringListOptionList info_1;
      Boolean eq;
      StringListOption ovld;
      TupleTypesAlphaType_aList bvars;
    case ({},info) then info; 
    case ((Types.ALPHA(_,_,eq,ovld,_),_) :: bvars,info)
      local TupleBooleanStringListOptionList info;
      equation 
        info_1 = gen_bvars(bvars, (eq,ovld) :: info); then info_1;
  end matchcontinue;
end gen_bvars;

public function gen_limit
  input Types.Type ty;
  input Integer limit;
  output Scheme out_scheme;
protected 
  type TupleTypesAlphaInteger = tuple<TypesAlpha,Integer>;
  type TupleTypesAlphaIntegerList = list<TupleTypesAlphaInteger>;
  type StringList = list<String>;
  type StringListOption = Option<StringList>;
  type TupleBooleanStringListOption = tuple<Boolean,StringListOption>;
  type TupleBooleanStringListOptionList = list<TupleBooleanStringListOption>;
  TupleTypesAlphaIntegerList bvars_out;
  Comb comb;
  TupleBooleanStringListOptionList info;
algorithm 
  (bvars_out,comb) := gen1(ty, {}, limit);
  info := gen_bvars(bvars_out, {});
  out_scheme := SCHEME(info,comb);
end gen_limit;

public function gen_none
  input Types.Type in_type;
  output Scheme out_scheme;
algorithm 
  out_scheme:=
  matchcontinue (in_type)
    local Types.Type ty;
    case ty then SCHEME({},QUOTE(ty)); 
  end matchcontinue;
end gen_none;
end Scheme;

