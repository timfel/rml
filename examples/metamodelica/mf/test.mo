package Test

public import Absyn.*;

protected function sieve
  input Integer inInteger;
  output Absyn.exp outexp;
algorithm 
  outexp:=
  matchcontinue (inInteger)
    local Integer NTH;
    case NTH then Absyn.RECexp(
          {
          ("filter",
          Absyn.LAMexp("p",
          Absyn.LAMexp("xs0",
          Absyn.CASEexp(Absyn.VARexp("xs0"),
          {
          (Absyn.CONSTpat(Absyn.NILcnst()),
          Absyn.CONSTexp(Absyn.NILcnst())),
          (Absyn.CONSpat(Absyn.VARpat("x"),Absyn.VARpat("xs")),
          Absyn.IFexp(Absyn.APPexp(Absyn.VARexp("p"),Absyn.VARexp("x")),
          Absyn.CONSexp(Absyn.VARexp("x"),
          Absyn.APPexp(Absyn.APPexp(Absyn.VARexp("filter"),Absyn.VARexp("p")),
          Absyn.VARexp("xs"))),
          Absyn.APPexp(Absyn.APPexp(Absyn.VARexp("filter"),Absyn.VARexp("p")),
          Absyn.VARexp("xs"))))})))),
          ("take",
          Absyn.LAMexp("n0",
          Absyn.LAMexp("xs0",
          Absyn.CASEexp(Absyn.VARexp("n0"),
          {
          (Absyn.CONSTpat(Absyn.INTcnst(0)),
          Absyn.CONSTexp(Absyn.NILcnst())),
          (Absyn.VARpat("n"),
          Absyn.CASEexp(Absyn.VARexp("xs0"),
          {
          (Absyn.CONSpat(Absyn.VARpat("x"),Absyn.VARpat("xs")),
          Absyn.CONSexp(Absyn.VARexp("x"),
          Absyn.APPexp(
          Absyn.APPexp(Absyn.VARexp("take"),
          Absyn.PRIM2exp(Absyn.SUB(),Absyn.VARexp("n"),
          Absyn.CONSTexp(Absyn.INTcnst(1)))),Absyn.VARexp("xs")))),
          (Absyn.CONSTpat(Absyn.NILcnst()),
          Absyn.CONSTexp(Absyn.NILcnst()))}))})))),
          ("from",
          Absyn.LAMexp("n",
          Absyn.CONSexp(Absyn.VARexp("n"),
          Absyn.APPexp(Absyn.VARexp("from"),
          Absyn.PRIM2exp(Absyn.ADD(),Absyn.VARexp("n"),
          Absyn.CONSTexp(Absyn.INTcnst(1))))))),
          ("not_div",
          Absyn.LAMexp("x",
          Absyn.LAMexp("y",
          Absyn.PRIM2exp(Absyn.NE(),
          Absyn.PRIM2exp(Absyn.MOD(),Absyn.VARexp("y"),Absyn.VARexp("x")),Absyn.CONSTexp(Absyn.INTcnst(0)))))),
          ("sieve",
          Absyn.LAMexp("xs0",
          Absyn.CASEexp(Absyn.VARexp("xs0"),
          {
          (Absyn.CONSpat(Absyn.VARpat("x"),Absyn.VARpat("xs")),
          Absyn.CONSexp(Absyn.VARexp("x"),
          Absyn.APPexp(Absyn.VARexp("sieve"),
          Absyn.APPexp(
          Absyn.APPexp(Absyn.VARexp("filter"),
          Absyn.APPexp(Absyn.VARexp("not_div"),Absyn.VARexp("x"))),Absyn.VARexp("xs")))))}))),
          ("primes",
          Absyn.APPexp(Absyn.VARexp("sieve"),
          Absyn.APPexp(Absyn.VARexp("from"),Absyn.CONSTexp(Absyn.INTcnst(2)))))},
          Absyn.APPexp(
          Absyn.APPexp(Absyn.VARexp("take"),Absyn.CONSTexp(Absyn.INTcnst(NTH))),Absyn.VARexp("primes")));  "<<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<<"
  end matchcontinue;
end sieve;

public function test
  input Integer inInteger;
  output Absyn.exp outexp;
