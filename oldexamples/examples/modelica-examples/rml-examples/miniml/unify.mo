package Unify " unify.rml "
import types;
import util;

protected function same_alphas
  input Types.Alpha in_alpha1;
  input Types.Alpha in_alpha2;
  output Boolean out_boolean;
algorithm 
  out_boolean:=
  matchcontinue (in_alpha1,in_alpha2)
    local Integer tag1,tag2;
    case (Types.ALPHA(tag1,_,_,_,_),Types.ALPHA(tag2,_,_,_,_)) then (tag1 == tag2); 
  end matchcontinue;
end same_alphas;

protected function check_occur " OCCUR CHECK "
  input Types.Alpha alpha;
  input Types.Type ty;
protected 
  Types.Type ty_1;
algorithm 
  ty_1 := Types.deref(ty);
  ocheck2(alpha, ty_1);
end check_occur;

protected function ocheck2
  input Types.Alpha in_alpha;
  input Types.Type in_type;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_alpha,in_type)
    local
      type TypesTypeList = list<Types.Type>;
      Types.Alpha alpha,alpha_1;
      TypesTypeList tys;
    case (alpha,Types.VAR(alpha_1))
      equation 
        false = same_alphas(alpha, alpha_1); then true;
    case (alpha,Types.CONS(tys,_))
      equation 
        ocheck3(alpha, tys); then true;
  end matchcontinue;
end ocheck2;

protected function ocheck3
  input Types.Alpha in_alpha;
  input TypesTypeList in_typestypelist;
  output Boolean dummy;
protected 
  type TypesTypeList = list<Types.Type>;
algorithm 
  dummy:=
  matchcontinue (in_alpha,in_typestypelist)
    local
      replaceable type Type_a;
      Type_a alpha;
      Types.Type ty;
      TypesTypeList tys;
    case (_,{}) then true; 
    case (alpha,ty :: tys)
      equation 
        check_occur(alpha, ty);
        ocheck3(alpha, tys); then true;
  end matchcontinue;
end ocheck3;

protected function check_level " SCOPE LEVEL CHECK "
  input Integer maxlev;
  input Types.Type ty;
protected 
  Types.Type ty_1;
algorithm 
  ty_1 := Types.deref(ty);
  lcheck2(maxlev, ty_1);
end check_level;

protected function lcheck2
  input Integer in_integer;
  input Types.Type in_type;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_integer,in_type)
    local
      type StringList = list<String>;
      type StringListOption = Option<StringList>;
      type TypesTypelvar = lvar<Types.Type>;
      type TypesTypeList = list<Types.Type>;
      Integer maxlev,lev;
      Types.Alpha alpha;
      Boolean eq;
      StringListOption ovld;
      TypesTypelvar subst;
      TypesTypeList tys;
    case (maxlev,Types.VAR(Types.ALPHA(_,lev,_,_,_)))
      equation 
        (lev <= maxlev) = true; then true;
    case (maxlev,Types.VAR(Types.ALPHA(_,lev,eq,ovld,subst)))
      equation 
        (lev <= maxlev) = false;
        alpha = Types.mkAlpha(maxlev, eq, ovld);
        lvar_set(subst, Types.VAR(alpha)); then true;
    case (maxlev,Types.CONS(tys,_))
      equation 
        lcheck3(maxlev, tys); then true;
  end matchcontinue;
end lcheck2;

protected function lcheck3
  input Integer in_integer;
  input TypesTypeList in_typestypelist;
  output Boolean dummy;
protected 
  type TypesTypeList = list<Types.Type>;
algorithm 
  dummy:=
  matchcontinue (in_integer,in_typestypelist)
    local
      replaceable type Type_a;
      Type_a maxlev;
      Types.Type ty;
      TypesTypeList tys;
    case (_,{}) then true; 
    case (maxlev,ty :: tys)
      equation 
        check_level(maxlev, ty);
        lcheck3(maxlev, tys); then true;
  end matchcontinue;
end lcheck3;

