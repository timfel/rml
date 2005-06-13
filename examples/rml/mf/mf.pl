% mf.pl -- Mini-Freja Evaluator

% type in these SICSTUS declarations before compiling:
% :- prolog_flag(compiling, _, fastcode).
% :- prolog_flag(gc_trace, _, terse).

%datatype Prim1	= pNOT | pNEG
%datatype Prim2	= pLT | pLE | pEQ | pNE | pGE | pGT | pAND
%		| pOR | pADD | pSUB | pMUL | pDIV | pMOD
%
%datatype Const	= conINT of int
%		| conBOOL of bool
%		| conNIL
%
%datatype Pat	= patCONST of Const
%		| patVAR of Var
%		| patCONS of Pat * Pat
%
%datatype Exp	= expCONST of Const
%		| expVAR of Var
%		| expCONS of Exp * Exp
%		| expLAM of Var * Exp
%		| expPRIM1 of Prim1 * Exp
%		| expPRIM2 of Prim2 * Exp * Exp
%		| expIF of Exp * Exp * Exp
%		| expAPP of Exp * Exp
%		| expCASE of Exp * Rule list
%		| expREC of Bind list * Exp
%and Bind	= bind of Var * Exp
%and Rule	= rule of Pat * Exp
%
%datatype Val	= valCONST of Const
%		| valCLO of Env * Var * Exp
%		| valCONS of Val * Val
%		| valSUSP of Env * Exp
%and Bound	= bound of Var * Val
%withtype Env	= Bound list

% Implementation of some primops

bool_not(true, false).
bool_not(false, true).
bool_and(true, true, true).
bool_and(true, false, false).
bool_and(false, _, false).
bool_or(false, false, false).
bool_or(false, true, true).
bool_or(true, _, true).

int_lt(X, Y, Z) :- ('<'(X, Y) -> Z=true ; Z=false).
int_le(X, Y, Z) :- ('=<'(X, Y) -> Z=true ; Z=false).
int_eq(X, Y, Z) :- ('=:='(X, Y) -> Z=true ; Z=false).
int_ne(X, Y, Z) :- ('=\='(X, Y) -> Z=true ; Z=false).
int_ge(X, Y, Z) :- ('>='(X, Y) -> Z=true ; Z=false).
int_gt(X, Y, Z) :- ('>'(X, Y) -> Z=true ; Z=false).

% Check if the args are equal, return true of false

%equal(?Any, ?Any, -Bool)

equal(X, Y, Z) :- (X=Y -> Z=true ; Z=false).

% Apply a unary strict primop. The argument must be a constant.

%primapp1(+Prim1, +Const, -Const)

primapp1(pNOT, conBOOL(X), conBOOL(Y)) :-
	bool_not(X, Y).
primapp1(pNEG, conINT(X), conINT(Y)) :-
	Y is -X.

% Apply a binary strict primop. The arguments must be constant.

%primapp2(+Prim2, +Const, -Const)

primapp2(pLT, conINT(X), conINT(Y), conBOOL(Z)) :-
	int_lt(X, Y, Z).
primapp2(pLE, conINT(X), conINT(Y), conBOOL(Z)) :-
	int_le(X, Y, Z).
primapp2(pEQ, conINT(X), conINT(Y), conBOOL(Z)) :-
	int_eq(X, Y, Z).
primapp2(pNE, conINT(X), conINT(Y), conBOOL(Z)) :-
	int_ne(X, Y, Z).
primapp2(pGE, conINT(X), conINT(Y), conBOOL(Z)) :-
	int_ge(X, Y, Z).
primapp2(pGT, conINT(X), conINT(Y), conBOOL(Z)) :-
	int_gt(X, Y, Z).
primapp2(pADD, conINT(X), conINT(Y), conINT(Z)) :-
	Z is X+Y.
primapp2(pSUB, conINT(X), conINT(Y), conINT(Z)) :-
	Z is X-Y.
primapp2(pMUL, conINT(X), conINT(Y), conINT(Z)) :-
	Z is X*Y.
primapp2(pDIV, conINT(X), conINT(Y), conINT(Z)) :-
	Z is X//Y.
primapp2(pMOD, conINT(X), conINT(Y), conINT(Z)) :-
	Z is X mod Y.
primapp2(pAND, conBOOL(X), conBOOL(Y), conBOOL(Z)) :-
	bool_and(X, Y, Z).
primapp2(pOR, conBOOL(X), conBOOL(Y), conBOOL(Z)) :-
	bool_or(X, Y, Z).

% Find the most recent binding of an identifier in an environment.

%lookup(+Env, +Var, -Val)

