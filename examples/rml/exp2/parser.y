%{
#include <stdio.h>
#include "rml.h"
#include "exp2.h"

#define YYSTYPE void*
extern void* absyntree;

%}

%token T_INTCONST
%token T_LPAREN T_RPAREN
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_GARBAGE
%token T_FAK

%token T_ERR

%%

/* Yacc BNF Syntax of the expression language Exp2 */

program
                 :  expression
                    { absyntree = $1; }

expression       :  term
                 |  expression  T_ADD  term
                    { $$ = exp2__BINARY($1, exp2__ADD, $3);}
                 |  expression  T_SUB  term
                    { $$ = exp2__BINARY($1, exp2__SUB, $3);}
                 
term             :  u_element
                 |  term  T_MUL  u_element
                    { $$ = exp2__BINARY($1, exp2__MUL, $3);}
                 |  term  T_DIV  u_element
                    { $$ = exp2__BINARY($1, exp2__DIV, $3);}

u_element        :  element
                 |  T_SUB  element
                    { $$ = exp2__UNARY(exp2__NEG, $2);}

element          :  T_INTCONST
                 |  T_LPAREN  expression  T_RPAREN
                    { $$ = $2;}




