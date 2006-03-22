package Static " static.rml "
import absyn;
import tcode;
import types;

protected function map
  input FuncTypeType_aToType_b in_functypetype_atotype_b;
  input VType_aList in_vtype_alist;
  output VType_bList out_vtype_blist;
protected 
  function FuncTypeType_aToType_b
    input Type_a in_type_a;
    output Type_b out_type_b;
  protected 
    replaceable type Type_a;
    replaceable type Type_b;
  end FuncTypeType_aToType_b;
  replaceable type Type_a;
  type VType_aList = list<Type_a>;
  replaceable type Type_b;
  type VType_bList = list<Type_b>;
algorithm 
  out_vtype_blist:=
  matchcontinue (in_functypetype_atotype_b,in_vtype_alist)
    local
      Type_b y;
      VType_bList ys;
      FuncTypeType_aToType_b R;
      Type_a x;
      VType_aList xs;
    case (_,{}) then {}; 
    case (R,x :: xs)
      equation 
        y = R(x);
        ys = map(R, xs); then y :: ys;
  end matchcontinue;
end map;

uniontype Con "
 * Static environment
 "
  record INTcon
    Integer x1;
  end INTcon;
  record REALcon
    Real x1;
  end REALcon;
end Con;

type TypesTyList = list<Types.Ty>;

uniontype Bnd
  record VARbnd
    Types.Ty x1;
  end VARbnd;
  record CONSTbnd
    Con x1;
  end CONSTbnd;
  record FUNCbnd
    TypesTyList x1;
    Types.Ty x2;
  end FUNCbnd;
  record PROCbnd
    TypesTyList x1;
  end PROCbnd;
  record TYPEbnd
    Types.Ty x1;
  end TYPEbnd;
  record NILbnd
  end NILbnd;
end Bnd;

type TupleStringBnd = tuple<String,Bnd>;

type TupleStringBndList = list<TupleStringBnd>;
constant TupleStringBndList env_init=list(("integer",TYPEbnd(Types.ARITH(Types.INT))),
          ("real",TYPEbnd(Types.ARITH(Types.REAL))),("char",TYPEbnd(Types.ARITH(Types.CHAR))),
          ("read",FUNCbnd({},Types.ARITH(Types.INT))),("write",PROCbnd(list(Types.ARITH(Types.INT)))),
          ("trunc",
          FUNCbnd(list(Types.ARITH(Types.REAL)),Types.ARITH(Types.INT))),("nil",NILbnd()));

protected function lookup
  input TupleType_aType_bList in_tupletype_atype_blist;
  input Type_a in_type_a;
  output Type_b out_type_b;
protected 
  replaceable type Type_a;
  replaceable type Type_b;
  type TupleType_aType_b = tuple<Type_a,Type_b>;
  type TupleType_aType_bList = list<TupleType_aType_b>;
algorithm 
  out_type_b:=
  matchcontinue (in_tupletype_atype_blist,in_type_a)
    local
      type TupleType_aType_a = tuple<Type_a,Type_a>;
      type TupleType_aType_aList = list<TupleType_aType_a>;
      Type_a key1,bnd,key0;
      TupleType_aType_aList env;
    case ((key1,bnd) :: _,key0)
      equation 
        equality(key1 = key0); then bnd;
    case ((key1,_) :: env,key0)
      equation 
        failure(equality(key1 = key0));
        bnd = lookup(env, key0); then bnd;
  end matchcontinue;
end lookup;

protected function elab_constant " Constants and Types
 "
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.Constant in_constant;
  output Con out_con;
algorithm 
  out_con:=
  matchcontinue (in_tuplestringbndlist,in_constant)
    local
      replaceable type Type_a;
      Type_a env;
      Integer i;
      Real r;
      Con c;
      String id;
    case (env,Absyn.INTcon(i)) then INTcon(i); 
    case (env,Absyn.REALcon(r)) then REALcon(r); 
    case (env,Absyn.IDENTcon(id))
      local TupleStringBndList env;
      equation 
        CONSTbnd(c) = lookup(env, id); then c;
  end matchcontinue;
end elab_constant;

protected function elab_const
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.ConBnd in_conbnd;
  output TupleStringBndList out_tuplestringbndlist;
algorithm 
  out_tuplestringbndlist:=
  matchcontinue (in_tuplestringbndlist,in_conbnd)
    local
      Con con;
      TupleStringBndList env0;
      String id;
      Absyn.Constant c;
    case (env0,Absyn.CONBND(id,c)) " env |- Const => env' "
      equation 
        con = elab_constant(env0, c); then (id,CONSTbnd(con)) :: env0;
  end matchcontinue;
end elab_const;

protected function elab_consts
  input TupleStringBndList in_tuplestringbndlist;
  input AbsynConBndList in_absynconbndlist;
  output TupleStringBndList out_tuplestringbndlist;
protected 
  type AbsynConBndList = list<Absyn.ConBnd>;
