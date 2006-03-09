package Main

protected import Parse.*;

protected import Trans.*;

protected import Emit.*;

public function main "Parse and translate a PAM program into MCode,
  then emit it as textual assembly code.
"
  type Mcode_MCodeLst = list<Mcode.MCode>;
  Absyn.Stmt program;
  Mcode_MCodeLst mcode;
algorithm 
  program := Parse.parse();
  mcode := Trans.transProgram(program);
  Emit.emitAssembly(mcode);
end main;
end Main;

