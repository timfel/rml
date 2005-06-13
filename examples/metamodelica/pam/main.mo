package Main
import parse;
import pam;

public function main
protected 
  Pam.Stmt program;
algorithm 
  program := Parse.parse();
  _ := Pam.eval_stmt({}, program);
end main;
end Main;

