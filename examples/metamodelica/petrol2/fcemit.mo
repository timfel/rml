package FCEmit " fcemit.rml "
import fcode;

protected function foreach
  input FuncTypeType_alphaTo in_functypetype_alphato;
  input VType_alphaList in_vtype_alphalist;
  output Boolean dummy;
protected 
  function FuncTypeType_alphaTo
    input Type_alpha in_type_alpha;
    output Boolean dummy;
  protected 
    replaceable type Type_alpha;
  end FuncTypeType_alphaTo;
  replaceable type Type_alpha;
  type VType_alphaList = list<Type_alpha>;
algorithm 
  dummy:=
  matchcontinue (in_functypetype_alphato,in_vtype_alphalist)
    local
      FuncTypeType_alphaTo F;
      Type_alpha x;
      VType_alphaList xs;
    case (_,{}) then true; 
    case (F,x :: xs)
      equation 
        F(x);
        foreach(F, xs); then true;
  end matchcontinue;
end foreach;

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
      FuncTypeType_alphaToType_beta F;
      Type_alpha x;
      VType_alphaList xs;
    case (_,{}) then {}; 
    case (F,x :: xs)
      equation 
        y = F(x);
        ys = map(F, xs); then y :: ys;
  end matchcontinue;
end map;

uniontype Base
  record BASE
    String x1;
  end BASE;
  record REC
    Integer x1;
  end REC;
end Base;

type ArgList = list<Arg>;

uniontype InvTy
  record PTRity
    InvTy x1;
  end PTRity;
  record ARRity
    InvTy x1;
    Integer x2;
  end ARRity;
  record VARity
    String x1;
  end VARity;
  record FUNity
    String x1;
    ArgList x2;
  end FUNity;
end InvTy;

uniontype Arg
  record ARG
    Base x1;
    InvTy x2;
  end ARG;
end Arg;

protected function emit_int
  input Integer i;
protected 
  String s;
algorithm 
  s := int_string(i);
  print(s);
end emit_int;

protected function emit_real
  input Real r;
protected 
  String s;
algorithm 
  s := real_string(r);
  print(s);
end emit_real;

protected function emit_struct
  input Integer stamp;
algorithm 
  print("struct rec");
  emit_int(stamp);
end emit_struct;

protected function emit_base
  input Base in_base;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_base)
    local
      String str;
      Integer stamp;
    case (BASE(str))
      equation 
        print(str); then true;
    case (REC(stamp))
      equation 
        emit_struct(stamp); then true;
  end matchcontinue;
end emit_base;

protected function emit_invty
  input InvTy in_invty;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_invty)
    local
      InvTy ity;
      Integer sz;
      String str,id;
      ArgList args;
    case (PTRity(ity))
      equation 
        print("(");
        print("*");
        emit_invty(ity);
        print(")"); then true;
    case (ARRity(ity,sz))
      equation 
        emit_invty(ity);
        print("[");
        emit_int(sz);
        print("]"); then true;
    case (VARity(str))
      equation 
        print(str); then true;
    case (FUNity(id,args))
      equation 
        print(id);
        print("(");
        emit_args(args);
        print(")"); then true;
  end matchcontinue;
end emit_invty;

protected function emit_args
  input ArgList in_arglist;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_arglist)
    local
      Arg arg;
      ArgList args;
    case ({})
      equation 
        print("void"); then true;
    case (arg :: args)
      equation 
        emit_arg(arg);
        foreach(emit_comma_arg, args); then true;
  end matchcontinue;
end emit_args;

protected function emit_arg
  input Arg in_arg;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_arg)
    local
      Base base;
      InvTy ity;
    case (ARG(base,ity))
      equation 
        emit_base(base);
        print(" ");
        emit_invty(ity); then true;
  end matchcontinue;
end emit_arg;

protected function emit_comma_arg
  input Arg arg;
algorithm 
  print(", ");
  emit_arg(arg);
end emit_comma_arg;

protected function invert_ty
  input InvTy in_invty;
  input FCode.Ty in_ty;
  output Base out_base;
  output InvTy out_invty;
