
% Mercury implementation - first try
% Adrian Pop, 2006-04-10
% mf.pl -- Mini-Freja Evaluator
:- module mf.

:- interface.
:- import_module io, list.
:- pred main(io.state::di, io.state::uo) is det.


:- implementation.
:- import_module builtin, int, bool, list, std_util, io, string.


% Implementation of some primops
:- pred int_lt(int::in, int::in, bool.bool::out).
int_lt(X, Y, Z) :- (X < Y   -> Z=bool.yes ; Z=bool.no).
:- pred int_le(int::in, int::in, bool.bool::out).
int_le(X, Y, Z) :- (X =< Y  -> Z=bool.yes ; Z=bool.no).
:- pred int_eq(int::in, int::in, bool.bool::out).
int_eq(X, Y, Z) :- (X = Y -> Z=bool.yes ; Z=bool.no).
:- pred int_ne(int::in, int::in, bool.bool::out).
int_ne(X, Y, Z) :- (X \= Y -> Z=bool.no ; Z=bool.yes).
:- pred int_ge(int::in, int::in, bool.bool::out).
int_ge(X, Y, Z) :- (X >= Y  -> Z=bool.yes ; Z=bool.no).
:- pred int_gt(int::in, int::in, bool.bool::out).
int_gt(X, Y, Z) :- (X > Y   -> Z=bool.yes ; Z=bool.no).

% Check if the args are equal, return bool.yes of bool.no

%equal(?Any, ?Any, -Bool)

:- pred equal(T::in, T::in, bool.bool::out).
equal(X, Y, Z) :- (X=Y -> Z=bool.yes ; Z=bool.no).

% Apply a unary strict primop. The argument must be a constant.
%primapp1(+Prim1, +Const, -Const)
:- type prim1 ---> pNOT ; pNEG.
:- type const ---> conBOOL(bool.bool) ; conINT(int) ; conNIL.
:- pred primapp1(prim1::in, const::in, const::out).
primapp1(pNOT, conBOOL(X), conBOOL(Y)) :- bool__not(X, Y).
primapp1(pNEG, conINT(X),  conINT(Y))  :- Y is -X.

% Apply a binary strict primop. The arguments must be constant.
%primapp2(+Prim2, +Const, -Const)
:- type prim2 ---> pLT ; pLE; pEQ ; pNE ; pGE ; pGT ; pAND ; pOR ; pADD ; pSUB ; pMUL ; pDIV ; pMOD.
:- pred primapp2(prim2::in, const::in, const::in, const::out) is semidet.
primapp2(pLT, conINT(X), conINT(Y), conBOOL(Z))    :- int_lt(X, Y, Z).
primapp2(pLE, conINT(X), conINT(Y), conBOOL(Z))    :- int_le(X, Y, Z).
primapp2(pEQ, conINT(X), conINT(Y), conBOOL(Z))    :- int_eq(X, Y, Z).
primapp2(pNE, conINT(X), conINT(Y), conBOOL(Z))    :- int_ne(X, Y, Z).
primapp2(pGE, conINT(X), conINT(Y), conBOOL(Z))    :- int_ge(X, Y, Z).
primapp2(pGT, conINT(X), conINT(Y), conBOOL(Z))    :- int_gt(X, Y, Z).
primapp2(pADD, conINT(X), conINT(Y), conINT(Z))    :- Z is X+Y.
primapp2(pSUB, conINT(X), conINT(Y), conINT(Z))    :- Z is X-Y.
primapp2(pMUL, conINT(X), conINT(Y), conINT(Z))    :- Z is X*Y.
primapp2(pDIV, conINT(X), conINT(Y), conINT(Z))    :- Z is X//Y.
primapp2(pMOD, conINT(X), conINT(Y), conINT(Z))    :- Z is X mod Y.
primapp2(pAND, conBOOL(X), conBOOL(Y), conBOOL(Z)) :- bool__and(X, Y, Z).
primapp2(pOR, conBOOL(X), conBOOL(Y), conBOOL(Z))  :- bool__or(X, Y, Z).


% Find the most recent binding of an identifier in an environment.
%lookup(+Env, +Var, -Val)
:- type var == string.
:- type pat ---> patCONST(const) ; patVAR(var) ; patCONS(pat, pat).
:- type exp ---> 
	expCONST(const)           ;
	expVAR(var)               ;	
	expCONS(exp, exp)         ;	
	expLAM(string, exp)       ;
	expPRIM1(prim1, exp)      ;
	expPRIM2(prim2, exp, exp) ;
	expIF(exp, exp, exp)      ;
	expAPP(exp, exp)          ;
	expCASE(exp, list(ruleT)) ;
	expREC(list(bindT), exp)  .
