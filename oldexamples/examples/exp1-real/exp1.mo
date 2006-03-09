function eval
  uniontype Exp
   record RCONST Real x1; end RCONST;
   record PLUS  Exp x1; Exp x2; end PLUS;
   record SUB   Exp x1; Exp x2; end SUB;
   record MUL   Exp x1; Exp x2; end MUL;
   record DIV   Exp x1; Exp x2; end DIV;
   record NEG   Exp x1;         end NEG;
  end Exp;
  input  Exp   exp_1;
  output Real rval_1;
algorithm
 rval_1 :=
  case exp_1
    local Integer v1,v2;
          Exp     e1,e2;
    of RCONST(v1) then in v1;
    of PLUS(e1,e2) then 
      eval(e1) = v1;  eval(e2) = v2;
      in v1+v2;
    of SUB(e1,e2) then
      eval(e1) = v1;  eval(e2) = v2;
      in v1-v2;
    of MUL(e1,e2) then
      eval(e1) = v1;  eval(e2) = v2;
      in v1*v2;
    of DIV(e1,e2) then
      eval(e1) = v1;  eval(e2) = v2;
      in v1/v2;
    of NEG(e1) then
      eval(e1) = v1;
      in -v1;
    else
      assert("Bad expression!"));	 
   end case;
end eval;
