package Static " static.rml "
import absyn;
import tcode;
import types;

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

type Ident = String " Bnd is just to tag the different type of values that identifiers are
 * associated to,
 * not the binding itself (compare to denotable value in denot. semantics).
 ";

type Binding = tuple<TCodeIdent,Bnd>;

type Env = list<Binding>;

type TupleStringBnd = tuple<String,Bnd>;

type TupleStringBndList = list<TupleStringBnd>;
constant TupleStringBndList env_init=list(("integer",TYPEbnd(Types.ARITH(Types.INT))),
          ("real",TYPEbnd(Types.ARITH(Types.REAL))),("char",TYPEbnd(Types.ARITH(Types.CHAR))),
          ("read",FUNCbnd({},Types.ARITH(Types.INT))),("write",PROCbnd(list(Types.ARITH(Types.INT)))),
          ("trunc",
          FUNCbnd(list(Types.ARITH(Types.REAL)),Types.ARITH(Types.INT))),("nil",NILbnd()));

protected function map
  input FuncTypeType_alphaToType_beta in_functypetype_alphatotype_beta;
  input VType_alphaList in_vtype_alphalist;
  output VType_betaList out_vtype_betalist;
protected 
  function FuncTypeType_alphaToType_beta
    input Type_alpha in_type_alpha;
    output Type_beta out_type_beta;
  protected 
    replaceable type Type_alpha;
    replaceable type Type_beta;
  end FuncTypeType_alphaToType_beta;
  replaceable type Type_alpha;
  type VType_alphaList = list<Type_alpha>;
  replaceable type Type_beta;
  type VType_betaList = list<Type_beta>;
algorithm 
  out_vtype_betalist:=
  matchcontinue (in_functypetype_alphatotype_beta,in_vtype_alphalist)
    local
      Type_beta y;
      VType_betaList ys;
      FuncTypeType_alphaToType_beta Rfunc;
      Type_alpha x;
      VType_alphaList xs;
    case (_,{}) then {}; 
    case (Rfunc,x :: xs)
      equation 
        y = Rfunc(x);
        ys = map(Rfunc, xs); then y :: ys;
  end matchcontinue;
end map;

protected function lookup_1
  input TupleTypesIdentTypesTyList in_tupletypesidenttypestylist;
  input Absyn.Ident in_ident;
  output Types.Ty out_ty;
protected 
  type TupleTypesIdentTypesTy = tuple<TypesIdent,TypesTy>;
  type TupleTypesIdentTypesTyList = list<TupleTypesIdentTypesTy>;
algorithm 
  out_ty:=
  matchcontinue (in_tupletypesidenttypestylist,in_ident)
    local
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      Ident key1,key0;
      Types.Ty ty;
      TupleIdentTypesTyList r;
    case ((key1,ty) :: _,key0)
      equation 
        equality(key1 = key0); then ty;
    case ((key1,_) :: r,key0)
      equation 
        failure(equality(key1 = key0));
        ty = lookup_1(r, key0); then ty;
  end matchcontinue;
end lookup_1;

protected function lookup
  input Env in_env;
  input TCode.Ident in_ident;
  output Bnd out_bnd;
algorithm 
  out_bnd:=
  matchcontinue (in_env,in_ident)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      Ident key1,key0;
      Bnd bnd;
      TupleIdentBndList env;
    case ((key1,bnd) :: _,key0)
      equation 
        equality(key1 = key0); then bnd;
    case ((key1,_) :: env,key0)
      equation 
        failure(equality(key1 = key0));
        bnd = lookup(env, key0); then bnd;
  end matchcontinue;
end lookup;

protected function elab_constant
  input Env in_env;
  input Absyn.Constant in_constant;
  output Con out_con;
algorithm 
  out_con:=
  matchcontinue (in_env,in_constant)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TupleIdentBndList env;
      Integer i;
      Real r;
      Con c;
      Ident id;
    case (env,Absyn.INTcon(i)) then INTcon(i); 
    case (env,Absyn.REALcon(r)) then REALcon(r); 
    case (env,Absyn.IDENTcon(id)) " const a = b "
      equation 
        CONSTbnd(c) = lookup(env, id); then c;
  end matchcontinue;
end elab_constant;

