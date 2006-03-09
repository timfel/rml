package Static " static.rml "
import absyn;
import scheme;

type TupleStringSchemeScheme = tuple<String,SchemeScheme>;

type Env = list<TupleStringSchemeScheme>;
import util;
import types;
import unify;
constant TypesType tyINT=Types.CONS({},"int");
constant TypesType tyREAL=Types.CONS({},"real");
constant TypesType tySTRING=Types.CONS({},"string");
constant TypesType tyBOOL=Types.CONS({},"bool");
constant TypesType tyUNIT=Types.CONS({},"unit");
constant SchemeComb qunit=Scheme.QUOTE(tyUNIT);
constant SchemeComb qbool=Scheme.QUOTE(tyBOOL);

replaceable type Type_a;

type VType_aOption = Option<Type_a>;

type TupleBooleanVType_aOption = tuple<Boolean,VType_aOption>;
constant TupleBooleanVType_aOption bv_free=(false,NONE);
constant SchemeComb alpha=Scheme.BOUND(0);
constant SchemeComb beta=Scheme.BOUND(1);
constant SchemeComb alphaRef=Scheme.MKCONS(list(alpha),"ref");
constant SchemeComb alphaXbeta=Scheme.MKCONS(list(alpha,beta),"*");
constant SchemeComb alphaList=Scheme.MKCONS(list(alpha),"list");
constant TypesType intXint=Types.CONS(list(tyINT,tyINT),"*");
constant TypesType intXintTOint=Types.CONS(list(intXint,tyINT),"->");
constant SchemeScheme scheme_intXintTOint=Scheme.SCHEME({},Scheme.QUOTE(intXintTOint));
constant SchemeScheme scheme_numXnumTOnum=Scheme.SCHEME(list((false,SOME(list("int","real")))),
          Scheme.MKCONS(list(Scheme.MKCONS(list(alpha,alpha),"*"),alpha),"->"));
constant SchemeScheme scheme_numXnumTObool=Scheme.SCHEME(list((false,SOME(list("int","real")))),
          Scheme.MKCONS(list(Scheme.MKCONS(list(alpha,alpha),"*"),qbool),"->"));
constant SchemeScheme scheme_realXrealTOreal=Scheme.SCHEME({},
          Scheme.QUOTE(
          Types.CONS(list(Types.CONS(list(tyREAL,tyREAL),"*"),tyREAL),"->")));
constant SchemeScheme scheme_eqalphaXeqalphaTObool=Scheme.SCHEME(list((true,NONE)),
          Scheme.MKCONS(list(Scheme.MKCONS(list(alpha,alpha),"*"),qbool),"->"));
constant Env env0=list(("=",scheme_eqalphaXeqalphaTObool),
          ("ref",
          Scheme.SCHEME(list(bv_free),Scheme.MKCONS(list(alpha,alphaRef),"->"))),
          ("!",
          Scheme.SCHEME(list(bv_free),Scheme.MKCONS(list(alphaRef,alpha),"->"))),
          (":=",
          Scheme.SCHEME(list(bv_free),
          Scheme.MKCONS(list(Scheme.MKCONS(list(alphaRef,alpha),"*"),qunit),"->"))),
          ("fst",
          Scheme.SCHEME(list(bv_free,bv_free),
          Scheme.MKCONS(list(alphaXbeta,alpha),"->"))),
          ("snd",
          Scheme.SCHEME(list(bv_free,bv_free),
          Scheme.MKCONS(list(alphaXbeta,beta),"->"))),("true",Scheme.SCHEME({},qbool)),("false",Scheme.SCHEME({},qbool)),
          ("null",
          Scheme.SCHEME(list(bv_free),Scheme.MKCONS(list(alphaList,qbool),"->"))),
          ("hd",
          Scheme.SCHEME(list(bv_free),Scheme.MKCONS(list(alphaList,alpha),"->"))),
          ("tl",
          Scheme.SCHEME(list(bv_free),Scheme.MKCONS(list(alphaList,alphaList),"->"))),("nil",Scheme.SCHEME(list(bv_free),alphaList)),
          ("::",
          Scheme.SCHEME(list(bv_free),
          Scheme.MKCONS(list(Scheme.MKCONS(list(alpha,alphaList),"*"),alphaList),
          "->"))),("+",scheme_numXnumTOnum),("-",scheme_numXnumTOnum),
          ("*",scheme_numXnumTOnum),("idiv",scheme_intXintTOint),("imod",scheme_intXintTOint),
          ("/",scheme_realXrealTOreal),("<",scheme_numXnumTObool),("<=",scheme_numXnumTObool),
          ("print",
          Scheme.SCHEME(list((false,SOME(list("int","real","bool","string")))),
          Scheme.MKCONS(list(alpha,qunit),"->"))));

