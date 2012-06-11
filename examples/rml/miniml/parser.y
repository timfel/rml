/* parser.y */

%{
#include <stdarg.h>
#include <stdio.h>
#include "rml.h"
#include "parsutil.h"
#include "lexer.h"
static void yyerror(const char*);
%}

%union {
    void	*voidp;
    enum bop	bop;
}

/* terminals */
%token T_COLONCOLON
%token T_COLONEQ
%token T_COMMA
%token T_DASH
%token T_ELSE
%token T_END
%token T_EQ
%token T_FATARROW
%token T_FN
%token T_FUN
%token <voidp> T_ICON
%token <voidp> T_IDENT
%token T_IDIV
%token T_IF
%token T_IMOD
%token T_IN
%token T_LE
%token T_LET
%token T_LBRACK
%token T_LPAREN
%token T_LT
%token T_OP
%token T_PLUS
%token T_RBRACK
%token <voidp> T_RCON
%token T_RDIV
%token T_RPAREN
%token <voidp> T_SCON
%token T_SEMI
%token T_STAR
%token T_THEN
%token T_VAL

/* non-terminals */
%type <voidp> program alldecs
%type <voidp> topdec
%type <voidp> exp lam_exp if_exp infl3exp infl4exp infr5exp infl6exp
%type <voidp> infl7exp app_exp at_exp exp_plus
%type <voidp> fun
%type <bop> infl4op infl6op infl7op operator

/* start symbol */
%start program

%%

program	: alldecs			{ yylval.voidp = $1; YYACCEPT; }

alldecs	: /*empty*/			{ $$ = mk_nil(); }
	| topdec opt_semi alldecs	{ $$ = mk_cons($1, $3); }

opt_semi: T_SEMI
	| /*empty*/

topdec	: T_VAL T_IDENT T_EQ exp
		{ $$ = pu_dec_val($2, $4); }
	| T_FUN T_IDENT fun
		{ $$ = pu_dec_val($2, pu_exp_letrec($2, $3, pu_exp_var($2))); }

exp	: lam_exp

lam_exp	: if_exp
	| T_FN T_IDENT T_FATARROW exp
		{ $$ = pu_exp_lam(pu_lambda($2, $4)); }

if_exp	: infl3exp
	| T_IF exp T_THEN exp T_ELSE exp
		{ $$ = pu_exp_if($2, $4, $6); }

infl3exp: infl4exp
	| infl3exp T_COLONEQ infl4exp
		{ $$ = pu_exp_app(pu_bop_var(BOP_SET), pu_exp_pair($1, $3)); }

infl4exp: infr5exp
	| infl4exp infl4op infr5exp
		{ $$ = pu_exp_app(pu_bop_var($2), pu_exp_pair($1, $3)); }

infl4op	: T_EQ			{ $$ = BOP_EQ; }
	| T_LE			{ $$ = BOP_LE; }
	| T_LT			{ $$ = BOP_LT; }

infr5exp: infl6exp
	| infr5exp T_COLONCOLON infl6exp
		{ $$ = pu_exp_app(pu_bop_var(BOP_CONS), pu_exp_pair($1, $3)); }

infl6exp: infl7exp
	| infl6exp infl6op infl7exp
		{ $$ = pu_exp_app(pu_bop_var($2), pu_exp_pair($1, $3)); }

infl6op	: T_DASH		{ $$ = BOP_SUB; }
	| T_PLUS		{ $$ = BOP_ADD; }

infl7exp: app_exp
	| infl7exp infl7op app_exp
		{ $$ = pu_exp_app(pu_bop_var($2), pu_exp_pair($1, $3)); }

infl7op	: T_IDIV		{ $$ = BOP_IDIV; }
	| T_IMOD		{ $$ = BOP_IMOD; }
	| T_RDIV		{ $$ = BOP_RDIV; }
	| T_STAR		{ $$ = BOP_MUL; }

app_exp	: at_exp
	| app_exp at_exp	{ $$ = pu_exp_app($1, $2); }

at_exp	: T_ICON		{ $$ = pu_exp_icon($1); }
	| T_RCON		{ $$ = pu_exp_rcon($1); }
	| T_SCON		{ $$ = pu_exp_scon($1); }
	| T_IDENT		{ $$ = pu_exp_var($1); }
	| T_LPAREN T_RPAREN	{ $$ = pu_exp_unit(); }
	| T_LPAREN exp T_RPAREN	{ $$ = $2; }
	| T_LPAREN exp T_COMMA exp T_RPAREN	{ $$ = pu_exp_pair($2, $4); }
	| T_LPAREN exp T_SEMI exp T_RPAREN
		{ $$ = pu_exp_let(mk_scon("_"), $2, $4); }
	| T_LET T_VAL T_IDENT T_EQ exp T_IN exp T_END
		{ $$ = pu_exp_let($3, $5, $7); }
	| T_LET T_FUN T_IDENT fun T_IN exp T_END
		{ $$ = pu_exp_letrec($3, $4, $6); }
	| T_LBRACK T_RBRACK	{ $$ = pu_exp_nil(); }
	| T_LBRACK exp_plus	{ $$ = $2; }
	| T_OP operator		{ $$ = pu_bop_var($2); }
	| T_OP T_IDENT		{ $$ = pu_exp_var($2); }

operator: T_COLONEQ		{ $$ = BOP_SET; }
	| T_COLONCOLON		{ $$ = BOP_CONS; }
	| infl4op
	| infl6op
	| infl7op

exp_plus: exp T_RBRACK
		{ $$ = pu_exp_app(pu_bop_var(BOP_CONS),
				  pu_exp_pair($1, pu_exp_nil())); }
	| exp T_COMMA exp_plus
		{ $$ = pu_exp_app(pu_bop_var(BOP_CONS), pu_exp_pair($1, $3)); }

fun	: T_IDENT T_EQ exp	{ $$ = pu_lambda($1, $3); }
	| T_IDENT fun		{ $$ = pu_lambda($1, pu_exp_lam($2)); }
%%

#if	YYDEBUG
extern int yydebug;
#endif

static void yyerror(const char *msg)
{
#if	YYDEBUG
    if( yydebug )
	lexerror("%s at token %s\n", msg, lex_token_to_string(yychar));
    else
#endif
	lexerror("%s\n", msg);
}

static void yyprintf(const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);
}
#define printf yyprintf