algorithm 
  (out_base,out_invty):=
  matchcontinue (in_invty,in_ty)
    local
      InvTy ity,ity_1;
      Base base;
      FCode.Ty ty;
      Integer sz,stamp;
    case (ity,FCode.CHAR()) then (BASE("char"),ity); 
    case (ity,FCode.INT()) then (BASE("int"),ity); 
    case (ity,FCode.REAL()) then (BASE("double"),ity); 
    case (ity,FCode.PTR(ty))
      equation 
        (base,ity_1) = invert_ty(PTRity(ity), ty); then (base,ity_1);
    case (ity,FCode.ARR(sz,ty))
      equation 
        (base,ity_1) = invert_ty(ARRity(ity,sz), ty); then (base,ity_1);
    case (ity,FCode.REC(FCode.RECORD(stamp,_))) then (REC(stamp),ity); 
    case (ity,FCode.UNFOLD(stamp)) then (REC(stamp),ity); 
  end matchcontinue;
end invert_ty;

protected function emit_var
  input FCode.Var in_var;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_var)
    local
      Base base;
      InvTy ity;
      String id;
      FCode.Ty ty;
    case (FCode.VAR(id,ty))
      equation 
        (base,ity) = invert_ty(VARity(id), ty);
        emit_base(base);
        print(" ");
        emit_invty(ity); then true;
  end matchcontinue;
end emit_var;

protected function emit_var_bnd
  input FCode.Var var;
algorithm 
  print("\t");
  emit_var(var);
  print(";\n");
end emit_var_bnd;

protected function emit_rec_bnds
  input FCodeVarList in_fcodevarlist;
  input String in_string;
  output Boolean dummy;
protected 
  type FCodeVarList = list<FCode.Var>;
algorithm 
  dummy:=
  matchcontinue (in_fcodevarlist,in_string)
    local
      String id_1,id,prefix;
      FCode.Ty ty;
      FCodeVarList bnds;
    case ({},_) then true; 
    case (FCode.VAR(id,ty) :: bnds,prefix)
      equation 
        id_1 = string_append(prefix, id);
        emit_var_bnd(FCode.VAR(id_1,ty));
        emit_rec_bnds(bnds, prefix); then true;
  end matchcontinue;
end emit_rec_bnds;

protected function emit_record
  input FCode.Record in_record;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_record)
    local
      type FCodeVarList = list<FCode.Var>;
      String stamp1,prefix0,prefix1;
      Integer stamp0;
      FCodeVarList bnds;
    case (FCode.RECORD(_,{})) then true; 
    case (FCode.RECORD(stamp0,(bnds = _ :: _)))
      equation 
        emit_struct(stamp0);
        print(" {\n");
        stamp1 = int_string(stamp0);
        prefix0 = string_append("rec", stamp1);
        prefix1 = string_append(prefix0, "_");
        emit_rec_bnds(bnds, prefix1);
        print("};\n"); then true;
  end matchcontinue;
end emit_record;

protected function emit_unop
  input FCode.UnOp in_unop;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_unop)
    local
      Base base;
      InvTy ity;
      FCode.Ty ty;
      Integer stamp;
      String id;
    case (FCode.CtoI())
      equation 
        print("(int)("); then true;
    case (FCode.ItoR())
      equation 
        print("(double)("); then true;
    case (FCode.RtoI())
      equation 
        print("(int)("); then true;
    case (FCode.ItoC())
      equation 
        print("(char)("); then true;
    case (FCode.PtoI())
      equation 
        print("(int)("); then true;
    case (FCode.TOPTR(ty))
      equation 
        print("(");
        (base,ity) = invert_ty(VARity(""), FCode.PTR(ty));
        emit_base(base);
        print(" ");
        emit_invty(ity);
        print(")("); then true;
    case (FCode.LOAD(_))
      equation 
        print("*("); then true;
    case (FCode.OFFSET(FCode.RECORD(stamp,_),id))
      equation 
        print("P_OFFSET(rec");
        emit_int(stamp);
        print("_");
        print(id);
        print(","); then true;
  end matchcontinue;
end emit_unop;

protected function binop_to_str
  input FCode.BinOp in_binop;
  output String out_string;
