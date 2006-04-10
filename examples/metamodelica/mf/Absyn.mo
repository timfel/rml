package Absyn "absyn.rml -- Mini-Freja Abstract Syntax"

public type Var = String;

public uniontype Prim1
  record NOT end NOT;
  record NEG end NEG;
end Prim1;

public uniontype Prim2
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
end Prim2;

public uniontype Const
  record INTcnst
    Integer integer;
  end INTcnst;
  record BOOLcnst
    Boolean boolean;
  end BOOLcnst;
  record NILcnst end NILcnst;
end Const;

public uniontype Pat
  record CONSTpat 
    Const const; 
  end CONSTpat;
  record VARpat
    Var var;
  end VARpat;
  record CONSpat
    Pat pat1;
    Pat pat2;
  end CONSpat;
end Pat;

public uniontype Exp
  record CONSTexp
    Const const;
  end CONSTexp;
  record VARexp
    Var var;
  end VARexp;
  record CONSexp
    Exp exp1;
    Exp exp2;
  end CONSexp;
  record LAMexp
    Var var;
    Exp exp;
  end LAMexp;
  record PRIM1exp
    Prim1 Prim1;
    Exp exp;
  end PRIM1exp;
  record PRIM2exp
    Prim2 Prim21;
    Exp exp2;
    Exp exp3;
  end PRIM2exp;
  record IFexp
    Exp exp1;
    Exp exp2;
    Exp exp3;
  end IFexp;
  record APPexp
    Exp exp1;
    Exp exp2;
  end APPexp;
  record CASEexp
    Exp exp;
    list<CRule> cruleLst;
  end CASEexp;
  record RECexp
    list<tuple<Var, Exp>> tplvarexpLst;
    Exp exp;
  end RECexp;
end Exp;

public type CRule = tuple<Pat, Exp>;

end Absyn;

