#include <stdio.h>
#include <string.h>
#include "y.tab.h"
#include "defs.h"

int lineno = 1, columnno = 0;

void *yylval;

#define MAX_COMMENT_LENGTH  2000

char comment_buffer[MAX_COMMENT_LENGTH+100];
int  comment_bufindex = 0;

static struct keyword
{
  char *name;
  int   code;
}
keywords[] =
{
/* Only RML keywords so far, need to add Modelica keywords as well */

#if 1
  /* RML keywords */
  { "abstype",      T_abstype },
  { "and",          T_and },
  { "as",           T_as },
  { "axiom",        T_axiom },
  { "block",        T_block },
  { "class",        T_class },
  { "connector",    T_connector },
  { "const",        T_const },
  { "datatype",     T_datatype },
  { "discrete",     T_discrete },
  { "end",          T_end },
  { "encapsulated", T_encapsulated },
  { "exists",       T_exists },
  { "flow",         T_flow },
  { "function",     T_function },
  { "input",        T_input },
  { "let",          T_let },
  { "module",       T_module },
  { "model",        T_model },
  { "not",          T_not },
  { "of",           T_of },
  { "or",           T_or },
  { "output",       T_output },
  { "package",      T_package },
  { "parameter",    T_parameter },
  { "partial",      T_partial },
  { "record",       T_record },
  { "relation",     T_relation },
  { "rule",         T_rule },
  { "type",         T_type },
  { "val",          T_val },
  { "with",         T_with },
  { "within",       T_within },
  { "withtype",     T_withtype },
  { "_",            T_UNDERSCORE },
#endif

#if 1
  /* Modelica keywords */
  { "class",    T_class },
#endif

  { 0, 0 }
};

static int back_ch = 0;
static int last_ch = 0;

static int keywords_sorted = 0;

static int cmpkw(struct keyword *k1, struct keyword *k2)
{
  return strcmp(k1->name, k2->name);
}

static int init_sort_keywords()
{
  int n;

  for(n = 0; keywords[n].name; ++n);

  qsort(keywords, n, sizeof(struct keyword), cmpkw);
}

static int get()
{
  if (back_ch)
    { back_ch = 0; return last_ch;}

  last_ch = fgetc(stdin);
  if (last_ch == '\n')
    { ++lineno; columnno = 0;}
  else if (last_ch == '\t')
    { while (++columnno % 8 != 0);}
  else
    ++columnno;

  return last_ch;
}

static void unget()
{
  back_ch = 1;
}

static int esc_char(int in_char_literal)
{
  int c = get();
  int v, i;

  switch (c)
  {
    case 'b':
      return '\b';
    case 'e':
      return 033;
    case 'f':
      return '\f';
    case 'n':
      return '\n';
    case 't':
      return '\t';
    default:
      if (c >= '0' && c <= '7')
      {
        for(v = i = 0; i < 3 && c >= '0' && c <= '7'; c = get())
          v = v*8 + c-'0';
        unget();
        return v;
      }
      return c;
  }
}