lookup([bound(ID,VAL)|RHO], ID1, VAL1) :-
	equal(ID, ID1, FLAG),
	lookup_choose(FLAG, VAL, RHO, ID1, VAL1).

%lookup_choose(+Bool, +Val, +Env, +Var, -Val)

lookup_choose(true, VAL, _, _, VAL).
lookup_choose(false, _, RHO, ID, VAL) :-
	lookup(RHO, ID, VAL).

% Augment an environment with a set of recursive declarations
% Step 1: guess the resulting environment RHO2
% Step 2: augment old env with binding (id,SUSP(RHO2,e)) for each declaration (id,e)
% Step 3: unify RHO2 with the final augmented environment RHO3

%newenv(+Env, +(Var*Exp) list, -Env, -Env)

newenv(RHO, [], _, RHO).
newenv(RHO1, [bind(ID,EXP)|DECLS], RHO2, RHO3) :-
	newenv([bound(ID,valSUSP(RHO2,EXP))|RHO1], DECLS, RHO2, RHO3).

% recenv(+Env, +(Var*Exp) list, -Env)

recenv(RHO1, DECLS, RHO3) :-
	newenv(RHO1, DECLS, RHO2, RHO3),
	RHO2 = RHO3.

% Match a pattern with a value. Return augmented environment.

%datatype MatchOut = mYES of Env | mNO

%match_const(+Bool, +Env, -MatchOut)

match_const(true, RHO, mYES(RHO)).
match_const(false, _, mNO).

%match(+Env, +Val, +Pat, -MatchOut)

match(RHO, VAL, patVAR(ID), mYES([bound(ID,VAL)|RHO])).
match(RHO, valCONST(C1), patCONST(C2), OUT) :-
	equal(C1, C2, FLAG),
	match_const(FLAG, RHO, OUT).
match(RHO, valCONS(V1,V2), patCONS(P1,P2), OUT2) :-
	match(RHO, V1, P1, OUT1),
	match_pair(OUT1, V2, P2, OUT2).
match(_, valCONST(_), patCONS(_,_), mNO).
match(_, valCONS(_,_), patCONST(_), mNO).

%match_pair(+MatchOut, +Val, +Pat, -MatchOut)

match_pair(mYES(RHO), V2, P2, OUT) :-
	match(RHO, V2, P2, OUT).
match_pair(mNO, _, _, mNO).

% Using result of IF predicate, choose between the alternative expressions

%if_choose(+Bool, +Exp, +Exp, -Exp)

if_choose(true, E2, _, E2).
if_choose(false, _, E3, E3).

% Evaluate the expression of the first pattern to match the value. Result in whnf

%case(+Env, +Val, +Rule list, -Val)

case(RHO, V, [rule(PAT,EXP)|RULES], V1) :-
	match(RHO, V, PAT, OUT),
	case_choose(OUT, EXP, RHO, V, RULES, V1).

% case_choose(+MatchOut, +Exp, +Env, +Val, +Rule list, -Val)

case_choose(mYES(RHO1), EXP, _, _, _, V1) :-
	eval(RHO1, EXP, V1).
case_choose(mNO, _, RHO, V, RULES, V1) :-
	case(RHO, V, RULES, V1).

% Compute the whnf of an expression in an environment

%eval(+Env, +Exp, -Val)

eval(_, expCONST(C), valCONST(C)).
eval(RHO, expVAR(ID), V2) :-
	lookup(RHO, ID, V1),
	force(V1, V2).
eval(RHO, expCONS(E1,E2), valCONS(valSUSP(RHO,E1), valSUSP(RHO,E2))).
eval(RHO, expLAM(ID,EXP), valCLO(RHO,ID,EXP)).
eval(RHO, expCASE(EXP,RULES), V2) :-
	eval(RHO, EXP, V1),
	case(RHO, V1, RULES, V2).
eval(RHO, expPRIM1(PRIM1,EXP), valCONST(C2)) :-
	eval(RHO, EXP, valCONST(C1)),
	primapp1(PRIM1, C1, C2).
eval(RHO, expPRIM2(PRIM2,E1,E2), valCONST(C3)) :-
	eval(RHO, E1, valCONST(C1)),
	eval(RHO, E2, valCONST(C2)),
	primapp2(PRIM2, C1, C2, C3).
eval(RHO, expIF(E1,E2,E3), V) :-
	eval(RHO, E1, valCONST(conBOOL(FLAG))),
	if_choose(FLAG, E2, E3, E),
	eval(RHO, E, V).
eval(RHO, expAPP(F,ARG), V) :-
	eval(RHO, F, valCLO(RHO1,FORMAL,BODY)),
	eval([bound(FORMAL,valSUSP(RHO,ARG))|RHO1], BODY, V).
