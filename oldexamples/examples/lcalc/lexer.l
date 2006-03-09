

%{
#include "parser.h"
#include "yacclib.h"
#include "rml.h"
#include "reducer.h"

typedef unsigned rml_string;
int t_var(void);
%}



n               ("\n"|"\r")
t               ("\t"|" ")
s               ({n}|{t})

digit           [0-9]
letter          [a-zA-Z]
lchar           ({letter}|[+*/<>-])
vchar           ({lchar}|{digit}|[_])

var             {lchar}{vchar}*
comment         "//".*{n}


%%



"true"       return T_TRUE;
"false"      return T_FALSE;
"0"          return T_ZERO;

"succ"       return T_SUCC;
"pred"       return T_PRED;
"iszero"     return T_ISZERO;

"if"         return T_IF;
"then"       return T_THEN;
"else"       return T_ELSE;

"="          return T_EQ;
";"          return T_SEP;

"#"          return T_LAMBDA;
"."          return T_DOT;
"."{s}       return T_HUNGRY_DOT;

"("          return T_LEFT;
")"          return T_RIGHT;

{var}        return t_var();

{s}*{n}      return T_NL;
{s}+         ;
{comment}    ;
.            return T_ERR;


%%


int t_var() {
  yylval = (rml_string) mk_scon(yytext);
  return T_VAR;
}

