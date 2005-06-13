package Types " types.rml "
import absyn;
import tcode " import RelOp and BinOp ";

type Ident = String;

type Stamp = Integer;

uniontype ATy
  record CHAR
  end CHAR;
  record INT
  end INT;
  record REAL
  end REAL;
end ATy;

uniontype Ty
  record ARITH
    ATy x1;
  end ARITH;
  record PTR
    Ty x1;
  end PTR;
  record PTRNIL
  end PTRNIL;
  record ARR
    Stamp x1;
    Ty x2;
  end ARR;
  record REC
    Record x1;
  end REC;
  record UNFOLD
    Stamp x1;
  end UNFOLD;
end Ty;

type TupleIdentTy = tuple<Ident,Ty>;

type TupleIdentTyList = list<TupleIdentTy>;

uniontype Record
  record RECORD
    Stamp x1;
    TupleIdentTyList x2 " An lvalue type (lty) can be any type, except PTRNIL.
       PTR, ARR, and REC can only refer to lvalue types.
       UNFOLD is an internal placeholder that should never
       occur outside of a REC.   inspect a record by unfolding it one level ";
  end RECORD;
end Record;

protected function unfold_ty " Inspect a record by unfolding it one level
 "
  input Ty in_ty;
  input Record in_record;
  output Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_ty,in_record)
    local
      replaceable type Type_a;
      Ty ty,ty_1;
      Type_a r;
      Stamp sz,stamp,stamp_1;
      TupleIdentTyList bnds_1,bnds;
    case ((ty = ARITH(_)),_) then ty; 
    case ((ty = PTRNIL()),_) then ty; 
    case (PTR(ty),r)
      equation 
        ty_1 = unfold_ty(ty, r); then PTR(ty_1);
    case (ARR(sz,ty),r)
      equation 
        ty_1 = unfold_ty(ty, r); then ARR(sz,ty_1);
    case (REC(RECORD(stamp,bnds)),r)
      equation 
        bnds_1 = unfold_bnds(r, bnds, {}); then REC(RECORD(stamp,bnds_1));
    case (UNFOLD(stamp),(r = RECORD(stamp_1,_)))
      local Record r;
      equation 
        equality(stamp = stamp_1); then REC(r);
    case ((ty = UNFOLD(stamp)),RECORD(stamp_1,_))
      equation 
        failure(equality(stamp = stamp_1)); then ty;
  end matchcontinue;
end unfold_ty;

protected function unfold_bnds
  input Record in_record1;
  input TupleStringTyList in_tuplestringtylist2;
  input TupleStringTyList in_tuplestringtylist3;
  output TupleStringTyList out_tuplestringtylist;
protected 
  type TupleStringTy = tuple<String,Ty>;
  type TupleStringTyList = list<TupleStringTy>;
algorithm 
  out_tuplestringtylist:=
  matchcontinue (in_record1,in_tuplestringtylist2,in_tuplestringtylist3)
    local
      replaceable type Type_a;
      type VType_aList = list<Type_a>;
      type TupleType_aType_a = tuple<Type_a,Type_a>;
      type TupleType_aType_aList = list<TupleType_aType_a>;
      replaceable type Type_b;
      type TupleType_aType_b = tuple<Type_a,Type_b>;
      type TupleType_aType_bList = list<TupleType_aType_b>;
      VType_aList bnds_2,bnds_1;
      Type_a ty_1,r,id;
      Type_b ty;
      TupleType_aType_bList bnds;
    case (_,{},bnds_1)
      equation 
        bnds_2 = list_reverse(bnds_1); then bnds_2;
    case (r,(id,ty) :: bnds,bnds_1)
      local TupleType_aType_aList bnds_2,bnds_1;
      equation 
        ty_1 = unfold_ty(ty, r);
        bnds_2 = unfold_bnds(r, bnds, (id,ty_1) :: bnds_1); then bnds_2;
  end matchcontinue;
end unfold_bnds;

public function unfold_rec
  input Record in_record;
  output TupleStringTyList out_tuplestringtylist;
protected 
  type TupleStringTy = tuple<String,Ty>;
  type TupleStringTyList = list<TupleStringTy>;
