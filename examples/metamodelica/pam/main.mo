package Main

protected import Parse;
protected import Pam;

public function main "Parse and translate a PAM program into MCode,
  then emit it as textual assembly code.
"
  Pam.Stmt program;
algorithm 
  program := Parse.parse();
  _ := Pam.evalStmt({}, program);
end main;
end Main;

