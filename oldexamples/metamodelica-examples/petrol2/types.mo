package Types " types.rml "
import absyn;
import tcode " import RelOp and BinOp ";

type Ident = String " Type representation in module Types, used for environments and type
 analysis ";

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
    TupleIdentTyList x2;
  end RECORD;
end Record;

public function unfold_rec
  input Record in_record;
  output TupleIdentTyList out_tupleidenttylist;
algorithm 
  out_tupleidenttylist:=
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

protected function unfold_bnds
  input Record in_record1;
  input TupleIdentTyList in_tupleidenttylist2;
  input TupleIdentTyList in_tupleidenttylist3;
  output TupleIdentTyList out_tupleidenttylist;
algorithm 
  out_tupleidenttylist:=
  matchcontinue (in_record1,in_tupleidenttylist2,in_tupleidenttylist3)
    local
      TupleIdentTyList bnds_2,bnds_1,bnds;
      Ty ty_1,ty;
      Record r;
      Ident id;
    case (_,{},bnds_1)
      equation 
        bnds_2 = list_reverse(bnds_1); then bnds_2;
    case (r,(id,ty) :: bnds,bnds_1)
      equation 
        ty_1 = unfold_ty(ty, r);
        bnds_2 = unfold_bnds(r, bnds, (id,ty_1) :: bnds_1); then bnds_2;
  end matchcontinue;
end unfold_bnds;

protected function unfold_ty
  input Ty in_ty;
  input Record in_record;
  output Ty out_ty;
algorithm 
  out_ty:=
  matchcontinue (in_ty,in_record)
    local
      Ty ty,ty_1;
      Record r;
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
    case (UNFOLD(stamp),(r = RECORD(stamp_1,_))) " Unfold one level; replace the UNFOLD constructor with a node containing
     a copy of the record declaration itself "
      equation 
        equality(stamp = stamp_1); then REC(r);
    case ((ty = UNFOLD(stamp)),RECORD(stamp_1,_))
      equation 
        failure(equality(stamp = stamp_1)); then ty;
  end matchcontinue;
end unfold_ty;

public function ty_cnv
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
  input TupleIdentTyList in_tupleidenttylist;
  input TCodeVarList in_tcodevarlist;
  output TCodeVarList out_tcodevarlist;
protected 
  type TCodeVarList = list<TCode.Var>;
algorithm 
  out_tcodevarlist:=
  matchcontinue (in_tupleidenttylist,in_tcodevarlist)
    local
      TCodeVarList bnds_2,bnds_1;
      TCode.Ty ty_1;
      Ident var;
      Ty ty;
      TupleIdentTyList bnds;
    case ({},bnds_1)
      equation 
        bnds_2 = list_reverse(bnds_1); then bnds_2;
    case ((var,ty) :: bnds,bnds_1)
      equation 
        ty_1 = ty_cnv(ty);
        bnds_2 = bnds_cnv(bnds, TCode.VAR(var,ty_1) :: bnds_1); then bnds_2;
  end matchcontinue;
end bnds_cnv;

public function decay
  input TCode.Exp in_exp;
  input Ty in_ty;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp,in_ty)
    local
      TCode.Exp exp;
      TCode.Ty ty_1;
      Ty ty;
    case (exp,ARITH(CHAR())) then (TCode.UNARY(TCode.CtoI(),exp),ARITH(INT())); 
    case (exp,ARR(_,ty))
      equation 
        ty_1 = ty_cnv(ty); then (TCode.UNARY(TCode.TOPTR(ty_1),exp),PTR(ty));
    case (exp,(ty = ARITH(INT()))) then (exp,ty); 
    case (exp,(ty = ARITH(REAL()))) then (exp,ty); 
    case (exp,(ty = PTR(_))) then (exp,ty); 
    case (exp,(ty = REC(_))) then (exp,ty); 
    case (exp,(ty = PTRNIL())) then (exp,ty); 
  end matchcontinue;
end decay;

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
    case (rhs,ARITH(aty1),ARITH(aty2))
      equation 
        rhs_1 = asg_cnv_1(rhs, aty1, aty2); then rhs_1;
    case (rhs,PTR(ty1),PTR(ty2))
      equation 
        equality(ty1 = ty2); then rhs;
    case (rhs,ARR(_,ty1),PTR(ty2))
      equation 
        equality(ty1 = ty2); then rhs;
    case (_,PTRNIL(),PTR(ty)) " Generic NIL, PTRNIL is converted to a specific NIL (ICON 0) for type ty'"
      equation 
        ty_1 = ty_cnv(ty); then TCode.UNARY(TCode.TOPTR(ty_1),TCode.ICON(0));
    case (rhs,REC(RECORD(stamp1,_)),REC(RECORD(stamp2,_)))
      equation 
        equality(stamp1 = stamp2); then rhs;
  end matchcontinue;