algorithm 
  out_string:=
  matchcontinue (in_binop)
    case (FCode.IADD()) then " + "; 
    case (FCode.ISUB()) then " - "; 
    case (FCode.IMUL()) then " * "; 
    case (FCode.IDIV()) then " / "; 
    case (FCode.IMOD()) then " % "; 
    case (FCode.IAND()) then " && "; 
    case (FCode.IOR()) then " || "; 
    case (FCode.ILT()) then " < "; 
    case (FCode.ILE()) then " <= "; 
    case (FCode.IEQ()) then " == "; 
    case (FCode.RADD()) then " + "; 
    case (FCode.RSUB()) then " - "; 
    case (FCode.RMUL()) then " * "; 
    case (FCode.RDIV()) then " / "; 
    case (FCode.RLT()) then " < "; 
    case (FCode.RLE()) then " <= "; 
    case (FCode.REQ()) then " == "; 
    case (FCode.PADD(_)) then " + "; 
    case (FCode.PSUB(_)) then " - "; 
    case (FCode.PDIFF(_)) then " - "; 
    case (FCode.PLT(_)) then " < "; 
    case (FCode.PLE(_)) then " <= "; 
    case (FCode.PEQ(_)) then " == "; 
  end matchcontinue;
end binop_to_str;

protected function emit_exp
  input FCode.Exp in_exp;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_exp)
    local
      type FCodeExpList = list<FCode.Exp>;
      Integer i,level;
      Real r;
      FCode.UnOp unop;
      FCode.Exp exp,exp1,exp2;
      String str,id;
      FCode.BinOp binop;
      FCodeExpList exps;
    case (FCode.ICON(i))
      equation 
        emit_int(i); then true;
    case (FCode.RCON(r))
      equation 
        emit_real(r); then true;
    case (FCode.DISPLAY(level))
      equation 
        print("display[");
        emit_int(level);
        print("]"); then true;
    case (FCode.UNARY(unop,exp))
      equation 
        emit_unop(unop);
        emit_exp(exp);
        print(")"); then true;
    case (FCode.BINARY(exp1,binop,exp2))
      equation 
        print("((");
        emit_exp(exp1);
        print(")");
        str = binop_to_str(binop);
        print(str);
        print("(");
        emit_exp(exp2);
        print("))"); then true;
    case (FCode.FCALL(id,exps))
      equation 
        print(id);
        print("(");
        emit_exps(exps);
        print(")"); then true;
  end matchcontinue;
end emit_exp;

protected function emit_comma_exp
  input FCode.Exp exp;
algorithm 
  print(", ");
  emit_exp(exp);
end emit_comma_exp;

protected function emit_exps
  input FCodeExpList in_fcodeexplist;
  output Boolean dummy;
protected 
  type FCodeExpList = list<FCode.Exp>;
algorithm 
  dummy:=
  matchcontinue (in_fcodeexplist)
    local
      FCode.Exp exp;
      FCodeExpList exps;
    case {} then true; 
    case (exp :: exps)
      equation 
        emit_exp(exp);
        foreach(emit_comma_exp, exps); then true;
  end matchcontinue;
end emit_exps;

protected function emit_assign_retval
  input TupleFCodeTyFCodeExpOption in_tuplefcodetyfcodeexpoption;
  output Boolean dummy;
protected 
  type TupleFCodeTyFCodeExp = tuple<FCodeTy,FCodeExp>;
  type TupleFCodeTyFCodeExpOption = Option<TupleFCodeTyFCodeExp>;
algorithm 
  dummy:=
  matchcontinue (in_tuplefcodetyfcodeexpoption)
    local FCode.Exp exp;
    case (NONE) then true; 
    case (SOME((_,exp)))
      equation 
        print("\tretval = ");
        emit_exp(exp);
        print(";\n"); then true;
  end matchcontinue;
end emit_assign_retval;

