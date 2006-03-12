%{
#include "parser.h"
#include "yacclib.h"
#include "rml.h"
#include "eval.h"

typedef void *rml_t;

rml_t absyn_integer(char *s);

%}

digit           ("0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9")
digits          {digit}+
junk            \n
letter          [$_A-Za-z.]
letters         {letter}+


%%

{digits}     { yylval=absyn_integer(yytext); return T_REALCONST;}
"+"          return T_ADD;
"-"          return T_SUB;
"*"          return T_MUL;
"/"          return T_DIV;
"("          return T_LPAREN;
")"          return T_RPAREN;
{junk}+         ;
{letters}    return T_ERR;

%%

rml_t absyn_integer(char *s)
{
  return (rml_t) Eval__RCONST(mk_rcon(atof(s)));
}

