package Main
import parse;
import trans;
import emit;

public function main
protected 
  type McodeMCodeList = list<Mcode.MCode>;
  Absyn.Stmt program;
  McodeMCodeList mcode;
algorithm 
  program := Parse.parse();
  mcode := Trans.trans_program(program);
  Emit.emit_assembly(mcode);
end main;
end Main;

