package Eval

uniontype Exp
  record RCONST Real x1; end RCONST;
  record PLUS Exp x1; Exp x2; end PLUS;
  record SUB Exp x1; Exp x2; end SUB;
  record MUL Exp x1; Exp x2; end MUL;
  record DIV Exp x1; Exp x2; end DIV;
  record NEG Exp x1; end NEG;
end Exp;

function eval
  input Exp exp_1;
  output Real rval_1;
algorithm
  rval_1 :=
   match exp_1 
	local Real v1,v2; Exp e1,e2;
    case RCONST(v1) then v1;
    case PLUS(e1,e2) equation 
       v1 = eval(e1); v2 = eval(e2);
       then v1 +. v2;
    case SUB(e1,e2) equation
       v1 = eval(e1); v2 = eval(e2);
       then v1 -. v2;
    case MUL(e1,e2) equation
       v1 = eval(e1); v2 = eval(e2);
       then v1 *. v2;
    case DIV(e1,e2) equation
       v1 = eval(e1); v2 = eval(e2);
       then v1 /. v2;
    case NEG(e1) equation
       v1 = eval(e1);
       then -. v1;
   end match;
end eval;

end Eval;
