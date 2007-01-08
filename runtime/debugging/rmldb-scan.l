%{

#include "rmldb-parse.h"
#include <string.h>

#ifdef RML_DEBUG

#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <readline/readline.h>
#include <readline/history.h>
#include "rml.h"

/* Using flex, we can ask for a smaller input buffer.  With lex, this
   does nothing! */

#ifndef _PROTOTYPE
 #ifdef __STDC__
  #define _PROTOTYPE(func, args) func args
 #else
  #define _PROTOTYPE(func, args) func()
 #endif
#endif

#ifdef SMALL_BUF
#undef YY_READ_BUF_SIZE
#define YY_READ_BUF_SIZE 512
#endif

/* Force . as last for now. */
#define DOT_IS_LAST

/* We want to define our own yywrap. */
#undef aawrap
_PROTOTYPE(int aawrap, (void));

/* --- readline start */
/* Support for the readline and history libraries.  This allows
   nicer input on the interactive part of input. */

/* Have input call the following function. */
#undef  YY_INPUT
#define YY_INPUT(buf,result,max_size) \
		rl_input((char *)buf, &result, max_size)

/* Variables to help interface readline with rml debugger */
static char *rl_line = (char *)NULL;
static char *rl_start = (char *)NULL;
static int   rl_len = 0;

/* Definitions for readline access. */
extern FILE *rl_instream;
/*_PROTOTYPE(char *readline, (char *));*/

/* rl_input puts upto MAX characters into BUF with the number put in
   BUF placed in *RESULT.  If the yy input file is the same as
   rl_instream (stdin), use readline.  Otherwise, just read it.
*/

static void
rl_input (buf, result, max)
	char *buf;
	int  *result;
	int   max;
{	

    /* see if we are using the debugger over sockets */
	if (rmldb_terminal == RMLDB_TERMINAL_SOCKET)
	{
		size_t nb_bytes;                                                 
		nb_bytes = rmldb_recv_sock(rmldb_cmd_sock, (void*)buf, (size_t)max);           
		if ((nb_bytes == 0) || (nb_bytes == -1)) 
		{ 
			*result = YY_NULL;
			/* exit if the other part closed the socket */
			if (nb_bytes == -1 ) exit (1); 
		}   
		else 
		{ 
			*result = nb_bytes; 
		}
		return ;
	}
    
    /* here we use the readline interface */
    if (aain != rl_instream)
    {
      while ( (*result = read( fileno(aain), buf, max )) < 0 )
      if (errno != EINTR)
	  {
	    aaerror( "read() in flex scanner failed" );
	    exit (1);
	  }
      return;
    }
  
  /* Do we need a new string? */
  if (rl_len == 0)
  {
	if (rl_start)
		free(rl_start);
    rl_start = readline (RMLDB_PROMPT);
    if (rl_start == NULL) 
    {
		/* end of file */
		*result = 0;
		rl_len = 0;
		return;
	}
    rl_line = rl_start;
    rl_len = strlen (rl_line)+1;
    if (rl_len != 1)
		add_history (rl_line); 
    rl_line[rl_len-1] = '\n';
    fflush (stdout);
  }

  if (rl_len <= max)
  {
      strncpy (buf, rl_line, rl_len);
      *result = rl_len;
      rl_len = 0;
  }
  else
  {
      strncpy (buf, rl_line, max);
      *result = max;
      rl_line += max;
      rl_len -= max;
  }
}

/* --- readline end */

#endif /* RML_DEBUG */

/* 
this one tells the lexer if the 
parser expects an identifier next
*/
extern int rmldb_expect_identifier;

static const struct rmldb_keyword
{
	char *names; /* names are separated by '|' */
	int   tok;
} 
rmldb_keywords[] =
{
	{ "br|break|breakpoint",	T_BREAKPOINT				},
	{ "de|depth",				T_DEPTH						},
	{ "mx|maxstring",			T_MAXSTR					},
	{ "sh|show",				T_SHOW						},
	{ "on",						T_ON						},
	{ "off",					T_OFF						},
	{ "set",					T_SET						},
	{ "sg|settings",			T_SETTINGS					},
	{ "st|step",				T_STEP						},
	{ "ne|next",				T_NEXT						},
	{ "ru|run",					T_RUN						},
	{ "bt|backtrace",			T_BACKTRACE					},
	{ "fbt|fbacktrace",			T_FILTERED_BACKTRACE		},
	{ "gbt|graphbacktrace",		T_GRAPH_BACKTRACE			},
	{ "gfbt|graphfbacktrace",	T_GRAPH_FILTERED_BACKTRACE	},
	{ "mb|maxbacktrace",		T_MAXBT						},
	{ "ca|callchain",			T_CALLCHAIN					},
	{ "fca|fcallchain",			T_FILTERED_CALLCHAIN		},
	{ "gca|graphcallchain",		T_GRAPH_CALLCHAIN			},
	{ "gfca|graphfcallchain",	T_GRAPH_FILTERED_CALLCHAIN	},
	{ "mc|maxcallchain",		T_MAXCALLCHAIN				},
	{ "gc|graphcallchain",		T_GRAPH_CALLCHAIN			},
	{ "he|help",				T_HELP						},
	{ "qu|quit|ex|exit|by|bye",	T_QUIT						},
	{ "cl|clear",				T_CLEAR						},
	{ "sts|stat|status",		T_STATUS					},
	{ "ou|output",				T_OUTPUT					},
	{ "pr|print",				T_PRINT						},
	{ "pty|printtype",			T_PRINT_TYPE				},
	{ "li|live|livevars",		T_LIVEVARS					},
	{ "sz|size|sizeof",			T_SIZEOF					},
	{ "di|display",				T_DISPLAY					},
	{ "ud|undisplay",			T_UNDISPLAY					},
	{ "gr|graph",				T_GRAPH						},
	{ "fa|fast",				T_FAST						},
	{ "dbgp|debugparser",		T_DEBUGPARSER				},
	{ "rdbdbgp|rdbdebugparser",	T_RDBDEBUGPARSER			},
	{ "dbgsock|debugsocket",	T_DEBUGSOCKET				},
	{ 0,						0							}
};

/* %option always-interactive */

%}


