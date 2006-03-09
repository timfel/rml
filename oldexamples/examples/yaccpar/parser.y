/* yaccpar.y -- Unified yacc parser for Modelica and RML.
 *
 * $Id$
 */
/*
//modelica

%token KW_CLASS KW_MODEL KW_RECORD KW_BLOCK KW_CONNECTOR KW_PACKAGE KW_FUNCTION
%token KW_FLOW KW_DISCRETE KW_PARAMETER KW_CONST KW_INPUT KW_OUTPUT
%token KW_ENCAPSULATED KW_PARTIAL KW_WITHIN KW_FINAL KW_EACH

%token KW_ENUMERATION KW_PUBLIC KW_EXTERNAL KW_OVERLOAD KW_IMPORT KW_PROTECTED
%token KW_INNER KW_OUTER KW_IF KW_THEN KW_ELSE KW_ELSEIF KW_FOR KW_LOOP KW_IN
%token KW_REPLACEABLE KW_WHEN KW_WHILE KW_ELSEWHEN KW_CONNECT
%token KW_INITIAL KW_ANNOTATION KW_TRUE KW_FALSE
%token KW_REDECLARE KW_EQUATION KW_ALGORITHM KW_EXTENDS KW_CODE
*/
%token KW_AND KW_AS KW_ABSTYPE KW_AXIOM KW_DATATYPE KW_DEFAULT
%token KW_END KW_EQTYPE KW_FAIL KW_INTERFACE KW_LET KW_MODULE
%token KW_NOT KW_OF KW_OR KW_RELATION KW_RULE KW_TYPE KW_VAL
%token KW_WITH KW_WITHTYPE

%token LBRACK RBRACK LBRACE RBRACE LPAR RPAR ASSIGN
%token DOT COLON COLONCOLON COMMA DASHES BAR AMPERSAND
%token SEMICOLON YIELDS STAR UNDERSCORE EQUALS PLUS MINUS DIV
%token LESS LESSEQ GREATER GREATEREQ EQEQ LESSGT
%token SLASH POWER UNSIGNED_INTEGER UNSIGNED_REAL

%token IDENT TYVARIDENT
%token CCON ICON RCON SCON
%{
#include <stdio.h> 
#include "yacclib.h" 
#include "rml.h" 
#include "absyn.h" 
#include "defs.h"
#define MAXCOMMENT 2000
extern int yylineno;
extern char yaccCommentBuffer[];
extern char parserCommentBuffer[];

#define mkIDENT(x) mk_scon(((struct Token*)x)->u.ident)

#define YYSTYPE rml_t
extern rml_t *absyntree;

%}

%%
start:
        stored_definition
{ 
          absyntree = $1;
}



stored_definition:
	/*	optENCAPSULATED optPARTIAL class_type ident
	{
	  $$ = Absyn__BEGIN_5fDEFINITION(Absyn__PATHIDENT(mkIDENT($4)), $3, $2, $1);
	}
	|
	KW_END ident SEMICOLON
	{
          $$ = Absyn__END_5fDEFINITION(mkIDENT($2));
	}
	|
	component_clause SEMICOLON
	{
	  $$ = Absyn__COMP_5fDEFINITION($1,mk_none());
	}
	|
	import_clause SEMICOLON
	{
	  $$ = Absyn__IMPORT_5fDEFINITION($1,mk_none());
	}
	|
	opt_within_clause class_definition_list
	{
	  $$ = Absyn__PROGRAM($2,$1);
        }
	| */
	rml_file
	{
	  $$ = $1;
	}
	;


/*********************************************/
/**************** RML Grammar ****************/
/*********************************************/

rml_file:
	KW_MODULE rml_ident COLON rml_interface rml_definitions
                { $$ = Absyn__RML_5fFILE($2, $4, $5); }
	|
	KW_INTERFACE rml_ident COLON rml_interface
                { $$ = Absyn__RML_5fFILE($2, $4, mk_nil()); }
	;

rml_interface:
	rml_interface_item_star
		{ $$ = $1; }
	KW_END
	;

rml_interface_item_star:
	rml_interface_item rml_interface_item_star
		{ $$ = mk_cons($1, $2); }
	|
		{ $$ = mk_nil(); }
	;

