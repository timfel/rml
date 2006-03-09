package exp1 " file exp1.rml "

uniontype Exp
  record INTconst
    Integer x1;
  end INTconst;
  record ADDop
    Exp x1;
    Exp x2;
  end ADDop;
  record SUBop
    Exp x1;
    Exp x2;
  end SUBop;
  record MULop
    Exp x1;
    Exp x2;
  end MULop;
  record DIVop
    Exp x1;
    Exp x2;
  end DIVop;
  record NEGop
    Exp x1;
  end NEGop;
end Exp;

constant Exp z = DIVop(INTconst(10),INTconst(10)); 

public function eval " Abstract syntax of the language Exp1 
   Evaluation semantics  of Exp1 "
  input Exp in_exp;
  output Integer out_integer;
algorithm 
  out_integer:=
  matchcontinue (in_exp)
    local
      Integer ival,v1,v2;
      Exp e1,e2,e;
    case (INTconst(ival)) then ival;  " eval of an integer node   is the integer itself "
    case (ADDop(e1,e2)) " Evaluation of an addition node PLUSop is v3, if v3 is the result of
   * adding the evaluated results of its children e1 and e2 
   * Subtraction, multiplication, division operators have similar specs.
   "
      equation 
        v1 = eval(e1);
        v2 = eval(e2); then v1 + v2;
    case (SUBop(e1,e2))
      equation 
        v1 = eval(e1);
        v2 = eval(e2); then v1 - v2;
    case (MULop(e1,e2))
      equation 
        v1 = eval(e1);
        v2 = eval(e2); then v1*v2;
    case (DIVop(e1,e2))
      equation 
        v1 = eval(e1);
        v2 = eval(e2); then v1/v2;
    case (NEGop(e))
      equation 
        v1 = eval(e); then -v1;
  end matchcontinue;
end eval;
end exp1;

