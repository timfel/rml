package Trans
import absyn;
import mcode;

protected function trans_expr "************** Arithmetic expression translation *************"
  input Absyn.Exp in_exp;
  output McodeMCodeList out_mcodemcodelist;
protected 
  type McodeMCodeList = list<Mcode.MCode>;
algorithm 
  out_mcodemcodelist:=
  matchcontinue (in_exp)
    local
      Integer v;
      String id;
      McodeMCodeList cod1,cod3,cod2;
      Mcode.MOperand operand2,t1,t2;
      Mcode.MBinOp opcode;
      Absyn.Exp e1,e2;
      Absyn.BinOp binop;
    case (Absyn.INT(v)) then list(Mcode.MLOAD(Mcode.N(v)));  " integer constant "
    case (Absyn.IDENT(id)) then list(Mcode.MLOAD(Mcode.I(id)));  " identifier id "
    case (Absyn.BINARY(e1,binop,e2)) " Arith binop: simple case, expr2 is just an identifier or constant   expr1 binop expr2 "
      equation 
        cod1 = trans_expr(e1);
        list(Mcode.MLOAD(operand2)) = trans_expr(e2);
        opcode = trans_binop(binop) " expr2 simple ";
        cod3 = list_append(cod1, list(Mcode.MB(opcode,operand2))); then cod3;
    case (Absyn.BINARY(e1,binop,e2)) " Arith binop: general case, expr2 is a more complicated expr   expr1 binop expr2 "
      equation 
        cod1 = trans_expr(e1);
        cod2 = trans_expr(e2);
        opcode = trans_binop(binop);
        t1 = gentemp();
        t2 = gentemp();
        cod3 = list_append6(cod1, list(Mcode.MSTO(t1)), cod2, list(Mcode.MSTO(t2)), 
          list(Mcode.MLOAD(t1)), list(Mcode.MB(opcode,t2))) " code for expr1   store expr1   code for expr2   store expr2   load expr1 value into Acc   Do arith operation "; then cod3;
  end matchcontinue;
end trans_expr;

protected function trans_binop
  input Absyn.BinOp in_binop;
  output Mcode.MBinOp out_mbinop;
algorithm 
  out_mbinop:=
  matchcontinue (in_binop)
    case (Absyn.ADD()) then Mcode.MADD(); 
    case (Absyn.SUB()) then Mcode.MSUB(); 
    case (Absyn.MUL()) then Mcode.MMULT(); 
    case (Absyn.DIV()) then Mcode.MDIV(); 
  end matchcontinue;
end trans_binop;

protected function gentemp
  output Mcode.MOperand out_moperand;
protected 
  Integer no;
algorithm 
  no := tick();
  out_moperand := Mcode.T(no);
end gentemp;

protected function genlabel
  output Mcode.MOperand out_moperand;
protected 
  Integer no;
algorithm 
  no := tick();
  out_moperand := Mcode.L(no);
end genlabel;

protected function list_append3
  input VType_aList l1;
  input VType_aList l2;
  input VType_aList l3;
  output VType_aList l13;
protected 
  replaceable type Type_a;
  type VType_aList = list<Type_a>;
  VType_aList l12;
algorithm 
  l12 := list_append(l1, l2);
  l13 := list_append(l12, l3);
end list_append3;

protected function list_append5
  input VType_aList l1;
  input VType_aList l2;
  input VType_aList l3;
  input VType_aList l4;
  input VType_aList l5;
  output VType_aList l15;
protected 
  replaceable type Type_a;
  type VType_aList = list<Type_a>;
  VType_aList l13;
algorithm 
  l13 := list_append3(l1, l2, l3);
  l15 := list_append3(l13, l4, l5);
end list_append5;

protected function list_append6
  input VType_aList l1;
  input VType_aList l2;
  input VType_aList l3;
  input VType_aList l4;
  input VType_aList l5;
  input VType_aList l6;
  output VType_aList l16;
protected 
  replaceable type Type_a;
  type VType_aList = list<Type_a>;
  VType_aList l13,l46;
