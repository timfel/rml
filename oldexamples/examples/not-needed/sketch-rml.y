%{
#include <stdio.h>
#include "defs.h"
%}

%token T_abstype T_and T_as T_axiom T_datatype T_end T_exists T_module
%token T_not T_of T_relation T_rule T_type T_val T_with T_withtype T_let

%token T_YIELDS T_HBAR T_COLONCOLON T_UNDERSCORE
%token STRINGCONST INTCONST REALCONST CHARCONST IDENT TYVARIDENT

%%

Module:
  Interface
  Declarations
    { parse_tree = node(0, $1, $2, 0);}

Interface:
  T_module ModID  ':' Spec T_end
    { $$ = node(N_INTERFACE, $2, $4, 0);}

Declarations:
  T_with STRINGCONST
    { $$ = node(N_WITH, $2, 0, 0);}
| T_type Typbind
    { $$ = node(N_TYPE, $2, 0, 0);}
| T_datatype Datbind Withbind
    { $$ = node(N_DATATYPE, $2, $3, 0);}
| T_relation Relbinds
    { $$ = node(N_RELATION, $2, 0, 0);}
| T_val Var '=' Exp
    { $$ = node(N_VAL, $2, $4, 0); addsym($2, 0);}
| Declarations Declarations
    { $$ = node(N_SEQ, $1, $2, 0);}


Spec:
  T_with STRINGCONST
    { $$ = node(N_WITH, $2, 0, 0);}
| T_abstype Tyvarseq Tycon
    { $$ = node(N_ABSTYPE, $2, $3, 0);}
| T_type Typbind
    { $$ = node(N_TYPE, $2, 0, 0);}
| T_datatype Datbind Withbind
    { $$ = node(N_DATATYPE, $2, $3, 0);}
| T_relation Var ':' Tyseq T_YIELDS Tyseq
    { $$ = node(N_RELATION,
                  node(N_RELBIND, $2, node(N_YIELDS, $4, $6, 0), 0), 0, 0);
    }
| T_val Var ':' Ty
    { $$ = node(N_VAL, $2, $4, 0); addsym($2, $$);}
| Spec Spec
    { $$ = node(N_SEQ, $1, $2, 0);}


Relbinds:
  Relbinds T_and Relbind
    { $$ = node(N_SEQ, $1, $3, 0);}
| Relbind
    { $$ = $1;}

Relbind:
  Var '=' Clause T_end
    { $$ = node(N_RELBIND, $1, $3, 0);}
| Var ':' Tyseq T_YIELDS Tyseq '=' Clause T_end
    { $$ = node(N_RELBIND, $1, node(N_YIELDS, $3, $5, 0), $7);}


Withbind:
    { $$ = 0;}
| T_withtype Typbind
    { $$ = $2;}

Typbind:
  Tyvarseq Tycon '=' Ty
    { $$ = node(N_TYPBIND, $1, $2, $4);}
| Typbind T_and Typbind
    { $$ = node(N_SEQ, $1, $3, 0);}


Datbind:
  Tyvarseq Tycon '=' Conbind
    { $$ = node(N_DATBIND, $1, $2, $4);}
| Datbind T_and Datbind
    { $$ = node(N_SEQ, $1, $3, 0);}


Conbind:
  Con
   { $$ = node(N_CON, $1, 0, 0);}
| Con T_of Tys
   { $$ = node(N_CON, $1, $3, 0);}
| Conbind '|' Conbind
   { $$ = node(N_SEQ, $1, $3, 0);}


Clause:
  T_rule Goalopt T_HBAR Var Patseqopt Expseqopt
   { $$ = node(N_CLAUSE, $2, $4, node(N_PATEXP, $5, $6, 0));}
| T_axiom Var Patseqopt Expseqopt
   { $$ = node(N_CLAUSE, 0, $2, node(N_PATEXP, $3, $4, 0));}
| Clause Clause
   { $$ = node(N_SEQ, $1, $2, 0);}


Goals:
  Goal
   { $$ = 1;}
| Goal '&' Goals
   { $$ = node(N_SEQ, $1, $3, 0);}
 

Goal:
  Longvar Expseqopt RetPatseqopt
   { $$ = node(N_GOAL_CALL, $1, $2, $3);}
| Var '=' Exp
   { $$ = node(N_GOAL_EQUAL, $1, $3, 0);}
| T_exists Var
   { $$ = node(N_GOAL_EXISTS, $2, 0, 0);}
| T_not Goal
   { $$ = node(N_GOAL_NOT, $2, 0, 0);}
| '(' Goals ')'
   { $$ = $1;}


Goalopt:
   { $$ = 0;}
| Goals
   { $$ = $1;}


RetPatseqopt:
   { $$ = 0;}
| T_YIELDS Patseqopt
   { $$ = $2;}

Patseqopt:
   { $$ = 0;}
| Patseq
   { $$ = $1;}


Expseqopt:
   { $$ = 0;}
| Expseq
   { $$ = $1;}

Expseq:
  Exp
   { $$ = $1;}