algorithm 
  outexp:=
  matchcontinue (inInteger)
    local
      Integer n_1,n;
      Absyn.exp e;
    case 0 then Absyn.PRIM2exp(Absyn.ADD(),Absyn.CONSTexp(Absyn.INTcnst(2)),
          Absyn.CONSTexp(Absyn.INTcnst(40))); 
    case 1 then Absyn.RECexp(
          {
          ("main",
          Absyn.CONSexp(Absyn.CONSTexp(Absyn.INTcnst(20)),Absyn.VARexp("a"))),("a",Absyn.CONSTexp(Absyn.INTcnst(27)))},Absyn.VARexp("main")); 
    case 2 then Absyn.RECexp(
          {
          ("main",
          Absyn.PRIM2exp(Absyn.ADD(),Absyn.VARexp("a"),
          Absyn.RECexp(
          {
          ("c",
          Absyn.PRIM2exp(Absyn.ADD(),
          Absyn.PRIM2exp(Absyn.MUL(),Absyn.CONSTexp(Absyn.INTcnst(2)),
          Absyn.CONSTexp(Absyn.INTcnst(3))),Absyn.VARexp("b"))),("a",Absyn.CONSTexp(Absyn.INTcnst(1)))},Absyn.PRIM2exp(Absyn.MUL(),Absyn.VARexp("c"),Absyn.VARexp("a"))))),("a",Absyn.CONSTexp(Absyn.INTcnst(40))),
          ("b",Absyn.CONSTexp(Absyn.INTcnst(42)))},Absyn.VARexp("main")); 
    case 3 then Absyn.RECexp(
          {
          ("foo",
          Absyn.LAMexp("y",
          Absyn.CASEexp(Absyn.VARexp("y"),
          {
          (Absyn.CONSTpat(Absyn.INTcnst(0)),
          Absyn.CONSTexp(Absyn.INTcnst(1))),
          (Absyn.VARpat("x"),
          Absyn.PRIM2exp(Absyn.ADD(),Absyn.VARexp("y"),
          Absyn.CONSTexp(Absyn.INTcnst(1))))}))),
          ("main",
          Absyn.APPexp(Absyn.VARexp("foo"),Absyn.CONSTexp(Absyn.INTcnst(5))))},Absyn.VARexp("main")); 
    case 4 then Absyn.RECexp(
          {("x",Absyn.CONSTexp(Absyn.INTcnst(17))),
          ("foo",
          Absyn.LAMexp("y",
          Absyn.RECexp({("x",Absyn.CONSTexp(Absyn.INTcnst(99)))},
          Absyn.PRIM2exp(Absyn.ADD(),Absyn.VARexp("y"),
          Absyn.CONSTexp(Absyn.INTcnst(1)))))),("main",Absyn.APPexp(Absyn.VARexp("foo"),Absyn.VARexp("x")))},Absyn.VARexp("main")); 
    case 5 then Absyn.RECexp(
          {
          ("fac",
          Absyn.LAMexp("n",
          Absyn.IFexp(
          Absyn.PRIM2exp(Absyn.LE(),Absyn.VARexp("n"),
          Absyn.CONSTexp(Absyn.INTcnst(1))),Absyn.CONSTexp(Absyn.INTcnst(1)),
          Absyn.PRIM2exp(Absyn.MUL(),Absyn.VARexp("n"),
          Absyn.APPexp(Absyn.VARexp("fac"),
          Absyn.PRIM2exp(Absyn.SUB(),Absyn.VARexp("n"),
          Absyn.CONSTexp(Absyn.INTcnst(1))))))))},Absyn.APPexp(Absyn.VARexp("fac"),Absyn.CONSTexp(Absyn.INTcnst(5)))); 
    case 6 then Absyn.RECexp(
          {
          ("iff",
          Absyn.LAMexp("x",
          Absyn.LAMexp("e1",
          Absyn.LAMexp("e2",
          Absyn.CASEexp(Absyn.VARexp("x"),
          {(Absyn.CONSTpat(Absyn.BOOLcnst(false)),Absyn.VARexp("e2")),
          (Absyn.CONSTpat(Absyn.BOOLcnst(true)),Absyn.VARexp("e1"))}))))),
          ("fac",
          Absyn.LAMexp("n",
          Absyn.APPexp(
          Absyn.APPexp(
          Absyn.APPexp(Absyn.VARexp("iff"),
          Absyn.PRIM2exp(Absyn.LE(),Absyn.VARexp("n"),
          Absyn.CONSTexp(Absyn.INTcnst(1)))),Absyn.CONSTexp(Absyn.INTcnst(1))),
          Absyn.PRIM2exp(Absyn.MUL(),Absyn.VARexp("n"),
          Absyn.APPexp(Absyn.VARexp("fac"),
          Absyn.PRIM2exp(Absyn.SUB(),Absyn.VARexp("n"),
          Absyn.CONSTexp(Absyn.INTcnst(1))))))))},Absyn.APPexp(Absyn.VARexp("fac"),Absyn.CONSTexp(Absyn.INTcnst(5)))); 
    case n "<<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<< <<<<<<<<<<<<<<<<"
      equation 
        (n > 10) = true;
        n_1 = n - 10;
        e = sieve(n_1); then e;
  end matchcontinue;
end test;
end Test;