protected function elab_const
  input Env in_env;
  input Absyn.ConBnd in_conbnd;
  output Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_conbnd)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      Con con;
      TupleIdentBndList env0;
      Ident id;
      Absyn.Constant c;
    case (env0,Absyn.CONBND(id,c)) " Enter a const declaration in the environment "
      equation 
        con = elab_constant(env0, c); then (id,CONSTbnd(con)) :: env0;
  end matchcontinue;
end elab_const;

protected function elab_consts
  input Env in_env;
  input AbsynConBndList in_absynconbndlist;
  output Env out_env;
protected 
  type AbsynConBndList = list<Absyn.ConBnd>;
algorithm 
  out_env:=
  matchcontinue (in_env,in_absynconbndlist)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TupleIdentBndList env,env_1,env_2;
      Absyn.ConBnd c;
      AbsynConBndList consts;
    case (env,{}) then env; 
    case (env,c :: consts)
      equation 
        env_1 = elab_const(env, c);
        env_2 = elab_consts(env_1, consts); then env_2;
  end matchcontinue;
end elab_consts;

protected function elab_ty
  input Env in_env;
  input Absyn.Ty in_ty;
  output Types.Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_env,in_ty)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      type AbsynVarBndList = list<Absyn.VarBnd>;
      Types.Ty ty_1;
      TupleIdentBndList env;
      Ident id;
      Absyn.Ty ty;
      Integer sz,stamp;
      Absyn.Constant c;
      TupleIdentTypesTyList bnds_1;
      AbsynVarBndList bnds;
    case (env,Absyn.NAME(id)) " Elaborate right hand side of type declaration   = id "
      equation 
        print("rule 1\n");
        TYPEbnd(ty_1) = lookup(env, id); then ty_1;
    case (env,Absyn.PTR(ty)) " = ^typeexpr, e.g. ^ array {5} of int "
      equation 
        print("rule 2\n");
        ty_1 = elab_ty(env, ty); then Types.PTR(ty_1);
    case (env,Absyn.ARR(c,ty)) " = array{c} of ty , c is a constant expr, constliteral or constid "
      equation 
        print("rule 3\n");
        INTcon(sz) = elab_constant(env, c);
        ty_1 = elab_ty(env, ty); then Types.ARR(sz,ty_1);
    case (env,Absyn.REC(bnds)) " = record <field_list> end;     
   record binding that contains bnds, a
   list of pairs of field names and types.
   tick is a builtin RML integer generator, that gives new integers 
   stamp is used as a temporary name for the anonymous record type.
   Needed because record decls can be recursive.
   Used to build the internal type representation, similar to the abstract
   syntax, but stamps have been added.
  "
      equation 
        print("rule 4\n");
        stamp = tick();
        bnds_1 = elab_ty_bnds(env, bnds, {}); then Types.REC(Types.RECORD(stamp,bnds_1));
    case (_,_) "a drpo added 2002-03-01 "
      equation 
        print("-- elab_ty failed \n"); then fail();
  end matchcontinue;
end elab_ty;

protected function elab_ty_bnds
  input Env in_env;
  input AbsynVarBndList in_absynvarbndlist;
  input TupleAbsynIdentTypesTyList in_tupleabsynidenttypestylist;
  output TupleAbsynIdentTypesTyList out_tupleabsynidenttypestylist;
protected 
  type AbsynVarBndList = list<Absyn.VarBnd>;
  type TupleAbsynIdentTypesTy = tuple<AbsynIdent,TypesTy>;
  type TupleAbsynIdentTypesTyList = list<TupleAbsynIdentTypesTy>;
algorithm 
  out_tupleabsynidenttypestylist:=
  matchcontinue (in_env,in_absynvarbndlist,in_tupleabsynidenttypestylist)
    local
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TupleIdentTypesTyList bnds_2,bnds_1;
      TupleIdentBndList env;
      Types.Ty ty_1;
      Ident id;
      Absyn.Ty ty;
      AbsynVarBndList bnds;
    case (env,{},bnds_1) " Map over the list of field bindings in the abstract syntax
 * to give the corresponding list of field bindings in the record type
 * representation.
 * The third parameter accumulates the result list, and is reversed
 * before being returned
 "
      equation 
        bnds_2 = list_reverse(bnds_1); then bnds_2;
    case (env,Absyn.VARBND(id,ty) :: bnds,bnds_1)
      equation 
        ty_1 = elab_ty(env, ty);
        bnds_2 = elab_ty_bnds(env, bnds, (id,ty_1) :: bnds_1); then bnds_2;
  end matchcontinue;
