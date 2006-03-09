%{
#include "gram.h"
#include "yacclib.h"
#include "rml.h"
#include "absyn.h"

typedef void *rml_t;
/* extern rml_t yylval; */

int lex_icon();
int lex_ident();

%}

%option yylineno

whitespace   [ \t\n]+
letter       [a-zA-Z_]
ident           {letter}({letter}|{digit})*
digit        [0-9]
digits       {digit}+
icon       {digits}
pt       "."
sign       [+-]
exponent       ([eE]{sign}?{digits})
rcon1       {digits}({pt}{digits}?)?{exponent}
rcon2       {digits}?{pt}{digits}{exponent}?
rcon       {rcon1}|{rcon2}

%%

{whitespace} ;
{ident}         return lex_ident(); /* T_IDENT */
{icon}     return lex_icon();  /* T_INTCONST */
{rcon}     return lex_rcon();  /* T_REALCONST */
":="         return T_ASSIGN;
"+"          return T_ADD;
"-"          return T_SUB;
"*"          return T_MUL;
"/"          return T_DIV;
"("          return T_LPAREN;
")"          return T_RPAREN;
";"          return EOF;
%%

int lex_icon()
{
  yylval = (rml_t) mk_icon(atoi(yytext));  
  return T_INTCONST;        
}

int lex_rcon()
{
  yylval=(rml_t) mk_rcon(atof(yytext));
  return T_REALCONST;
}

int lex_ident()
{
        yylval = (rml_t) mk_scon(yytext);
        return T_IDENT;
}
