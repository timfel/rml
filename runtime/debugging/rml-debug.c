/*
Copyright (c) 2002-2006 by Adrian Pop

Permission to use, copy, modify, and distribute this software and
its documentation for NON-COMMERCIAL purposes and without fee is hereby 
granted, provided that this copyright notice appear in all copies and 
that both the copyright notice and this permission notice and warranty
disclaimer appear in supporting documentation, and that the name of
The Author not be used in advertising or publicity pertaining to
distribution of the software without specific, written prior permission.
For COMMERCIAL uses of versions above rml-2.1.8 please contact 
Adrian Pop, adrpo@ida.liu.se. 

THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, INDIRECT OR
CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE
USE OR PERFORMANCE OF THIS SOFTWARE.
*/
/***********************************************************
[ rml-debug.c ] 
- Adrian Pop, adrpo@ida.liu.se, http://www.ida.liu.se/~adrpo 
- creation: 2002-10
  + implementation for rml debugging 
    this file contains all the functions for debugging.
    look also into runtime/debugging for:
    * debug-debug.c 
    * debug-print.c
    * debug-push-vars.c
	* rml-db-load.*
  + all things in this file starts with rmldb_
- last modified: 2005-12-27
************************************************************/

/* all these functions depends on RML_DEBUG macro */
/**************************************************/
#ifdef RML_DEBUG
/**************************************************/

#include <stdio.h>
#if defined(__MINGW32__) || defined(_MSC_VER)

#if defined(__MINGW32__) /* ********** MINGW32 stuff ******/
/* we have readline */
#include <readline/readline.h>
#include <readline/history.h>
/* do we have signal in ming32?? */
#include <signal.h>

#endif
/*********** MING32 && MSVC stuff **********/

#include <WinSock2.h>

#define rmldb_send_sock(x,y,z) send(x,y,z,0)
#define rmldb_recv_sock(x,y,z) recv(x,y,z,0)
#define rmldb_close_sock closesocket
#define rmldb_sock_errorno WSAGetLastError()

#else /***************** unix stuff ***************/

#include <readline/readline.h>
#include <readline/history.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/unistd.h>
#include <sys/stat.h>
#include <netinet/in.h>
#include <netdb.h>

#define rmldb_send_sock(x,y,z) write(x,y,z)
#define rmldb_recv_sock(x,y,z) read(x,y,z)
#define rmldb_close_sock close
#define rmldb_sock_errorno errno
#define SOCKET_ERROR (-1)
#define INVALID_SOCKET (-1)

#endif

#include <stdarg.h>
#include <errno.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

#ifndef  _RML_DEBUG_H_
#include "rml.h"
#endif


#define RMLDB_TYPE_SUFFIX_NONE   0
#define RMLDB_TYPE_SUFFIX_LIST   1
#define RMLDB_TYPE_SUFFIX_OPTION 2
#define RMLDB_TYPE_SUFFIX_LVAR   3
#define RMLDB_TYPE_SUFFIX_VECTOR 4
#define RMLDB_TYPE_SUFFIX_ARRAY  5

int rmldb_sock_debug = 0; /* make it 1 to debug the socket messages */
char* rmldb_command;
int   rmldb_execution_type         = RMLDB_STEP;
int   rmldb_execution_startup_type = RMLDB_STEP;
int   rmldb_show = RMLDB_HIDE;

/* adrpo 
this filter is set on the relations you want to make the 
program to stop (like a breakpoint, but with string matching  */
char rmldb_relation_filter[RMLDB_MAX_BREAKPOINTS][RMLDB_MAX_STRING];
int  rmldb_number_of_filters = 0; /* of course, the number of filters. */
int  rmldb_depth_of_variable_print = 10; /* the depth of the variable showing */
int  rmldb_max_string_variable_print = 60; /* how many characters we display in strings */
int  rmldb_max_backtrace_entries = 100;
int  rmldb_max_callchain_entries = 100;
int  rmldb_print_livevars_each_step = RMLDB_LIVEVARS_OFF;

/* adrpo 
This flag is set to RMLDB_BREAK_PARSE when you want EXIT the parse cycle.
This flag is set to RMLDB_REPEAT_PARSE when you want stay in the parse 
cycle after executing a command. See rmldb-parse.y.
  */ 
int  rmldb_last_command = RMLDB_REPEAT_PARSE;

struct rmldb_stack_node *rmldb_stack_start;
struct rmldb_stack_node *rmldb_stack_end;

struct rmldb_call_node *rmldb_callchain_start;
struct rmldb_call_node *rmldb_callchain_end;

struct rmldb_var_node *rmldb_var_in_start;
struct rmldb_var_node *rmldb_var_in_end;

struct rmldb_var_node *rmldb_var_out_start;
struct rmldb_var_node *rmldb_var_out_end;

char*  rmldb_ttyname = "DEFAULT";

/* Local functions */
#define RMLDB_MAX_LINE 10000
FILE* rmldb_external_server_sock_file = NULL;
int rmldb_external_server_sock = -1;
int rmldb_external_server_sock_status = 0;

char rmldb_display_vars[RMLDB_MAX_DISPLAY_VARS][RMLDB_MAX_STRING];
int rmldb_number_of_display_vars=0; /* of course, the number active display vars. */

/* current execution range */
rmldb_current_execution_loc_t rmldb_current_execution_loc;

#define RMLDB_RANGE_EQ  0
#define RMLDB_RANGE_GT  1
#define RMLDB_RANGE_LT -1


/* returns: (we compare only the first line/column of each range
  0 if equal
 +1 if [overlapping] bigger
 -1 if [overlapping] smaller
*/

int rmldb_range_cmp(rmldb_range_db_t *r1, rmldb_range_db_t *r2)
{
	int factor = 1000;
	int t1s,t1e,t2s,t2e;
	t1s = r1->sl*factor + r1->sc; t1e = r1->el*factor + r1->ec; 
	t2s = r2->sl*factor + r2->sc; t2e = r2->el*factor + r2->ec;
	if (t1s == t2s && t1e == t2e) return RMLDB_RANGE_EQ;
	if (t1s > t2s) return RMLDB_RANGE_GT;
	if (t1s < t2s) return RMLDB_RANGE_LT;
}

#define RMLDB_RANGE_1IN2 2
#define RMLDB_RANGE_2IN1 -2
/* returns
  0 if equal
 +1 if [overlapping] bigger
 -1 if [overlapping] smaller
 +2 if r1 included in r2
 -2 if r2 included in r1
*/

int rmldb_range_incl(rmldb_range_db_t *r1, rmldb_range_db_t *r2)
{
	int factor = 1000;
	int t1s,t1e,t2s,t2e;
	t1s = r1->sl*factor + r1->sc; t1e = r1->el*factor + r1->ec; 
	t2s = r2->sl*factor + r2->sc; t2e = r2->el*factor + r2->ec;
	if (t1s >= t2s && t1e <= t2e) return RMLDB_RANGE_1IN2;
	if (t1s <= t2s && t1e >= t2e) return RMLDB_RANGE_2IN1;
	return rmldb_range_cmp(r1,r2);
}

#if defined(__MINGW32__) /* ********** MINGW32 stuff ******/
char* ttyname(int fd) 
{
	return rmldb_ttyname;
}
#endif
/*
this function inits the debugger
*/
int rmldb_init(void)
{ 
#ifdef RML_DEBUG

#if defined(__MINGW32__) || defined(_MSC_VER)
	/* initialize the socket library */
    WSADATA info;
    if (WSAStartup(MAKEWORD(2,0), &info)) 
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Error! WSAStartup failed: %s\n", 
				RMLDB_PROMPT, 
				strerror(rmldb_sock_errorno));
    }

#if defined(__MINGW32__)
	signal (SIGINT, rmldb_use_quit);
#endif
	/* nothing to do on UNIX */
#endif
	char process_id[20];
	snprintf(process_id, 20, "%d", getpid());
	/* debug the damn parsers/lexers */
	/* aadebug = 1; */
	/* aarmldbdebug = 1; */ 
	if (rmldb_execution_startup_type == RMLDB_STEP)
	{
		printf("%s - Relational Meta-Language (RML) and MetaModelica (MMC) debugger\n", RMLDB_PROMPT);
		printf("%s - Copyright 2002-2006, Adrian Pop [adrpo@ida.liu.se], PELAB/IDA/LiU\n", RMLDB_PROMPT);  
		printf("%s - debugging process %s \n", RMLDB_PROMPT, process_id);
	}
	/* Readline support.  Set both application name and input file. */ 
	rl_readline_name = RMLDB_PROMPT;
	rl_instream = stdin;
	if (!isatty(STDIN_FILENO)) /* returns 1 on success */
	{
		fprintf(stderr, "RML debugger: isatty(fileno(stdin)) failed: %s\n",
			strerror(errno));
		/* rmldb_exit(0); */
	}
	if (!(rmldb_ttyname = ttyname(STDIN_FILENO)))
	{
		fprintf(stderr, "RML debugger init ttyname(0) failed: %s\n",
			strerror(errno));
		/*rmldb_exit(0);*/
	}
	else
	{
		if (rmldb_execution_startup_type == RMLDB_STEP)
			printf("%s - on tty:%s \n", RMLDB_PROMPT, rmldb_ttyname);
	}


	using_history ();

	/* initalize stuff */
	rmldb_var_in_start = NULL;
	rmldb_var_in_end = NULL;
	rmldb_var_out_start = NULL;
	rmldb_var_out_end = NULL;

	rmldb_var_db_start = NULL;
	rmldb_var_db_end = NULL;
	rmldb_type_db_start = NULL;
	rmldb_type_db_end = NULL;
	rmldb_con_db_start = NULL;
	rmldb_con_db_end = NULL;
	rmldb_relation_db_start = NULL;
	rmldb_relation_db_end = NULL;

	rmldb_current_execution_loc.file[0] = '\0';
	rmldb_current_execution_loc.relation[0] = '\0';
	rmldb_current_execution_loc.goal[0] = '\0';
	rmldb_current_execution_loc.range.sl = 0;
	rmldb_current_execution_loc.range.sc = 0;
	rmldb_current_execution_loc.range.el = 0;
	rmldb_current_execution_loc.range.ec = 0;
	rmldb_current_execution_loc.SP = rmldb_stack_pointer_to_ulong(rml_state_SP);

	/* parse for the first commands  */
	rmldb_execution_type = rmldb_execution_startup_type;
	/* wait for commands only if the execution startup type is step */
	if (rmldb_execution_startup_type == RMLDB_STEP) rmldb_parse();
 #endif /* RML_DEBUG */
}

/*
adrpo 2002-10 creation
- this function ends the debugging session.
- i didn't find a good time to call it.
*/
int rmldb_end(void)
{
#ifdef RML_DEBUG

#if defined(__MINGW32__) || defined(_MSC_VER)
	if(WSACleanup()) /* cleanup the socket library */
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Error! WSACleanup failed: %s\n", 
				RMLDB_PROMPT, 
				strerror(rmldb_sock_errorno));
#endif
	/*
	printf("%s - breaking just before exit\n", RMLDB_PROMPT);
	rmldb_parse();
	*/
	printf("%s - handing the control to the runtime for exit\n", RMLDB_PROMPT);
 #endif /* RML_DEBUG */
}

