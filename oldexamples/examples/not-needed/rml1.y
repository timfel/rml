module:
	MODULE IDENT COLON interface dec_star
	{ $0 = Absyn.RML_FILE(mkstring($2), $4, $5);}
|
	INTERFACE IDENT COLON interface
	{ $0 = Absyn.RML_FILE(mkstring($2), $4, mk_nil());}
;

/* interface specifications */

spec_star:
	/* empty */
	{ $0 = mk_nil(); }
|
	spec spec_star
	{ $0 = mk_cons($1, $2);}
;

spec:
	WITH SCON
		{ Absyn.WITH($1);}
|
	TYPE tyvarseq ident
		( Absyn.ABSTYPEspec(false, tyvarseq, ident) )
| EQTYPE tyvarseq ident
		( Absyn.ABSTYPEspec(true, tyvarseq, ident) )
	| TYPE typbind_plus
		( Absyn.TYPEspec(typbind_plus) )
	| DATATYPE datbind_plus withbind
		( Absyn.DATAspec(datbind_plus, withbind) )
	| VAL ident COLON ty
		( Absyn.VALspec(ident, ty) )
	| RELATION ident COLON ty
		( Absyn.RELspec(ident, ty) )

(* DECLARATIONS *)

dec_star
	: (*empty*)
		( [] )
	| dec dec_star
		( dec :: dec_star )

dec
	: WITH SCON
		( Absyn.WITHdec(SCON, ref Absyn.dummyInterface) )
	| TYPE typbind_plus
		( Absyn.TYPEdec(typbind_plus) )
	| DATATYPE datbind_plus withbind
		( Absyn.DATAdec(datbind_plus, withbind) )
	| VAL ident EQ exp
		( Absyn.VALdec(ident, exp) )
	| RELATION relbind_plus
		( Absyn.RELdec(relbind_plus) )

(* Constructor, datatype, type, withtype, and relation bindings *)

relbind_plus
	: relbind AND relbind_plus
		( relbind :: relbind_plus )
	| relbind
		( [relbind] )

relbind
	: ident relbind_ty_opt EQ clause_plus default_opt END
		( Absyn.RELBIND(ident, relbind_ty_opt, join_default(clause_plus,default_opt)) )

relbind_ty_opt
	: COLON ty
		( SOME(ty) )
	| (*empty*)
		( NONE )

withbind
	: (*empty*)
		( [] )
	| WITHTYPE typbind_plus
		( typbind_plus )

typbind_plus
	: typbind AND typbind_plus
		( typbind :: typbind_plus )
	| typbind
		( [typbind] )

typbind
	: tyvarseq ident EQ ty
		( Absyn.TYPBIND(tyvarseq, ident, ty) )

datbind_plus
	: datbind AND datbind_plus
		( datbind :: datbind_plus )
	| datbind
		( [datbind] )

datbind
	: tyvarseq ident EQ conbind_plus
		( Absyn.DATBIND(tyvarseq, ident, conbind_plus) )

conbind_plus
	: conbind BAR conbind_plus
		( conbind :: conbind_plus )
	| conbind
		( [conbind] )

conbind
	: ident
		( Absyn.CONcb(ident) )
	| ident OF tuple_ty
		( Absyn.CTORcb(ident, tuple_ty) )

(* DEFAULT CLAUSES *)

default_opt
	: (*empty*)
		( NONE )
	| DEFAULT clause_plus
		( SOME(clause_plus) )

(* CLAUSES *)

clause_plus
	: clause
		( clause )
	| clause clause_plus
		( Absyn.CLAUSE2(clause, clause_plus) )

clause
	: RULE conjunctive_goal_opt DASHES ident seq_pat result
		( Absyn.CLAUSE1(conjunctive_goal_opt, ident, seq_pat, result) )
	| AXIOM ident seq_pat result
		( Absyn.CLAUSE1(NONE, ident, seq_pat, result) )

