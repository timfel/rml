/* A Bison parser, made by GNU Bison 2.0.  */

/* Skeleton parser for Yacc-like parsing with Bison,
   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004 Free Software Foundation, Inc.

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
     T_BREAKPOINT = 258,
     T_DELETE_BREAKPOINT = 259,
     T_CLEAR_BREAKPOINTS = 260,
     T_FUNCTION_BREAKPOINT = 261,
     T_DELETE_FUNCTION_BREAKPOINT = 262,
     T_STRING_BREAKPOINT = 263,
     T_DELETE_STRING_BREAKPOINT = 264,
     T_FAILURE_BREAKPOINT = 265,
     T_DELETE_FAILURE_BREAKPOINT = 266,
     T_STEP = 267,
     T_STEP_OVER = 268,
     T_STEP_RETURN = 269,
     T_RUN = 270,
     T_STACK = 271,
     T_VARIABLE_VALUE = 272,
     T_LAZY_VARIABLE_VALUE = 273,
     T_FRAME_VARIABLE_VALUE = 274,
     T_FRAME_LAZY_VARIABLE_VALUE = 275,
     T_QUIT = 276,
     T_COLON = 277,
     T_EOL = 278,
     T_ID = 279
   };
#endif
#define T_BREAKPOINT 258
#define T_DELETE_BREAKPOINT 259
#define T_CLEAR_BREAKPOINTS 260
#define T_FUNCTION_BREAKPOINT 261
#define T_DELETE_FUNCTION_BREAKPOINT 262
#define T_STRING_BREAKPOINT 263
#define T_DELETE_STRING_BREAKPOINT 264
#define T_FAILURE_BREAKPOINT 265
#define T_DELETE_FAILURE_BREAKPOINT 266
#define T_STEP 267
#define T_STEP_OVER 268
#define T_STEP_RETURN 269
#define T_RUN 270
#define T_STACK 271
#define T_VARIABLE_VALUE 272
#define T_LAZY_VARIABLE_VALUE 273
#define T_FRAME_VARIABLE_VALUE 274
#define T_FRAME_LAZY_VARIABLE_VALUE 275
#define T_QUIT 276
#define T_COLON 277
#define T_EOL 278
#define T_ID 279




#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 19 "parse-command.y"
typedef union YYSTYPE {
	char* id;
} YYSTYPE;
/* Line 1318 of yacc.c.  */
#line 89 "parse-command.h"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE aalval;