void rmldb_show_help(void)
{
	printf("---------------------------------- HELP: COMMANDS -----------------------------------\n");
	printf("Seting/unsetting breakpoints:                    br|break|breakpoint [on|off] string\n");
	printf("Clear all breakpoints:                           cl|clear\n");
	printf("Show all breakpoints:                            sh|show\n");
	printf("Print the backtrace (stack):                     bt|backtrace\n");
	printf("Print filtered backtrace (stack):                fbt|fbacktrace filter\n");
	printf("Set the maximum of backtrace entries (stack):    mb|maxbacktrace integer (0=full, default=0)\n");
	printf("Send the backtrace to external viewer (stack):   gbt|graphbacktrace {WORK IN PROGRESS}\n");
	printf("Send the backtrace to external viewer (stack):   gfbt|graphfilteredbacktrace filter {WORK IN PROGRESS}\n");
	printf("Print the call chain:                            ca|callchain\n");
	printf("Print filtered call chain:                       fca|fcallchain filter\n");
	printf("Set the maximum of callchain entries:            mc|maxcallchain integer (0=full, default=100)\n");
	printf("Send the call chain to external viewer:          gca|graphcallchain {WORK IN PROGRESS}\n");
	printf("Send the call chain to external viewer:          gfca|graphfilteredcallchain filter {WORK IN PROGRESS}\n");
	printf("Set the depth of variable printing:              [set] de|depth integer (0=full, default=10)\n");
	printf("Set how may chars we print from long strings:    [set] ms|maxstring integer (0=full, default=60)\n");
	printf("Set the execution mode:                          set st|step [on|off]\n");
	printf("Perform one step:                                st|step|<ENTER>|<CR>\n");
	printf("Jump over next goal:                             ne|next\n");
	printf("Run the program:                                 ru|run\n");
	printf("Print the current settings:                      stg|settings\n");
	printf("Showing help:                                    he|help\n");
	printf("Printing the status of RML runtime:              sts|stat|status\n");
	printf("Set the output to go to file also:               ou|output file {WORK IN PROGRESS}\n");
	printf("Print the names of live variables:               li|live|livevars\n");
	printf("On/Off printing names of livevars each step:     [set] li|live|livevars on|off\n");
	printf("Print the live variable:                         pr|print var_name\n");
	printf("Print sizeof the live variable:                  sz|size|sizeof var_name\n");
	printf("Display the live variable each step:             di|display var_name\n");
	printf("Un-display the live variable :                   ud|undisplay var_name\n");
	printf("Show display variables:                          di|display\n");
	printf("Un-display ALL display variables:                ud|undisplay\n");
	printf("Send the live variable to external viewer:       gr|graph var_name\n");
	printf("Print type info on any rml id:                   pty|printtype identifier\n");
	printf("FAST debugging, no backtrace,callchain,livevars: fa|fast\n");
	printf("Exiting the debugger/program:                    qu|quit|ex|exit|by|bye\n");
	printf("Debugging/Undebugging the debugger parser:       dbgp|debugparse on|off {aadebug=1/0}\n");
	printf("Debugging/Undebugging the rdb parser:            rdbdbgp|rdbdebugparse on|off {aarmldbdebug=1/0}\n");
	printf("Debugging/Undebugging the socket sending:        dbgsock|debugsocket on|off\n");
	printf("-------------------------------------------------------------------------------------\n");
}

int rmldb_is_quit(char *line)
{
	if (strcmp(line, "quit") == 0 || 
		strcmp(line, "exit") == 0 ||
		strcmp(line, "bye") == 0  ||
		strcmp(line, "hit the road jack") == 0 ||
		strcmp(line, "go away") == 0
		) return 1;
	else return 0;
}

int rmldb_is_help(char *line)
{
	if (strcmp(line, "?") == 0 || 
		strcmp(line, "help") == 0
		) return 1;
	else return 0;
}

void rmldb_add_relation_filter(char *rname)
{
	int i;
	for (i=0; i < rmldb_number_of_filters; i++)
	{
		if (strcmp(rmldb_relation_filter[i], rname) == 0) return;
	}
	if (rmldb_number_of_filters + 1 == RMLDB_MAX_BREAKPOINTS)
	fprintf(stderr, "\nThe debugger can handle only %d breakpoints, clear some", 
					RMLDB_MAX_BREAKPOINTS);
	strncpy(rmldb_relation_filter[rmldb_number_of_filters], rname, RMLDB_MAX_STRING);
	rmldb_number_of_filters++;
	printf("Breakpoint on: [%s] added to breakpoints list.\n", rname); 
}

void rmldb_del_relation_filter(char *rname)
{
	int i;
	for (i=0; i < rmldb_number_of_filters; i++)
	{
		if (strcmp(rmldb_relation_filter[i], rname) == 0) break;
	}
	strcpy(rmldb_relation_filter[i], rmldb_relation_filter[rmldb_number_of_filters-1]);
	rmldb_number_of_filters--;  
	printf("Breakpoint on: [%s] removed from breakpoints list.\n", rname); 
}

unsigned long rmldb_stack_pointer_to_ulong(void* stackPointer)
{
	return (unsigned long)(&rml_stack[rml_stack_size] - (void**)stackPointer);
}

void rmldb_pr_ident(unsigned long depth)
{
	unsigned long i;
	for (i = 0; i < depth; i++) rmldb_sprintf(" ");
}

void rmldb_backtrace_push(char *rname, rmldb_current_execution_loc_t loc)
{
	struct rmldb_stack_node *last;
	int i = 0;
	struct rmldb_stack_node *tmp;

	for(tmp = rmldb_stack_start; tmp; tmp = tmp->next)
	{
		i++;
	}
	if (rmldb_max_backtrace_entries)
	{
		/* get rid of the first entry */
		if (i > rmldb_max_backtrace_entries)
		{
			tmp = rmldb_stack_start;
			if (rmldb_stack_start) 
			{
				if (rmldb_stack_start->next)
					rmldb_stack_start->next->prev = NULL;
				else 
					rmldb_stack_end = NULL;
				rmldb_stack_start = rmldb_stack_start->next;
			}
			free(tmp);
		}
	}
	last = (struct rmldb_stack_node*)malloc(sizeof(struct rmldb_stack_node));
	last->loc = loc;
	if(rmldb_stack_start)
		last->depth = rmldb_stack_end->depth + 1;
	else
	{
		rmldb_stack_start = last;
		last->depth = 0;
	}
	strcpy(last->relation_name, rname);
	last->next = NULL;
	last->prev = rmldb_stack_end;
	if(rmldb_stack_end)
		rmldb_stack_end->next = last;
	rmldb_stack_end = last;
}

void rmldb_backtrace_pop(void)
{
	struct rmldb_stack_node *tmp;
	if (!rmldb_stack_end) return; 
	tmp = rmldb_stack_end;
	if(rmldb_stack_end->prev)
		rmldb_stack_end->prev->next = NULL;
	else
		rmldb_stack_end = rmldb_stack_start = NULL;
	rmldb_stack_end = tmp->prev;
	free(tmp);
}

void rmldb_backtrace_print(char* filter)
{
	int i;
	struct rmldb_stack_node *tmp;
	printf("-------------- STACK ------------\n"); 
	if(!rmldb_stack_start)
		rmldb_sprintf("No stack.\n");
	for(tmp = rmldb_stack_end; tmp; tmp = tmp->prev)
	{
		if (!filter)
		{
			/* rmldb_sprintf("#%.4d sp#%.4d ", tmp->depth, tmp->loc.SP); */
            rmldb_sprintf("#%.4d ", tmp->depth);
			rmldb_sprintf("%s\n", tmp->relation_name);
		}
		else if (strstr(tmp->relation_name, filter) != NULL)
		{
			/* rmldb_sprintf("#%.4d sp#%.4d ", tmp->depth, tmp->loc.SP); */
            rmldb_sprintf("#%.4d ", tmp->depth);
			rmldb_sprintf("%s\n", tmp->relation_name);
		}
		/* fprintf(stderr, "#%d %s \n", tmp->depth, tmp->relation_name); */
	}
	printf("---------------------------------\n");
	printf("NOTE: you can see the also the actual call chain\n");
}	

void rmldb_backtrace_send(char* filter)
{
	int i;
	struct rmldb_stack_node *tmp;
	printf("-------------- STACK ------------\n"); 
	if(!rmldb_stack_start)
		rmldb_sprintf("No stack.\n");
	for(tmp = rmldb_stack_end; tmp; tmp = tmp->prev)
	{
		if (!filter)
		{
			/* rmldb_sprintf("#%.4d sp#%.4d ", tmp->depth, tmp->loc.SP); */
			rmldb_sprintf("#%.4d ", tmp->depth);
			rmldb_pr_ident(tmp->loc.SP);
			rmldb_sprintf("%s\n", tmp->relation_name);
		}
		else if (strstr(tmp->relation_name, filter) != NULL)
		{
			/* rmldb_sprintf("#%.4d sp#%.4d ", tmp->depth, tmp->loc.SP); */
			rmldb_sprintf("#%.4d ", tmp->depth);
			rmldb_pr_ident(tmp->loc.SP);
			rmldb_sprintf("%s\n", tmp->relation_name);
		}
		/* fprintf(stderr, "#%d %s \n", tmp->depth, tmp->relation_name); */
	}
	printf("---------------------------------\n");
}

void rmldb_callchain_push(char *rname, rmldb_current_execution_loc_t loc)
{
	struct rmldb_call_node *last;
	int i = 0;
	struct rmldb_call_node *tmp;

	for(tmp = rmldb_callchain_start; tmp; tmp = tmp->next)
	{
		i++;
	}
	if (rmldb_max_callchain_entries)
	{
		/* get rid of the first entry */
		if (i > rmldb_max_callchain_entries)
		{
			tmp = rmldb_callchain_start;
			if (rmldb_callchain_start) 
			{
				if (rmldb_callchain_start->next)
					rmldb_callchain_start->next->prev = NULL;
				else 
					rmldb_callchain_end = NULL;
				rmldb_callchain_start = rmldb_callchain_start->next;
			}
			free(tmp);
		}
	}
	last = (struct rmldb_call_node*)malloc(sizeof(struct rmldb_call_node));
	last->loc = loc;
	if(rmldb_callchain_start)
		last->depth = rmldb_callchain_end->depth + 1;
	else
	{
		rmldb_callchain_start = last;
		last->depth = 0;
	}
	strncpy(last->relation_name, rname, RMLDB_MAX_STRING);
	last->next = NULL;
	last->prev = rmldb_callchain_end;
	if(rmldb_callchain_end)
		rmldb_callchain_end->next = last;
	rmldb_callchain_end = last;
}

void rmldb_callchain_pop(void)
{
	struct rmldb_call_node *tmp;
	if (!rmldb_callchain_end) return; 
	tmp = rmldb_callchain_end;
	if(rmldb_callchain_end->prev)
		rmldb_callchain_end->prev->next = NULL;
	else
		rmldb_callchain_end = rmldb_callchain_start = NULL;
	rmldb_callchain_end = tmp->prev;
	free(tmp);
}

void rmldb_callchain_print(char* filter)
{
	int i;
	struct rmldb_call_node *tmp;
	printf("-------------- CALLCHAIN ------------\n"); 
	if(!rmldb_callchain_start)
		rmldb_sprintf("No callchain.\n");
	for(tmp = rmldb_callchain_end; tmp; tmp = tmp->prev)
	{
		if (!filter)
		{
			rmldb_sprintf("#%.4d sp#%.4d ", tmp->depth, tmp->loc.SP);
			rmldb_pr_ident(tmp->loc.SP);
			rmldb_sprintf("%s\n", tmp->relation_name);
		}
		else if (strstr(tmp->relation_name, filter) != NULL)
		{
			rmldb_sprintf("#%.4d sp#%.4d ", tmp->depth, tmp->loc.SP);
			rmldb_pr_ident(tmp->loc.SP);
			rmldb_sprintf("%s\n", tmp->relation_name);
		}
		/* fprintf(stderr, "#%d %s \n", tmp->depth, tmp->relation_name); */
	}
	printf("---------------------------------\n");
}

void rmldb_callchain_send(char* filter)
{
	int i;
	struct rmldb_call_node *tmp;
	printf("-------------- STACK ------------\n"); 
	if(!rmldb_callchain_start)
		rmldb_sprintf("No callchain.\n");
	for(tmp = rmldb_callchain_end; tmp; tmp = tmp->prev)
	{
		if (!filter)
		{
			rmldb_sprintf("#%.4d sp#%.4d ", tmp->depth, tmp->loc.SP);
			rmldb_pr_ident(tmp->loc.SP);
			rmldb_sprintf("%s\n", tmp->relation_name);
		}
		else if (strstr(tmp->relation_name, filter) != NULL)
		{
			rmldb_sprintf("#%.4d sp#%.4d ", tmp->depth, tmp->loc.SP);
			rmldb_pr_ident(tmp->loc.SP);
			rmldb_sprintf("%s\n", tmp->relation_name);
		}
		/* fprintf(stderr, "#%d %s \n", tmp->depth, tmp->relation_name); */
	}
	printf("---------------------------------\n");
}

void rmldb_add(struct rmldb_var_node **start_node, 
				   struct rmldb_var_node **end_node, void* var_name, void* var)
{
	struct rmldb_var_node *last;

	last = (struct rmldb_var_node*)malloc(sizeof(struct rmldb_var_node));
	last->var_name = var_name;
	last->var = var;
	if(*start_node)
		last->depth = ((struct rmldb_var_node*)*end_node)->depth + 1;
	else
	{
		*start_node = last;
		last->depth = 0;
	}
	last->next = NULL;
	last->prev = *end_node;
	if(*end_node)
		((struct rmldb_var_node*)*end_node)->next = last;
	*end_node = last;
}

extern void rmldb_add_var(int direction, void* var_name, void* var)
{
	if (direction == RMLDB_VAR_IN)
		rmldb_add(&rmldb_var_in_start, &rmldb_var_in_end, var_name, var);
	if (direction == RMLDB_VAR_OUT)
		rmldb_add(&rmldb_var_out_start, &rmldb_var_out_end, var_name, var);
}