algorithm 
  out_tuplestringbndlist:=
  matchcontinue (in_tuplestringbndlist,in_absynconbndlist)
    local
      replaceable type Type_a;
      Type_a env;
      TupleStringBndList env_1,env_2;
      Absyn.ConBnd c;
      AbsynConBndList consts;
    case (env,{}) then env; 
    case (env,c :: consts)
      local TupleStringBndList env;
      equation 
        env_1 = elab_const(env, c);
        env_2 = elab_consts(env_1, consts); then env_2;
  end matchcontinue;
end elab_consts;

protected function elab_ty
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.Ty in_ty;
  output Types.Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_tuplestringbndlist,in_ty)
    local
      type TupleStringTypesTy = tuple<String,TypesTy>;
      type TupleStringTypesTyList = list<TupleStringTypesTy>;
      type AbsynVarBndList = list<Absyn.VarBnd>;
      Types.Ty ty_1;
      TupleStringBndList env;
      String id;
      Absyn.Ty ty;
      Integer sz,stamp;
      Absyn.Constant c;
      TupleStringTypesTyList bnds_1;
      AbsynVarBndList bnds;
    case (env,Absyn.NAME(id)) " env |- Absyn.Ty => Types.Ty "
      equation 
        TYPEbnd(ty_1) = lookup(env, id); then ty_1;
    case (env,Absyn.PTR(ty))
      equation 
        ty_1 = elab_ty(env, ty); then Types.PTR(ty_1);
    case (env,Absyn.ARR(c,ty))
      equation 
        INTcon(sz) = elab_constant(env, c);
        ty_1 = elab_ty(env, ty); then Types.ARR(sz,ty_1);
    case (env,Absyn.REC(bnds))
      equation 
        stamp = tick();
        bnds_1 = elab_ty_bnds(env, bnds, {}); then Types.REC(Types.RECORD(stamp,bnds_1));
  end matchcontinue;
end elab_ty;

protected function elab_ty_bnds
  input TupleStringBndList in_tuplestringbndlist;
  input AbsynVarBndList in_absynvarbndlist;
  input TupleStringTypesTyList in_tuplestringtypestylist;
  output TupleStringTypesTyList out_tuplestringtypestylist;
protected 
  type AbsynVarBndList = list<Absyn.VarBnd>;
  type TupleStringTypesTy = tuple<String,TypesTy>;
  type TupleStringTypesTyList = list<TupleStringTypesTy>;
algorithm 
  out_tuplestringtypestylist:=
  matchcontinue (in_tuplestringbndlist,in_absynvarbndlist,in_tuplestringtypestylist)
    local
      TupleStringTypesTyList bnds_2,bnds_1;
      TupleStringBndList env;
      Types.Ty ty_1;
      String id;
      Absyn.Ty ty;
      AbsynVarBndList bnds;
    case (env,{},bnds_1)
      equation 
        bnds_2 = list_reverse(bnds_1); then bnds_2;
    case (env,Absyn.VARBND(id,ty) :: bnds,bnds_1)
      equation 
        ty_1 = elab_ty(env, ty);
        bnds_2 = elab_ty_bnds(env, bnds, (id,ty_1) :: bnds_1); then bnds_2;
  end matchcontinue;
end elab_ty_bnds;

protected function isunfold
  input Types.Ty in_ty;
  output Boolean out_boolean;
algorithm 
  out_boolean:=
  matchcontinue (in_ty)
    case (Types.UNFOLD(_)) then true; 
    case (Types.ARITH(_)) then false; 
    case (Types.PTR(_)) then false; 
    case (Types.ARR(_,_)) then false; 
    case (Types.REC(_)) then false; 
  end matchcontinue;
end isunfold;

protected function check_ty
  input Types.Ty in_ty;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_ty)
    local
      type TupleStringTypesTy = tuple<String,TypesTy>;
      type TupleStringTypesTyList = list<TupleStringTypesTy>;
      Types.Ty ty;
      TupleStringTypesTyList bnds;
    case (Types.ARITH(_)) then true; 
    case (Types.ARR(_,ty))
      equation 
        check_ty(ty); then true;
    case (Types.REC(Types.RECORD(_,bnds)))
      equation 
        check_bnds(bnds); then true;
    case (Types.PTR(ty))
      equation 
        true = isunfold(ty); then true;
    case (Types.PTR(ty))
      equation 
        false = isunfold(ty);
        check_ty(ty); then true;
  end matchcontinue;
end check_ty;

protected function check_bnds
  input TupleStringTypesTyList in_tuplestringtypestylist;
  output Boolean dummy;
protected 
  type TupleStringTypesTy = tuple<String,TypesTy>;
  type TupleStringTypesTyList = list<TupleStringTypesTy>;
algorithm 
  dummy:=
  matchcontinue (in_tuplestringtypestylist)
    local
      replaceable type Type_b;
      replaceable type Type_a;
      type TupleType_aType_b = tuple<Type_a,Type_b>;
      type TupleType_aType_bList = list<TupleType_aType_b>;
      Type_b ty;
      TupleType_aType_bList bnds;
    case {} then true; 
    case ((_,ty) :: bnds)
      equation 
        check_ty(ty);
        check_bnds(bnds); then true;
  end matchcontinue;
end check_bnds;

type AbsynVarBndList = list<Absyn.VarBnd>;