end elab_ty_bnds;

protected function elab_types
  input Env in_env;
  input AbsynTyBndList in_absyntybndlist;
  output Env out_env;
protected 
  type AbsynTyBndList = list<Absyn.TyBnd>;
algorithm 
  out_env:=
  matchcontinue (in_env,in_absyntybndlist)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TupleIdentBndList env,env_1,env_2;
      Absyn.TyBnd tybnd;
      AbsynTyBndList tybnds;
    case (env,{}) then env; 
    case (env,tybnd :: tybnds)
      equation 
        env_1 = elab_tybnd(env, tybnd);
        env_2 = elab_types(env_1, tybnds); then env_2;
  end matchcontinue;
end elab_types;

protected function elab_tybnd
  input Env in_env;
  input Absyn.TyBnd in_tybnd;
  output Env out_env;
algorithm 
  out_env:=
  matchcontinue (in_env,in_tybnd)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      IsRec xxx;
      Types.Ty ty_1;
      TupleIdentBndList env0;
      Ident id;
      Absyn.Ty ty;
    case (env0,Absyn.TYBND(id,ty))
      equation 
        xxx = isrec(ty);
        ty_1 = elab_tybnd_1(xxx, env0, id); then (id,TYPEbnd(ty_1)) :: env0;
  end matchcontinue;
end elab_tybnd;

protected function elab_tybnd_1
  input IsRec in_isrec;
  input Env in_env;
  input Ident in_ident;
  output Types.Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_isrec,in_env,in_ident)
    local
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      type AbsynVarBndList = list<Absyn.VarBnd>;
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      Integer stamp;
      TupleIdentTypesTyList bnds_1;
      AbsynVarBndList bnds;
      TupleIdentBndList env0;
      Ident id;
      Types.Ty ty_1;
      Absyn.Ty ty;
    case (ISREC(bnds),env0,id)
      equation 
        stamp = tick();
        bnds_1 = elab_ty_bnds((id,TYPEbnd(Types.UNFOLD(stamp))) :: env0, bnds, {});
        check_bnds(bnds_1); then Types.REC(Types.RECORD(stamp,bnds_1));
    case (NOREC(ty),env0,id) " If no record, cannot be recursive, just return elaborated type "
      equation 
        ty_1 = elab_ty(env0, ty); then ty_1;
  end matchcontinue;
end elab_tybnd_1;

protected function check_bnds
  input TupleIdentTypesTyList in_tupleidenttypestylist;
  output Boolean dummy;
protected 
  type TupleIdentTypesTy = tuple<Ident,TypesTy>;
  type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
algorithm 
  dummy:=
  matchcontinue (in_tupleidenttypestylist)
    local
      Types.Ty ty;
      TupleIdentTypesTyList bnds;
    case {} then true; 
    case ((_,ty) :: bnds)
      equation 
        check_ty(ty);
        check_bnds(bnds); then true;
  end matchcontinue;
end check_bnds;

protected function check_ty
  input Types.Ty in_ty;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_ty)
    local
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      Types.Ty ty;
      TupleIdentTypesTyList bnds;
    case (Types.ARITH(_)) then true; 
    case (Types.ARR(_,ty))
      equation 
        check_ty(ty); then true;
    case (Types.REC(Types.RECORD(_,bnds)))
      equation 
        check_bnds(bnds); then true;
    case (Types.PTR(ty)) " require that UNFOLD is preceeded by PTR "
      equation 
        true = isunfold(ty); then true;
    case (Types.PTR(ty))
      equation 
        false = isunfold(ty);
        check_ty(ty); then true;
  end matchcontinue;
end check_ty;

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

