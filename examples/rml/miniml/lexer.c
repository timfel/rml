/* lexer.c */
#include <ctype.h>
#include <stdio.h>
#include <string.h>	/* strcmp() strchr() */
#include <stdlib.h>	/* atoi() atof() */
#include <stdarg.h>
#include "rml.h"	/* enum bop */
#include "parsutil.h"	/* enum bop */
#include "parser.h"	/* tokens, yylval */
#include "lexer.h"

int yylineno = 1;

void lexerror(const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    fprintf(stderr, "Line %d: ", yylineno);
    vfprintf(stderr, fmt, ap);
    va_end(ap);
    exit(1);
}

const char *lex_token_to_string(int token)
{
    struct my_yytoktype {
	const char *t_name; int t_val;
    };
    static const struct my_yytoktype my_yytoks[] = {
	{ "T_COLONCOLON", T_COLONCOLON },
	{ "T_COLONEQ", T_COLONEQ },
	{ "T_COMMA", T_COMMA },
	{ "T_DASH", T_DASH },
	{ "T_ELSE", T_ELSE },
	{ "T_END", T_END },
	{ "T_EQ", T_EQ },
	{ "T_FATARROW", T_FATARROW },
	{ "T_FN", T_FN },
	{ "T_FUN", T_FUN },
	{ "T_ICON", T_ICON },
	{ "T_IDENT", T_IDENT },
	{ "T_IDIV", T_IDIV },
	{ "T_IF", T_IF },
	{ "T_IMOD", T_IMOD },
	{ "T_IN", T_IN },
	{ "T_LE", T_LE },
	{ "T_LET", T_LET },
	{ "T_LBRACK", T_LBRACK },
	{ "T_LPAREN", T_LPAREN },
	{ "T_LT", T_LT },
	{ "T_OP", T_OP },
	{ "T_PLUS", T_PLUS },
	{ "T_RBRACK", T_RBRACK },
	{ "T_RCON", T_RCON },
	{ "T_RDIV", T_RDIV },
	{ "T_RPAREN", T_RPAREN },
	{ "T_SCON", T_SCON },
	{ "T_SEMI", T_SEMI },
	{ "T_STAR", T_STAR },
	{ "T_THEN", T_THEN },
	{ "T_VAL", T_VAL },
	{ 0, -1 }	/* ends search */
    };
    const struct my_yytoktype *p;
    int token2;

    if( token == 0 )
	return "end-of-file";
    if( token < 0 )
	return "-none-";
    for(p = my_yytoks; (token2 = p->t_val) >= 0; ++p)
	if( token2 == token )
	    return p->t_name;
    {
	static char buf[32];
	sprintf(buf, "(unknown %d)", token);
	return buf;
    }
}

#ifdef LEXDEBUG
int lexdebug;

static int lex_log_token(int token)
{
    if( lexdebug ) {
	fprintf(stderr, "Lexer: line %d, token %s",
		yylineno, lex_token_to_string(token));
	if( token == T_ICON ) {
	    fprintf(stderr, ", value ");
	    print_icon(stderr, yylval.voidp);
	} else if( token == T_IDENT || token == T_SCON ) {
	    fprintf(stderr, ", value \"");
	    print_scon(stderr, yylval.voidp);
	    fputc('"', stderr);
	}
	fputc('\n', stderr);
    }
    return token;
}
#else
#define lex_log_token(TOKEN) (TOKEN)
#endif

static const struct {
	char *name;	int token;
} kwds[] = {
    {	"*",		T_STAR,		},
    {	"+",		T_PLUS		},
    {	"-",		T_DASH,		},
    {	"/",		T_RDIV		},
    {	"::",		T_COLONCOLON	},
    {	":=",		T_COLONEQ	},
    {	"<",		T_LT		},
    {	"<=",		T_LE		},
    {	"=",		T_EQ		},
    {	"=>",		T_FATARROW	},
    {	"div",		T_IDIV		},
    {	"else",		T_ELSE		},
    {	"end",		T_END		},
    {	"fn",		T_FN		},
    {	"fun",		T_FUN		},
    {	"if",		T_IF		},
    {	"in",		T_IN		},
    {	"let",		T_LET		},
    {	"mod",		T_IMOD		},
    {	"op",		T_OP		},
    {	"then",		T_THEN		},
    {	"val",		T_VAL		},
};

static int lex_kwd_or_ident(char *s)
{
    int low = 0;
    int high = (sizeof kwds) / (sizeof kwds[0]) - 1;

    while( low <= high ) {
	int mid = (low + high) / 2;
	int cmp = strcmp(kwds[mid].name, s);
	if( cmp == 0 )
	    return kwds[mid].token;
	else if( cmp < 0 )
	    low = mid + 1;
	else
	    high = mid - 1;
    }
    yylval.voidp = mk_scon(s);
    return T_IDENT;
}

static int lex_scon(void)
{
    char s[128];
    int ch, i = 0;

    for(;;) {
	switch( (ch = getchar()) ) {
	  case EOF:
	    lexerror("Premature EOF in string constant");
	  case '"':
	    break;
	  case '\\':
	    switch( (ch = getchar()) ) {
	      case '\n':
		++yylineno;
		break;
	      case 'n':
		ch = '\n';
		break;
	    }
	    /*FALLTHROUGH*/
	  default:
	    s[i++] = ch;
	    continue;
	}
	break;
    }
    s[i] = '\0';
    yylval.voidp = mk_scon(s);
    return T_SCON;
}

