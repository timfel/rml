package Main

type RealList = list<Real>;

type RealListArray = RealList[:];

uniontype tmp
  record V
    RealListArray x1;
  end V;
  record Vec
    RealListArray x1;
    RealListArray x2;
  end Vec;
end tmp;

type RealListList = list<RealList>;
constant RealListList ast=list(list(1.0),list(2.0),list(3.0)) " our AST ";

protected function loop_
  input Integer in_integer1;
  input Integer in_integer2;
  input RealListArray in_reallistarray3;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_integer1,in_integer2,in_reallistarray3)
    local
      Integer i_1,i,max;
      Real r;
      RealListArray vli;
      RealList l;
    case (i,max,vli)
      equation 
        (i < max) = true;
        i_1 = i + 1;
        r = int_real(i_1);
        vli = RML.array_update(vli, i_1, list(r));
        l = vli[i + 1];
        RML.debug_print("\nset:", l);
        apply(vli);
        loop_(i_1, max, vli); then true;
    case (i,max,_)
      equation 
        (i >= max) = true; then true;
  end matchcontinue;
end loop_;

protected function apply
  input VType_aArray arr;
protected 
  replaceable type Type_a;
  type VType_aArray = Type_a[:];
  type VType_aVector = Type_a[:];
  RealList li,li_new;
  RealListList lli;
  VType_aVector vec;
  RealListArray vli_1,vli,k,l;
  tmp z;
algorithm 
  li := list(10.0);
  lli := ast;
  vec := array_vector(arr);
  vli_1 := fill(li, 10);
  vli := list_array(lli);
  li_new := list(3.0);
  k := vli;
  vli_1 := array_update(vli_1, 1 + 1, li_new);
  vli := array_update(vli, 1 + 1, li_new);
  vli_1 := array_update(vli_1, 2 + 1, li_new);
  vli_1 := array_update(vli_1, 5, li_new);
  vli := array_update(vli, 2 + 1, li_new);
  vli_1 := array_add(vli_1, li_new);
  l := vli_1;
  z := Vec(k,l);
end apply;

public function main
  input StringList in_stringlist;
  output Boolean dummy;
protected 
  type StringList = list<String>;
algorithm 
  dummy:=
  matchcontinue (in_stringlist)
    local
      Integer max;
      RealList li;
      RealListArray vli;
    case (_)
      equation 
        max = 100;
        li = list(10.0);
        vli = fill(li, max);
        loop_(0, max, vli); then true;
  end matchcontinue;
end main;
end Main;

