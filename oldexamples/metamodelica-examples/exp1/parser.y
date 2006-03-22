%{
#include <stdio.h>
#include "yacclib.h"
#include "rml.h"
#include "exp1.h"

#define YYSTYPE rml_t

typedef void *rml_t;
extern rml_t absyntree;

%}

%token T_INTCONST
%token T_LPAREN T_RPAREN
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_GARBAGE

%token T_ERR

%%

/* Yacc BNF Syntax of the expression language Exp1 */

program
                 :  expression
                    { absyntree = $1; }

expression       :  term
                 |  expression  T_ADD  term
                    { $$ = mk_box2(exp1__ADDop_3dBOX2,$1,$3);}
                 |  expression  T_SUB  term
                    { $$ = mk_box2(exp1__SUBop_3dBOX2,$1,$3);}
                 
term             :  u_element
                 |  term  T_MUL  u_element
                    { $$ = mk_box2(exp1__MULop_3dBOX2,$1,$3);}
                 |  term  T_DIV  u_element
                    { $$ = mk_box2(exp1__DIVop_3dBOX2,$1,$3);}

u_element        :  element
                 |  T_SUB  element
                    { $$ = mk_box1(exp1__NEGop_3dBOX1,$2);}

element          :  T_INTCONST
                 |  T_LPAREN  expression  T_RPAREN
                    { $$ = $2;}