protected function elab_rvalue
  input Env in_env;
  input Absyn.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_env,in_exp)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      type TCodeExpList = list<TCode.Exp>;
      type AbsynExpList = list<Absyn.Exp>;
      TupleIdentBndList env;
      Integer i;
      Real r;
      Bnd bnd;
      TCode.Exp exp,exp_1,exp_2,exp1_1,exp2_1,exp3;
      Types.Ty ty,ty_1,ty_2,rty,rty1,rty2,rty3,resty;
      Ident id;
      Absyn.Exp exp1,exp2;
      Absyn.UnOp unop;
      Absyn.BinOp binop;
      Absyn.RelOp relop;
      TypesTyList argtys;
      TCodeExpList args_1;
      AbsynExpList args;
    case (env,Absyn.INT(i)) then (TCode.ICON(i),Types.ARITH(Types.INT)); 
    case (env,Absyn.REAL(r)) then (TCode.RCON(r),Types.ARITH(Types.REAL)); 
    case (env,Absyn.IDENT(id)) " id "
      equation 
        bnd = lookup(env, id);
        (exp,ty) = rvalue_id(bnd, id); then (exp,ty);
    case (env,Absyn.CAST(ty,exp)) " type cast "
      local
        Absyn.Ty ty;
        Absyn.Exp exp;
      equation 
        (exp_1,ty_1) = elab_rvalue_decay(env, exp);
        ty_2 = elab_ty(env, ty);
        exp_2 = Types.cast_cnv(exp_1, ty_1, ty_2); then (exp_2,ty_2);
    case (env,Absyn.FIELD(exp,id)) " fieldref:  exp.id "
      local Absyn.Exp exp;
      equation 
        (exp_1,ty) = elab_field(env, exp, id);
        (exp_2,ty_1) = rvalue_var(ty, exp_1); then (exp_2,ty_1);
    case (env,Absyn.UNARY(unop,exp)) " unop exp "
      local Absyn.Exp exp;
      equation 
        (exp_1,rty) = elab_unary_rvalue(env, unop, exp); then (exp_1,rty);
    case (env,Absyn.BINARY(exp1,binop,exp2)) " exp1 binop exp2 "
      equation 
        (exp1_1,rty1) = elab_rvalue_decay(env, exp1);
        (exp2_1,rty2) = elab_rvalue_decay(env, exp2);
        (exp3,rty3) = Types.bin_cnv(exp1_1, rty1, binop, exp2_1, rty2); then (exp3,rty3);
    case (env,Absyn.RELATION(exp1,relop,exp2)) " exp1 relop exp2 "
      equation 
        (exp1_1,rty1) = elab_rvalue_decay(env, exp1);
        (exp2_1,rty2) = elab_rvalue_decay(env, exp2);
        exp3 = Types.rel_cnv(exp1_1, rty1, relop, exp2_1, rty2); then (exp3,Types.ARITH(Types.INT));
    case (env,Absyn.EQUALITY(exp1,exp2)) " exp1 = exp2 "
      equation 
        (exp1_1,rty1) = elab_rvalue_decay(env, exp1);
        (exp2_1,rty2) = elab_rvalue_decay(env, exp2);
        exp3 = Types.eq_cnv(exp1_1, rty1, exp2_1, rty2); then (exp3,Types.ARITH(Types.INT));
    case (env,Absyn.FCALL(id,args))
      equation 
        FUNCbnd(argtys,resty) = lookup(env, id);
        args_1 = elab_args(env, args, argtys, {}); then (TCode.FCALL(id,args_1),resty);
  end matchcontinue;
end elab_rvalue;

protected function elab_unary_rvalue
  input Env in_env;
  input Absyn.UnOp in_unop;
  input Absyn.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_env,in_unop,in_exp)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TCode.Exp exp_1,exp_2;
      Types.Ty ty;
      TupleIdentBndList env;
      Absyn.Exp exp;
      TCode.Ty ty_1;
    case (env,Absyn.ADDR(),exp)
      equation 
        (exp_1,ty) = elab_lvalue(env, exp); then (exp_1,Types.PTR(ty));
    case (env,Absyn.INDIR(),exp)
      equation 
        (exp_1,Types.PTR(ty)) = elab_rvalue_decay(env, exp);
        ty_1 = Types.ty_cnv(ty); then (TCode.UNARY(TCode.LOAD(ty_1),exp_1),ty);
    case (env,Absyn.NOT(),exp)
      equation 
        (exp_1,ty) = elab_rvalue_decay(env, exp);
        exp_2 = Types.cond_cnv(exp_1, ty); then (TCode.BINARY(exp_2,TCode.IEQ(),TCode.ICON(0)),Types.ARITH(Types.INT));
  end matchcontinue;
end elab_unary_rvalue;