static void lex_comment(void)
{
    int level = 1, ch;

SkipToStarRP:
    switch( (ch = getchar()) ) {
      case '*':	goto AfterStar;
      case '(':	goto AfterLP;
      case EOF: goto PrematureEOF;
      case '\n': ++yylineno; goto SkipToStarRP;
      default:	goto SkipToStarRP;
    }
AfterStar:
    switch( (ch = getchar()) ) {
      case ')':	if( --level <= 0 ) return; else goto SkipToStarRP;
      case '*':	goto AfterStar;
      case '(':	goto AfterLP;
      case EOF: goto PrematureEOF;
      case '\n': ++yylineno; goto SkipToStarRP;
      default:	goto SkipToStarRP;
    }
AfterLP:
    switch( (ch = getchar()) ) {
      case '*':	++level; goto SkipToStarRP;
      case '(':	goto AfterLP;
      case EOF: goto PrematureEOF;
      case '\n': ++yylineno; goto SkipToStarRP;
      default:	goto SkipToStarRP;
    }
PrematureEOF:
    lexerror("Premature EOF in comment, now at level %d\n", level);
}

static int issymbol(int ch)
{
    /* the +1/-1 silliness is for those not-quite ANSI C compilers that
       insist on sticking a terminating NUL on every string literal */
    static const char symbols[20+1] = "-!%&$#+/:<=>?@\\~`^|*";
    int i;

    for(i = 0; i < (sizeof symbols)-1; ++i)
	if( symbols[i] == ch )
	    return 1;
    return 0;
}

static int lex_symbol_ident(int ch)
{
    char s[128];
    int i = 0;

    do {
	s[i++] = ch;
	ch = getchar();
    } while( issymbol(ch) );
    s[i] = '\0';
    ungetc(ch, stdin);
    return lex_kwd_or_ident(s);
}

static int lex_alpha_ident(int ch)
{
    char s[128];
    int i = 0;

    do {
	s[i++] = ch;
	ch = getchar();
    } while( isalnum(ch) || ch == '_' || ch == '\'' );
    s[i] = '\0';
    ungetc(ch, stdin);
    return lex_kwd_or_ident(s);
}

static int lex_number(int ch)
{
    char s[128];
    int i = 0, isreal = 0;

    do {
	s[i++] = ch;
	ch = getchar();
    } while( isdigit(ch) );
    if( ch == '.' ) {
	isreal = 1;
	s[i++] = ch;
	ch = getchar();
	if( !isdigit(ch) )
	    lexerror("Bad fraction: expected digit, got %03o", ch);
	do {
	    s[i++] = ch;
	    ch = getchar();
	} while( isdigit(ch) );
    }
    if( ch == 'e' || ch == 'E' ) {
	isreal = 1;
	s[i++] = ch;
	ch = getchar();
	if( ch == '~' ) {
	    s[i++] = '-';
	    ch = getchar();
	} else if( ch == '+' ) {
	    s[i++] = ch;
	    ch = getchar();
	}
	if( !isdigit(ch) )
	    lexerror("Bad exponent: expected digit, got %03o", ch);
	do {
	    s[i++] = ch;
	    ch = getchar();
	} while( isdigit(ch) );
    }
    s[i] = '\0';
    ungetc(ch, stdin);
    if( isreal ) {
	yylval.voidp = mk_rcon(atof(s));
	return T_RCON;
    } else {
	yylval.voidp = mk_icon(atoi(s));
	return T_ICON;
    }
}

int yylex(void)
{
    int ch;

    for(;;) {
	ch = getchar();
	switch( ch ) {
	  case EOF:
	    return 0;
	  case '\n':
	    ++yylineno;
	    continue;
	  case '\t':
	    continue;
	  case ' ':
	    continue;
	  case '[':
	    return lex_log_token(T_LBRACK);
	  case ']':
	    return lex_log_token(T_RBRACK);
	  case '(':	/* LPAREN or comment */
	    ch = getchar();
	    switch( ch ) {
	      case '*':
		lex_comment();
		continue;
	      default:
		ungetc(ch, stdin);
		return lex_log_token(T_LPAREN);
	    }
	  case ')':
	    return lex_log_token(T_RPAREN);
	  case ',':
	    return lex_log_token(T_COMMA);
	  case ';':
	    return lex_log_token(T_SEMI);
	  case '"':
	    return lex_log_token(lex_scon());
	  case '~':	/* number or symbolic identifier */
	    ch = getchar();
	    ungetc(ch, stdin);
	    if( isdigit(ch) )
		return lex_log_token(lex_number('-'));
	    else
		return lex_log_token(lex_symbol_ident('~'));
	  default:
	    if( isdigit(ch) )
		return lex_log_token(lex_number(ch));
	    else if( isalpha(ch) || ch == '_' )
		return lex_log_token(lex_alpha_ident(ch));
	    else if( issymbol(ch) )
		return lex_log_token(lex_symbol_ident(ch));
	    else {
		lexerror("Illegal character %03o", ch);
	    }
	}
    }
}
