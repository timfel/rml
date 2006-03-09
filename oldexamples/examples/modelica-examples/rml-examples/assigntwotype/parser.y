%{
#include <stdio.h>
#include "yacclib.h"
#include "rml.h"
#include "assigntwotype.h"

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

program         :  assignments T_SEMIC expression
                        { absyntree = assigntwotype__PROGRAM($1, $3);}

assignments     :  assignments  assignment
                        { $$ = mk_cons($2, $1);}
                |
                        { $$ = mk_nil();}

assignment      :  T_IDENT  T_ASSIGN  expression
                        { $$ = assigntwotype__ASSIGN($1, $3);}

expression      :  term
                        { $$ = $1;}
                |  expression  weak_operator  term
                        { $$ = assigntwotype__BINARY($1, $2, $3);}

term            :  u_element
                        { $$ = $1;}
                |  term  strong_operator  u_element
                        { $$ = assigntwotype__BINARY($1, $2, $3);}

u_element       :  element
                        { $$ = $1;}
                |  unary_operator  element
                        { $$ = assigntwotype__UNARY($1, $2);}

element         :  T_INTCONST
                        { $$ = assigntwotype__INT($1);}
                |  T_REALCONST
                        { $$ = $1;}
                |  T_IDENT
                        { $$ = assigntwotype__IDENT($1);}
                |  T_LPAREN  expression  T_RPAREN
                        { $$ = $2;}
                |  T_LPAREN  assignment  T_RPAREN
                        { $$ = $2;}

weak_operator   :  T_ADD
                        { $$ = assigntwotype__ADD;}
                |  T_SUB
                        { $$ = assigntwotype__SUB;}

strong_operator :  T_MUL
                        { $$ = assigntwotype__MUL;}
                |  T_DIV
                        { $$ = assigntwotype__DIV;}

unary_operator  :  T_SUB
                        { $$ = assigntwotype__NEG;}