uniontype IsRec
  record NOREC
    Absyn.Ty x1;
  end NOREC;
  record ISREC
    AbsynVarBndList x1;
  end ISREC;
end IsRec;

protected function isrec
  input Absyn.Ty in_ty;
  output IsRec out_isrec;
algorithm 
  out_isrec:=
  matchcontinue (in_ty)
    local
      Absyn.Ty ty;
      AbsynVarBndList bnds;
    case ((ty = Absyn.NAME(_))) then NOREC(ty); 
    case ((ty = Absyn.PTR(_))) then NOREC(ty); 
    case ((ty = Absyn.ARR(_,_))) then NOREC(ty); 
    case (Absyn.REC(bnds)) then ISREC(bnds); 
  end matchcontinue;
end isrec;

protected function elab_tybnd_1
  input IsRec in_isrec;
  input TupleStringBndList in_tuplestringbndlist;
  input String in_string;
  output Types.Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_isrec,in_tuplestringbndlist,in_string)
    local
      type TupleStringTypesTy = tuple<String,TypesTy>;
      type TupleStringTypesTyList = list<TupleStringTypesTy>;
      Integer stamp;
      TupleStringTypesTyList bnds_1;
      AbsynVarBndList bnds;
      TupleStringBndList env0;
      String id;
      Types.Ty ty_1;
      Absyn.Ty ty;
    case (ISREC(bnds),env0,id)
      equation 
        stamp = tick();
        bnds_1 = elab_ty_bnds((id,TYPEbnd(Types.UNFOLD(stamp))) :: env0, bnds, {});
        check_bnds(bnds_1); then Types.REC(Types.RECORD(stamp,bnds_1));
    case (NOREC(ty),env0,id)
      equation 
        ty_1 = elab_ty(env0, ty); then ty_1;
  end matchcontinue;
end elab_tybnd_1;

protected function elab_tybnd
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.TyBnd in_tybnd;
  output TupleStringBndList out_tuplestringbndlist;
algorithm 
  out_tuplestringbndlist:=
  matchcontinue (in_tuplestringbndlist,in_tybnd)
    local
      IsRec xxx;
      Types.Ty ty_1;
      TupleStringBndList env0;
      String id;
      Absyn.Ty ty;
    case (env0,Absyn.TYBND(id,ty))
      equation 
        xxx = isrec(ty);
        ty_1 = elab_tybnd_1(xxx, env0, id); then (id,TYPEbnd(ty_1)) :: env0;
  end matchcontinue;
end elab_tybnd;

protected function elab_types
  input TupleStringBndList in_tuplestringbndlist;
  input AbsynTyBndList in_absyntybndlist;
  output TupleStringBndList out_tuplestringbndlist;
protected 
  type AbsynTyBndList = list<Absyn.TyBnd>;
algorithm 
  out_tuplestringbndlist:=
  matchcontinue (in_tuplestringbndlist,in_absyntybndlist)
    local
      replaceable type Type_a;
      Type_a env;
      TupleStringBndList env_1,env_2;
      Absyn.TyBnd tybnd;
      AbsynTyBndList tybnds;
    case (env,{}) then env; 
    case (env,tybnd :: tybnds)
      local TupleStringBndList env;
      equation 
        env_1 = elab_tybnd(env, tybnd);
        env_2 = elab_types(env_1, tybnds); then env_2;
  end matchcontinue;
end elab_types;

protected function lvalue_id "
 * Expressions
 
  relation lvalue_id =
  rule	Types.ty_cnv ty => ty'
	----------------
	lvalue_id(Types.ARR(_,ty), addr) => TCode.UNARY(TCode.TOPTR ty', addr)

  axiom lvalue_id(Types.ARITH _, addr) => addr
  axiom lvalue_id(Types.PTR _, addr) => addr
  axiom lvalue_id(Types.REC _, addr) => addr
end"
  input Type_a in_type_a;
  input Type_b in_type_b;
  output Type_b out_type_b;
protected 
  replaceable type Type_a;
  replaceable type Type_b;
algorithm 
  out_type_b:=
  matchcontinue (in_type_a,in_type_b)
    local Type_a addr;
    case (_,addr) then addr; 
  end matchcontinue;
end lvalue_id;

protected function mkload
  input Types.Ty ty;
  input TCode.Exp addr;
  output TCode.Exp out_exp;
protected 
  TCode.Ty ty_1;
algorithm 
  ty_1 := Types.ty_cnv(ty);
  out_exp := TCode.UNARY(TCode.LOAD(ty_1),addr);
end mkload;

protected function rvalue_var
  input Types.Ty in_ty;
  input TCode.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_ty,in_exp)
    local
      TCode.Exp exp,addr;
      Types.Ty ty;
      TCode.Ty ty_1;
    case ((ty = Types.ARITH(_)),addr)
      equation 
        exp = mkload(ty, addr); then (exp,ty);
    case ((ty = Types.PTR(_)),addr)
      equation 
        exp = mkload(ty, addr); then (exp,ty);
    case ((ty = Types.REC(_)),addr)
      equation 
        exp = mkload(ty, addr); then (exp,ty);
    case (Types.ARR(_,ty),addr)
      equation 
        ty_1 = Types.ty_cnv(ty); then (TCode.UNARY(TCode.TOPTR(ty_1),addr),Types.PTR(ty));
  end matchcontinue;
