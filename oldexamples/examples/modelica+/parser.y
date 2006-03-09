%{
#include <stdio.h>
#include "yacclib.h"
#include "rml.h"
#include "eval.h"

#define YYSTYPE rml_t

typedef void *rml_t;
extern rml_t absyntree;

%}

%token T_REALCONST
%token T_LPAREN T_RPAREN
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_GARBAGE

%token T_ERR

%%

/* Yacc BNF Syntax of the expression language Eval */

program
                 :  expression
                    { absyntree = $1; }

expression       :  term
                 |  expression  T_ADD  term
                    { $$ = mk_box2(Eval__PLUS_3dBOX2,$1,$3);}
                 |  expression  T_SUB  term
                    { $$ = mk_box2(Eval__SUB_3dBOX2,$1,$3);}
                 
term             :  u_element
                 |  term  T_MUL  u_element
                    { $$ = mk_box2(Eval__MUL_3dBOX2,$1,$3);}
                 |  term  T_DIV  u_element
                    { $$ = mk_box2(Eval__DIV_3dBOX2,$1,$3);}

u_element        :  element
                 |  T_SUB  element
                    { $$ = mk_box1(Eval__NEG_3dBOX1,$2);}

element          :  T_REALCONST
                 |  T_LPAREN  expression  T_RPAREN
                    { $$ = $2;}