extern void rmldb_clear_vars(void)
{
	struct rmldb_var_node *tmp, *remember;
	if (rmldb_var_in_start && rmldb_var_in_start == rmldb_var_in_end) 
	{
		free (rmldb_var_in_start);
	}
	else 
		for(tmp = rmldb_var_in_start; tmp; tmp = remember) 
		{
			remember = tmp->next;
			free(tmp);
		}
	rmldb_var_in_start = NULL;
	rmldb_var_in_end = NULL;

	if (rmldb_var_out_start && rmldb_var_out_start == rmldb_var_out_end) 
	{
		free (rmldb_var_out_start);
	}
	else 
		for(tmp = rmldb_var_out_start; tmp; tmp = remember) 
		{
			remember = tmp->next;
			free(tmp);
		}
	rmldb_var_out_start = NULL;
	rmldb_var_out_end = NULL;
}

void rmldb_print_vars(void)
{
	struct rmldb_var_node *tmp;
	printf("\nLive variables:");
	printf("Results:");
	if (!rmldb_var_out_start) printf("[none available]");
	for(tmp = rmldb_var_out_start; tmp; tmp = tmp->next)
		printf("[%s] ", RML_STRINGDATA(tmp->var_name));
	printf("   -   Parameters:");
	if (!rmldb_var_in_start) printf("[none available]");
	for(tmp = rmldb_var_in_start; tmp; tmp = tmp->next)
		printf("[%s] ", RML_STRINGDATA(tmp->var_name));
	printf("\n");
}

void rmldb_set_print_vars(int flag)
{
	rmldb_print_livevars_each_step = flag;
	if (rmldb_print_livevars_each_step == RMLDB_LIVEVARS_OFF)
		printf("Print livevars each step set to: OFF\n"); 
	else
		printf("Print livevars each step set to: ON\n"); 
}

void rmldb_trace_vars(void)
{
	struct rmldb_var_node *tmp;
	rmldb_depth_of_variable_print = 0;
	printf("Results:\n");
	if (!rmldb_var_out_start) printf("[none available]\n");
	for(tmp = rmldb_var_out_start; tmp; tmp = tmp->next)
	{
		printf("[%s]", RML_STRINGDATA(tmp->var_name));
		printf("+++++++++++++++++++++++++++++++++\n");
		rmldb_print_variable(RML_STRINGDATA(tmp->var_name));
		printf("*********************************\n");
	}
	printf("Parameters:\n");
	if (!rmldb_var_in_start) printf("[none available]\n");
	for(tmp = rmldb_var_in_start; tmp; tmp = tmp->next)
	{
		printf("[%s]", RML_STRINGDATA(tmp->var_name));
		printf("+++++++++++++++++++++++++++++++++\n");
		rmldb_print_variable(RML_STRINGDATA(tmp->var_name));
		printf("*********************************\n");
	}
	printf("\n");
}

void rmldb_print_variable(char* var_name)
{
	int printed = 0;
	struct rmldb_var_node *tmp;
	rmldb_type_db_t* type_db;
	printf("NOTE that the depth of printing is set to: %d\n", rmldb_depth_of_variable_print);
	printf("Results:");
	for(tmp = rmldb_var_out_start; tmp; tmp = tmp->next)
		if (strcmp(RML_STRINGDATA(tmp->var_name), var_name) == 0)
		{
			printed = 1;
			type_db = rmldb_get_type(var_name);
			if (type_db)
			{
				printf("\nVARIABLE %s HAS TYPE: ", var_name);
				rmldb_print_type(type_db->type, 0, stdout);
				printf("\n");
				if (type_db->type->kind == RMLDB_eVARty)
				{
					rmldb_var_print(tmp->var);
				}
				else
				{
					printf(" %s=", var_name);
					rmldb_var_show(tmp->var, type_db->type, 0);
				}
			}
			else
			{
				printf("\nI couldn't find the type of variable %s! printing without types \n", var_name);
				printf(" %s=", var_name);
				rmldb_var_print(tmp->var);
			}
		}
	if (!printed) printf("[not in current context]");
	printed = 0;
	printf("\nParameters:");
	for(tmp = rmldb_var_in_start; tmp; tmp = tmp->next)
		if (strcmp(RML_STRINGDATA(tmp->var_name), var_name) == 0)
		{
			printed = 1;
			type_db = rmldb_get_type(var_name);
			if (type_db)
			{
				printf("\nVARIABLE %s HAS TYPE: ", var_name);
				rmldb_print_type(type_db->type, 0, stdout);
				printf("\n");
				if (type_db->type->kind == RMLDB_eVARty)
				{
					rmldb_var_print(tmp->var);
				}
				else
				{
					printf(" %s=", var_name);
					rmldb_var_show(tmp->var, type_db->type, 0);
				}
			}
			else
			{
				printf("\nI couldn't find the type of variable %s! printing without types \n", var_name);
				printf(" %s=", var_name);
				rmldb_var_print(tmp->var);
			}

		}
	if (!printed) printf("[not in current context]"); 
	printf("\n");
}

void rmldb_print_sizeof_variable(char* var_name)
{
	int printed = 0;
	struct rmldb_var_node *tmp;
	printf("Results:");
	for(tmp = rmldb_var_out_start; tmp; tmp = tmp->next)
		if (strcmp(var_name, RML_STRINGDATA(tmp->var_name)) == 0)
		{
			printf("[sizeof(%s)=%lu] ", var_name, rmldb_var_sizeof(tmp->var));
			printed = 1;
		}
	if (!printed) printf("[not in current context]");
	printed = 0;
	printf("   -   Parameters:");
	for(tmp = rmldb_var_in_start; tmp; tmp = tmp->next)
		if (strcmp(var_name, RML_STRINGDATA(tmp->var_name)) == 0)
		{
			printf("[sizeof(%s)=%lu] ", var_name, rmldb_var_sizeof(tmp->var));
			printed = 1;
		}
	if (!printed) printf("[not in current context]"); 
	printf("\n");
}

extern void rmldb_display_variable(char* var_name)
{
	int i;
	for (i=0; i < rmldb_number_of_display_vars; i++)
	{
		if (strcmp(rmldb_display_vars[i], var_name) == 0) return;
	}
	if (rmldb_number_of_display_vars + 1 == RMLDB_MAX_DISPLAY_VARS)
	fprintf(stderr, "\nThe debugger can handle only %d display variables, clear some", 
					RMLDB_MAX_DISPLAY_VARS);
	strcpy(rmldb_display_vars[rmldb_number_of_display_vars], var_name);
	rmldb_number_of_display_vars++;
	rmldb_print_variable(var_name);
	printf("Variable: [%s] added to display variable list.\n", var_name); 
}

extern void rmldb_undisplay_variable(char* var_name)
{
	int i;
	for (i=0; i < rmldb_number_of_display_vars; i++)
	{
		if (strcmp(rmldb_display_vars[i], var_name) == 0) break;
	}
	strcpy(rmldb_display_vars[i], rmldb_display_vars[rmldb_number_of_display_vars-1]);
	rmldb_number_of_display_vars--;
	printf("Variable: [%s] removed from display variable list\n", var_name); 
}

void rmldb_print_displayvars(void)
{
	int i = 0;
	if (rmldb_number_of_display_vars == 0) return; /* printf("No display variables are set\n"); */
	for (i=0; i < rmldb_number_of_display_vars; i++)
	{
		printf("display #%d -> %s\n", i, rmldb_display_vars[i]);
		rmldb_print_variable(rmldb_display_vars[i]);
	}
}

void rmldb_show_displayvars(void)
{
	int i = 0;
	printf("------ LIST OF DISPLAY VARIABLES ------\n");
	if (rmldb_number_of_display_vars == 0) printf("No display variables are set\n");
	for (i=0; i < rmldb_number_of_display_vars; i++)
	{
		printf("#%d -> %s\n", i, rmldb_display_vars[i]);
	}
}

void rmldb_clear_displayvars(void)
{
	rmldb_number_of_display_vars=0;
	printf("List of display variables cleared.\n");
}


extern void rmldb_view_variable(char* var_name)
{
	/*
	Java expects something like this!
	new RMLVariableInfo(vName, vType, vFile, vRelation, sl,	sc,	el,	ec, r_sl, r_sc, r_el, r_ec));
	*/
	int printed = 0;
	int found = 0;
	struct rmldb_var_node *tmp;
	rmldb_type_db_t* type_db; rmldb_var_db_t* var_db;
	char buf[RMLDB_MAX_LINE];
	rmldb_open_socket();
	printf("Sending variable %s to external viewer\n", var_name);
	printf("NOTE that the depth of printing is set to: %d\n", rmldb_depth_of_variable_print);
	printf("Results:");
	for(tmp = rmldb_var_out_start; tmp; tmp = tmp->next)
		if (strcmp(RML_STRINGDATA(tmp->var_name), var_name) == 0)
		{
			printed = 1;
			type_db = rmldb_get_type(var_name);
			var_db = rmldb_get_var(var_name);
			if (type_db && var_db)
			{
				printf("\nVARIABLE %s HAS TYPE: ", var_name);
				rmldb_print_type(type_db->type, 0, stdout);
				printf("\nNow sending contents:\n");
				if (type_db->type->kind == RMLDB_eVARty)
				{
					rmldb_var_print(tmp->var);
				}
				else
				{
					printf(" please wait while \"%s\" is send...", var_name);
					fflush(stdout);
					snprintf(buf, RMLDB_MAX_LINE, "%s / print depth: %d", var_name, rmldb_depth_of_variable_print);
					rmldb_socket_outln(buf); 
					rmldb_type_to_sock(type_db->type, 0); 
					rmldb_socket_outln("");
					snprintf(buf, RMLDB_MAX_LINE, "%s", var_db->file);
					rmldb_socket_outln(buf);
					snprintf(buf, RMLDB_MAX_LINE, "%s", var_db->relation);
					rmldb_socket_outln(buf);
					snprintf(buf, RMLDB_MAX_LINE, "%d.%d.%d.%d",
						var_db->range->sl,var_db->range->sc,var_db->range->el,var_db->range->ec);
					rmldb_socket_outln(buf);
					snprintf(buf, RMLDB_MAX_LINE, "%d.%d.%d.%d", 
						var_db->clause_range->sl,
						var_db->clause_range->sc,
						var_db->clause_range->el,
						var_db->clause_range->ec);
					rmldb_socket_outln(buf);
					snprintf(buf, RMLDB_MAX_LINE, "%d.%d.%d.%d", 
						rmldb_current_execution_loc.range.sl,
						rmldb_current_execution_loc.range.sc,
						rmldb_current_execution_loc.range.el,
						rmldb_current_execution_loc.range.ec);
					rmldb_socket_outln(buf);
					rmldb_var_send(tmp->var, type_db->type, 0);
					printf(" variable \"%s\" was sent!", var_name);
					fflush(stdout);
					found = 1;
				}
			}
			else
			{
				printf("\nI couldn't find the type of variable %s! printing without types \n", var_name);
				printf(" %s=", var_name);
				rmldb_var_print(tmp->var);
			}
		}
	if (!printed) printf("[not in current context]");
	printed = 0;
	printf("\nParameters:");
	for(tmp = rmldb_var_in_start; tmp; tmp = tmp->next)
		if (strcmp(RML_STRINGDATA(tmp->var_name), var_name) == 0)
		{
			printed = 1;
			type_db = rmldb_get_type(var_name);
			var_db = rmldb_get_var(var_name);
			if (type_db && var_db)
			{
				printf("\nVARIABLE %s HAS TYPE: ", var_name);
				rmldb_print_type(type_db->type, 0, stdout);
				if (found)
				{
					printf("\nAlready printed at results. No need to print it again!");
					break;
				}
				printf("\nNow sending contents:\n");
				if (type_db->type->kind == RMLDB_eVARty)
				{
					rmldb_var_print(tmp->var);
				}
				else
				{
					printf(" please wait while \"%s\" is send...", var_name);
					fflush(stdout);
					snprintf(buf, RMLDB_MAX_LINE, "%s / print depth: %d", var_name, rmldb_depth_of_variable_print);
					rmldb_socket_outln(buf); 
					rmldb_type_to_sock(type_db->type, 0); 
					rmldb_socket_outln("");
					snprintf(buf, RMLDB_MAX_LINE, "%s", var_db->file);
					rmldb_socket_outln(buf);
					snprintf(buf, RMLDB_MAX_LINE, "%s", var_db->relation);
					rmldb_socket_outln(buf);
					snprintf(buf, RMLDB_MAX_LINE, "%d.%d.%d.%d",
						var_db->range->sl,var_db->range->sc,var_db->range->el,var_db->range->ec);
					rmldb_socket_outln(buf);
					snprintf(buf, RMLDB_MAX_LINE, "%d.%d.%d.%d", 
						var_db->clause_range->sl,
						var_db->clause_range->sc,
						var_db->clause_range->el,
						var_db->clause_range->ec);
					rmldb_socket_outln(buf);
					snprintf(buf, RMLDB_MAX_LINE, "%d.%d.%d.%d", 
						rmldb_current_execution_loc.range.sl,
						rmldb_current_execution_loc.range.sc,
						rmldb_current_execution_loc.range.el,
						rmldb_current_execution_loc.range.ec);
					rmldb_socket_outln(buf);
					rmldb_var_send(tmp->var, type_db->type, 0);
					printf(" variable \"%s\" was sent!", var_name);
					fflush(stdout);
				}
			}
			else
			{
				printf("\nI couldn't find the type of variable %s! printing without types \n", var_name);
				printf(" %s=", var_name);
				rmldb_var_print(tmp->var);
			}

		}
	if (!printed) printf("[not in current context]");
	printf("\n");
	rmldb_close_socket();
}


