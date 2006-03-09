package Eval " eval.rml -- Mini-Freja Evaluator "
import absyn;

type envlvar = lvar<env>;

uniontype value
  record CONSTval
    Absyn.const_ x1;
  end CONSTval;
  record CLOval
    env x1;
    Absyn.var x2;
    Absyn.exp x3;
  end CLOval;
  record CONSval
    value x1;
    value x2;
  end CONSval;
  record SUSPval
    env x1;
    Absyn.exp x2;
  end SUSPval;
  record RSUSPval
    envlvar x1;
    Absyn.exp x2 " for RECexp ";
  end RSUSPval;
end value;

type TupleAbsynvarvalue = tuple<Absynvar,value>;

type env = list<TupleAbsynvarvalue>;

protected function primapp1 " Apply a unary strict primop. The argument must be a constant. "
  input Absyn.prim1 in_prim1;
  input Absyn.const_ in_const_;
  output Absyn.const_ out_const_;
algorithm 
  out_const_:=
  matchcontinue (in_prim1,in_const_)
    local Boolean y,x;
    case (Absyn.NOT(),Absyn.BOOLcnst(x))
      equation 
        y = bool_not(x); then Absyn.BOOLcnst(y);
    case (Absyn.NEG(),Absyn.INTcnst(x))
      local Integer y,x;
      equation 
        y = -x; then Absyn.INTcnst(y);
  end matchcontinue;
end primapp1;

protected function primapp2 " Apply a binary strict primop. The arguments must be constants. "
  input Absyn.prim2 in_prim21;
  input Absyn.const_ in_const_2;
  input Absyn.const_ in_const_3;
  output Absyn.const_ out_const_;
algorithm 
  out_const_:=
  matchcontinue (in_prim21,in_const_2,in_const_3)
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
        z = bool_and(x, y); then Absyn.BOOLcnst(z);
    case (Absyn.OR(),Absyn.BOOLcnst(x),Absyn.BOOLcnst(y))
      local Boolean x,y;
      equation 
        z = bool_or(x, y); then Absyn.BOOLcnst(z);
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
        z = int_mod(x, y); then Absyn.INTcnst(z);
  end matchcontinue;
end primapp2;

protected function lookup " Find the most recent binding of an identifier in an environment. "
  input env in_env;
  input Absyn.var in_var;
  output value out_value;
algorithm 
  out_value:=
  matchcontinue (in_env,in_var)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      String id,id_1;
      value v;
      TupleStringvalueList rho;
    case ((id,v) :: _,id_1)
      equation 
        equality(id = id_1); then v;
    case ((id,_) :: rho,id_1)
      equation 
        failure(equality(id = id_1));
        v = lookup(rho, id_1); then v;
  end matchcontinue;
end lookup;

protected function newenv " Augment an environment with a set of recursive declarations
 * Step 1: construct an uninstantiated reference ptrNewRho
 * Step 2: construct newRho: for every declaration (id,exp), push
 *	   a binding (id, RSUSPval(ptrNewRho,exp)) onto the old rho
 * Step 3: tie the knot by instantiating ptrNewRho to newRho
 *
 * The force and strict functions automatically dereference these
 * rho references.
 "
  input env in_env;
  input TupleAbsynvarAbsynexpList in_tupleabsynvarabsynexplist;
  input envlvar in_envlvar;
  output env out_env;
protected 
  type TupleAbsynvarAbsynexp = tuple<Absynvar,Absynexp>;
  type TupleAbsynvarAbsynexpList = list<TupleAbsynvarAbsynexp>;
algorithm 
  out_env:=
  matchcontinue (in_env,in_tupleabsynvarabsynexplist,in_envlvar)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      type TupleStringAbsynexp = tuple<String,Absynexp>;
      type TupleStringAbsynexpList = list<TupleStringAbsynexp>;
      type TupleStringvalueListlvar = lvar<TupleStringvalueList>;
      TupleStringvalueList rho,newRho;
      String id;
      Absyn.exp exp;
      TupleStringAbsynexpList decls;
      TupleStringvalueListlvar ptrNewRho;
    case (rho,{},_) then rho; 
    case (rho,(id,exp) :: decls,ptrNewRho)
      equation 
        newRho = newenv((id,RSUSPval(ptrNewRho,exp)) :: rho, decls, ptrNewRho); then newRho;
  end matchcontinue;
end newenv;

