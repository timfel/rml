/******************************************************************************
 * @author Adrian Pop [adrpo@ida.liu.se, http://www.ida.liu.se/~adrpo]
 * Copyright (c) 2002-2007, Adrian Pop [adrpo@ida.liu.se],
 * Programming Environments Laboratory (PELAB),
 * Department of Computer and Information Science (IDA), 
 * Linköpings University (LiU). 
 * All rights reserved.
 *
 * http://www.ida.liu.se/~adrpo/license/
 */
/***********************************************************
 [ rml-debug.h ] 
  - Adrian Pop, adrpo@ida.liu.se, http://www.ida.liu.se/~adrpo
  - creation 2002-10
    + interface for rml debugging 
    + this file contains all the functions for debugging 
	+ all things in this file start with rmldb_
  - last modified 2005-12-27
************************************************************/
#ifndef _RML_DEBUG_H_
#define _RML_DEBUG_H_

/* all these functions depends on RML_DEBUG macro */
/************************************************************/
#ifdef RML_DEBUG

#include <stdio.h>
#include <string.h>
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

#endif /* unix vs windows stuff */

/* this file will be included in the generated rml.h */
/* adrpo some useful defines. */
#define RMLDB_PROMPT "rml+mmc db@>"
#define RMLDB_RUN    0
#define RMLDB_STEP   1
#define RMLDB_NEXT   2
#define RMLDB_FAST   3 /* no livevars, no backtrace, just very fast debugging (breakpoints) */
#define RMLDB_TRACE_CALLS  4
#define RMLDB_TRACE_ALL    5

#define RMLDB_REPEAT_PARSE   0  /* repeat the command parse */
#define RMLDB_BREAK_PARSE    1  /* exit the parse cycle and continue with the execution */

#define RMLDB_SHOW  1
#define RMLDB_HIDE  0

#define RMLDB_VAR_IN 0
#define RMLDB_VAR_OUT 1

#define RMLDB_LIVEVARS_ON  1
#define RMLDB_LIVEVARS_OFF 0

#define RMLDB_MAX_BREAKPOINTS 100

#define RMLDB_MAX_DISPLAY_VARS 100

#define RMLDB_TERMINAL_READLINE 0 
#define RMLDB_TERMINAL_SOCKET   1
/* adrpo - debugger global variables */
extern int   rmldb_terminal;    /* terminal type (readline|socket) */
extern int   rmldb_cmd_port;    /* listen for commands on this port */
extern int   rmldb_event_port;  /* listen for events on this port */
extern int   rmldb_cmd_sock;    /* listen for commands on this socket */
extern int   rmldb_event_sock;  /* listen for events on this socket */
extern void rmldb_open_cmd_socket(void);  /* open the command socket  */
extern void rmldb_close_cmd_socket(void); /* close the command socket */
extern void rmldb_open_event_socket(void);  /* open the command socket  */
extern void rmldb_close_event_socket(void); /* close the command socket */


extern int   rmldb_sock_debug;
extern int   rmldb_execution_type;
extern int   rmldb_execution_startup_type;
extern int   rmldb_show;
extern int   rmldb_last_command; /* need to know if we should start running or get more commands from the debugger */
extern char* rmldb_command;
extern int   rmldb_max_backtrace_entries;
extern int   rmldb_max_callchain_entries;
extern int   rmldb_depth_of_variable_print;
extern int   rmldb_max_string_variable_print;
extern int   rmldb_print_livevars_each_step; /* print the current livevars each step */
/* this filter is set on the relations you want to make the 
   program to stop (like a breakpoint, but with string matching)  */
extern char  rmldb_relation_filter[RMLDB_MAX_BREAKPOINTS][RMLDB_MAX_STRING];
extern int   rmldb_number_of_filters; /* of course, the number of filters. */
extern char  rmldb_display_vars[RMLDB_MAX_DISPLAY_VARS][RMLDB_MAX_STRING];
extern int   rmldb_number_of_display_vars; /* of course, the number active display vars. */
extern char* rmldb_ttyname;
/* location of current execution point */
extern       rmldb_current_execution_loc_t rmldb_current_execution_loc;

/* init/help/exit */
extern int  rmldb_init(void);
extern int  rmldb_end(void);
extern void rmldb_show_help(void);
extern int  rmldb_quit(char *line);

/* breakpoints */
extern void rmldb_add_relation_filter(char *);
extern void rmldb_del_relation_filter(char *);
extern void rmldb_show_breakpoints(void);
extern void rmldb_clear_breakpoints(void);


