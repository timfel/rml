package Absyn " absyn.rml "

type Ident = String;

uniontype Constant
  record INTcon
    Integer x1 " Ex: 55, 36, 999 ";
  end INTcon;
  record REALcon
    Real x1 " Ex: 3.1459, 1.2E-35 ";
  end REALcon;
  record IDENTcon
    Ident x1 " Ex: foo, fum ";
  end IDENTcon;
end Constant;

uniontype ConBnd " Ex: foo, fum "
  record CONBND
    Ident x1;
    Constant x2 " fooconst = 444 ";
  end CONBND;
end ConBnd;

type VarBndList = list<VarBnd>;

uniontype Ty " Types and variables "
  record NAME
    Ident x1 " typename ";
  end NAME;
  record PTR
    Ty x1 " ^typename ";
  end PTR;
  record ARR
    Constant x1;
    Ty x2 " array {const} of ty ";
  end ARR;
  record REC
    VarBndList x1 " record a:b; c:d;...end";
  end REC;
end Ty;

uniontype VarBnd
  record VARBND
    Ident x1;
    Ty x2 " id1:ty1 ";
  end VARBND;
end VarBnd;

uniontype TyBnd
  record TYBND
    Ident x1;
    Ty x2 " newreal = real; ";
  end TYBND;
end TyBnd;

uniontype UnOp " Operators "
  record ADDR
  end ADDR;
  record INDIR
  end INDIR;
  record NOT "  &,  ^,  not "
  end NOT;
end UnOp;

uniontype BinOp "  &,  ^,  not "
  record ADD
  end ADD;
  record SUB
  end SUB;
  record MUL
  end MUL;
  record RDIV
  end RDIV;
  record IDIV "  +, -, *, /, "
  end IDIV;
  record IMOD
  end IMOD;
  record IAND
  end IAND;
  record IOR "  div, mod, and, or "
  end IOR;
end BinOp;

uniontype RelOp "  div, mod, and, or "
  record LT
  end LT;
  record LE "  <, <=  "
  end LE;
end RelOp;

type ExpList = list<Exp>;

uniontype Exp " Expression nodes "
  record INT
    Integer x1 "  55, 999, ";
  end INT;
  record REAL
    Real x1 "  3.1459, ... ";
  end REAL;
  record IDENT
    Ident x1 "  foo, fum ... ";
  end IDENT;
  record CAST
    Ty x1;
    Exp x2 "  real(3+5)   ";
  end CAST;
  record FIELD
    Exp x1;
    Ident x2 "  recexp.fieldid ";
  end FIELD;
  record UNARY
    UnOp x1;
    Exp x2 "  unop expr ";
  end UNARY;
  record BINARY
    Exp x1;
    BinOp x2;
    Exp x3 "  e1 binop e2 ";
  end BINARY;
  record RELATION
    Exp x1;
    RelOp x2;
    Exp x3 "  e1 relop e2 ";
  end RELATION;
  record EQUALITY
    Exp x1;
    Exp x2 "  e1 = e2 ";
  end EQUALITY;
  record FCALL
    Ident x1;
    ExpList x2 "  foo(e1,e2,...)   Statements ";
  end FCALL;
end Exp;

uniontype Stmt
  record ASSIGN
    Exp x1;
    Exp x2 "  x := 1+y;  ";
  end ASSIGN;
  record PCALL
    Ident x1;
    ExpList x2 "  f2(a1,a2+5,a3,...) ";
  end PCALL;
  record FRETURN
    Exp x1 "  return e1+5  ";
  end FRETURN;
  record PRETURN "  return  "
  end PRETURN;
  record WHILE
    Exp x1;
    Stmt x2 "  while e1 do s1 end ";
  end WHILE;
  record IF
    Exp x1;
    Stmt x2;
    Stmt x3 "  if e1 then s1 else s2";
  end IF;
  record SEQ
    Stmt x1;
    Stmt x2 "  s1;  s2  ";
  end SEQ;
  record SKIP "  empty statement "
  end SKIP;
end Stmt;

type BlockOption = Option<Block>;

uniontype SubBnd " Subprograms 
   Block option is needed for Petrol extern declarations without body "
  record FUNCBND
    Ident x1;
    VarBndList x2;
    Ty x3;
    BlockOption x4;
  end FUNCBND;
  record PROCBND
    Ident x1;
    VarBndList x2;
    BlockOption x3;
  end PROCBND;
end SubBnd;

type ConBndList = list<ConBnd>;

type TyBndList = list<TyBnd>;

type SubBndList = list<SubBnd>;

uniontype Block
  record BLOCK
    ConBndList x1;
    TyBndList x2;
    VarBndList x3;
    SubBndList x4;
    Stmt x5 " Programs ";
  end BLOCK;
end Block;

uniontype Prog
  record PROG
    Ident x1;
    Block x2;
  end PROG;
end Prog;
end Absyn;

