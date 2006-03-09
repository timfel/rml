package Eval

public import OpenModelica.Compiler.Absyn.*;

public import OpenModelica.Compiler.Env.*;

protected function binaryLub "Type lattice;  int --> real"
  input Env.Value inValue1;
  input Env.Value inValue2;
  output Env.Value2 outValue2;
algorithm 
  outValue2:=
  matchcontinue (inValue1,inValue2)
    local
      Integer v1,v2;
      Real c1,c2;
    case (Env.INTVAL(v1),Env.INTVAL(v2)) then Env.INTVAL2(v1,v2); 
    case (Env.REALVAL(v1),Env.REALVAL(v2))
      local Real v1,v2; then Env.REALVAL2(v1,v2);
    case (Env.INTVAL(v1),Env.REALVAL(v2))
      local Real v2;
      equation 
        c1 = intReal(v1); then Env.REALVAL2(c1,v2);
    case (Env.REALVAL(v1),Env.INTVAL(v2))
      local Real v1;
      equation 
        c2 = intReal(v2); then Env.REALVAL2(v1,c2);
  end matchcontinue;
end binaryLub;

protected function promote "Promotion and type check"
  input Env.Value inValue;
  input Env.Type inType;
  output Env.Value outValue;
algorithm 
  outValue:=
  matchcontinue (inValue,inType)
    local
      Integer v;
      Real v2;
    case (Env.INTVAL(v),Env.INTTYPE()) then Env.INTVAL(v); 
    case (Env.REALVAL(v),Env.REALTYPE())
      local Real v; then Env.REALVAL(v);
    case (Env.BOOLVAL(v),Env.BOOLTYPE())
      local Boolean v; then Env.BOOLVAL(v);
    case (Env.INTVAL(v),Env.REALTYPE())
      equation 
        v2 = intReal(v); then Env.REALVAL(v2);
  end matchcontinue;
end promote;

protected function applyIntBinary "Auxiliary functions for applying the binary operators"
  input Absyn.BinOp inBinOp1;
  input Integer inInteger2;
  input Integer inInteger3;
  output Integer outInteger;
algorithm 
  outInteger:=
  matchcontinue (inBinOp1,inInteger2,inInteger3)
    local Integer v1,v2;
    case (Absyn.ADD(),v1,v2) then v1 + v2; 
    case (Absyn.SUB(),v1,v2) then v1 - v2; 
    case (Absyn.MUL(),v1,v2) then v1*v2; 
    case (Absyn.DIV(),v1,v2) then v1/v2; 
  end matchcontinue;
end applyIntBinary;

protected function applyRealBinary
  input Absyn.BinOp inBinOp1;
  input Real inReal2;
  input Real inReal3;
  output Real outReal;
algorithm 
  outReal:=
  matchcontinue (inBinOp1,inReal2,inReal3)
    local Real v1,v2;
    case (Absyn.ADD(),v1,v2) then v1 +. v2; 
    case (Absyn.SUB(),v1,v2) then v1 -. v2; 
    case (Absyn.MUL(),v1,v2) then v1*.v2; 
    case (Absyn.DIV(),v1,v2) then v1/.v2; 
  end matchcontinue;
end applyRealBinary;

protected function applyIntUnary "Auxiliary functions for applying the unary operators"
  input Absyn.UnOp inUnOp;
  input Integer inInteger;
  output Integer outInteger;
algorithm 
  outInteger:=
  matchcontinue (inUnOp,inInteger)
    local Integer v1;
    case (Absyn.NEG(),v1) then -v1; 
  end matchcontinue;
end applyIntUnary;

protected function applyRealUnary
  input Absyn.UnOp inUnOp;
  input Real inReal;
  output Real outReal;
algorithm 
  outReal:=
  matchcontinue (inUnOp,inReal)
    local Real v1;
    case (Absyn.NEG(),v1) then -.v1; 
  end matchcontinue;
end applyRealUnary;

