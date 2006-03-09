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
   match exp_1 of 
	local Real v1,v2; Exp e1,e2;
    case RCONST(v1) then v1;
    case PLUS(e1,e2) equation 
       v1 = eval(e1); v2 = eval(e2);
       then v1+v2;
    case SUB(e1,e2) equation
       v1 = eval(e1); v2 = eval(e2);
       then v1-v2;
    case MUL(e1,e2) equation
       v1 = eval(e1); v2 = eval(e2);
       then v1*v2;
    case DIV(e1,e2) equation
       v1 = eval(e1); v2 = eval(e2);
       then v1/v2;
    case NEG(e1) equation
       v1 = eval(e1);
       then -v1;
   end match;
end eval;

/*
replaceable type Type_a;
type Option_a = option<Type_a>;

function arr_map_int "Map over an array of integers"
  function _
    input Integer x1; output Integer x2;
  end Functype;
  input replaceable function func extends Functype;
  input Functype func;
  input Integer[:] inarr;
  output Integer[size(inarr,1)] outarr;  
algorithm
 for i in 1:size(inarr,1) loop
   outarr[i] := func(inarr[i]);
 end for;
end arr_map_int;

function TestArrInt
algorithm
	arr2 := arr_map_int(add1, {2,3,5,8})
end TestArrInt;

function arr_map "Map over an array of elements of Type_a"
  replaceable type Type_a;
  function Functype input Type_a x1; output Type_a x2; end Functype;
  input replaceable function func extends Functype;
  input Type_a[:] inarr;
  output Type_a[size(inarr,1)] outarr;
algorithm
 for i in 1:size(inarr,1) loop
  outarr[i] := func(inarr[i]);
 end for;
end arr_map;

function TestArrTyVar
algorithm
 arr3 := arr_map<String>(addA, {"foo","fie"});
end TestArrTyVar;

*/
end Eval;