algorithm 
  out_tuplestringtylist:=
  matchcontinue (in_record)
    local
      TupleIdentTyList bnds_1,bnds;
      Record r;
      Stamp stamp;
    case ((r = RECORD(stamp,bnds)))
      equation 
        bnds_1 = unfold_bnds(r, bnds, {}); then bnds_1;
  end matchcontinue;
end unfold_rec;

public function ty_cnv " Convert one of our types to a TCode type.
 * PTRNIL is intentionally excluded.
 "
  input Ty in_ty;
  output TCode.Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_ty)
    local
      TCode.Ty ty_1;
      Ty ty;
      Stamp sz,stamp;
      TCode.Record r_1;
      Record r;
    case (ARITH(CHAR())) then TCode.CHAR(); 
    case (ARITH(INT())) then TCode.INT(); 
    case (ARITH(REAL())) then TCode.REAL(); 
    case (PTR(ty))
      equation 
        ty_1 = ty_cnv(ty); then TCode.PTR(ty_1);
    case (ARR(sz,ty))
      equation 
        ty_1 = ty_cnv(ty); then TCode.ARR(sz,ty_1);
    case (REC(r))
      equation 
        r_1 = rec_cnv(r); then TCode.REC(r_1);
    case (UNFOLD(stamp)) then TCode.UNFOLD(stamp); 
  end matchcontinue;
end ty_cnv;

public function rec_cnv
  input Record in_record;
  output TCode.Record out_record;
algorithm 
  out_record:=
  matchcontinue (in_record)
    local
      type TCodeVarList = list<TCode.Var>;
      TCodeVarList bnds_1;
      Stamp stamp;
      TupleIdentTyList bnds;
    case (RECORD(stamp,bnds))
      equation 
        bnds_1 = bnds_cnv(bnds, {}); then TCode.RECORD(stamp,bnds_1);
  end matchcontinue;
end rec_cnv;

protected function bnds_cnv
  input TupleStringTyList in_tuplestringtylist;
  input TCodeVarList in_tcodevarlist;
  output TCodeVarList out_tcodevarlist;
protected 
  type TupleStringTy = tuple<String,Ty>;
  type TupleStringTyList = list<TupleStringTy>;
  type TCodeVarList = list<TCode.Var>;
algorithm 
  out_tcodevarlist:=
  matchcontinue (in_tuplestringtylist,in_tcodevarlist)
    local
      replaceable type Type_a;
      type VType_aList = list<Type_a>;
      VType_aList bnds_2,bnds_1;
      TCode.Ty ty_1;
      Ident var;
      Ty ty;
      TupleIdentTyList bnds;
    case ({},bnds_1)
      equation 
        bnds_2 = list_reverse(bnds_1); then bnds_2;
    case ((var,ty) :: bnds,bnds_1)
      local TCodeVarList bnds_2,bnds_1;
      equation 
        ty_1 = ty_cnv(ty);
        bnds_2 = bnds_cnv(bnds, TCode.VAR(var,ty_1) :: bnds_1); then bnds_2;
  end matchcontinue;
end bnds_cnv;

public function decay " Apply the usual CHAR->INT and ARR->PTR decay
 * to an rvalue.
 "
  input TCode.Exp in_exp;
  input Ty in_ty;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp,in_ty)
    local
      TCode.Exp exp;
      Ty ty;
      TCode.Ty ty_1;
    case (exp,ARITH(CHAR())) then (TCode.UNARY(TCode.CtoI(),exp),ARITH(INT())); 
    case (exp,(ty = ARITH(INT()))) then (exp,ty); 
    case (exp,(ty = ARITH(REAL()))) then (exp,ty); 
    case (exp,(ty = PTR(_))) then (exp,ty); 
    case (exp,(ty = REC(_))) then (exp,ty); 
    case (exp,(ty = PTRNIL())) then (exp,ty); 
    case (exp,ARR(_,ty))
      equation 
        ty_1 = ty_cnv(ty); then (TCode.UNARY(TCode.TOPTR(ty_1),exp),PTR(ty));
  end matchcontinue;
end decay;

