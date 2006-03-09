package Main

protected import Absyn.*;

protected import Eval.*;

protected import Test.*;

public function main
  input StringLst inStringLst;
  type StringLst = list<String>;
algorithm 
  _:=
  matchcontinue (inStringLst)
    local
      Integer k;
      Absyn.exp prog;
      String arg;
      StringLst argv;
    case {} then (); 
    case arg :: argv
      equation 
        k = stringInt(arg);
        prog = Test.test(k);
        Eval.exec(prog);
        main(argv); then ();
  end matchcontinue;
end main;
end Main;