algorithm 
  l13 := list_append3(l1, l2, l3);
  l46 := list_append3(l4, l5, l6);
  l16 := list_append(l13, l46);
end list_append6;

protected function list_append10
  input VType_aList l1;
  input VType_aList l2;
  input VType_aList l3;
  input VType_aList l4;
  input VType_aList l5;
  input VType_aList l6;
  input VType_aList l7;
  input VType_aList l8;
  input VType_aList l9;
  input VType_aList l10;
  output VType_aList l110;
protected 
  replaceable type Type_a;
  type VType_aList = list<Type_a>;
  VType_aList l15;
algorithm 
  l15 := list_append5(l1, l2, l3, l4, l5);
  l110 := list_append6(l15, l6, l7, l8, l9, l10);
end list_append10;

protected function trans_comparison
  input Absyn.Comparison in_comparison;
  input Mcode.MOperand in_moperand;
  output McodeMCodeList out_mcodemcodelist;
protected 
  type McodeMCodeList = list<Mcode.MCode>;
algorithm 
  out_mcodemcodelist:=
  matchcontinue (in_comparison,in_moperand)
    local
      McodeMCodeList cod1,cod3,cod2;
      Mcode.MOperand operand2,lab,t1;
      Mcode.MCondJmp jmpop;
      Absyn.Exp e1,e2;
      Absyn.RelOp relop;
    case (Absyn.RELATION(e1,relop,e2),lab) " translation of a comparison:  expr1 function expr2
 * Example call:  trans_comparison(RELATION(INDENT(x), GT, INT(5)), L(10))
 *
 * Use a simple code pattern (the first rule), when expr2 is  a simple
 * identifier or constant:
 *   code for expr1
 *   SUB operand2
 *   conditional jump to lab
 *
 * or a general code pattern (second rule), which is needed when expr2
 * is more complicated than a simple identifier or constant:
 *   code for expr1
 *   STO temp1
 *   code for expr2
 *   SUB temp1
 *   conditional jump to lab
   expr1 relop expr2 "
      equation 
        cod1 = trans_expr(e1);
        list(Mcode.MLOAD(operand2)) = trans_expr(e2);
        jmpop = trans_relop(relop);
        cod3 = list_append3(cod1, list(Mcode.MB(Mcode.MSUB(),operand2)), 
          list(Mcode.MJ(jmpop,lab))); then cod3;
    case (Absyn.RELATION(e1,relop,e2),lab) " expr1 relop expr2 "
      equation 
        cod1 = trans_expr(e1);
        cod2 = trans_expr(e2);
        jmpop = trans_relop(relop);
        t1 = gentemp();
        cod3 = list_append5(cod1, list(Mcode.MSTO(t1)), cod2, 
          list(Mcode.MB(Mcode.MSUB(),t1)), list(Mcode.MJ(jmpop,lab))); then cod3;
  end matchcontinue;
end trans_comparison;

protected function trans_relop
  input Absyn.RelOp in_relop;
  output Mcode.MCondJmp out_mcondjmp;
algorithm 
  out_mcondjmp:=
  matchcontinue (in_relop)
    case (Absyn.EQ()) then Mcode.MJNP();  " Jump on Negative or Positive "
    case (Absyn.LE()) then Mcode.MJP();  " Jump on Positive "
    case (Absyn.LT()) then Mcode.MJPZ();  " Jump on Positive or Zero "
    case (Absyn.GT()) then Mcode.MJNZ();  " Jump on Negative or Zero "
    case (Absyn.GE()) then Mcode.MJN();  " Jump on Negative "
    case (Absyn.NE()) then Mcode.MJZ();  " Jump on Zero "
  end matchcontinue;
end trans_relop;

protected function trans_stmt "************** Statement translation *************"
  input Absyn.Stmt in_stmt;
  output McodeMCodeList out_mcodemcodelist;
protected 
  type McodeMCodeList = list<Mcode.MCode>;