protected function asg_cnv_1 " Convert the rhs of an assignment to the type of the lhs.
 * Ditto for return <exp>.
 * Arithmetic types are widened or narrowed as necessary.
 * The generic null pointer is made type-specific.
 "
  input TCode.Exp in_exp1;
  input ATy in_aty2;
  input ATy in_aty3;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp1,in_aty2,in_aty3)
    local
      replaceable type Type_a;
      Type_a rhs;
    case (rhs,CHAR(),CHAR()) then rhs; 
    case (rhs,CHAR(),INT())
      local TCode.Exp rhs; then TCode.UNARY(TCode.CtoI(),rhs);
    case (rhs,CHAR(),REAL())
      local TCode.Exp rhs; then TCode.UNARY(TCode.ItoR(),TCode.UNARY(TCode.CtoI(),rhs));
    case (rhs,INT(),CHAR())
      local TCode.Exp rhs; then TCode.UNARY(TCode.ItoC(),rhs);
    case (rhs,INT(),INT())
      local TCode.Exp rhs; then rhs;
    case (rhs,INT(),REAL())
      local TCode.Exp rhs; then TCode.UNARY(TCode.ItoR(),rhs);
    case (rhs,REAL(),CHAR())
      local TCode.Exp rhs; then TCode.UNARY(TCode.ItoC(),TCode.UNARY(TCode.RtoI(),rhs));
    case (rhs,REAL(),INT())
      local TCode.Exp rhs; then TCode.UNARY(TCode.RtoI(),rhs);
    case (rhs,REAL(),REAL())
      local TCode.Exp rhs; then rhs;
  end matchcontinue;
end asg_cnv_1;

public function asg_cnv
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input Ty in_ty3;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp1,in_ty2,in_ty3)
    local
      TCode.Exp rhs_1,rhs;
      ATy aty1,aty2;
      Ty ty1,ty2,ty;
      TCode.Ty ty_1;
      Stamp stamp1,stamp2;
    case (rhs,ARITH(aty1),ARITH(aty2)) " rhs, rty, lty => rhs' "
      equation 
        rhs_1 = asg_cnv_1(rhs, aty1, aty2); then rhs_1;
    case (rhs,PTR(ty1),PTR(ty2))
      equation 
        equality(ty1 = ty2); then rhs;
    case (rhs,ARR(_,ty1),PTR(ty2))
      equation 
        equality(ty1 = ty2); then rhs;
    case (_,PTRNIL(),PTR(ty))
      equation 
        ty_1 = ty_cnv(ty); then TCode.UNARY(TCode.TOPTR(ty_1),TCode.ICON(0));
    case (rhs,REC(RECORD(stamp1,_)),REC(RECORD(stamp2,_)))
      equation 
        equality(stamp1 = stamp2); then rhs;
  end matchcontinue;
end asg_cnv;

public function cast_cnv
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input Ty in_ty3;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp1,in_ty2,in_ty3)
    local
      TCode.Exp exp_1,exp;
      ATy aty1,aty2,aty;
      TCode.Ty ty2_1,ty_1;
      Ty ty2,ty;
    case (exp,ARITH(aty1),ARITH(aty2))
      equation 
        exp_1 = asg_cnv_1(exp, aty1, aty2); then exp_1;
    case (exp,PTR(_),ARITH(aty))
      equation 
        exp_1 = asg_cnv_1(TCode.UNARY(TCode.PtoI(),exp), INT(), aty); then exp_1;
    case (_,PTRNIL(),ARITH(aty))
      equation 
        exp = asg_cnv_1(TCode.ICON(0), INT(), aty); then exp;
    case (exp,ARITH(aty1),PTR(ty2))
      equation 
        exp_1 = asg_cnv_1(exp, aty1, INT());
        ty2_1 = ty_cnv(ty2); then TCode.UNARY(TCode.TOPTR(ty2_1),exp_1);
    case (exp,PTR(_),PTR(ty))
      equation 
        ty_1 = ty_cnv(ty); then TCode.UNARY(TCode.TOPTR(ty_1),exp);
    case (_,PTRNIL(),PTR(ty))
      equation 
        ty_1 = ty_cnv(ty); then TCode.UNARY(TCode.TOPTR(ty_1),TCode.ICON(0));
  end matchcontinue;
end cast_cnv;