protected function recenv
  input env rho;
  input TupleAbsynvarAbsynexpList decls;
  output env newRho;
protected 
  type TupleAbsynvarAbsynexp = tuple<Absynvar,Absynexp>;
  type TupleAbsynvarAbsynexpList = list<TupleAbsynvarAbsynexp>;
  type TupleStringvalue = tuple<String,value>;
  type TupleStringvalueList = list<TupleStringvalue>;
  type TupleStringvalueListlvar = lvar<TupleStringvalueList>;
  TupleStringvalueListlvar ptrNewRho;
algorithm 
  ptrNewRho := lvar_new();
  newRho := newenv(rho, decls, ptrNewRho);
  lvar_set(ptrNewRho, newRho);
end recenv;

uniontype match_result " Match a pattern with a value. Return augmented environment or error. "
  record MYES
    env x1;
  end MYES;
  record MNO
  end MNO;
end match_result;

protected function match
  input env in_env;
  input value in_value;
  input Absyn.pat in_pat;
  output match_result out_match_result;
algorithm 
  out_match_result:=
  matchcontinue (in_env,in_value,in_pat)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      TupleStringvalueList rho;
      value v,v1,v2;
      String id;
      Absyn.const_ c,c_1;
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
        res1 = match(rho, v1, p1);
        res2 = match_cdr(res1, v2, p2); then res2;
    case (_,CONSTval(_),Absyn.CONSpat(_,_)) then MNO(); 
    case (_,CONSval(_,_),Absyn.CONSTpat(_)) then MNO(); 
  end matchcontinue;
end match;

protected function match_cdr
  input match_result in_match_result;
  input value in_value;
  input Absyn.pat in_pat;
  output match_result out_match_result;
algorithm 
  out_match_result:=
  matchcontinue (in_match_result,in_value,in_pat)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      match_result res;
      TupleStringvalueList rho;
      value v2;
      Absyn.pat p2;
    case (MYES(rho),v2,p2)
      equation 
        res = match(rho, v2, p2); then res;
    case (MNO(),_,_) then MNO();  " could use AS pattern here "
  end matchcontinue;
end match_cdr;

protected function if_choose " Using result of IF predicate, choose between the alternative expressions "
  input Boolean in_boolean1;
  input Absyn.exp in_exp2;
  input Absyn.exp in_exp3;
  output Absyn.exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_boolean1,in_exp2,in_exp3)
    local Absyn.exp e2,e3;
    case (true,e2,_) then e2; 
    case (false,_,e3) then e3; 
  end matchcontinue;
end if_choose;

protected function eval_case " Evaluate the expression of the first pattern to match the value. Result in whnf "
  input env in_env;
  input value in_value;
  input AbsyncruleList in_absyncrulelist;
  output value out_value;
protected 
  type AbsyncruleList = list<Absyn.crule>;
algorithm 
  out_value:=
  matchcontinue (in_env,in_value,in_absyncrulelist)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      type TupleAbsynpatAbsynexp = tuple<Absynpat,Absynexp>;
      type TupleAbsynpatAbsynexpList = list<TupleAbsynpatAbsynexp>;
      match_result result;
      value v_1,v;
      TupleStringvalueList rho;
      Absyn.pat pat;
      Absyn.exp exp;
      TupleAbsynpatAbsynexpList rules;
    case (rho,v,(pat,exp) :: rules)
      equation 
        result = match(rho, v, pat);
        v_1 = case_choose(result, exp, rho, v, rules); then v_1;
  end matchcontinue;
end eval_case;

protected function case_choose
  input match_result in_match_result;
  input Absyn.exp in_exp;
  input env in_env;
  input value in_value;
  input AbsyncruleList in_absyncrulelist;
  output value out_value;
protected 
  type AbsyncruleList = list<Absyn.crule>;
algorithm 
  out_value:=
  matchcontinue (in_match_result,in_exp,in_env,in_value,in_absyncrulelist)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      type TupleAbsynpatAbsynexp = tuple<Absynpat,Absynexp>;
      type TupleAbsynpatAbsynexpList = list<TupleAbsynpatAbsynexp>;
      value v_1,v;
      TupleStringvalueList rho_1,rho;
      Absyn.exp exp;
      TupleAbsynpatAbsynexpList rules;
    case (MYES(rho_1),exp,_,_,_)
      equation 
        v_1 = eval(rho_1, exp); then v_1;
    case (MNO(),_,rho,v,rules)
      equation 
        v_1 = eval_case(rho, v, rules); then v_1;
  end matchcontinue;
