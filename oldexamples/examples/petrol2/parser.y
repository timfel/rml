/* parser.y */

%{
#include <stdarg.h>
#include <stdio.h>
#include "yacclib.h"
#include "parsutil.h"
#include "lexer.h"
static void yyerror(const char*);
%}

%union {
    void        *voidp;
    enum uop    uop;
    enum bop    bop;
    enum rop    rop;
    enum eop    eop;
}

/* terminals */
%token T_AMPER         /*    &           */
%token T_AND           /*    and         */
%token T_ARRAY         /*    array       */
%token T_ASSIGN        /*    :=          */
%token T_BEGIN         /*    begin       */
%token T_CARET         /*    ^           */
%token T_CAST          /*    cast        */
%token T_COLON         /*    :           */
%token T_COMMA         /*    ,           */
%token T_CONST         /*    const       */
%token T_DO            /*    do          */
%token T_DOT           /*    .           */
%token T_ELSE          /*    else        */
%token T_ELSIF         /*    elseif      */
%token T_END           /*    end         */
%token T_EQ            /*    =           */
%token T_EXTERN        /*    extern      */
%token T_FUNCTION      /*    function    */
%token T_GE            /*    >=          */
%token T_GT            /*    >           */
%token <voidp> T_ICON  /* <int constant> */
%token <voidp> T_IDENT /* <identifier>   */
%token T_IDIV          /*    div         */
%token T_IF            /*    if          */
%token T_IMOD          /*    mod         */
%token T_LBRACK        /*    [           */
%token T_LE            /*    <=          */
%token T_LPAREN        /*    (           */
%token T_LT            /*    <           */
%token T_MINUS         /*    -           */
%token T_MUL           /*    *           */
%token T_NE            /*    <>          */
%token T_NOT           /*    not         */
%token T_OF            /*    of          */
%token T_OR            /*    or          */
%token T_PLUS          /*    +           */
%token T_PROCEDURE     /*    procedure   */
%token T_PROGRAM       /*    program     */
%token T_RBRACK        /*    ]           */
%token <voidp> T_RCON  /* <real constant>*/
%token T_RDIV          /*    /           */
%token T_RECORD        /*    record      */
%token T_RETURN        /*    return      */
%token T_RPAREN        /*    )           */
%token T_SEMI          /*    ;           */
%token T_THEN          /*    then        */
%token T_TYPE          /*    type        */
%token T_VAR           /*    var         */
%token T_WHILE         /*    while       */

/* non-terminals */
%type <voidp> block body
%type <voidp> const_part const_decls const_decl constant
%type <voidp> type_part type_decls type_decl type
%type <voidp> var_part var_decls var_decl
%type <voidp> sub_part sub_decls sub_decl opt_param_list param_list param
%type <voidp> comp_stmt stmt_list stmt elsif_part else_part
%type <voidp> opt_exp_list exp_list exp eq_exp rel_exp add_exp
%type <voidp> mul_exp unary_exp postfix_exp primary_exp
%type <uop> unary_op
%type <bop> mul_op add_op
%type <rop> rel_op
%type <eop> eq_op

/* start symbol */
%start program

%%

program         : T_PROGRAM T_IDENT T_SEMI block T_DOT
                        { yylval.voidp = pu_PROG($2, $4); YYACCEPT; }

block           : const_part type_part var_part sub_part comp_stmt
                        { $$ = pu_BLOCK($1, $2, $3, $4, $5); }

body            : T_EXTERN
                        { $$ = mk_none(); }
                | block
                        { $$ = mk_some($1); }

/*
 * CONSTANTS
 */

const_part      : T_CONST const_decls
                        { $$ = $2; }
                | /*empty*/
                        { $$ = mk_nil(); }

const_decls     : const_decl
                        { $$ = mk_cons($1, mk_nil()); }
                | const_decl const_decls
                        { $$ = mk_cons($1, $2); }

const_decl      : T_IDENT T_EQ constant T_SEMI
                        { $$ = pu_CONBND($1, $3); }

constant        : T_ICON
                        { $$ = pu_Constant_INTcon($1); }
                | T_RCON
                        { $$ = pu_Constant_REALcon($1); }
                | T_IDENT
                        { $$ = pu_Constant_IDENTcon($1); }

/*
 * TYPES
 */

type_part       : T_TYPE type_decls
                        { $$ = $2; }
                | /*empty*/
                        { $$ = mk_nil(); }

type_decls      : type_decl
                        { $$ = mk_cons($1, mk_nil()); }
                | type_decl type_decls
                        { $$ = mk_cons($1, $2); }

type_decl       : T_IDENT T_EQ type T_SEMI
                        { $$ = pu_TYBND($1, $3); }

type            : T_IDENT
                        { $$ = pu_Ty_NAME($1); }
                | T_CARET type
                        { $$ = pu_Ty_PTR($2); }
                | T_ARRAY T_LBRACK constant T_RBRACK T_OF type
                        { $$ = pu_Ty_ARR($3, $6); }
                | T_RECORD var_decls T_END
                        { $$ = pu_Ty_REC($2); }

/*
 * VARIABLES
 */

var_part        : T_VAR var_decls
                        { $$ = $2; }
                | /*empty*/
                        { $$ = mk_nil(); }

var_decls       : var_decl
                        { $$ = mk_cons($1, mk_nil()); }
                | var_decl var_decls
                        { $$ = mk_cons($1, $2); }

var_decl        : T_IDENT T_COLON type T_SEMI
                        { $$ = pu_VARBND($1, $3); }

/*
 * SUB-PROGRAMS
 */

sub_part        : sub_decls
                | /*empty*/
                        { $$ = mk_nil(); }

