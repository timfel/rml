package Dynamic " dynamic.rml "
import absyn;

uniontype P1
  record P1REF
  end P1REF;
  record P1GET
  end P1GET;
  record P1NULL
  end P1NULL;
  record P1HD
  end P1HD;
  record P1TL
  end P1TL;
  record P1CONS
  end P1CONS;
  record P1PRINT
  end P1PRINT;
end P1;

uniontype P2
  record P2SET
  end P2SET;
  record P2FST
  end P2FST;
  record P2SND
  end P2SND;
  record P2EQ
  end P2EQ;
  record P2LT
  end P2LT;
  record P2LE
  end P2LE;
  record P2ADD
  end P2ADD;
  record P2SUB
  end P2SUB;
  record P2MUL
  end P2MUL;
  record P2IDIV
  end P2IDIV;
  record P2IMOD
  end P2IMOD;
  record P2RDIV
  end P2RDIV;
end P2;

uniontype Prim
  record P1
    P1 x1;
  end P1;
  record P2
    P2 x1;
  end P2;
end Prim;

type Location = Integer;

uniontype Val
  record INT
    Location x1;
  end INT;
  record REAL
    Real x1;
  end REAL;
  record STRING
    String x1;
  end STRING;
  record BOOL
    Boolean x1;
  end BOOL;
  record REF
    Location x1;
  end REF;
  record UNIT
  end UNIT;
  record PAIR
    Val x1;
    Val x2;
  end PAIR;
  record CLO
    Closure x1;
  end CLO;
  record PRIM
    Prim x1;
  end PRIM;
end Val;

type StringOption = Option<String>;

uniontype Closure
  record CLOSURE
    Absyn.Lambda x1;
    Env x2;
    StringOption x3;
  end CLOSURE;
end Closure;

type TupleStringVal = tuple<String,Val>;

type Env = list<TupleStringVal>;

type TupleLocationVal = tuple<Location,Val>;

type Store = list<TupleLocationVal>;
import util;

protected function bool_string
  input Boolean in_boolean;
  output String out_string;
algorithm 
  out_string:=
  matchcontinue (in_boolean)
    case true then "true"; 
    case false then "false"; 
  end matchcontinue;
end bool_string;

protected function app_p1
  input TupleIntegerValList in_tupleintegervallist;
  input P1 in_p1;
  input Val in_val;
  output TupleIntegerValList out_tupleintegervallist;
  output Val out_val;
protected 
  type TupleIntegerVal = tuple<Integer,Val>;
  type TupleIntegerValList = list<TupleIntegerVal>;
algorithm 
  (out_tupleintegervallist,out_val):=
  matchcontinue (in_tupleintegervallist,in_p1,in_val)
    local
      replaceable type Type_a;
      type TupleLocationType_a = tuple<Location,Type_a>;
      type TupleLocationType_aList = list<TupleLocationType_a>;
      Location loc;
      TupleLocationType_aList s;
      Type_a x;
      Val y,xy;
      String str;
    case (s,P1REF(),x) " s,p1,v |- s',v' "
      equation 
        loc = tick(); then ((loc,x) :: s,REF(loc));
    case (s,P1GET(),REF(loc))
      local
        Val x;
        Store s;
      equation 
        x = Util.lookup(s, loc); then (s,x);
    case (s,P1NULL(),UNIT())
      local Store s; then (s,BOOL(true));
    case (s,P1NULL(),PAIR(_,_))
      local Store s; then (s,BOOL(false));
    case (s,P1HD(),PAIR(x,_))
      local
        Store s;
        Val x; then (s,x);
    case (s,P1TL(),PAIR(_,y))
      local Store s; then (s,y);
    case (s,P1CONS(),xy)
      local Store s; then (s,xy);
    case (s,P1PRINT(),INT(x))
      local
        Store s;
        Location x;
      equation 
        str = int_string(x);
        print(str);
        print("\n"); then (s,UNIT());
    case (s,P1PRINT(),REAL(x))
      local
        Store s;
        Real x;
      equation 
        str = real_string(x);
        print(str);
        print("\n"); then (s,UNIT());
    case (s,P1PRINT(),STRING(x))
      local
        Store s;
        String x;
      equation 
        print(x);
        print("\n"); then (s,UNIT());
    case (s,P1PRINT(),BOOL(x))
      local
        Store s;
        Boolean x;
      equation 
        str = bool_string(x);
        print(str);
        print("\n"); then (s,UNIT());
  end matchcontinue;