protected function check_equality " EQUALITY CHECK "
  input Types.Type ty;
protected 
  Types.Type ty_1;
algorithm 
  ty_1 := Types.deref(ty);
  echeck2(ty_1);
end check_equality;

protected function echeck2
  input Types.Type in_type;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_type)
    local
      type StringList = list<String>;
      type StringListOption = Option<StringList>;
      type TypesTypelvar = lvar<Types.Type>;
      type TypesTypeList = list<Types.Type>;
      Boolean eq;
      Types.Alpha alpha;
      Integer lev;
      StringListOption ovld;
      TypesTypelvar subst;
      String name;
      TypesTypeList tys;
    case (Types.VAR(Types.ALPHA(_,_,eq,_,_)))
      equation 
        equality(eq = true); then true;
    case (Types.VAR(Types.ALPHA(_,lev,eq,ovld,subst)))
      equation 
        failure(equality(eq = true));
        alpha = Types.mkAlpha(lev, true, ovld);
        lvar_set(subst, Types.VAR(alpha)); then true;
    case (Types.CONS(_,name))
      equation 
        equality(name = "ref"); then true;
    case (Types.CONS(tys,name))
      equation 
        failure(equality(name = "ref"));
        failure(equality(name = "->"));
        echeck3(tys); then true;
  end matchcontinue;
end echeck2;

protected function echeck3
  input TypesTypeList in_typestypelist;
  output Boolean dummy;
protected 
  type TypesTypeList = list<Types.Type>;
algorithm 
  dummy:=
  matchcontinue (in_typestypelist)
    local
      Types.Type ty;
      TypesTypeList tys;
    case {} then true; 
    case (ty :: tys)
      equation 
        check_equality(ty);
        echeck3(tys); then true;
  end matchcontinue;
end echeck3;

protected function maybe_check_equality
  input Boolean in_boolean;
  input Types.Type in_type;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_boolean,in_type)
    local Types.Type ty;
    case (false,_) then true; 
    case (true,ty)
      equation 
        check_equality(ty); then true;
  end matchcontinue;
end maybe_check_equality;

protected function check_ovld " OVERLOADING CHECK "
  input StringListOption in_stringlistoption;
  input Types.Type in_type;
  output Boolean dummy;
protected 
  type StringList = list<String>;
  type StringListOption = Option<StringList>;
algorithm 
  dummy:=
  matchcontinue (in_stringlistoption,in_type)
    local
      StringList tynames;
      String tyname;
    case (NONE,_) then true; 
    case (SOME(tynames),Types.CONS({},tyname))
      equation 
        true = list_member(tyname, tynames); then true;
  end matchcontinue;
end check_ovld;

protected function bind_alpha " UNIFICATION "
  input Types.Alpha in_alpha;
  input Types.Type in_type;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_alpha,in_type)
    local
      type StringList = list<String>;
      type StringListOption = Option<StringList>;
      type TypesTypelvar = lvar<Types.Type>;
      Types.Alpha alpha1;
      Integer lev;
      Boolean eq;
      StringListOption ovld;
      TypesTypelvar subst;
      Types.Type ty2;
    case ((alpha1 = Types.ALPHA(_,lev,eq,ovld,subst)),ty2)
      equation 
        check_occur(alpha1, ty2);
        check_level(lev, ty2);
        maybe_check_equality(eq, ty2);
        check_ovld(ovld, ty2);
        lvar_set(subst, ty2); then true;
  end matchcontinue;
end bind_alpha;

protected function join_ovld
  input VType_aListOption in_vtype_alistoption1;
  input VType_aListOption in_vtype_alistoption2;
  output VType_aListOption out_vtype_alistoption;
protected 
  replaceable type Type_a;
  type VType_aList = list<Type_a>;
  type VType_aListOption = Option<VType_aList>;
