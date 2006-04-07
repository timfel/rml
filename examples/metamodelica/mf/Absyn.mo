package Absyn "absyn.rml -- Mini-Freja Abstract Syntax"

public 
type var = String;

public 
uniontype prim1
  record NOT end NOT;

  record NEG end NEG;

end prim1;

public 
uniontype prim2
  record LT end LT;

  record LE end LE;

  record EQ end EQ;

  record NE end NE;

  record GE end GE;

  record GT end GT;

  record AND end AND;

  record OR end OR;

  record ADD end ADD;

  record SUB end SUB;

  record MUL end MUL;

  record DIV end DIV;

  record MOD end MOD;

end prim2;

public 
uniontype const
  record INTcnst
    Integer integer;
  end INTcnst;

  record BOOLcnst
    Boolean boolean;
  end BOOLcnst;

  record NILcnst end NILcnst;

end const;

public 
uniontype pat
  record CONSTpat
    const const;
  end CONSTpat;

  record VARpat
    var var;
  end VARpat;

  record CONSpat
    pat pat1;
    pat pat2;
  end CONSpat;

end pat;

public 
uniontype exp
  record CONSTexp
    const const;
  end CONSTexp;

  record VARexp
    var var;
  end VARexp;

  record CONSexp
    exp exp1;
    exp exp2;
  end CONSexp;

  record LAMexp
    var var;
    exp exp;
  end LAMexp;

  record PRIM1exp
    prim1 prim1;
    exp exp;
  end PRIM1exp;

  record PRIM2exp
    prim2 prim21;
    exp exp2;
    exp exp3;
  end PRIM2exp;

  record IFexp
    exp exp1;
    exp exp2;
    exp exp3;
  end IFexp;

  record APPexp
    exp exp1;
    exp exp2;
  end APPexp;

  record CASEexp
    exp exp;
    list<crule> cruleLst;
  end CASEexp;

  record RECexp
    list<tuple<var, exp>> tplvarexpLst;
    exp exp;
  end RECexp;

end exp;

public 
type crule = tuple<pat, exp>;
end Absyn;