protected function emit_stmt
  input FCode.Stmt in_stmt;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_stmt)
    local
      type FCodeExpList = list<FCode.Exp>;
      type TupleFCodeTyFCodeExp = tuple<FCodeTy,FCodeExp>;
      type TupleFCodeTyFCodeExpOption = Option<TupleFCodeTyFCodeExp>;
      FCode.Exp lhs,rhs,exp;
      String id;
      FCodeExpList exps;
      TupleFCodeTyFCodeExpOption ret;
      FCode.Stmt stmt,stmt1,stmt2;
    case (FCode.STORE(_,lhs,rhs))
      equation 
        print("\t*");
        emit_exp(lhs);
        print(" = ");
        emit_exp(rhs);
        print(";\n"); then true;
    case (FCode.PCALL(id,exps))
      equation 
        print("\t");
        print(id);
        print("(");
        emit_exps(exps);
        print(");\n"); then true;
    case (FCode.RETURN(ret))
      equation 
        emit_assign_retval(ret);
        print("\tgoto epilogue;\n"); then true;
    case (FCode.WHILE(exp,stmt))
      equation 
        print("\twhile( ");
        emit_exp(exp);
        print(" ) {\n");
        emit_stmt(stmt);
        print("\t}\n"); then true;
    case (FCode.IF(exp,stmt1,stmt2))
      equation 
        print("\tif( ");
        emit_exp(exp);
        print(" ) {\n");
        emit_stmt(stmt1);
        print("\t} else {\n");
        emit_stmt(stmt2);
        print("\t}\n"); then true;
    case (FCode.SEQ(stmt1,stmt2))
      equation 
        emit_stmt(stmt1);
        emit_stmt(stmt2); then true;
    case (FCode.SKIP()) then true; 
  end matchcontinue;
end emit_stmt;

protected function conv_formal_decl
  input FCode.Var in_var;
  output Arg out_arg;
algorithm 
  out_arg:=
  matchcontinue (in_var)
    local
      Base base;
      InvTy ity;
      FCode.Ty ty;
    case (FCode.VAR(_,ty))
      equation 
        (base,ity) = invert_ty(VARity(""), ty); then ARG(base,ity);
  end matchcontinue;
end conv_formal_decl;

protected function emit_proc_head
  input FCodeTyOption in_fcodetyoption;
  input FCode.Ident in_ident;
  input ArgList in_arglist;
  output Boolean dummy;
protected 
  type FCodeTyOption = Option<FCode.Ty>;
algorithm 
  dummy:=
  matchcontinue (in_fcodetyoption,in_ident,in_arglist)
    local
      String id;
      ArgList args;
      Base base;
      InvTy ity;
      FCode.Ty ty;
    case (NONE,id,args)
      equation 
        print("void ");
        print(id);
        print("(");
        emit_args(args);
        print(")"); then true;
    case (SOME(ty),id,args)
      equation 
        (base,ity) = invert_ty(FUNity(id,args), ty);
        emit_base(base);
        print(" ");
        emit_invty(ity); then true;
  end matchcontinue;
end emit_proc_head;

protected function emit_proc_decl
  input FCode.Proc in_proc;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_proc)
    local
      type FCodeVarList = list<FCode.Var>;
      type FCodeTyOption = Option<FCode.Ty>;
      ArgList formals_1;
      String id;
      FCodeVarList formals;
      FCodeTyOption ty_opt;
    case (FCode.PROC(id,formals,ty_opt,_))
      equation 
        formals_1 = map(conv_formal_decl, formals);
        print("extern ");
        emit_proc_head(ty_opt, id, formals_1);
        print(";\n"); then true;
  end matchcontinue;
end emit_proc_decl;

protected function conv_formal_defn
  input FCode.Var in_var;
  output Arg out_arg;
algorithm 
  out_arg:=
  matchcontinue (in_var)
    local
      Base base;
      InvTy ity;
      String id;
      FCode.Ty ty;
    case (FCode.VAR(id,ty))
      equation 
        (base,ity) = invert_ty(VARity(id), ty); then ARG(base,ity);
  end matchcontinue;
end conv_formal_defn;

protected function emit_decl_retval
  input FCodeTyOption in_fcodetyoption;
  output Boolean dummy;
protected 
  type FCodeTyOption = Option<FCode.Ty>;
algorithm 
  dummy:=
  matchcontinue (in_fcodetyoption)
    local FCode.Ty ty;
    case (NONE) then true; 
    case (SOME(ty))
      equation 
        emit_var_bnd(FCode.VAR("retval",ty)); then true;
  end matchcontinue;
end emit_decl_retval;

protected function emit_return_retval
  input FCodeTyOption in_fcodetyoption;
  output Boolean dummy;
protected 
  type FCodeTyOption = Option<FCode.Ty>;
algorithm 
  dummy:=
  matchcontinue (in_fcodetyoption)
    case (NONE) then true; 
    case (SOME(_))
      equation 
        print("\treturn retval;\n"); then true;
  end matchcontinue;
end emit_return_retval;

