package exp1 "file exp1.rml"

public 
uniontype Exp
  record INTconst
    Integer integer;
  end INTconst;

  record ADDop
    Exp exp1;
    Exp exp2;
  end ADDop;

  record SUBop
    Exp exp1;
    Exp exp2;
  end SUBop;

  record MULop
    Exp exp1;
    Exp exp2;
  end MULop;

  record DIVop
    Exp exp1;
    Exp exp2;
  end DIVop;

  record NEGop
    Exp exp;
  end NEGop;

end Exp;

public function eval "Abstract syntax of the language Exp1
  Evaluation semantics  of Exp1"
  input Exp inExp;
  output Integer outInteger;
algorithm 
  outInteger:=
  matchcontinue (inExp)
    local
      Integer ival,v1,v2;
      Exp e1,e2,e;
    case (INTconst(integer = ival)) "eval of an integer node is the integer itself" then ival;
    case (ADDop(exp1 = e1,exp2 = e2)) "Evaluation of an addition node PLUSop is v3, if v3 is the result of
    adding the evaluated results of its children e1 and e2 
    Subtraction, multiplication, division operators have similar specs.
"   equation
      v1 = eval(e1); 
    then v1 + eval(e2);
    case (SUBop(exp1 = e1,exp2 = e2))
      equation 
        v1 = eval(e1);
        v2 = eval(e2); then v1 - v2;
    case (MULop(exp1 = e1,exp2 = e2))
      equation 
        v1 = eval(e1);
        v2 = eval(e2); then v1*v2;
    case (DIVop(exp1 = e1,exp2 = e2))
      equation 
        v1 = eval(e1);
        v2 = eval(e2); then v1/v2;
    case (NEGop(exp = e))
      equation 
        v1 = eval(e); then -v1;
  end matchcontinue;
end eval;
end exp1;

