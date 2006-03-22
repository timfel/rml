/* A Bison parser, made by GNU Bison 1.875d.  */

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
     T_COLONCOLON = 258,
     T_COLONEQ = 259,
     T_COMMA = 260,
     T_DASH = 261,
     T_ELSE = 262,
     T_END = 263,
     T_EQ = 264,
     T_FATARROW = 265,
     T_FN = 266,
     T_FUN = 267,
     T_ICON = 268,
     T_IDENT = 269,
     T_IDIV = 270,
     T_IF = 271,
     T_IMOD = 272,
     T_IN = 273,
     T_LE = 274,
     T_LET = 275,
     T_LBRACK = 276,
     T_LPAREN = 277,
     T_LT = 278,
     T_OP = 279,
     T_PLUS = 280,
     T_RBRACK = 281,
     T_RCON = 282,
     T_RDIV = 283,
     T_RPAREN = 284,
     T_SCON = 285,
     T_SEMI = 286,
     T_STAR = 287,
     T_THEN = 288,
     T_VAL = 289
   };
#endif
#define T_COLONCOLON 258
#define T_COLONEQ 259
#define T_COMMA 260
#define T_DASH 261
#define T_ELSE 262
#define T_END 263
#define T_EQ 264
#define T_FATARROW 265
#define T_FN 266
#define T_FUN 267
#define T_ICON 268
#define T_IDENT 269
#define T_IDIV 270
#define T_IF 271
#define T_IMOD 272
#define T_IN 273
#define T_LE 274
#define T_LET 275
#define T_LBRACK 276
#define T_LPAREN 277
#define T_LT 278
#define T_OP 279
#define T_PLUS 280
#define T_RBRACK 281
#define T_RCON 282
#define T_RDIV 283
#define T_RPAREN 284
#define T_SCON 285
#define T_SEMI 286
#define T_STAR 287
#define T_THEN 288
#define T_VAL 289




#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 12 "parser.y"
typedef union YYSTYPE {
    void	*voidp;
    enum bop	bop;
} YYSTYPE;
/* Line 1285 of yacc.c.  */
#line 110 "y.tab.h"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;