protected function elab_rvalue_decay
  input Env in_env;
  input Absyn.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_env,in_exp)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TCode.Exp exp_1,exp_2;
      Types.Ty ty,ty_1;
      TupleIdentBndList env;
      Absyn.Exp exp;
    case (env,exp)
      equation 
        (exp_1,ty) = elab_rvalue(env, exp);
        (exp_2,ty_1) = Types.decay(exp_1, ty); then (exp_2,ty_1);
  end matchcontinue;
end elab_rvalue_decay;

protected function rvalue_id
  input Bnd in_bnd;
  input Absyn.Ident in_ident;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_bnd,in_ident)
    local
      Integer i;
      Real r;
      TCode.Exp exp_1;
      Types.Ty ty_1,ty;
      Ident id;
    case (CONSTbnd(INTcon(i)),_) then (TCode.ICON(i),Types.ARITH(Types.INT)); 
    case (CONSTbnd(REALcon(r)),_) then (TCode.RCON(r),Types.ARITH(Types.REAL)); 
    case (NILbnd(),_) then (TCode.ICON(0),Types.PTRNIL); 
    case (VARbnd(ty),id)
      equation 
        (exp_1,ty_1) = rvalue_var(ty, TCode.ADDR(id)); then (exp_1,ty_1);
  end matchcontinue;
end rvalue_id;

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

protected function elab_arg
  input Env env;
  input Absyn.Exp exp;
  input Types.Ty ty;
  output TCode.Exp exp_2;
protected 
  TCode.Exp exp_1,exp_2;
  Types.Ty ty_1;
algorithm 
  (exp_1,ty_1) := elab_rvalue(env, exp);
  exp_2 := Types.asg_cnv(exp_1, ty_1, ty);
end elab_arg;

protected function elab_args
  input Env in_env;
  input AbsynExpList in_absynexplist;
  input TypesTyList in_typestylist;
  input TCodeExpList in_tcodeexplist;
  output TCodeExpList out_tcodeexplist;
protected 
  type AbsynExpList = list<Absyn.Exp>;
  type TCodeExpList = list<TCode.Exp>;
algorithm 
  out_tcodeexplist:=
  matchcontinue (in_env,in_absynexplist,in_typestylist,in_tcodeexplist)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TCodeExpList args_2,args_1,exps_2,exps_1;
      TCode.Exp exp_1;
      TupleIdentBndList env;
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

protected function elab_lvalue
  input Env in_env;
  input Absyn.Exp in_exp;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_env,in_exp)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      Types.Ty ty;
      TupleIdentBndList env;
      Ident id;
      TCode.Exp exp_1;
      Absyn.Exp exp;
    case (env,Absyn.IDENT(id))
      equation 
        VARbnd(ty) = lookup(env, id); then (TCode.ADDR(id),ty);
    case (env,Absyn.FIELD(exp,id))
      equation 
        (exp_1,ty) = elab_field(env, exp, id); then (exp_1,ty);
    case (env,Absyn.UNARY(Absyn.INDIR(),exp))
      equation 
        (exp_1,Types.PTR(ty)) = elab_rvalue_decay(env, exp); then (exp_1,ty);
  end matchcontinue;
end elab_lvalue;

protected function elab_field
  input Env in_env;
  input Absyn.Exp in_exp;
  input Absyn.Ident in_ident;
  output TCode.Exp out_exp;
  output Types.Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_env,in_exp,in_ident)
    local
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TCode.Exp exp_1;
      Types.Record r;
      TupleIdentTypesTyList bnds;
      Types.Ty ty;
      TCode.Record r_1;
      TupleIdentBndList env;
      Absyn.Exp exp;
      Ident id;
    case (env,exp,id)
      equation 
        (exp_1,Types.REC(r)) = elab_lvalue(env, exp);
        bnds = Types.unfold_rec(r);
        ty = lookup_1(bnds, id);
        r_1 = Types.rec_cnv(r); then (TCode.UNARY(TCode.OFFSET(r_1,id),exp_1),ty);
  end matchcontinue;
end elab_field;

protected function elab_stmt
  input TypesTyOption in_typestyoption;
  input Env in_env;
  input Absyn.Stmt in_stmt;
  output TCode.Stmt out_stmt;
protected 
  type TypesTyOption = Option<Types.Ty>;