%option 8bit
%option caseless
%option nodefault
%option outfile = "rmldb-scan.c"
%option prefix = "aa"

DIGIT	[0-9]
%%


	  
[ \t]+				{ /* Skip whitespace */ }

[[:alnum:]|"."|":"|"'"|"_"|[:graph:]|[:punct:]]* { 
	/* 
	check for rmldb_keywords here. we need to do this because we 
	want to have variable names as rmldb_keywords 
	*/
	int tok = T_ID, i = 0;
	for( i = 0; rmldb_keywords[i].names; ++i ) 
	{
		/* first try a direct comparison */
		if (strcmp(aatext, rmldb_keywords[i].names) == 0) 
		{
			tok = rmldb_keywords[i].tok; 
			break;
		}
		else /* try the tokens */
		{
			char* token = strtok(strdup(rmldb_keywords[i].names),"|");
			if (strcmp(aatext, token) == 0) 
			{
				tok = rmldb_keywords[i].tok; 
				break;
			}
			while (token = strtok(NULL, "|"))
			{
				if (strcmp(aatext, token) == 0) 
				{
					tok = rmldb_keywords[i].tok; 
					break;
				}
			}
		}
	}
	if (tok == T_ID) /* there was no keyword, return the id */
	{
		aalval.id = (char*)malloc(strlen(aatext)+1);
#ifdef RML_DEBUG
		if (aadebug) printf("FLEX:[ID:%s]", aatext); 
#endif
		strcpy(aalval.id, aatext); 
		return T_ID; 
	}
	else /* was a keyword, let's do some tests */
	{
		if (rmldb_expect_identifier) /* is the parser expecting an identifer? */
		{
			aalval.id = (char*)malloc(strlen(aatext)+1);
	#ifdef RML_DEBUG
			if (aadebug) printf("FLEX:[ID:%s]", aatext); 
	#endif
			strcpy(aalval.id, aatext); 
			return T_ID; 
		}
		return tok;
	}
	
}

\n              { return T_EOL; }
<<EOF>>			{ yyterminate(); }
.				{ 
#ifdef RML_DEBUG
if (aadebug) printf("FLEX:bad character %s:\n", aatext); 
#endif
}
%%

#ifdef RML_DEBUG

/* This is the way to get multiple files input into lex. */
int aawrap()
{ 
	if (rmldb_terminal == RMLDB_TERMINAL_READLINE)
	{
		fprintf(stdout, "reopening stdin on tty: %s...\n", rmldb_ttyname);
		if (!rmldb_open_new_file ()) return (1); /* EOF on standard in. */
		return (0);				         /* We have more input. */
	}
	
	/* if we are within a socket terminal */
	return 1; 
}

#endif /* RML_DEBUG */