end app_p1;

protected function app_p2
  input TupleIntegerValList in_tupleintegervallist1;
  input P2 in_p22;
  input Val in_val3;
  input Val in_val4;
  output TupleIntegerValList out_tupleintegervallist;
  output Val out_val;
protected 
  type TupleIntegerVal = tuple<Integer,Val>;
  type TupleIntegerValList = list<TupleIntegerVal>;
algorithm 
  (out_tupleintegervallist,out_val):=
  matchcontinue (in_tupleintegervallist1,in_p22,in_val3,in_val4)
    local
      replaceable type Type_a;
      type TupleLocationType_a = tuple<Location,Type_a>;
      type TupleLocationType_aList = list<TupleLocationType_a>;
      TupleLocationType_aList s;
      Location loc,z;
      Type_a y;
      Val x;
      Boolean flag;
    case (s,P2SET(),REF(loc),y) then ((loc,y) :: s,UNIT()); 
    case (s,P2FST(),x,_) then (s,x); 
    case (s,P2SND(),_,y)
      local
        Store s;
        Val y; then (s,y);
    case (s,P2EQ(),x,y)
      local
        Store s;
        Val y;
      equation 
        equality(x = y); then (s,BOOL(true));
    case (s,P2EQ(),x,y)
      local
        Store s;
        Val y;
      equation 
        failure(equality(x = y)); then (s,BOOL(false));
    case (s,P2LT(),INT(x),INT(y))
      local
        Store s;
        Location x,y;
      equation 
        flag = (x < y); then (s,BOOL(flag));
    case (s,P2LT(),REAL(x),REAL(y))
      local
        Store s;
        Real x,y;
      equation 
        flag = (x <. y); then (s,BOOL(flag));
    case (s,P2LE(),INT(x),INT(y))
      local
        Store s;
        Location x,y;
      equation 
        flag = (x <= y); then (s,BOOL(flag));
    case (s,P2LE(),REAL(x),REAL(y))
      local
        Store s;
        Real x,y;
      equation 
        flag = (x <=. y); then (s,BOOL(flag));
    case (s,P2ADD(),INT(x),INT(y))
      local
        Store s;
        Location x,y;
      equation 
        z = x + y; then (s,INT(z));
    case (s,P2ADD(),REAL(x),REAL(y))
      local
        Real z,x,y;
        Store s;
      equation 
        z = x +. y; then (s,REAL(z));
    case (s,P2SUB(),INT(x),INT(y))
      local
        Store s;
        Location x,y;
      equation 
        z = x - y; then (s,INT(z));
    case (s,P2SUB(),REAL(x),REAL(y))
      local
        Real z,x,y;
        Store s;
      equation 
        z = x -. y; then (s,REAL(z));
    case (s,P2MUL(),INT(x),INT(y))
      local
        Store s;
        Location x,y;
      equation 
        z = x*y; then (s,INT(z));
    case (s,P2MUL(),REAL(x),REAL(y))
      local
        Real z,x,y;
        Store s;
      equation 
        z = x*.y; then (s,REAL(z));
    case (s,P2IDIV(),INT(x),INT(y))
      local
        Store s;
        Location x,y;
      equation 
        z = x/y; then (s,INT(z));
    case (s,P2IMOD(),INT(x),INT(y))
      local
        Store s;
        Location x,y;
      equation 
        z = int_mod(x, y); then (s,INT(z));
    case (s,P2RDIV(),REAL(x),REAL(y))
      local
        Real z,x,y;
        Store s;
      equation 
        z = x/.y; then (s,REAL(z));
  end matchcontinue;