eval(RHO, expREC(DECLS,EXP), V) :-
	recenv(RHO, DECLS, RHO1),
	eval(RHO1, EXP, V).

% Force a value to be in whnf

%force(+Val, -Val)

force(V, V) :-
	V = valCONST(_).
force(V, V) :-
	V = valCLO(_,_,_).
force(V, V) :-
	V = valCONS(_,_).
force(valSUSP(RHO,EXP), V2) :-
	eval(RHO, EXP, V1),
	force(V1, V2).

% Force a value to be fully evaluated

%strict(+Val, -Val)

strict(V, V) :-
	V = valCONST(_).
strict(V, V) :-
	V = valCLO(_,_,_).
strict(valCONS(V1,V2), valCONS(V3,V4)) :-
	strict(V1, V3),
	strict(V2, V4).
strict(valSUSP(RHO,EXP), V2) :-
	eval(RHO, EXP, V1),
	strict(V1, V2).

% Evaluate an expression and print the result

%exec(+Exp)

exec(EXP) :-
	eval([], EXP, V1),
	strict(V1, V2),
	write(V2),nl.

% Construct a test case for sieve

mkfilter(
expLAM("p",
       expLAM("xs0",
	      expCASE(expVAR("xs0"),
		      [rule(patCONST(conNIL),
			    expCONST(conNIL)),
		       rule(patCONS(patVAR("x"), patVAR("xs")),
			    expIF(expAPP(expVAR("p"), expVAR("x")),
				  expCONS(expVAR("x"),
					  expAPP(expAPP(expVAR("filter"),
							expVAR("p")),
						 expVAR("xs"))),
				  expAPP(expAPP(expVAR("filter"),
						expVAR("p")),
					 expVAR("xs"))))])))
).

mktake(
expLAM("n0",
       expLAM("xs0",
	      expCASE(expVAR("n0"),
		      [rule(patCONST(conINT(0)),
			    expCONST(conNIL)),
		       rule(patVAR("n"),
			    expCASE(expVAR("xs0"),
				    [rule(patCONS(patVAR("x"), patVAR("xs")),
					  expCONS(expVAR("x"),
						  expAPP(expAPP(expVAR("take"),
								expPRIM2(pSUB,
									 expVAR("n"),
									 expCONST(conINT(1)))),
							 expVAR("xs")))),
				     rule(patCONST(conNIL),
					  expCONST(conNIL))]))])))
).

mkfrom(
expLAM("n",
       expCONS(expVAR("n"),
	       expAPP(expVAR("from"),
		      expPRIM2(pADD,
			       expVAR("n"),
			       expCONST(conINT(1))))))
).

mknotdiv(
expLAM("x",
       expLAM("y",
	      expPRIM2(pNE,
		       expPRIM2(pMOD,
				expVAR("y"),
				expVAR("x")),
		       expCONST(conINT(0)))))
).

mksieve(
expLAM("xs0",
       expCASE(expVAR("xs0"),
	       [rule(patCONS(patVAR("x"), patVAR("xs")),
		     expCONS(expVAR("x"),
			     expAPP(expVAR("sieve"),
				    expAPP(expAPP(expVAR("filter"),
						  expAPP(expVAR("not_div"),
							 expVAR("x"))),
					   expVAR("xs")))))]))
).

mkprimes(
expAPP(expVAR("sieve"),
       expAPP(expVAR("from"),
	      expCONST(conINT(2))))
).

mkmain(NTH,
expAPP(expAPP(expVAR("take"),
	      expCONST(conINT(NTH))),
       expVAR("primes"))
).

%sieve(+Int, -Exp)

sieve(NTH, EXP) :-
	mkfilter(FILTER),
	mktake(TAKE),
	mkfrom(FROM),
	mknotdiv(NOTDIV),
	mksieve(SIEVE),
	mkprimes(PRIMES),
	mkmain(NTH, MAIN),
	EXP=expREC([bind("filter", FILTER),
		    bind("take", TAKE),
		    bind("from", FROM),
		    bind("not_div", NOTDIV),
		    bind("sieve", SIEVE),
		    bind("primes", PRIMES)],
		   MAIN).

mkfac(
expLAM("n",
       expIF(expPRIM2(pLE,
		      expVAR("n"),
		      expCONST(conINT(1))),
	     expCONST(conINT(1)),
	     expPRIM2(pMUL,
		      expVAR("n"),
		      expAPP(expVAR("fac"),
			     expPRIM2(pSUB,
				      expVAR("n"),
				      expCONST(conINT(1)))))))
).

% main

main :-
	sieve(18, EXP),
	exec(EXP),
	halt.