:- type val   ---> 
	valCONST(const)       ;
	valCLO(list(boundT), var, exp) ;
	valCONS(val, val)     ;
	valSUSP(list(boundT), exp)     .
:- type boundT ---> bound(var, val).
:- type env    ---> list(boundT).
:- type bindT  ---> bind(var, exp).
:- type ruleT  ---> rule(pat, exp). 

:- pred lookup(list(boundT)::in, var::in, val::out). 
lookup([bound(ID,VAL)|RHO], ID1, VAL1) :-
	equal(ID, ID1, FLAG),
	lookup_choose(FLAG, VAL, RHO, ID1, VAL1).

%lookup_choose(+Bool, +Val, +Env, +Var, -Val)
:- pred lookup_choose(bool.bool::in, val::in, list(boundT)::in, var::in, val::out).
lookup_choose(bool.yes, VAL, _, _, VAL).
lookup_choose(bool.no, _, RHO, ID, VAL) :-
	lookup(RHO, ID, VAL).

% Augment an environment with a set of recursive declarations
% Step 1: guess the resulting environment RHO2
% Step 2: augment old env with binding (id,SUSP(RHO2,e)) for each declaration (id,e)
% Step 3: unify RHO2 with the final augmented environment RHO3
%newenv(+Env, +(Var*Exp) list, -Env, -Env)
:- pred newenv(list(boundT), list(bindT), list(boundT), list(boundT)) is nondet.
:- mode newenv(in, in, out, out).
newenv(RHO, [], _, RHO).
newenv(RHO1, [bind(ID,EXP)|DECLS], RHO2, RHO3) :-
	newenv([bound(ID,valSUSP(RHO2,EXP))|RHO1], DECLS, RHO2, RHO3).

% recenv(+Env, +(Var*Exp) list, -Env)
:- pred recenv(list(boundT)::in, list(bindT)::in, list(boundT)::out).
recenv(RHO1, DECLS, RHO3) :-
	newenv(RHO1, DECLS, RHO2, RHO3),
	RHO2 = RHO3.
	

% Match a pattern with a value. Return augmented environment.
%datatype MatchOut = mBOOL.YES of Env | mNO
%match_const(+Bool, +Env, -MatchOut)
:- type matchOut ---> mBOOL_YES(list(boundT)) ; mNO.
:- pred match_const(bool.bool::in, list(boundT)::in, matchOut::out).
match_const(bool.yes, RHO, mBOOL_YES(RHO)).
match_const(bool.no, _, mNO).

%match(+Env, +Val, +Pat, -MatchOut)
:- pred match(list(boundT)::in, val::in, pat::in, matchOut::out).
match(RHO, VAL, patVAR(ID), mBOOL_YES([bound(ID,VAL)|RHO])).
match(RHO, valCONST(C1), patCONST(C2), OUT) :-
	equal(C1, C2, FLAG),
	match_const(FLAG, RHO, OUT).
match(RHO, valCONS(V1,V2), patCONS(P1,P2), OUT2) :-
	match(RHO, V1, P1, OUT1),
	match_pair(OUT1, V2, P2, OUT2).
match(_, valCONST(_), patCONS(_,_), mNO).
match(_, valCONS(_,_), patCONST(_), mNO).

%match_pair(+MatchOut, +Val, +Pat, -MatchOut)
:- pred match_pair(matchOut::in, val::in, pat::in, matchOut::out).
match_pair(mBOOL_YES(RHO), V2, P2, OUT) :-
	match(RHO, V2, P2, OUT).
match_pair(mNO, _, _, mNO).

% Using result of IF predicate, choose between the alternative expressions

%if_choose(+Bool, +Exp, +Exp, -Exp)
:- pred if_choose(bool.bool::in, exp::in, exp::in, exp::out).

if_choose(bool.yes, E2, _, E2).
if_choose(bool.no, _, E3, E3).

% Evaluate the expression of the first pattern to match the value. Result in whnf

%case(+Env, +Val, +Rule list, -Val)
:- pred case(list(boundT)::in, val::in, list(ruleT)::in, val::out). 
case(RHO, V, [rule(PAT,EXP)|RULES], V1) :-
	match(RHO, V, PAT, OUT),
	case_choose(OUT, EXP, RHO, V, RULES, V1).