algorithm 
  out_stmt:=
  matchcontinue (in_typestyoption,in_env,in_stmt)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      type TCodeExpList = list<TCode.Exp>;
      type AbsynExpList = list<Absyn.Exp>;
      TCode.Exp lval,rval,rval_1,exp_1,exp_2;
      Types.Ty lvalty,rvalty,ety,rty;
      TCode.Ty lvalty_1,rty_1;
      TypesTyOption fty;
      TupleIdentBndList env;
      Absyn.Exp lhs,rhs,exp;
      TypesTyList argtys;
      TCodeExpList args_1;
      Ident id;
      AbsynExpList args;
      TCode.Stmt stmt_1,stmt1_1,stmt2_1;
      Absyn.Stmt stmt,stmt1,stmt2;
    case (fty,env,Absyn.ASSIGN(lhs,rhs)) " lhs := rhs; "
      equation 
        (lval,lvalty) = elab_lvalue(env, lhs);
        (rval,rvalty) = elab_rvalue(env, rhs);
        rval_1 = Types.asg_cnv(rval, rvalty, lvalty);
        lvalty_1 = Types.ty_cnv(lvalty); then TCode.STORE(lvalty_1,lval,rval_1);
    case (fty,env,Absyn.PCALL(id,args)) "  procid(args); "
      equation 
        PROCbnd(argtys) = lookup(env, id);
        args_1 = elab_args(env, args, argtys, {}); then TCode.PCALL(id,args_1);
    case (SOME(rty),env,Absyn.FRETURN(exp))
      equation 
        (exp_1,ety) = elab_rvalue(env, exp);
        exp_2 = Types.asg_cnv(exp_1, ety, rty);
        rty_1 = Types.ty_cnv(rty); then TCode.RETURN(SOME((rty_1,exp_2)));
    case (NONE,env,Absyn.PRETURN()) then TCode.RETURN(NONE);  " return "
    case (fty,env,Absyn.WHILE(exp,stmt)) " while exp do stmt "
      equation 
        (exp_1,ety) = elab_rvalue_decay(env, exp);
        exp_2 = Types.cond_cnv(exp_1, ety);
        stmt_1 = elab_stmt(fty, env, stmt); then TCode.WHILE(exp_2,stmt_1);
    case (fty,env,Absyn.IF(exp,stmt1,stmt2))
      equation 
        (exp_1,ety) = elab_rvalue_decay(env, exp);
        exp_2 = Types.cond_cnv(exp_1, ety);
        stmt1_1 = elab_stmt(fty, env, stmt1);
        stmt2_1 = elab_stmt(fty, env, stmt2); then TCode.IF(exp_2,stmt1_1,stmt2_1);
    case (fty,env,Absyn.SEQ(stmt1,stmt2))
      equation 
        stmt1_1 = elab_stmt(fty, env, stmt1);
        stmt2_1 = elab_stmt(fty, env, stmt2); then TCode.SEQ(stmt1_1,stmt2_1);
    case (fty,env,Absyn.SKIP()) then TCode.SKIP();  " empty stmt  ; "
  end matchcontinue;
end elab_stmt;

protected function elab_vars
  input Env in_env;
  input AbsynVarBndList in_absynvarbndlist;
  input TupleAbsynIdentTypesTyList in_tupleabsynidenttypestylist;
  output TupleAbsynIdentTypesTyList out_tupleabsynidenttypestylist;
protected 
  type TupleAbsynIdentTypesTy = tuple<AbsynIdent,TypesTy>;
  type TupleAbsynIdentTypesTyList = list<TupleAbsynIdentTypesTy>;
algorithm 
  out_tupleabsynidenttypestylist:=
  matchcontinue (in_env,in_absynvarbndlist,in_tupleabsynidenttypestylist)
    local
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TupleIdentTypesTyList vars_2,vars_1;
      Ident id;
      Types.Ty ty;
      TupleIdentBndList env;
      Absyn.VarBnd var;
      AbsynVarBndList vars;
    case (_,{},vars_1)
      equation 
        vars_2 = list_reverse(vars_1); then vars_2;
    case (env,var :: vars,vars_1)
      equation 
        (id,ty) = elab_var(env, var);
        vars_2 = elab_vars(env, vars, (id,ty) :: vars_1); then vars_2;
  end matchcontinue;
end elab_vars;

protected function elab_var
  input Env in_env;
  input Absyn.VarBnd in_varbnd;
  output Absyn.Ident out_ident;
  output Types.Ty out_ty;