| '(' Explist ')'
   { $$ = $1;}


Exp:
  Lit
   { $$ = $1;}
| '[' Explist ']'
   { $$ = $1;}
| Longcon
   { $$ = $1;}
| Longvar
   { $$ = $1;}
| Longcon Expseq
   { $$ = node(N_FUN, $1, $2, 0);}
| '(' Explist ')'
   { $$ = $2;}
| Exp T_COLONCOLON Exp
   { $$ = node(N_JOIN, $1, $2, 0);}


Explist:
   { $$ = 0;}
| Explist1
   { $$ = $1;}

Explist1:
  Exp
   { $$ = $1;}
| Explist1 ',' Exp
   { $$ = node(N_SEQ, $1, $3, 0);}

Patseq:
  Pat
   { $$ = node(N_PATTERN, $1, 0, 0);}
| '(' Patlist ')'
   { $$ = node(N_PATTERN, $1, 0, 0);}


Pat:
  T_UNDERSCORE
   { $$ = node(N_WILDCARD, 0, 0, 0);}
| Lit
   { $$ = $1;}
| '[' Patlist ']'
   { $$ = $1;}
| Longcon
   { $$ = $1;}
| Var
   { $$ = $1;}
| Longcon Patseq
   { $$ = node(N_FUN, $1, $2, 0);}
| '(' Patlist ')'
   { $$ = $2;}
| Pat T_COLONCOLON Pat
   { $$ = node(N_JOIN, $1, $3, 0);}
| Var T_as Pat
   { $$ = node(N_AS, $1, $3, 0);}


Patlist1:
  Pat
   { $$ = $1;}
| Patlist1 ',' Pat
   { $$ = node(N_SEQ, $1, $3, 0);}


Patlist:
   { $$ = 0;}
| Patlist1
   { $$ = $1;}


Tyseq:
  '(' ')'
   { $$ = 0;}
| Ty
   { $$ = $1;}
| '(' Tylist ')'
   { $$ = $2;}


Tylist:
  Ty
   { $$ = $1;}
| Tylist ',' Ty
   { $$ = node(N_SEQ, $1, $3, 0);}


Ty:
  Tyvar
   { $$ = $1;}
| Tyseqopt Longtycon
   { $$ = node(N_TYPE, 0, $1, $2);}
| Tys
   { $$ = $1;}
| Tyseq T_YIELDS Tyseq
   { $$ = node(N_YIELDS, $1, $3, 0);}
| '(' Ty ')'
   { $$ = $2;}


Tys:
  Ty '*' Ty
   { $$ = node(N_TYPES, node(N_TYPES, $1, 0, 0), $3, 0);}
| Tys '*' Ty
   { $$ = node(N_TYPES, $1, $3, 0);}


Tyseqopt:
   { $$ = 0;}
| Tyseq
   { $$ = $1;}


Tyvarlist:
  Tyvar
   { $$ = $1;}
| Tyvarlist ',' Tyvar
   { $$ = node(N_SEQ, $1, $3, 0);}


Tyvarseq:
   { $$ = 0;}
| Tyvar
   { $$ = $1;}
| '(' Tyvarlist ')'
   { $$ = $2;}

Lit:
  CHARCONST
   { $$ = node(N_CHARCONST, $1, 0, 0);}
| INTCONST
   { $$ = node(N_INTCONST, $1, 0, 0);}
| REALCONST
   { $$ = node(N_REALCONST, $1, 0, 0);}
| STRINGCONST
   { $$ = node(N_STRINGCONST, $1, 0, 0);}


Longvar:
  ModIDopt Var
   { $$ = node(N_SYMBOL, $2, $1, 0);}


Longcon:
  ModIDopt Con
   { $$ = node(N_SYMBOL, $2, $1, 0);}


Longtycon:
  ModIDopt Tycon
   { $$ = node(N_SYMBOL, $2, $1, 0);}


ModIDopt:
   { $$ = 0;}
| ModID '.'
   { $$ = $1;}


ModID:
  Symbol { $$ = $1;}

Var:
  Symbol { $$ = $1;}

Tyvar:
  TyvarSymbol { $$ = $1;}

Con:
  Symbol { $$ = $1;}

Tycon:
  Symbol { $$ = $1;}

Symbol:
  IDENT
   {
     struct Token *t = $1;
     $$ = node(N_IDENT, $1,
               node(N_SRCFIRST, 0, t->firstline, t->firstcol),
               node(N_SRCLAST,  0, t->lastline,  t->lastcol));
   }

TyvarSymbol:
  TYVARIDENT
   {
     struct Token *t = $1;
     $$ = node(N_IDENT, $1,
               node(N_SRCFIRST, 0, t->firstline, t->firstcol),
               node(N_SRCLAST,  0, t->lastline,  t->lastcol));
   }

%%

void yyerror(char *s)
{
  extern int lineno;

  if (*s == '!') /* '!' marks errors without specific position */
    ++s;
  else
    fprintf(stderr, "line %d: ", lineno);

  fprintf(stderr, "%s\n", s);

  exit(1);
}