void rmldb_set_output(char *outputFile)
{
	fprintf(stdout, "The output will go to: %s file also. [NOT IMPLEMENTED YET]\n", outputFile);
}

int rmldb_open_new_file ()
{
	int tty_file_descriptor = open(rmldb_ttyname, O_RDWR);
	if (tty_file_descriptor == -1)
	{
		fprintf(stderr, "reopen of %s failed: %s\n",
			rmldb_ttyname,
			strerror(errno));
	}
	if( !(aain = fdopen(tty_file_descriptor, "rw")) ) 
	{
		fprintf(stderr, "fdopen aain failed: %s\n",
			strerror(errno));
	}
	/* Readline support.  Set both application name and input file. */ 
	rl_readline_name = RMLDB_PROMPT;
	rl_instream = aain;
	return 1;
}

/* What happens if you press CTRL+C  */
/*
unsigned long rmldb_CTRL-C_clock_start = 0;
unsigned long rmldb_CTRL-C_clock_end = 0;
int CTRL-C_times = 0;
*/
void rmldb_use_quit (sig) 
int sig;
{
	/*
	if (CTRL-C_times == 0) 
	{
		rmldb_CTRL-C_clock_start = rmldb_prim_clock();
		CTRL-C_times++;
	}
	else 
	{
		rmldb_CTRL-C_clock_end = rmldb_prim_clock();
		CTRL-C_times++;
	}
	double secs = (double)(rmldb_CTRL-C_clock_end - rmldb_CTRL-C_clock_start) / (double)RMLDB_CLOCKS_PER_SEC;
	if (secs < 2) 
	*/
	printf ("\nCTRL+C encountered. Breaking at next site....\n");
	rmldb_execution_type = RMLDB_STEP;
}


int rmldb_parse(void)
{
	int parse_status = 0;
	do
	{
		while (aaparse() != 0) 
		{
			printf("%s - command error, showing help\n", RMLDB_PROMPT);
			rmldb_show_help();
		}
	}
	while (rmldb_last_command == RMLDB_REPEAT_PARSE);
	return 0;
}


void rmldb_set_depth(char* depth)
{
	rmldb_depth_of_variable_print = atoi(depth);
	printf("Depth of variable print set to: %d successfully\n", rmldb_depth_of_variable_print);
	printf("Set it to 0 (ZERO) if you want full printing\n");
}

void rmldb_set_maxstr(char* maxstr)
{
	rmldb_max_string_variable_print = atoi(maxstr);
	printf("Printing of max: %d chars from strings set succesfully\n", rmldb_max_string_variable_print);
	printf("Set it to 0 (ZERO) if you want full strings printed\n");
}

void rmldb_show_breakpoints(void)
{
	int i = 0;
	printf ("---------- CURRENT BREAKPOINTS ---------\n");
	if (rmldb_number_of_filters == 0) printf("No breakpoints are set\n");
	for (i=0; i < rmldb_number_of_filters; i++)
	{
		printf("#%d -> %s\n", i, rmldb_relation_filter[i]);
	}
}

void rmldb_clear_breakpoints(void)
{
	rmldb_number_of_filters=0;
	printf("Breakpoints list cleared\n");
}

void rmldb_set_max_backtrace(char *maxbt)
{
	rmldb_max_backtrace_entries = atoi(maxbt);
	printf("Maximum number of backtrace entries set to: %d successfully\n", rmldb_max_backtrace_entries);
}

void rmldb_set_max_callchain(char *maxbt)
{
	rmldb_max_callchain_entries = atoi(maxbt);
	printf("Maximum number of call chain entries set to: %d successfully\n", rmldb_max_callchain_entries);
}

void rmldb_print_settings(void)
{
	printf("---------------------CURRENT SETTINGS---------------------------\n");
	printf("max backtrace entries:              %d (full=0, default=0)\n", rmldb_max_backtrace_entries);
	printf("max call chain entries:             %d (full=0, default=100)\n", rmldb_max_callchain_entries);
	printf("depth of variable print:            %d (full=0, default=10)\n", rmldb_depth_of_variable_print);
	printf("cut strings when print at:          %d (full=0, default=60)\n", rmldb_max_string_variable_print);
	if (rmldb_execution_type == RMLDB_STEP) 
	printf("execution type:                     step\n");
	if (rmldb_execution_type == RMLDB_RUN)
	printf("execution type:                     run\n");
	if (rmldb_print_livevars_each_step)
	printf("print names of livevars each step:  true\n");
	else 
	printf("print names of livevars each step:  false\n");
	printf("Variables printed at each step/breakpoint:\n");
	rmldb_show_displayvars();
	printf("breakpoints:\n");
	rmldb_show_breakpoints();
	printf("tty:   %s\n", rmldb_ttyname);
	printf("RML runtime status:\n");
	rmldb_show_status();
	rmldb_print_vars();
	printf("----------------------------------------------------------------\n");
}


extern rmldb_str_t* rmldb_make_rmldb_str(char* name)
{
	rmldb_str_t* rmldb_str_node = (rmldb_str_t*)malloc(sizeof(rmldb_str_t));
	rmldb_str_node->name = name;
	rmldb_str_node->depth = 0;
	rmldb_str_node->next = NULL;
	rmldb_str_node->prev = NULL;
	return rmldb_str_node;
}

extern void rmldb_str_list_add(
					rmldb_str_t **start_node, 
				    rmldb_str_t **end_node, 
					rmldb_str_t *node)
{
	rmldb_str_t *last;
	last = node;
	if(*start_node)
		last->depth = ((rmldb_str_t*)*end_node)->depth + 1;
	else { *start_node = last; last->depth = 0; }
	last->next = NULL;	last->prev = *end_node;
	if(*end_node) ((rmldb_str_t*)*end_node)->next = last;
	*end_node = last;
}

void rmldb_str_list_print(rmldb_str_list_t* list)
{
	rmldb_str_t* tmp;
	fprintf(stderr, "=TYPE_LIST(");
	if (list) 
		for (tmp = list->list_start; tmp; tmp = tmp->next)
		{
			if (tmp->next) fprintf(stderr, "%s, ", tmp->name);
			else fprintf(stderr, "%s", tmp->name);
		}
	fprintf(stderr, ")\n");
}

void rmldb_print_type_info_id(char* id, FILE* out)
{
	rmldb_relation_db_t* tmpr;	rmldb_type_db_t* tmpt;
	rmldb_con_db_t* tmpc;  	rmldb_var_db_t* tmpd;
	if (!id) { fprintf(out, "wrong id\n"); return; }
	/* search in relations, vars, types */
	fprintf(out, "*********** TYPE INFO ON ID: %s *************\n", id);
	/* relations */
	fprintf(out, "- relations");
	for(tmpr = rmldb_relation_db_start; tmpr; tmpr = tmpr->next)
	{
		if (strcmp(id, tmpr->name) == 0)
		{
			fprintf(out, "\n\t+ %s:%d.%d.%d.%d|relation:%s|type:",
				tmpr->file,
				tmpr->range->sl,tmpr->range->sc,tmpr->range->el,tmpr->range->el,
				tmpr->name);
			rmldb_print_type(tmpr->type_db->type, 0, out);
		}
	}
	/* types */
	fprintf(out, "\n- types");
	for(tmpt = rmldb_type_db_start; tmpt; tmpt = tmpt->next)
	{
		/* rmldb_current_execution_loc must be included in type range -> type */
		if (strcmp(id, tmpt->name) == 0)
		{
			fprintf(out, "\n\t+ %s:%d.%d.%d.%d|type:%s|constructors:\n",
				tmpt->file,
				tmpt->range->sl,tmpt->range->sc,tmpt->range->el,tmpt->range->el,
				tmpt->name,
				id);
			rmldb_print_type_constructors(tmpt->name, out);
		}
	}
	/* constructors */
	fprintf(out, "\n- type constructors");
	for(tmpc = rmldb_con_db_start; tmpc; tmpc = tmpc->next)
	{
		if (strcmp(id, tmpc->name) == 0)
		{
			fprintf(out, "\n\t+ %s:%d.%d.%d.%d|constructor:",
				tmpc->file,
				tmpc->range->sl,tmpc->range->sc,tmpc->range->el,tmpc->range->el);
			rmldb_print_type_constructor(tmpc->name, out);
			fprintf(out,"\n");
		}
	}
	/* vars */
	fprintf(out, "\n- variables");
	rmldb_var_db_t* tmpv;
	for(tmpv = rmldb_var_db_start; tmpv; tmpv = tmpv->next)
	{
		if (strcmp(id, tmpv->name) == 0)
		{
			fprintf(out, "\n\t+ %s:%d.%d.%d.%d|relation: %s|clause range: %d.%d.%d.%d|variable: %s has type:",
				tmpv->file,
				tmpv->range->sl,tmpv->range->sc,tmpv->range->el,tmpv->range->el,
				tmpv->relation,
				tmpv->clause_range->sl,tmpv->clause_range->sc,tmpv->clause_range->el,tmpv->clause_range->el,
				id);
			rmldb_print_type(tmpv->type_db->type, 0, out);
		}
	}
	printf("\n*************************************************************\n");
}

void rmldb_type_list_to_list(rmldb_LISTty_t* list, rmldb_str_list_t* lst)
{
	rmldb_type_t* tmp;
	for (tmp = list->list_start; tmp; tmp = tmp->next)
		rmldb_type_to_list(tmp, lst);
}

extern void rmldb_type_to_list(rmldb_type_t *type, rmldb_str_list_t* list)
{
	if (!type) { return; } 
	switch (type->kind)
	{
	case RMLDB_eLISTty:  
		{
			rmldb_type_list_to_list(type->component.l, list);
			break;
		}
	case RMLDB_eVARty:   
		{
			rmldb_str_list_add(
				&list->list_start,
				&list->list_end,
				rmldb_make_rmldb_str(type->component.v->id)); 
			break;
		}
	case RMLDB_eCONSty:  
		{ 
			rmldb_type_list_to_list(type->component.c->list, list);
			rmldb_str_list_add(
				&list->list_start,
				&list->list_end,
				rmldb_make_rmldb_str(type->component.c->id));
			break;
		}
	case RMLDB_eTUPLEty: 
		{ 
			rmldb_type_list_to_list(type->component.t->list, list);
			break;
		}
	case RMLDB_eRELty:   
		{ 
			rmldb_type_list_to_list(type->component.r->list1, list);
			rmldb_type_list_to_list(type->component.r->list2, list);			
			break;
		}
	}
}

void rmldb_print_type_list(rmldb_LISTty_t* list, int detailed, char* separator, FILE* out)
{
	rmldb_type_t* tmp;
	if (!list) { fprintf(out, "()"); return; }
	for (tmp = list->list_start; tmp; tmp = tmp->next)
		if (tmp->next) { rmldb_print_type(tmp, detailed, out); fprintf(out, "%s", separator); }
		else rmldb_print_type(tmp, detailed, out);
}

