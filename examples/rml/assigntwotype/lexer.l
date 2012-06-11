%{
#define YYSTYPE void*
#include "parser.h"
#include "rml.h"
#include "assigntwotype.h"

int lex_icon(void);
int lex_ident(void);
int lex_rcon(void);

%}

whitespace   [ \t\n]+
letter       [a-zA-Z_]
ident        {letter}({letter}|{digit})*
digit        [0-9]
digits       {digit}+
icon         {digits}
pt           "."
sign         [+-]
exponent     ([eE]{sign}?{digits})
rcon1        {digits}({pt}{digits}?)?{exponent}
rcon2        {digits}?{pt}{digits}{exponent}?
rcon         {rcon1}|{rcon2}

%%

{whitespace} ;
{ident}      return lex_ident(); /* T_IDENT */
{icon}       return lex_icon();  /* T_INTCONST */
{rcon}       return lex_rcon();  /* T_REALCONST */
":="         return T_ASSIGN;
"+"          return T_ADD;
"-"          return T_SUB;
"*"          return T_MUL;
"/"          return T_DIV;
"("          return T_LPAREN;
")"          return T_RPAREN;
";"          return T_SEMIC;

%%

int lex_icon(void)
{
  int x = atoi(yytext);
  yylval = (void*) mk_icon(atoi(yytext));
  return T_INTCONST;
}

int lex_rcon(void)
{
  yylval=(void*) assigntwotype__REAL(mk_rcon(atof(yytext)));
  return T_REALCONST;
}

int lex_ident(void)
{
  yylval = (void*) mk_scon(yytext);
  return T_IDENT;
}