public function cond_cnv " Convert a decayed rvalue to a boolean:
 * reals are compared with zero: x != 0.0, i.e. (x == 0.0) == 0
 * pointers are compared with null: p != <nil>, i.e. (p == <nil>) == 0
 "
  input TCode.Exp in_exp;
  input Ty in_ty;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp,in_ty)
    local
      TCode.Exp exp;
      TCode.Ty ty_1;
      Ty ty;
    case (_,PTRNIL()) then TCode.ICON(0); 
    case (exp,ARITH(INT())) then exp; 
    case (exp,ARITH(REAL())) then TCode.BINARY(TCode.BINARY(exp,TCode.REQ(),TCode.RCON(0.0)),TCode.IEQ(),
          TCode.ICON(0)); 
    case (exp,PTR(ty))
      equation 
        ty_1 = ty_cnv(ty); then TCode.BINARY(
          TCode.BINARY(exp,TCode.PEQ(ty_1),
          TCode.UNARY(TCode.TOPTR(ty_1),TCode.ICON(0))),TCode.IEQ(),TCode.ICON(0));
  end matchcontinue;
end cond_cnv;

protected function arith_lub " Compute the least upper bound of two decayed arithmetic rvalue types
 "
  input ATy in_aty1;
  input ATy in_aty2;
  output ATy out_aty;
algorithm 
  out_aty:=
  matchcontinue (in_aty1,in_aty2)
    local
      replaceable type Type_a;
      Type_a y;
    case (INT(),y) then y; 
    case (REAL(),_) then REAL(); 
  end matchcontinue;
end arith_lub;

protected function arith_widen " Widen a decayed arithmetic rvalue
 "
  input TCode.Exp in_exp1;
  input ATy in_aty2;
  input ATy in_aty3;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp1,in_aty2,in_aty3)
    local
      replaceable type Type_a;
      Type_a exp;
    case (exp,INT(),INT()) then exp; 
    case (exp,INT(),REAL())
      local TCode.Exp exp; then TCode.UNARY(TCode.ItoR(),exp);
    case (exp,REAL(),REAL())
      local TCode.Exp exp; then exp;
  end matchcontinue;
end arith_widen;

protected function arith_cnv " Usual arithmetic conversions.
 * Widen two decayed arithmetic rvalues to their lub.
 "
  input TCode.Exp in_exp1;
  input ATy in_aty2;
  input TCode.Exp in_exp3;
  input ATy in_aty4;
  output TCode.Exp out_exp1;
  output TCode.Exp out_exp2;
  output ATy out_aty3;
algorithm 
  (out_exp1,out_exp2,out_aty3):=
  matchcontinue (in_exp1,in_aty2,in_exp3,in_aty4)
    local
      ATy raty3,raty1,raty2;
      TCode.Exp exp1_1,exp2_1,exp1,exp2;
    case (exp1,raty1,exp2,raty2)
      equation 
        raty3 = arith_lub(raty1, raty2);
        exp1_1 = arith_widen(exp1, raty1, raty3);
        exp2_1 = arith_widen(exp2, raty2, raty3); then (exp1_1,exp2_1,raty3);
  end matchcontinue;
end arith_cnv;

protected function choose_int_real " Elaborate an equality expression.
 * The arguments are already elaborated as decayed rvalues.
 * Make arguments compatible, if necessary by arithmetic widening
 * or instantiation of the polymorphic nil pointer.
 * Return elaborated expression. Result type always int.
 * Equality of records is not defined.
 "
  input ATy in_aty1;
  input Type_a in_type_a2;
  input Type_a in_type_a3;
  output Type_a out_type_a;
protected 
  replaceable type Type_a;
algorithm 
  out_type_a:=
  matchcontinue (in_aty1,in_type_a2,in_type_a3)
    local Type_a x,y;
    case (INT(),x,_) then x; 
    case (REAL(),_,y) then y; 
  end matchcontinue;
end choose_int_real;

protected function ptr_eq_null
  input TCode.Exp exp;
  input Ty ty;
  output TCode.Exp out_exp;
protected 
  TCode.Ty ty_1;