void rmldb_print_type(rmldb_type_t *type, int detailed, FILE* out)
{
	if (!type) { fprintf(out,"()"); return; } 
	switch (type->kind)
	{
	case RMLDB_eLISTty:  
		{
			if (detailed) fprintf(out, "LISTty(["); 
			else fprintf(out, "[");
			rmldb_print_type_list(type->component.l, detailed, ", ", out);
			if (detailed) fprintf(out, "])"); else fprintf(out, "]");
			break;
		}
	case RMLDB_eVARty:   
		{
			if (detailed) fprintf(out, "VARty(%s)", type->component.v->id);
			else fprintf(out, "%s", type->component.v->id);
			break;
		}
	case RMLDB_eCONSty:  
		{
			if (detailed) fprintf(out, "CONSty([");
			rmldb_print_type_list(type->component.c->list, detailed, ", " , out); 
			if (detailed) fprintf(out, "], %s)", type->component.c->id);
			else if (type->component.c->list && type->component.c->list->list_start) 
					fprintf(out, " %s", type->component.c->id);
			else fprintf(out, "%s", type->component.c->id);
			break;
		}
	case RMLDB_eTUPLEty: 
		{
			if (detailed) fprintf(out, "TUPLEty([");
			else fprintf(out, "(");
			rmldb_print_type_list(type->component.t->list, detailed, " * ", out);
			if (detailed) fprintf(out, "])");
			else fprintf(out, ")");
			break;
		}
	case RMLDB_eRELty:   
		{
			if (detailed) fprintf(out, "RELty(["); else fprintf(out, "(("); 
			rmldb_print_type_list(type->component.r->list1, detailed, ", ",  out);
			if (detailed) fprintf(out, "] => ["); else fprintf(out, ") => (");
			rmldb_print_type_list(type->component.r->list2, detailed, ", ", out);
			if (detailed) fprintf(out, "])"); else fprintf(out, "))");
			break;
		}
	}
}


void rmldb_type_list_to_sock(rmldb_LISTty_t* list, int detailed, char* separator)
{
	char buf[RMLDB_MAX_LINE];
	rmldb_type_t* tmp;
	if (!list) 
	{ 
		snprintf(buf, RMLDB_MAX_LINE, "()");
		rmldb_socket_out(buf);
		return; 
	}
	for (tmp = list->list_start; tmp; tmp = tmp->next)
		if (tmp->next) 
		{ 
			rmldb_type_to_sock(tmp, detailed); 
			snprintf(buf, RMLDB_MAX_LINE, "%s", separator);
			rmldb_socket_out(buf);
		}
		else rmldb_type_to_sock(tmp, detailed);
}

void rmldb_type_to_sock(rmldb_type_t *type, int detailed)
{
	char buf[RMLDB_MAX_LINE];
	if (!type) 
	{ 
		snprintf(buf, RMLDB_MAX_LINE, "()");
		rmldb_socket_out(buf);
		return; 
	} 
	switch (type->kind)
	{
	case RMLDB_eLISTty:  
		{
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "LISTty(["); rmldb_socket_out(buf);
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "["); rmldb_socket_out(buf);
			}
			rmldb_type_list_to_sock(type->component.l, detailed, ", ");
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "])"); rmldb_socket_out(buf);
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "]"); rmldb_socket_out(buf);
			}
			break;
		}
	case RMLDB_eVARty:   
		{
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE, "VARty(%s)", type->component.v->id);
				rmldb_socket_out(buf);
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "%s", type->component.v->id);
				rmldb_socket_out(buf);
			}
			break;
		}
	case RMLDB_eCONSty:  
		{
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "CONSty([");
				rmldb_socket_out(buf);
			}
			rmldb_type_list_to_sock(type->component.c->list, detailed, ", "); 
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "], %s)", type->component.c->id);
				rmldb_socket_out(buf);
			}
			else if (type->component.c->list && type->component.c->list->list_start)
			{
				snprintf(buf, RMLDB_MAX_LINE,  " %s", type->component.c->id);
				rmldb_socket_out(buf);
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "%s", type->component.c->id);
				rmldb_socket_out(buf);
			}
			break;
		}
	case RMLDB_eTUPLEty: 
		{
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "TUPLEty(["); rmldb_socket_out(buf);
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "("); rmldb_socket_out(buf);
			}
			rmldb_type_list_to_sock(type->component.t->list, detailed, " * ");
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "])"); rmldb_socket_out(buf);
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE,  ")"); rmldb_socket_out(buf);
			}
			break;
		}
	case RMLDB_eRELty:   
		{
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "RELty(["); rmldb_socket_out(buf); 
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "(("); rmldb_socket_out(buf);
			}
			rmldb_type_list_to_sock(type->component.r->list1, detailed, ", ");
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE,  "] => ["); rmldb_socket_out(buf);
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE,  ") => ("); rmldb_socket_out(buf);
 			}
			rmldb_type_list_to_sock(type->component.r->list2, detailed, ", ");
			if (detailed) 
			{
				snprintf(buf, RMLDB_MAX_LINE, "])"); rmldb_socket_out(buf); 
			}
			else 
			{
				snprintf(buf, RMLDB_MAX_LINE, "))"); rmldb_socket_out(buf);
			}
			break;
		}
	}
}

extern rmldb_type_db_t* rmldb_get_type(char* var_name)
{
	rmldb_var_db_t* tmp; rmldb_relation_db_t* tmpr;
	for(tmp = rmldb_var_db_start; tmp; tmp = tmp->next)
	{
		/* rmldb_current_execution_loc must be included in variable range -> type */
		if (strcmp(rmldb_current_execution_loc.file, tmp->file) == 0) 
		if (strcmp(rmldb_current_execution_loc.relation, tmp->relation) == 0)
		if (strcmp(var_name, tmp->name) == 0)
		if (rmldb_range_incl(&rmldb_current_execution_loc.range, tmp->clause_range) ==
			RMLDB_RANGE_1IN2)
			return tmp->type_db;
	}
	for(tmpr = rmldb_relation_db_start; tmpr; tmpr = tmpr->next)
	{
		if (strcmp(var_name, tmpr->name) == 0 ||
			strcmp(var_name, (strstr(tmpr->name,".")+1)) == 0)
		{
			return tmpr->type_db;
		}
	}
	return NULL;
}

extern rmldb_var_db_t* rmldb_get_var(char* var_name)
{
	rmldb_var_db_t* tmp; rmldb_relation_db_t* tmpr;
	for(tmp = rmldb_var_db_start; tmp; tmp = tmp->next)
	{
		/* rmldb_current_execution_loc must be included in variable range -> type */
		if (strcmp(rmldb_current_execution_loc.file, tmp->file) == 0) 
		if (strcmp(rmldb_current_execution_loc.relation, tmp->relation) == 0)
		if (strcmp(var_name, tmp->name) == 0)
		if (rmldb_range_incl(&rmldb_current_execution_loc.range, tmp->clause_range) ==
			RMLDB_RANGE_1IN2)
			return tmp;
	}
	return NULL;
}


char* rmldb_get_type_id(rmldb_con_db_t* con_db)
{
	if (con_db->type_db->type->kind == RMLDB_eRELty)
		return con_db->type_db->type->component.r->list2->list_start->component.c->id;
	if (con_db->type_db->type->kind == RMLDB_eCONSty)
		return con_db->type_db->type->component.c->id;
	fprintf(stderr, "ERROR, unexpected type kind %d", con_db->type_db->type->kind);
	return NULL;
}

rmldb_LISTty_t* rmldb_get_type_components(rmldb_con_db_t* con_db)
{
	if (con_db->type_db->type->kind == RMLDB_eRELty)
		return con_db->type_db->type->component.r->list1;
	if (con_db->type_db->type->kind == RMLDB_eCONSty)
		return NULL;
	fprintf(stderr, "ERROR, unexpected type kind %d", con_db->type_db->type->kind);
	return NULL;
}

void rmldb_order_rmldb_con_db(void)
{
	/*
   char *file; int constructor; rmldb_range_db_t* range; char *name;
   rmldb_type_db_t* type_db; int depth;
	*/
	char *buff;
	int seq;
	rmldb_con_db_t *i,*j;
	void *tmp;
	for(j = rmldb_con_db_start; j; j = j->next)
	for(i = j; i; i = i->next)
	{
	    if (!strcmp(i->file, j->file))
		if (rmldb_range_cmp(j->range, i->range) == RMLDB_RANGE_GT)
		{
			/* XXXX fixme! move arround ->prev ->next not the contents */
			tmp = (void*)i->range;
			i->range = j->range;
			j->range = (rmldb_range_db_t*)tmp;

			buff = (char*)malloc(strlen(i->name)+1);
			strcpy(buff, i->name);
			free(i->name);
			i->name = (char*)malloc(strlen(j->name)+1);
			strcpy(i->name,j->name);
			free(j->name);
			j->name = buff;

			tmp = (void*)i->type_db;
			i->type_db = j->type_db;
			j->type_db = (rmldb_type_db_t*)tmp;

			tmp = (void*)i->depth;
			i->depth = j->depth;
			j->depth = (int)tmp;
		}
	}
	/* order over datatypes of the same type */
	seq = 0;
	for(i = rmldb_con_db_start; i; i = i->next)
	{
		if (i->next)
		{
			if (!strcmp(rmldb_get_type_id(i), rmldb_get_type_id(i->next)))
			{
				i->constructor = seq; seq++;
				i->next->constructor = seq;
			}
			else
			{
				if (seq == 0) /* means there is ONLY ONE CONSTRUCTOR in this datatype */
				{
					rmldb_LISTty_t* rmlLISTty_node = rmldb_get_type_components(i);
					/* means is not a constant constructor OR a type > 2 */
					/* must be exactly 1 slot and 1 constructor in the datatype
					 * datatype varTys ident = CONSTRUCTOR tys */
					if (rmlLISTty_node != NULL && rmlLISTty_node->length == 1)  
					{
						i->is_transparent = 1;
						/*
						fprintf(stderr,"TRANSPARENT on %s->%s\n", i->name, rmldb_get_type_id(i));
						*/
					}
				}
				seq = 0;
			}
		}
		else
		{
			if (seq == 0) /* means there is ONLY ONE CONSTRUCTOR in this datatype */
			{
				rmldb_LISTty_t* rmlLISTty_node = rmldb_get_type_components(i);
				/* means is not a constant constructor OR a type > 2 */
				/* must be exactly 1 slot and 1 constructor in the datatype
				 * datatype varTys ident = CONSTRUCTOR tys */
				if (rmlLISTty_node != NULL && rmlLISTty_node->length == 1)  
				{
					i->is_transparent = 1;
					/*
					fprintf(stderr,"TRANSPARENT on %s->%s\n", i->name, rmldb_get_type_id(i));
					*/				
				}
			}
		}
	}
	/*
	fprintf(stderr,"\n---- TYPES----\n");
	for(i = rmldb_con_db_start; i; i = i->next)
	{
		fprintf(stderr,"%s:%d.%d.%d.%d | %s->%s[%d][",
			i->file,
			i->range->sl,i->range->sc,i->range->el,i->range->ec,
			rmldb_get_type_id(i), 
			i->name,
			i->constructor);
		rmldb_print_type_list(rmldb_get_type_components(i), 0, ", ", stderr);
		fprintf(stderr,"]\n");
	}
	*/
}

void rmldb_print_type_constructors(char* type_name, FILE* out)
{
	rmldb_con_db_t *i;
	for(i = rmldb_con_db_start; i; i = i->next)
	{
		rmldb_str_list_t* components;
		components = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
		components->list_start = components->list_end = NULL;
		rmldb_type_to_list(i->type_db->type, components);
		/* 
		rmldb_print_type(i->type_db->type, 1, stderr);
		rmldb_str_list_print(components); 
		*/
		if (components && 
			components->list_start && 
			components->list_end->name)
		{
			if (!strcmp(type_name,
				components->list_end->name))
			{
				fprintf(out, "%s of ", i->name);
				rmldb_print_type_list(rmldb_get_type_components(i), 0, " * ", out);
				fprintf(out, "\n");
			}
		}
		rmldb_str_list_free(components);
	}
}

void rmldb_print_type_constructor(char* constructor_name, FILE* out)
{
	rmldb_con_db_t *i;
	for(i = rmldb_con_db_start; i; i = i->next)
	{
		if (!strcmp(constructor_name, i->name))
		{
			fprintf(out, "%s of ", i->name);
			rmldb_print_type_list(rmldb_get_type_components(i), 0, " * ", out);
			fprintf(out, " => %s", rmldb_get_type_id(i));
		}
	}
}

char* rmldb_get_con_name(rmldb_type_t *type, int constructor)
{
	rmldb_con_db_t *i;
	if (type)
	{
		rmldb_str_list_t* types;
		types = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
		types->list_start = types->list_end = NULL;
		rmldb_type_to_list(type, types);
		/* 
		rmldb_print_type(type, 0, stderr);
		rmldb_str_list_print(types);
		*/
		if (types && types->list_start && types->list_start->name)
		{
			for(i = rmldb_con_db_start; i; i = i->next)
			{
				rmldb_str_list_t* components;
				components = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
				components->list_start = components->list_end = NULL;
				rmldb_type_to_list(i->type_db->type, components);
				/* 
				rmldb_print_type(i->type_db->type, 0, stderr);
				rmldb_str_list_print(components); 
				*/
				if (components && 
					components->list_start && 
					types->list_start->name &&
					components->list_end->name)
				{
					if (!strcmp(types->list_start->name,
						components->list_end->name))
					{
						if (i->constructor == constructor)
							return i->name;
						/*
						if (i->is_transparent)
						{
							return i->name;
						}
						*/
					}
				}
				rmldb_str_list_free(components);
			}
		}
		rmldb_str_list_free(types);
	}
	return NULL;
}

