package Pam "This version differs from the one in the book. The State is just the
 current environment, the input and output streams do not exist.
 Input is done through the function read which just calls a c function doing
 a call to scanf. Works if no backtracking occurs, as when print is used."

public 
type Ident = String "Semantics oriented abstract syntax for the PAM language";

public 
uniontype BinOp
  record ADD end ADD;

  record SUB end SUB;

  record MUL end MUL;

  record DIV end DIV;

end BinOp;

public 
uniontype RelOp
  record EQ end EQ;

  record GT end GT;

  record LT end LT;

  record LE end LE;

  record GE end GE;

  record NE end NE;

end RelOp;

public 
uniontype Exp
  record INT
    Integer integer;
  end INT;

  record IDENT
    Ident ident;
  end IDENT;

  record BINARY
    Exp exp1;
    BinOp binOp2;
    Exp exp3;
  end BINARY;

  record RELATION
    Exp exp1;
    RelOp relOp2;
    Exp exp3;
  end RELATION;

end Exp;

public 
type IdentLst = list<Ident>;

uniontype Stmt
  record ASSIGN
    Ident ident;
    Exp id "Id := Exp";
  end ASSIGN;

  record IF
    Exp exp;
    Stmt stmt;
    Stmt if_ "if Exp then Stmt..";
  end IF;

  record WHILE
    Exp exp;
    Stmt while_ "while Exp do Stmt";
  end WHILE;

  record TODO
    Exp exp;
    Stmt to "to Exp do Stmt...";
  end TODO;

  record READ
    IdentLst read "read id1,id2,...";
  end READ;

  record WRITE
    IdentLst write "write id1,id2,..";
  end WRITE;

  record SEQ
    Stmt stmt;
    Stmt stmt1 "Stmt1; Stmt2";
  end SEQ;

  record SKIP "; empty stmt" end SKIP;

end Stmt;

public 
type VarBnd = tuple<Ident,Value> "Types needed for modeling static and dynamic semantics
Variable binding and environment type";

public 
type Env = list<VarBnd>;

public 
uniontype Value "Value type needed for evaluation"
  record INTval
    Integer integer;
  end INTval;

  record BOOLval
    Boolean boolean;
  end BOOLval;

end Value;

public 
type State = Env;

protected import Input.*;

protected function repeatEval "Auxiliary utility functions"
  input State inState;
  input Integer inInteger;
  input Stmt inStmt;
  output State outState;
algorithm 
  outState:=
  matchcontinue (inState,inInteger,inStmt)
    local
      State state,state2,state3;
      Integer n,n2;
      Stmt stmt;
    case (state,n,stmt) "repeatedly evaluate stmt n times n <= 0"
      equation 
        (n <= 0) = true; then state;
    case (state,n,stmt) "eval n times"
      equation 
        (n > 0) = true;
        n2 = n - 1 "n > 0";
        state2 = evalStmt(state, stmt);
        state3 = repeatEval(state2, n2, stmt); then state3;
  end matchcontinue;
end repeatEval;

protected function error
  input String inString1;
  input String inString2;
algorithm 
  _:=
  matchcontinue (inString1,inString2)
    local Ident str1,str2;
    case (str1,str2) "Print error messages str1 and str2, and fail"
      equation 
        print("Error - ");
        print(str1);
        print(" ");
        print(str2);
        print("\n"); then fail();
  end matchcontinue;
end error;

protected function inputItem
  output Integer i;
algorithm 
  print("input: ");
  i := Input.read();
  print("\n");
end inputItem;

protected function outputItem
  input Integer i;
  Ident s;
algorithm 
  s := intString(i);
  print(s);
end outputItem;

protected function lookup
  input Env inEnv;
  input Ident inIdent;
  output Value outValue;
algorithm 
  outValue:=
  matchcontinue (inEnv,inIdent)
    local
      Ident id2,id;
      Value value;
      State rest;
    case ((id2,value) :: _,id) "lookup returns the value associated with an identifier.
  If no association is present, lookup will fail. id first in list"
      equation 
        equality(id = id2); then value;
    case ((id2,_) :: rest,id) "id in rest of list"
      equation 
        failure(equality(id = id2));
        value = lookup(rest, id); then value;
  end matchcontinue;
end lookup;

protected function update
  input Env inEnv;
  input Ident inIdent;
  input Value inValue;
  output Env outEnv;
algorithm 
  outEnv:=
  matchcontinue (inEnv,inIdent,inValue)
    local
      State env;
      Ident id;
      Value value;
    case (env,id,value) then (id,value) :: env; 
  end matchcontinue;
end update;

protected function applyBinop "Arithmetic and functional operators"
  input BinOp inBinOp1;
  input Integer inInteger2;
  input Integer inInteger3;
  output Integer outInteger;
