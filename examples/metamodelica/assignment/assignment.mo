package assignment " file assignment.rml "

type ExpList = list<Exp>;

uniontype Program " Abstract syntax for the Assignments language "
  record PROGRAM
    ExpList x1;
    Exp x2;
  end PROGRAM;
end Program;

uniontype Exp
  record INT
    Integer x1;
  end INT;
  record BINARY
    Exp x1;
    BinOp x2;
    Exp x3;
  end BINARY;
  record UNARY
    UnOp x1;
    Exp x2;
  end UNARY;
  record ASSIGN
    Ident x1;
    Exp x2;
  end ASSIGN;
  record IDENT
    Ident x1;
  end IDENT;
end Exp;

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

uniontype UnOp
  record NEG
  end NEG;
end UnOp;

type Ident = String;

type Value = Integer " Values stored in environments ";

type VarBnd = tuple<Ident,Value> " Bindings and environments ";

type Env = list<VarBnd>;

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
      Env rest;
    case ((id2,value) :: _,id) " lookup returns the value associated with an identifier.
 * If no association is present, lookup will fail. "
      equation 
        equality(id = id2); then value;
    case ((id2,_) :: rest,id)
      equation 
        failure(equality(id = id2));
        value = lookup(rest, id); then value;
  end matchcontinue;
end lookup;

protected function lookupextend
  input Env in_env;
  input Ident in_ident;
  output Env out_env;
  output Value out_value;
algorithm 
  (out_env,out_value):=
  matchcontinue (in_env,in_ident)
    local
      Env env;
      Ident id;
      Value value;
    case (env,id)
      equation 
        failure(v = lookup(env, id)); then ((id,0) :: env,0);
    case (env,id)
      equation 
        value = lookup(env, id); then (env,value);
  end matchcontinue;
end lookupextend;

protected function update
  input Env in_env;
  input Ident in_ident;
  input Value in_value;
  output Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_ident,in_value)
    local
      Env env;
      Ident id;
      Value value;
    case (env,id,value) then (id,value) :: env; 
  end matchcontinue;
end update;

public function evalprogram
  input Program in_program;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_program)
    local
      ExpList assignments_1,assignments;
      Env env2;
      Value value;
      Exp exp;
    case (PROGRAM(assignments,exp))
      equation 
        print("evp1\n");
        assignments_1 = list_reverse(assignments);
        print("evp2\n");
        env2 = evals({}, assignments_1);
        print("evp3\n");
        (_,value) = eval(env2, exp);
        print("evp4\n"); then value;
  end matchcontinue;
end evalprogram;

protected function evals
  input Env in_env;
  input ExpList in_explist;
  output Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_explist)
    local
      Env e,env2,env3,env;
      Value v;
      Ident s;
      Exp exp;
      ExpList expl;
    case (e,{}) then e; 
    case (env,exp :: expl)
      equation 
        (env2,v) = eval(env, exp);
        s = int_string(v);
        print("v: ");
        print(s);
        print("\n");
        env3 = evals(env2, expl); then env3;
  end matchcontinue;
end evals;

protected function eval
  input Env in_env;
  input Exp in_exp;
  output Env out_env;
  output Integer out_integer;
algorithm 
  (out_env,out_integer):=
  matchcontinue (in_env,in_exp)
    local
      Env env,env2,env3,env1;
      Value ival,value,v1,v2,v3;
      Ident s,id;
      Exp exp,e1,e2,e;
      BinOp binop;
      UnOp unop;
    case (env,INT(ival)) then (env,ival); 
    case (env,IDENT(id)) " eval of an identifier node will lookup the identifier and return a
   * value if present; otherwise insert a binding to zero, and return zero.
   "
      equation 
        (env2,value) = lookupextend(env, id);
        s = int_string(value);
        print("lookup: ");
        print(s);
        print("\n"); then (env2,value);
    case (env,ASSIGN(id,exp)) " eval of an assignment node returns the updated environment and
   * the assigned value.
   "
      equation 
        (env2,value) = eval(env, exp);
        env3 = update(env2, id, value); then (env3,value);
    case (env1,BINARY(e1,binop,e2)) " eval of an addition node ADD(e1,e2), etc. in an environment env "
      equation 
        (env2,v1) = eval(env1, e1);
        (env3,v2) = eval(env2, e2);
        v3 = apply_binop(binop, v1, v2); then (env3,v3);
    case (env1,UNARY(unop,e))
      equation 
        (env2,v1) = eval(env1, e);
        v2 = apply_unop(unop, v1); then (env2,v2);
  end matchcontinue;
end eval;

protected function apply_binop
  input BinOp in_binop1;
  input Integer in_integer2;
  input Integer in_integer3;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_binop1,in_integer2,in_integer3)
    local Value v1,v2;
    case (ADD(),v1,v2) then v1 + v2; 
    case (SUB(),v1,v2) then v1 - v2; 
    case (MUL(),v1,v2) then v1 * v2; 
    case (DIV(),v1,v2) then v1 / v2; 
  end matchcontinue;
end apply_binop;

protected function apply_unop
  input UnOp in_unop;
  input Integer in_integer;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_unop,in_integer)
    local Value v;
    case (NEG(),v) then -v; 
  end matchcontinue;
end apply_unop;
end assignment;