protected function applyIntRelation "Auxiliary functions for applying the function operators"
  input Absyn.RelOp inRelOp1;
  input Integer inInteger2;
  input Integer inInteger3;
  output Boolean outBoolean;
algorithm 
  outBoolean:=
  matchcontinue (inRelOp1,inInteger2,inInteger3)
    local Integer v1,v2;
    case (Absyn.LT(),v1,v2) then (v1 < v2); 
    case (Absyn.LE(),v1,v2) then (v1 <= v2); 
    case (Absyn.GT(),v1,v2) then (v1 > v2); 
    case (Absyn.GE(),v1,v2) then (v1 >= v2); 
    case (Absyn.NE(),v1,v2) then (v1 <> v2); 
    case (Absyn.EQ(),v1,v2) then (v1 == v2); 
  end matchcontinue;
end applyIntRelation;

protected function applyRealRelation
  input Absyn.RelOp inRelOp1;
  input Real inReal2;
  input Real inReal3;
  output Boolean outBoolean;
algorithm 
  outBoolean:=
  matchcontinue (inRelOp1,inReal2,inReal3)
    local Real v1,v2;
    case (Absyn.LT(),v1,v2) then (v1 <. v2); 
    case (Absyn.LE(),v1,v2) then (v1 <=. v2); 
    case (Absyn.GT(),v1,v2) then (v1 >. v2); 
    case (Absyn.GE(),v1,v2) then (v1 >=. v2); 
    case (Absyn.NE(),v1,v2) then (v1 <>. v2); 
    case (Absyn.EQ(),v1,v2) then (v1 ==. v2); 
  end matchcontinue;
end applyRealRelation;

protected function evalExpr "EVALUATE A SINGLE EXPRESSION in an environment. Return
   the new value. Expressions do not change environments."
  input Env.Env inEnv;
  input Absyn.Expr inExpr;
  output Env.Value outValue;
algorithm 
  outValue:=
  matchcontinue (inEnv,inExpr)
    local
      type Env_BindLst = list<Env.Bind>;
      Env_BindLst env;
      Integer v,c1,c2,v3;
      Env.Value v1,v2;
      Absyn.Expr e1,e2;
      Absyn.BinOp binop;
      Absyn.UnOp unop;
      Absyn.RelOp relop;
      String id;
    case (env,Absyn.INTCONST(v)) then Env.INTVAL(v); 
    case (env,Absyn.REALCONST(v))
      local Real v; then Env.REALVAL(v);
    case (env,Absyn.BINARY(e1,binop,e2)) "Binary operators"
      equation 
        v1 = evalExpr(env, e1);
        v2 = evalExpr(env, e2);
        Env.INTVAL2(c1,c2) = binaryLub(v1, v2);
        v3 = applyIntBinary(binop, c1, c2); then Env.INTVAL(v3);
    case (env,Absyn.BINARY(e1,binop,e2))
      local Real c1,c2,v3;
      equation 
        v1 = evalExpr(env, e1);
        v2 = evalExpr(env, e2);
        Env.REALVAL2(c1,c2) = binaryLub(v1, v2);
        v3 = applyRealBinary(binop, c1, c2); then Env.REALVAL(v3);
    case (_,Absyn.BINARY(_,_,_))
      equation 
        print("Error: binary operator applied to invalid type(s)\n"); then fail();
    case (env,Absyn.UNARY(unop,e1)) "Unary operators"
      local Integer v1,v2;
      equation 
        Env.INTVAL(v1) = evalExpr(env, e1);
        v2 = applyIntUnary(unop, v1); then Env.INTVAL(v2);
    case (env,Absyn.UNARY(unop,e1))
      local Real v1,v2;
      equation 
        Env.REALVAL(v1) = evalExpr(env, e1);
        v2 = applyRealUnary(unop, v1); then Env.REALVAL(v2);
    case (_,Absyn.UNARY(_,_))
      equation 
        print("Error: unary operator applied to invalid type\n"); then fail();
    case (env,Absyn.RELATION(e1,relop,e2)) "Relation operators"
      local Boolean v3;
      equation 
        v1 = evalExpr(env, e1);
        v2 = evalExpr(env, e2);
        Env.INTVAL2(c1,c2) = binaryLub(v1, v2);
        v3 = applyIntRelation(relop, c1, c2); then Env.BOOLVAL(v3);
    case (env,Absyn.RELATION(e1,relop,e2))
      local
        Real c1,c2;
        Boolean v3;
      equation 
        v1 = evalExpr(env, e1);
        v2 = evalExpr(env, e2);
        Env.REALVAL2(c1,c2) = binaryLub(v1, v2);
        v3 = applyRealRelation(relop, c1, c2); then Env.BOOLVAL(v3);
    case (_,Absyn.RELATION(_,_,_))
      equation 
        print("Error: relation operator applied to invalid type(s)\n"); then fail();
    case (env,Absyn.VARIABLE(id)) "Variable lookup"
      local Env.Value v;
      equation 
        v = Env.lookup(env, id); then v;
    case (env,Absyn.VARIABLE(id))
      equation 
        failure(v = Env.lookup(env, id));
        print("Error: undefined variable (");
        print(id);
        print(")\n"); then fail();
  end matchcontinue;