protected function pure
  input Absyn.Exp in_exp;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_exp)
    local Absyn.Exp e1,e2,e3;
    case (Absyn.INT(_)) then true; 
    case (Absyn.REAL(_)) then true; 
    case (Absyn.STRING(_)) then true; 
    case (Absyn.UNIT()) then true; 
    case (Absyn.VAR(_)) then true; 
    case (Absyn.LAM(_)) then true; 
    case (Absyn.PAIR(e1,e2))
      equation 
        pure(e1);
        pure(e2); then true;
    case (Absyn.IF(e1,e2,e3))
      equation 
        pure(e1);
        pure(e2);
        pure(e3); then true;
  end matchcontinue;
end pure;

protected function gen
  input Absyn.Exp in_exp;
  input Types.Type in_type;
  input Integer in_integer;
  output Scheme.Scheme out_scheme;
algorithm 
  out_scheme:=
  matchcontinue (in_exp,in_type,in_integer)
    local
      Scheme.Scheme rhs_sigma;
      Absyn.Exp rhs;
      Types.Type rhs_ty;
      Integer lev;
    case (rhs,rhs_ty,lev)
      equation 
        pure(rhs);
        rhs_sigma = Scheme.gen_limit(rhs_ty, lev); then rhs_sigma;
    case (rhs,rhs_ty,lev)
      equation 
        failure(pure(rhs));
        rhs_sigma = Scheme.gen_none(rhs_ty); then rhs_sigma;
  end matchcontinue;
end gen;

type TypesTyNameList = list<Types.TyName>;

uniontype Constraint
  record OVLD
    Types.Type x1;
    TypesTyNameList x2;
  end OVLD;
end Constraint;

protected function check_c
  input Constraint in_constraint;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_constraint)
    local
      type StringList = list<String>;
      String tyname;
      Types.Type ty;
      StringList tynames;
    case (OVLD(ty,tynames))
      equation 
        Types.CONS({},tyname) = Types.deref(ty);
        true = list_member(tyname, tynames); then true;
  end matchcontinue;
end check_c;

protected function check_constraints
  input ConstraintList in_constraintlist;
  output Boolean dummy;
protected 
  type ConstraintList = list<Constraint>;
algorithm 
  dummy:=
  matchcontinue (in_constraintlist)
    local
      Constraint c;
      ConstraintList cs;
    case ({}) then true; 
    case (c :: cs)
      equation 
        check_c(c);
        check_constraints(cs); then true;
  end matchcontinue;
end check_constraints;

protected function add_constraints
  input TypesAlphaList in_typesalphalist;
  input ConstraintList in_constraintlist;
  output ConstraintList out_constraintlist;
protected 
  type TypesAlphaList = list<Types.Alpha>;
  type ConstraintList = list<Constraint>;
algorithm 
  out_constraintlist:=
  matchcontinue (in_typesalphalist,in_constraintlist)
    local
      type StringList = list<String>;
      Type_a cs;
      StringList tynames;
      ConstraintList cs_1;
      Types.Alpha alfa;
      TypesAlphaList alphas;
    case ({},cs) then cs; 
    case (alfa :: alphas,cs)
      local ConstraintList cs;
      equation 
        SOME(tynames) = Types.alpha_ovld(alfa);
        cs_1 = add_constraints(alphas, OVLD(Types.VAR(alfa),tynames) :: cs); then cs_1;
    case (alfa :: alphas,cs)
      local ConstraintList cs;
      equation 
        NONE = Types.alpha_ovld(alfa);
        cs_1 = add_constraints(alphas, cs); then cs_1;
  end matchcontinue;
