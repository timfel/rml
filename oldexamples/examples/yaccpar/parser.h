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
     KW_AND = 258,
     KW_AS = 259,
     KW_ABSTYPE = 260,
     KW_AXIOM = 261,
     KW_DATATYPE = 262,
     KW_DEFAULT = 263,
     KW_END = 264,
     KW_EQTYPE = 265,
     KW_FAIL = 266,
     KW_INTERFACE = 267,
     KW_LET = 268,
     KW_MODULE = 269,
     KW_NOT = 270,
     KW_OF = 271,
     KW_OR = 272,
     KW_RELATION = 273,
     KW_RULE = 274,
     KW_TYPE = 275,
     KW_VAL = 276,
     KW_WITH = 277,
     KW_WITHTYPE = 278,
     LBRACK = 279,
     RBRACK = 280,
     LBRACE = 281,
     RBRACE = 282,
     LPAR = 283,
     RPAR = 284,
     ASSIGN = 285,
     DOT = 286,
     COLON = 287,
     COLONCOLON = 288,
     COMMA = 289,
     DASHES = 290,
     BAR = 291,
     AMPERSAND = 292,
     SEMICOLON = 293,
     YIELDS = 294,
     STAR = 295,
     UNDERSCORE = 296,
     EQUALS = 297,
     PLUS = 298,
     MINUS = 299,
     DIV = 300,
     LESS = 301,
     LESSEQ = 302,
     GREATER = 303,
     GREATEREQ = 304,
     EQEQ = 305,
     LESSGT = 306,
     SLASH = 307,
     POWER = 308,
     UNSIGNED_INTEGER = 309,
     UNSIGNED_REAL = 310,
     IDENT = 311,
     TYVARIDENT = 312,
     CCON = 313,
     ICON = 314,
     RCON = 315,
     SCON = 316
   };
#endif
#define KW_AND 258
#define KW_AS 259
#define KW_ABSTYPE 260
#define KW_AXIOM 261
#define KW_DATATYPE 262
#define KW_DEFAULT 263
#define KW_END 264
#define KW_EQTYPE 265
#define KW_FAIL 266
#define KW_INTERFACE 267
#define KW_LET 268
#define KW_MODULE 269
#define KW_NOT 270
#define KW_OF 271
#define KW_OR 272
#define KW_RELATION 273
#define KW_RULE 274
#define KW_TYPE 275
#define KW_VAL 276
#define KW_WITH 277
#define KW_WITHTYPE 278
#define LBRACK 279
#define RBRACK 280
#define LBRACE 281
#define RBRACE 282
#define LPAR 283
#define RPAR 284
#define ASSIGN 285
#define DOT 286
#define COLON 287
#define COLONCOLON 288
#define COMMA 289
#define DASHES 290
#define BAR 291
#define AMPERSAND 292
#define SEMICOLON 293
#define YIELDS 294
#define STAR 295
#define UNDERSCORE 296
#define EQUALS 297
#define PLUS 298
#define MINUS 299
#define DIV 300
#define LESS 301
#define LESSEQ 302
#define GREATER 303
#define GREATEREQ 304
#define EQEQ 305
#define LESSGT 306
#define SLASH 307
#define POWER 308
#define UNSIGNED_INTEGER 309
#define UNSIGNED_REAL 310
#define IDENT 311
#define TYVARIDENT 312
#define CCON 313
#define ICON 314
#define RCON 315
#define SCON 316




#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;