algorithm 
  (out_ident,out_ty):=
  matchcontinue (in_env,in_varbnd)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      Types.Ty ty_1;
      TupleIdentBndList env;
      Ident id;
      Absyn.Ty ty;
    case (env,Absyn.VARBND(id,ty))
      equation 
        ty_1 = elab_ty(env, ty); then (id,ty_1);
  end matchcontinue;
end elab_var;

protected function mkvar
  input TupleIdentTypesTy in_tupleidenttypesty;
  output TCode.Var out_var;
protected 
  type TupleIdentTypesTy = tuple<Ident,TypesTy>;
algorithm 
  out_var:=
  matchcontinue (in_tupleidenttypesty)
    local
      TCode.Ty ty_1;
      Ident id;
      Types.Ty ty;
    case ((id,ty))
      equation 
        ty_1 = Types.ty_cnv(ty); then TCode.VAR(id,ty_1);
  end matchcontinue;
end mkvar;

protected function mkvarbnd
  input TupleIdentTypesTy in_tupleidenttypesty;
  output TupleIdentBnd out_tupleidentbnd;
protected 
  type TupleIdentTypesTy = tuple<Ident,TypesTy>;
  type TupleIdentBnd = tuple<Ident,Bnd>;
algorithm 
  out_tupleidentbnd:=
  matchcontinue (in_tupleidenttypesty)
    local
      Ident id;
      Types.Ty ty;
    case ((id,ty)) then (id,VARbnd(ty)); 
  end matchcontinue;
end mkvarbnd;

protected function elab_formals
  input Env in_env;
  input AbsynVarBndList in_absynvarbndlist;
  output TCodeVarList out_tcodevarlist;
  output TupleIdentBndList out_tupleidentbndlist;
  output TypesTyList out_typestylist;
protected 
  type TCodeVarList = list<TCode.Var>;
  type TupleIdentBnd = tuple<Ident,Bnd>;
  type TupleIdentBndList = list<TupleIdentBnd>;
algorithm 
  (out_tcodevarlist,out_tupleidentbndlist,out_typestylist):=
  matchcontinue (in_env,in_absynvarbndlist)
    local
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      TupleIdentTypesTyList pre_formals,pre_formals_1;
      TCodeVarList formals_1;
      TupleIdentBndList argenv,env;
      TypesTyList argtys;
      AbsynVarBndList formals;
    case (env,formals)
      equation 
        pre_formals = elab_vars(env, formals, {});
        pre_formals_1 = map(decay_formal, pre_formals);
        formals_1 = map(mkvar, pre_formals_1);
        argenv = map(mkvarbnd, pre_formals_1);
        argtys = map(extract_ty, pre_formals_1); then (formals_1,argenv,argtys);
  end matchcontinue;
end elab_formals;

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
  input TupleIdentTypesTy in_tupleidenttypesty;
  output Ident out_ident;
  output Types.Ty out_ty;
protected 
  type TupleIdentTypesTy = tuple<Ident,TypesTy>;
algorithm 
  (out_ident,out_ty):=
  matchcontinue (in_tupleidenttypesty)
    local
      Types.Ty ty_1,ty;
      Ident id;
    case ((id,ty))
      equation 
        ty_1 = decay_formal_ty(ty); then (id,ty_1);
  end matchcontinue;
end decay_formal;

protected function extract_ty
  input TupleIdentTypesTy in_tupleidenttypesty;
  output Types.Ty out_ty;
protected 
  type TupleIdentTypesTy = tuple<Ident,TypesTy>;
algorithm 
  out_ty:=
  matchcontinue (in_tupleidenttypesty)
    local Types.Ty y;
    case ((_,y)) then y; 
  end matchcontinue;
end extract_ty;

protected function elab_subbnd
  input Env in_env;
  input Absyn.SubBnd in_subbnd;
  output Env out_env;
  output TCode.Proc out_proc;