extern void rmldb_debug_add_var(int direction, void* var_name, void* var);
extern void rmldb_clear_debug_vars(void);
extern void rmldb_print_variable(char* var_name);
extern void rmldb_trace_vars(void);
extern unsigned long rmldb_var_sizeof(void *p);
extern void rmldb_print_sizeof_variable(char* var_name);
extern void rmldb_print_debug_vars(void);
extern void rmldb_set_print_debug_vars(int flag);
extern void rmldb_display_variable(char* var_name);
extern void rmldb_undisplay_variable(char* var_name);
extern void rmldb_print_displayvars(void);
extern void rmldb_show_displayvars(void);
extern void rmldb_clear_displayvars(void);
extern void rmldb_view_variable(char* var_name);

extern unsigned long rmldb_stack_pointer_to_ulong(void* stackPointer);

/* stack (backtrace) */
extern void rmldb_backtrace_push(char *rname, rmldb_current_execution_loc_t loc);
extern void rmldb_backtrace_pop(void);
extern void rmldb_backtrace_print(char* filter);
extern void rmldb_backtrace_send(char* filter);
extern void rmldb_set_max_backtrace(char *maxbt);

/* call chain */
extern void rmldb_callchain_push(char *rname, rmldb_current_execution_loc_t loc);
extern void rmldb_callchain_pop(void);
extern void rmldb_callchain_print(char* filter);
extern void rmldb_backtrace_send(char* filter);
extern void rmldb_set_max_callchain(char *maxcallchain);

/* settings */
extern void rmldb_set_depth(char* depth);
extern void rmldb_set_maxstring(char* maxstr);
extern void rmldb_print_settings(void);
extern void rmldb_set_output(char *);

/* function to work with the program database */
extern void rmldb_print_type_info_id(char* name, FILE* out);
extern void rmldb_print_type_constructor(char* constructor_name, FILE* out);
extern void rmldb_print_type_constructors(char* type_name, FILE* out);
extern void rmldb_print_type(rmldb_type_t* type, int detailed, FILE* out);
extern void rmldb_print_type_list(rmldb_LISTty_t* list, int detailed, char* separator, FILE* out);
extern rmldb_type_db_t* rmldb_get_type(char* var_name);
extern rmldb_var_db_t* rmldb_get_var(char* var_name);
extern char* rmldb_get_con_name(rmldb_type_t *type, int constructor);
extern rmldb_con_db_t* rml_get_con(rmldb_type_t *type, int constructor);
extern int rmldb_is_type_transparent(rmldb_type_t *type);
extern rmldb_str_t* rmldb_make_rmldb_str(char* name);
extern void rmldb_str_list_print(rmldb_str_list_t* list);
extern void rmldb_str_list_free(rmldb_str_list_t* list);
extern void rmldb_type_list_to_list(rmldb_LISTty_t* list, rmldb_str_list_t* lst);
extern void rmldb_type_to_list(rmldb_type_t *type, rmldb_str_list_t* list);
extern int rmldb_str_list_get_size(rmldb_str_list_t* list);
extern char* rmldb_str_list_get_index(rmldb_str_list_t* list, int index);
extern rmldb_LISTty_t* rmldb_get_type_components(rmldb_con_db_t* con_db);
extern rmldb_type_t* rmldb_get_type_component(rmldb_type_t* type, int constr, int index);
extern rmldb_type_t* rmldb_get_type_comp_from_con(rmldb_LISTty_t* type, int index);
extern void rmldb_var_show(void *p, rmldb_type_t* type, int depth);
extern void rmldb_var_send(void *p, rmldb_type_t* type, int depth);
extern void rmldb_open_socket(void);
extern void rmldb_close_socket(void);
extern void rmldb_socket_outln(char* msg);
extern void rmldb_socket_out(char* msg);
extern void rmldb_type_list_to_sock(rmldb_LISTty_t* list, int detailed, char* separator);
extern void rmldb_type_to_sock(rmldb_type_t *type, int detailed);

int  rmldb_open_new_file(void);
void rmldb_use_quit (int);
int  rmldb_parse(void);

/* comand stream */
extern FILE* aain; /* the stream we need to parse from the rmldebugger */

#endif /* RML_DEBUG */

extern int   aaerror(char*);
extern int   aaparse(void);
extern int   aadebug;

#define rmldb_sprintf printf

#endif /* _RML_DEBUG_H_  */