end add_constraints;

protected function lookup_and_inst
  input TupleType_aSchemeSchemeList in_tupletype_aschemeschemelist;
  input Integer in_integer;
  input ConstraintList in_constraintlist;
  input Type_a in_type_a;
  output Types.Type out_type;
  output ConstraintList out_constraintlist;
protected 
  type TupleType_aSchemeScheme = tuple<Type_a,SchemeScheme>;
  type TupleType_aSchemeSchemeList = list<TupleType_aSchemeScheme>;
  type ConstraintList = list<Constraint>;
algorithm 
  (out_type,out_constraintlist):=
  matchcontinue (in_tupletype_aschemeschemelist,in_integer,in_constraintlist,in_type_a)
    local
      type TypesAlphaList = list<Types.Alpha>;
      Scheme.Scheme var_sigma;
      TypesAlphaList bvars;
      Types.Type var_ty;
      ConstraintList cs_1,cs;
      TupleType_aSchemeSchemeList env;
      Integer lev;
      Type_a var;
    case (env,lev,cs,var)
      equation 
        var_sigma = Util.lookup(env, var);
        (bvars,var_ty) = Scheme.inst(var_sigma, lev);
        cs_1 = add_constraints(bvars, cs); then (var_ty,cs_1);
  end matchcontinue;
end lookup_and_inst;

protected function elab_exp
  input TupleStringSchemeSchemeList in_tuplestringschemeschemelist;
  input Integer in_integer;
  input ConstraintList in_constraintlist;
  input Absyn.Exp in_exp;
  output Types.Type out_type;
  output ConstraintList out_constraintlist;
protected 
  type ConstraintList = list<Constraint>;
algorithm 
  (out_type,out_constraintlist):=
  matchcontinue (in_tuplestringschemeschemelist,in_integer,in_constraintlist,in_exp)
    local
      Type_a cs;
      Types.Type var_ty,lam_ty,func_ty,arg_ty,res_ty,e1_ty,e2_ty,e3_ty,rhs_ty,body_ty,lhs_ty;
      ConstraintList cs_1,cs1,cs2,cs3;
      Env env;
      Integer lev,lev1;
      String var,lhs;
      Absyn.Lambda lam;
      Types.Alpha alfa;
      Absyn.Exp func,arg,e1,e2,e3,rhs,body;
      Scheme.Scheme lhs_sigma,lhs_sigma1,lhs_sigma0;
    case (_,_,cs,Absyn.INT(_)) then (tyINT,cs); 
    case (_,_,cs,Absyn.REAL(_)) then (tyREAL,cs); 
    case (_,_,cs,Absyn.STRING(_)) then (tySTRING,cs); 
    case (_,_,cs,Absyn.UNIT()) then (tyUNIT,cs); 
    case (env,lev,cs,Absyn.VAR(var))
      local ConstraintList cs;
      equation 
        (var_ty,cs_1) = lookup_and_inst(env, lev, cs, var); then (var_ty,cs_1);
    case (env,lev,cs,Absyn.LAM(lam))
      local ConstraintList cs;
      equation 
        (lam_ty,cs_1) = elab_lam(env, lev, cs, lam); then (lam_ty,cs_1);
    case (env,lev,cs,Absyn.APP(func,arg))
      local ConstraintList cs;
      equation 
        (func_ty,cs1) = elab_exp(env, lev, cs, func);
        (arg_ty,cs2) = elab_exp(env, lev, cs1, arg);
        alfa = Types.mkFreeAlpha(lev);
        res_ty = Types.VAR(alfa);
        Unify.unify(func_ty, Types.CONS(list(arg_ty,res_ty),"->")); then (res_ty,cs2);
    case (env,lev,cs,Absyn.PAIR(e1,e2))
      local ConstraintList cs;
      equation 
        (e1_ty,cs1) = elab_exp(env, lev, cs, e1);
        (e2_ty,cs2) = elab_exp(env, lev, cs1, e2); then (Types.CONS(list(e1_ty,e2_ty),"*"),cs2);
    case (env,lev,cs,Absyn.IF(e1,e2,e3))
      local ConstraintList cs;
      equation 
        (e1_ty,cs1) = elab_exp(env, lev, cs, e1);
        Unify.unify(e1_ty, tyBOOL);
        (e2_ty,cs2) = elab_exp(env, lev, cs1, e2);
        (e3_ty,cs3) = elab_exp(env, lev, cs2, e3);
        Unify.unify(e2_ty, e3_ty); then (e2_ty,cs3);
    case (env,lev,cs,Absyn.LET(lhs,rhs,body))
      local ConstraintList cs;
      equation 
        lev1 = lev + 1;
        (rhs_ty,cs1) = elab_exp(env, lev1, cs, rhs);
        lhs_sigma = gen(rhs, rhs_ty, lev);
        (body_ty,cs2) = elab_exp((lhs,lhs_sigma) :: env, lev, cs1, body); then (body_ty,cs2);
    case (env,lev,cs,Absyn.LETREC(lhs,lam,body))
      local ConstraintList cs;
      equation 
        lev1 = lev + 1;
        alfa = Types.mkFreeAlpha(lev1);
        lhs_ty = Types.VAR(alfa);
        lhs_sigma1 = Scheme.gen_none(lhs_ty);
        (lam_ty,cs1) = elab_lam((lhs,lhs_sigma1) :: env, lev1, cs, lam);
        Unify.unify(lhs_ty, lam_ty);
        lhs_sigma0 = Scheme.gen_limit(lhs_ty, lev);
        (body_ty,cs2) = elab_exp((lhs,lhs_sigma0) :: env, lev, cs1, body); then (body_ty,cs2);
  end matchcontinue;