algorithm 
  (out_env,out_proc):=
  matchcontinue (in_env,in_subbnd)
    local
      type TCodeVarList = list<TCode.Var>;
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      type TCodeBlockOption = Option<TCode.Block>;
      type AbsynBlockOption = Option<Absyn.Block>;
      Types.Ty ty0,ty1;
      TCode.Ty ty2;
      TCodeVarList formals_1;
      TupleIdentBndList argenv,env1,env2,env0;
      TypesTyList argtys;
      TCodeBlockOption block_1;
      Ident id;
      AbsynVarBndList formals;
      Absyn.Ty ty;
      AbsynBlockOption block_;
    case (env0,Absyn.FUNCBND(id,formals,ty,block_)) " elaborate a function "
      equation 
        ty0 = elab_ty(env0, ty);
        ty1 = decay_formal_ty(ty0);
        ty2 = Types.ty_cnv(ty1) " ret ARR ==> ret PTR ";
        (formals_1,argenv,argtys) = elab_formals(env0, formals);
        env1 = (id,FUNCbnd(argtys,ty1)) :: env0;
        env2 = list_append(argenv, env1);
        block_1 = elab_body(SOME(ty1), env2, block_); then (env1,TCode.PROC(id,formals_1,SOME(ty2),block_1));
    case (env0,Absyn.PROCBND(id,formals,block_)) " elaborate a procedure "
      equation 
        (formals_1,argenv,argtys) = elab_formals(env0, formals);
        env1 = (id,PROCbnd(argtys)) :: env0;
        env2 = list_append(argenv, env1);
        block_1 = elab_body(NONE, env2, block_); then (env1,TCode.PROC(id,formals_1,NONE,block_1));
  end matchcontinue;
end elab_subbnd;

protected function elab_subbnds
  input Env in_env;
  input AbsynSubBndList in_absynsubbndlist;
  input TCodeProcList in_tcodeproclist;
  output Env out_env;
  output TCodeProcList out_tcodeproclist;
protected 
  type AbsynSubBndList = list<Absyn.SubBnd>;
  type TCodeProcList = list<TCode.Proc>;
algorithm 
  (out_env,out_tcodeproclist):=
  matchcontinue (in_env,in_absynsubbndlist,in_tcodeproclist)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TCodeProcList subbnds_2,subbnds_1;
      TupleIdentBndList env,env_1,env_2;
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
  input Env in_env;
  input AbsynBlockOption in_absynblockoption;
  output TCodeBlockOption out_tcodeblockoption;
protected 
  type TypesTyOption = Option<Types.Ty>;
  type AbsynBlockOption = Option<Absyn.Block>;
  type TCodeBlockOption = Option<TCode.Block>;
algorithm 
  out_tcodeblockoption:=
  matchcontinue (in_typestyoption,in_env,in_absynblockoption)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      TCode.Block block_1;
      TypesTyOption fty;
      TupleIdentBndList env;
      Absyn.Block block_;
    case (_,_,NONE) then NONE; 
    case (fty,env,SOME(block_))
      equation 
        block_1 = elab_block(fty, env, block_); then SOME(block_1);
  end matchcontinue;
end elab_body;

protected function elab_block
  input TypesTyOption in_typestyoption;
  input Env in_env;
  input Absyn.Block in_block;
  output TCode.Block out_block;
protected 
  type TypesTyOption = Option<Types.Ty>;
algorithm 
  out_block:=
  matchcontinue (in_typestyoption,in_env,in_block)
    local
      type TupleIdentBnd = tuple<Ident,Bnd>;
      type TupleIdentBndList = list<TupleIdentBnd>;
      type TupleIdentTypesTy = tuple<Ident,TypesTy>;
      type TupleIdentTypesTyList = list<TupleIdentTypesTy>;
      type TCodeVarList = list<TCode.Var>;
      type TCodeProcList = list<TCode.Proc>;
      type AbsynConBndList = list<Absyn.ConBnd>;
      type AbsynTyBndList = list<Absyn.TyBnd>;
      type AbsynSubBndList = list<Absyn.SubBnd>;
      TupleIdentBndList env1,env2,varenv,env3,env4,env0;
      TupleIdentTypesTyList pre_vars;
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
        env2 = elab_types(env1, types) " also pushes on env ";
        pre_vars = elab_vars(env2, vars, {}) " also pushes on env ";
        vars_1 = map(mkvar, pre_vars) " only makes pre_vars alst ";
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
      Ident id;
      Absyn.Block block_;
    case (Absyn.PROG(id,block_))
      equation 
        block_1 = elab_block(NONE, env_init, block_); then TCode.PROG(id,block_1);
  end matchcontinue;
end elaborate;
end Static;