% case_choose(+MatchOut, +Exp, +Env, +Val, +Rule list, -Val)
:- pred case_choose(matchOut::in, exp::in, list(boundT)::in, val::in, list(ruleT)::in, val::out).
case_choose(mBOOL_YES(RHO1), EXP, _, _, _, V1) :-
	eval(RHO1, EXP, V1).
case_choose(mNO, _, RHO, V, RULES, V1) :-
	case(RHO, V, RULES, V1).

% Compute the whnf of an expression in an environment

%eval(+Env, +Exp, -Val)
:- pred eval(list(boundT)::in, exp::in, val::out).
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
:- pred force(val::in, val::out).
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
:- pred strict(val::in, val::out).
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

% Evaluate an expression and return the result
%exec(+Exp, +[Val], -[Val])
:- pred exec(exp::in, list(val)::in, list(val)::out) is semidet.
exec(EXP, IN, OUT) :-
	eval([], EXP, V1),
	strict(V1, V2),
	OUT=[V2|IN].

% Construct a test case for sieve
% mkfilter(-Exp)
:- pred mkfilter(exp::out).
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

% mktake(-Exp)
:- pred mktake(exp::out).
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

% mkfrom(-Exp)
:- pred mkfrom(exp::out).
mkfrom(
expLAM("n",
       expCONS(expVAR("n"),
	       expAPP(expVAR("from"),
		      expPRIM2(pADD,
			       expVAR("n"),
			       expCONST(conINT(1))))))
).

% mknotdiv(-Exp)
:- pred mknotdiv(exp::out).
mknotdiv(
expLAM("x",
       expLAM("y",
	      expPRIM2(pNE,
		       expPRIM2(pMOD,
				expVAR("y"),
				expVAR("x")),
		       expCONST(conINT(0)))))
).

% mksieve(-Exp)
:- pred mksieve(exp::out).
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

% mkprimes(-Exp)
:- pred mkprimes(exp::out).
mkprimes(
expAPP(expVAR("sieve"),
       expAPP(expVAR("from"),
	      expCONST(conINT(2))))
).

% mkmain(+Exp)
:- pred mkmain(int::in, exp::out).
mkmain(NTH,
expAPP(expAPP(expVAR("take"),
	      expCONST(conINT(NTH))),
       expVAR("primes"))
).

%sieve(+Int, -Exp)
:-pred sieve(int::in, exp::out).
sieve(NTH, EXP) :-
	mkfilter(FILTER),
	mktake(TAKE),
	mkfrom(FROM),
	mknotdiv(NOTDIV),
	mksieve(SIEVE),
	mkprimes(PRIMES),
	mkmain(NTH, MAIN),
	EXP=expREC(
		[bind("filter", FILTER),
		 bind("take", TAKE),
		 bind("from", FROM),
		 bind("not_div", NOTDIV),
		 bind("sieve", SIEVE),
		 bind("primes", PRIMES)],
		 MAIN).

% mkfac(+Exp)
:- pred mkfac(exp::out).
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

%sweepVal(+Val, list(string)).
:- pred sweepVal(val::in, list(string)::in, list(string)::out).
sweepVal(valCONS(V1, V2), StrListIn, StrListOut2) :-
	sweepVal(V1, StrListIn, StrListOut1), 
	sweepVal(V2, StrListOut1, StrListOut2).
sweepVal(valCONST(conINT(I)), StrListIn, StrListOut) :- 
	string.int_to_string(I, StrI),
	list.cons(StrI, StrListIn, StrListOut).
sweepVal(_, StrListIn, StrListOut) :- 
	list.cons("<other>", StrListIn, StrListOut).

%sweepValList(+[Val], list(string), list(string)).
:- pred sweepValList(list(val)::in, list(string)::in, list(string)::out).
sweepValList([V1|REST], StrListIn, StrListOut) :- 
	sweepVal(V1, StrListIn, StrListOut1),
	sweepValList(REST, StrListOut1, StrListOut).
sweepValList([], X, X). 


%readArgs(list(string)::in, int::out)
%:- pred readArgs(list(string)::in, int::out) is det.
%readArgs([XSTR|_], string.det_to_int(XSTR)).
%readArgs(_, 0).

% main(+int, +list(int))
main(!IO) :-
	    sieve(10, EXP),
	    (exec(EXP, [], OUT) ->
		print("Ok", !IO)
		;
		print("NOT Ok", !IO)
	    ).



