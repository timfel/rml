/* A Bison parser, made by GNU Bison 1.875b.  */

/* Skeleton parser for Yacc-like parsing with Bison,
   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003 Free Software Foundation, Inc.

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
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

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
     T_END = 274,
     T_DEBUGPARSER = 275,
     T_OUTPUT = 276,
     T_LIVEVARS = 277,
     T_PRINT = 278,
     T_SIZEOF = 279,
     T_DISPLAY = 280,
     T_UNDISPLAY = 281,
     T_GRAPH = 282,
     T_FAST = 283,
     T_MAXBT = 284,
     T_BACKTRACE = 285,
     T_FILTERED_BACKTRACE = 286,
     T_GRAPH_BACKTRACE = 287,
     T_GRAPH_FILTERED_BACKTRACE = 288,
     T_MAXSTR = 289,
     T_PRINT_TYPE = 290,
     T_NEXT = 291,
     T_MAXCALLCHAIN = 292,
     T_CALLCHAIN = 293,
     T_FILTERED_CALLCHAIN = 294,
     T_GRAPH_CALLCHAIN = 295,
     T_GRAPH_FILTERED_CALLCHAIN = 296,
     T_ID = 297
   };
#endif
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
#define T_END 274
#define T_DEBUGPARSER 275
#define T_OUTPUT 276
#define T_LIVEVARS 277
#define T_PRINT 278
#define T_SIZEOF 279
#define T_DISPLAY 280
#define T_UNDISPLAY 281
#define T_GRAPH 282
#define T_FAST 283
#define T_MAXBT 284
#define T_BACKTRACE 285
#define T_FILTERED_BACKTRACE 286
#define T_GRAPH_BACKTRACE 287
#define T_GRAPH_FILTERED_BACKTRACE 288
#define T_MAXSTR 289
#define T_PRINT_TYPE 290
#define T_NEXT 291
#define T_MAXCALLCHAIN 292
#define T_CALLCHAIN 293
#define T_FILTERED_CALLCHAIN 294
#define T_GRAPH_CALLCHAIN 295
#define T_GRAPH_FILTERED_CALLCHAIN 296
#define T_ID 297




#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 19 "rmldb-parse.y"
typedef union YYSTYPE {
  int   v_int;
  float v_float;
  char *to_print;
  char *id;
} YYSTYPE;
/* Line 1252 of yacc.c.  */
#line 128 "rmldb-parse.h"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE aalval;