end rvalue_var;

protected function rvalue_id
  input Bnd in_bnd;
  input String in_string;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_bnd,in_string)
    local
      Integer i;
      Real r;
      TCode.Exp exp_1;
      Types.Ty ty_1,ty;
      String id;
    case (CONSTbnd(INTcon(i)),_) then (TCode.ICON(i),Types.ARITH(Types.INT)); 
    case (CONSTbnd(REALcon(r)),_) then (TCode.RCON(r),Types.ARITH(Types.REAL)); 
    case (NILbnd(),_) then (TCode.ICON(0),Types.PTRNIL); 
    case (VARbnd(ty),id)
      equation 
        (exp_1,ty_1) = rvalue_var(ty, TCode.ADDR(id)); then (exp_1,ty_1);
  end matchcontinue;
end rvalue_id;

protected function elab_arg
  input TupleStringBndList env;
  input Absyn.Exp exp;
  input Types.Ty ty;
  output TCode.Exp exp_2;
protected 
  TCode.Exp exp_1,exp_2;
  Types.Ty ty_1;
algorithm 
  (exp_1,ty_1) := elab_rvalue(env, exp);
  exp_2 := Types.asg_cnv(exp_1, ty_1, ty) " no auto decay ";
end elab_arg;

protected function elab_args
  input TupleStringBndList in_tuplestringbndlist;
  input AbsynExpList in_absynexplist;
  input TypesTyList in_typestylist;
  input TCodeExpList in_tcodeexplist;
  output TCodeExpList out_tcodeexplist;
protected 
  type AbsynExpList = list<Absyn.Exp>;
  type TCodeExpList = list<TCode.Exp>;
algorithm 
  out_tcodeexplist:=
  matchcontinue (in_tuplestringbndlist,in_absynexplist,in_typestylist,in_tcodeexplist)
    local
      TCodeExpList args_2,args_1,exps_2,exps_1;
      TCode.Exp exp_1;
      TupleStringBndList env;
      Absyn.Exp exp;
      AbsynExpList exps;
      Types.Ty ty;
      TypesTyList tys;
    case (_,{},{},args_1)
      equation 
        args_2 = list_reverse(args_1); then args_2;
    case (env,exp :: exps,ty :: tys,exps_1)
      equation 
        exp_1 = elab_arg(env, exp, ty);
        exps_2 = elab_args(env, exps, tys, exp_1 :: exps_1); then exps_2;
  end matchcontinue;
end elab_args;

protected function elab_unary_rvalue
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.UnOp in_unop;
  input Absyn.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_tuplestringbndlist,in_unop,in_exp)
    local
      replaceable type Type_a;
      Type_a exp_1,env,exp;
      Types.Ty ty;
      TCode.Exp exp_2;
      TCode.Ty ty_1;
    case (env,Absyn.ADDR(),exp)
      equation 
        (exp_1,ty) = elab_lvalue(env, exp); then (exp_1,Types.PTR(ty));
    case (env,Absyn.INDIR(),exp)
      local TCode.Exp exp_1;
      equation 
        (exp_1,Types.PTR(ty)) = elab_rvalue_decay(env, exp);
        ty_1 = Types.ty_cnv(ty); then (TCode.UNARY(TCode.LOAD(ty_1),exp_1),ty);
    case (env,Absyn.NOT(),exp)
      local TCode.Exp exp_1;
      equation 
        (exp_1,ty) = elab_rvalue_decay(env, exp);
        exp_2 = Types.cond_cnv(exp_1, ty); then (TCode.BINARY(exp_2,TCode.IEQ(),TCode.ICON(0)),Types.ARITH(Types.INT));
  end matchcontinue;
end elab_unary_rvalue;

