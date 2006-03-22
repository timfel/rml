package Absyn

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

uniontype RelOp
  record LT
  end LT;
  record LE
  end LE;
  record GT
  end GT;
  record GE
  end GE;
  record NE
  end NE;
  record EQ
  end EQ;
end RelOp;

type Ident = String;

uniontype Expr
  record INTCONST
    Integer x1;
  end INTCONST;
  record REALCONST
    Real x1;
  end REALCONST;
  record BINARY
    Expr x1;
    BinOp x2;
    Expr x3;
  end BINARY;
  record UNARY
    UnOp x1;
    Expr x2;
  end UNARY;
  record RELATION
    Expr x1;
    RelOp x2;
    Expr x3;
  end RELATION;
  record VARIABLE
    Ident x1;
  end VARIABLE;
end Expr;

type StmtList = list<Stmt>;

uniontype Stmt
  record ASSIGN
    Ident x1;
    Expr x2;
  end ASSIGN;
  record WRITE
    Expr x1;
  end WRITE;
  record NOOP
  end NOOP;
  record IF
    Expr x1;
    StmtList x2;
    StmtList x3;
  end IF;
  record WHILE
    Expr x1;
    StmtList x2;
  end WHILE;
end Stmt;

type StmtList = list<Stmt>;

uniontype Decl
  record NAMEDECL
    Ident x1;
    Ident x2;
  end NAMEDECL;
end Decl;

type DeclList = list<Decl>;

uniontype Prog
  record PROG
    DeclList x1;
    StmtList x2;
  end PROG;
end Prog;
end Absyn;