sub_decls       : sub_decl
                        { $$ = mk_cons($1, mk_nil()); }
                | sub_decl sub_decls
                        { $$ = mk_cons($1, $2); }

sub_decl        : T_PROCEDURE T_IDENT opt_param_list T_SEMI body T_SEMI
                        { $$ = pu_SubBnd_PROCBND($2, $3, $5); }
                | T_FUNCTION T_IDENT opt_param_list T_COLON type T_SEMI body T_SEMI
                        { $$ = pu_SubBnd_FUNCBND($2, $3, $5, $7); }

opt_param_list  : T_LPAREN param_list T_RPAREN
                        { $$ = $2; }
                | T_LPAREN T_RPAREN
                        { $$ = mk_nil(); }
                | /*empty*/
                        { $$ = mk_nil(); }

param_list      : param
                        { $$ = mk_cons($1, mk_nil()); }
                | param T_SEMI param_list
                        { $$ = mk_cons($1, $3); }

param           : T_IDENT T_COLON type
                        { $$ = pu_VARBND($1, $3); }

/*
 * STATEMENTS
 */

comp_stmt       : T_BEGIN stmt_list T_END
                        { $$ = $2; }

stmt_list       : stmt
                | stmt T_SEMI stmt_list
                        { $$ = pu_Stmt_SEQ($1, $3); }

stmt            : T_IF exp T_THEN stmt_list elsif_part
                        { $$ = pu_Stmt_IF($2, $4, $5); }
                | T_WHILE exp T_DO stmt_list T_END
                        { $$ = pu_Stmt_WHILE($2, $4); }
                | T_IDENT T_LPAREN opt_exp_list T_RPAREN
                        { $$ = pu_Stmt_PCALL($1, $3); }
                | unary_exp T_ASSIGN exp
                        { $$ = pu_Stmt_ASSIGN($1, $3); }
                | T_RETURN exp
                        { $$ = pu_Stmt_FRETURN($2); }
                | T_RETURN
                        { $$ = pu_Stmt_PRETURN(); }
                | /*empty*/
                        { $$ = pu_Stmt_SKIP(); }

elsif_part      : T_ELSIF exp T_THEN stmt_list elsif_part
                        { $$ = pu_Stmt_IF($2, $4, $5); }
                | else_part

else_part       : T_ELSE stmt_list T_END
                        { $$ = $2; }
                | T_END
                        { $$ = pu_Stmt_SKIP(); }

/*
 * EXPRESSIONS
 */

opt_exp_list    : exp_list
                | /*empty*/
                        { $$ = mk_nil(); }

exp_list        : exp
                        { $$ = mk_cons($1, mk_nil()); }
                | exp T_COMMA exp_list
                        { $$ = mk_cons($1, $3); }

exp             : eq_exp

eq_exp          : rel_exp
                | eq_exp eq_op rel_exp
                        { $$ = pu_Exp_EQUALITY($1, $2, $3); }

eq_op           : T_EQ
                        { $$ = EOP_EQ; }
                | T_NE
                        { $$ = EOP_NE; }

rel_exp         : add_exp
                | rel_exp rel_op add_exp
                        { $$ = pu_Exp_RELATION($1, $2, $3); }

rel_op          : T_LT
                        { $$ = ROP_LT; }
                | T_LE
                        { $$ = ROP_LE; }
                | T_GE
                        { $$ = ROP_GE; }
                | T_GT
                        { $$ = ROP_GT; }
add_exp         : mul_exp
                | add_exp add_op mul_exp
                        { $$ = pu_Exp_BINARY($1, $2, $3); }

add_op          : T_OR
                        { $$ = BOP_IOR; }
                | T_PLUS
                        { $$ = BOP_ADD; }
                | T_MINUS
                        { $$ = BOP_SUB; }

mul_exp         : unary_exp
                | mul_exp mul_op unary_exp
                        { $$ = pu_Exp_BINARY($1, $2, $3); }

mul_op          : T_AND
                        { $$ = BOP_IAND; }
                | T_MUL
                        { $$ = BOP_MUL; }
                | T_RDIV
                        { $$ = BOP_RDIV; }
                | T_IDIV
                        { $$ = BOP_IDIV; }
                | T_IMOD
                        { $$ = BOP_IMOD; }

unary_exp       : postfix_exp
                | unary_op unary_exp
                        { $$ = pu_Exp_UNARY($1, $2); }

unary_op        : T_AMPER
                        { $$ = UOP_ADDR; }
                | T_NOT
                        { $$ = UOP_NOT; }
                | T_PLUS
                        { $$ = UOP_PLUS; }
                | T_MINUS
                        { $$ = UOP_MINUS; }

postfix_exp     : primary_exp
                | postfix_exp T_CARET
                        { $$ = pu_Exp_UNARY(UOP_INDIR, $1); }
                | postfix_exp T_DOT T_IDENT
                        { $$ = pu_Exp_FIELD($1, $3); }
                | postfix_exp T_LBRACK exp T_RBRACK
                        { $$ = pu_Exp_UNARY(UOP_INDIR,
                                            pu_Exp_BINARY($1, BOP_ADD, $3)); }
                | T_IDENT T_LPAREN opt_exp_list T_RPAREN
                        { $$ = pu_Exp_FCALL($1, $3); }
                | T_CAST T_LPAREN type T_COMMA exp T_RPAREN
                        { $$ = pu_Exp_CAST($3, $5); }

primary_exp     : T_IDENT
                        { $$ = pu_Exp_IDENT($1); }
                | T_ICON
                        { $$ = pu_Exp_INT($1); }
                | T_RCON
                        { $$ = pu_Exp_REAL($1); }
                | T_LPAREN exp T_RPAREN
                        { $$ = $2; }
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