result
	: (*empty*)
		( Absyn.RETURN [] )
	| YIELDS seq_exp
		( Absyn.RETURN seq_exp )
	| YIELDS FAIL
		( Absyn.FAIL )

(* GOALS *)

conjunctive_goal_opt
	: (*empty*)
		( NONE )
	| conjunctive_goal
		( SOME(conjunctive_goal) )

conjunctive_goal
	: atomic_goal
		( atomic_goal )
	| atomic_goal AMPERSAND conjunctive_goal
		( Absyn.ANDgoal(atomic_goal, conjunctive_goal) )

atomic_goal
	: longorshortid seq_exp res_pat
		( Absyn.CALLgoal(longorshortid, seq_exp, res_pat) )
	| ident EQ exp
		( Absyn.EQUALgoal(ident, exp) )
	| LET pat EQ exp
		( Absyn.LETgoal(pat, exp) )
	| NOT atomic_goal
		( Absyn.NOTgoal(atomic_goal) )
	| LPAREN conjunctive_goal RPAREN
		( conjunctive_goal )

(* EXPRESSIONS *)

exp	(* expressions possibly starting with LPAREN *)
	: exp_a COLONCOLON exp
		( Absyn.STRUCTexp(ctor_cons, [exp_a,exp]) )
	| exp_a
		( exp_a )

exp_a	(* simple expressions possibly starting with LPAREN *)
	: LPAREN RPAREN
		( Absyn.STRUCTexp(NONE, []) )
	| LPAREN exp RPAREN
		( exp )
	| LPAREN exp COMMA exp_comma_plus RPAREN
		( Absyn.STRUCTexp(NONE, exp :: exp_comma_plus) )
	| exp_c
		( exp_c )

exp_b	(* expressions not starting with LPAREN *)
	: exp_c COLONCOLON exp_b
		( Absyn.STRUCTexp(ctor_cons, [exp_c,exp_b]) )
	| exp_c
		( exp_c )

exp_c	(* simple expressions not starting with LPAREN *)
	: longorshortid exp_star
		( Absyn.STRUCTexp(SOME longorshortid, exp_star) )
	| longorshortid exp_d
		( Absyn.STRUCTexp(SOME longorshortid, [exp_d]) )
	| exp_d
		( exp_d )

exp_d	(* atomic expressions not starting with LPAREN *)
	: literal
		( Absyn.LITexp(literal) )
	| longorshortid
		( Absyn.IDENTexp(longorshortid, ref(Absyn.STRUCTexp(NONE,[]))) )
	| LBRACK exp_comma_star RBRACK
		( mkexplst(exp_comma_star) )

seq_exp
	: (*empty*)
		( [] )
	| exp_b		(* cannot start with LPAREN *)
		( [exp_b] )
	| exp_star
		( exp_star )

exp_star
	: LPAREN exp_comma_star RPAREN
		( exp_comma_star )

exp_comma_star
	: (*empty*)
		( [] )
	| exp_comma_plus
		( exp_comma_plus )

exp_comma_plus
	: exp
		( [exp] )
	| exp COMMA exp_comma_plus
		( exp :: exp_comma_plus )

(* PATTERNS *)

pat	(* patterns possibly starting with LPAREN *)
	: ident AS pat
		( Absyn.BINDpat(ident, pat))
	| pat_a
		( pat_a )

pat_a
	: pat_b COLONCOLON pat_a
		( Absyn.STRUCTpat(ctor_cons, [pat_b,pat_a]) )
	| pat_b
		( pat_b )

pat_b	(* simple patterns possibly starting with LPAREN *)
	: LPAREN RPAREN
		( Absyn.STRUCTpat(NONE, []) )
	| LPAREN pat RPAREN
		( pat )
	| LPAREN pat COMMA pat_comma_plus RPAREN
		( Absyn.STRUCTpat(NONE, pat :: pat_comma_plus) )
	| pat_d
		( pat_d )