protected function elab_rvalue
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_tuplestringbndlist,in_exp)
    local
      replaceable type Type_a;
      type TCodeExpList = list<TCode.Exp>;
      type AbsynExpList = list<Absyn.Exp>;
      Type_a env;
      Integer i;
      Real r;
      Bnd bnd;
      TCode.Exp exp,exp_1,exp_2,exp1_1,exp2_1,exp3;
      Types.Ty ty,ty_1,ty_2,rty,rty1,rty2,rty3,resty;
      String id;
      Absyn.Exp exp1,exp2;
      Absyn.UnOp unop;
      Absyn.BinOp binop;
      Absyn.RelOp relop;
      TypesTyList argtys;
      TCodeExpList args_1;
      AbsynExpList args;
    case (env,Absyn.INT(i)) then (TCode.ICON(i),Types.ARITH(Types.INT)); 
    case (env,Absyn.REAL(r)) then (TCode.RCON(r),Types.ARITH(Types.REAL)); 
    case (env,Absyn.IDENT(id))
      local TupleStringBndList env;
      equation 
        bnd = lookup(env, id);
        (exp,ty) = rvalue_id(bnd, id); then (exp,ty);
    case (env,Absyn.CAST(ty,exp))
      local
        TupleStringBndList env;
        Absyn.Ty ty;
        Absyn.Exp exp;
      equation 
        (exp_1,ty_1) = elab_rvalue_decay(env, exp);
        ty_2 = elab_ty(env, ty);
        exp_2 = Types.cast_cnv(exp_1, ty_1, ty_2); then (exp_2,ty_2);
    case (env,Absyn.FIELD(exp,id))
      local
        TupleStringBndList env;
        Absyn.Exp exp;
      equation 
        (exp_1,ty) = elab_field(env, exp, id);
        (exp_2,ty_1) = rvalue_var(ty, exp_1); then (exp_2,ty_1);
    case (env,Absyn.UNARY(unop,exp))
      local
        TupleStringBndList env;
        Absyn.Exp exp;
      equation 
        (exp_1,rty) = elab_unary_rvalue(env, unop, exp); then (exp_1,rty);
    case (env,Absyn.BINARY(exp1,binop,exp2))
      local TupleStringBndList env;
      equation 
        (exp1_1,rty1) = elab_rvalue_decay(env, exp1);
        (exp2_1,rty2) = elab_rvalue_decay(env, exp2);
        (exp3,rty3) = Types.bin_cnv(exp1_1, rty1, binop, exp2_1, rty2); then (exp3,rty3);
    case (env,Absyn.RELATION(exp1,relop,exp2))
      local TupleStringBndList env;
      equation 
        (exp1_1,rty1) = elab_rvalue_decay(env, exp1);
        (exp2_1,rty2) = elab_rvalue_decay(env, exp2);
        exp3 = Types.rel_cnv(exp1_1, rty1, relop, exp2_1, rty2); then (exp3,Types.ARITH(Types.INT));
    case (env,Absyn.EQUALITY(exp1,exp2))
      local TupleStringBndList env;
      equation 
        (exp1_1,rty1) = elab_rvalue_decay(env, exp1);
        (exp2_1,rty2) = elab_rvalue_decay(env, exp2);
        exp3 = Types.eq_cnv(exp1_1, rty1, exp2_1, rty2); then (exp3,Types.ARITH(Types.INT));
    case (env,Absyn.FCALL(id,args))
      local TupleStringBndList env;
      equation 
        FUNCbnd(argtys,resty) = lookup(env, id);
        args_1 = elab_args(env, args, argtys, {}); then (TCode.FCALL(id,args_1),resty);
  end matchcontinue;
end elab_rvalue;

protected function elab_rvalue_decay
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_tuplestringbndlist,in_exp)
    local
      replaceable type Type_a;
      TCode.Exp exp_1,exp_2;
      Types.Ty ty,ty_1;
      Type_a env,exp;
    case (env,exp)
      equation 
        (exp_1,ty) = elab_rvalue(env, exp);
        (exp_2,ty_1) = Types.decay(exp_1, ty); then (exp_2,ty_1);
  end matchcontinue;
end elab_rvalue_decay;

protected function elab_lvalue "
 * LValue Expressions.
 * Elaboration results in (exp,ty), where exp evaluates to
 * _a_pointer_to_ the lvalue, and ty is its type.
 "
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_tuplestringbndlist,in_exp)
    local
      Types.Ty ty;
      TCode.Exp exp_1;
      TupleStringBndList env;
      String id;
      Absyn.Exp exp;
    case (env,Absyn.IDENT(id)) " env |- exp => ptr_exp,ty "
      equation 
        VARbnd(ty) = lookup(env, id);
        exp_1 = lvalue_id(ty, TCode.ADDR(id)); then (exp_1,ty);
    case (env,Absyn.FIELD(exp,id))
      equation 
        (exp_1,ty) = elab_field(env, exp, id); then (exp_1,ty);
    case (env,Absyn.UNARY(Absyn.INDIR(),exp))
      equation 
        (exp_1,Types.PTR(ty)) = elab_rvalue_decay(env, exp); then (exp_1,ty);
  end matchcontinue;
end elab_lvalue;

protected function elab_field
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.Exp in_exp;
  input String in_string;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_tuplestringbndlist,in_exp,in_string)
    local
      type TupleStringTypesTy = tuple<String,TypesTy>;
      type TupleStringTypesTyList = list<TupleStringTypesTy>;
      TCode.Exp exp_1,exp_2;
      Types.Record r;
      TupleStringTypesTyList bnds;
      Types.Ty ty;
      TCode.Record r_1;
      TupleStringBndList env;
      Absyn.Exp exp;
      String id;
    case (env,exp,id)
      equation 
        (exp_1,Types.REC(r)) = elab_lvalue(env, exp);
        bnds = Types.unfold_rec(r);
        ty = lookup(bnds, id) "N.B.";
        r_1 = Types.rec_cnv(r);
        exp_2 = lvalue_id(ty, TCode.UNARY(TCode.OFFSET(r_1,id),exp_1)); then (exp_2,ty);
  end matchcontinue;
end elab_field;

protected function elab_stmt "
 * Statements
 "
  input TypesTyOption in_typestyoption;
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.Stmt in_stmt;
  output TCode.Stmt out_stmt;
protected 
  type TypesTyOption = Option<Types.Ty>;
