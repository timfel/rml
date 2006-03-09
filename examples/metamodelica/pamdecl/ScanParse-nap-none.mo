package ScanParse

public import OpenModelica.Compiler.Absyn.*;

public function scanparse
  output Absyn.Prog outProg;

  external "C" ;
end scanparse;
end ScanParse;

