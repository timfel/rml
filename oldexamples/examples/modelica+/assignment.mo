/*---------------------
 assignment
---------------------*/


package assignment
  uniontype Program
    type ExpList = list<Exp>;
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

  type Value = Integer;

  type VarBnd = tuple<Ident,Value>;

  type Env = list<VarBnd>;

  function lookup
    input Env in_value1;
    input Ident in_value2;
    output Value out_value1;
  algorithm 
    out_value1:=
    match (in_value1,in_value2)
      local
        String id2;
        Integer value;
        String id;
        type TupleStringInteger = tuple<String,Integer>;
        type TupleStringIntegerList = list<TupleStringInteger>;
        TupleStringIntegerList rest;
      case ((id2,value) :: _,id)
        equation 
          id = id2;
        then value;
      case ((id2,_) :: rest,id)
        equation 
          failure(id = id2);
          value = lookup(rest, id);
        then value;
    end match;
  end lookup;

  function lookupextend
    input Env in_value1;
    input Ident in_value2;
    output Env out_value1;
    output Value out_value2;
  algorithm 
    out_value1:=
    match (in_value1,in_value2)
      local
        type TupleStringInteger = tuple<String,Integer>;
        type TupleStringIntegerList = list<TupleStringInteger>;
        TupleStringIntegerList env;
        String id;
        Integer value;
      case (env,id)
        equation 
          failure(v = lookup(env, id));
        then ((id,0) :: env,0);
      case (env,id)
        equation 
          value = lookup(env, id);
        then (env,value);
    end match;
  end lookupextend;

  function update
    input Env in_value1;
    input Ident in_value2;
    input Value in_value3;
    output Env out_value1;
  algorithm 
    out_value1:=
    match (in_value1,in_value2,in_value3)
      local
        type TupleStringInteger = tuple<String,Integer>;
        type TupleStringIntegerList = list<TupleStringInteger>;
        TupleStringIntegerList env;
        String id;
        Integer value;
      case (env,id,value) then (id,value) :: env;
    end match;
  end update;

  function evalprogram
    input Program in_value1;
    output Integer out_value1;
  algorithm 
    out_value1:=
    match in_value1
      local
        type ExpList = list<Exp>;
        ExpList assignments_1;
        type TupleStringInteger = tuple<String,Integer>;
        type TupleStringIntegerList = list<TupleStringInteger>;
        TupleStringIntegerList env2;
        Integer value;
        ExpList assignments;
        Exp exp;
      case PROGRAM(assignments,exp)
        equation 
          print("evp1\n");
          assignments_1 = list_reverse(assignments);
          print("evp2\n");
          env2 = evals({}, assignments_1);
          print("evp3\n");
          (_,value) = eval(env2, exp);
          print("evp4\n");
        then value;
    end match;
  end evalprogram;

  function evals
    type ExpList = list<Exp>;
    input Env in_value1;
    input ExpList in_value2;
    output Env out_value1;
  algorithm 
    out_value1:=
    match (in_value1,in_value2)
      local
        type TupleStringInteger = tuple<String,Integer>;
        type TupleStringIntegerList = list<TupleStringInteger>;
        TupleStringIntegerList e;
        TupleStringIntegerList env2;
        Integer v;
        String s;
        TupleStringIntegerList env3;
        TupleStringIntegerList env;
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
          env3 = evals(env2, expl);
        then env3;
    end match;
  end evals;

  function eval
    input Env in_value1;
    input Exp in_value2;
    output Env out_value1;
    output Integer out_value2;
  algorithm 
    out_value1:=
    match (in_value1,in_value2)
      local
        type TupleStringInteger = tuple<String,Integer>;
        type TupleStringIntegerList = list<TupleStringInteger>;
        TupleStringIntegerList env;
        Integer ival;
        TupleStringIntegerList env2;
        Integer value;
        String s;
        String id;
        TupleStringIntegerList env3;
        Exp exp;
        Integer v1;
        Integer v2;
        Integer v3;
        TupleStringIntegerList env1;
        Exp e1;
        BinOp binop;
        Exp e2;
        UnOp unop;
        Exp e;
      case (env,INT(ival)) then (env,ival);
      case (env,IDENT(id))
        equation 
          (env2,value) = lookupextend(env, id);
          s = int_string(value);
          print("lookup: ");
          print(s);
          print("\n");
        then (env2,value);
      case (env,ASSIGN(id,exp))
        equation 
          (env2,value) = eval(env, exp);
          env3 = update(env2, id, value);
        then (env3,value);
      case (env1,BINARY(e1,binop,e2))
        equation 
          (env2,v1) = eval(env1, e1);
          (env3,v2) = eval(env2, e2);
          v3 = apply_binop(binop, v1, v2);
        then (env3,v3);
      case (env1,UNARY(unop,e))
        equation 
          (env2,v1) = eval(env1, e);
          v2 = apply_unop(unop, v1);
        then (env2,v2);
    end match;
  end eval;

  function apply_binop
    input BinOp in_value1;
    input Integer in_value2;
    input Integer in_value3;
    output Integer out_value1;
  algorithm 
    out_value1:=
    match (in_value1,in_value2,in_value3)
      local
        Integer v3;
        Integer v1;
        Integer v2;
      case (ADD,v1,v2)
        equation 
          v3 = v1 + v2;
        then v3;
      case (SUB,v1,v2)
        equation 
          v3 = v1 - v2;
        then v3;
      case (MUL,v1,v2)
        equation 
          v3 = v1*v2;
        then v3;
      case (DIV,v1,v2)
        equation 
          v3 = v1/v2;
        then v3;
    end match;
  end apply_binop;

  function apply_unop
    input UnOp in_value1;
    input Integer in_value2;
    output Integer out_value1;
  algorithm 
    out_value1:=
    match (in_value1,in_value2)
      local
        Integer v2;
        Integer v;
      case (NEG,v)
        equation 
          v2 = -v;
        then v2;
    end match;
  end apply_unop;

end assignment;
