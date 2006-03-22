package Eval
import absyn;
import env;

protected function binary_lub " Type lattice;  int --> real "
  input Env.Value in_value1;
  input Env.Value in_value2;
  output Env.Value2 out_value2;
algorithm 
  out_value2:=
  matchcontinue (in_value1,in_value2)
    local
      Integer v1,v2;
      Real c1,c2;
    case (Env.INTVAL(v1),Env.INTVAL(v2)) then Env.INTVAL2(v1,v2); 
    case (Env.REALVAL(v1),Env.REALVAL(v2))
      local Real v1,v2; then Env.REALVAL2(v1,v2);
    case (Env.INTVAL(v1),Env.REALVAL(v2))
      local Real v2;
      equation 
        c1 = int_real(v1); then Env.REALVAL2(c1,v2);
    case (Env.REALVAL(v1),Env.INTVAL(v2))
      local Real v1;
      equation 
        c2 = int_real(v2); then Env.REALVAL2(v1,c2);
  end matchcontinue;
end binary_lub;

protected function promote " Promotion and type check "
  input Env.Value in_value;
  input Env.Type in_type;
  output Env.Value out_value;
algorithm 
  out_value:=
  matchcontinue (in_value,in_type)
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
        v2 = int_real(v); then Env.REALVAL(v2);
  end matchcontinue;
end promote;

protected function apply_int_binary " Auxiliary functions for applying the binary operators "
  input Absyn.BinOp in_binop1;
  input Integer in_integer2;
  input Integer in_integer3;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_binop1,in_integer2,in_integer3)
    local Integer v1,v2;
    case (Absyn.ADD(),v1,v2) then v1 + v2; 
    case (Absyn.SUB(),v1,v2) then v1 - v2; 
    case (Absyn.MUL(),v1,v2) then v1*v2; 
    case (Absyn.DIV(),v1,v2) then v1/v2; 
  end matchcontinue;
end apply_int_binary;

protected function apply_real_binary
  input Absyn.BinOp in_binop1;
  input Real in_real2;
  input Real in_real3;
  output Real out_real;
algorithm 
  out_real:=
  matchcontinue (in_binop1,in_real2,in_real3)
    local Real v1,v2;
    case (Absyn.ADD(),v1,v2) then v1 +. v2; 
    case (Absyn.SUB(),v1,v2) then v1 -. v2; 
    case (Absyn.MUL(),v1,v2) then v1*.v2; 
    case (Absyn.DIV(),v1,v2) then v1/.v2; 
  end matchcontinue;
end apply_real_binary;

protected function apply_int_unary " Auxiliary functions for applying the unary operators "
  input Absyn.UnOp AbsynNEG;
  input Integer v1;
  output Integer v2;
algorithm 
  v2 := -v1;
end apply_int_unary;

protected function apply_real_unary
  input Absyn.UnOp AbsynNEG;
  input Real v1;
  output Real v2;
algorithm 
  v2 := -.v1;
end apply_real_unary;

protected function apply_int_relation " Auxiliary functions for applying the function operators "
  input Absyn.RelOp in_relop1;
  input Integer in_integer2;
  input Integer in_integer3;
  output Boolean out_boolean;
algorithm 
  out_boolean:=
  matchcontinue (in_relop1,in_integer2,in_integer3)
    local Integer v1,v2;
    case (Absyn.LT(),v1,v2) then (v1 < v2); 
    case (Absyn.LE(),v1,v2) then (v1 <= v2); 
    case (Absyn.GT(),v1,v2) then (v1 > v2); 
    case (Absyn.GE(),v1,v2) then (v1 >= v2); 
    case (Absyn.NE(),v1,v2) then (v1 <> v2); 
    case (Absyn.EQ(),v1,v2) then (v1 == v2); 
  end matchcontinue;
end apply_int_relation;

protected function apply_real_relation
  input Absyn.RelOp in_relop1;
  input Real in_real2;
  input Real in_real3;
  output Boolean out_boolean;
algorithm 
  out_boolean:=
  matchcontinue (in_relop1,in_real2,in_real3)
    local Real v1,v2;
    case (Absyn.LT(),v1,v2) then (v1 <. v2); 
    case (Absyn.LE(),v1,v2) then (v1 <=. v2); 
    case (Absyn.GT(),v1,v2) then (v1 >. v2); 
    case (Absyn.GE(),v1,v2) then (v1 >=. v2); 
    case (Absyn.NE(),v1,v2) then (v1 <>. v2); 
    case (Absyn.EQ(),v1,v2) then (v1 ==. v2); 
  end matchcontinue;
