package Absyn

type Ident = String " Semantics oriented abstract syntax for the PAM language ";

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

uniontype RelOp
  record EQ
  end EQ;
  record GT
  end GT;
  record LT
  end LT;
  record LE
  end LE;
  record GE
  end GE;
  record NE
  end NE;
end RelOp;

uniontype Exp
  record INT
    Integer x1;
  end INT;
  record IDENT
    Ident x1;
  end IDENT;
  record BINARY
    Exp x1;
    BinOp x2;
    Exp x3;
  end BINARY;
  record RELATION
    Exp x1;
    RelOp x2;
    Exp x3;
  end RELATION;
end Exp;

type Comparison = Exp;

type IdentList = list<Ident>;

uniontype Stmt
  record ASSIGN
    Ident x1;
    Comparison x2 " Id := Exp ";
  end ASSIGN;
  record IF
    Comparison x1;
    Stmt x2;
    Stmt x3 " if Exp then Stmt..";
  end IF;
  record WHILE
    Comparison x1;
    Stmt x2 " while Exp do Stmt";
  end WHILE;
  record TODO
    Comparison x1;
    Stmt x2 " to Exp do Stmt...";
  end TODO;
  record READ
    IdentList x1 " read id1,id2,...";
  end READ;
  record WRITE
    IdentList x1 " write id1,id2,..";
  end WRITE;
  record SEQ
    Stmt x1;
    Stmt x2 " Stmt1; Stmt2 ";
  end SEQ;
  record SKIP " ; empty stmt "
  end SKIP;
end Stmt;
end Absyn;

