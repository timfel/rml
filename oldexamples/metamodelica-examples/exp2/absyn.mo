package exp2 " file exp2.rml "

uniontype Exp
  record INTconst
    Integer x1;
  end INTconst;
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
  record ADDop
  end ADDop;
  record SUBop
  end SUBop;
  record MULop
  end MULop;
  record DIVop
  end DIVop;
end BinOp;

uniontype UnOp
  record NEGop
  end NEGop;
end UnOp;
end exp2;