rmldb_con_db_t* rmldb_get_con(rmldb_type_t *type, int constructor)
{
	rmldb_con_db_t *i;
	if (type)
	{
		rmldb_str_list_t* types;
		types = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
		types->list_start = types->list_end = NULL;
		rmldb_type_to_list(type, types);
		/* 
		rmldb_print_type(type, 0, stderr);
		rmldb_str_list_print(types);
		*/
		if (types && types->list_start && types->list_start->name)
		{
			for(i = rmldb_con_db_start; i; i = i->next)
			{
				rmldb_str_list_t* components;
				components = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
				components->list_start = components->list_end = NULL;
				rmldb_type_to_list(i->type_db->type, components);
				/* 
				rmldb_print_type(i->type_db->type, 0, stderr);
				rmldb_str_list_print(components); 
				*/
				if (components && 
					components->list_start && 
					types->list_start->name &&
					components->list_end->name)
				{
					if (!strcmp(types->list_start->name,
						components->list_end->name))
					{
						if (i->constructor == constructor)
							return i;
						/*
						if (i->is_transparent)
						{
							return i->name;
						}
						*/
					}
				}
				rmldb_str_list_free(components);
			}
		}
		rmldb_str_list_free(types);
	}
	return NULL;
}


rmldb_type_t* rmldb_get_type_comp_from_con(rmldb_LISTty_t* list, int index)
{
	rmldb_type_t* tmp;
	if (list) 
		for (tmp = list->list_start; tmp; tmp = tmp->next)
		{
			/*
			uncomment to debug
			fprintf(stderr, "\nINDEX=[%d]-DEPTH=[/%d]->TYPE:", index, tmp->depth); 
			rmldb_print_type(tmp, 0, stderr);
			*/
			if (tmp->depth == index) return tmp;
		}
	return NULL;
}

rmldb_type_t* rmldb_get_type_component(rmldb_type_t *type, int constructor, int index)
{
	rmldb_con_db_t *i;
	if (type)
	{
		rmldb_str_list_t* types;
		types = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
		types->list_start = types->list_end = NULL;
		rmldb_type_to_list(type, types);
		/*
		rmldb_print_type(type, 0, stderr);
		rmldb_str_list_print(types);
		*/
		if (types && types->list_start, types->list_end->name)
		{
			for(i = rmldb_con_db_start; i; i = i->next)
			{
				rmldb_str_list_t* components;
				components = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
				components->list_start = components->list_end = NULL;
				rmldb_type_to_list(i->type_db->type, components);
				/*
				rmldb_print_type(i->type_db->type, 0, stderr);
				rmldb_str_list_print(components);
				*/
				if (components && 
					components->list_start,
					types->list_start->name,
					components->list_end->name)
				{
					if (!strcmp(types->list_start->name,
						components->list_end->name))
					{
						if (i->constructor == constructor)
							return rmldb_get_type_comp_from_con(rmldb_get_type_components(i), index);
						/*
						if (i->is_transparent)
						{
							return rmldb_get_type_component(rmldb_get_type_components(i), 0);
						}
						*/
					}
				}
				rmldb_str_list_free(components);
			}
		}
		rmldb_str_list_free(types);
	}
	return NULL;
}


int rmldb_is_type_transparent(rmldb_type_t *type)
{
	rmldb_con_db_t *i;
	if (type)
	{
		rmldb_str_list_t* types;
		types = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
		types->list_start = types->list_end = NULL;
		rmldb_type_to_list(type, types);
		/*
		rmldb_print_type(type, 0, stderr);
		rmldb_str_list_print(types);
		*/
		if (types && types->list_start, types->list_end->name)
		{
			for(i = rmldb_con_db_start; i; i = i->next)
			{
				rmldb_str_list_t* components;
				components = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
				components->list_start = components->list_end = NULL;
				rmldb_type_to_list(i->type_db->type, components);
				/*
				rmldb_print_type(i->type_db->type, 0, stderr);
				rmldb_str_list_print(components);
				*/
				if (components && 
					components->list_start,
					types->list_start->name,
					components->list_end->name)
				{
					if (!strcmp(types->list_start->name,
						components->list_end->name))
					{
						if (i->is_transparent)
						{
							return 1;
						}
					}
				}
				rmldb_str_list_free(components);
			}
		}
		rmldb_str_list_free(types);
	}
	return 0;
}

extern int rmldb_str_list_get_size(rmldb_str_list_t* list)
{
	if (!list->list_end) return 0;
	return list->list_end->depth;
}

extern char* rmldb_str_list_get_index(rmldb_str_list_t* list, int index)
{
	rmldb_str_t* tmp;
	for (tmp = list->list_start; tmp; tmp = tmp->next)
		if(tmp->depth == index) return tmp->name;
	return NULL;
}

void rmldb_str_list_free(rmldb_str_list_t* list)
{
	rmldb_str_t* tmp, *temp;
	tmp = list->list_start;
	while (tmp)
	{
		temp = tmp;
		tmp = tmp->next;
		free(temp);
	}
	free(list);
}

void rmldb_print_increment(int depth)
{
	int d = 0;
	while(d < depth) { rmldb_sprintf(" "); d++; }
}

rmldb_type_t* rmldb_type_unfold(rmldb_type_t* type)
{
	return type->component.c->list->list_start;
}

void rmldb_var_show(void *p, rmldb_type_t* type, int depth)
{
	int remeber = 0;
	/* un-comment if you need debugging */
	/*
	if (type) 
	{ 
		fprintf(stdout,"\nTYPE="); 
		rmldb_print_type(type, 0, stdout); 
		fprintf(stdout,"\n");
	}
	else
	{
		fprintf(stdout,"\nTYPE=NULL");
		fprintf(stdout,"\n");
	}
	*/
	/* if we reached the depth, (if is not 0 = max) exit */
	if (rmldb_depth_of_variable_print && depth > rmldb_depth_of_variable_print) return; 
	if (type && type->kind == RMLDB_eVARty) type = NULL;
	/* oh, shit, another problem, TRANSPARENT SHIT, we should forbid this stuff */
	if (rmldb_is_type_transparent(type))
	{
		rml_uint_t ctor = 0;
		struct rml_struct *po = (void*)malloc(2*sizeof(void*));
		po->header = RML_STRUCTHDR(1, ctor);
		po->data[0] = p;
		p = RML_TAGPTR(po);
		/* fprintf(stdout,"TYPE IS TRANSPARENT\n"); fprintf(stdout,"\n"); */
		/* damn, I need to think at a way to free this indirection */
		remeber = 1;
	}
	rmldb_print_increment(depth);

	if( RML_ISIMM(p) ) 
	{
		if (type)
		{
			if(type->kind==RMLDB_eCONSty && !strcmp(type->component.c->id, "bool"))
			{
				if (RML_UNTAGFIXNUM(p))
					rmldb_sprintf ("true:%s", type->component.c->id);
				else
					rmldb_sprintf ("false:%s", type->component.c->id);
			}
			else if(type->kind==RMLDB_eCONSty && strcmp(type->component.c->id, "int"))
			{
				/* enumtype??? */
				char *con_name = NULL;
				con_name = rmldb_get_con_name(type, RML_UNTAGFIXNUM(p));
				if (con_name) 
					rmldb_sprintf ("%d:enum:%s", RML_UNTAGFIXNUM(p),con_name);
				else rmldb_sprintf ("%d:int", RML_UNTAGFIXNUM(p));
			}
			else
				if(type->kind==RMLDB_eRELty)
				{
					rmldb_sprintf ("%p:function (same module)", p);
					fprintf(stdout,":"); 
					rmldb_print_type(type, 0, stdout); 
					fprintf(stdout,"\n");
				}
				else
					rmldb_sprintf ("%d:int", RML_UNTAGFIXNUM(p));
		}
		else rmldb_sprintf ("%d:int", RML_UNTAGFIXNUM(p));
	} 
	else 
	{
		rml_uint_t phdr = RML_GETHDR(p);            
		if( phdr == RML_REALHDR ) 
		{
			rmldb_sprintf ("%f:real", rml_prim_get_real(p));
			fflush(stdout);
		} else 
			if( RML_HDRISSTRING(phdr) ) 
			{
				if (rmldb_max_string_variable_print)
				{
					if (rmldb_max_string_variable_print >= RML_HDRSTRLEN(phdr))
						rmldb_sprintf ("\"%s\":string", RML_STRINGDATA(p)); 
					else
					{
						char format[100];
						snprintf(format, 100, "\"%c%c%d%c\"...:string", '%', '.', rmldb_max_string_variable_print, 's');
						rmldb_sprintf(format, RML_STRINGDATA(p));
					}
				}
				else rmldb_sprintf ("\"%s\":string", RML_STRINGDATA(p));
				fflush(stdout);
					/* use if neccesarry RML_HDRSTRLEN(phdr) */
			} 
			else 
			{
				if( RML_HDRISSTRUCT(phdr) ) 
				{
					rmldb_str_list_t* components;
					char* con_name;
					rml_uint_t slots = RML_HDRSLOTS(phdr);
					rml_uint_t constr = RML_HDRCTOR(phdr);
					int suffix = RMLDB_TYPE_SUFFIX_NONE; /* 1-lists, 2-option, 3-lvar */
					if(type && type->kind==RMLDB_eRELty) /* deal with function pointers */
					{
						rmldb_sprintf ("%p:function (external module)", p);
						fprintf(stdout,":"); 
						rmldb_print_type(type, 0, stdout); 
						fprintf(stdout,"\n");
						return;
					}
					if (type && type->kind == RMLDB_eTUPLEty)
					{
						int i;
						rmldb_sprintf ("(");
						void **pp = RML_STRUCTDATA(p);
						for (i = 0; i < slots; i++)
						{
							/* tree like display please */
							rmldb_sprintf ("\n");
							rmldb_var_show(*pp++, 
								rmldb_get_type_comp_from_con(type->component.t->list, i), 
								depth+1);
							if (i < slots-1) rmldb_sprintf (" * ");
							fflush(stdout);
						}
						rmldb_sprintf (")"); fflush(stdout);
						return;
					}
					if (type && type->kind == RMLDB_eLISTty)
					{
						int i;
						rmldb_sprintf ("(");
						void **pp = RML_STRUCTDATA(p);
						for (i = 0; i < slots; i++)
						{
							/* tree like display please */
							rmldb_sprintf ("\n");
							rmldb_var_show(*pp++, 
								rmldb_get_type_comp_from_con(type->component.l, i), 
								depth+1);
							if (i < slots-1) rmldb_sprintf (" * ");
							fflush(stdout);
						}
						rmldb_sprintf (")"); fflush(stdout);
						return;
					}
					if (type)
					{
						components = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
						components->list_start = components->list_end = NULL;
						rmldb_type_to_list(type, components);
						/*
						rmldb_print_type(type, 0, stderr);
						rmldb_str_list_print(components);
						*/
						/*
						RML_STRUCTHDR(slots,ctor);
						#define RML_NILHDR		RML_STRUCTHDR(0,0)
						#define RML_CONSHDR		RML_STRUCTHDR(2,1)
						*/
						if (components->list_end->name)
						{
							if (!strcmp(components->list_end->name, "list"))   
							{
								suffix = RMLDB_TYPE_SUFFIX_LIST;
							}
							if (!strcmp(components->list_end->name, "option")) 
							{
								suffix = RMLDB_TYPE_SUFFIX_OPTION;
							}
							if (!strcmp(components->list_end->name, "vector")) 
							{
								suffix = RMLDB_TYPE_SUFFIX_VECTOR;
							}
							if (!strcmp(components->list_end->name, "array")) 
							{
								suffix = RMLDB_TYPE_SUFFIX_ARRAY;
							}
							if (!strcmp(components->list_end->name, "lvar"))   
							{
								suffix = RMLDB_TYPE_SUFFIX_LVAR;
							}
						}
					}
					/* rmldb_sprintf ("S(%d)[%d]=", constr, slots); */
					if (suffix == RMLDB_TYPE_SUFFIX_NONE)
					{
						con_name = rmldb_get_con_name(type, constr);
						if (con_name) 
						{
							if (slots == 0)
								rmldb_sprintf ("%s[%d]", con_name, slots);
							else
								rmldb_sprintf ("%s[%d](", con_name, slots);
						}
					}
					else 
					{
						if ((suffix != RMLDB_TYPE_SUFFIX_VECTOR) &&
							(suffix != RMLDB_TYPE_SUFFIX_ARRAY))
						{
							if (slots == 0 && constr == 0) 
							{
								rmldb_sprintf ("NIL");
							}
							else
							/* if we haven't found the CONSTRUCTOR NAME print it as it is */
							if (slots == 2 && constr == 1) 
							{ 
								/* rmldb_sprintf("RML.cons("); */
								suffix = RMLDB_TYPE_SUFFIX_LIST;
							}
							else 
								if (slots == 1 && constr == 1) 
								{ 
									/* rmldb_sprintf("RML.SOME("); */
									suffix = RMLDB_TYPE_SUFFIX_OPTION;
								}
							else if (!remeber)/* fall to the most miserable case */ 
									rmldb_sprintf ("S(%d)[%d](", constr, slots);
						}
					}
					void **pp = RML_STRUCTDATA(p);
					fflush(stdout);
					/* function definition  - check this here by the variable type
					   if is a function then is RELty as type !!!!! */
					if ((constr == 64 || constr==13) &&
						slots > 1000000) return;
					if( slots != 0 )
					{
						int i = 0; 
						/* treat here vectors separately */
						if (suffix == RMLDB_TYPE_SUFFIX_VECTOR)
						{
							rmldb_sprintf ("VECTOR[%d]{", slots);
							for (i = 0; i < slots; i++)
							{
								/* tree like display please */
								rmldb_sprintf ("{\n");
								rmldb_var_show(*pp++, 
									rmldb_type_unfold(type), 
									depth+1);
								if (i < slots-1) rmldb_sprintf ("},");
								else rmldb_sprintf ("}");
								fflush(stdout);
							}
							rmldb_sprintf ("}");
							fflush(stdout);
							return;
						}
						/* treat here arrays separately */
						if (suffix == RMLDB_TYPE_SUFFIX_ARRAY)
						{
							rmldb_sprintf ("ARRAY[%d]{", slots);
							for (i = 0; i < slots; i++)
							{
								/* tree like display please */
								rmldb_sprintf ("{\n");
								rmldb_var_show(*pp++, 
									rmldb_type_unfold(type), 
									depth+1);
								if (i < slots-1) rmldb_sprintf ("},");
								else rmldb_sprintf ("}");
								fflush(stdout);
							}
							rmldb_sprintf ("}");
							fflush(stdout);
							return;
						}
						/* treat here lists separately */
						if (suffix == RMLDB_TYPE_SUFFIX_LIST)
						{
							/*
							#define RML_NILHDR		RML_STRUCTHDR(0,0)
							#define RML_CONSHDR		RML_STRUCTHDR(2,1)
							*/
							rmldb_sprintf ("[");
							while (phdr == RML_CONSHDR)
							{
								void *pcar = RML_CAR(p);
								void *pcdr = RML_CDR(p);
								/* list = RML.cons(car, cdr) | RML.nil */
								/* cdr */
								phdr = RML_GETHDR(pcdr);
								rmldb_sprintf ("\n");
								/* print car */
								rmldb_var_show(pcar, 
									rmldb_type_unfold(type), 
									depth+1);
								if (phdr == RML_CONSHDR) 
								{
									rmldb_sprintf (",");
									/* print cdr 
									rmldb_var_show(*pcdr, 
										type, 
										depth+1);
									*/
									p = pcdr;
								}
							}
							rmldb_sprintf ("]");
							fflush(stdout);
							return;
						}
						/* treat option separate also */
						if (suffix == RMLDB_TYPE_SUFFIX_OPTION)
						{
							if (phdr == RML_NILHDR) /* NONE */
							{
								rmldb_sprintf ("NONE");
							}
							else
							{
								/* phdr = RML_STRUCTHDR(1,1) = SOME(x) */
								void **pcar = RML_STRUCTDATA(p);
								rmldb_sprintf ("SOME(\n");
								/* pcar++; */
								rmldb_var_show(*pcar, 
									rmldb_type_unfold(type), 
									depth+1);
								rmldb_sprintf (")");
							}
							fflush(stdout);
							return;
						}
						/* treat option separate also */
						if (suffix == RMLDB_TYPE_SUFFIX_LVAR)
						{
							/* actually should not happen here */
							rmldb_sprintf ("LVAR?!?!?");
							return;
						}
						/* the last case DATATYPES */
						for (i = 0; i < slots; i++)
						{
							/* tree like display please */
							rmldb_sprintf ("\n");
							rmldb_var_show(*pp++, 
								rmldb_get_type_component(type, constr, i), 
								depth+1);
							if (i < slots-1) rmldb_sprintf (",");
							fflush(stdout);
						}
						if (remeber) 
						{
							/* we can free the p now here */
							free (RML_UNTAGPTR(p));
							remeber = 0;
						}
						rmldb_sprintf (")"); fflush(stdout);
					}					    
				} 
				else 
				{
					rmldb_sprintf ("LVAR(UNKNOWN)"); fflush(stdout);
				}
			}
	}
}

