%{
#include <stdio.h>
#include "yacclib.h"
#include "rml.h"
#include "absyn.h"

typedef void *rml_t;
#define YYSTYPE rml_t
extern rml_t absyntree;

%}

%token T_SEMIC
%token T_ASSIGN
%token T_IDENT
%token T_INTCONST
%token T_REALCONST
%token T_LPAREN T_RPAREN
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_GARBAGE

%token T_ERR

%%

/* Yacc BNF grammar of the expression language Assigntwotypes */

program         :  assignment
                        { absyntree = $1; }
                |  expression
                        { absyntree = $1; }

assignment      :  T_IDENT  T_ASSIGN  expression
                        { $$ = Absyn__ASSIGN($1, $3); }

expression      :  term
                        { $$ = $1;  }
                |  expression  weak_operator  term
                        { $$ = Absyn__BINARY($1, $2, $3);}

term            :  u_element
                        { $$ = $1;}
                |  term  strong_operator  u_element
                        { $$ = Absyn__BINARY($1, $2, $3);}

u_element       :  element
                        { $$ = $1;}
                |  unary_operator  element
                        { $$ = Absyn__UNARY($1, $2);}

element         :  T_INTCONST
                        { $$ = Absyn__INT($1);}
                |  T_REALCONST
                        { $$ = Absyn__REAL($1);}
                |  T_IDENT
                        { $$ = Absyn__IDENT($1);}
                |  T_LPAREN  expression  T_RPAREN
                        { $$ = $2;}
                |  T_LPAREN  assignment  T_RPAREN
                        { $$ = $2;}

weak_operator   :  T_ADD
                        { $$ = Absyn__ADD;}
                |  T_SUB
                        { $$ = Absyn__SUB;}

strong_operator :  T_MUL
                        { $$ = Absyn__MUL;}
                |  T_DIV
                        { $$ = Absyn__DIV;}

unary_operator  :  T_SUB
                        { $$ = Absyn__NEG;}


%%

void yyerror(char *str)
{
  /* printf("\nerror!:%s\n", str); */
}
