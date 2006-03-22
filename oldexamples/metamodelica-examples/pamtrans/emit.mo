package Emit
import mcode;

public function emit_assembly
  input McodeMCodeList in_mcodemcodelist;
  output Boolean dummy;
protected 
  type McodeMCodeList = list<Mcode.MCode>;
algorithm 
  dummy:=
  matchcontinue (in_mcodemcodelist)
    local
      Mcode.MCode instr;
      McodeMCodeList rest;
    case ({}) then true; 
    case (instr :: rest)
      equation 
        emit_instr(instr);
        emit_assembly(rest); then true;
  end matchcontinue;
end emit_assembly;

protected function emit_instr
  input Mcode.MCode in_mcode;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_mcode)
    local
      String op;
      Mcode.MBinOp mbinop;
      Mcode.MOperand mopr,mlab;
      Mcode.MCondJmp jmpop;
    case (Mcode.MB(mbinop,mopr)) " Print an MCode instruction "
      equation 
        op = mbinop_to_str(mbinop);
        emit_op_operand(op, mopr); then true;
    case (Mcode.MJ(jmpop,mlab))
      equation 
        op = mjmpop_to_str(jmpop);
        emit_op_operand(op, mlab); then true;
    case (Mcode.MJMP(mlab))
      equation 
        emit_op_operand("J", mlab); then true;
    case (Mcode.MLOAD(mopr))
      equation 
        emit_op_operand("LOAD", mopr); then true;
    case (Mcode.MSTO(mopr))
      equation 
        emit_op_operand("STO", mopr); then true;
    case (Mcode.MGET(mopr))
      equation 
        emit_op_operand("GET", mopr); then true;
    case (Mcode.MPUT(mopr))
      equation 
        emit_op_operand("PUT", mopr); then true;
    case (Mcode.MLABEL(mlab))
      equation 
        emit_moperand(mlab);
        print("\tLAB\n"); then true;
    case (Mcode.MHALT())
      equation 
        print("\tHALT\n"); then true;
  end matchcontinue;
end emit_instr;

protected function emit_op_operand
  input String opstr;
  input Mcode.MOperand mopr;
algorithm 
  print("\t");
  print(opstr);
  print("\t");
  emit_moperand(mopr);
  print("\n");
end emit_op_operand;

protected function emit_int
  input Integer i;
protected 
  String s;
algorithm 
  s := int_string(i);
  print(s);
end emit_int;

protected function emit_moperand
  input Mcode.MOperand in_moperand;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_moperand)
    local
      String id;
      Integer number,labno,tempnr;
    case (Mcode.I(id))
      equation 
        print(id); then true;
    case (Mcode.N(number))
      equation 
        emit_int(number); then true;
    case (Mcode.L(labno))
      equation 
        print("L");
        emit_int(labno); then true;
    case (Mcode.T(tempnr))
      equation 
        print("T");
        emit_int(tempnr); then true;
  end matchcontinue;
end emit_moperand;

protected function mbinop_to_str
  input Mcode.MBinOp in_mbinop;
  output String out_string;
algorithm 
  out_string:=
  matchcontinue (in_mbinop)
    case (Mcode.MADD()) then "ADD"; 
    case (Mcode.MSUB()) then "SUB"; 
    case (Mcode.MMULT()) then "MULT"; 
    case (Mcode.MDIV()) then "DIV"; 
  end matchcontinue;
end mbinop_to_str;

protected function mjmpop_to_str
  input Mcode.MCondJmp in_mcondjmp;
  output String out_string;
algorithm 
  out_string:=
  matchcontinue (in_mcondjmp)
    case (Mcode.MJNP()) then "JNP"; 
    case (Mcode.MJP()) then "JP"; 
    case (Mcode.MJN()) then "JN"; 
    case (Mcode.MJNZ()) then "JNZ"; 
    case (Mcode.MJPZ()) then "JPZ"; 
    case (Mcode.MJZ()) then "JZ"; 
  end matchcontinue;
end mjmpop_to_str;
end Emit;