algorithm 
  out_mcodemcodelist:=
  matchcontinue (in_stmt)
    local
      type StringList = list<String>;
      McodeMCodeList cod1,cod2,s1cod,compcod,cod3,s2cod,bodycod,tocod;
      String id;
      Absyn.Exp e1,comp;
      Mcode.MOperand l1,l2,t1;
      Absyn.Stmt s1,s2,stmt1,stmt2;
      StringList idlist_rest;
    case (Absyn.ASSIGN(id,e1)) " Statement translation: map the current state into a new state   correct??   Assignment "
      equation 
        cod1 = trans_expr(e1);
        cod2 = list_append(cod1, list(Mcode.MSTO(Mcode.I(id)))); then cod2;
    case (Absyn.SKIP()) then {};  " ; empty statement "
    case (Absyn.IF(comp,s1,Absyn.SKIP())) " IF comp then s1 "
      equation 
        s1cod = trans_stmt(s1);
        l1 = genlabel();
        compcod = trans_comparison(comp, l1);
        cod3 = list_append3(compcod, s1cod, list(Mcode.MLABEL(l1))); then cod3;
    case (Absyn.IF(comp,s1,s2)) " IF comp then s1 else s2 "
      equation 
        s1cod = trans_stmt(s1);
        s2cod = trans_stmt(s2);
        l1 = genlabel();
        l2 = genlabel();
        compcod = trans_comparison(comp, l1);
        cod3 = list_append6(compcod, s1cod, list(Mcode.MJMP(l2)), 
          list(Mcode.MLABEL(l1)), s2cod, list(Mcode.MLABEL(l2))); then cod3;
    case (Absyn.WHILE(comp,s1)) " WHILE ... "
      equation 
        bodycod = trans_stmt(s1);
        l1 = genlabel();
        l2 = genlabel();
        compcod = trans_comparison(comp, l2);
        cod3 = list_append5(list(Mcode.MLABEL(l1)), compcod, bodycod, 
          list(Mcode.MJMP(l1)), list(Mcode.MLABEL(l2))); then cod3;
    case (Absyn.TODO(e1,s1)) " TO e1 DO s1 .. "
      equation 
        tocod = trans_expr(e1);
        bodycod = trans_stmt(s1);
        t1 = gentemp();
        l1 = genlabel();
        l2 = genlabel();
        cod3 = list_append10(tocod, list(Mcode.MSTO(t1)), list(Mcode.MLABEL(l1)), 
          list(Mcode.MLOAD(t1)), list(Mcode.MB(Mcode.MSUB(),Mcode.N(1))), 
          list(Mcode.MJ(Mcode.MJN(),l2)), list(Mcode.MSTO(t1)), bodycod, list(Mcode.MJMP(l1)), 
          list(Mcode.MLABEL(l2))); then cod3;
    case (Absyn.READ({})) then {};  " READ {} "
    case (Absyn.READ(id :: idlist_rest))
      equation 
        cod2 = trans_stmt(Absyn.READ(idlist_rest)); then Mcode.MGET(Mcode.I(id) :: cod2);
    case (Absyn.WRITE({})) then {};  " WRITE {} "
    case (Absyn.WRITE(id :: idlist_rest))
      equation 
        cod2 = trans_stmt(Absyn.WRITE(idlist_rest)); then Mcode.MPUT(Mcode.I(id) :: cod2);
    case (Absyn.SEQ(stmt1,stmt2)) " stmt1 ; stmt2 "
      equation 
        cod1 = trans_stmt(stmt1);
        cod2 = trans_stmt(stmt2);
        cod3 = list_append(cod1, cod2); then cod3;
  end matchcontinue;
end trans_stmt;

public function trans_program
  input Absyn.Stmt progbody;
  output McodeMCodeList programcode;
protected 
  type McodeMCodeList = list<Mcode.MCode>;
  McodeMCodeList cod1;
algorithm 
  cod1 := trans_stmt(progbody);
  programcode := list_append(cod1, list(Mcode.MHALT()));
end trans_program;
end Trans;

