%{
#define YYSTYPE void*
#include "gram.h"
#include "rml.h"
#include "absyn.h"

typedef void *rml_t;
/* extern rml_t yylval; */ 

int absyn_integer(char *s);
int absyn_ident_or_keyword(char *s);

%}

%option yylineno
 
%x c_comment

whitespace   [ \t\n]+
letter       [a-zA-Z]
ident           {letter}({letter}|{digit})*
digit        [0-9]
digits       {digit}+
icon       {digits}
/* Lex style lexical syntax of tokens in the PAM language */

%%


{whitespace} ;
{ident}         return absyn_ident_or_keyword(yytext); /* T_IDENT */
{digits}     return absyn_integer(yytext);  /* T_INTCONST */
":="         return T_ASSIGN;
"+"          return T_ADD;
"-"          return T_SUB;
"*"          return T_MUL;
"/"          return T_DIV;
"("          return T_LPAREN;
")"          return T_RPAREN;
"<"          return T_LT;
"<="         return T_LE;
"="          return T_EQ;
"<>"         return T_NE;
">="         return T_GE;
">"          return T_GT;
";"          return T_SEMIC;


"/\*"	     {
		BEGIN(c_comment);
             }
<c_comment>
{
    "\*/"    { BEGIN(INITIAL); }
    "/\*"    { yyerror("Suspicious comment"); }
    [^\n]    ;
    \n       ;
    <<EOF>>  {
               yyerror("Unterminated comment");
	       yyterminate();
	     }
}

%%

/* Make an RML integer from a C string representation (decimal),
   box it for our abstract syntax, put in yylval and return constant token. */
 
int absyn_integer(char *s)
{
  yylval=(rml_t) Absyn__INT(mk_icon(atoi(s)));
  return T_INTCONST;
}
 
/* Make an RML Ident or a keyword token from a C string */
/* Reserved words: if,then,else,endif,while,do,end,to,read,write */
 
static struct keyword_s
{
  char *name;
  int token;
} kw[] =
{
  {"do",        T_DO},
  {"else",      T_ELSE},
  {"end",       T_END},
  {"if",        T_IF},
  {"read",   T_READ},
  {"then",      T_THEN},
  {"while",     T_WHILE},
  {"write",     T_WRITE},
};

int absyn_ident_or_keyword(char *s)
{
        int low = 0;
        int high = (sizeof kw) / sizeof(struct keyword_s) - 1;

        while( low <= high ) {
                int mid = (low + high) / 2;
                int cmp = strcmp(kw[mid].name, yytext);
                if( cmp == 0 )
                {
                        return kw[mid].token;
                }
                else if( cmp < 0 )
                        low = mid + 1;
                else
                        high = mid - 1;
        }
        yylval = (rml_t) mk_scon(s);
        return T_IDENT;
}