end evalExpr;

protected function printValue "EVALUATING STATEMENTS
  Print a value - the \"write\" statement"
  input Env.Value inValue;
algorithm 
  _:=
  matchcontinue (inValue)
    local
      String vstr;
      Integer v;
    case (Env.INTVAL(v))
      equation 
        vstr = intString(v);
        print(vstr);
        print("\n"); then ();
    case Env.REALVAL(v)
      local Real v;
      equation 
        vstr = realString(v);
        print(vstr);
        print("\n"); then ();
    case Env.BOOLVAL(true)
      equation 
        print("true\n"); then ();
    case Env.BOOLVAL(false)
      equation 
        print("false\n"); then ();
  end matchcontinue;
end printValue;

protected function evalStmt "Evaluate a single statement. Pass environment forward."
  input Env.Env inEnv;
  input Absyn.Stmt inStmt;
  output Env.Env outEnv;
algorithm 
  outEnv:=
  matchcontinue (inEnv,inStmt)
    local
      type Env_BindLst = list<Env.Bind>;
      type Absyn_StmtLst = list<Absyn.Stmt>;
      Env.Value v,v2;
      Env.Type ty;
      Env_BindLst env1,env,env2;
      String id;
      Absyn.Expr e;
      Absyn_StmtLst c,a,ss;
    case (env,Absyn.ASSIGN(id,e))
      equation 
        v = evalExpr(env, e);
        ty = Env.lookuptype(env, id);
        v2 = promote(v, ty);
        env1 = Env.update(env, id, ty, v2); then env1;
    case (env,Absyn.ASSIGN(id,e))
      equation 
        v = evalExpr(env, e);
        print("Error: assignment mismatch or variable missing\n"); then fail();
    case (env,Absyn.WRITE(e))
      equation 
        v = evalExpr(env, e);
        printValue(v); then env;
    case (env,Absyn.NOOP()) then env; 
    case (env,Absyn.IF(e,c,_))
      equation 
        Env.BOOLVAL(true) = evalExpr(env, e);
        env1 = evalStmtList(env, c); then env1;
    case (env,Absyn.IF(e,_,a))
      equation 
        Env.BOOLVAL(false) = evalExpr(env, e);
        env1 = evalStmtList(env, a); then env1;
    case (env,Absyn.WHILE(e,ss))
      equation 
        Env.BOOLVAL(true) = evalExpr(env, e);
        env1 = evalStmtList(env, ss);
        env2 = evalStmt(env1, Absyn.WHILE(e,ss)); then env2;
    case (env,Absyn.WHILE(e,ss))
      equation 
        Env.BOOLVAL(false) = evalExpr(env, e); then env;
    case (env,Absyn.IF(e,_,a))
      equation 
        Env.BOOLVAL(false) = evalExpr(env, e);
        env1 = evalStmtList(env, a); then env1;
    case (env,Absyn.WHILE(e,ss))
      equation 
        Env.BOOLVAL(true) = evalExpr(env, e);
        env1 = evalStmtList(env, ss);
        env2 = evalStmt(env1, Absyn.WHILE(e,ss)); then env2;
    case (env,Absyn.WHILE(e,ss))
      equation 
        Env.BOOLVAL(false) = evalExpr(env, e); then env;
  end matchcontinue;
