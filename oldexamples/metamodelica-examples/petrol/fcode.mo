package FCode " fcode.rml "

type Level = Integer;

type Ident = String;

type Stamp = Integer;

uniontype Ty
  record CHAR
  end CHAR;
  record INT
  end INT;
  record REAL
  end REAL;
  record PTR
    Ty x1;
  end PTR;
  record ARR
    Stamp x1;
    Ty x2;
  end ARR;
  record REC
    Record x1;
  end REC;
  record UNFOLD
    Stamp x1;
  end UNFOLD;
end Ty;

type VarList = list<Var>;

uniontype Record
  record RECORD
    Stamp x1;
    VarList x2;
  end RECORD;
end Record;

uniontype Var
  record VAR
    Ident x1;
    Ty x2;
  end VAR;
end Var;

uniontype UnOp
  record CtoI
  end CtoI;
  record ItoR
  end ItoR;
  record RtoI
  end RtoI;
  record ItoC
  end ItoC;
  record TOPTR
    Ty x1;
  end TOPTR;
  record PtoI
  end PtoI;
  record LOAD
    Ty x1;
  end LOAD;
  record OFFSET
    Record x1;
    Ident x2;
  end OFFSET;
end UnOp;

uniontype BinOp
  record IADD
  end IADD;
  record ISUB
  end ISUB;
  record IMUL
  end IMUL;
  record IDIV
  end IDIV;
  record IMOD
  end IMOD;
  record IAND
  end IAND;
  record IOR
  end IOR;
  record ILT
  end ILT;
  record ILE
  end ILE;
  record IEQ
  end IEQ;
  record RADD
  end RADD;
  record RSUB
  end RSUB;
  record RMUL
  end RMUL;
  record RDIV
  end RDIV;
  record RLT
  end RLT;
  record RLE
  end RLE;
  record REQ
  end REQ;
  record PADD
    Ty x1;
  end PADD;
  record PSUB
    Ty x1;
  end PSUB;
  record PDIFF
    Ty x1;
  end PDIFF;
  record PLT
    Ty x1;
  end PLT;
  record PLE
    Ty x1;
  end PLE;
  record PEQ
    Ty x1;
  end PEQ;
end BinOp;

type ExpList = list<Exp>;

uniontype Exp
  record ICON
    Stamp x1;
  end ICON;
  record RCON
    Real x1;
  end RCON;
  record DISPLAY
    Level x1;
  end DISPLAY;
  record UNARY
    UnOp x1;
    Exp x2;
  end UNARY;
  record BINARY
    Exp x1;
    BinOp x2;
    Exp x3;
  end BINARY;
  record FCALL
    Ident x1;
    ExpList x2;
  end FCALL;
end Exp;

type TupleTyExp = tuple<Ty,Exp>;

type TupleTyExpOption = Option<TupleTyExp>;

uniontype Stmt
  record STORE
    Ty x1;
    Exp x2;
    Exp x3;
  end STORE;
  record PCALL
    Ident x1;
    ExpList x2;
  end PCALL;
  record RETURN
    TupleTyExpOption x1;
  end RETURN;
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

uniontype Block
  record BLOCK
    Level x1;
    Record x2;
    Stmt x3;
  end BLOCK;
end Block;

type TyOption = Option<Ty>;

type BlockOption = Option<Block>;

uniontype Proc
  record PROC
    Ident x1;
    VarList x2;
    TyOption x3;
    BlockOption x4;
  end PROC;
end Proc;

type ProcList = list<Proc>;

uniontype Prog
  record PROG
    ProcList x1;
    Ident x2;
  end PROG;
end Prog;
end FCode;