void rmldb_init_sockaddr (struct sockaddr_in *name, const char *hostname, int port)
{
  struct hostent *hostinfo;
  name->sin_family = AF_INET;
  name->sin_port = htons (port);
  hostinfo = gethostbyname (hostname);
  if (hostinfo == NULL)
  {
      fprintf (stderr, "Unknown host %s.\n", hostname);
      return;
  }
  name->sin_addr = *(struct in_addr *) hostinfo->h_addr;
}

void rmldb_open_socket(void)
{
	int port=9999; 
	char* hostname ="localhost";
	/* Create the socket. */
	if (rmldb_external_server_sock_status) 
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Warning! Socket already opened. \n", 
				RMLDB_PROMPT);
		return;
	}
	rmldb_external_server_sock = socket (PF_INET, SOCK_STREAM, 0);
	if (rmldb_external_server_sock == INVALID_SOCKET)
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Error! socket opening failed: %s\n", 
				RMLDB_PROMPT, 
				strerror(rmldb_sock_errorno));
		rmldb_external_server_sock_status = 0;
		return;
	}
	struct sockaddr_in servername;
	rmldb_init_sockaddr (&servername, hostname, port);
	if (SOCKET_ERROR == connect (rmldb_external_server_sock, (struct sockaddr *) &servername, sizeof (servername)))
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Error! socket connect failed: %s. Is the external viewer started?\n", 
				RMLDB_PROMPT, 
				strerror(rmldb_sock_errorno));
		rmldb_external_server_sock_status = 0;
		return;
	} 
	rmldb_external_server_sock_status = 1;
	if (rmldb_sock_debug) 
		fprintf(stderr, "%s Info! socket opened and connected\n", 
			RMLDB_PROMPT);
}

void rmldb_close_socket(void)
{
	int result;
	if (rmldb_external_server_sock_status) 
	{
		rmldb_socket_outln("<.$STOP$.>");
		rmldb_external_server_sock_status = 0;
		result = rmldb_close_sock(rmldb_external_server_sock);
		if (result == SOCKET_ERROR)
		{
			if (rmldb_sock_debug) 
				fprintf(stderr, "%s Error! socket closing failed: %s.\n", 
					RMLDB_PROMPT, 
					strerror(rmldb_sock_errorno));
		}
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Info! socket closed.\n", 
				RMLDB_PROMPT);
	}
	else
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Warning! socket already closed.\n", 
				RMLDB_PROMPT);
	}
}

void rmldb_socket_outln(char *msg)
{
	char buf[RMLDB_MAX_LINE+2];
	int length = 0;
	snprintf(buf, RMLDB_MAX_LINE, "%s\n", msg);
	if (!rmldb_external_server_sock_status)	
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Warning! socket is closed. Could not send: %s", 
				RMLDB_PROMPT,
				buf);
		return;
	}
	length = rmldb_send_sock(rmldb_external_server_sock, buf, strlen(buf));
	if (length == SOCKET_ERROR)
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Error! socket send failed: %s. Could not send: %s", 
				RMLDB_PROMPT,
				strerror(rmldb_sock_errorno),
				buf);
		rmldb_external_server_sock_status = 0;
		return;
	}
	if (length != strlen(buf))
	{
		rmldb_external_server_sock_status = 0;
		return;
	}
	if (rmldb_sock_debug) 
		fprintf(stderr, "%s Info! socket sent message: %s", 
			RMLDB_PROMPT,
			buf);
	length = rmldb_recv_sock(rmldb_external_server_sock, buf, RMLDB_MAX_LINE);
	if (length == SOCKET_ERROR)
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Error! socket recv message: %s", 
				RMLDB_PROMPT,
				strerror(rmldb_sock_errorno));
		rmldb_external_server_sock_status = 0;
		buf[0] = '\0';
		return;
	}
	buf[length] = '\0';
	if (rmldb_sock_debug) 
		fprintf(stderr, "%s Info! socket recv message of acknowledge from server successfully\n", 
			RMLDB_PROMPT);
}

void rmldb_socket_out(char *msg)
{
	int length = 0;
	if (!rmldb_external_server_sock_status)
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Warning! socket is closed. Could not send: %s\n", 
				RMLDB_PROMPT,
				msg);
		return;
	}
	length = send(rmldb_external_server_sock, msg, strlen(msg), 0);
	if (length == SOCKET_ERROR)
	{
		if (rmldb_sock_debug) 
			fprintf(stderr, "%s Error! socket send failed: %s. Could not send: %s\n", 
				RMLDB_PROMPT,
				strerror(rmldb_sock_errorno),
				msg);
		rmldb_external_server_sock_status = 0;
		return;
	}
	if (length != strlen(msg))
	{
		rmldb_external_server_sock_status = 0;
		return;
	}
	if (rmldb_sock_debug) 
		fprintf(stderr, "%s Info! socket sent message: %s\n", 
			RMLDB_PROMPT,
			msg);
}



void rmldb_send_increment(int depth)
{
	/*
	int d = 0;
	while(d < depth) { rmldb_socket_outln(" "); d++; }
	*/
}