protected function emit_load_formals
  input FCodeVarList in_fcodevarlist;
  input String in_string;
  output Boolean dummy;
protected 
  type FCodeVarList = list<FCode.Var>;
algorithm 
  dummy:=
  matchcontinue (in_fcodevarlist,in_string)
    local
      String id,stamp;
      FCodeVarList formals;
    case ({},_) then true; 
    case (FCode.VAR(id,_) :: formals,stamp)
      equation 
        print("\tframe.rec");
        print(stamp);
        print("_");
        print(id);
        print(" = ");
        print(id);
        print(";\n");
        emit_load_formals(formals, stamp); then true;
  end matchcontinue;
end emit_load_formals;

protected function emit_setup_display
  input FCode.Level in_level;
  input FCodeVarList in_fcodevarlist;
  input FCode.Record in_record;
  output Boolean dummy;
protected 
  type FCodeVarList = list<FCode.Var>;
algorithm 
  dummy:=
  matchcontinue (in_level,in_fcodevarlist,in_record)
    local
      String stamp_1;
      Integer lev,stamp;
      FCodeVarList formals,vars;
    case (_,_,FCode.RECORD(_,{})) then true; 
    case (lev,formals,FCode.RECORD(stamp,(vars = _ :: _)))
      equation 
        print("\t");
        emit_struct(stamp);
        print(" frame;\n");
        print("\tvoid *saveFP = display[");
        emit_int(lev);
        print("];\n");
        print("\tdisplay[");
        emit_int(lev);
        print("] = &frame;\n");
        stamp_1 = int_string(stamp);
        emit_load_formals(formals, stamp_1); then true;
  end matchcontinue;
end emit_setup_display;

protected function emit_restore_display
  input FCode.Level in_level;
  input FCode.Record in_record;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_level,in_record)
    local Integer lev;
    case (_,FCode.RECORD(_,{})) then true; 
    case (lev,FCode.RECORD(_,_ :: _))
      equation 
        print("\tdisplay[");
        emit_int(lev);
        print("] = saveFP;\n"); then true;
  end matchcontinue;
end emit_restore_display;

protected function emit_proc_defn
  input FCode.Proc in_proc;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_proc)
    local
      type FCodeVarList = list<FCode.Var>;
      type FCodeTyOption = Option<FCode.Ty>;
      ArgList formals_1;
      String id;
      FCodeVarList formals;
      FCodeTyOption ty_opt;
      Integer lev;
      FCode.Record r;
      FCode.Stmt stmt;
    case (FCode.PROC(_,_,_,NONE)) then true; 
    case (FCode.PROC(id,formals,ty_opt,SOME(FCode.BLOCK(lev,r,stmt))))
      equation 
        formals_1 = map(conv_formal_defn, formals);
        emit_proc_head(ty_opt, id, formals_1);
        print("\n{\n");
        emit_decl_retval(ty_opt);
        emit_setup_display(lev, formals, r);
        emit_stmt(stmt);
        print("epilogue:;\n");
        emit_restore_display(lev, r);
        emit_return_retval(ty_opt);
        print("}\n"); then true;
  end matchcontinue;
end emit_proc_defn;

uniontype Cmp "
 * RECORDS, for binary search tree storing record types.
 "
  record LT
  end LT;
  record EQ
  end EQ;
  record GT
  end GT;
end Cmp;

protected function compare_1
  input FCode.Stamp in_stamp1;
  input FCode.Stamp in_stamp2;
  output Cmp out_cmp;
algorithm 
  out_cmp:=
  matchcontinue (in_stamp1,in_stamp2)
    local Integer i,j;
    case (i,j)
      equation 
        (i < j) = true; then LT();
    case (i,j)
      equation 
        (i < j) = false; then GT();
  end matchcontinue;
end compare_1;

protected function compare
  input FCode.Stamp in_stamp1;
  input FCode.Stamp in_stamp2;
  output Cmp out_cmp;
algorithm 
  out_cmp:=
  matchcontinue (in_stamp1,in_stamp2)
    local
      Integer i,j;
      Cmp cmp;
    case (i,j)
      equation 
        (i == j) = true; then EQ();
    case (i,j)
      equation 
        (i == j) = false;
        cmp = compare_1(i, j); then cmp;
  end matchcontinue;
end compare;

