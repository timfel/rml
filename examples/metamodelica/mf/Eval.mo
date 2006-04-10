package Eval "eval.rml -- Mini-Freja Evaluator"

public import Absyn;

protected uniontype Value
  record CONSTval
    Absyn.Const const;
  end CONSTval;
  record CLOval
    Env env;
    Absyn.Var var;
    Absyn.Exp exp;
  end CLOval;
  record CONSval
    Value value1;
    Value value2;
  end CONSval;
  record SUSPval
    Env env;
    Absyn.Exp exp;
  end SUSPval;
  record RSUSPval
    lvar<Env> envlvar;
    Absyn.Exp for_ "for RECexp" ;
  end RSUSPval;
end Value;

protected type Env = list<tuple<Absyn.Var, Value>>;


protected function primapp1 
  "Apply a unary strict primop. The argument must be a constant."
  input Absyn.Prim1 inprim1;
  input Absyn.Const inconst;
  output Absyn.Const outconst;
algorithm 
  outconst:=
  matchcontinue (inprim1,inconst)
    local Boolean y,x;
    case (Absyn.NOT(),Absyn.BOOLcnst(x))
      equation 
        y = boolNot(x);
      then
        Absyn.BOOLcnst(y);
    case (Absyn.NEG(),Absyn.INTcnst(x))
      local Integer y,x;
      equation 
        y = -x;
      then
        Absyn.INTcnst(y);
  end matchcontinue;
end primapp1;

protected function primapp2 
  "Apply a binary strict primop. The arguments must be constants."
  input Absyn.Prim2 inprim21;
  input Absyn.Const inconst2;
  input Absyn.Const inconst3;
  output Absyn.Const outconst;