static int yylex0()
{
  int i, c, d, token;

  struct Token *val;
 
  static char ident[100];
  static char string[4100];

  val = (struct Token *) malloc(sizeof(struct Token));
  if (!val)
    yyerror("!out of memory");
  memset(val, 0, sizeof(struct Token));

  yylval = (long *) val;

  c = get();

  val->firstline = lineno;
  val->firstcol  = columnno;
  val->lastline  = lineno;
  val->lastcol   = columnno;

  switch (c)
  {
    case '\n': case ' ': case '\t':
      return yylex0();

    case EOF: case 0:
      return EOF;

    case '=': /* '=' or '=>' */
      d = get();
      if (d == '>')
        { token = T_YIELDS; break;}
      unget();
      return '=';

    case ':': /* ':' or '::' */
      d = get();
      if (d == ':')
        { token = T_YIELDS; break;}
      unget();
      return ':';

    case '(': /* '(' or '(*...comment...*)' */
      d = get();
      if (d == '*')
      {
        if (comment_bufindex > 0 && comment_bufindex < MAX_COMMENT_LENGTH)
        {
          comment_buffer[comment_bufindex++] = '\n';
          comment_buffer[comment_bufindex++] = '\n';
        }

        while (d != EOF)
        {
          d = get();
          if (d != '*')
          {
            if (comment_bufindex < MAX_COMMENT_LENGTH)
              comment_buffer[comment_bufindex++] = d;
            continue;
          }
          d = get();
          if (d == ')')
            break;
          if (comment_bufindex < MAX_COMMENT_LENGTH)
            comment_buffer[comment_bufindex++] = '*';
          unget();
        }
        return yylex0(); /* comment: skip and return next token */
      }
      unget();
      return '(';

    case '-': /* '-' or horizontal bar */
      d = get();
      if (d == '-')
      {
        while (d == '-')
          d = get();
        unget();
        token = T_HBAR;
        break;
      }
      unget();
      return '-';

    case '"': /* string constant */
      i = 0;
      while (1)
      {
        c = get();
        if (c == '"')
          break;
        if (c == '\\')
          c = esc_char(0);
        if (i < 4096)
          string[i++] = c;
        else
          yyerror("string buffer overflow");
      }
      string[i] = 0;
      token = STRINGCONST;
      val->string = strdup(string);
      break;

    case '#':
      c = get();
      if (c != '"')
        yyerror("invalid character constant");
      c = get();
      if (c == '\\')
        c = esc_char(1);
      d = get();
      if (d != '"')
        yyerror("invalid character constant");
      val->number = c;
      token = CHARCONST;
      break;

    case ',': case '*': case '|': case '&': case ')': case '.':
    case '[': case ']':
      /* plain separator/operator tokens */
      return c;

    default:
      if (isalpha(c) || c == '\'' || c == '_')
      {
        i = 0;
        do
        {
          if (i < 50)
          {
            ident[i++] = c;
            val->lastline = lineno;
            val->lastcol  = columnno;
          }
          c = get();
        }
        while (isalnum(c) || c == '\'' || c == '_');

        unget();
        ident[i] = 0;

      	if (!keywords_sorted)
      	{
      	  init_sort_keywords();
      	  keywords_sorted = 1;
      	}

        for(i = 0; keywords[i].name; ++i)
          if (!strcmp(ident, keywords[i].name))
            return keywords[i].code;

        val->ident = strdup(ident);
        return ident[0] == '\'' ? TYVARIDENT : IDENT;
      }
      else if (isdigit(c))
      {
        for(val->number = 0; isdigit(c); c = get())
          val->number = val->number*10 + c-'0';
        /* FIXME: add test and support for REALCONST here */
        unget();
        token = INTCONST;
        break;
      }
      else
        yyerror("invalid input character");
  }

  val->lastline = lineno;
  val->lastcol  = columnno;

  return token;
}


int yylex()
{
  int token = yylex0();
  int i;

  comment_buffer[comment_bufindex] = 0; /* ensure NUL termination */

#ifdef DEBUG
  /* for debugging */
  switch (token)
  {
    case IDENT:
      fprintf(stderr, "[IDENT %s]", ((struct Token *)yylval)->ident);
      return token;

    case T_YIELDS:
      fprintf(stderr, "[=>]");
      return token;

    case T_HBAR:
      fprintf(stderr, "[---]");
      return token;

    default:
     if (token > 0 && token < 256)
     {
       fprintf(stderr, "['%c']", token);
       return token;
     }       
     for(i = 0; keywords[i].name; ++i)
       if (keywords[i].code == token)
       {
         fprintf(stderr, "[KW %s]", keywords[i].name);
         return token;
       }
     fprintf(stderr, "[TOKEN %d]", token);
  }
#endif

  return token;
}