rml_interface_item:
	KW_WITH SCON
		{ $$ = Absyn__WITH(mk_scon(((struct Token*)$2)->u.string)); }
	|
	KW_TYPE tyvarparseq rml_ident
		{ $$ = mk_nil(); /* FIXME!! */; }
	|
	KW_TYPE typbind_plus
		{ $$ = $2; }
	|
	KW_DATATYPE datbind_plus withbind
		{ $$ = Absyn__DATATYPEDECL($2); }
	|
	KW_VAL rml_ident COLON ty
		{ $$ = Absyn__VALINTERFACE($2, $4); }
	|
	KW_RELATION rml_ident COLON ty
		{ $$ = Absyn__RELATION_5fINTERFACE($2, $4); }
	;

rml_definitions:
	rml_definition_item rml_definitions
		{ $$ = mk_cons($1, $2); }
	|
		{ $$ = mk_nil(); }
	;

rml_definition_item:
	KW_WITH SCON
		{ $$ = Absyn__WITH(mk_scon(((struct Token*)$2)->u.string)); }
	|
	KW_TYPE typbind_plus
		{ $$ = $2; }
	|
	KW_DATATYPE datbind_plus withbind
		{ $$ = Absyn__DATATYPEDECL($2); /* FIXME: support withbind */ }
	|
	KW_VAL rml_ident EQUALS rml_expression
		{ $$ = Absyn__VALDEF($2, $4); }
	|
	KW_RELATION relbind
		{ $$ = $2; }
	;

opt_type:
	COLON ty
		{ $$ = mk_some($2); }
	|
	empty
		{ $$ = mk_none(); }
	;

relbind:
	rml_ident opt_type EQUALS clause_plus default_opt KW_END
		{ $$ = Absyn__RELATION_5fDEFINITION($1, $2, $4); }
	;

withbind:
		{ $$ = mk_nil(); }
	|
	KW_WITHTYPE typbind_plus
		{ $$ = $2; }
	;

typbind_plus:
	typbind KW_AND typbind_plus /* do we really want to support this? */
		{ $$ = mk_cons($1, $3); }
	|
	typbind
		{ $$ = $1; }
	;

typbind:
	tyvarseq rml_ident EQUALS ty //should ty be ty_sans_star?
		{ $$ = Absyn__TYPE($2,$4); /* FIXME: $1 */ }
	;

datbind_plus:
	datbind KW_AND datbind_plus
		{ $$ = mk_cons($1, $3); }
	|
	datbind
                { $$ = $1; } //mk_cons($1, mk_nil()); }
	;

datbind:
	tyvarseq rml_ident EQUALS conbind_plus
		{ $$ = Absyn__DATATYPE(mk_nil(),$2, $4); /* FIXME: $1 */ }
	;

conbind_plus:
	conbind BAR conbind_plus
		{ $$ = mk_cons($1, $3); }
	|
	conbind
		{ $$ = mk_cons($1, mk_nil()); }
	;

conbind:
	rml_ident
		{ $$ = Absyn__DTCONS($1, mk_nil()); }
	|
	rml_ident KW_OF tuple_ty 
		{ $$ = Absyn__DTCONS($1, $3); }
	;

default_opt:
	/* empty */
	|
	KW_DEFAULT clause_plus
		{ /* FIXME */}
	;

clause_plus:
	clause clause_plus
		{ $$ = mk_cons($1, $2); }
	|
	clause
		{ $$ = mk_cons($1, mk_nil()); }
	;

clause:
	KW_RULE conjunctive_goal_opt DASHES rml_ident seq_pat result
		{ $$ = Absyn__RMLRULE($4, $5, $2, $6); }
	|
	KW_AXIOM rml_ident seq_pat result
		{ $$ = Absyn__RMLRULE($2, $3, mk_none(), $4); }
	;

result:
	/* empty */
                { 
		  $$ = Absyn__RMLNoResult; }
	|
	YIELDS seq_exp
		{ $$ = Absyn__RMLResultExp($2); }
	|
	YIELDS KW_FAIL
		{ $$ = Absyn__RMLResultFail; }
	;

conjunctive_goal_opt:
	/* empty */
		{ $$ = mk_none(); }
	|
	conjunctive_goal
		{ $$ = mk_some($1); }
	;

conjunctive_goal:
	atomic_goal AMPERSAND conjunctive_goal
                { $$ = Absyn__RMLGOAL_5fAND($1, $3); }
        |
	atomic_goal
		{ $$ = $1; }
	;

