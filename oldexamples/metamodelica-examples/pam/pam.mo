package Pam " This version differs from the one in the book. The State is just the
 current environment, the input and output streams do not exist.
 Input is done through the function read which just calls a c function doing
 a call to scanf. Works if no backtracking occurs, as when print is used. "

type Ident = String " Semantics oriented abstract syntax for the PAM language ";

uniontype BinOp
  record ADD
  end ADD;
  record SUB
  end SUB;
  record MUL
  end MUL;
  record DIV
  end DIV;
end BinOp;

uniontype RelOp
  record EQ
  end EQ;
  record GT
  end GT;
  record LT
  end LT;
  record LE
  end LE;
  record GE
  end GE;
  record NE
  end NE;
end RelOp;

uniontype Exp
  record INT
    Integer x1;
  end INT;
  record IDENT
    Ident x1;
  end IDENT;
  record BINARY
    Exp x1;
    BinOp x2;
    Exp x3;
  end BINARY;
  record RELATION
    Exp x1;
    RelOp x2;
    Exp x3;
  end RELATION;
end Exp;

type IdentList = list<Ident>;

uniontype Stmt
  record ASSIGN
    Ident x1;
    Exp x2 " Id := Exp ";
  end ASSIGN;
  record IF
    Exp x1;
    Stmt x2;
    Stmt x3 " if Exp then Stmt..";
  end IF;
  record WHILE
    Exp x1;
    Stmt x2 " while Exp do Stmt";
  end WHILE;
  record TODO
    Exp x1;
    Stmt x2 " to Exp do Stmt...";
  end TODO;
  record READ
    IdentList x1 " read id1,id2,...";
  end READ;
  record WRITE
    IdentList x1 " write id1,id2,..";
  end WRITE;
  record SEQ
    Stmt x1;
    Stmt x2 " Stmt1; Stmt2 ";
  end SEQ;
  record SKIP " ; empty stmt "
  end SKIP;
end Stmt;

type VarBnd = tuple<Ident,Value> " Types needed for modeling static and dynamic semantics 
 Variable binding and environment type ";

type Env = list<VarBnd>;

uniontype Value " Value type needed for evaluation "
  record INTval
    Integer x1;
  end INTval;
  record BOOLval
    Boolean x1;
  end BOOLval;
end Value;

type State = Env;
import input;

protected function repeat_eval "**************** Auxiliary utility functions *****************"
  input State in_state;
  input Integer in_integer;
  input Stmt in_stmt;
  output State out_state;
algorithm 
  out_state:=
  matchcontinue (in_state,in_integer,in_stmt)
    local
      State state,state2,state3;
      Integer n,n2;
      Stmt stmt;
    case (state,n,stmt) " repeatedly evaluate stmt n times   n <= 0 "
      equation 
        (n <= 0) = true; then state;
    case (state,n,stmt) " eval n times "
      equation 
        (n > 0) = true;
        n2 = n - 1 " n > 0  ";
        state2 = eval_stmt(state, stmt);
        state3 = repeat_eval(state2, n2, stmt); then state3;
  end matchcontinue;
end repeat_eval;

protected function error
  input String in_string1;
  input String in_string2;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_string1,in_string2)
    local Ident str1,str2;
    case (str1,str2) " Print error messages str1 and str2, and fail "
      equation 
        print("Error - ");
        print(str1);
        print(" ");
        print(str2);
        print("\n"); then fail();
  end matchcontinue;
end error;

protected function input_item
  output Integer i;
algorithm 
  print("input: ");
  i := Input.read();
  print("\n");
end input_item;

protected function output_item
  input Integer i;
protected 
  Ident s;
algorithm 
  s := int_string(i);
  print(s);
end output_item;

protected function lookup
  input Env in_env;
  input Ident in_ident;
  output Value out_value;
algorithm 
  out_value:=
  matchcontinue (in_env,in_ident)
    local
      Ident id2,id;
      Value value;
      State rest;
    case ((id2,value) :: _,id) " lookup returns the value associated with an identifier.
 * If no association is present, lookup will fail.   id first in list "
      equation 
        equality(id = id2); then value;
    case ((id2,_) :: rest,id) " id in rest of list "
      equation 
        failure(equality(id = id2));
        value = lookup(rest, id); then value;
  end matchcontinue;
end lookup;

protected function update
  input Env in_env;
  input Ident in_ident;
  input Value in_value;
  output Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_ident,in_value)
    local
      State env;
      Ident id;
      Value value;
    case (env,id,value) then (id,value) :: env; 
  end matchcontinue;
end update;