uniontype RTree
  record EMPTY
  end EMPTY;
  record NODE
    RTree x1;
    FCode.Record x2;
    RTree x3;
  end NODE;
end RTree;

protected function insert "* Binary search tree (non-balanced), to insert found record types
 * and ensure that each record is stored only once.
 "
  input FCode.Record in_record;
  input RTree in_rtree;
  output RTree out_rtree;
algorithm 
  out_rtree:=
  matchcontinue (in_record,in_rtree)
    local
      FCode.Record r,r_1;
      Cmp cmp;
      RTree left_1,right_1,left,right;
      Integer stamp_1,stamp;
    case (r,EMPTY()) then NODE(EMPTY(),r,EMPTY()); 
    case ((r_1 = FCode.RECORD(stamp_1,_)),NODE(left,(r = FCode.RECORD(stamp,_)),right))
      equation 
        cmp = compare(stamp_1, stamp);
        (left_1,right_1) = insert_1(cmp, r_1, left, right); then NODE(left_1,r,right_1);
  end matchcontinue;
end insert;

protected function insert_1
  input Cmp in_cmp1;
  input FCode.Record in_record2;
  input RTree in_rtree3;
  input RTree in_rtree4;
  output RTree out_rtree1;
  output RTree out_rtree2;
algorithm 
  (out_rtree1,out_rtree2):=
  matchcontinue (in_cmp1,in_record2,in_rtree3,in_rtree4)
    local
      RTree left,right,left_1,right_1;
      FCode.Record r_1;
    case (EQ(),_,left,right) then (left,right); 
    case (LT(),r_1,left,right)
      equation 
        left_1 = insert(r_1, left); then (left_1,right);
    case (GT(),r_1,left,right)
      equation 
        right_1 = insert(r_1, right); then (left,right_1);
  end matchcontinue;
end insert_1;

protected function emit_rec_tree
  input RTree in_rtree;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_rtree)
    local
      RTree left,right;
      FCode.Record r;
    case (EMPTY()) then true; 
    case (NODE(left,r,right))
      equation 
        emit_rec_tree(left);
        emit_record(r);
        emit_rec_tree(right); then true;
  end matchcontinue;
end emit_rec_tree;

protected function ty_recs
  input FCode.Ty in_ty;
  input RTree in_rtree;
  output RTree out_rtree;
algorithm 
  out_rtree:=
  matchcontinue (in_ty,in_rtree)
    local
      type FCodeVarList = list<FCode.Var>;
      RTree recs,recs1,recs0,recs2;
      FCode.Ty ty;
      FCode.Record r;
      FCodeVarList bnds;
    case (FCode.CHAR(),recs) then recs; 
    case (FCode.INT(),recs) then recs; 
    case (FCode.REAL(),recs) then recs; 
    case (FCode.PTR(ty),recs0)
      equation 
        recs1 = ty_recs(ty, recs0); then recs1;
    case (FCode.ARR(_,ty),recs0)
      equation 
        recs1 = ty_recs(ty, recs0); then recs1;
    case (FCode.REC((r = FCode.RECORD(_,bnds))),recs0) "* Insert the found record r into recs0 "
      equation 
        recs1 = insert(r, recs0);
        recs2 = vars_recs(bnds, recs1); then recs2;
    case (FCode.UNFOLD(_),recs) then recs; 
  end matchcontinue;
end ty_recs;

protected function vars_recs
  input FCodeVarList in_fcodevarlist;
  input RTree in_rtree;
  output RTree out_rtree;
protected 
  type FCodeVarList = list<FCode.Var>;
algorithm 
  out_rtree:=
  matchcontinue (in_fcodevarlist,in_rtree)
    local
      RTree recs,recs1,recs2,recs0;
      FCode.Ty ty;
      FCodeVarList vars;
    case ({},recs) then recs; 
    case (FCode.VAR(_,ty) :: vars,recs0)
      equation 
        recs1 = ty_recs(ty, recs0);
        recs2 = vars_recs(vars, recs1); then recs2;
  end matchcontinue;
end vars_recs;

protected function ty_opt_recs
  input FCodeTyOption in_fcodetyoption;
  input RTree in_rtree;
  output RTree out_rtree;
protected 
  type FCodeTyOption = Option<FCode.Ty>;