end app_p2;

protected function app_prim
  input TupleIntegerValList in_tupleintegervallist;
  input Prim in_prim;
  input Val in_val;
  output TupleIntegerValList out_tupleintegervallist;
  output Val out_val;
protected 
  type TupleIntegerVal = tuple<Integer,Val>;
  type TupleIntegerValList = list<TupleIntegerVal>;
algorithm 
  (out_tupleintegervallist,out_val):=
  matchcontinue (in_tupleintegervallist,in_prim,in_val)
    local
      Store s_1,s;
      Val z,x,y;
      P1 p1;
      P2 p2;
    case (s,P1(p1),x) " s,p,v |- s',v' "
      equation 
        (s_1,z) = app_p1(s, p1, x); then (s_1,z);
    case (s,P2(p2),PAIR(x,y))
      equation 
        (s_1,z) = app_p2(s, p2, x, y); then (s_1,z);
  end matchcontinue;
end app_prim;

protected function unfold_clo
  input Closure in_closure;
  output Closure out_closure;
algorithm 
  out_closure:=
  matchcontinue (in_closure)
    local
      Closure clo;
      Absyn.Lambda lam;
      Env env;
      String id;
    case ((clo = CLOSURE(_,_,NONE))) then clo; 
    case ((clo = CLOSURE(lam,env,SOME(id)))) then CLOSURE(lam,(id,CLO(clo)) :: env,SOME(id)); 
  end matchcontinue;
end unfold_clo;

protected function apply
  input TupleIntegerValList in_tupleintegervallist1;
  input Val in_val2;
  input Val in_val3;
  output TupleIntegerValList out_tupleintegervallist;
  output Val out_val;
protected 
  type TupleIntegerVal = tuple<Integer,Val>;
  type TupleIntegerValList = list<TupleIntegerVal>;
algorithm 
  (out_tupleintegervallist,out_val):=
  matchcontinue (in_tupleintegervallist1,in_val2,in_val3)
    local
      replaceable type Type_a;
      String id;
      Absyn.Exp exp;
      Env env;
      Type_a s_1,s;
      Val v,x,y;
      Closure clo;
      Prim p;
    case (s,CLO(clo),x) " s,v |- s',v' "
      equation 
        CLOSURE(Absyn.LAMBDA(id,exp),env,_) = unfold_clo(clo);
        (s_1,v) = eval(s, (id,x) :: env, exp); then (s_1,v);
    case (s,PRIM(p),x)
      local Store s_1,s;
      equation 
        (s_1,y) = app_prim(s, p, x); then (s_1,y);
  end matchcontinue;
end apply;

protected function eval
  input TupleIntegerValList in_tupleintegervallist;
  input TupleStringValList in_tuplestringvallist;
  input Absyn.Exp in_exp;
  output TupleIntegerValList out_tupleintegervallist;
  output Val out_val;
protected 
  type TupleIntegerVal = tuple<Integer,Val>;
  type TupleIntegerValList = list<TupleIntegerVal>;
