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
     T_EOF = 258,
     T_EOL = 259,
     T_VAL = 260,
     T_VAR = 261,
     T_CON = 262,
     T_TYPE = 263,
     T_RELATION = 264,
     T_LBRACK = 265,
     T_RBRACK = 266,
     T_FATARROW = 267,
     T_DOT = 268,
     T_MORE = 269,
     T_COLON = 270,
     T_LPAR = 271,
     T_RPAR = 272,
     T_COMMA = 273,
     T_STAR = 274,
     T_id = 275,
     T_tyvar = 276,
     T_file = 277,
     T_number = 278
   };
#endif
#define T_EOF 258
#define T_EOL 259
#define T_VAL 260
#define T_VAR 261
#define T_CON 262
#define T_TYPE 263
#define T_RELATION 264
#define T_LBRACK 265
#define T_RBRACK 266
#define T_FATARROW 267
#define T_DOT 268
#define T_MORE 269
#define T_COLON 270
#define T_LPAR 271
#define T_RPAR 272
#define T_COMMA 273
#define T_STAR 274
#define T_id 275
#define T_tyvar 276
#define T_file 277
#define T_number 278




#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 25 "rml-db-parse.y"
typedef union YYSTYPE {
  int vint;
  char *vid;
  rmldb_type_t *vtyp;
  rmldb_LISTty_t *vtyplist;
  rmldb_range_db_t *vrangep;
} YYSTYPE;
/* Line 1318 of yacc.c.  */
#line 91 "rml-db-parse.h"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE aarmldblval;