protected function apply_binop "************** Arithmetic and functional operators *************"
  input BinOp in_binop1;
  input Integer in_integer2;
  input Integer in_integer3;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_binop1,in_integer2,in_integer3)
    local Integer x,y;
    case (ADD(),x,y) then x + y;  " Apply a binary arithmetic operator to constant integer arguments   x+y "
    case (SUB(),x,y) then x - y;  " x-y "
    case (MUL(),x,y) then x*y;  " x*y "
    case (DIV(),x,y) then x/y;  " x/y "
  end matchcontinue;
end apply_binop;

protected function apply_relop
  input RelOp in_relop1;
  input Integer in_integer2;
  input Integer in_integer3;
  output Boolean out_boolean;
algorithm 
  out_boolean:=
  matchcontinue (in_relop1,in_integer2,in_integer3)
    local Integer x,y;
    case (LT(),x,y) then (x < y);  " Apply a function operator, returning a boolean value   x<y "
    case (LE(),x,y) then (x <= y);  " x<=y "
    case (EQ(),x,y) then (x == y);  " x=y "
    case (NE(),x,y) then (x <> y);  " x<>y "
    case (GE(),x,y) then (x >= y);  " x>=y "
    case (GT(),x,y) then (x > y);  " x>y "
  end matchcontinue;
end apply_relop;

protected function eval "************** Expression evaluation *************"
  input Env in_env;
  input Exp in_exp;
  output Value out_value;
algorithm 
  out_value:=
  matchcontinue (in_env,in_exp)
    local
      Integer v,v1,v2,v3;
      State env;
      Ident id;
      Exp e1,e2;
      BinOp binop;
      RelOp relop;
    case (_,INT(v)) then INTval(v);  " integer constant "
    case (env,IDENT(id)) " identifier id "
      local Value v;
      equation 
        v = lookup(env, id); then v;
    case (env,IDENT(id)) " If id not declared, give an error message and fail through error   undefined variable id "
      equation 
        failure(v = lookup(env, id));
        error("Undefined identifier", id); then INTval(0);
    case (env,BINARY(e1,binop,e2)) " expr1 binop expr2 "
      equation 
        INTval(v1) = eval(env, e1);
        INTval(v2) = eval(env, e2);
        v3 = apply_binop(binop, v1, v2); then INTval(v3);
    case (env,RELATION(e1,relop,e2)) " expr1 relop expr2 "
      local Boolean v3;
      equation 
        INTval(v1) = eval(env, e1);
        INTval(v2) = eval(env, e2);
        v3 = apply_relop(relop, v1, v2); then BOOLval(v3);
  end matchcontinue;
end eval;

public function eval_stmt "************** Statement evaluation *************"
  input State in_state;
  input Stmt in_stmt;
  output State out_state;
algorithm 
  out_state:=
  matchcontinue (in_state,in_stmt)
    local
      Value v1;
      State env2,env,state2,state1,state,state3;
      Ident id;
      Exp e1,comp;
      Stmt s1,s2,stmt1,stmt2;
      Integer n1,v2;
      IdentList rest;
    case (env,ASSIGN(id,e1)) " Statement evaluation: map the current state into a new state   Assignment "
      equation 
        v1 = eval(env, e1);
        env2 = update(env, id, v1); then env2;
    case ((state1 = env),IF(comp,s1,s2)) " IF true ... "
      equation 
        BOOLval(true) = eval(env, comp);
        state2 = eval_stmt(state1, s1); then state2;
    case ((state1 = env),IF(comp,s1,s2)) " IF false ... "
      equation 
        BOOLval(false) = eval(env, comp);
        state2 = eval_stmt(state1, s2); then state2;
    case (state,WHILE(comp,s1)) " WHILE ... "
      equation 
        state2 = eval_stmt(state, IF(comp,SEQ(s1,WHILE(comp,s1)),SKIP())); then state2;
    case ((state = env),TODO(e1,s1)) " TO e1 DO s1 .. "
      equation 
        INTval(n1) = eval(env, e1);
        state2 = repeat_eval(state, n1, s1); then state2;
    case (state,READ({})) then state;  " READ {} "
    case (env,READ(id :: rest)) " READ id1,..  "
      equation 
        v2 = input_item();
        env2 = update(env, id, INTval(v2));
        state2 = eval_stmt(env2, READ(rest)); then state2;
    case (state,WRITE({})) then state;  " WRITE {} "
    case (env,WRITE(id :: rest)) "WRITE id1,. "
      equation 
        INTval(v2) = lookup(env, id);
        output_item(v2);
        state2 = eval_stmt(env, WRITE(rest)); then state2;
    case (state,SEQ(stmt1,stmt2)) " stmt1 ; stmt2 "
      equation 
        state2 = eval_stmt(state, stmt1);
        state3 = eval_stmt(state2, stmt2); then state3;
    case (state,SKIP()) then state;  " ; empty statement "
  end matchcontinue;
end eval_stmt;
end Pam;

