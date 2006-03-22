package Absyn " absyn.rml
 * concrete syntax rewritings:
 *	exp1{exp2}	==> (exp1 + exp2)^
 *	-exp		==> 0 - exp
 *	+exp		==> exp
 *	exp1 <> exp2	==> not(exp1 = exp2)
 *	exp1 >= exp2	==> exp2 <= exp1
 *	exp1 > exp2	==> exp2 < exp1
 "

type Ident = String;

uniontype Constant
  record INTcon
    Integer x1;
  end INTcon;
  record REALcon
    Real x1;
  end REALcon;
  record IDENTcon
    Ident x1;
  end IDENTcon;
end Constant;

uniontype ConBnd
  record CONBND
    Ident x1;
    Constant x2;
  end CONBND;
end ConBnd;

type VarBndList = list<VarBnd>;

uniontype Ty
  record NAME
    Ident x1;
  end NAME;
  record PTR
    Ty x1;
  end PTR;
  record ARR
    Constant x1;
    Ty x2;
  end ARR;
  record REC
    VarBndList x1;
  end REC;
end Ty;

uniontype VarBnd
  record VARBND
    Ident x1;
    Ty x2;
  end VARBND;
end VarBnd;

uniontype TyBnd
  record TYBND
    Ident x1;
    Ty x2;
  end TYBND;
end TyBnd;

uniontype UnOp
  record ADDR
  end ADDR;
  record INDIR
  end INDIR;
  record NOT
  end NOT;
end UnOp;

uniontype BinOp
  record ADD
  end ADD;
  record SUB
  end SUB;
  record MUL
  end MUL;
  record RDIV
  end RDIV;
  record IDIV
  end IDIV;
  record IMOD
  end IMOD;
  record IAND
  end IAND;
  record IOR
  end IOR;
end BinOp;

uniontype RelOp
  record LT
  end LT;
  record LE
  end LE;
end RelOp;

type ExpList = list<Exp>;

uniontype Exp
  record INT
    Integer x1;
  end INT;
  record REAL
    Real x1;
  end REAL;
  record IDENT
    Ident x1;
  end IDENT;
  record CAST
    Ty x1;
    Exp x2;
  end CAST;
  record FIELD
    Exp x1;
    Ident x2;
  end FIELD;
  record UNARY
    UnOp x1;
    Exp x2;
  end UNARY;
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
  record EQUALITY
    Exp x1;
    Exp x2;
  end EQUALITY;
  record FCALL
    Ident x1;
    ExpList x2;
  end FCALL;
end Exp;

uniontype Stmt
  record ASSIGN
    Exp x1;
    Exp x2;
  end ASSIGN;
  record PCALL
    Ident x1;
    ExpList x2;
  end PCALL;
  record FRETURN
    Exp x1;
  end FRETURN;
  record PRETURN
  end PRETURN;
  record WHILE
    Exp x1;
    Stmt x2;
  end WHILE;
  record IF
    Exp x1;
    Stmt x2;
    Stmt x3;
  end IF;
  record SEQ
    Stmt x1;
    Stmt x2;
  end SEQ;
  record SKIP
  end SKIP;
end Stmt;

type BlockOption = Option<Block>;

uniontype SubBnd
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
    Stmt x5;
  end BLOCK;
end Block;

uniontype Prog
  record PROG
    Ident x1;
    Block x2;
  end PROG;
end Prog;
end Absyn;