algorithm 
  ty_1 := ty_cnv(ty);
  out_exp := TCode.BINARY(exp,TCode.PEQ(ty_1),
          TCode.UNARY(TCode.TOPTR(ty_1),TCode.ICON(0)));
end ptr_eq_null;

public function eq_cnv
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input TCode.Exp in_exp3;
  input Ty in_ty4;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp1,in_ty2,in_exp3,in_ty4)
    local
      TCode.Ty ty_1;
      TCode.Exp exp1,exp2,exp_1,exp,exp1_1,exp2_1;
      Ty ty1,ty2,ty;
      ATy raty3,raty1,raty2;
      TCode.BinOp bop;
    case (exp1,PTR(ty1),exp2,PTR(ty2))
      equation 
        equality(ty1 = ty2);
        ty_1 = ty_cnv(ty1); then TCode.BINARY(exp1,TCode.PEQ(ty_1),exp2);
    case (exp,PTR(ty),_,PTRNIL())
      equation 
        exp_1 = ptr_eq_null(exp, ty); then exp_1;
    case (_,PTRNIL(),exp,PTR(ty))
      equation 
        exp_1 = ptr_eq_null(exp, ty); then exp_1;
    case (exp1,ARITH(raty1),exp2,ARITH(raty2))
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = choose_int_real(raty3, TCode.IEQ(), TCode.REQ()); then TCode.BINARY(exp1_1,bop,exp2_1);
  end matchcontinue;
end eq_cnv;

protected function ptr_relop " Elaborate a function expression.
 * The arguments are already elaborated as decayed rvalues.
 * Make arguments compatible, if necessary by arithmetic widening.
 * Choose int, real, or ptr/ptr version of function operator.
 * Return elaborated expression. Result type always int.
 "
  input Absyn.RelOp in_relop;
  input TCode.Ty in_ty;
  output TCode.BinOp out_binop;
algorithm 
  out_binop:=
  matchcontinue (in_relop,in_ty)
    local TCode.Ty ty;
    case (Absyn.LT(),ty) then TCode.PLT(ty); 
    case (Absyn.LE(),ty) then TCode.PLE(ty); 
  end matchcontinue;
end ptr_relop;

protected function int_relop
  input Absyn.RelOp in_relop;
  output TCode.BinOp out_binop;
algorithm 
  out_binop:=
  matchcontinue (in_relop)
    case Absyn.LT() then TCode.ILT(); 
    case Absyn.LE() then TCode.ILE(); 
  end matchcontinue;
end int_relop;

protected function real_relop
  input Absyn.RelOp in_relop;
  output TCode.BinOp out_binop;
algorithm 
  out_binop:=
  matchcontinue (in_relop)
    case Absyn.LT() then TCode.RLT(); 
    case Absyn.LE() then TCode.RLE(); 
  end matchcontinue;
end real_relop;

protected function int_or_real_relop
  input ATy in_aty;
  input Absyn.RelOp in_relop;
  output TCode.BinOp out_binop;
algorithm 
  out_binop:=
  matchcontinue (in_aty,in_relop)
    local
      TCode.BinOp bop;
      Absyn.RelOp rop;
    case (INT(),rop)
      equation 
        bop = int_relop(rop); then bop;
    case (REAL(),rop)
      equation 
        bop = real_relop(rop); then bop;
  end matchcontinue;
end int_or_real_relop;

public function rel_cnv
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input Absyn.RelOp in_relop3;
  input TCode.Exp in_exp4;
  input Ty in_ty5;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp1,in_ty2,in_relop3,in_exp4,in_ty5)
    local
      TCode.Ty ty_1;
      TCode.BinOp bop;
      TCode.Exp exp1,exp2,exp1_1,exp2_1;
      Ty ty1,ty2;
      Absyn.RelOp rop;
      ATy raty3,raty1,raty2;
    case (exp1,PTR(ty1),rop,exp2,PTR(ty2))
      equation 
        equality(ty1 = ty2);
        ty_1 = ty_cnv(ty1);
        bop = ptr_relop(rop, ty_1); then TCode.BINARY(exp1,bop,exp2);
    case (exp1,ARITH(raty1),rop,exp2,ARITH(raty2))
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = int_or_real_relop(raty3, rop); then TCode.BINARY(exp1_1,bop,exp2_1);
  end matchcontinue;