end apply_real_relation;

protected function eval_expr " EVALUATE A SINGLE EXPRESSION in an environment. Return
   the new value. Expressions do not change environments. "
  input Env.Env in_env;
  input Absyn.Expr in_expr;
  output Env.Value out_value;
algorithm 
  out_value:=
  matchcontinue (in_env,in_expr)
    local
      type EnvBindList = list<Env.Bind>;
      EnvBindList env;
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
    case (env,Absyn.BINARY(e1,binop,e2)) " Binary operators "
      equation 
        v1 = eval_expr(env, e1);
        v2 = eval_expr(env, e2);
        Env.INTVAL2(c1,c2) = binary_lub(v1, v2);
        v3 = apply_int_binary(binop, c1, c2); then Env.INTVAL(v3);
    case (env,Absyn.BINARY(e1,binop,e2))
      local Real c1,c2,v3;
      equation 
        v1 = eval_expr(env, e1);
        v2 = eval_expr(env, e2);
        Env.REALVAL2(c1,c2) = binary_lub(v1, v2);
        v3 = apply_real_binary(binop, c1, c2); then Env.REALVAL(v3);
    case (_,Absyn.BINARY(_,_,_))
      equation 
        print("Error: binary operator applied to invalid type(s)\n"); then fail();
    case (env,Absyn.UNARY(unop,e1)) " Unary operators "
      local Integer v1,v2;
      equation 
        Env.INTVAL(v1) = eval_expr(env, e1);
        v2 = apply_int_unary(unop, v1); then Env.INTVAL(v2);
    case (env,Absyn.UNARY(unop,e1))
      local Real v1,v2;
      equation 
        Env.REALVAL(v1) = eval_expr(env, e1);
        v2 = apply_real_unary(unop, v1); then Env.REALVAL(v2);
    case (_,Absyn.UNARY(_,_))
      equation 
        print("Error: unary operator applied to invalid type\n"); then fail();
    case (env,Absyn.RELATION(e1,relop,e2)) " Relation operators "
      local Boolean v3;
      equation 
        v1 = eval_expr(env, e1);
        v2 = eval_expr(env, e2);
        Env.INTVAL2(c1,c2) = binary_lub(v1, v2);
        v3 = apply_int_relation(relop, c1, c2); then Env.BOOLVAL(v3);
    case (env,Absyn.RELATION(e1,relop,e2))
      local
        Real c1,c2;
        Boolean v3;
      equation 
        v1 = eval_expr(env, e1);
        v2 = eval_expr(env, e2);
        Env.REALVAL2(c1,c2) = binary_lub(v1, v2);
        v3 = apply_real_relation(relop, c1, c2); then Env.BOOLVAL(v3);
    case (_,Absyn.RELATION(_,_,_))
      equation 
        print("Error: relation operator applied to invalid type(s)\n"); then fail();
    case (env,Absyn.VARIABLE(id)) " Variable lookup "
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
end eval_expr;

protected function print_value " EVALUATING STATEMENTS 
   Print a value - the \"write\" statement "
  input Env.Value in_value;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_value)
    local
      String vstr;
      Integer v;
    case (Env.INTVAL(v))
      equation 
        vstr = int_string(v);
        print(vstr);
        print("\n"); then true;
    case Env.REALVAL(v)
      local Real v;
      equation 
        vstr = real_string(v);
        print(vstr);
        print("\n"); then true;
    case Env.BOOLVAL(true)
      equation 
        print("true\n"); then true;
    case Env.BOOLVAL(false)
      equation 
        print("false\n"); then true;
  end matchcontinue;
end print_value;