algorithm 
  outInteger:=
  matchcontinue (inBinOp1,inInteger2,inInteger3)
    local Integer x,y;
    case (ADD(),x,y) then x + y;  "Apply a binary arithmetic operator to constant integer arguments x+y"
    case (SUB(),x,y) then x - y;  "x-y"
    case (MUL(),x,y) then x*y;  "xy"
    case (DIV(),x,y) then x/y;  "x/y"
  end matchcontinue;
end applyBinop;

protected function applyRelop
  input RelOp inRelOp1;
  input Integer inInteger2;
  input Integer inInteger3;
  output Boolean outBoolean;
algorithm 
  outBoolean:=
  matchcontinue (inRelOp1,inInteger2,inInteger3)
    local Integer x,y;
    case (LT(),x,y) then (x < y);  "Apply a function operator, returning a boolean value x<y"
    case (LE(),x,y) then (x <= y);  "x<=y"
    case (EQ(),x,y) then (x == y);  "x=y"
    case (NE(),x,y) then (x <> y);  "x<>y"
    case (GE(),x,y) then (x >= y);  "x>=y"
    case (GT(),x,y) then (x > y);  "x>y"
  end matchcontinue;
end applyRelop;

protected function eval "Expression evaluation"
  input Env inEnv;
  input Exp inExp;
  output Value outValue;
algorithm 
  outValue:=
  matchcontinue (inEnv,inExp)
    local
      Integer v,v1,v2,v3;
      State env;
      Ident id;
      Exp e1,e2;
      BinOp binop;
      RelOp relop;
    case (_,INT(v)) then INTval(v);  "integer constant"
    case (env,IDENT(id)) "identifier id"
      local Value v;
      equation 
        v = lookup(env, id); then v;
    case (env,IDENT(id)) "If id not declared, give an error message and fail through error undefined variable id"
      equation 
        failure(v = lookup(env, id));
        error("Undefined identifier", id); then INTval(0);
    case (env,BINARY(e1,binop,e2)) "expr1 binop expr2"
      equation 
        INTval(v1) = eval(env, e1);
        INTval(v2) = eval(env, e2);
        v3 = applyBinop(binop, v1, v2); then INTval(v3);
    case (env,RELATION(e1,relop,e2)) "expr1 relop expr2"
      local Boolean v3;
      equation 
        INTval(v1) = eval(env, e1);
        INTval(v2) = eval(env, e2);
        v3 = applyRelop(relop, v1, v2); then BOOLval(v3);
  end matchcontinue;
end eval;

public function evalStmt "Statement evaluation"
  input State inState;
  input Stmt inStmt;
  output State outState;
algorithm 
  outState:=
  matchcontinue (inState,inStmt)
    local
      Value v1;
      State env2,env,state2,state1,state,state3;
      Ident id;
      Exp e1,comp;
      Stmt s1,s2,stmt1,stmt2;
      Integer n1,v2;
      IdentLst rest;
    case (env,ASSIGN(id,e1)) "Statement evaluation: map the current state into a new state Assignment"
      equation 
        v1 = eval(env, e1);
        env2 = update(env, id, v1); then env2;
    case ((state1 as env),IF(comp,s1,s2)) "IF true ..."
      equation 
        BOOLval(true) = eval(env, comp);
        state2 = evalStmt(state1, s1); then state2;
    case ((state1 as env),IF(comp,s1,s2)) "IF false ..."
      equation 
        BOOLval(false) = eval(env, comp);
        state2 = evalStmt(state1, s2); then state2;
    case (state,WHILE(comp,s1)) "WHILE ..."
      equation 
        state2 = evalStmt(state, IF(comp,SEQ(s1,WHILE(comp,s1)),SKIP())); then state2;
    case ((state as env),TODO(e1,s1)) "TO e1 DO s1 .."
      equation 
        INTval(n1) = eval(env, e1);
        state2 = repeatEval(state, n1, s1); then state2;
    case (state,READ({})) then state;  "READ {}"
    case (env,READ(id :: rest)) "READ id1,.."
      equation 
        v2 = inputItem();
        env2 = update(env, id, INTval(v2));
        state2 = evalStmt(env2, READ(rest)); then state2;
    case (state,WRITE({})) then state;  "WRITE {}"
    case (env,WRITE(id :: rest)) "WRITE id1,."
      equation 
        INTval(v2) = lookup(env, id);
        outputItem(v2);
        state2 = evalStmt(env, WRITE(rest)); then state2;
    case (state,SEQ(stmt1,stmt2)) "stmt1 ; stmt2"
      equation 
        state2 = evalStmt(state, stmt1);
        state3 = evalStmt(state2, stmt2); then state3;
    case (state,SKIP()) then state;  "; empty statement"
  end matchcontinue;
end evalStmt;
end Pam;