end rel_cnv;

protected function ptr_add_int_cnv " Elaborate an addition expression.
 * The arguments are already elaborated as decayed rvalues.
 * Make arguments compatible, if necessary by arithmetic widening.
 * Choose int, real, or ptr/int version of the addition operator.
 * Return elaborated expression and its type.
 "
  input TCode.Exp in_exp1;
  input Type_a in_type_a2;
  input Ty in_ty3;
  input TCode.Exp in_exp4;
  output TCode.Exp out_exp;
  output Type_a out_type_a;
protected 
  replaceable type Type_a;
algorithm 
  (out_exp,out_type_a):=
  matchcontinue (in_exp1,in_type_a2,in_ty3,in_exp4)
    local
      TCode.Ty ty1_1;
      TCode.Exp exp1,exp2;
      Type_a ty;
      Ty ty1;
    case (exp1,ty,ty1,exp2)
      equation 
        ty1_1 = ty_cnv(ty1); then (TCode.BINARY(exp1,TCode.PADD(ty1_1),exp2),ty);
  end matchcontinue;
end ptr_add_int_cnv;

protected function add_cnv
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input TCode.Exp in_exp3;
  input Ty in_ty4;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp1,in_ty2,in_exp3,in_ty4)
    local
      TCode.Exp exp3,exp1,exp2,exp1_1,exp2_1;
      Ty ty3,ty,ty1,ty2;
      ATy raty3,raty1,raty2;
      TCode.BinOp bop;
    case (exp1,(ty = PTR(ty1)),exp2,ARITH(INT()))
      equation 
        (exp3,ty3) = ptr_add_int_cnv(exp1, ty, ty1, exp2); then (exp3,ty3);
    case (exp1,ARITH(INT()),exp2,(ty = PTR(ty2)))
      equation 
        (exp3,ty3) = ptr_add_int_cnv(exp2, ty, ty2, exp1); then (exp3,ty3);
    case (exp1,ARITH(raty1),exp2,ARITH(raty2))
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = choose_int_real(raty3, TCode.IADD(), TCode.RADD()); then (TCode.BINARY(exp1_1,bop,exp2_1),ARITH(raty3));
  end matchcontinue;
end add_cnv;

protected function sub_cnv " Elaborate a subtraction expression.
 * The arguments are already elaborated as decayed rvalues.
 * Make arguments compatible, if necessary by arithmetic widening.
 * Choose int, real, ptr/int, or ptr/ptr version of the subtraction operator.
 * Return elaborated expression and its type.
 "
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input TCode.Exp in_exp3;
  input Ty in_ty4;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp1,in_ty2,in_exp3,in_ty4)
    local
      TCode.Ty ty1_1;
      TCode.Exp exp1,exp2,exp1_1,exp2_1;
      Ty ty1,ty2,ty;
      ATy raty3,raty1,raty2;
      TCode.BinOp bop;
    case (exp1,PTR(ty1),exp2,PTR(ty2))
      equation 
        equality(ty1 = ty2);
        ty1_1 = ty_cnv(ty1); then (TCode.BINARY(exp1,TCode.PDIFF(ty1_1),exp2),ARITH(INT()));
    case (exp1,(ty = PTR(ty1)),exp2,ARITH(INT()))
      equation 
        ty1_1 = ty_cnv(ty1); then (TCode.BINARY(exp1,TCode.PSUB(ty1_1),exp2),ty);
    case (exp1,ARITH(raty1),exp2,ARITH(raty2))
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = choose_int_real(raty3, TCode.ISUB(), TCode.RSUB()); then (TCode.BINARY(exp1_1,bop,exp2_1),ARITH(raty3));
  end matchcontinue;
end sub_cnv;