protected function eval_stmt " Evaluate a single statement. Pass environment forward."
  input Env.Env in_env;
  input Absyn.Stmt in_stmt;
  output Env.Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_stmt)
    local
      type EnvBindList = list<Env.Bind>;
      type AbsynStmtList = list<Absyn.Stmt>;
      Env.Value v,v2;
      Env.Type ty;
      EnvBindList env1,env,env2;
      String id;
      Absyn.Expr e;
      AbsynStmtList c,a,ss;
    case (env,Absyn.ASSIGN(id,e))
      equation 
        v = eval_expr(env, e);
        ty = Env.lookuptype(env, id);
        v2 = promote(v, ty);
        env1 = Env.update(env, id, ty, v2); then env1;
    case (env,Absyn.ASSIGN(id,e))
      equation 
        v = eval_expr(env, e);
        print("Error: assignment mismatch or variable missing\n"); then fail();
    case (env,Absyn.WRITE(e))
      equation 
        v = eval_expr(env, e);
        print_value(v); then env;
    case (env,Absyn.NOOP()) then env; 
    case (env,Absyn.IF(e,c,_))
      equation 
        Env.BOOLVAL(true) = eval_expr(env, e);
        env1 = eval_stmt_list(env, c); then env1;
    case (env,Absyn.IF(e,_,a))
      equation 
        Env.BOOLVAL(false) = eval_expr(env, e);
        env1 = eval_stmt_list(env, a); then env1;
    case (env,Absyn.WHILE(e,ss))
      equation 
        Env.BOOLVAL(true) = eval_expr(env, e);
        env1 = eval_stmt_list(env, ss);
        env2 = eval_stmt(env1, Absyn.WHILE(e,ss)); then env2;
    case (env,Absyn.WHILE(e,ss))
      equation 
        Env.BOOLVAL(false) = eval_expr(env, e); then env;
    case (env,Absyn.IF(e,_,a))
      equation 
        Env.BOOLVAL(false) = eval_expr(env, e);
        env1 = eval_stmt_list(env, a); then env1;
    case (env,Absyn.WHILE(e,ss))
      equation 
        Env.BOOLVAL(true) = eval_expr(env, e);
        env1 = eval_stmt_list(env, ss);
        env2 = eval_stmt(env1, Absyn.WHILE(e,ss)); then env2;
    case (env,Absyn.WHILE(e,ss))
      equation 
        Env.BOOLVAL(false) = eval_expr(env, e); then env;
  end matchcontinue;
end eval_stmt;

protected function eval_stmt_list " Evaluate a list of statements in an environent.
   Pass environment forward "
  input Env.Env in_env;
  input Absyn.StmtList in_stmtlist;
  output Env.Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_stmtlist)
    local
      type EnvBindList = list<Env.Bind>;
      type AbsynStmtList = list<Absyn.Stmt>;
      EnvBindList env,env1,env2;
      Absyn.Stmt s;
      AbsynStmtList ss;
    case (env,{}) then env; 
    case (env,s :: ss)
      equation 
        env1 = eval_stmt(env, s);
        env2 = eval_stmt_list(env1, ss); then env2;
  end matchcontinue;
end eval_stmt_list;

protected function eval_decl " EVALUATING DECLARATIONS 
   Evaluate a single statement. Pass environment forward."
  input Env.Env in_env;
  input Absyn.Decl in_decl;
  output Env.Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_decl)
    local
      type EnvBindList = list<Env.Bind>;
      EnvBindList env2,env;
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
end eval_decl;

protected function eval_decl_list " Evaluate a list of declarations, extending the environent. "
  input Env.Env in_env;
  input Absyn.DeclList in_decllist;
  output Env.Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_decllist)
    local
      type EnvBindList = list<Env.Bind>;
      type AbsynDeclList = list<Absyn.Decl>;
      EnvBindList env,env1,env2;
      Absyn.Decl s;
      AbsynDeclList ss;
    case (env,{}) then env; 
    case (env,s :: ss)
      equation 
        env1 = eval_decl(env, s);
        env2 = eval_decl_list(env1, ss); then env2;
  end matchcontinue;
end eval_decl_list;

public function evalprog " EVALUTATING A PROGRAM means to evaluate the list of statements,
   with an initial environment containing just standard defs. "
  input Absyn.Prog in_prog;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_prog)
    local
      type EnvBindList = list<Env.Bind>;
      type AbsynDeclList = list<Absyn.Decl>;
      type AbsynStmtList = list<Absyn.Stmt>;
      EnvBindList env1,env2,env3;
      AbsynDeclList decls;
      AbsynStmtList stmts;
    case (Absyn.PROG(decls,stmts))
      equation 
        env1 = Env.initial_();
        env2 = eval_decl_list(env1, decls);
        env3 = eval_stmt_list(env2, stmts); then true;
  end matchcontinue;
end evalprog;
end Eval;

