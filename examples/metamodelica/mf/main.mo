package Main "main.rml -- Mini-Freja test driver"

protected import OpenModelica.Compiler.Absyn;

protected import OpenModelica.Compiler.Eval;

protected import OpenModelica.Compiler.Test;

public function main
  input list<String> inStringLst;
algorithm 
  _:=
  matchcontinue (inStringLst)
    local
      Integer k;
      Absyn.exp prog;
      String arg;
      list<String> argv;
    case {} then (); 
    case (arg :: argv)
      equation 
        k = stringInt(arg);
        prog = Test.test(k);
        Eval.exec(prog);
        main(argv);
      then
        ();
  end matchcontinue;
end main;
end Main;