protected function mul_cnv " Elaborate a multiplication expression.
 * The arguments are already elaborated as decayed rvalues.
 * Make arguments compatible, if necessary by arithmetic widening.
 * Choose int or real version of the multiplication operator.
 * Return elaborated expression and its type.
 "
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input TCode.Exp in_exp3;
  input Ty in_ty4;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp1,in_ty2,in_exp3,in_ty4)
    local
      TCode.Exp exp1_1,exp2_1,exp1,exp2;
      ATy raty3,raty1,raty2;
      TCode.BinOp bop;
    case (exp1,ARITH(raty1),exp2,ARITH(raty2))
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = choose_int_real(raty3, TCode.IMUL(), TCode.RMUL()); then (TCode.BINARY(exp1_1,bop,exp2_1),ARITH(raty3));
  end matchcontinue;
end mul_cnv;

protected function rdiv_cnv " Elaborate a real division expression.
 * The arguments are already elaborated as decayed rvalues.
 * Widen both arguments to reals.
 * Return elaborated expression and its type (always real).
 "
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input TCode.Exp in_exp3;
  input Ty in_ty4;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp1,in_ty2,in_exp3,in_ty4)
    local
      TCode.Exp exp1_1,exp2_1,exp1,exp2;
      ATy raty1,raty2;
    case (exp1,ARITH(raty1),exp2,ARITH(raty2))
      equation 
        exp1_1 = arith_widen(exp1, raty1, REAL());
        exp2_1 = arith_widen(exp2, raty2, REAL()); then (TCode.BINARY(exp1_1,TCode.RDIV(),exp2_1),ARITH(REAL()));
  end matchcontinue;
end rdiv_cnv;

protected function intop_cnv " Elaborate an integer operator expression.
 * The arguments are already elaborated as decayed rvalues.
 * Verify arguments. Return elaborated expression and its type (always int).
 "
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input TCode.BinOp in_binop3;
  input TCode.Exp in_exp4;
  input Ty in_ty5;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp1,in_ty2,in_binop3,in_exp4,in_ty5)
    local
      TCode.Exp exp1,exp2;
      TCode.BinOp bop;
    case (exp1,ARITH(INT()),bop,exp2,ARITH(INT())) then (TCode.BINARY(exp1,bop,exp2),ARITH(INT())); 
  end matchcontinue;
end intop_cnv;

public function bin_cnv " Elaborate a binary operator expression.
 * The arguments are already elaborated as decayed rvalues.
 * Return elaborated expression and its type.
 "
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input Absyn.BinOp in_binop3;
  input TCode.Exp in_exp4;
  input Ty in_ty5;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp1,in_ty2,in_binop3,in_exp4,in_ty5)
    local
      TCode.Exp exp3,exp1,exp2;
      Ty rty3,rty1,rty2;
    case (exp1,rty1,Absyn.ADD(),exp2,rty2)
      equation 
        (exp3,rty3) = add_cnv(exp1, rty1, exp2, rty2); then (exp3,rty3);
    case (exp1,rty1,Absyn.SUB(),exp2,rty2)
      equation 
        (exp3,rty3) = sub_cnv(exp1, rty1, exp2, rty2); then (exp3,rty3);
    case (exp1,rty1,Absyn.MUL(),exp2,rty2)
      equation 
        (exp3,rty3) = mul_cnv(exp1, rty1, exp2, rty2); then (exp3,rty3);
    case (exp1,rty1,Absyn.RDIV(),exp2,rty2)
      equation 
        (exp3,rty3) = rdiv_cnv(exp1, rty1, exp2, rty2); then (exp3,rty3);
    case (exp1,rty1,Absyn.IDIV(),exp2,rty2)
      equation 
        (exp3,rty3) = intop_cnv(exp1, rty1, TCode.IDIV(), exp2, rty2); then (exp3,rty3);
    case (exp1,rty1,Absyn.IMOD(),exp2,rty2)
      equation 
        (exp3,rty3) = intop_cnv(exp1, rty1, TCode.IMOD(), exp2, rty2); then (exp3,rty3);
    case (exp1,rty1,Absyn.IAND(),exp2,rty2)
      equation 
        (exp3,rty3) = intop_cnv(exp1, rty1, TCode.IAND(), exp2, rty2); then (exp3,rty3);
    case (exp1,rty1,Absyn.IOR(),exp2,rty2)
      equation 
        (exp3,rty3) = intop_cnv(exp1, rty1, TCode.IOR(), exp2, rty2); then (exp3,rty3);
  end matchcontinue;
end bin_cnv;
end Types;