algorithm 
  outconst:=
  matchcontinue (inprim21,inconst2,inconst3)
    local
      Boolean z;
      Integer x,y;
    case (Absyn.LT(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x < y);
      then
        Absyn.BOOLcnst(z);
    case (Absyn.LE(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x <= y);
      then
        Absyn.BOOLcnst(z);
    case (Absyn.EQ(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x == y);
      then
        Absyn.BOOLcnst(z);
    case (Absyn.NE(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x <> y);
      then
        Absyn.BOOLcnst(z);
    case (Absyn.GE(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x >= y);
      then
        Absyn.BOOLcnst(z);
    case (Absyn.GT(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      equation 
        z = (x > y);
      then
        Absyn.BOOLcnst(z);
    case (Absyn.AND(),Absyn.BOOLcnst(x),Absyn.BOOLcnst(y))
      local Boolean x,y;
      equation 
        z = boolAnd(x, y);
      then
        Absyn.BOOLcnst(z);
    case (Absyn.OR(),Absyn.BOOLcnst(x),Absyn.BOOLcnst(y))
      local Boolean x,y;
      equation 
        z = boolOr(x, y);
      then
        Absyn.BOOLcnst(z);
    case (Absyn.ADD(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = x + y;
      then
        Absyn.INTcnst(z);
    case (Absyn.SUB(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = x - y;
      then
        Absyn.INTcnst(z);
    case (Absyn.MUL(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = x*y;
      then
        Absyn.INTcnst(z);
    case (Absyn.DIV(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = x/y;
      then
        Absyn.INTcnst(z);
    case (Absyn.MOD(),Absyn.INTcnst(x),Absyn.INTcnst(y))
      local Integer z;
      equation 
        z = intMod(x, y);
      then
        Absyn.INTcnst(z);
  end matchcontinue;
end primapp2;

protected function lookup 
"Find the most recent binding of an identifier in an environment."
  input Env inenv;
  input Absyn.Var invar;
  output Value outvalue;
algorithm 
  outvalue:=
  matchcontinue (inenv,invar)
    local
      String id,id_1;
      Value v;
      list<tuple<String, Value>> rho;
    case (((id,v) :: _),id_1)
      equation 
        equality(id = id_1);
      then
        v;
    case (((id,_) :: rho),id_1)
      equation 
        failure(equality(id = id_1));
        v = lookup(rho, id_1);
      then
        v;
  end matchcontinue;
end lookup;

protected function newenv 
 "Augment an environment with a set of recursive declarations
  Step 1: construct an uninstantiated reference ptrNewRho
  Step 2: construct newRho: for every declaration (id,exp), push
 	   a binding (id, RSUSPval(ptrNewRho,exp)) onto the old rho
  Step 3: tie the knot by instantiating ptrNewRho to newRho
 
  The force and strict functions automatically dereference these
  rho references."
  input Env inenv;
  input list<tuple<Absyn.Var, Absyn.Exp>> inTplAbsynVarAbsynExpLst;
  input lvar<Env> inenvlvar;
  output Env outenv;
algorithm 
  outenv:=
  matchcontinue (inenv,inTplAbsynVarAbsynExpLst,inenvlvar)
    local
      list<tuple<String, Value>> rho,newRho;
      String id;
      Absyn.Exp exp;
      list<tuple<String, Absyn.Exp>> decls;
      lvar<list<tuple<String, Value>>> ptrNewRho;
    case (rho,{},_) then rho; 
    case (rho,((id,exp) :: decls),ptrNewRho)
      equation 
        newRho = newenv(((id,RSUSPval(ptrNewRho,exp)) :: rho), decls, ptrNewRho);
      then
        newRho;
  end matchcontinue;
end newenv;

protected function recenv
  input Env rho;
  input list<tuple<Absyn.Var, Absyn.Exp>> decls;
  output Env newRho;
  lvar<list<tuple<String, Value>>> ptrNewRho;
algorithm 
  ptrNewRho := lvarNew();
  newRho := newenv(rho, decls, ptrNewRho);
  lvarSet(ptrNewRho, newRho);
end recenv;

protected uniontype MatchResult 
  "Match a pattern with a value. Return augmented environment or error."
  record MYES
    Env env;
  end MYES;
  record MNO end MNO;
end MatchResult;

protected function match_
  input Env inenv;
  input Value invalue;
  input Absyn.Pat inpat;
  output MatchResult outmatchResult;
algorithm 
  outmatchResult:=
  matchcontinue (inenv,invalue,inpat)
    local
      list<tuple<String, Value>> rho;
      Value v,v1,v2;
      String id;
      Absyn.Const c,c_1;
      MatchResult res1,res2;
      Absyn.Pat p1,p2;
    case (rho,v,Absyn.VARpat(id)) then MYES(((id,v) :: rho)); 
    case (rho,CONSTval(c),Absyn.CONSTpat(c_1))
      equation 
        equality(c = c_1);
      then
        MYES(rho);
    case (rho,CONSTval(c),Absyn.CONSTpat(c_1))
      equation 
        failure(equality(c = c_1));
      then
        MNO();
    case (rho,CONSval(v1,v2),Absyn.CONSpat(p1,p2))
      equation 
        res1 = match_(rho, v1, p1);
        res2 = matchCdr(res1, v2, p2);
      then
        res2;
    case (_,CONSTval(_),Absyn.CONSpat(_,_)) then MNO(); 
    case (_,CONSval(_,_),Absyn.CONSTpat(_)) then MNO(); 
  end matchcontinue;
end match_;

protected function matchCdr
  input MatchResult inmatchResult;
  input Value invalue;
  input Absyn.Pat inpat;
  output MatchResult outmatchResult;
algorithm 
  outmatchResult:=
  matchcontinue (inmatchResult,invalue,inpat)
    local
      MatchResult res;
      list<tuple<String, Value>> rho;
      Value v2;
      Absyn.Pat p2;
    case (MYES(rho),v2,p2)
      equation 
        res = match_(rho, v2, p2);
      then
        res;
    case (MNO(),_,_) then MNO();  /* could use AS pattern here */ 
  end matchcontinue;
end matchCdr;

protected function ifChoose 
  "Using result of IF predicate, choose 
   between the alternative expressions"
  input Boolean inBoolean1;
  input Absyn.Exp inexp2;
  input Absyn.Exp inexp3;
  output Absyn.Exp outexp;
algorithm 
  outexp:=
  matchcontinue (inBoolean1,inexp2,inexp3)
    local Absyn.Exp e2,e3;
    case (true,e2,_) then e2; 
    case (false,_,e3) then e3; 
  end matchcontinue;
end ifChoose;

protected function evalCase 
  "Evaluate the expression of the first pattern 
   to match the value. Result in whnf"
  input Env inenv;
  input Value invalue;
  input list<Absyn.CRule> inAbsynCruleLst;
  output Value outvalue;
algorithm 
  outvalue:=
  matchcontinue (inenv,invalue,inAbsynCruleLst)
    local
      MatchResult result;
      Value v_1,v;
      list<tuple<String, Value>> rho;
      Absyn.Pat pat;
      Absyn.Exp exp;
      list<tuple<Absyn.Pat, Absyn.Exp>> rules;
    case (rho,v,((pat,exp) :: rules))
      equation 
        result = match_(rho, v, pat);
        v_1 = caseChoose(result, exp, rho, v, rules);
      then
        v_1;
  end matchcontinue;
end evalCase;

protected function caseChoose
  input MatchResult inmatchResult;
  input Absyn.Exp inexp;
  input Env inenv;
  input Value invalue;
  input list<Absyn.CRule> inAbsynCruleLst;
  output Value outvalue;
algorithm 
  outvalue:=
  matchcontinue (inmatchResult,inexp,inenv,invalue,inAbsynCruleLst)
    local
      Value v_1,v;
      list<tuple<String, Value>> rho_1,rho;
      Absyn.Exp exp;
      list<tuple<Absyn.Pat, Absyn.Exp>> rules;
    case (MYES(rho_1),exp,_,_,_)
      equation 
        v_1 = eval(rho_1, exp);
      then
        v_1;
    case (MNO(),_,rho,v,rules)
      equation 
        v_1 = evalCase(rho, v, rules);
      then
        v_1;
  end matchcontinue;
end caseChoose;

protected function eval 
  "Compute the whnf of an 
   expression in an environment"
  input Env inenv;
  input Absyn.Exp inexp;
  output Value outvalue;
algorithm 
  outvalue:=
  matchcontinue (inenv,inexp)
    local
      Absyn.Const c,c_1,c1,c2,c3;
      Value v,v_1;
      list<tuple<String, Value>> rho,rho_1;
      String id,formal;
      Absyn.Exp e1,e2,exp,e,e3,body,f,arg;
      list<tuple<Absyn.Pat, Absyn.Exp>> rules;
      Absyn.Prim1 p;
      Boolean flag;
      list<tuple<String, Absyn.Exp>> d;
    case (_,Absyn.CONSTexp(c)) then CONSTval(c); 
    case (rho,Absyn.VARexp(id))
      equation 
        v = lookup(rho, id);
        v_1 = force(v);
      then
        v_1;
    case (rho,Absyn.CONSexp(e1,e2)) then CONSval(SUSPval(rho,e1),SUSPval(rho,e2)); 
    case (rho,Absyn.LAMexp(id,exp)) then CLOval(rho,id,exp); 
    case (rho,Absyn.CASEexp(e,rules))
      equation 
        v = eval(rho, e);
        v_1 = evalCase(rho, v, rules);
      then
        v_1;
    case (rho,Absyn.PRIM1exp(p,e))
      equation 
        CONSTval(c) = eval(rho, e);
        c_1 = primapp1(p, c);
      then
        CONSTval(c_1);
    case (rho,Absyn.PRIM2exp(p,e1,e2))
      local Absyn.Prim2 p;
      equation 
        CONSTval(c1) = eval(rho, e1);
        CONSTval(c2) = eval(rho, e2);
        c3 = primapp2(p, c1, c2);
      then
        CONSTval(c3);
    case (rho,Absyn.IFexp(e1,e2,e3))
      equation 
        CONSTval(Absyn.BOOLcnst(flag)) = eval(rho, e1);
        e = ifChoose(flag, e2, e3);
        v = eval(rho, e);
      then
        v;
    case (rho,Absyn.APPexp(f,arg))
      equation 
        CLOval(rho_1,formal,body) = eval(rho, f);
        v = eval(((formal,SUSPval(rho,arg)) :: rho_1), body);
      then
        v;
    case (rho,Absyn.RECexp(d,e))
      equation 
        rho_1 = recenv(rho, d);
        v = eval(rho_1, e);
      then
        v;
  end matchcontinue;
end eval;

protected function force "Force a value to be in whnf"
  input Value invalue;
  output Value outvalue;
algorithm 
  outvalue:=
  matchcontinue (invalue)
    local
      Value v,v_1;
      list<tuple<String, Value>> rho;
      Absyn.Exp exp;
      lvar<list<tuple<String, Value>>> ptrRho;
    case ((v as CONSTval(_))) then v; 
    case ((v as CLOval(_,_,_))) then v; 
    case ((v as CONSval(_,_))) then v; 
    case SUSPval(rho,exp)
      equation 
        v = eval(rho, exp);
        v_1 = force(v);
      then
        v_1;
    case RSUSPval(ptrRho,exp)
      equation 
        SOME(rho) = lvarGet(ptrRho);
        v = eval(rho, exp) "fails is still unbound" ;
        v_1 = force(v);
      then
        v_1;
  end matchcontinue;
end force;

protected function strict "Force a value to be fully evaluated"
  input Value invalue;
  output Value outvalue;
algorithm 
  outvalue:=
  matchcontinue (invalue)
    local
      Value v,v1_1,v2_1,v1,v2,v_1;
      list<tuple<String, Value>> rho;
      Absyn.Exp exp;
      lvar<list<tuple<String, Value>>> ptrRho;
    case ((v as CONSTval(_))) then v; 
    case ((v as CLOval(_,_,_))) then v; 
    case CONSval(v1,v2)
      equation 
        v1_1 = strict(v1);
        v2_1 = strict(v2);
      then
        CONSval(v1_1,v2_1);
    case SUSPval(rho,exp)
      equation 
        v = eval(rho, exp);
        v_1 = strict(v);
      then
        v_1;
    case RSUSPval(ptrRho,exp)
      equation 
        SOME(rho) = lvarGet(ptrRho);
        v = eval(rho, exp) "fails if still unbound" ;
        v_1 = strict(v);
      then
        v_1;
  end matchcontinue;
end strict;

protected function boolString "print a strict value"
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
  input Absyn.Const inconst;
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
        print(s);
      then
        ();
    case (Absyn.BOOLcnst(b))
      equation 
        s = boolString(b);
        print(s);
      then
        ();
    case (Absyn.NILcnst())
      equation 
        print("[]");
      then
        ();
  end matchcontinue;
end printConst;

protected function printValue
  input Value invalue;
algorithm 
  _:=
  matchcontinue (invalue)
    local
      Absyn.Const c;
      Value car,cdr;
    case (CONSTval(c))
      equation 
        printConst(c);
      then
        ();
    case (CLOval(_,_,_))
      equation 
        print("<closure>");
      then
        ();
    case (CONSval(car,cdr))
      equation 
        printValue(car);
        print("::");
        printValue(cdr);
      then
        ();
  end matchcontinue;
end printValue;

public function exec "Evaluate an expression and print the result"
  input Absyn.Exp e;
  Value v,v_1;
algorithm 
  v := eval({}, e);
  v_1 := strict(v);
  printValue(v_1);
  print("\n");
end exec;
end Eval;