algorithm 
  (out_tupleintegervallist,out_val):=
  matchcontinue (in_tupleintegervallist,in_tuplestringvallist,in_exp)
    local
      replaceable type Type_a;
      Type_a s,s1,s2,s3,s0,s_1;
      Location x;
      String id;
      Val v,f_1,x_1,v1,v2;
      Env env;
      Absyn.Lambda lam;
      Absyn.Exp f,e1,e2,e3,exp;
    case (s,_,Absyn.INT(x)) then (s,INT(x)); 
    case (s,_,Absyn.REAL(x))
      local Real x; then (s,REAL(x));
    case (s,_,Absyn.STRING(x))
      local String x; then (s,STRING(x));
    case (s,_,Absyn.UNIT()) then (s,UNIT()); 
    case (s,env,Absyn.VAR(id))
      equation 
        v = Util.lookup(env, id); then (s,v);
    case (s,env,Absyn.LAM(lam)) then (s,CLO(CLOSURE(lam,env,NONE))); 
    case (s0,env,Absyn.APP(f,x))
      local Absyn.Exp x;
      equation 
        (s1,f_1) = eval(s0, env, f);
        (s2,x_1) = eval(s1, env, x);
        (s3,v) = apply(s2, f_1, x_1); then (s3,v);
    case (s0,env,Absyn.PAIR(e1,e2))
      equation 
        (s1,v1) = eval(s0, env, e1);
        (s2,v2) = eval(s1, env, e2); then (s2,PAIR(v1,v2));
    case (s0,env,Absyn.IF(e1,e2,_))
      equation 
        (s1,BOOL(true)) = eval(s0, env, e1);
        (s2,v2) = eval(s1, env, e2); then (s2,v2);
    case (s0,env,Absyn.IF(e1,_,e3))
      equation 
        (s1,BOOL(false)) = eval(s0, env, e1);
        (s2,v2) = eval(s1, env, e3); then (s2,v2);
    case (s0,env,Absyn.LET(x,e1,e2))
      local String x;
      equation 
        (s1,v1) = eval(s0, env, e1);
        (s2,v2) = eval(s1, (x,v1) :: env, e2); then (s2,v2);
    case (s,env,Absyn.LETREC(id,lam,exp))
      equation 
        (s_1,v) = eval(s, (id,CLO(CLOSURE(lam,env,SOME(id)))) :: env, exp); then (s_1,v);
  end matchcontinue;
end eval;
constant Store state0={};
constant Env env0=list(("=",PRIM(P2(P2EQ()))),("ref",PRIM(P1(P1REF()))),
          ("!",PRIM(P1(P1GET()))),(":=",PRIM(P2(P2SET()))),("fst",PRIM(P2(P2FST()))),
          ("snd",PRIM(P2(P2SND()))),("true",BOOL(true)),("false",BOOL(false)),
          ("null",PRIM(P1(P1NULL()))),("hd",PRIM(P1(P1HD()))),("tl",PRIM(P1(P1TL()))),("nil",UNIT()),
          ("::",PRIM(P1(P1CONS()))),("+",PRIM(P2(P2ADD()))),("-",PRIM(P2(P2SUB()))),
          ("*",PRIM(P2(P2MUL()))),("idiv",PRIM(P2(P2IDIV()))),("imod",PRIM(P2(P2IMOD()))),
          ("/",PRIM(P2(P2RDIV()))),("<",PRIM(P2(P2LT()))),("<=",PRIM(P2(P2LE()))),
          ("print",PRIM(P1(P1PRINT()))));

public function evaluate
  input TupleIntegerValList in_tupleintegervallist;
  input TupleStringValList in_tuplestringvallist;
  input Absyn.Dec in_dec;
  output TupleIntegerValList out_tupleintegervallist;
  output TupleStringValList out_tuplestringvallist;
protected 
  type TupleIntegerVal = tuple<Integer,Val>;
  type TupleIntegerValList = list<TupleIntegerVal>;
algorithm 
  (out_tupleintegervallist,out_tuplestringvallist):=
  matchcontinue (in_tupleintegervallist,in_tuplestringvallist,in_dec)
    local
      Store s_1,s;
      Val v;
      Env env;
      String id;
      Absyn.Exp exp;
    case (s,env,Absyn.VAL(id,exp))
      equation 
        (s_1,v) = eval(s, env, exp); then (s_1,(id,v) :: env);
  end matchcontinue;
end evaluate;
end Dynamic;