algorithm 
  out_stmt:=
  matchcontinue (in_typestyoption,in_tuplestringbndlist,in_stmt)
    local
      replaceable type Type_a;
      type TCodeExpList = list<TCode.Exp>;
      type AbsynExpList = list<Absyn.Exp>;
      TCode.Exp lval,rval,rval_1,exp_1,exp_2;
      Types.Ty lvalty,rvalty,ety,rty;
      TCode.Ty lvalty_1,rty_1;
      Type_a fty;
      TupleStringBndList env;
      Absyn.Exp lhs,rhs,exp;
      TypesTyList argtys;
      TCodeExpList args_1;
      String id;
      AbsynExpList args;
      TCode.Stmt stmt_1,stmt1_1,stmt2_1;
      Absyn.Stmt stmt,stmt1,stmt2;
    case (fty,env,Absyn.ASSIGN(lhs,rhs)) " ty_opt,env |- stmt => stmt' "
      equation 
        (lval,lvalty) = elab_lvalue(env, lhs);
        (rval,rvalty) = elab_rvalue(env, rhs);
        rval_1 = Types.asg_cnv(rval, rvalty, lvalty) " no auto decay ";
        lvalty_1 = Types.ty_cnv(lvalty); then TCode.STORE(lvalty_1,lval,rval_1);
    case (fty,env,Absyn.PCALL(id,args))
      equation 
        PROCbnd(argtys) = lookup(env, id);
        args_1 = elab_args(env, args, argtys, {}); then TCode.PCALL(id,args_1);
    case (SOME(rty),env,Absyn.FRETURN(exp))
      equation 
        (exp_1,ety) = elab_rvalue(env, exp);
        exp_2 = Types.asg_cnv(exp_1, ety, rty) " no auto decay ";
        rty_1 = Types.ty_cnv(rty); then TCode.RETURN(SOME((rty_1,exp_2)));
    case (NONE,env,Absyn.PRETURN()) then TCode.RETURN(NONE); 
    case (fty,env,Absyn.WHILE(exp,stmt))
      local TypesTyOption fty;
      equation 
        (exp_1,ety) = elab_rvalue_decay(env, exp);
        exp_2 = Types.cond_cnv(exp_1, ety);
        stmt_1 = elab_stmt(fty, env, stmt); then TCode.WHILE(exp_2,stmt_1);
    case (fty,env,Absyn.IF(exp,stmt1,stmt2))
      local TypesTyOption fty;
      equation 
        (exp_1,ety) = elab_rvalue_decay(env, exp);
        exp_2 = Types.cond_cnv(exp_1, ety);
        stmt1_1 = elab_stmt(fty, env, stmt1);
        stmt2_1 = elab_stmt(fty, env, stmt2); then TCode.IF(exp_2,stmt1_1,stmt2_1);
    case (fty,env,Absyn.SEQ(stmt1,stmt2))
      local TypesTyOption fty;
      equation 
        stmt1_1 = elab_stmt(fty, env, stmt1);
        stmt2_1 = elab_stmt(fty, env, stmt2); then TCode.SEQ(stmt1_1,stmt2_1);
    case (fty,env,Absyn.SKIP())
      local TypesTyOption fty; then TCode.SKIP();
  end matchcontinue;
end elab_stmt;

protected function elab_var "
 * Declarations
 "
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.VarBnd in_varbnd;
  output String out_string;
  output Types.Ty out_ty;
algorithm 
  (out_string,out_ty):=
  matchcontinue (in_tuplestringbndlist,in_varbnd)
    local
      Types.Ty ty_1;
      TupleStringBndList env;
      String id;
      Absyn.Ty ty;
    case (env,Absyn.VARBND(id,ty)) " env |- Var => (id,ty) "
      equation 
        ty_1 = elab_ty(env, ty); then (id,ty_1);
  end matchcontinue;
end elab_var;

protected function elab_vars
  input TupleStringBndList in_tuplestringbndlist;
  input AbsynVarBndList in_absynvarbndlist;
  input TupleStringTypesTyList in_tuplestringtypestylist;
  output TupleStringTypesTyList out_tuplestringtypestylist;
protected 
  type TupleStringTypesTy = tuple<String,TypesTy>;
  type TupleStringTypesTyList = list<TupleStringTypesTy>;
algorithm 
  out_tuplestringtypestylist:=
  matchcontinue (in_tuplestringbndlist,in_absynvarbndlist,in_tuplestringtypestylist)
    local
      replaceable type Type_a;
      type VType_aList = list<Type_a>;
      VType_aList vars_2,vars_1;
      String id;
      Types.Ty ty;
      TupleStringBndList env;
      Absyn.VarBnd var;
      AbsynVarBndList vars;
    case (_,{},vars_1)
      equation 
        vars_2 = list_reverse(vars_1); then vars_2;
    case (env,var :: vars,vars_1)
      local TupleStringTypesTyList vars_2,vars_1;
      equation 
        (id,ty) = elab_var(env, var);
        vars_2 = elab_vars(env, vars, (id,ty) :: vars_1); then vars_2;
  end matchcontinue;
end elab_vars;

protected function mkvar
  input TupleStringTypesTy in_tuplestringtypesty;
  output TCode.Var out_var;