end case_choose;

protected function eval " Compute the whnf of an expression in an environment "
  input env in_env;
  input Absyn.exp in_exp;
  output value out_value;
algorithm 
  out_value:=
  matchcontinue (in_env,in_exp)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      type TupleAbsynpatAbsynexp = tuple<Absynpat,Absynexp>;
      type TupleAbsynpatAbsynexpList = list<TupleAbsynpatAbsynexp>;
      type TupleStringAbsynexp = tuple<String,Absynexp>;
      type TupleStringAbsynexpList = list<TupleStringAbsynexp>;
      Absyn.const_ c,c_1,c1,c2,c3;
      value v,v_1;
      TupleStringvalueList rho,rho_1;
      String id,formal;
      Absyn.exp e1,e2,exp,e,e3,body,f,arg;
      TupleAbsynpatAbsynexpList rules;
      Absyn.prim1 p;
      Boolean flag;
      TupleStringAbsynexpList d;
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
        v_1 = eval_case(rho, v, rules); then v_1;
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
        e = if_choose(flag, e2, e3);
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

protected function force " Force a value to be in whnf "
  input value in_value;
  output value out_value;
algorithm 
  out_value:=
  matchcontinue (in_value)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      type TupleStringvalueListlvar = lvar<TupleStringvalueList>;
      value v,v_1;
      TupleStringvalueList rho;
      Absyn.exp exp;
      TupleStringvalueListlvar ptrRho;
    case ((v = CONSTval(_))) then v; 
    case ((v = CLOval(_,_,_))) then v; 
    case ((v = CONSval(_,_))) then v; 
    case SUSPval(rho,exp)
      equation 
        v = eval(rho, exp);
        v_1 = force(v); then v_1;
    case RSUSPval(ptrRho,exp)
      equation 
        SOME(rho) = lvar_get(ptrRho);
        v = eval(rho, exp) " fails is still unbound ";
        v_1 = force(v); then v_1;
  end matchcontinue;
end force;

protected function strict " Force a value to be fully evaluated "
  input value in_value;
  output value out_value;
algorithm 
  out_value:=
  matchcontinue (in_value)
    local
      type TupleStringvalue = tuple<String,value>;
      type TupleStringvalueList = list<TupleStringvalue>;
      type TupleStringvalueListlvar = lvar<TupleStringvalueList>;
      value v,v1_1,v2_1,v1,v2,v_1;
      TupleStringvalueList rho;
      Absyn.exp exp;
      TupleStringvalueListlvar ptrRho;
    case ((v = CONSTval(_))) then v; 
    case ((v = CLOval(_,_,_))) then v; 
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
        SOME(rho) = lvar_get(ptrRho);
        v = eval(rho, exp) " fails if still unbound ";
        v_1 = strict(v); then v_1;
  end matchcontinue;
end strict;

protected function bool_string " print a strict value "
  input Boolean in_boolean;
  output String out_string;
algorithm 
  out_string:=
  matchcontinue (in_boolean)
    case true then "true"; 
    case false then "false"; 
  end matchcontinue;
end bool_string;

protected function print_const
  input Absyn.const_ in_const_;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_const_)
    local
      String s;
      Integer i;
      Boolean b;
    case (Absyn.INTcnst(i))
      equation 
        s = int_string(i);
        print(s); then true;
    case (Absyn.BOOLcnst(b))
      equation 
        s = bool_string(b);
        print(s); then true;
    case (Absyn.NILcnst())
      equation 
        print("[]"); then true;
  end matchcontinue;
end print_const;

protected function print_value
  input value in_value;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_value)
    local
      Absyn.const_ c;
      value car,cdr;
    case (CONSTval(c))
      equation 
        print_const(c); then true;
    case (CLOval(_,_,_))
      equation 
        print("<closure>"); then true;
    case (CONSval(car,cdr))
      equation 
        print_value(car);
        print("::");
        print_value(cdr); then true;
  end matchcontinue;
end print_value;

public function exec " Evaluate an expression and print the result "
  input Absyn.exp e;
protected 
  value v,v_1;
algorithm 
  v := eval({}, e);
  v_1 := strict(v);
  print_value(v_1);
  print("\n");
end exec;
end Eval;

