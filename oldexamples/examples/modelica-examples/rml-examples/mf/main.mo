package Main " main.rml -- Mini-Freja test driver "
import absyn;
import eval;
import test;

public function main
  input StringList in_stringlist;
  output Boolean dummy;
protected 
  type StringList = list<String>;
algorithm 
  dummy:=
  matchcontinue (in_stringlist)
    local
      Integer k;
      Absyn.exp prog;
      String arg;
      StringList argv;
    case {} then true; 
    case arg :: argv
      equation 
        k = string_int(arg);
        prog = Test.test(k);
        Eval.exec(prog);
        main(argv); then true;
  end matchcontinue;
end main;
end Main;

