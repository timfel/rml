package Flatten " flatten.rml "
import tcode;
import fcode;

uniontype Scope
  record SCOPE
    FCode.Level x1;
    FCode.Ident x2;
  end SCOPE;
end Scope;

uniontype Bnd
  record VAR
    FCode.Level x1;
    FCode.Record x2;
  end VAR;
  record PROC
    FCode.Ident x1;
  end PROC;
end Bnd;

type TupleStringBnd = tuple<String,Bnd>;

type TupleStringBndList = list<TupleStringBnd>;
constant TupleStringBndList env_init=list(("read",PROC("petrol_read")),
          ("write",PROC("petrol_write")),("trunc",PROC("petrol_trunc")));

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
      FuncTypeType_aToType_b F;
      Type_a x;
      VType_aList xs;
    case (_,{}) then {}; 
    case (F,x :: xs)
      equation 
        y = F(x);
        ys = map(F, xs); then y :: ys;
  end matchcontinue;
end map;

protected function trans_ty "******************************************************************************"
  input TCode.Ty in_ty;
  output FCode.Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_ty)
    local
      FCode.Ty ty_1;
      TCode.Ty ty;
      Integer sz,stamp;
      FCode.Record r_1;
      TCode.Record r;
    case (TCode.CHAR()) then FCode.CHAR(); 
    case (TCode.INT()) then FCode.INT(); 
    case (TCode.REAL()) then FCode.REAL(); 
    case (TCode.PTR(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.PTR(ty_1);
    case (TCode.ARR(sz,ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.ARR(sz,ty_1);
    case (TCode.REC(r))
      equation 
        r_1 = trans_rec(r); then FCode.REC(r_1);
    case (TCode.UNFOLD(stamp)) then FCode.UNFOLD(stamp); 
  end matchcontinue;
end trans_ty;

protected function trans_rec
  input TCode.Record in_record;
  output FCode.Record out_record;
algorithm 
  out_record:=
  matchcontinue (in_record)
    local
      type FCodeVarList = list<FCode.Var>;
      type TCodeVarList = list<TCode.Var>;
      FCodeVarList bnds_1;
      Integer stamp;
      TCodeVarList bnds;
    case (TCode.RECORD(stamp,bnds))
      equation 
        bnds_1 = map(trans_var, bnds); then FCode.RECORD(stamp,bnds_1);
  end matchcontinue;
end trans_rec;

protected function trans_var
  input TCode.Var in_var;
  output FCode.Var out_var;
algorithm 
  out_var:=
  matchcontinue (in_var)
    local
      FCode.Ty ty_1;
      String id;
      TCode.Ty ty;
    case (TCode.VAR(id,ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.VAR(id,ty_1);
  end matchcontinue;
end trans_var;

protected function trans_tyopt
  input TCodeTyOption in_tcodetyoption;
  output FCodeTyOption out_fcodetyoption;
protected 
  type TCodeTyOption = Option<TCode.Ty>;
  type FCodeTyOption = Option<FCode.Ty>;
algorithm 
  out_fcodetyoption:=
  matchcontinue (in_tcodetyoption)
    local
      FCode.Ty ty_1;
      TCode.Ty ty;
    case NONE then NONE; 
    case (SOME(ty))
      equation 
        ty_1 = trans_ty(ty); then SOME(ty_1);
  end matchcontinue;
end trans_tyopt;

protected function trans_unop
  input TCode.UnOp in_unop;
  output FCode.UnOp out_unop;
algorithm 
  out_unop:=
  matchcontinue (in_unop)
    local
      FCode.Ty ty_1;
      TCode.Ty ty;
      FCode.Record r_1;
      TCode.Record r;
      String id;
    case (TCode.CtoI()) then FCode.CtoI(); 
    case (TCode.ItoR()) then FCode.ItoR(); 
    case (TCode.RtoI()) then FCode.RtoI(); 
    case (TCode.ItoC()) then FCode.ItoC(); 
    case (TCode.PtoI()) then FCode.PtoI(); 
    case (TCode.TOPTR(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.TOPTR(ty_1);
    case (TCode.LOAD(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.LOAD(ty_1);
    case (TCode.OFFSET(r,id))
      equation 
        r_1 = trans_rec(r); then FCode.OFFSET(r_1,id);
  end matchcontinue;
end trans_unop;

protected function trans_binop
  input TCode.BinOp in_binop;
  output FCode.BinOp out_binop;
algorithm 
  out_binop:=
  matchcontinue (in_binop)
    local
      FCode.Ty ty_1;
      TCode.Ty ty;
    case (TCode.IADD()) then FCode.IADD(); 
    case (TCode.ISUB()) then FCode.ISUB(); 
    case (TCode.IMUL()) then FCode.IMUL(); 
    case (TCode.IDIV()) then FCode.IDIV(); 
    case (TCode.IMOD()) then FCode.IMOD(); 
    case (TCode.IAND()) then FCode.IAND(); 
    case (TCode.IOR()) then FCode.IOR(); 
    case (TCode.ILT()) then FCode.ILT(); 
    case (TCode.ILE()) then FCode.ILE(); 
    case (TCode.IEQ()) then FCode.IEQ(); 
    case (TCode.RADD()) then FCode.RADD(); 
    case (TCode.RSUB()) then FCode.RSUB(); 
    case (TCode.RMUL()) then FCode.RMUL(); 
    case (TCode.RDIV()) then FCode.RDIV(); 
    case (TCode.RLT()) then FCode.RLT(); 
    case (TCode.RLE()) then FCode.RLE(); 
    case (TCode.REQ()) then FCode.REQ(); 
    case (TCode.PADD(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.PADD(ty_1);
    case (TCode.PSUB(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.PSUB(ty_1);
    case (TCode.PDIFF(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.PDIFF(ty_1);
    case (TCode.PLT(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.PLT(ty_1);
    case (TCode.PLE(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.PLE(ty_1);
    case (TCode.PEQ(ty))
      equation 
        ty_1 = trans_ty(ty); then FCode.PEQ(ty_1);
  end matchcontinue;
end trans_binop;

protected function trans_procid
  input TupleType_aBndList env;
  input Type_a id;
  output String id_1;
protected 
  replaceable type Type_a;
  type TupleType_aBnd = tuple<Type_a,Bnd>;
  type TupleType_aBndList = list<TupleType_aBnd>;
  String id_1;
algorithm 
  PROC(id_1) := lookup(env, id);
end trans_procid;

protected function trans_exp
  input TupleStringBndList in_tuplestringbndlist;
  input TCode.Exp in_exp;
  output FCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_tuplestringbndlist,in_exp)
    local
      type FCodeExpList = list<FCode.Exp>;
      type TCodeExpList = list<TCode.Exp>;
      Integer x,lev;
      FCode.Record r;
      TupleStringBndList env;
      String id,id_1;
      FCode.UnOp unop_1;
      FCode.Exp exp_1,exp1_1,exp2_1;
      TCode.UnOp unop;
      TCode.Exp exp,exp1,exp2;
      FCode.BinOp binop_1;
      TCode.BinOp binop;
      FCodeExpList args_1;
      TCodeExpList args;
    case (_,TCode.ICON(x)) then FCode.ICON(x); 
    case (_,TCode.RCON(x))
      local Real x; then FCode.RCON(x);
    case (env,TCode.ADDR(id))
      equation 
        VAR(lev,r) = lookup(env, id); then FCode.UNARY(FCode.OFFSET(r,id),
          FCode.UNARY(FCode.TOPTR(FCode.REC(r)),FCode.DISPLAY(lev)));
    case (env,TCode.UNARY(unop,exp))
      equation 
        unop_1 = trans_unop(unop);
        exp_1 = trans_exp(env, exp); then FCode.UNARY(unop_1,exp_1);
    case (env,TCode.BINARY(exp1,binop,exp2))
      equation 
        binop_1 = trans_binop(binop);
        exp1_1 = trans_exp(env, exp1);
        exp2_1 = trans_exp(env, exp2); then FCode.BINARY(exp1_1,binop_1,exp2_1);
    case (env,TCode.FCALL(id,args))
      equation 
        id_1 = trans_procid(env, id);
        args_1 = trans_args(env, args, {}); then FCode.FCALL(id_1,args_1);
  end matchcontinue;
end trans_exp;

protected function trans_args
  input TupleStringBndList in_tuplestringbndlist;
  input TCodeExpList in_tcodeexplist;
  input FCodeExpList in_fcodeexplist;
  output FCodeExpList out_fcodeexplist;
protected 
  type TCodeExpList = list<TCode.Exp>;
  type FCodeExpList = list<FCode.Exp>;
algorithm 
  out_fcodeexplist:=
  matchcontinue (in_tuplestringbndlist,in_tcodeexplist,in_fcodeexplist)
    local
      FCodeExpList args_2,args_1;
      FCode.Exp arg_1;
      TupleStringBndList env;
      TCode.Exp arg;
      TCodeExpList args;
    case (_,{},args_1)
      equation 
        args_2 = list_reverse(args_1); then args_2;
    case (env,arg :: args,args_1)
      equation 
        arg_1 = trans_exp(env, arg);
        args_2 = trans_args(env, args, arg_1 :: args_1); then args_2;
  end matchcontinue;
end trans_args;

protected function trans_return
  input TupleStringBndList in_tuplestringbndlist;
  input TupleTCodeTyTCodeExpOption in_tupletcodetytcodeexpoption;
  output TupleFCodeTyFCodeExpOption out_tuplefcodetyfcodeexpoption;
protected 
  type TupleTCodeTyTCodeExp = tuple<TCodeTy,TCodeExp>;
  type TupleTCodeTyTCodeExpOption = Option<TupleTCodeTyTCodeExp>;
  type TupleFCodeTyFCodeExp = tuple<FCodeTy,FCodeExp>;
  type TupleFCodeTyFCodeExpOption = Option<TupleFCodeTyFCodeExp>;
algorithm 
  out_tuplefcodetyfcodeexpoption:=
  matchcontinue (in_tuplestringbndlist,in_tupletcodetytcodeexpoption)
    local
      FCode.Ty ty_1;
      FCode.Exp exp_1;
      TupleStringBndList env;
      TCode.Ty ty;
      TCode.Exp exp;
    case (_,NONE) then NONE; 
    case (env,SOME((ty,exp)))
      equation 
        ty_1 = trans_ty(ty);
        exp_1 = trans_exp(env, exp); then SOME((ty_1,exp_1));
  end matchcontinue;
end trans_return;

protected function trans_stmt
  input TupleStringBndList in_tuplestringbndlist;
  input TCode.Stmt in_stmt;
  output FCode.Stmt out_stmt;
algorithm 
  out_stmt:=
  matchcontinue (in_tuplestringbndlist,in_stmt)
    local
      type FCodeExpList = list<FCode.Exp>;
      type TCodeExpList = list<TCode.Exp>;
      type TupleFCodeTyFCodeExp = tuple<FCodeTy,FCodeExp>;
      type TupleFCodeTyFCodeExpOption = Option<TupleFCodeTyFCodeExp>;
      type TupleTCodeTyTCodeExp = tuple<TCodeTy,TCodeExp>;
      type TupleTCodeTyTCodeExpOption = Option<TupleTCodeTyTCodeExp>;
      FCode.Ty ty_1;
      FCode.Exp lhs_1,rhs_1,exp_1;
      TupleStringBndList env;
      TCode.Ty ty;
      TCode.Exp lhs,rhs,exp;
      String id_1,id;
      FCodeExpList args_1;
      TCodeExpList args;
      TupleFCodeTyFCodeExpOption ret_1;
      TupleTCodeTyTCodeExpOption ret;
      FCode.Stmt stmt_1,stmt1_1,stmt2_1;
      TCode.Stmt stmt,stmt1,stmt2;
    case (env,TCode.STORE(ty,lhs,rhs))
      equation 
        ty_1 = trans_ty(ty);
        lhs_1 = trans_exp(env, lhs);
        rhs_1 = trans_exp(env, rhs); then FCode.STORE(ty_1,lhs_1,rhs_1);
    case (env,TCode.PCALL(id,args))
      equation 
        id_1 = trans_procid(env, id);
        args_1 = trans_args(env, args, {}); then FCode.PCALL(id_1,args_1);
    case (env,TCode.RETURN(ret))
      equation 
        ret_1 = trans_return(env, ret); then FCode.RETURN(ret_1);
    case (env,TCode.WHILE(exp,stmt))
      equation 
        exp_1 = trans_exp(env, exp);
        stmt_1 = trans_stmt(env, stmt); then FCode.WHILE(exp_1,stmt_1);
    case (env,TCode.IF(exp,stmt1,stmt2))
      equation 
        exp_1 = trans_exp(env, exp);
        stmt1_1 = trans_stmt(env, stmt1);
        stmt2_1 = trans_stmt(env, stmt2); then FCode.IF(exp_1,stmt1_1,stmt2_1);
    case (env,TCode.SEQ(stmt1,stmt2))
      equation 
        stmt1_1 = trans_stmt(env, stmt1);
        stmt2_1 = trans_stmt(env, stmt2); then FCode.SEQ(stmt1_1,stmt2_1);
    case (_,TCode.SKIP()) then FCode.SKIP(); 
  end matchcontinue;
end trans_stmt;

protected function env_plus_vars
  input TupleStringType_aList in_tuplestringtype_alist;
  input Type_a in_type_a;
  input FCodeVarList in_fcodevarlist;
  output TupleStringType_aList out_tuplestringtype_alist;
protected 
  replaceable type Type_a;
  type TupleStringType_a = tuple<String,Type_a>;
  type TupleStringType_aList = list<TupleStringType_a>;
  type FCodeVarList = list<FCode.Var>;
algorithm 
  out_tuplestringtype_alist:=
  matchcontinue (in_tuplestringtype_alist,in_type_a,in_fcodevarlist)
    local
      Type_a env,bnd;
      TupleStringType_aList env_1;
      String id;
      FCodeVarList vars;
    case (env,_,{}) then env; 
    case (env,bnd,FCode.VAR(id,_) :: vars)
      local TupleStringType_aList env;
      equation 
        env_1 = env_plus_vars((id,bnd) :: env, bnd, vars); then env_1;
  end matchcontinue;
end env_plus_vars;

protected function flatten_proc
  input Scope in_scope;
  input TupleStringBndList in_tuplestringbndlist;
  input TCode.Proc in_proc;
  input FCodeProcList in_fcodeproclist;
  output TupleStringBndList out_tuplestringbndlist;
  output FCodeProcList out_fcodeproclist;
protected 
  type FCodeProcList = list<FCode.Proc>;
algorithm 
  (out_tuplestringbndlist,out_fcodeproclist):=
  matchcontinue (in_scope,in_tuplestringbndlist,in_proc,in_fcodeproclist)
    local
      type FCodeVarList = list<FCode.Var>;
      type FCodeTyOption = Option<FCode.Ty>;
      type TCodeVarList = list<TCode.Var>;
      type TCodeTyOption = Option<TCode.Ty>;
      type TCodeProcList = list<TCode.Proc>;
      FCodeVarList formals_1,locals_1,vars_1;
      FCodeTyOption tyopt_1;
      TupleStringBndList env0,env1,env2,env3;
      String id,id_1,prefix1,prefix0;
      TCodeVarList formals,locals;
      TCodeTyOption tyopt;
      FCodeProcList procs0,procs1;
      Integer level1,stamp,level0;
      FCode.Record r;
      FCode.Stmt stmt_1;
      TCodeProcList procs;
      TCode.Stmt stmt;
    case (_,env0,TCode.PROC(id,formals,tyopt,NONE),procs0)
      equation 
        formals_1 = map(trans_var, formals);
        tyopt_1 = trans_tyopt(tyopt); then ((id,PROC(id)) :: env0,FCode.PROC(id,formals_1,tyopt_1,NONE) :: procs0);
    case (SCOPE(level0,prefix0),env0,TCode.PROC(id,formals,tyopt,SOME(TCode.BLOCK(locals,procs,stmt))),procs0)
      equation 
        level1 = level0 + 1;
        id_1 = string_append(prefix0, id);
        prefix1 = string_append(id_1, "_");
        formals_1 = map(trans_var, formals);
        locals_1 = map(trans_var, locals);
        vars_1 = list_append(formals_1, locals_1);
        stamp = tick();
        r = FCode.RECORD(stamp,vars_1);
        env1 = (id,PROC(id_1)) :: env0;
        env2 = env_plus_vars(env1, VAR(level1,r), vars_1);
        (env3,procs1) = flatten_procs(SCOPE(level1,prefix1), env2, procs, procs0);
        stmt_1 = trans_stmt(env3, stmt);
        tyopt_1 = trans_tyopt(tyopt); then (env1,FCode.PROC(id_1,formals_1,tyopt_1,SOME(FCode.BLOCK(level1,r,stmt_1))) :: procs1);
  end matchcontinue;
end flatten_proc;

protected function flatten_procs
  input Scope in_scope;
  input TupleStringBndList in_tuplestringbndlist;
  input TCodeProcList in_tcodeproclist;
  input FCodeProcList in_fcodeproclist;
  output TupleStringBndList out_tuplestringbndlist;
  output FCodeProcList out_fcodeproclist;
protected 
  type TCodeProcList = list<TCode.Proc>;
  type FCodeProcList = list<FCode.Proc>;
algorithm 
  (out_tuplestringbndlist,out_fcodeproclist):=
  matchcontinue (in_scope,in_tuplestringbndlist,in_tcodeproclist,in_fcodeproclist)
    local
      TupleStringBndList env0,env1,env2;
      FCodeProcList procs0,procs1,procs2;
      Scope scope;
      TCode.Proc proc;
      TCodeProcList procs;
    case (_,env0,{},procs0) then (env0,procs0); 
    case (scope,env0,proc :: procs,procs0)
      equation 
        (env1,procs1) = flatten_proc(scope, env0, proc, procs0);
        (env2,procs2) = flatten_procs(scope, env1, procs, procs1); then (env2,procs2);
  end matchcontinue;
end flatten_procs;

public function flatten
  input TCode.Prog in_prog;
  output FCode.Prog out_prog;
algorithm 
  out_prog:=
  matchcontinue (in_prog)
    local
      type FCodeProcList = list<FCode.Proc>;
      FCodeProcList procs_1;
      String id;
      TCode.Block block_;
    case (TCode.PROG(id,block_))
      equation 
        (_,procs_1) = flatten_proc(SCOPE(-1,""), env_init, 
          TCode.PROC(id,{},NONE,SOME(block_)), {}); then FCode.PROG(procs_1,id);
  end matchcontinue;
end flatten;
end Flatten;