algorithm 
  out_rtree:=
  matchcontinue (in_fcodetyoption,in_rtree)
    local
      RTree recs,recs1,recs0;
      FCode.Ty ty;
    case (NONE,recs) then recs; 
    case (SOME(ty),recs0)
      equation 
        recs1 = ty_recs(ty, recs0); then recs1;
  end matchcontinue;
end ty_opt_recs;

protected function unop_recs
  input FCode.UnOp in_unop;
  input RTree in_rtree;
  output RTree out_rtree;
algorithm 
  out_rtree:=
  matchcontinue (in_unop,in_rtree)
    local
      RTree recs1,recs0,recs;
      FCode.Ty ty;
    case (FCode.TOPTR(ty),recs0)
      equation 
        recs1 = ty_recs(ty, recs0); then recs1;
    case (FCode.CtoI(),recs) then recs; 
    case (FCode.ItoR(),recs) then recs; 
    case (FCode.RtoI(),recs) then recs; 
    case (FCode.ItoC(),recs) then recs; 
    case (FCode.PtoI(),recs) then recs; 
    case (FCode.LOAD(_),recs) then recs; 
    case (FCode.OFFSET(_,_),recs) then recs; 
  end matchcontinue;
end unop_recs;

protected function exp_recs
  input FCode.Exp in_exp;
  input RTree in_rtree;
  output RTree out_rtree;
algorithm 
  out_rtree:=
  matchcontinue (in_exp,in_rtree)
    local
      type FCodeExpList = list<FCode.Exp>;
      RTree recs,recs1,recs2,recs0;
      FCode.UnOp unop;
      FCode.Exp exp,exp1,exp2;
      FCodeExpList exps;
    case (FCode.ICON(_),recs) then recs; 
    case (FCode.RCON(_),recs) then recs; 
    case (FCode.DISPLAY(_),recs) then recs; 
    case (FCode.UNARY(unop,exp),recs0) "* A unary operator PTR may refer to a record type from unop_recs "
      equation 
        recs1 = unop_recs(unop, recs0);
        recs2 = exp_recs(exp, recs1); then recs1;
    case (FCode.BINARY(exp1,_,exp2),recs0)
      equation 
        recs1 = exp_recs(exp1, recs0);
        recs2 = exp_recs(exp2, recs1); then recs2;
    case (FCode.FCALL(_,exps),recs0)
      equation 
        recs1 = exps_recs(exps, recs0); then recs1;
  end matchcontinue;
end exp_recs;

protected function exps_recs
  input FCodeExpList in_fcodeexplist;
  input RTree in_rtree;
  output RTree out_rtree;
protected 
  type FCodeExpList = list<FCode.Exp>;
algorithm 
  out_rtree:=
  matchcontinue (in_fcodeexplist,in_rtree)
    local
      RTree recs,recs1,recs2,recs0;
      FCode.Exp exp;
      FCodeExpList exps;
    case ({},recs) then recs; 
    case (exp :: exps,recs0)
      equation 
        recs1 = exp_recs(exp, recs0);
        recs2 = exps_recs(exps, recs1); then recs2;
  end matchcontinue;
end exps_recs;

protected function stmt_recs
  input FCode.Stmt in_stmt;
  input RTree in_rtree;
  output RTree out_rtree;
algorithm 
  out_rtree:=
  matchcontinue (in_stmt,in_rtree)
    local
      type FCodeExpList = list<FCode.Exp>;
      RTree recs1,recs2,recs3,recs0,recs;
      FCode.Ty ty;
      FCode.Exp exp1,exp2,exp;
      FCodeExpList exps;
      FCode.Stmt stmt,stmt1,stmt2;
    case (FCode.STORE(ty,exp1,exp2),recs0) "* Traverse all statement and expressions, to find record types
 * which are referenced.
 "
      equation 
        recs1 = ty_recs(ty, recs0);
        recs2 = exp_recs(exp1, recs1);
        recs3 = exp_recs(exp2, recs2); then recs3;
    case (FCode.PCALL(_,exps),recs0)
      equation 
        recs1 = exps_recs(exps, recs0); then recs1;
    case (FCode.RETURN(NONE),recs) then recs; 
    case (FCode.RETURN(SOME((_,exp))),recs0)
      equation 
        recs1 = exp_recs(exp, recs0); then recs1;
    case (FCode.WHILE(exp,stmt),recs0)
      equation 
        recs1 = exp_recs(exp, recs0);
        recs2 = stmt_recs(stmt, recs1); then recs2;
    case (FCode.IF(exp,stmt1,stmt2),recs0)
      equation 
        recs1 = exp_recs(exp, recs0);
        recs2 = stmt_recs(stmt1, recs1);
        recs3 = stmt_recs(stmt2, recs2); then recs3;
    case (FCode.SEQ(stmt1,stmt2),recs0)
      equation 
        recs1 = stmt_recs(stmt1, recs0);
        recs2 = stmt_recs(stmt2, recs1); then recs2;
    case (FCode.SKIP(),recs) then recs; 
  end matchcontinue;
