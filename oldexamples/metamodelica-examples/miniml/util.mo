package Util " util.rml "

public function bound
  input TupleType_aType_bList in_tupletype_atype_blist;
  input Type_a in_type_a;
  output VType_bOption out_vtype_boption;
protected 
  replaceable type Type_a;
  replaceable type Type_b;
  type TupleType_aType_b = tuple<Type_a,Type_b>;
  type TupleType_aType_bList = list<TupleType_aType_b>;
  type VType_bOption = Option<Type_b>;
algorithm 
  out_vtype_boption:=
  matchcontinue (in_tupletype_atype_blist,in_type_a)
    local
      type VType_aOption = Option<Type_a>;
      type TupleType_aType_a = tuple<Type_a,Type_a>;
      type TupleType_aType_aList = list<TupleType_aType_a>;
      Type_a x,y,x_1;
      VType_aOption result;
      TupleType_aType_aList env;
    case ({},_) then NONE; 
    case ((x,y) :: _,x_1)
      equation 
        equality(x = x_1); then SOME(y);
    case ((x,_) :: env,x_1)
      equation 
        failure(equality(x = x_1));
        result = bound(env, x_1); then result;
  end matchcontinue;
end bound;

public function lookup
  input TupleType_aType_bList env;
  input Type_a x;
  output Type_b y;
protected 
  replaceable type Type_a;
  replaceable type Type_b;
  type TupleType_aType_b = tuple<Type_a,Type_b>;
  type TupleType_aType_bList = list<TupleType_aType_b>;
algorithm 
  SOME(y) := bound(env, x);
end lookup;

protected function intersect_1
  input VType_aList in_vtype_alist1;
  input VType_aList in_vtype_alist2;
  input VType_aList in_vtype_alist3;
  output VType_aList out_vtype_alist;
protected 
  replaceable type Type_a;
  type VType_aList = list<Type_a>;
algorithm 
  out_vtype_alist:=
  matchcontinue (in_vtype_alist1,in_vtype_alist2,in_vtype_alist3)
    local
      Type_a zs,x;
      VType_aList zs_1,xs,ys;
    case ({},_,zs) then zs; 
    case (x :: xs,ys,zs)
      local VType_aList zs;
      equation 
        true = list_member(x, ys);
        zs_1 = intersect_1(xs, ys, x :: zs); then zs_1;
    case (x :: xs,ys,zs)
      local VType_aList zs;
      equation 
        false = list_member(x, ys);
        zs_1 = intersect_1(xs, ys, zs); then zs_1;
  end matchcontinue;
end intersect_1;

public function intersect
  input VType_aList xs;
  input VType_aList ys;
  output VType_aList zs;
protected 
  replaceable type Type_a;
  type VType_aList = list<Type_a>;
algorithm 
  zs := intersect_1(xs, ys, {});
end intersect;
end Util;

