package Eval

public import Absyn.*;

protected 
type envlvar = lvar<env>;

uniontype value
  record CONSTval
    Absyn.const const;
  end CONSTval;

  record CLOval
    env env;
    Absyn.var var;
    Absyn.exp exp;
  end CLOval;

  record CONSval
    value value1;
    value value2;
  end CONSval;

  record SUSPval
    env env;
    Absyn.exp exp;
  end SUSPval;

  record RSUSPval
    envlvar envlvar;
    Absyn.exp exp;
  end RSUSPval;

end value;

protected function primapp1
  input Absyn.prim1 inprim1;
  input Absyn.const inconst;
  output Absyn.const outconst;
algorithm 
  outconst:=
  matchcontinue (inprim1,inconst)
    local Boolean y,x;
    case (Absyn.NOT(),Absyn.BOOLcnst(x))
      equation 
        y = boolNot(x); then Absyn.BOOLcnst(y);
    case (Absyn.NEG(),Absyn.INTcnst(x))
      local Integer y,x;
      equation 
        y = -x; then Absyn.INTcnst(y);
  end matchcontinue;
end primapp1;

protected function primapp2
  input Absyn.prim2 inprim21;
  input Absyn.const inconst2;
  input Absyn.const inconst3;
  output Absyn.const outconst;