atomic_goal:
	longorshortid seq_exp res_pat
		{ $$ = Absyn__RMLGOAL_5fRELATION($1, $2, $3); }
	|
	rml_ident EQUALS rml_expression
		{ $$ = Absyn__RMLGOAL_5fEQUAL($1, $3); }
	|
	KW_LET pat EQUALS rml_expression
		{ $$ = Absyn__RMLGOAL_5fLET($2, $4); }
	|
	KW_NOT atomic_goal
		{ $$ = Absyn__RMLGOAL_5fNOT($2); }
	|
	LPAR conjunctive_goal RPAR
		{ $$ = $2; }
	;

/* RML Expressions */

rml_expression:
	rml_exp_a COLONCOLON rml_expression
		{ $$ = Absyn__RMLCONS($1, $3); }
	|
	rml_exp_a
		{ $$ = $1; }
	;

rml_expression_list:
	rml_expression COMMA rml_expression_list
		{ $$ = mk_cons($1, $3); }
|
	rml_expression
		{ $$ = mk_cons($1, mk_nil()); }
;

rml_exp_a:
	LPAR RPAR
		{ $$ = mk_nil(); }
	|
	LPAR rml_expression RPAR
		{ $$ = $2; }
	|
	LPAR rml_expression_list RPAR
		{ $$ = $2; }
	|
	rml_exp_c
		{ $$ = $1; }
	;

rml_exp_b:
	rml_exp_c COLONCOLON rml_exp_b
		{ $$ = Absyn__RMLCONS($1, $3); }
	|
	rml_exp_c
		{ $$ = $1; }
	;

rml_exp_c:
	longorshortid rml_exp_star
		{ $$ = Absyn__RMLCALL($1, $2); }
	|
	rml_addsub
		{ $$ = $1; }
	;

rml_addsub:
	rml_muldiv PLUS rml_addsub
		{ $$ = Absyn__BINARY($1, Absyn__ADD, $3); }
	|
	rml_muldiv MINUS rml_addsub
		{ $$ = Absyn__BINARY($1, Absyn__SUB, $3); }
	|
	rml_muldiv
		{ $$ = $1; }
	;

rml_muldiv:
	rml_unary STAR rml_muldiv
		{ $$ = Absyn__BINARY($1, Absyn__MUL, $3); }
	|
	rml_unary DIV rml_muldiv
		{ $$ = Absyn__BINARY($1, Absyn__DIV, $3); }
	|
	rml_unary 
		{ $$ = $1; }
	;

rml_unary:
	MINUS rml_unary
		{ $$ = Absyn__UNARY(Absyn__UMINUS, $2); }
	|
	rml_primary
		{ $$ = $1; }
	;

rml_primary:
	rml_literal
		{ $$ = Absyn__RMLLIT($1); }
	|
	longorshortid
		{ $$ = Absyn__RML_5fREFERENCE($1); }
	|
	LBRACK rml_exp_comma_star RBRACK
		{ $$ = Absyn__RMLLIST($2); }
	|
	LPAR rml_expression RPAR
		{ $$ = $2; }
	|
	LPAR RPAR
		{ $$ = Absyn__RMLNIL; }
	;

rml_exp_comma_star:
	/* empty */
		{ $$ = mk_nil(); }
	|
	rml_exp_comma_plus
		{ $$ = $1; }
	;

rml_exp_comma_plus:
	rml_expression COMMA rml_exp_comma_plus
		{ $$ = mk_cons($1, $3); }
|
	rml_expression
		{ $$ = mk_cons($1, mk_nil()); }
	;

rml_exp_star:
	LPAR rml_exp_comma_star RPAR
		{ $$ = $2; }
;

seq_exp:
	/* empty */
		{ $$ = mk_nil(); }
	|
	rml_exp_b
		{ $$ = mk_cons($1, mk_nil()); }
	|
	rml_exp_star
		{ $$ = $1; }
;

/* RML Patterns */

pat:
	rml_ident KW_AS pat
		{ $$ = Absyn__RMLPAT_5fAS($1, $3); }
	|
	pat_a
		{ $$ = $1; }
	;

pat_a:
	pat_b COLONCOLON pat_a
		{ $$ = Absyn__RMLPAT_5fCONS($1, $3); }
	|
	pat_b
		{ $$ = $1; }
	;

pat_b:
	LPAR RPAR
		{ $$ = Absyn__RMLPAT_5fNIL; }
	|
	LPAR pat RPAR
		{ $$ = $2; }
	|
	LPAR pat COMMA pat_comma_plus RPAR
		{ $$ = Absyn__RMLPAT_5fSTRUCT(mk_none(),mk_cons($2, $4)); }
	|
	pat_d
		{ $$ = $1; }
	;

