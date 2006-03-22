package exp2 " file exp2.rml "

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

public function eval
  input Exp in_exp;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_exp)
    local
      Integer ival,v1,v2,v3;
      Exp e1,e2,e;
      BinOp binop;
      UnOp unop;
    case (INT(ival)) then ival; 
    case (BINARY(e1,binop,e2))
      equation 
        v1 = eval(e1);
        v2 = eval(e2);
        v3 = apply_binop(binop, v1, v2); then v3;
    case (UNARY(unop,e))
      equation 
        v1 = eval(e);
        v2 = apply_unop(unop, v1); then v2;
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
    local Integer v1,v2;
    case (ADD(),v1,v2) then v1 + v2; 
    case (SUB(),v1,v2) then v1 - v2; 
    case (MUL(),v1,v2) then v1*v2; 
    case (DIV(),v1,v2) then v1/v2; 
  end matchcontinue;
end apply_binop;

protected function apply_unop
  input UnOp in_unop;
  input Integer in_integer;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_unop,in_integer)
    local Integer v;
    case (NEG(),v) then -v; 
  end matchcontinue;
end apply_unop;
end exp2;

