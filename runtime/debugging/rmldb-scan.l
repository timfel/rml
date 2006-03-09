%{

#include "rmldb-parse.h"

#ifdef RML_DEBUG

#include <stdlib.h>
#include <string.h>
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

/* Variables to help interface readline with bc. */
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
/* %option always-interactive */

#endif /* RML_DEBUG */

%}


%option 8bit
%option caseless
%option nodefault
%option outfile = "rmldb-scan.c"
%option prefix = "aa"

DIGIT	[0-9]
%%

br|break|breakpoint {
	return T_BREAKPOINT;
}

de|depth {
	return T_DEPTH;
}

ms|maxstring {
	return T_MAXSTR;
}

sh|show {
	return T_SHOW;
}

on {
	return T_ON;
}

off {
	return T_OFF;
}

set {
	return T_SET;
}

sg|settings {
	return T_SETTINGS;
}

st|step {
	return T_STEP;
}

ne|next {
	return T_NEXT;
}
				
ru|run {
	return T_RUN;
}

bt|backtrace {
	return T_BACKTRACE;
}

fbt|fbacktrace {
	return T_FILTERED_BACKTRACE;
}								

gbt|graphbacktrace {
	return T_GRAPH_BACKTRACE;
}

gfbt|graphfbacktrace {
	return T_GRAPH_FILTERED_BACKTRACE;
}								

mb|maxbacktrace {
	return T_MAXBT;
}

ca|callchain {
	return T_CALLCHAIN;
}

fca|fcallchain {
	return T_FILTERED_CALLCHAIN;
}								

gca|graphcallchain {
	return T_GRAPH_CALLCHAIN;
}

gfca|graphfcallchain {
	return T_GRAPH_FILTERED_CALLCHAIN;
}								

mc|maxcallchain {
	return T_MAXCALLCHAIN;
}

gc|graphcallchain
{
	return T_GRAPH_CALLCHAIN;
}

he|help {
	return T_HELP;
}

end {
	return T_END;
}
				
qu|quit|ex|exit|by|bye {
	return T_QUIT;
}

cl|clear {
	return T_CLEAR;
}

sts|stat|status {
	return T_STATUS;
}

ou|output {
	return T_OUTPUT;
}
				
pr|print {
	return T_PRINT;
}

pty|printtype {
	return T_PRINT_TYPE;
}
		
li|live|livevars {
	return T_LIVEVARS;
}

sz|size|sizeof	{
	return T_SIZEOF;
}

di|display	{
	return T_DISPLAY;
}

ud|undisplay {
	return T_UNDISPLAY;
}

gr|graph {
	return T_GRAPH;
}

fa|fast {
   return T_FAST;
}

dbgp|debugparser {
   return T_DEBUGPARSER;
}
	  
[ \t]+				{ /* Skip whitespace */ }

[[:alnum:]|"."|":"|"'"|"_"|[:graph:]|[:punct:]]* { 
	aalval.id = (char*)malloc(strlen(aatext)+1);
#ifdef RML_DEBUG
	if (aadebug) printf("FLEX:[ID:%s]",aatext); 
#endif
	strcpy(aalval.id, aatext); 
	return T_ID; 
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
  fprintf(stdout, "reopening stdin on tty: %s...\n", rmldb_ttyname);
  if (!rmldb_open_new_file ()) return (1); /* EOF on standard in. */
  return (0);				         /* We have more input. */
}

#endif /* RML_DEBUG */