end elab_exp;

protected function elab_lam
  input TupleStringSchemeSchemeList in_tuplestringschemeschemelist;
  input Integer in_integer;
  input ConstraintList in_constraintlist;
  input Absyn.Lambda in_lambda;
  output Types.Type out_type;
  output ConstraintList out_constraintlist;
protected 
  type ConstraintList = list<Constraint>;
algorithm 
  (out_type,out_constraintlist):=
  matchcontinue (in_tuplestringschemeschemelist,in_integer,in_constraintlist,in_lambda)
    local
      Types.Alpha alfa;
      Types.Type var_ty,body_ty;
      Scheme.Scheme var_sigma;
      ConstraintList cs_1,cs;
      Env env;
      Integer lev;
      String var;
      Absyn.Exp body;
    case (env,lev,cs,Absyn.LAMBDA(var,body))
      equation 
        alfa = Types.mkFreeAlpha(lev);
        var_ty = Types.VAR(alfa);
        var_sigma = Scheme.gen_none(var_ty);
        (body_ty,cs_1) = elab_exp((var,var_sigma) :: env, lev, cs, body); then (Types.CONS(list(var_ty,body_ty),"->"),cs_1);
  end matchcontinue;
end elab_lam;

public function elaborate
  input TupleStringSchemeSchemeList in_tuplestringschemeschemelist;
  input Absyn.Dec in_dec;
  output TupleStringSchemeSchemeList out_tuplestringschemeschemelist;
algorithm 
  out_tuplestringschemeschemelist:=
  matchcontinue (in_tuplestringschemeschemelist,in_dec)
    local
      type ConstraintList = list<Constraint>;
      Types.Type ty;
      ConstraintList cs;
      Scheme.Scheme sigma;
      Env env;
      String id;
      Absyn.Exp exp;
    case (env,Absyn.VAL(id,exp))
      equation 
        (ty,cs) = elab_exp(env, 0, {}, exp);
        check_constraints(cs);
        sigma = Scheme.gen_limit(ty, -1); then (id,sigma) :: env;
  end matchcontinue;
end elaborate;
end Static;

