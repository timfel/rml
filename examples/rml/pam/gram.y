%{
#include <stdio.h>
#include "rml.h"
#include "pam.h"

#define YYSTYPE void*
extern void* absyntree;

%}

%token T_READ
%token T_WRITE
%token T_ASSIGN
%token T_IF
%token T_THEN
%token T_ENDIF
%token T_ELSE
%token T_TO
%token T_DO
%token T_END
%token T_WHILE
%token T_LPAREN
%token T_RPAREN
%token T_IDENT
%token T_INTCONST
%token T_EQ
%token T_LE
%token T_LT
%token T_GT
%token T_GE
%token T_NE
%token T_ADD
%token T_SUB
%token T_MUL
%token T_DIV
%token T_SEMIC
%token T_COMMENT

%%

/* Yacc BNF grammar of the PAM language */

program               :  series
                                { absyntree = $1; }
series                :  statement
                                { $$ = Pam__SEQ($1, Pam__SKIP); }
                      |  statement series
                                { $$ = Pam__SEQ($1, $2); }

statement             :  input_statement T_SEMIC
                                { $$ = $1; }
                      |  output_statement T_SEMIC
                                { $$ = $1; }
                      |  assignment_statement T_SEMIC
                                { $$ = $1; }
                      |  conditional_statement
                                { $$ = $1; }
                      |  definite_loop
                                { $$ = $1; }
                      |  while_loop
                                { $$ = $1; }

input_statement       :  T_READ  variable_list
                                { $$ = Pam__READ($2); }

output_statement      :  T_WRITE  variable_list
                                { $$ = Pam__WRITE($2); }

variable_list         :  variable
                                { $$ = mk_cons($1, mk_nil()); }
                      |  variable variable_list
                                { $$ = mk_cons($1, $2); }

assignment_statement  :  variable  T_ASSIGN  expression
                                { $$ = Pam__ASSIGN($1, $3); }

conditional_statement :  T_IF comparison T_THEN series T_ENDIF
                                { $$ = Pam__IF($2, $4, Pam__SKIP); }
                      |  T_IF comparison T_THEN series 
                                         T_ELSE series T_ENDIF
                                { $$ = Pam__IF($2, $4, $6); }

definite_loop         :  T_TO expression T_DO series T_END
                                { $$ = Pam__TODO($2, $4); }

while_loop            :  T_WHILE comparison T_DO series T_END
                                { $$ = Pam__WHILE($2, $4); }

expression       :  term
                                { $$ = $1; }
                 |  expression  weak_operator  term
                                { $$ = Pam__BINARY($1, $2, $3); }

term             :  element
                                { $$ = $1; }
                 |  term  strong_operator  element
                                { $$ = Pam__BINARY($1, $2, $3); }

element          :  constant
                                { $$ = $1; }
                 |  variable
                                { $$ = Pam__IDENT($1); }
                 |  T_LPAREN  expression  T_RPAREN
                                { $$ = $2; }

comparison       :  expression  relation  expression
                                { $$ = Pam__RELATION($1, $2, $3); }

variable         :  T_IDENT
                                { $$ = $1; }
constant         :  T_INTCONST
                                { $$ = $1; }

relation         : T_EQ { $$ = Pam__EQ;}
                 | T_LE { $$ = Pam__LE;}
                 | T_LT { $$ = Pam__LT;}
                 | T_GT { $$ = Pam__GT;}
                 | T_GE { $$ = Pam__GE;}
                 | T_NE { $$ = Pam__NE;}

weak_operator    : T_ADD { $$ = Pam__ADD;}
                 | T_SUB { $$ = Pam__SUB;}

strong_operator  : T_MUL { $$ = Pam__MUL;}
                 | T_DIV { $$ = Pam__DIV;}

%%

void yyerror(char *str) {
        extern int linenr;
        printf("%s on line %d!\n", str, linenr);
}