end asg_cnv;

protected function asg_cnv_1
  input TCode.Exp in_exp1;
  input ATy in_aty2;
  input ATy in_aty3;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp1,in_aty2,in_aty3)
    local TCode.Exp rhs;
    case (rhs,CHAR(),CHAR()) then rhs; 
    case (rhs,CHAR(),INT()) then TCode.UNARY(TCode.CtoI(),rhs); 
    case (rhs,CHAR(),REAL()) then TCode.UNARY(TCode.ItoR(),TCode.UNARY(TCode.CtoI(),rhs)); 
    case (rhs,INT(),CHAR()) then TCode.UNARY(TCode.ItoC(),rhs); 
    case (rhs,INT(),INT()) then rhs; 
    case (rhs,INT(),REAL()) then TCode.UNARY(TCode.ItoR(),rhs); 
    case (rhs,REAL(),CHAR()) then TCode.UNARY(TCode.ItoC(),TCode.UNARY(TCode.RtoI(),rhs)); 
    case (rhs,REAL(),INT()) then TCode.UNARY(TCode.RtoI(),rhs); 
    case (rhs,REAL(),REAL()) then rhs; 
  end matchcontinue;
end asg_cnv_1;

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

public function cond_cnv "*?? what about AND, OR operators? The function bin_cnv (called by elab_rvalue) does not seem to apply any conversions to non-boolean values ** note: booleans never exist. and or ar bit pattern operators on integer values).
In the first rule, the type PTRNIL is only used for the generic pointer constant nil, which is represented as the integer zero.
In the second rule, no change is done since the boolean type at this stage is represented as the integer type. Booleans never exist as a separate type in Petrol-they are always represented as integers.
The third rule converts floating point expressions, by inserting tests that equality to floating point zero is false.
Finally, the fourth rule handles pointer expressions similarly by inserting tests that pointer equality to nil is false. The function ty_cnv is called to provide the TCode type representation needed by the type-parameterized operator PTR. "
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
    case (exp,ARITH(INT())) then exp;  " No change for int, already bool "
    case (exp,ARITH(REAL())) then TCode.BINARY(TCode.BINARY(exp,TCode.REQ(),TCode.RCON(0.0)),TCode.IEQ(),
          TCode.ICON(0)); 
    case (exp,PTR(ty)) " Example: if xptr ..., converted to (xptr=nil) = False "
      equation 
        ty_1 = ty_cnv(ty); then TCode.BINARY(
          TCode.BINARY(exp,TCode.PEQ(ty_1),
          TCode.UNARY(TCode.TOPTR(ty_1),TCode.ICON(0))),TCode.IEQ(),TCode.ICON(0));
  end matchcontinue;
end cond_cnv;

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
    case (exp1,PTR(ty1),exp2,PTR(ty2)) " Compare two pointers, just require that pointer types are equal "
      equation 
        equality(ty1 = ty2);
        ty_1 = ty_cnv(ty1); then TCode.BINARY(exp1,TCode.PEQ(ty_1),exp2);
    case (exp,PTR(ty),_,PTRNIL()) " Special case: compare pointer to nil "
      equation 
        exp_1 = ptr_eq_null(exp, ty); then exp_1;
    case (_,PTRNIL(),exp,PTR(ty)) " Special case: compare nil to pointer "
      equation 
        exp_1 = ptr_eq_null(exp, ty); then exp_1;
    case (exp1,ARITH(raty1),exp2,ARITH(raty2)) " arithmetic case: widen to real if one of them is real "
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = choose_int_real(raty3, TCode.IEQ(), TCode.REQ()); then TCode.BINARY(exp1_1,bop,exp2_1);
  end matchcontinue;
end eq_cnv;

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

protected function choose_int_real
  input ATy in_aty1;
  input TCode.BinOp in_binop2;
  input TCode.BinOp in_binop3;
  output TCode.BinOp out_binop;
algorithm 
  out_binop:=
  matchcontinue (in_aty1,in_binop2,in_binop3)
    local TCode.BinOp x,y;
    case (INT(),x,_) then x; 
    case (REAL(),_,y) then y; 
  end matchcontinue;
end choose_int_real;

protected function arith_cnv
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

protected function arith_lub
  input ATy in_aty1;
  input ATy in_aty2;
  output ATy out_aty;
algorithm 
  out_aty:=
  matchcontinue (in_aty1,in_aty2)
    local ATy y;
    case (INT(),y) then y; 
    case (REAL(),_) then REAL(); 
  end matchcontinue;
