%{
#include <stdio.h>
#include "yacclib.h"
#include "rml.h"
#include "reducer.h"

#define YYDEBUG 1

typedef void* rml_t;
#define YYSTYPE rml_t
extern rml_t absyntree;
%}



%token T_TRUE
%token T_FALSE
%token T_ZERO
%token T_VAR

%token T_SUCC
%token T_PRED
%token T_ISZERO

%token T_EQ
%token T_NL
%token T_SEP

%token T_LAMBDA
%token T_DOT
%token T_HUNGRY_DOT

%token T_IF
%token T_THEN
%token T_ELSE

%token T_LEFT
%token T_RIGHT

%token T_ERR


%%



program          :  top_seq
                    { absyntree = $1; }

top_seq          :  term T_NL
                    { $$ = $1; }
                 |  definition T_NL top_seq
                    { $$ = reducer__SEQ($1, $3); }

seq              :  term
                    { $$ = $1; }
                 |  definition T_SEP seq
                    { $$ = reducer__SEQ($1, $3); }

definition       :  T_VAR T_EQ term
                    { $$ = reducer__DEF($1, $3); }

term             :  rterm
                    { $$ = $1; }
                 |  lterm rterm
                    { $$ = reducer__APPLY($1, $2); }

lterm            :  lhead
                    { $$ = $1; }
                 |  lterm lrterm
                    { $$ = reducer__APPLY($1, $2); }

rterm            :  rhead
                    { $$ = $1; }
                 |  T_SUCC term
                    { $$ = reducer__SUCC($2); }
                 |  T_PRED term
                    { $$ = reducer__PRED($2); }
                 |  T_ISZERO term
                    { $$ = reducer__ISZERO($2); }
                 |  T_IF seq T_THEN seq T_ELSE seq
                    { $$ = reducer__IF($2, $4, $6); }

lhead            :  lrterm
                    { $$ = $1; }
                 |  T_LAMBDA T_VAR T_DOT lhead
                    { $$ = reducer__LAMBDA($2, $4, reducer__OPEN); }
                 |  T_LAMBDA T_LAMBDA T_VAR T_DOT lhead
                    { $$ = reducer__LAMBDA($3, $5, reducer__LOCKED); }

rhead            :  lrterm
                    { $$ = $1; }
                 |  T_LAMBDA T_VAR T_DOT rhead
                    { $$ = reducer__LAMBDA($2, $4, reducer__OPEN); }
                 |  T_LAMBDA T_LAMBDA T_VAR T_DOT lhead
                    { $$ = reducer__LAMBDA($3, $5, reducer__LOCKED); }
                 |  T_LAMBDA T_VAR T_HUNGRY_DOT seq
                    { $$ = reducer__LAMBDA($2, $4, reducer__OPEN); }
                 |  T_LAMBDA T_LAMBDA T_VAR T_HUNGRY_DOT seq
                    { $$ = reducer__LAMBDA($3, $5, reducer__LOCKED); }

lrterm           :  T_TRUE
                    { $$ = reducer__TRUE; }
                 |  T_FALSE
                    { $$ = reducer__FALSE; }
                 |  T_ZERO
                    { $$ = reducer__ZERO; }
                 |  T_VAR
                    { $$ = reducer__VAR($1); }
                 |  T_LEFT seq T_RIGHT
                    { $$ = $2; }