pat_c:
	pat_d COLONCOLON pat_c
		{ $$ = Absyn__RMLPAT_5fCONS($1, $3); }
	|
	pat_d
		{ $$ = $1; }
	;

pat_d:
	longorshortid pat_star
		{ $$ = Absyn__RMLPAT_5fSTRUCT(mk_some($1), $2); }
	|
	longorshortid pat_e
		{ $$ = Absyn__RMLPAT_5fSTRUCT(mk_some($1), $2); }
	|
	pat_e
		{ $$ = $1; }
	;

pat_e:
	UNDERSCORE
		{ $$ = Absyn__RMLPAT_5fWILDCARD; }
	|
	rml_literal
		{ $$ = Absyn__RMLPAT_5fLITERAL($1); }
	|
	longid
		{ $$ = Absyn__RMLPAT_5fIDENT($1); }
	|
	rml_ident
		{ $$ = Absyn__RMLPAT_5fIDENT($1); }
	|
	LBRACK pat_comma_star RBRACK
		{ $$ = Absyn__RMLPAT_5fLIST($2); }
	;

res_pat: 
	/* empty */
		{ $$ = mk_none(); }
	|
	YIELDS seq_pat
		{ $$ = mk_some($2); }
	;

seq_pat:
	/* empty */
		{ $$ = mk_nil(); }
	|
	pat_c
		{ $$ = $1; }
	|
	pat_star                
                { $$ = Absyn__RMLPAT_5fSTRUCT(mk_none(),$1); } 
                //changed..
	;

pat_star:
	LPAR pat_comma_star RPAR
		{ $$ = $2; }
	;

pat_comma_star:
	/* empty */
		{ $$ = mk_nil(); }
	|
	pat_comma_plus
		{ $$ = $1; }
	;

pat_comma_plus:
	pat COMMA pat_comma_plus
		{ $$ = mk_cons($1, $3); }
	|
	pat
		{ $$ = mk_cons($1, mk_nil()); }
	;

/* RML Literals */

rml_literal:
	CCON
		{ $$ = Absyn__RMLLIT_5fCHAR(mk_icon(((struct Token*)$1)->u.number)); }
	|
	ICON
		{ 
		  $$ = Absyn__RMLLIT_5fINTEGER(mk_icon(((struct Token*)$1)->u.number));
                  }
	|
	RCON
		{ 
		  $$ = Absyn__RMLLIT_5fREAL(mk_rcon(((struct Token*)$1)->u.realnumber));
		}
	|
	SCON
		{ $$ = Absyn__RMLLIT_5fSTRING(mk_scon(((struct Token*)$1)->u.string)); }
	;

/* RML Types */

ty:
	seq_ty YIELDS seq_ty
                { $$ = Absyn__RMLTYPE_5fSIGNATURE(
		       Absyn__CALLSIGN($1, $3)); }
        // $$ = Absyn__CALLSIGN($1, $3); }
	|
	tuple_ty
		{ $$ = Absyn__RMLTYPE_5fTUPLE($1); }
	;

tuple_ty:
	ty_sans_star STAR tuple_ty
		{ $$ = mk_cons($1, $3); }
	|
	ty_sans_star
		{ $$ = mk_cons($1, mk_nil()); }
	;

ty_sans_star:

	ty_sans_star longorshortid
	               { $$ = Absyn__RMLTYPE_5fTYCONS(mk_cons($1,mk_nil()),$2) }
	|
/*	LPAR ty_comma_seq2 RPAR longorshortid
	|
*/
	LPAR ty RPAR
		{ $$ = $2; }
	|
	tyvar
		{ $$ = Absyn__RMLTYPE_5fTYVAR($1); }
	|
	longorshortid
		{ $$ = Absyn__RMLTYPE_5fUSERDEFINED($1); }
	;

ty_comma_seq2:
	ty COMMA ty_comma_seq2
		{ $$ = mk_cons($1, $3); }
	|
	ty COMMA ty
		{ $$ = mk_cons($1, mk_cons($3, mk_nil())); }
	;

seq_ty:
	LPAR RPAR
		{ $$ = mk_nil(); }
	|
	LPAR ty_comma_seq2 RPAR
		{ $$ = $2; }
	|
	tuple_ty //changed, could effect others...
		{ $$ = $1; }
	;

tyvarseq1:
	tyvar COMMA tyvarseq1
		{ $$ = mk_cons($1, $3); }
	|
	tyvar
		{ $$ = mk_cons($1, mk_nil()); }
	;

