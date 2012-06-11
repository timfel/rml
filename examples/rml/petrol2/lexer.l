%{
/* lexer.l */
#include "port/config.h"
#include "rml.h"
#include "parsutil.h"
#include "parser.h"
#include "lexutil.h"

...

%}

white           [ \t\n]+
letter          [a-zA-Z_]
digit           [0-9]
ident           {letter}({letter}|{digit})*
digits          {digit}+
icon            {digits}
pt              "."
sign            [+-]
exponent        ([eE]{sign}?{digits})
rcon1           {digits}({pt}{digits}?)?{exponent}
rcon2           {digits}?{pt}{digits}{exponent}?
rcon            {rcon1}|{rcon2}

%%
"{"             lex_comment();
{white}         ;
{ident}         return lex_log_token(lex_ident());
{icon}          return lex_log_token(lex_icon());
{rcon}          return lex_log_token(lex_rcon());
":="            return lex_log_token(T_ASSIGN);
":"             return lex_log_token(T_COLON);
","             return lex_log_token(T_COMMA);
"."             return lex_log_token(T_DOT);
"["             return lex_log_token(T_LBRACK);
"]"             return lex_log_token(T_RBRACK);
"("             return lex_log_token(T_LPAREN);
")"             return lex_log_token(T_RPAREN);
"<>"            return lex_log_token(T_NE);
"<="            return lex_log_token(T_LE);
"<"             return lex_log_token(T_LT);
"="             return lex_log_token(T_EQ);
">="            return lex_log_token(T_GE);
">"             return lex_log_token(T_GT);
"-"             return lex_log_token(T_MINUS);
"*"             return lex_log_token(T_MUL);
"+"             return lex_log_token(T_PLUS);
"/"             return lex_log_token(T_RDIV);
";"             return lex_log_token(T_SEMI);
"&"             return lex_log_token(T_AMPER);
"^"             return lex_log_token(T_CARET);