algorithm 
  out_vtype_alistoption:=
  matchcontinue (in_vtype_alistoption1,in_vtype_alistoption2)
    local
      type VType_aOption = Option<Type_a>;
      Type_a ovld2;
      VType_aOption ovld1;
      VType_aList tynames3,tynames1,tynames2;
    case (NONE,ovld2) then ovld2; 
    case ((ovld1 = SOME(_)),NONE) then ovld1; 
    case (SOME(tynames1),SOME(tynames2))
      equation 
        tynames3 = Util.intersect(tynames1, tynames2); then SOME(tynames3);
  end matchcontinue;
end join_ovld;

protected function bind_alphas
  input Types.Alpha in_alpha1;
  input Types.Alpha in_alpha2;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_alpha1,in_alpha2)
    local
      type StringList = list<String>;
      type StringListOption = Option<StringList>;
      type TypesTypelvar = lvar<Types.Type>;
      Integer lev3,lev1,lev2;
      Boolean eq3,eq1,eq2;
      StringListOption ovld3,ovld1,ovld2;
      Types.Alpha alpha3;
      Types.Type ty3;
      TypesTypelvar subst1,subst2;
    case (Types.ALPHA(_,lev1,eq1,ovld1,subst1),Types.ALPHA(_,lev2,eq2,ovld2,subst2))
      equation 
        lev3 = int_min(lev1, lev2);
        eq3 = bool_or(eq1, eq2);
        ovld3 = join_ovld(ovld1, ovld2);
        alpha3 = Types.mkAlpha(lev3, eq3, ovld3);
        ty3 = Types.VAR(alpha3);
        lvar_set(subst1, ty3);
        lvar_set(subst2, ty3); then true;
  end matchcontinue;
end bind_alphas;

protected function unify_alphas
  input Types.Alpha in_alpha1;
  input Types.Alpha in_alpha2;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_alpha1,in_alpha2)
    local Types.Alpha alpha1,alpha2;
    case (alpha1,alpha2)
      equation 
        true = same_alphas(alpha1, alpha2); then true;
    case (alpha1,alpha2)
      equation 
        false = same_alphas(alpha1, alpha2);
        bind_alphas(alpha1, alpha2); then true;
  end matchcontinue;
end unify_alphas;

public function unify
  input Types.Type ty1;
  input Types.Type ty2;
protected 
  Types.Type ty1_1,ty2_1;
algorithm 
  ty1_1 := Types.deref(ty1);
  ty2_1 := Types.deref(ty2);
  unify2(ty1_1, ty2_1);
end unify;

protected function unify2
  input Types.Type in_type1;
  input Types.Type in_type2;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_type1,in_type2)
    local
      type TypesTypeList = list<Types.Type>;
      Types.Alpha alpha1,alpha2;
      Types.Type ty2,ty1;
      TypesTypeList tys1,tys2;
      String name1,name2;
    case (Types.VAR(alpha1),Types.VAR(alpha2))
      equation 
        unify_alphas(alpha1, alpha2); then true;
    case (Types.VAR(alpha1),(ty2 = Types.CONS(_,_)))
      equation 
        bind_alpha(alpha1, ty2); then true;
    case ((ty1 = Types.CONS(_,_)),Types.VAR(alpha2))
      equation 
        bind_alpha(alpha2, ty1); then true;
    case (Types.CONS(tys1,name1),Types.CONS(tys2,name2))
      equation 
        equality(name1 = name2);
        unify3(tys1, tys2); then true;
  end matchcontinue;
end unify2;

protected function unify3
  input TypesTypeList in_typestypelist1;
  input TypesTypeList in_typestypelist2;
  output Boolean dummy;
protected 
  type TypesTypeList = list<Types.Type>;
algorithm 
  dummy:=
  matchcontinue (in_typestypelist1,in_typestypelist2)
    local
      replaceable type Type_a;
      type VType_aList = list<Type_a>;
      Type_a ty1,ty2;
      VType_aList tys1,tys2;
    case ({},{}) then true; 
    case (ty1 :: tys1,ty2 :: tys2)
      equation 
        unify(ty1, ty2);
        unify3(tys1, tys2); then true;
  end matchcontinue;
end unify3;
end Unify;