tyvarparseq:
	LPAR tyvarseq1 RPAR
		{ $$ = $2; }
	;

tyvarseq:
	/* empty */
		{ $$ = mk_nil(); }
	|
	tyvar
		{ $$ = $1; }
	|
	tyvarparseq
		{ $$ = $1; }
	;

/* RML Identifiers */

longid:
	ident DOT ident
		{ $$ = Absyn__RMLLONGID(mkIDENT($1), mkIDENT($3)); }
	;

longorshortid:
	longid
		{ $$ = $1; }
	| rml_ident
          { $$ = $1;
          }
	;

ident:
	IDENT
	{ 
	  $$ = $1;
	}
	;

rml_ident:
	ident
         {
	    $$ = Absyn__RMLSHORTID(mkIDENT($1),
		  Absyn__INFO(
                    mk_scon(((struct Token*)$1)->file),
		    mk_icon(((struct Token*)$1)->firstline),
		    mk_icon(((struct Token*)$1)->firstcol),
		    mk_icon(((struct Token*)$1)->lastline),
		    mk_icon(((struct Token*)$1)->lastcol))); 
         }
         ;
tyvar:
	TYVARIDENT
	{
	  $$ = Absyn__RMLSHORTID(mk_scon(((struct Token*)$1)->u.string),
		  Absyn__INFO(
                    mk_scon(((struct Token*)$1)->file),
		    mk_icon(((struct Token*)$1)->firstline),
		    mk_icon(((struct Token*)$1)->firstcol),
		    mk_icon(((struct Token*)$1)->lastline),
		    mk_icon(((struct Token*)$1)->lastcol))); 
	    /* $$ = mk_scon(((struct Token*)$1)->u.string); */
        }
	;

empty:	;


%%

#define PCOMMENTBUF 2000
static int yylineno;
static char parserCommentBuffer[PCOMMENTBUF+10];
static char yaccCommentBuffer[PCOMMENTBUF+10];
extern rml_t *absyntree;

#define MAXPOSINDEX   50
static int posIndex  = 0;
static int posLineNo[MAXPOSINDEX+1];

void positionPush()
{
    if (++posIndex > 50)
	yyerror("Internal error: positionPush(): overflow.\n");
    posLineNo[posIndex] = yylineno;
}

void positionPop()
{
    if (--posIndex < 0)
	yyerror("Internal error: positionPop(): underflow.\n");
}

int positionLineNo()
{
    return posLineNo[posIndex];
}

char *positionFileName()
{
    return "NoFile";
}

void *parser_make_element(int   is_final,
			  void *innerouter,
			  int   is_replaceable,
			  void *classdef,
			  void *componentclause,
			  void *constraint,
			  void *comment)
{
    void *final       = is_final ? RML_TRUE : RML_FALSE;
    void *replaceable = is_replaceable ? RML_TRUE : RML_FALSE;

    if (componentclause)
    {
	/* Declaration. */
	return Absyn__ELEMENT(final,
			      replaceable,
			      is_replaceable ? Absyn__UNSPECIFIED : innerouter,
			      mk_scon((is_replaceable ? "replaceable component"
                                                     : "component")),
			      componentclause,
			      mk_scon(positionFileName()),
			      mk_scon(positionLineNo()),
			      constraint ? mk_some(constraint) : mk_none());
    }
    else if (classdef)
    {
	/* Definition. */
	return Absyn__ELEMENT(final,
			      replaceable,
			      is_replaceable ? Absyn__UNSPECIFIED : innerouter,
			      mk_scon((is_replaceable ? "?replaceable classdef?"
                                                     : "?classdef?")),
			      Absyn__CLASSDEF(replaceable, classdef),
			      mk_scon(positionFileName()),
			      mk_scon(positionLineNo()),
			      constraint ? mk_some(constraint) : mk_none());

    }
    else
	yyerror("Internal error in parser_make_element().\n");
}

void **tempQuadMake(void *v1, void *v2, void *v3, void *v4)
{
    void **quad = malloc(sizeof(void *)*4);
    if (!quad)
	yyerror("Out of memory.");
    quad[0] = v1;
    quad[1] = v2;
    quad[2] = v3;
    quad[3] = v4;
    return quad;
}

void *tempQuadGet(void **quad, int element)
{
    if (!quad || element < 0 || element > 3)
	yyerror("Internal error: tempQuadGet(): bad arguments.");
    return quad[element];
}

void tempQuadFree(void **quad)
{
    if (quad)
	free(quad);
}

