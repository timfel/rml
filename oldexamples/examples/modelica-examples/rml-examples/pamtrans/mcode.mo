package Mcode

type Id = String;

uniontype MBinOp
  record MADD
  end MADD;
  record MSUB
  end MSUB;
  record MMULT
  end MMULT;
  record MDIV
  end MDIV;
end MBinOp;

uniontype MCondJmp
  record MJNP
  end MJNP;
  record MJP
  end MJP;
  record MJN
  end MJN;
  record MJNZ
  end MJNZ;
  record MJPZ
  end MJPZ;
  record MJZ
  end MJZ;
end MCondJmp;

uniontype MOperand
  record I
    Id x1;
  end I;
  record N
    Integer x1;
  end N;
  record T
    Integer x1;
  end T;
  record L
    Integer x1 "datatype MLab     =  L of int
type MTemp    =  T of int
type MIdent   =  I of Id
type MIdTemp  =  I of Id | T of int
";
  end L;
end MOperand;

uniontype MCode "datatype MLab     =  L of int
type MTemp    =  T of int
type MIdent   =  I of Id
type MIdTemp  =  I of Id | T of int
"
  record MB
    MBinOp x1;
    MOperand x2 " Binary arith ops ";
  end MB;
  record MJ
    MCondJmp x1;
    MOperand x2 " Conditional jumps ";
  end MJ;
  record MJMP
    MOperand x1;
  end MJMP;
  record MLOAD
    MOperand x1;
  end MLOAD;
  record MSTO
    MOperand x1;
  end MSTO;
  record MGET
    MOperand x1;
  end MGET;
  record MPUT
    MOperand x1;
  end MPUT;
  record MLABEL
    MOperand x1;
  end MLABEL;
  record MHALT
  end MHALT;
end MCode;
end Mcode;

