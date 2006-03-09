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

/* Written by Richard Stallman by simplifying the original so called
   ``semantic'' parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     T_AMPER = 258,
     T_AND = 259,
     T_ARRAY = 260,
     T_ASSIGN = 261,
     T_BEGIN = 262,
     T_CARET = 263,
     T_CAST = 264,
     T_COLON = 265,
     T_COMMA = 266,
     T_CONST = 267,
     T_DO = 268,
     T_DOT = 269,
     T_ELSE = 270,
     T_ELSIF = 271,
     T_END = 272,
     T_EQ = 273,
     T_EXTERN = 274,
     T_FUNCTION = 275,
     T_GE = 276,
     T_GT = 277,
     T_ICON = 278,
     T_IDENT = 279,
     T_IDIV = 280,
     T_IF = 281,
     T_IMOD = 282,
     T_LBRACK = 283,
     T_LE = 284,
     T_LPAREN = 285,
     T_LT = 286,
     T_MINUS = 287,
     T_MUL = 288,
     T_NE = 289,
     T_NOT = 290,
     T_OF = 291,
     T_OR = 292,
     T_PLUS = 293,
     T_PROCEDURE = 294,
     T_PROGRAM = 295,
     T_RBRACK = 296,
     T_RCON = 297,
     T_RDIV = 298,
     T_RECORD = 299,
     T_RETURN = 300,
     T_RPAREN = 301,
     T_SEMI = 302,
     T_THEN = 303,
     T_TYPE = 304,
     T_VAR = 305,
     T_WHILE = 306
   };
#endif
#define T_AMPER 258
#define T_AND 259
#define T_ARRAY 260
#define T_ASSIGN 261
#define T_BEGIN 262
#define T_CARET 263
#define T_CAST 264
#define T_COLON 265
#define T_COMMA 266
#define T_CONST 267
#define T_DO 268
#define T_DOT 269
#define T_ELSE 270
#define T_ELSIF 271
#define T_END 272
#define T_EQ 273
#define T_EXTERN 274
#define T_FUNCTION 275
#define T_GE 276
#define T_GT 277
#define T_ICON 278
#define T_IDENT 279
#define T_IDIV 280
#define T_IF 281
#define T_IMOD 282
#define T_LBRACK 283
#define T_LE 284
#define T_LPAREN 285
#define T_LT 286
#define T_MINUS 287
#define T_MUL 288
#define T_NE 289
#define T_NOT 290
#define T_OF 291
#define T_OR 292
#define T_PLUS 293
#define T_PROCEDURE 294
#define T_PROGRAM 295
#define T_RBRACK 296
#define T_RCON 297
#define T_RDIV 298
#define T_RECORD 299
#define T_RETURN 300
#define T_RPAREN 301
#define T_SEMI 302
#define T_THEN 303
#define T_TYPE 304
#define T_VAR 305
#define T_WHILE 306




/* Copy the first part of user declarations.  */
#line 3 "parser.y"

#include <stdarg.h>
#include <stdio.h>
#include "yacclib.h"
#include "parsutil.h"
#include "lexer.h"
static void yyerror(const char*);


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 12 "parser.y"
typedef union YYSTYPE {
    void	*voidp;
    enum uop	uop;
    enum bop	bop;
    enum rop	rop;
    enum eop	eop;
} YYSTYPE;
/* Line 191 of yacc.c.  */
#line 195 "y.tab.c"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 214 of yacc.c.  */
#line 207 "y.tab.c"

#if ! defined (yyoverflow) || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# if YYSTACK_USE_ALLOCA
#  define YYSTACK_ALLOC alloca
# else
#  ifndef YYSTACK_USE_ALLOCA
#   if defined (alloca) || defined (_ALLOCA_H)
#    define YYSTACK_ALLOC alloca
#   else
#    ifdef __GNUC__
#     define YYSTACK_ALLOC __builtin_alloca
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning. */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
# else
#  if defined (__STDC__) || defined (__cplusplus)
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   define YYSIZE_T size_t
#  endif
#  define YYSTACK_ALLOC malloc
#  define YYSTACK_FREE free
# endif
#endif /* ! defined (yyoverflow) || YYERROR_VERBOSE */


#if (! defined (yyoverflow) \
     && (! defined (__cplusplus) \
	 || (YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  short yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short) + sizeof (YYSTYPE))				\
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  register YYSIZE_T yyi;		\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (0)
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (0)

#endif

#if defined (__STDC__) || defined (__cplusplus)
   typedef signed char yysigned_char;
#else
   typedef short yysigned_char;
#endif

/* YYFINAL -- State number of the termination state. */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   153

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  52
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  41
/* YYNRULES -- Number of rules. */
#define YYNRULES  96
/* YYNRULES -- Number of states. */
#define YYNSTATES  176

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   306