pat_c	(* patterns not starting with LPAREN *)
	: pat_d COLONCOLON pat_c
		( Absyn.STRUCTpat(ctor_cons, [pat_d,pat_c]) )
	| pat_d
		( pat_d )

pat_d	(* simple patterns not starting with LPAREN *)
	: longorshortid pat_star
		( Absyn.STRUCTpat(SOME longorshortid, pat_star) )
	| longorshortid pat_e
		( Absyn.STRUCTpat(SOME longorshortid, [pat_e]) )
	| pat_e
		( pat_e )

pat_e	(* atomic patterns not starting with LPAREN *)
	: WILD
		( Absyn.WILDpat )
	| literal
		( Absyn.LITpat(literal) )
	| longid
		( Absyn.CONpat(longid) )
	| ident
		( Absyn.IDENTpat(ident, ref Absyn.WILDpat) )
	| LBRACK pat_comma_star RBRACK
		( mkpatlst(pat_comma_star) )

res_pat
	: (*empty*)
		( [] )
	| YIELDS seq_pat
		( seq_pat )

seq_pat
	: (*empty*)
		( [] )
	| pat_c		(* cannot start with LPAREN *)
		( [pat_c] )
	| pat_star
		( pat_star )

pat_star
	: LPAREN pat_comma_star RPAREN
		( pat_comma_star )

pat_comma_star
	: (*empty*)
		( [] )
	| pat_comma_plus
		( pat_comma_plus )

pat_comma_plus
	: pat
		( [pat] )
	| pat COMMA pat_comma_plus
		( pat :: pat_comma_plus )

(* LITERALS *)

literal
	: CCON
		( Absyn.CCONlit(CCON) )
	| ICON
		( Absyn.ICONlit(ICON) )
	| RCON
		( Absyn.RCONlit(RCON) )
	| SCON
		( Absyn.SCONlit(SCON) )

(* TYPES *)

ty
	: seq_ty YIELDS seq_ty
		( Absyn.RELty(seq_ty1, seq_ty2) )
	| tuple_ty
		( mktuplety(tuple_ty) )

tuple_ty
	: ty_sans_star STAR tuple_ty
		( ty_sans_star :: tuple_ty )
	| ty_sans_star
		( [ty_sans_star] )

ty_sans_star
	: ty_sans_star longorshortid
		( Absyn.CONSty([ty_sans_star], longorshortid) )
	| LPAREN ty_comma_seq2 RPAREN longorshortid
		( Absyn.CONSty(ty_comma_seq2, longorshortid) )
	| LPAREN ty RPAREN
		( ty )
	| tyvar
		( Absyn.VARty(tyvar) )
	| longorshortid
		( Absyn.CONSty([], longorshortid) )

ty_comma_seq2
	: ty COMMA ty_comma_seq2
		( ty :: ty_comma_seq2 )
	| ty COMMA ty
		( [ty1, ty2] )

seq_ty
	: LPAREN RPAREN
		( [] )
	| LPAREN ty_comma_seq2 RPAREN
		( ty_comma_seq2 )
	| tuple_ty
		( [mktuplety(tuple_ty)] )

tyvarseq
	: (*empty*)
		( [] )
	| tyvar
		( [tyvar] )
	| LPAREN tyvar_comma_plus RPAREN
		( tyvar_comma_plus )

tyvar_comma_plus
	: tyvar COMMA tyvar_comma_plus
		( tyvar :: tyvar_comma_plus )
	| tyvar
		( [tyvar] )

(* LONG IDENTIFIERS *)

longid
	: ident DOT ident
		( Absyn.LONGID(SOME ident1, ident2) )

longorshortid
	: longid
		( longid )
	| ident
		( Absyn.LONGID(NONE, ident) )

(* SHORT IDENTIFIERS *)

ident
	: IDENT
		( Absyn.makeIdent(IDENT, IDENTleft, IDENTright) )

tyvar
	: TYVAR
		( Absyn.makeIdent(TYVAR, TYVARleft, TYVARright) )