algorithm 
  outconst:=
  matchcontinue (inprim21,inconst2,inconst3)
    local
      Boolean z;
      Integer x,y;
    case (Absyn.LT(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x < y); then Absyn.BOOLcnst(z);
    case (Absyn.LE(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x <= y); then Absyn.BOOLcnst(z);
    case (Absyn.EQ(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x == y); then Absyn.BOOLcnst(z);
    case (Absyn.NE(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x <> y); then Absyn.BOOLcnst(z);
    case (Absyn.GE(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x >= y); then Absyn.BOOLcnst(z);
    case (Absyn.GT(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x > y); then Absyn.BOOLcnst(z);
    case (Absyn.AND(),Absyn.BOOLcnst(x),Absyn.BOOLcnst(y))
      local Boolean x,y;
      equation 
        z = boolAnd(x, y); then Absyn.BOOLcnst(z);
    case (Absyn.OR(),Absyn.BOOLcnst(x),Absyn.BOOLcnst(y))
      local Boolean x,y;
      equation 
        z = boolOr(x, y); then Absyn.BOOLcnst(z);
    case (Absyn.ADD(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = x + y; then Absyn.INTcnst(z);
    case (Absyn.SUB(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = x - y; then Absyn.INTcnst(z);
    case (Absyn.MUL(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = x*y; then Absyn.INTcnst(z);
    case (Absyn.DIV(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = x/y; then Absyn.INTcnst(z);
    case (Absyn.MOD(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = intMod(x, y); then Absyn.INTcnst(z);
  end matchcontinue;
end primapp2;

protected function lookup
  input env inenv;
  input Absyn.var invar;
  output value outvalue;
algorithm 
  outvalue:=
  matchcontinue (inenv,invar)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      String id,id_1;
      value v;
      TplStringvalueLst rho;
    case ((id,v) :: _,id_1)
      equation 
        equality(id = id_1); then v;
    case ((id,_) :: rho,id_1)
      equation 
        failure(equality(id = id_1));
        v = lookup(rho, id_1); then v;
  end matchcontinue;
end lookup;

protected function newenv
  input env inenv;
  input TplAbsyn_varAbsyn_expLst inTplAbsynVarAbsynExpLst;
  input envlvar inenvlvar;
  output env outenv;
  type TplAbsyn_varAbsyn_exp = tuple<Absyn.var,Absyn.exp>;
  type TplAbsyn_varAbsyn_expLst = list<TplAbsyn_varAbsyn_exp>;
algorithm 
  outenv:=
  matchcontinue (inenv,inTplAbsynVarAbsynExpLst,inenvlvar)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      type TplStringAbsyn_exp = tuple<String,Absyn.exp>;
      type TplStringAbsyn_expLst = list<TplStringAbsyn_exp>;
      type TplStringvalueLstlvar = lvar<TplStringvalueLst>;
      TplStringvalueLst rho,newRho;
      String id;
      Absyn.exp exp;
      TplStringAbsyn_expLst decls;
      TplStringvalueLstlvar ptrNewRho;
    case (rho,{},_) then rho; 
    case (rho,(id,exp) :: decls,ptrNewRho)
      equation 
        newRho = newenv((id,RSUSPval(ptrNewRho,exp)) :: rho, decls, ptrNewRho); then newRho;
  end matchcontinue;
end newenv;

protected function recenv
  input env rho;
  input TplAbsyn_varAbsyn_expLst decls;
  output env newRho;
  type TplAbsyn_varAbsyn_exp = tuple<Absyn.var,Absyn.exp>;
  type TplAbsyn_varAbsyn_expLst = list<TplAbsyn_varAbsyn_exp>;
  type TplStringvalue = tuple<String,value>;
  type TplStringvalueLst = list<TplStringvalue>;
  type TplStringvalueLstlvar = lvar<TplStringvalueLst>;
  TplStringvalueLstlvar ptrNewRho;
algorithm 
  ptrNewRho := lvarNew();
  newRho := newenv(rho, decls, ptrNewRho);
  lvarSet(ptrNewRho, newRho);
end recenv;

protected 
uniontype match_result
  record MYES
    env env;
  end MYES;

  record MNO end MNO;

end match_result;

protected function match_
  input env inenv;
  input value invalue;
  input Absyn.pat inpat;
  output match_result outmatchResult;
algorithm 
  outmatchResult:=
  matchcontinue (inenv,invalue,inpat)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      TplStringvalueLst rho;
      value v,v1,v2;
      String id;
      Absyn.const c,c_1;
      match_result res1,res2;
      Absyn.pat p1,p2;
    case (rho,v,Absyn.VARpat(id)) then MYES((id,v) :: rho); 
    case (rho,CONSTval(c),Absyn.CONSTpat(c_1))
      equation 
        equality(c = c_1); then MYES(rho);
    case (rho,CONSTval(c),Absyn.CONSTpat(c_1))
      equation 
        failure(equality(c = c_1)); then MNO();
    case (rho,CONSval(v1,v2),Absyn.CONSpat(p1,p2))
      equation 
        res1 = match_(rho, v1, p1);
        res2 = matchCdr(res1, v2, p2); then res2;
    case (_,CONSTval(_),Absyn.CONSpat(_,_)) then MNO(); 
    case (_,CONSval(_,_),Absyn.CONSTpat(_)) then MNO(); 
  end matchcontinue;
end match_;

protected function matchCdr
  input match_result inmatchResult;
  input value invalue;
  input Absyn.pat inpat;
  output match_result outmatchResult;
algorithm 
  outmatchResult:=
  matchcontinue (inmatchResult,invalue,inpat)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      match_result res;
      TplStringvalueLst rho;
      value v2;
      Absyn.pat p2;
    case (MYES(rho),v2,p2)
      equation 
        res = match_(rho, v2, p2); then res;
    case (MNO(),_,_) then MNO(); 
  end matchcontinue;
end matchCdr;

protected function ifChoose
  input Boolean inBoolean1;
  input Absyn.exp inexp2;
  input Absyn.exp inexp3;
  output Absyn.exp outexp;
algorithm 
  outexp:=
  matchcontinue (inBoolean1,inexp2,inexp3)
    local Absyn.exp e2,e3;
    case (true,e2,_) then e2; 
    case (false,_,e3) then e3; 
  end matchcontinue;
end ifChoose;

protected function evalCase
  input env inenv;
  input value invalue;
  input Absyn_cruleLst inAbsynCruleLst;
  output value outvalue;
  type Absyn_cruleLst = list<Absyn.crule>;
algorithm 
  outvalue:=
  matchcontinue (inenv,invalue,inAbsynCruleLst)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      type TplAbsyn_patAbsyn_exp = tuple<Absyn.pat,Absyn.exp>;
      type TplAbsyn_patAbsyn_expLst = list<TplAbsyn_patAbsyn_exp>;
      match_result result;
      value v_1,v;
      TplStringvalueLst rho;
      Absyn.pat pat;
      Absyn.exp exp;
      TplAbsyn_patAbsyn_expLst rules;
    case (rho,v,(pat,exp) :: rules)
      equation 
        result = match_(rho, v, pat);
        v_1 = caseChoose(result, exp, rho, v, rules); then v_1;
  end matchcontinue;
end evalCase;

protected function caseChoose
  input match_result inmatchResult;
  input Absyn.exp inexp;
  input env inenv;
  input value invalue;
  input Absyn_cruleLst inAbsynCruleLst;
  output value outvalue;
  type Absyn_cruleLst = list<Absyn.crule>;
algorithm 
  outvalue:=
  matchcontinue (inmatchResult,inexp,inenv,invalue,inAbsynCruleLst)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      type TplAbsyn_patAbsyn_exp = tuple<Absyn.pat,Absyn.exp>;
      type TplAbsyn_patAbsyn_expLst = list<TplAbsyn_patAbsyn_exp>;
      value v_1,v;
      TplStringvalueLst rho_1,rho;
      Absyn.exp exp;
      TplAbsyn_patAbsyn_expLst rules;
    case (MYES(rho_1),exp,_,_,_)
      equation 
        v_1 = eval(rho_1, exp); then v_1;
    case (MNO(),_,rho,v,rules)
      equation 
        v_1 = evalCase(rho, v, rules); then v_1;
  end matchcontinue;
end caseChoose;

protected function eval
  input env inenv;
  input Absyn.exp inexp;
  output value outvalue;
algorithm 
  outvalue:=
  matchcontinue (inenv,inexp)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      type TplAbsyn_patAbsyn_exp = tuple<Absyn.pat,Absyn.exp>;
      type TplAbsyn_patAbsyn_expLst = list<TplAbsyn_patAbsyn_exp>;
      type TplStringAbsyn_exp = tuple<String,Absyn.exp>;
      type TplStringAbsyn_expLst = list<TplStringAbsyn_exp>;
      Absyn.const c,c_1,c1,c2,c3;
      value v,v_1;
      TplStringvalueLst rho,rho_1;
      String id,formal;
      Absyn.exp e1,e2,exp,e,e3,body,f,arg;
      TplAbsyn_patAbsyn_expLst rules;
      Absyn.prim1 p;
      Boolean flag;
      TplStringAbsyn_expLst d;
    case (_,Absyn.CONSTexp(c)) then CONSTval(c); 
    case (rho,Absyn.VARexp(id))
      equation 
        v = lookup(rho, id);
        v_1 = force(v); then v_1;
    case (rho,Absyn.CONSexp(e1,e2)) then CONSval(SUSPval(rho,e1),SUSPval(rho,e2)); 
    case (rho,Absyn.LAMexp(id,exp)) then CLOval(rho,id,exp); 
    case (rho,Absyn.CASEexp(e,rules))
      equation 
        v = eval(rho, e);
        v_1 = evalCase(rho, v, rules); then v_1;
    case (rho,Absyn.PRIM1exp(p,e))
      equation 
        CONSTval(c) = eval(rho, e);
        c_1 = primapp1(p, c); then CONSTval(c_1);
    case (rho,Absyn.PRIM2exp(p,e1,e2))
      local Absyn.prim2 p;
      equation 
        CONSTval(c1) = eval(rho, e1);
        CONSTval(c2) = eval(rho, e2);
        c3 = primapp2(p, c1, c2); then CONSTval(c3);
    case (rho,Absyn.IFexp(e1,e2,e3))
      equation 
        CONSTval(Absyn.BOOLcnst(flag)) = eval(rho, e1);
        e = ifChoose(flag, e2, e3);
        v = eval(rho, e); then v;
    case (rho,Absyn.APPexp(f,arg))
      equation 
        CLOval(rho_1,formal,body) = eval(rho, f);
        v = eval((formal,SUSPval(rho,arg)) :: rho_1, body); then v;
    case (rho,Absyn.RECexp(d,e))
      equation 
        rho_1 = recenv(rho, d);
        v = eval(rho_1, e); then v;
  end matchcontinue;
end eval;

protected function force
  input value invalue;
  output value outvalue;
algorithm 
  outvalue:=
  matchcontinue (invalue)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      type TplStringvalueLstlvar = lvar<TplStringvalueLst>;
      value v,v_1;
      TplStringvalueLst rho;
      Absyn.exp exp;
      TplStringvalueLstlvar ptrRho;
    case ((v as CONSTval(_))) then v; 
    case ((v as CLOval(_,_,_))) then v; 
    case ((v as CONSval(_,_))) then v; 
    case SUSPval(rho,exp)
      equation 
        v = eval(rho, exp);
        v_1 = force(v); then v_1;
    case RSUSPval(ptrRho,exp)
      equation 
        SOME(rho) = lvarGet(ptrRho);
        v = eval(rho, exp);
        v_1 = force(v); then v_1;
  end matchcontinue;
end force;

protected function strict
  input value invalue;
  output value outvalue;
algorithm 
  outvalue:=
  matchcontinue (invalue)
    local
      type TplStringvalue = tuple<String,value>;
      type TplStringvalueLst = list<TplStringvalue>;
      type TplStringvalueLstlvar = lvar<TplStringvalueLst>;
      value v,v1_1,v2_1,v1,v2,v_1;
      TplStringvalueLst rho;
      Absyn.exp exp;
      TplStringvalueLstlvar ptrRho;
    case ((v as CONSTval(_))) then v; 
    case ((v as CLOval(_,_,_))) then v; 
    case CONSval(v1,v2)
      equation 
        v1_1 = strict(v1);
        v2_1 = strict(v2); then CONSval(v1_1,v2_1);
    case SUSPval(rho,exp)
      equation 
        v = eval(rho, exp);
        v_1 = strict(v); then v_1;
    case RSUSPval(ptrRho,exp)
      equation 
        SOME(rho) = lvarGet(ptrRho);
        v = eval(rho, exp);
        v_1 = strict(v); then v_1;
  end matchcontinue;
end strict;

protected function boolString
  input Boolean inBoolean;
  output String outString;
algorithm 
  outString:=
  matchcontinue (inBoolean)
    case true then "true"; 
    case false then "false"; 
  end matchcontinue;
end boolString;

protected function printConst
  input Absyn.const inconst;
algorithm 
  _:=
  matchcontinue (inconst)
    local
      String s;
      Integer i;
      Boolean b;
    case (Absyn.INTcnst(i))
      equation 
        s = intString(i);
        print(s); then ();
    case (Absyn.BOOLcnst(b))
      equation 
        s = boolString(b);
        print(s); then ();
    case (Absyn.NILcnst())
      equation 
        print("[]"); then ();
  end matchcontinue;
end printConst;

protected function printValue
  input value invalue;
algorithm 
  _:=
  matchcontinue (invalue)
    local
      Absyn.const c;
      value car,cdr;
    case (CONSTval(c))
      equation 
        printConst(c); then ();
    case (CLOval(_,_,_))
      equation 
        print("<closure>"); then ();
    case (CONSval(car,cdr))
      equation 
        printValue(car);
        print("::");
        printValue(cdr); then ();
  end matchcontinue;
end printValue;

public function exec
  input Absyn.exp e;
  value v,v_1;
algorithm 
  v := eval({}, e);
  v_1 := strict(v);
  printValue(v_1);
  print("\n");
end exec;
end Eval;