#define YYTRANSLATE(YYX) 						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const unsigned char yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned short yyprhs[] =
{
       0,     0,     3,     9,    15,    17,    19,    22,    23,    25,
      28,    33,    35,    37,    39,    42,    43,    45,    48,    53,
      55,    58,    65,    69,    72,    73,    75,    78,    83,    85,
      86,    88,    91,    98,   107,   111,   114,   115,   117,   121,
     125,   129,   131,   135,   141,   147,   152,   156,   159,   161,
     162,   168,   170,   174,   176,   178,   179,   181,   185,   187,
     189,   193,   195,   197,   199,   203,   205,   207,   209,   211,
     213,   217,   219,   221,   223,   225,   229,   231,   233,   235,
     237,   239,   241,   244,   246,   248,   250,   252,   254,   257,
     261,   266,   271,   278,   280,   282,   284
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const yysigned_char yyrhs[] =
{
      53,     0,    -1,    40,    24,    47,    54,    14,    -1,    56,
      60,    64,    67,    73,    -1,    19,    -1,    54,    -1,    12,
      57,    -1,    -1,    58,    -1,    58,    57,    -1,    24,    18,
      59,    47,    -1,    23,    -1,    42,    -1,    24,    -1,    49,
      61,    -1,    -1,    62,    -1,    62,    61,    -1,    24,    18,
      63,    47,    -1,    24,    -1,     8,    63,    -1,     5,    28,
      59,    41,    36,    63,    -1,    44,    65,    17,    -1,    50,
      65,    -1,    -1,    66,    -1,    66,    65,    -1,    24,    10,
      63,    47,    -1,    68,    -1,    -1,    69,    -1,    69,    68,
      -1,    39,    24,    70,    47,    55,    47,    -1,    20,    24,
      70,    10,    63,    47,    55,    47,    -1,    30,    71,    46,
      -1,    30,    46,    -1,    -1,    72,    -1,    72,    47,    71,
      -1,    24,    10,    63,    -1,     7,    74,    17,    -1,    75,
      -1,    75,    47,    74,    -1,    26,    80,    48,    74,    76,
      -1,    51,    80,    13,    74,    17,    -1,    24,    30,    78,
      46,    -1,    89,     6,    80,    -1,    45,    80,    -1,    45,
      -1,    -1,    16,    80,    48,    74,    76,    -1,    77,    -1,
      15,    74,    17,    -1,    17,    -1,    79,    -1,    -1,    80,
      -1,    80,    11,    79,    -1,    81,    -1,    83,    -1,    81,
      82,    83,    -1,    18,    -1,    34,    -1,    85,    -1,    83,
      84,    85,    -1,    31,    -1,    29,    -1,    21,    -1,    22,
      -1,    87,    -1,    85,    86,    87,    -1,    37,    -1,    38,
      -1,    32,    -1,    89,    -1,    87,    88,    89,    -1,     4,
      -1,    33,    -1,    43,    -1,    25,    -1,    27,    -1,    91,
      -1,    90,    89,    -1,     3,    -1,    35,    -1,    38,    -1,
      32,    -1,    92,    -1,    91,     8,    -1,    91,    14,    24,
      -1,    91,    28,    80,    41,    -1,    24,    30,    78,    46,
      -1,     9,    30,    63,    11,    80,    46,    -1,    24,    -1,
      23,    -1,    42,    -1,    30,    80,    46,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short yyrline[] =
{
       0,    90,    90,    93,    96,    98,   105,   108,   110,   112,
     115,   118,   120,   122,   129,   132,   134,   136,   139,   142,
     144,   146,   148,   155,   158,   160,   162,   165,   172,   174,
     176,   178,   181,   183,   186,   188,   191,   193,   195,   198,
     205,   208,   209,   212,   214,   216,   218,   220,   222,   225,
     227,   229,   231,   233,   240,   242,   244,   246,   249,   251,
     252,   255,   257,   260,   261,   264,   266,   268,   270,   273,
     274,   277,   279,   281,   284,   285,   288,   290,   292,   294,
     296,   299,   300,   303,   305,   307,   309,   312,   313,   315,
     317,   320,   322,   325,   327,   329,   331
};
#endif

#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "T_AMPER", "T_AND", "T_ARRAY", "T_ASSIGN", 
  "T_BEGIN", "T_CARET", "T_CAST", "T_COLON", "T_COMMA", "T_CONST", "T_DO", 
  "T_DOT", "T_ELSE", "T_ELSIF", "T_END", "T_EQ", "T_EXTERN", "T_FUNCTION", 
  "T_GE", "T_GT", "T_ICON", "T_IDENT", "T_IDIV", "T_IF", "T_IMOD", 
  "T_LBRACK", "T_LE", "T_LPAREN", "T_LT", "T_MINUS", "T_MUL", "T_NE", 
  "T_NOT", "T_OF", "T_OR", "T_PLUS", "T_PROCEDURE", "T_PROGRAM", 
  "T_RBRACK", "T_RCON", "T_RDIV", "T_RECORD", "T_RETURN", "T_RPAREN", 
  "T_SEMI", "T_THEN", "T_TYPE", "T_VAR", "T_WHILE", "$accept", "program", 
  "block", "body", "const_part", "const_decls", "const_decl", "constant", 
  "type_part", "type_decls", "type_decl", "type", "var_part", "var_decls", 
  "var_decl", "sub_part", "sub_decls", "sub_decl", "opt_param_list", 
  "param_list", "param", "comp_stmt", "stmt_list", "stmt", "elsif_part", 
  "else_part", "opt_exp_list", "exp_list", "exp", "eq_exp", "eq_op", 
  "rel_exp", "rel_op", "add_exp", "add_op", "mul_exp", "mul_op", 
  "unary_exp", "unary_op", "postfix_exp", "primary_exp", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const unsigned short yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    52,    53,    54,    55,    55,    56,    56,    57,    57,
      58,    59,    59,    59,    60,    60,    61,    61,    62,    63,
      63,    63,    63,    64,    64,    65,    65,    66,    67,    67,
      68,    68,    69,    69,    70,    70,    70,    71,    71,    72,
      73,    74,    74,    75,    75,    75,    75,    75,    75,    75,
      76,    76,    77,    77,    78,    78,    79,    79,    80,    81,
      81,    82,    82,    83,    83,    84,    84,    84,    84,    85,
      85,    86,    86,    86,    87,    87,    88,    88,    88,    88,
      88,    89,    89,    90,    90,    90,    90,    91,    91,    91,
      91,    91,    91,    92,    92,    92,    92
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     5,     5,     1,     1,     2,     0,     1,     2,
       4,     1,     1,     1,     2,     0,     1,     2,     4,     1,
       2,     6,     3,     2,     0,     1,     2,     4,     1,     0,
       1,     2,     6,     8,     3,     2,     0,     1,     3,     3,
       3,     1,     3,     5,     5,     4,     3,     2,     1,     0,
       5,     1,     3,     1,     1,     0,     1,     3,     1,     1,
       3,     1,     1,     1,     3,     1,     1,     1,     1,     1,
       3,     1,     1,     1,     1,     3,     1,     1,     1,     1,
       1,     1,     2,     1,     1,     1,     1,     1,     2,     3,
       4,     4,     6,     1,     1,     1,     3
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned char yydefact[] =
{
       0,     0,     0,     0,     1,     7,     0,     0,    15,     0,
       6,     8,     2,     0,    24,     0,     9,     0,    14,    16,
       0,    29,    11,    13,    12,     0,     0,    17,     0,    23,
      25,     0,     0,     0,    28,    30,    10,     0,     0,    19,
       0,     0,     0,    26,    36,    36,    49,     3,    31,     0,
      20,     0,    18,     0,     0,     0,     0,    83,     0,    94,
      93,     0,     0,    86,    84,    85,    95,    48,     0,     0,
      41,     0,     0,    81,    87,     0,    22,    27,     0,    35,
       0,    37,     0,     7,     0,    55,    93,     0,    58,    59,
      63,    69,    74,     0,    47,     0,    40,    49,     0,    82,
      88,     0,     0,     0,     0,    34,     0,     0,     4,     5,
       0,     0,     0,    54,    56,    55,    49,    61,    62,     0,
      67,    68,    66,    65,     0,    73,    71,    72,     0,    76,
      79,    80,    77,    78,     0,    96,    49,    42,    46,    89,
       0,     0,    39,    38,     7,    32,     0,    45,     0,     0,
       0,    60,    64,    70,    75,     0,    90,    21,     0,     0,
      57,    91,    49,     0,    53,    43,    51,    44,    33,    92,
       0,     0,    52,    49,     0,    50
};

/* YYDEFGOTO[NTERM-NUM]. */
static const short yydefgoto[] =
{
      -1,     2,   109,   110,     8,    10,    11,    25,    14,    18,
      19,    41,    21,    29,    30,    33,    34,    35,    55,    80,
      81,    47,    69,    70,   165,   166,   112,   113,   114,    88,
     119,    89,   124,    90,   128,    91,   134,    92,    72,    73,
      74
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -95
static const yysigned_char yypact[] =
{
     -24,    -3,    29,   -12,   -95,    37,    17,    48,    15,    35,
     -95,    17,   -95,    41,    22,    -4,   -95,    69,   -95,    41,
      70,    -9,   -95,   -95,   -95,    46,    51,   -95,    87,   -95,
      70,    74,    75,    93,   -95,    -9,   -95,    73,    51,   -95,
      70,    55,    51,   -95,    76,    76,     1,   -95,   -95,    -4,
     -95,    86,   -95,    58,   -18,    97,    61,   -95,    80,   -95,
      81,    31,    31,   -95,   -95,   -95,   -95,    31,    31,    95,
      66,   108,    31,     4,   -95,    77,   -95,   -95,   105,   -95,
      71,    72,    51,   -10,    51,    31,    90,    78,    40,    60,
      39,    53,   -95,    79,   -95,   109,   -95,     1,    31,   -95,
     -95,    99,    31,    85,    51,   -95,   100,    82,   -95,   -95,
      83,   117,    88,   -95,   120,    31,     1,   -95,   -95,    31,
     -95,   -95,   -95,   -95,    31,   -95,   -95,   -95,    31,   -95,
     -95,   -95,   -95,   -95,    31,   -95,     1,   -95,   -95,   -95,
      91,    51,   -95,   -95,   -10,   -95,    31,     9,    31,    89,
      68,    60,    39,    53,   -95,   116,   -95,   -95,    92,    94,
     -95,   -95,     1,    31,   -95,   -95,   -95,   -95,   -95,   -95,
     119,    96,   -95,     1,    68,   -95
};

/* YYPGOTO[NTERM-NUM].  */
static const short yypgoto[] =
{
     -95,   -95,   132,    -6,   -95,   130,   -95,    98,   -95,   123,
     -95,   -37,   -95,    20,   -95,   -95,   110,   -95,   101,    42,
     -95,   -95,   -94,   -95,   -31,   -95,    34,     2,   -54,   -95,
     -95,    32,   -95,    28,   -95,    25,   -95,   -46,   -95,   -95,
     -95
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -92
static const short yytable[] =
{
      71,    50,     6,   137,    57,    53,    78,    87,    93,   108,
      58,    31,   100,    94,    95,   -91,     1,   -91,   101,    22,
      23,     3,   150,   -91,    59,    60,    99,    61,    79,     4,
      32,    62,   102,    63,    57,     5,    64,   -91,    24,    65,
      58,     9,   155,    66,   138,   107,    67,   111,   140,     6,
      43,    71,    68,    15,    59,    86,    37,   129,   117,    38,
      51,    62,    12,    63,    13,    17,    64,   142,   170,    65,
      71,   125,    20,    66,   118,    39,   126,   127,   130,   174,
     131,   120,   121,   162,   163,   164,   132,    26,   154,   122,
      71,   123,   159,    36,    28,    40,   133,    42,    44,    45,
      46,    49,    52,    76,   157,    77,    54,    82,    83,   171,
      84,    85,    96,    97,    98,   104,    71,   105,   103,   106,
     115,   141,   136,   139,    78,   135,   116,    71,   146,   144,
     145,   148,   156,   167,   147,   161,   172,     7,   158,   168,
     169,    16,    27,   175,   173,    48,    56,    75,   143,   149,
     160,   151,   152,   153
};

static const unsigned char yycheck[] =
{
      46,    38,    12,    97,     3,    42,    24,    61,    62,    19,
       9,    20,     8,    67,    68,     6,    40,     8,    14,    23,
      24,    24,   116,    14,    23,    24,    72,    26,    46,     0,
      39,    30,    28,    32,     3,    47,    35,    28,    42,    38,
       9,    24,   136,    42,    98,    82,    45,    84,   102,    12,
      30,    97,    51,    18,    23,    24,     5,     4,    18,     8,
      40,    30,    14,    32,    49,    24,    35,   104,   162,    38,
     116,    32,    50,    42,    34,    24,    37,    38,    25,   173,
      27,    21,    22,    15,    16,    17,    33,    18,   134,    29,
     136,    31,   146,    47,    24,    44,    43,    10,    24,    24,
       7,    28,    47,    17,   141,    47,    30,    10,    47,   163,
      30,    30,    17,    47,     6,    10,   162,    46,    41,    47,
      30,    36,    13,    24,    24,    46,    48,   173,    11,    47,
      47,    11,    41,    17,    46,    46,    17,     5,   144,    47,
      46,    11,    19,   174,    48,    35,    45,    49,   106,   115,
     148,   119,   124,   128
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,    40,    53,    24,     0,    47,    12,    54,    56,    24,
      57,    58,    14,    49,    60,    18,    57,    24,    61,    62,
      50,    64,    23,    24,    42,    59,    18,    61,    24,    65,
      66,    20,    39,    67,    68,    69,    47,     5,     8,    24,
      44,    63,    10,    65,    24,    24,     7,    73,    68,    28,
      63,    65,    47,    63,    30,    70,    70,     3,     9,    23,
      24,    26,    30,    32,    35,    38,    42,    45,    51,    74,
      75,    89,    90,    91,    92,    59,    17,    47,    24,    46,
      71,    72,    10,    47,    30,    30,    24,    80,    81,    83,
      85,    87,    89,    80,    80,    80,    17,    47,     6,    89,
       8,    14,    28,    41,    10,    46,    47,    63,    19,    54,
      55,    63,    78,    79,    80,    30,    48,    18,    34,    82,
      21,    22,    29,    31,    84,    32,    37,    38,    86,     4,
      25,    27,    33,    43,    88,    46,    13,    74,    80,    24,
      80,    36,    63,    71,    47,    47,    11,    46,    11,    78,
      74,    83,    85,    87,    89,    74,    41,    63,    55,    80,
      79,    46,    15,    16,    17,    76,    77,    17,    47,    46,
      74,    80,    17,    48,    74,    76
};

#if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
# define YYSIZE_T __SIZE_TYPE__
#endif
#if ! defined (YYSIZE_T) && defined (size_t)
# define YYSIZE_T size_t
#endif
#if ! defined (YYSIZE_T)
# if defined (__STDC__) || defined (__cplusplus)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# endif
#endif
#if ! defined (YYSIZE_T)
# define YYSIZE_T unsigned int
#endif

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrlab1


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { 								\
      yyerror ("syntax error: cannot back up");\
      YYERROR;							\
    }								\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

/* YYLLOC_DEFAULT -- Compute the default location (before the actions
   are run).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)         \
  Current.first_line   = Rhs[1].first_line;      \
  Current.first_column = Rhs[1].first_column;    \
  Current.last_line    = Rhs[N].last_line;       \
  Current.last_column  = Rhs[N].last_column;
#endif

/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (0)

# define YYDSYMPRINT(Args)			\
do {						\
  if (yydebug)					\
    yysymprint Args;				\
} while (0)

# define YYDSYMPRINTF(Title, Token, Value, Location)		\
do {								\
  if (yydebug)							\
    {								\
      YYFPRINTF (stderr, "%s ", Title);				\
      yysymprint (stderr, 					\
                  Token, Value);	\
      YYFPRINTF (stderr, "\n");					\
    }								\
} while (0)

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (cinluded).                                                   |
`------------------------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_stack_print (short *bottom, short *top)
#else
static void
yy_stack_print (bottom, top)
    short *bottom;
    short *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (/* Nothing. */; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_reduce_print (int yyrule)
#else
static void
yy_reduce_print (yyrule)
    int yyrule;
#endif
{
  int yyi;
  unsigned int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %u), ",
             yyrule - 1, yylno);
  /* Print the symbols being reduced, and their result.  */
  for (yyi = yyprhs[yyrule]; 0 <= yyrhs[yyi]; yyi++)
    YYFPRINTF (stderr, "%s ", yytname [yyrhs[yyi]]);
  YYFPRINTF (stderr, "-> %s\n", yytname [yyr1[yyrule]]);
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (Rule);		\
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YYDSYMPRINT(Args)
# define YYDSYMPRINTF(Title, Token, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   SIZE_MAX < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#if YYMAXDEPTH == 0
# undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined (__GLIBC__) && defined (_STRING_H)
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
#   if defined (__STDC__) || defined (__cplusplus)
yystrlen (const char *yystr)
#   else
yystrlen (yystr)
     const char *yystr;
#   endif
{
  register const char *yys = yystr;

  while (*yys++ != '\0')
    continue;

  return yys - yystr - 1;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined (__GLIBC__) && defined (_STRING_H) && defined (_GNU_SOURCE)
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
#   if defined (__STDC__) || defined (__cplusplus)
yystpcpy (char *yydest, const char *yysrc)
#   else
yystpcpy (yydest, yysrc)
     char *yydest;
     const char *yysrc;
#   endif
{
  register char *yyd = yydest;
  register const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

#endif /* !YYERROR_VERBOSE */



#if YYDEBUG
/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yysymprint (FILE *yyoutput, int yytype, YYSTYPE *yyvaluep)
#else
static void
yysymprint (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  if (yytype < YYNTOKENS)
    {
      YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
# ifdef YYPRINT
      YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
    }
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  switch (yytype)
    {
      default:
        break;
    }
  YYFPRINTF (yyoutput, ")");
}

#endif /* ! YYDEBUG */
/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yydestruct (int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yytype, yyvaluep)
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  switch (yytype)
    {

      default:
        break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM);
# else
int yyparse ();
# endif
#else /* ! YYPARSE_PARAM */
#if defined (__STDC__) || defined (__cplusplus)
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM)
# else
int yyparse (YYPARSE_PARAM)
  void *YYPARSE_PARAM;
# endif
#else /* ! YYPARSE_PARAM */
#if defined (__STDC__) || defined (__cplusplus)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  register int yystate;
  register int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  short	yyssa[YYINITDEPTH];
  short *yyss = yyssa;
  register short *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  register YYSTYPE *yyvsp;



#define YYPOPSTACK   (yyvsp--, yyssp--)

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* When reducing, the number of symbols on the RHS of the reduced
     rule.  */
  int yylen;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed. so pushing a state here evens the stacks.
     */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack. Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	short *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow ("parser stack overflow",
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyoverflowlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyoverflowlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	short *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyoverflowlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YYDSYMPRINTF ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */
  YYDPRINTF ((stderr, "Shifting token %s, ", yytname[yytoken]));

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;


  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  yystate = yyn;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 91 "parser.y"
    { yylval.voidp = pu_PROG(yyvsp[-3].voidp, yyvsp[-1].voidp); YYACCEPT; }
    break;

  case 3:
#line 94 "parser.y"
    { yyval.voidp = pu_BLOCK(yyvsp[-4].voidp, yyvsp[-3].voidp, yyvsp[-2].voidp, yyvsp[-1].voidp, yyvsp[0].voidp); }
    break;

  case 4:
#line 97 "parser.y"
    { yyval.voidp = mk_none(); }
    break;

  case 5:
#line 99 "parser.y"
    { yyval.voidp = mk_some(yyvsp[0].voidp); }
    break;

  case 6:
#line 106 "parser.y"
    { yyval.voidp = yyvsp[0].voidp; }
    break;

  case 7:
#line 108 "parser.y"
    { yyval.voidp = mk_nil(); }
    break;

  case 8:
#line 111 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[0].voidp, mk_nil()); }
    break;

  case 9:
#line 113 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[-1].voidp, yyvsp[0].voidp); }
    break;

  case 10:
#line 116 "parser.y"
    { yyval.voidp = pu_CONBND(yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 11:
#line 119 "parser.y"
    { yyval.voidp = pu_Constant_INTcon(yyvsp[0].voidp); }
    break;

  case 12:
#line 121 "parser.y"
    { yyval.voidp = pu_Constant_REALcon(yyvsp[0].voidp); }
    break;

  case 13:
#line 123 "parser.y"
    { yyval.voidp = pu_Constant_IDENTcon(yyvsp[0].voidp); }
    break;

  case 14:
#line 130 "parser.y"
    { yyval.voidp = yyvsp[0].voidp; }
    break;

  case 15:
#line 132 "parser.y"
    { yyval.voidp = mk_nil(); }
    break;

  case 16:
#line 135 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[0].voidp, mk_nil()); }
    break;

  case 17:
#line 137 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[-1].voidp, yyvsp[0].voidp); }
    break;

  case 18:
#line 140 "parser.y"
    { yyval.voidp = pu_TYBND(yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 19:
#line 143 "parser.y"
    { yyval.voidp = pu_Ty_NAME(yyvsp[0].voidp); }
    break;

  case 20:
#line 145 "parser.y"
    { yyval.voidp = pu_Ty_PTR(yyvsp[0].voidp); }
    break;

  case 21:
#line 147 "parser.y"
    { yyval.voidp = pu_Ty_ARR(yyvsp[-3].voidp, yyvsp[0].voidp); }
    break;

  case 22:
#line 149 "parser.y"
    { yyval.voidp = pu_Ty_REC(yyvsp[-1].voidp); }
    break;

  case 23:
#line 156 "parser.y"
    { yyval.voidp = yyvsp[0].voidp; }
    break;

  case 24:
#line 158 "parser.y"
    { yyval.voidp = mk_nil(); }
    break;

  case 25:
#line 161 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[0].voidp, mk_nil()); }
    break;

  case 26:
#line 163 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[-1].voidp, yyvsp[0].voidp); }
    break;

  case 27:
#line 166 "parser.y"
    { yyval.voidp = pu_VARBND(yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 29:
#line 174 "parser.y"
    { yyval.voidp = mk_nil(); }
    break;

  case 30:
#line 177 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[0].voidp, mk_nil()); }
    break;

  case 31:
#line 179 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[-1].voidp, yyvsp[0].voidp); }
    break;

  case 32:
#line 182 "parser.y"
    { yyval.voidp = pu_SubBnd_PROCBND(yyvsp[-4].voidp, yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 33:
#line 184 "parser.y"
    { yyval.voidp = pu_SubBnd_FUNCBND(yyvsp[-6].voidp, yyvsp[-5].voidp, yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 34:
#line 187 "parser.y"
    { yyval.voidp = yyvsp[-1].voidp; }
    break;

  case 35:
#line 189 "parser.y"
    { yyval.voidp = mk_nil(); }
    break;

  case 36:
#line 191 "parser.y"
    { yyval.voidp = mk_nil(); }
    break;

  case 37:
#line 194 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[0].voidp, mk_nil()); }
    break;

  case 38:
#line 196 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 39:
#line 199 "parser.y"
    { yyval.voidp = pu_VARBND(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 40:
#line 206 "parser.y"
    { yyval.voidp = yyvsp[-1].voidp; }
    break;

  case 42:
#line 210 "parser.y"
    { yyval.voidp = pu_Stmt_SEQ(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 43:
#line 213 "parser.y"
    { yyval.voidp = pu_Stmt_IF(yyvsp[-3].voidp, yyvsp[-1].voidp, yyvsp[0].voidp); }
    break;

  case 44:
#line 215 "parser.y"
    { yyval.voidp = pu_Stmt_WHILE(yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 45:
#line 217 "parser.y"
    { yyval.voidp = pu_Stmt_PCALL(yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 46:
#line 219 "parser.y"
    { yyval.voidp = pu_Stmt_ASSIGN(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 47:
#line 221 "parser.y"
    { yyval.voidp = pu_Stmt_FRETURN(yyvsp[0].voidp); }
    break;

  case 48:
#line 223 "parser.y"
    { yyval.voidp = pu_Stmt_PRETURN(); }
    break;

  case 49:
#line 225 "parser.y"
    { yyval.voidp = pu_Stmt_SKIP(); }
    break;

  case 50:
#line 228 "parser.y"
    { yyval.voidp = pu_Stmt_IF(yyvsp[-3].voidp, yyvsp[-1].voidp, yyvsp[0].voidp); }
    break;

  case 52:
#line 232 "parser.y"
    { yyval.voidp = yyvsp[-1].voidp; }
    break;

  case 53:
#line 234 "parser.y"
    { yyval.voidp = pu_Stmt_SKIP(); }
    break;

  case 55:
#line 242 "parser.y"
    { yyval.voidp = mk_nil(); }
    break;

  case 56:
#line 245 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[0].voidp, mk_nil()); }
    break;

  case 57:
#line 247 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 60:
#line 253 "parser.y"
    { yyval.voidp = pu_Exp_EQUALITY(yyvsp[-2].voidp, yyvsp[-1].eop, yyvsp[0].voidp); }
    break;

  case 61:
#line 256 "parser.y"
    { yyval.eop = EOP_EQ; }
    break;

  case 62:
#line 258 "parser.y"
    { yyval.eop = EOP_NE; }
    break;

  case 64:
#line 262 "parser.y"
    { yyval.voidp = pu_Exp_RELATION(yyvsp[-2].voidp, yyvsp[-1].rop, yyvsp[0].voidp); }
    break;

  case 65:
#line 265 "parser.y"
    { yyval.rop = ROP_LT; }
    break;

  case 66:
#line 267 "parser.y"
    { yyval.rop = ROP_LE; }
    break;

  case 67:
#line 269 "parser.y"
    { yyval.rop = ROP_GE; }
    break;

  case 68:
#line 271 "parser.y"
    { yyval.rop = ROP_GT; }
    break;

  case 70:
#line 275 "parser.y"
    { yyval.voidp = pu_Exp_BINARY(yyvsp[-2].voidp, yyvsp[-1].bop, yyvsp[0].voidp); }
    break;

  case 71:
#line 278 "parser.y"
    { yyval.bop = BOP_IOR; }
    break;

  case 72:
#line 280 "parser.y"
    { yyval.bop = BOP_ADD; }
    break;

  case 73:
#line 282 "parser.y"
    { yyval.bop = BOP_SUB; }
    break;

  case 75:
#line 286 "parser.y"
    { yyval.voidp = pu_Exp_BINARY(yyvsp[-2].voidp, yyvsp[-1].bop, yyvsp[0].voidp); }
    break;

  case 76:
#line 289 "parser.y"
    { yyval.bop = BOP_IAND; }
    break;

  case 77:
#line 291 "parser.y"
    { yyval.bop = BOP_MUL; }
    break;

  case 78:
#line 293 "parser.y"
    { yyval.bop = BOP_RDIV; }
    break;

  case 79:
#line 295 "parser.y"
    { yyval.bop = BOP_IDIV; }
    break;

  case 80:
#line 297 "parser.y"
    { yyval.bop = BOP_IMOD; }
    break;

  case 82:
#line 301 "parser.y"
    { yyval.voidp = pu_Exp_UNARY(yyvsp[-1].uop, yyvsp[0].voidp); }
    break;

  case 83:
#line 304 "parser.y"
    { yyval.uop = UOP_ADDR; }
    break;

  case 84:
#line 306 "parser.y"
    { yyval.uop = UOP_NOT; }
    break;

  case 85:
#line 308 "parser.y"
    { yyval.uop = UOP_PLUS; }
    break;

  case 86:
#line 310 "parser.y"
    { yyval.uop = UOP_MINUS; }
    break;

  case 88:
#line 314 "parser.y"
    { yyval.voidp = pu_Exp_UNARY(UOP_INDIR, yyvsp[-1].voidp); }
    break;

  case 89:
#line 316 "parser.y"
    { yyval.voidp = pu_Exp_FIELD(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 90:
#line 318 "parser.y"
    { yyval.voidp = pu_Exp_UNARY(UOP_INDIR,
					    pu_Exp_BINARY(yyvsp[-3].voidp, BOP_ADD, yyvsp[-1].voidp)); }
    break;

  case 91:
#line 321 "parser.y"
    { yyval.voidp = pu_Exp_FCALL(yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 92:
#line 323 "parser.y"
    { yyval.voidp = pu_Exp_CAST(yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 93:
#line 326 "parser.y"
    { yyval.voidp = pu_Exp_IDENT(yyvsp[0].voidp); }
    break;

  case 94:
#line 328 "parser.y"
    { yyval.voidp = pu_Exp_INT(yyvsp[0].voidp); }
    break;

  case 95:
#line 330 "parser.y"
    { yyval.voidp = pu_Exp_REAL(yyvsp[0].voidp); }
    break;

  case 96:
#line 332 "parser.y"
    { yyval.voidp = yyvsp[-1].voidp; }
    break;


    }

/* Line 999 of yacc.c.  */
#line 1665 "y.tab.c"

  yyvsp -= yylen;
  yyssp -= yylen;


  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (YYPACT_NINF < yyn && yyn < YYLAST)
	{
	  YYSIZE_T yysize = 0;
	  int yytype = YYTRANSLATE (yychar);
	  const char* yyprefix;
	  char *yymsg;
	  int yyx;

	  /* Start YYX at -YYN if negative to avoid negative indexes in
	     YYCHECK.  */
	  int yyxbegin = yyn < 0 ? -yyn : 0;

	  /* Stay within bounds of both yycheck and yytname.  */
	  int yychecklim = YYLAST - yyn;
	  int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
	  int yycount = 0;

	  yyprefix = ", expecting ";
	  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	      {
		yysize += yystrlen (yyprefix) + yystrlen (yytname [yyx]);
		yycount += 1;
		if (yycount == 5)
		  {
		    yysize = 0;
		    break;
		  }
	      }
	  yysize += (sizeof ("syntax error, unexpected ")
		     + yystrlen (yytname[yytype]));
	  yymsg = (char *) YYSTACK_ALLOC (yysize);
	  if (yymsg != 0)
	    {
	      char *yyp = yystpcpy (yymsg, "syntax error, unexpected ");
	      yyp = yystpcpy (yyp, yytname[yytype]);

	      if (yycount < 5)
		{
		  yyprefix = ", expecting ";
		  for (yyx = yyxbegin; yyx < yyxend; ++yyx)
		    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
		      {
			yyp = yystpcpy (yyp, yyprefix);
			yyp = yystpcpy (yyp, yytname[yyx]);
			yyprefix = " or ";
		      }
		}
	      yyerror (yymsg);
	      YYSTACK_FREE (yymsg);
	    }
	  else
	    yyerror ("syntax error; also virtual memory exhausted");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror ("syntax error");
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      /* Return failure if at end of input.  */
      if (yychar == YYEOF)
        {
	  /* Pop the error token.  */
          YYPOPSTACK;
	  /* Pop the rest of the stack.  */
	  while (yyss < yyssp)
	    {
	      YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
	      yydestruct (yystos[*yyssp], yyvsp);
	      YYPOPSTACK;
	    }
	  YYABORT;
        }

      YYDSYMPRINTF ("Error: discarding", yytoken, &yylval, &yylloc);
      yydestruct (yytoken, &yylval);
      yychar = YYEMPTY;

    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*----------------------------------------------------.
| yyerrlab1 -- error raised explicitly by an action.  |
`----------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;

      YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
      yydestruct (yystos[yystate], yyvsp);
      yyvsp--;
      yystate = *--yyssp;

      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  YYDPRINTF ((stderr, "Shifting error token, "));

  *++yyvsp = yylval;


  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*----------------------------------------------.
| yyoverflowlab -- parser overflow comes here.  |
`----------------------------------------------*/
yyoverflowlab:
  yyerror ("parser stack overflow");
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  return yyresult;
}


#line 333 "parser.y"


#if	YYDEBUG
extern int yydebug;
#endif

static void yyerror(const char *msg)
{
#if	YYDEBUG
    if( yydebug )
	lexerror("%s at token %s\n", msg, lex_token_to_string(yychar));
    else
#endif
	lexerror("%s\n", msg);
}

static void yyprintf(const char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);
}
#define printf yyprintf