end evalStmt;

protected function evalStmtList "Evaluate a list of statements in an environent.
   Pass environment forward"
  input Env.Env inEnv;
  input Absyn.StmtList inStmtList;
  output Env.Env outEnv;
algorithm 
  outEnv:=
  matchcontinue (inEnv,inStmtList)
    local
      type Env_BindLst = list<Env.Bind>;
      type Absyn_StmtLst = list<Absyn.Stmt>;
      Env_BindLst env,env1,env2;
      Absyn.Stmt s;
      Absyn_StmtLst ss;
    case (env,{}) then env; 
    case (env,(s :: ss))
      equation 
        env1 = evalStmt(env, s);
        env2 = evalStmtList(env1, ss); then env2;
  end matchcontinue;
end evalStmtList;

protected function evalDecl "EVALUATING DECLARATIONS
  Evaluate a single statement. Pass environment forward."
  input Env.Env inEnv;
  input Absyn.Decl inDecl;
  output Env.Env outEnv;
algorithm 
  outEnv:=
  matchcontinue (inEnv,inDecl)
    local
      type Env_BindLst = list<Env.Bind>;
      Env_BindLst env2,env;
      String var;
    case (env,Absyn.NAMEDECL(var,"integer"))
      equation 
        env2 = Env.update(env, var, Env.INTTYPE(), Env.INTVAL(0)); then env2;
    case (env,Absyn.NAMEDECL(var,"real"))
      equation 
        env2 = Env.update(env, var, Env.REALTYPE(), Env.REALVAL(0.0)); then env2;
    case (env,Absyn.NAMEDECL(var,"boolean"))
      equation 
        env2 = Env.update(env, var, Env.BOOLTYPE(), Env.BOOLVAL(false)); then env2;
  end matchcontinue;
end evalDecl;

protected function evalDeclList "Evaluate a list of declarations, extending the environent."
  input Env.Env inEnv;
  input Absyn.DeclList inDeclList;
  output Env.Env outEnv;
algorithm 
  outEnv:=
  matchcontinue (inEnv,inDeclList)
    local
      type Env_BindLst = list<Env.Bind>;
      type Absyn_DeclLst = list<Absyn.Decl>;
      Env_BindLst env,env1,env2;
      Absyn.Decl s;
      Absyn_DeclLst ss;
    case (env,{}) then env; 
    case (env,(s :: ss))
      equation 
        env1 = evalDecl(env, s);
        env2 = evalDeclList(env1, ss); then env2;
  end matchcontinue;
end evalDeclList;

public function evalprog "EVALUTATING A PROGRAM means to evaluate the list of statements,
   with an initial environment containing just standard defs."
  input Absyn.Prog inProg;
algorithm 
  _:=
  matchcontinue (inProg)
    local
      type Env_BindLst = list<Env.Bind>;
      type Absyn_DeclLst = list<Absyn.Decl>;
      type Absyn_StmtLst = list<Absyn.Stmt>;
      Env_BindLst env1,env2,env3;
      Absyn_DeclLst decls;
      Absyn_StmtLst stmts;
    case (Absyn.PROG(decls,stmts))
      equation 
        env1 = Env.initial_();
        env2 = evalDeclList(env1, decls);
        env3 = evalStmtList(env2, stmts); then ();
  end matchcontinue;
end evalprog;
end Eval;

