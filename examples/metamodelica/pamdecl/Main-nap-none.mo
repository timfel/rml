package Main

public import OpenModelica.Compiler.ScanParse.*;

public import OpenModelica.Compiler.Eval.*;

public function main
  Absyn.Prog ast;
algorithm 
  ast := ScanParse.scanparse();
  Eval.evalprog(ast);
end main;
end Main;