protected 
  type TupleStringTypesTy = tuple<String,TypesTy>;
algorithm 
  out_var:=
  matchcontinue (in_tuplestringtypesty)
    local
      TCode.Ty ty_1;
      String id;
      Types.Ty ty;
    case ((id,ty))
      equation 
        ty_1 = Types.ty_cnv(ty); then TCode.VAR(id,ty_1);
  end matchcontinue;
end mkvar;

protected function mkvarbnd
  input TupleType_aTypesTy in_tupletype_atypesty;
  output TupleType_aBnd out_tupletype_abnd;
protected 
  replaceable type Type_a;
  type TupleType_aTypesTy = tuple<Type_a,TypesTy>;
  type TupleType_aBnd = tuple<Type_a,Bnd>;
algorithm 
  out_tupletype_abnd:=
  matchcontinue (in_tupletype_atypesty)
    local
      Type_a id;
      Types.Ty ty;
    case ((id,ty)) then (id,VARbnd(ty)); 
  end matchcontinue;
end mkvarbnd;

protected function decay_formal_ty
  input Types.Ty in_ty;
  output Types.Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_ty)
    local Types.Ty ty;
    case (Types.ARR(_,ty)) then Types.PTR(ty); 
    case ((ty = Types.ARITH(_))) then ty; 
    case ((ty = Types.PTR(_))) then ty; 
    case ((ty = Types.REC(_))) then ty; 
  end matchcontinue;
end decay_formal_ty;

protected function decay_formal
  input TupleType_aTypesTy in_tupletype_atypesty;
  output TupleType_aTypesTy out_tupletype_atypesty;
protected 
  replaceable type Type_a;
  type TupleType_aTypesTy = tuple<Type_a,TypesTy>;
algorithm 
  out_tupletype_atypesty:=
  matchcontinue (in_tupletype_atypesty)
    local
      Types.Ty ty_1,ty;
      Type_a id;
    case ((id,ty))
      equation 
        ty_1 = decay_formal_ty(ty); then (id,ty_1);
  end matchcontinue;
end decay_formal;

protected function snd
  input TupleType_aType_b in_tupletype_atype_b;
  output Type_b out_type_b;
protected 
  replaceable type Type_a;
  replaceable type Type_b;
  type TupleType_aType_b = tuple<Type_a,Type_b>;
algorithm 
  out_type_b:=
  matchcontinue (in_tupletype_atype_b)
    local Type_a y;
    case ((_,y)) then y; 
  end matchcontinue;
end snd;

protected function elab_formals
  input TupleStringBndList in_tuplestringbndlist;
  input AbsynVarBndList in_absynvarbndlist;
  output TCodeVarList out_tcodevarlist;
  output TupleStringBndList out_tuplestringbndlist;
  output TypesTyList out_typestylist;
protected 
  type TCodeVarList = list<TCode.Var>;
algorithm 
  (out_tcodevarlist,out_tuplestringbndlist,out_typestylist):=
  matchcontinue (in_tuplestringbndlist,in_absynvarbndlist)
    local
      type TupleStringTypesTy = tuple<String,TypesTy>;
      type TupleStringTypesTyList = list<TupleStringTypesTy>;
      TupleStringTypesTyList pre_formals,pre_formals_1;
      TCodeVarList formals_1;
      TupleStringBndList argenv,env;
      TypesTyList argtys;
      AbsynVarBndList formals;
    case (env,formals)
      equation 
        pre_formals = elab_vars(env, formals, {});
        pre_formals_1 = map(decay_formal, pre_formals);
        formals_1 = map(mkvar, pre_formals_1);
        argenv = map(mkvarbnd, pre_formals_1);
        argtys = map(snd, pre_formals_1); then (formals_1,argenv,argtys);
  end matchcontinue;
end elab_formals;

protected function elab_subbnd
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.SubBnd in_subbnd;
  output TupleStringBndList out_tuplestringbndlist;
  output TCode.Proc out_proc;
algorithm 
  (out_tuplestringbndlist,out_proc):=
  matchcontinue (in_tuplestringbndlist,in_subbnd)
    local
      type TCodeVarList = list<TCode.Var>;
      type TCodeBlockOption = Option<TCode.Block>;
      type AbsynBlockOption = Option<Absyn.Block>;
      Types.Ty ty0,ty1;
      TCode.Ty ty2;
      TCodeVarList formals_1;
      TupleStringBndList argenv,env1,env2,env0;
      TypesTyList argtys;
      TCodeBlockOption block_1;
      String id;
      AbsynVarBndList formals;
      Absyn.Ty ty;
      AbsynBlockOption block_;
    case (env0,Absyn.FUNCBND(id,formals,ty,block_))
      equation 
        ty0 = elab_ty(env0, ty);
        ty1 = decay_formal_ty(ty0);
        ty2 = Types.ty_cnv(ty1) " ret ARR ==> ret PTR ";
        (formals_1,argenv,argtys) = elab_formals(env0, formals);
        env1 = (id,FUNCbnd(argtys,ty1)) :: env0;
        env2 = list_append(argenv, env1);
        block_1 = elab_body(SOME(ty1), env2, block_); then (env1,TCode.PROC(id,formals_1,SOME(ty2),block_1));
    case (env0,Absyn.PROCBND(id,formals,block_))
      equation 
        (formals_1,argenv,argtys) = elab_formals(env0, formals);
        env1 = (id,PROCbnd(argtys)) :: env0;
        env2 = list_append(argenv, env1);
        block_1 = elab_body(NONE, env2, block_); then (env1,TCode.PROC(id,formals_1,NONE,block_1));
  end matchcontinue;
