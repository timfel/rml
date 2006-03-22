package Main
import scanparse;
import eval;

public function main
  input StringList in_stringlist;
  output Boolean dummy;
protected 
  type StringList = list<String>;
algorithm 
  dummy:=
  matchcontinue (in_stringlist)
    local Absyn.Prog ast;
    case _
      equation 
        ast = ScanParse.scanparse();
        Eval.evalprog(ast); then true;
  end matchcontinue;
end main;
end Main;