void rmldb_var_send(void *p, rmldb_type_t* type, int depth)
{
	/*
	java expects this!
	depth|ty|vName|vType|vFile|sl.sc.el.ec\n
	where ty:
	  st<ring>,
	  da<tatype constructor>,
	  tu<ple>,
	  li<st>,
	  en<enum>,
	  op<option>,
	  lv<ar>,
	  re<al>,
	  in<t>,
	  bo<olean>
	  fu<nction>
	  ve<ctor>
	*/
	char line[RMLDB_MAX_LINE];
	int remeber = 0;
	if (!rmldb_external_server_sock_status) return;
	/* if we reached the depth, (if is not 0 = max) exit */
	if (rmldb_depth_of_variable_print && depth > rmldb_depth_of_variable_print) return; 
	if (type && type->kind == RMLDB_eVARty) type = NULL;
	/* oh, shit, another problem, TRANSPARENT SHIT, we should forbid this stuff */
	/* debug if (type ) rmldb_print_type(type, 1, stderr); */
	if (rmldb_is_type_transparent(type))
	{
		unsigned ctor = 0;
		struct rml_struct *po = (void*)malloc(2*sizeof(void*));
		po->header = RML_STRUCTHDR(1, ctor);
		po->data[0] = p;
		p = RML_TAGPTR(po);
		/* fprintf(stdout,"TYPE IS TRANSPARENT\n"); fprintf(stdout,"\n"); */
		/* damn, I need to think at a way to free this indirection */
		remeber = 1;
	}
	if( RML_ISIMM(p) ) 
	{
		if (type)
		{
			if(type->kind==RMLDB_eCONSty && !strcmp(type->component.c->id, "bool"))
			{
				if (RML_UNTAGFIXNUM(p))
				{
					snprintf(line, RMLDB_MAX_LINE, "%d|bo|true|%s|RML|0.0.0.0", depth, type->component.c->id);
					rmldb_socket_outln(line);
				}
				else
				{
					snprintf(line, RMLDB_MAX_LINE, "%d|bo|false|%s|RML|0.0.0.0", depth, type->component.c->id);
					rmldb_socket_outln(line);
				}
			}
			else if(type->kind==RMLDB_eCONSty && strcmp(type->component.c->id, "int") != 0)
			{
				/* enumtype??? */
				rmldb_con_db_t *con = NULL;
				con = rmldb_get_con(type, RML_UNTAGFIXNUM(p));
				if (con)
				{
					snprintf(line, RMLDB_MAX_LINE,"%d|en|%d:enum:%s|", depth, RML_UNTAGFIXNUM(p), con->name);
					rmldb_socket_out(line);
					rmldb_type_to_sock(con->type_db->type, 0);
					snprintf(line, RMLDB_MAX_LINE,"|%s|%d.%d.%d.%d", 
						con->file,
						con->range->sl,
						con->range->sc,
						con->range->el,
						con->range->ec);
					rmldb_socket_outln(line);
				}
				else 
				{
					snprintf(line, RMLDB_MAX_LINE,"%d|in|%d|int|RML|0.0.0.0", depth, RML_UNTAGFIXNUM(p));
					rmldb_socket_outln(line);
				}
			}
			else
				if(type->kind==RMLDB_eRELty)
				{
					snprintf(line, RMLDB_MAX_LINE,"%d|fu|%p:function (same module)|", depth, p); 
					rmldb_socket_out(line);
					rmldb_type_to_sock(type, 0);
					snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
					rmldb_socket_outln(line);
				}
				else
				{
					snprintf(line, RMLDB_MAX_LINE,"%d|in|%d|int|RML|0.0.0.0", depth, RML_UNTAGFIXNUM(p));
					rmldb_socket_outln(line);
				}
		}
		else 
		{
			snprintf(line, RMLDB_MAX_LINE,"%d|in|%d|int|RML|0.0.0.0", depth, RML_UNTAGFIXNUM(p));
			rmldb_socket_outln(line);
		}
	} 
	else 
	{
		rml_uint_t phdr = RML_GETHDR(p);            
		if( phdr == RML_REALHDR ) 
		{
			snprintf(line, RMLDB_MAX_LINE,"%d|re|%f|real|RML|0.0.0.0", depth, rml_prim_get_real(p));
			rmldb_socket_outln(line);
		} else 
			if( RML_HDRISSTRING(phdr) ) 
			{
				int idx = 0;
				snprintf(line, RMLDB_MAX_LINE,"%d|st|STRING|string|RML|0.0.0.0", depth);
				rmldb_socket_outln(line);
				/* send all the string data, you can do htmlPane.setText(data) in java */
				rmldb_socket_outln("<.$STRING_START$.>");
				if (RML_HDRSTRLEN(phdr) <= RMLDB_MAX_LINE)
				{
					rmldb_socket_out(RML_STRINGDATA(p));
				}
				else
				{
					for (idx = 0; idx < RML_HDRSTRLEN(phdr); idx++)
					{
						sprintf(line, "%c", RML_STRINGDATA(p)[idx]); 
						rmldb_socket_out(line);
					}
				}
				rmldb_socket_out("\n");
				rmldb_socket_outln("<.$STRING_END$.>");
			} 
			else 
			{
				if( RML_HDRISSTRUCT(phdr) ) 
				{
					int i = 0; 
					rmldb_str_list_t* components;
					char* con_name;
					rml_uint_t slots = RML_HDRSLOTS(phdr);
					rml_uint_t constr = RML_HDRCTOR(phdr);
					int suffix = RMLDB_TYPE_SUFFIX_NONE; /* 1-lists, 2-option, 3-lvar */
					if(type && type->kind==RMLDB_eRELty) /* deal with function pointers */
					{
						snprintf(line, RMLDB_MAX_LINE, "%d|fu|%p:function (external module)|", depth, p);
						rmldb_socket_out(line);
						rmldb_type_to_sock(type, 0);
						snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
						rmldb_socket_outln(line);
						return;
					}
					if (type && (type->kind == RMLDB_eTUPLEty || type->kind == RMLDB_eLISTty))
					{
						int i;
						snprintf(line, RMLDB_MAX_LINE,"%d|tu|TUPLE[%d](%d)|", depth, slots, type->kind);
						rmldb_socket_out(line);
						rmldb_type_to_sock(type, 0);
						snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
						rmldb_socket_outln(line);
						void **pp = RML_STRUCTDATA(p);
						for (i = 0; i < slots; i++)
						{
							if (type->kind == RMLDB_eTUPLEty)
							{
							  rmldb_var_send(*pp++, 
								rmldb_get_type_comp_from_con(type->component.t->list, i), 
								depth+1);
							}
							if (type->kind == RMLDB_eLISTty)
							{
							  rmldb_var_send(*pp++, 
								rmldb_get_type_comp_from_con(type->component.l, i), 
								depth+1);
							}							
						}
						return;
					}
					if (type)
					{
						components = (rmldb_str_list_t*)malloc(sizeof(rmldb_str_list_t));
						components->list_start = components->list_end = NULL;
						rmldb_type_to_list(type, components);
						/*
						rmldb_print_type(type, 0, stderr);
						rmldb_str_list_print(components);
						*/
						/*
						RML_STRUCTHDR(slots,ctor);
						#define RML_NILHDR		RML_STRUCTHDR(0,0)
						#define RML_CONSHDR		RML_STRUCTHDR(2,1)
						*/
						if (components->list_end->name)
						{
							if (!strcmp(components->list_end->name, "list"))   
							{
								suffix = RMLDB_TYPE_SUFFIX_LIST;
							}
							if (!strcmp(components->list_end->name, "option")) 
							{
								suffix = RMLDB_TYPE_SUFFIX_OPTION;
							}
							if (!strcmp(components->list_end->name, "vector")) 
							{
								suffix = RMLDB_TYPE_SUFFIX_VECTOR;
							}
							if (!strcmp(components->list_end->name, "array")) 
							{
								suffix = RMLDB_TYPE_SUFFIX_ARRAY;
							}
							if (!strcmp(components->list_end->name, "lvar"))   
							{
								suffix = RMLDB_TYPE_SUFFIX_LVAR;
							}
						}
					}
					void **pp = RML_STRUCTDATA(p);
					/* function definition  - check this here by the variable type
					   if is a function then is RELty as type !!!!! */
					if ((constr == 64 || constr==13) && slots > 1000000) return;
					/* treat here vectors separately */
					if (suffix == RMLDB_TYPE_SUFFIX_VECTOR)
					{
						snprintf(line, RMLDB_MAX_LINE,"%d|ve|VECTOR[%d]|", depth, slots);
						rmldb_socket_out(line);
						rmldb_type_to_sock(type, 0);
						snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
						rmldb_socket_outln(line);
						for (i = 0; i < slots; i++)
						{
							rmldb_var_send(*pp++, 
								rmldb_type_unfold(type), 
								depth+1);
						}
						return;
					}
					/* treat here arrays separately */
					if (suffix == RMLDB_TYPE_SUFFIX_ARRAY)
					{
						snprintf(line, RMLDB_MAX_LINE,"%d|ar|ARRAY[%d]|", depth, slots);
						rmldb_socket_out(line);
						rmldb_type_to_sock(type, 0);
						snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
						rmldb_socket_outln(line);
						for (i = 0; i < slots; i++)
						{
							rmldb_var_send(*pp++, 
								rmldb_type_unfold(type), 
								depth+1);
						}
						return;
					}
					/* treat here lists separately */
					if (suffix == RMLDB_TYPE_SUFFIX_LIST)
					{
						/*
						#define RML_NILHDR		RML_STRUCTHDR(0,0)
						#define RML_CONSHDR		RML_STRUCTHDR(2,1)
						*/
						if (phdr == RML_CONSHDR) 
							snprintf(line, RMLDB_MAX_LINE,"%d|li|LIST|", depth);
						else /* nil header */
							snprintf(line, RMLDB_MAX_LINE,"%d|li|NIL|", depth);
						rmldb_socket_out(line);
						rmldb_type_to_sock(type, 0);
						snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
						rmldb_socket_outln(line);							
						while (phdr == RML_CONSHDR)
						{
							void *pcar = RML_CAR(p);
							void *pcdr = RML_CDR(p);
							/* list = RML.cons(car, cdr) | RML.nil */
							/* cdr */
							phdr = RML_GETHDR(pcdr);
							/* print car */
							rmldb_var_send(pcar, 
								rmldb_type_unfold(type), 
								depth+1);
							if (phdr == RML_CONSHDR) 
							{
								p = pcdr;
							}
							else /* nil hdr */
							{
								/* do not send nil, is no need
								snprintf(line, RMLDB_MAX_LINE,"%d|li|LIST_END|", depth);
								rmldb_socket_out(line);
								rmldb_type_to_sock(type, 0);
								snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0");
								rmldb_socket_outln(line);
								*/
							}
						}
						return;
					}
					/* treat option separate also */
					if (suffix == RMLDB_TYPE_SUFFIX_OPTION)
					{
						if (phdr == RML_NILHDR) /* NONE */
						{
							snprintf(line, RMLDB_MAX_LINE,"%d|op|NONE[0]|", depth);
							rmldb_socket_out(line);
							rmldb_type_to_sock(type, 0);
							snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
							rmldb_socket_outln(line);							
						}
						else
						{
							/* phdr = RML_STRUCTHDR(1,1) = SOME(x) */
							void **pcar = RML_STRUCTDATA(p);
							snprintf(line, RMLDB_MAX_LINE,"%d|op|SOME[1]|", depth);
							rmldb_socket_out(line);
							rmldb_type_to_sock(type, 0);
							snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
							rmldb_socket_outln(line);							
							/* pcar++; */
							rmldb_var_send(*pcar, 
								rmldb_type_unfold(type), 
								depth+1);
						}
						return;
					}
					/* treat option separate also */
					if (suffix == RMLDB_TYPE_SUFFIX_LVAR)
					{
						/* actually should not happen here 
						* yes, it should, fold the type
						*/
						snprintf(line, RMLDB_MAX_LINE,"%d|lv|LVAR[1]|", depth);
						rmldb_socket_out(line);
						rmldb_type_to_sock(type, 0);
						snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
						rmldb_socket_outln(line);			
						return;
					}
					
					/* the last case DATATYPES */
					/* print the constructor here */
					if (type) 
					{
						rmldb_con_db_t *con = NULL;
						con = rmldb_get_con(type, constr);
						if (con)
						{
							snprintf(line, RMLDB_MAX_LINE,"%d|da|%s[%d]|", depth, con->name, slots);
							rmldb_socket_out(line);
							rmldb_type_to_sock(con->type_db->type, 0);
							snprintf(line, RMLDB_MAX_LINE,"|%s|%d.%d.%d.%d", 
								con->file,
								con->range->sl,
								con->range->sc,
								con->range->el,
								con->range->ec);
							rmldb_socket_outln(line);
						}
						else
						{
							snprintf(line, RMLDB_MAX_LINE,"%d|da|??UNNAMED??[%d,%d]|", depth, constr, slots);
							rmldb_socket_out(line);
							rmldb_type_to_sock(type, 0);
							snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
							rmldb_socket_outln(line);
						}
					}
					else
					{
							snprintf(line, RMLDB_MAX_LINE,"%d|da|UNKNOWN-STRUCTURE[%d,%d]|", depth, constr, slots);
							rmldb_socket_out(line);
							rmldb_type_to_sock(type, 0);
							snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
							rmldb_socket_outln(line);
					}
					/* print the constructor components here */
					for (i = 0; i < slots; i++)
					{
						/* tree like display please */
						rmldb_var_send(*pp++, 
							rmldb_get_type_component(type, constr, i), 
							depth+1);
					}
					if (remeber) 
					{
						/* we can free the p now here */
						free (RML_UNTAGPTR(p));
						remeber = 0;
					}
				} 
				else 
				{
					snprintf(line, RMLDB_MAX_LINE,"%d|lv|LVAR(NOT_BOUND)|", depth); 
					rmldb_socket_out(line);
					rmldb_type_to_sock(type, 0);
					snprintf(line, RMLDB_MAX_LINE,"|RML|0.0.0.0"); 
					rmldb_socket_outln(line);
				}
			}
	}
}


static unsigned long rmldb_var_size = 0;

unsigned long rmldb_get_var_size(void *p)
{
tail_recur_debug:
	if (!p) { return 0; }
	if( RML_ISIMM(p) ) 
	{
		return sizeof(void*);
	} 
	else 
	{
		rml_uint_t phdr = RML_GETHDR(p);            
		if( phdr == RML_REALHDR ) 
		{
			return sizeof(struct rml_real);
		} else 
			if( RML_HDRISSTRING(phdr) ) 
			{
				return RML_HDRSTRLEN(phdr);
			} else 
				if( RML_HDRISSTRUCT(phdr) ) 
				{
					rml_uint_t slots = RML_HDRSLOTS(phdr);
					rml_uint_t constr = RML_HDRCTOR(phdr);
					if (slots == 0)
					{
						return sizeof(struct rml_header);
					}
					void **pp = RML_STRUCTDATA(p);
					// function definition
					if ((constr == 64 || constr==13) && slots > 1000000) 
						return sizeof(struct rml_header);
					if( slots != 0 )
					{
						while( --slots > 0 )
						{
							rmldb_var_size += rmldb_get_var_size(*pp++);
						}
						p = *pp; 
						rmldb_var_size += rmldb_get_var_size(*pp); 
					}					    
				} 
				else 
				{
					return sizeof(struct rml_ref);
				}
	}
}

unsigned long rmldb_var_sizeof(void *p)
{
	rmldb_var_size = 0;
	unsigned long result = rmldb_get_var_size(p);
	if (rmldb_var_size == 0) return result;
	else return rmldb_var_size;
}


#endif /* RML_DEBUG */