end elab_subbnd;

protected function elab_subbnds
  input TupleStringBndList in_tuplestringbndlist;
  input AbsynSubBndList in_absynsubbndlist;
  input TCodeProcList in_tcodeproclist;
  output TupleStringBndList out_tuplestringbndlist;
  output TCodeProcList out_tcodeproclist;
protected 
  type AbsynSubBndList = list<Absyn.SubBnd>;
  type TCodeProcList = list<TCode.Proc>;
algorithm 
  (out_tuplestringbndlist,out_tcodeproclist):=
  matchcontinue (in_tuplestringbndlist,in_absynsubbndlist,in_tcodeproclist)
    local
      TCodeProcList subbnds_2,subbnds_1;
      TupleStringBndList env,env_1,env_2;
      TCode.Proc subbnd_1;
      Absyn.SubBnd subbnd;
      AbsynSubBndList subbnds;
    case (env,{},subbnds_1)
      equation 
        subbnds_2 = list_reverse(subbnds_1); then (env,subbnds_2);
    case (env,subbnd :: subbnds,subbnds_1)
      equation 
        (env_1,subbnd_1) = elab_subbnd(env, subbnd);
        (env_2,subbnds_2) = elab_subbnds(env_1, subbnds, subbnd_1 :: subbnds_1); then (env_2,subbnds_2);
  end matchcontinue;
end elab_subbnds;

protected function elab_body
  input TypesTyOption in_typestyoption;
  input TupleStringBndList in_tuplestringbndlist;
  input AbsynBlockOption in_absynblockoption;
  output TCodeBlockOption out_tcodeblockoption;
protected 
  type TypesTyOption = Option<Types.Ty>;
  type AbsynBlockOption = Option<Absyn.Block>;
  type TCodeBlockOption = Option<TCode.Block>;
algorithm 
  out_tcodeblockoption:=
  matchcontinue (in_typestyoption,in_tuplestringbndlist,in_absynblockoption)
    local
      TCode.Block block_1;
      TypesTyOption fty;
      TupleStringBndList env;
      Absyn.Block block_;
    case (_,_,NONE) then NONE; 
    case (fty,env,SOME(block_))
      equation 
        block_1 = elab_block(fty, env, block_); then SOME(block_1);
  end matchcontinue;
end elab_body;

protected function elab_block
  input TypesTyOption in_typestyoption;
  input TupleStringBndList in_tuplestringbndlist;
  input Absyn.Block in_block;
  output TCode.Block out_block;
protected 
  type TypesTyOption = Option<Types.Ty>;
algorithm 
  out_block:=
  matchcontinue (in_typestyoption,in_tuplestringbndlist,in_block)
    local
      type TupleStringTypesTy = tuple<String,TypesTy>;
      type TupleStringTypesTyList = list<TupleStringTypesTy>;
      type TCodeVarList = list<TCode.Var>;
      type TCodeProcList = list<TCode.Proc>;
      type AbsynConBndList = list<Absyn.ConBnd>;
      type AbsynTyBndList = list<Absyn.TyBnd>;
      type AbsynSubBndList = list<Absyn.SubBnd>;
      TupleStringBndList env1,env2,varenv,env3,env4,env0;
      TupleStringTypesTyList pre_vars;
      TCodeVarList vars_1;
      TCodeProcList subbnds_1;
      TCode.Stmt stmt_1;
      TypesTyOption fty;
      AbsynConBndList consts;
      AbsynTyBndList types;
      AbsynVarBndList vars;
      AbsynSubBndList subbnds;
      Absyn.Stmt stmt;
    case (fty,env0,Absyn.BLOCK(consts,types,vars,subbnds,stmt))
      equation 
        env1 = elab_consts(env0, consts);
        env2 = elab_types(env1, types);
        pre_vars = elab_vars(env2, vars, {});
        vars_1 = map(mkvar, pre_vars);
        varenv = map(mkvarbnd, pre_vars);
        env3 = list_append(varenv, env2);
        (env4,subbnds_1) = elab_subbnds(env3, subbnds, {});
        stmt_1 = elab_stmt(fty, env4, stmt); then TCode.BLOCK(vars_1,subbnds_1,stmt_1);
  end matchcontinue;
end elab_block;

public function elaborate
  input Absyn.Prog in_prog;
  output TCode.Prog out_prog;
algorithm 
  out_prog:=
  matchcontinue (in_prog)
    local
      TCode.Block block_1;
      String id;
      Absyn.Block block_;
    case (Absyn.PROG(id,block_))
      equation 
        block_1 = elab_block(NONE, env_init, block_); then TCode.PROG(id,block_1);
  end matchcontinue;
end elaborate;
end Static;

