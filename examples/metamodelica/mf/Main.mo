package Main "main.rml -- Mini-Freja test driver"

protected import Absyn;
protected import Eval;
protected import Test;

public function main
  input list<String> inStringLst;
algorithm 
  _:=
  matchcontinue (inStringLst)
    local
      Integer k;
      Absyn.Exp prog;
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

