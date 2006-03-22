package Absyn " absyn.rml "

type Ident = String;

uniontype Exp
  record INT
    Integer x1;
  end INT;
  record REAL
    Real x1;
  end REAL;
  record STRING
    Ident x1;
  end STRING;
  record UNIT
  end UNIT;
  record VAR
    Ident x1;
  end VAR;
  record LAM
    Lambda x1;
  end LAM;
  record APP
    Exp x1;
    Exp x2;
  end APP;
  record PAIR
    Exp x1;
    Exp x2;
  end PAIR;
  record IF
    Exp x1;
    Exp x2;
    Exp x3;
  end IF;
  record LET
    Ident x1;
    Exp x2;
    Exp x3;
  end LET;
  record LETREC
    Ident x1;
    Lambda x2;
    Exp x3;
  end LETREC;
end Exp;

uniontype Lambda
  record LAMBDA
    Ident x1;
    Exp x2;
  end LAMBDA;
end Lambda;

uniontype Dec
  record VAL
    Ident x1;
    Exp x2;
  end VAL;
end Dec;
constant Exp var_add=VAR("+");
constant Exp var_cons=VAR("::");
constant Exp var_eq=VAR("=");
constant Exp var_idiv=VAR("idiv");
constant Exp var_imod=VAR("imod");
constant Exp var_le=VAR("<=");
constant Exp var_lt=VAR("<");
constant Exp var_mul=VAR("*");
constant Exp var_nil=VAR("nil");
constant Exp var_rdiv=VAR("rdiv");
constant Exp var_set=VAR(":=");
constant Exp var_sub=VAR("-");
end Absyn;

