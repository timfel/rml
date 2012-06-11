%{
#define YYSTYPE void*
#include "parser.h"
#include "rml.h"
#include "Assignment.h"

int lex_icon(void);
int lex_ident(void);

%}

whitespace   [ \t\n]+
letter       [a-zA-Z_]
ident        {letter}({letter}|{digit})*
digit        [0-9]
digits       {digit}+
%%

{whitespace} ;
{ident}      return lex_ident(); /* T_IDENT */
{digits}     return lex_icon();  /* T_INTCONST */
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
  yylval = (void*) Assignment__INT(mk_icon(atoi(yytext)));  
  return T_INTCONST;        
}

int lex_ident(void)
{
  yylval = (void*) mk_scon(yytext);
  return T_IDENT;
}