end arith_lub;

protected function arith_widen
  input TCode.Exp in_exp1;
  input ATy in_aty2;
  input ATy in_aty3;
  output TCode.Exp out_exp;
algorithm 
  out_exp:=
  matchcontinue (in_exp1,in_aty2,in_aty3)
    local TCode.Exp exp;
    case (exp,INT(),INT()) then exp; 
    case (exp,INT(),REAL()) then TCode.UNARY(TCode.ItoR(),exp); 
    case (exp,REAL(),REAL()) then exp; 
  end matchcontinue;
end arith_widen;

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
      Absyn.RelOp relop;
      ATy raty3,raty1,raty2;
    case (exp1,PTR(ty1),relop,exp2,PTR(ty2))
      equation 
        equality(ty1 = ty2);
        ty_1 = ty_cnv(ty1);
        bop = ptr_relop(relop, ty_1); then TCode.BINARY(exp1,bop,exp2);
    case (exp1,ARITH(raty1),relop,exp2,ARITH(raty2))
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = int_or_real_relop(raty3, relop); then TCode.BINARY(exp1_1,bop,exp2_1);
  end matchcontinue;
end rel_cnv;

protected function ptr_relop
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

protected function int_or_real_relop
  input ATy in_aty;
  input Absyn.RelOp in_relop;
  output TCode.BinOp out_binop;
algorithm 
  out_binop:=
  matchcontinue (in_aty,in_relop)
    case (INT(),Absyn.LT()) then TCode.ILT(); 
    case (INT(),Absyn.LE()) then TCode.ILE(); 
    case (REAL(),Absyn.LT()) then TCode.RLT(); 
    case (REAL(),Absyn.LE()) then TCode.RLE(); 
  end matchcontinue;
end int_or_real_relop;

public function bin_cnv
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
    case (exp1,(ty = PTR(ty1)),exp2,ARITH(INT())) " ptr + arith -> ptr "
      equation 
        (exp3,ty3) = ptr_add_int_cnv(exp1, ty, ty1, exp2); then (exp3,ty3);
    case (exp1,ARITH(INT()),exp2,(ty = PTR(ty2))) " arith + ptr -> ptr "
      equation 
        (exp3,ty3) = ptr_add_int_cnv(exp2, ty, ty2, exp1); then (exp3,ty3);
    case (exp1,ARITH(raty1),exp2,ARITH(raty2)) " arith + arith -> arith "
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = choose_int_real(raty3, TCode.IADD(), TCode.RADD()); then (TCode.BINARY(exp1_1,bop,exp2_1),ARITH(raty3));
  end matchcontinue;
end add_cnv;

protected function ptr_add_int_cnv
  input TCode.Exp in_exp1;
  input Ty in_ty2;
  input Ty in_ty3;
  input TCode.Exp in_exp4;
  output TCode.Exp out_exp;
  output Ty out_ty;
algorithm 
  (out_exp,out_ty):=
  matchcontinue (in_exp1,in_ty2,in_ty3,in_exp4)
    local
      TCode.Ty ty1_1;
      TCode.Exp exp1,exp2;
      Ty ty,ty1;
    case (exp1,ty,ty1,exp2)
      equation 
        ty1_1 = ty_cnv(ty1); then (TCode.BINARY(exp1,TCode.PADD(ty1_1),exp2),ty);
  end matchcontinue;
end ptr_add_int_cnv;

protected function sub_cnv
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
    case (exp1,PTR(ty1),exp2,PTR(ty2)) " ptr - ptr -> arith "
      equation 
        equality(ty1 = ty2);
        ty1_1 = ty_cnv(ty1); then (TCode.BINARY(exp1,TCode.PDIFF(ty1_1),exp2),ARITH(INT()));
    case (exp1,(ty = PTR(ty1)),exp2,ARITH(INT())) " ptr - arith -> ptr "
      equation 
        ty1_1 = ty_cnv(ty1); then (TCode.BINARY(exp1,TCode.PSUB(ty1_1),exp2),ty);
    case (exp1,ARITH(raty1),exp2,ARITH(raty2)) " Note:  arith - ptr  is not allowed!!   arith - arith -> "
      equation 
        (exp1_1,exp2_1,raty3) = arith_cnv(exp1, raty1, exp2, raty2);
        bop = choose_int_real(raty3, TCode.ISUB(), TCode.RSUB()); then (TCode.BINARY(exp1_1,bop,exp2_1),ARITH(raty3));
  end matchcontinue;
end sub_cnv;

protected function mul_cnv
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

protected function rdiv_cnv
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

protected function intop_cnv
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
end Types;

