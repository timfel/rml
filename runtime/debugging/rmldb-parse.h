/* A Bison parser, made by GNU Bison 2.1.  */

/* Skeleton parser for Yacc-like parsing with Bison,
   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_EOF = 258,
     T_ERROR = 259,
     T_EOL = 260,
     T_HELP = 261,
     T_BREAKPOINT = 262,
     T_SET = 263,
     T_SETTINGS = 264,
     T_RUN = 265,
     T_STEP = 266,
     T_CLEAR = 267,
     T_QUIT = 268,
     T_ON = 269,
     T_OFF = 270,
     T_DEPTH = 271,
     T_SHOW = 272,
     T_STATUS = 273,
     T_DEBUGPARSER = 274,
     T_RDBDEBUGPARSER = 275,
     T_DEBUGSOCKET = 276,
     T_OUTPUT = 277,
     T_LIVEVARS = 278,
     T_PRINT = 279,
     T_SIZEOF = 280,
     T_DISPLAY = 281,
     T_UNDISPLAY = 282,
     T_GRAPH = 283,
     T_FAST = 284,
     T_MAXBT = 285,
     T_BACKTRACE = 286,
     T_FILTERED_BACKTRACE = 287,
     T_GRAPH_BACKTRACE = 288,
     T_GRAPH_FILTERED_BACKTRACE = 289,
     T_MAXSTR = 290,
     T_PRINT_TYPE = 291,
     T_NEXT = 292,
     T_MAXCALLCHAIN = 293,
     T_CALLCHAIN = 294,
     T_FILTERED_CALLCHAIN = 295,
     T_GRAPH_CALLCHAIN = 296,
     T_GRAPH_FILTERED_CALLCHAIN = 297,
     T_ID = 298
   };
#endif
/* Tokens.  */
#define T_EOF 258
#define T_ERROR 259
#define T_EOL 260
#define T_HELP 261
#define T_BREAKPOINT 262
#define T_SET 263
#define T_SETTINGS 264
#define T_RUN 265
#define T_STEP 266
#define T_CLEAR 267
#define T_QUIT 268
#define T_ON 269
#define T_OFF 270
#define T_DEPTH 271
#define T_SHOW 272
#define T_STATUS 273
#define T_DEBUGPARSER 274
#define T_RDBDEBUGPARSER 275
#define T_DEBUGSOCKET 276
#define T_OUTPUT 277
#define T_LIVEVARS 278
#define T_PRINT 279
#define T_SIZEOF 280
#define T_DISPLAY 281
#define T_UNDISPLAY 282
#define T_GRAPH 283
#define T_FAST 284
#define T_MAXBT 285
#define T_BACKTRACE 286
#define T_FILTERED_BACKTRACE 287
#define T_GRAPH_BACKTRACE 288
#define T_GRAPH_FILTERED_BACKTRACE 289
#define T_MAXSTR 290
#define T_PRINT_TYPE 291
#define T_NEXT 292
#define T_MAXCALLCHAIN 293
#define T_CALLCHAIN 294
#define T_FILTERED_CALLCHAIN 295
#define T_GRAPH_CALLCHAIN 296
#define T_GRAPH_FILTERED_CALLCHAIN 297
#define T_ID 298




#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 32 "rmldb-parse.y"
typedef union YYSTYPE {
  int   v_int;
  float v_float;
  char *to_print;
  char *id;
} YYSTYPE;
/* Line 1447 of yacc.c.  */
#line 131 "rmldb-parse.h"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE aalval;