end stmt_recs;

protected function block_opt_recs
  input FCodeBlockOption in_fcodeblockoption;
  input RTree in_rtree;
  output RTree out_rtree;
protected 
  type FCodeBlockOption = Option<FCode.Block>;
algorithm 
  out_rtree:=
  matchcontinue (in_fcodeblockoption,in_rtree)
    local
      RTree recs,recs1,recs2,recs0;
      FCode.Record r;
      FCode.Stmt stmt;
    case (NONE,recs) then recs; 
    case (SOME(FCode.BLOCK(_,r,stmt)),recs0) "* Insert found record type r "
      equation 
        recs1 = insert(r, recs0);
        recs2 = stmt_recs(stmt, recs1); then recs2;
  end matchcontinue;
end block_opt_recs;

protected function proc_recs
  input FCode.Proc in_proc;
  input RTree in_rtree;
  output RTree out_rtree;
algorithm 
  out_rtree:=
  matchcontinue (in_proc,in_rtree)
    local
      type FCodeVarList = list<FCode.Var>;
      type FCodeTyOption = Option<FCode.Ty>;
      type FCodeBlockOption = Option<FCode.Block>;
      RTree recs1,recs2,recs3,recs0;
      FCodeVarList formals;
      FCodeTyOption ty_opt;
      FCodeBlockOption block_opt;
    case (FCode.PROC(_,formals,ty_opt,block_opt),recs0) "* Extract possible records from formals, etc. 
  * In all places where there might be types. 
  * Record types for procedure parameters must be generated, since
  * C procedures are called from elsewhere.
  * Local variables are only visible inside the procedure, and
  * are declared in the activation record.
  "
      equation 
        recs1 = vars_recs(formals, recs0);
        recs2 = ty_opt_recs(ty_opt, recs1);
        recs3 = block_opt_recs(block_opt, recs2); then recs3;
  end matchcontinue;
end proc_recs;

protected function procs_recs
  input FCodeProcList in_fcodeproclist;
  input RTree in_rtree;
  output RTree out_rtree;
protected 
  type FCodeProcList = list<FCode.Proc>;
algorithm 
  out_rtree:=
  matchcontinue (in_fcodeproclist,in_rtree)
    local
      RTree recs,recs1,recs2,recs0;
      FCode.Proc proc;
      FCodeProcList procs;
    case ({},recs) then recs; 
    case (proc :: procs,recs0)
      equation 
        recs1 = proc_recs(proc, recs0);
        recs2 = procs_recs(procs, recs1); then recs2;
  end matchcontinue;
end procs_recs;

protected function emit_record_defns "* Traverse all procedures, and create a set of all records which are
 * used (recs), and emit declarations for these records.
 "
  input FCodeProcList procs;
protected 
  type FCodeProcList = list<FCode.Proc>;
  RTree recs;
algorithm 
  recs := procs_recs(procs, EMPTY());
  emit_rec_tree(recs);
end emit_record_defns;

public function emit "
 * PROGRAMS
 
  * Traverse all procedure declarations and print out a C struct for
 *  each activation record 
 "
  input FCode.Prog in_prog;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_prog)
    local
      type FCodeProcList = list<FCode.Proc>;
      FCodeProcList procs;
      String id;
    case (FCode.PROG(procs,id))
      equation 
        print("#include \"petrol.h\"\nvoid *display[16];\n");
        emit_record_defns(procs);
        foreach(emit_proc_decl, procs);
        foreach(emit_proc_defn, procs);
        print("int main(void)\n{\n\t");
        print(id);
        print("();\n\treturn 0;\n}\n"); then true;
  end matchcontinue;
end emit;
end FCEmit;

