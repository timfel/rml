package Absyn " absyn.rml -- Mini-Freja Abstract Syntax "

type var = String;

uniontype prim1
  record NOT
  end NOT;
  record NEG
  end NEG;
end prim1;

uniontype prim2
  record LT
  end LT;
  record LE
  end LE;
  record EQ
  end EQ;
  record NE
  end NE;
  record GE
  end GE;
  record GT
  end GT;
  record AND
  end AND;
  record OR
  end OR;
  record ADD
  end ADD;
  record SUB
  end SUB;
  record MUL
  end MUL;
  record DIV
  end DIV;
  record MOD
  end MOD;
end prim2;

uniontype const_
  record INTcnst
    Integer x1;
  end INTcnst;
  record BOOLcnst
    Boolean x1;
  end BOOLcnst;
  record NILcnst
  end NILcnst;
end const_;

uniontype pat
  record CONSTpat
    const_ x1;
  end CONSTpat;
  record VARpat
    var x1;
  end VARpat;
  record CONSpat
    pat x1;
    pat x2;
  end CONSpat;
end pat;

type crule = tuple<exp,pat>;

type cruleList = list<crule>;

type Tuplevarexp = tuple<var,exp>;

type TuplevarexpList = list<Tuplevarexp>;

uniontype exp
  record CONSTexp
    const_ x1;
  end CONSTexp;
  record VARexp
    var x1;
  end VARexp;
  record CONSexp
    exp x1;
    exp x2;
  end CONSexp;
  record LAMexp
    var x1;
    exp x2;
  end LAMexp;
  record PRIM1exp
    prim1 x1;
    exp x2;
  end PRIM1exp;
  record PRIM2exp
    prim2 x1;
    exp x2;
    exp x3;
  end PRIM2exp;
  record IFexp
    exp x1;
    exp x2;
    exp x3;
  end IFexp;
  record APPexp
    exp x1;
    exp x2;
  end APPexp;
  record CASEexp
    exp x1;
    cruleList x2;
  end CASEexp;
  record RECexp
    TuplevarexpList x1;
    exp x2;
  end RECexp;
end exp;
end Absyn;

