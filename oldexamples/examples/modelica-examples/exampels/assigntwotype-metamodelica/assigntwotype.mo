package assigntwotype " file assignment.rml "

type ExpList = list<Exp>;

uniontype Program " Abstract syntax for the Assigntwotype language "
  record PROGRAM
    ExpList x1;
    Exp x2;
  end PROGRAM;
end Program;

uniontype Exp
  record INT
    Integer x1;
  end INT;
  record REAL
    Real x1;
  end REAL;
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

uniontype Value " Values stored in environments "
  record INTval
    Integer x1;
  end INTval;
  record REALval
    Real x1;
  end REALval;
end Value;

type VarBnd = tuple<Ident,Value> " Bindings and environments ";

type Env = list<VarBnd>;

uniontype Ty2 " Ty2 is an auxiliary datatype used to handle types during evaluation "
  record INT2
    Integer x1;
    Integer x2;
  end INT2;
  record REAL2
    Real x1;
    Real x2;
  end REAL2;
end Ty2;

protected function printvalue
  input Value in_value;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_value)
    local
      Ident x_1;
      Integer x;
    case (INTval(x))
      equation 
        x_1 = int_string(x);
        print(x_1); then true;
    case (REALval(x))
      local Real x;
      equation 
        x_1 = real_string(x);
        print(x_1); then true;
  end matchcontinue;
end printvalue;

public function evalprogram
  input Program in_program;
  output Boolean dummy;
algorithm 
  dummy:=
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
        print("evp4\n");
        printvalue(value); then true;
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
      Exp exp;
      ExpList expl;
    case (e,{}) then e; 
    case (env,exp :: expl)
      equation 
        (env2,_) = eval(env, exp);
        env3 = evals(env2, expl); then env3;
  end matchcontinue;
end evals;

protected function eval
  input Env in_env;
  input Exp in_exp;
  output Env out_env;
  output Value out_value;
algorithm 
  (out_env,out_value):=
  matchcontinue (in_env,in_exp)
    local
      Env env,env2,env1;
      Integer ival,x,y,z;
      Real rval;
      Value value,v1,v2;
      Ident id;
      Exp e1,e2,e,exp;
      BinOp binop;
      UnOp unop;
    case (env,INT(ival)) then (env,INTval(ival)); 
    case (env,REAL(rval)) then (env,REALval(rval)); 
    case (env,IDENT(id)) " variable id "
      equation 
        (env2,value) = lookupextend(env, id); then (env2,value);
    case (env,BINARY(e1,binop,e2)) " int binop int "
      equation 
        (env1,v1) = eval(env, e1);
        (env2,v2) = eval(env, e2);
        INT2(x,y) = type_lub(v1, v2);
        z = apply_int_binop(binop, x, y); then (env2,INTval(z));
    case (env,BINARY(e1,binop,e2)) " int/real binop int/real "
      local Real x,y,z;
      equation 
        (env1,v1) = eval(env, e1);
        (env2,v2) = eval(env, e2);
        REAL2(x,y) = type_lub(v1, v2);
        z = apply_real_binop(binop, x, y); then (env2,REALval(z));
    case (env,UNARY(unop,e)) " int unop exp "
      equation 
        (env1,INTval(x)) = eval(env, e);
        y = apply_int_unop(unop, x); then (env1,INTval(y));
    case (env,UNARY(unop,e)) " real unop exp "
      local Real x,y;
      equation 
        (env1,REALval(x)) = eval(env, e);
        y = apply_real_unop(unop, x); then (env1,REALval(y));
    case (env,ASSIGN(id,exp)) " eval of an assignment node returns the updated environment and
   * the assigned value   id := exp "
      equation 
        (env1,value) = eval(env, exp);
        env2 = update(env1, id, value); then (env2,value);
  end matchcontinue;
end eval;

protected function type_lub
  input Value in_value1;
  input Value in_value2;
  output Ty2 out_ty2;
algorithm 
  out_ty2:=
  matchcontinue (in_value1,in_value2)
    local
      Integer x,y;
      Real x2,y2;
    case (INTval(x),INTval(y)) then INT2(x,y); 
    case (INTval(x),REALval(y))
      local Real y;
      equation 
        x2 = int_real(x); then REAL2(x2,y);
    case (REALval(x),INTval(y))
      local Real x;
      equation 
        y2 = int_real(y); then REAL2(x,y2);
    case (REALval(x),REALval(y))
      local Real x,y; then REAL2(x,y);
  end matchcontinue;
end type_lub;

protected function apply_int_binop
  input BinOp in_binop1;
  input Integer in_integer2;
  input Integer in_integer3;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_binop1,in_integer2,in_integer3)
    local Integer x,y;
    case (ADD(),x,y) then x + y;  " x+y "
    case (SUB(),x,y) then x - y;  " x-y "
    case (MUL(),x,y) then x*y;  " x*y "
    case (DIV(),x,y) then x/y;  " x/y "
  end matchcontinue;
end apply_int_binop;

protected function apply_real_binop
  input BinOp in_binop1;
  input Real in_real2;
  input Real in_real3;
  output Real out_real;
algorithm 
  out_real:=
  matchcontinue (in_binop1,in_real2,in_real3)
    local Real x,y;
    case (ADD(),x,y) then x +. y;  " x+y "
    case (SUB(),x,y) then x -. y;  " x-y "
    case (MUL(),x,y) then x*.y;  " x*y "
    case (DIV(),x,y) then x/.y;  " x/y "
  end matchcontinue;
end apply_real_binop;

protected function apply_int_unop
  input UnOp in_unop;
  input Integer in_integer;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_unop,in_integer)
    local Integer x;
    case (NEG(),x) then -x;  " -x "
  end matchcontinue;
end apply_int_unop;

protected function apply_real_unop
  input UnOp in_unop;
  input Real in_real;
  output Real out_real;
algorithm 
  out_real:=
  matchcontinue (in_unop,in_real)
    local Real x;
    case (NEG(),x) then -.x;  " -x "
  end matchcontinue;
end apply_real_unop;

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
 * If no association is present, lookup will fail.   Identifier id is found in the first pair of the list, and value
 * is returned. "
      equation 
        equality(id = id2); then value;
    case ((id2,_) :: rest,id) " id is not found in the first pair of the list, and lookup will
 * recursively search the rest of the list. If found, value is returned.
 "
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
      Value value;
      Env env;
      Ident id;
    case (env,id) " Return value of id in env. If id not present, add id and return 0 "
      equation 
        failure(v = lookup(env, id));
        value = INTval(0); then ((id,value) :: env,value);
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
end assigntwotype;

