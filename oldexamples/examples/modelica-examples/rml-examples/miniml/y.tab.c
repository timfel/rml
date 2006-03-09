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
    enum bop	bop;
} YYSTYPE;
/* Line 191 of yacc.c.  */
#line 158 "y.tab.c"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 214 of yacc.c.  */
#line 170 "y.tab.c"

#if ! defined (yyoverflow) || YYERROR_VERBOSE

# ifndef YYFREE
#  define YYFREE free
# endif
# ifndef YYMALLOC
#  define YYMALLOC malloc
# endif

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   define YYSTACK_ALLOC alloca
#  endif
# else
#  if defined (alloca) || defined (_ALLOCA_H)
#   define YYSTACK_ALLOC alloca
#  else
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
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
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
# endif
#endif /* ! defined (yyoverflow) || YYERROR_VERBOSE */


#if (! defined (yyoverflow) \
     && (! defined (__cplusplus) \
	 || (defined (YYSTYPE_IS_TRIVIAL) && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  short int yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short int) + sizeof (YYSTYPE))			\
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined (__GNUC__) && 1 < __GNUC__
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
   typedef short int yysigned_char;
#endif

/* YYFINAL -- State number of the termination state. */
#define YYFINAL  8
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   129

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  35
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  21
/* YYNRULES -- Number of rules. */
#define YYNRULES  57
/* YYNRULES -- Number of states. */
#define YYNSTATES  101

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   289

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
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned char yyprhs[] =
{
       0,     0,     3,     5,     6,    10,    12,    13,    18,    22,
      24,    26,    31,    33,    40,    42,    46,    48,    52,    54,
      56,    58,    60,    64,    66,    70,    72,    74,    76,    80,
      82,    84,    86,    88,    90,    93,    95,    97,    99,   101,
     104,   108,   114,   120,   129,   137,   140,   143,   146,   149,
     151,   153,   155,   157,   159,   162,   166,   170
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const yysigned_char yyrhs[] =
{
      36,     0,    -1,    37,    -1,    -1,    39,    38,    37,    -1,
      31,    -1,    -1,    34,    14,     9,    40,    -1,    12,    14,
      55,    -1,    41,    -1,    42,    -1,    11,    14,    10,    40,
      -1,    43,    -1,    16,    40,    33,    40,     7,    40,    -1,
      44,    -1,    43,     4,    44,    -1,    46,    -1,    44,    45,
      46,    -1,     9,    -1,    19,    -1,    23,    -1,    47,    -1,
      46,     3,    47,    -1,    49,    -1,    47,    48,    49,    -1,
       6,    -1,    25,    -1,    51,    -1,    49,    50,    51,    -1,
      15,    -1,    17,    -1,    28,    -1,    32,    -1,    52,    -1,
      51,    52,    -1,    13,    -1,    27,    -1,    30,    -1,    14,
      -1,    22,    29,    -1,    22,    40,    29,    -1,    22,    40,
       5,    40,    29,    -1,    22,    40,    31,    40,    29,    -1,
      20,    34,    14,     9,    40,    18,    40,     8,    -1,    20,
      12,    14,    55,    18,    40,     8,    -1,    21,    26,    -1,
      21,    54,    -1,    24,    53,    -1,    24,    14,    -1,     4,
      -1,     3,    -1,    45,    -1,    48,    -1,    50,    -1,    40,
      26,    -1,    40,     5,    54,    -1,    14,     9,    40,    -1,
      14,    55,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned char yyrline[] =
{
       0,    64,    64,    66,    67,    69,    70,    72,    74,    77,
      79,    80,    83,    84,    87,    88,    91,    92,    95,    96,
      97,    99,   100,   103,   104,   107,   108,   110,   111,   114,
     115,   116,   117,   119,   120,   122,   123,   124,   125,   126,
     127,   128,   129,   131,   133,   135,   136,   137,   138,   140,
     141,   142,   143,   144,   146,   149,   152,   153
};
#endif

#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "T_COLONCOLON", "T_COLONEQ", "T_COMMA",
  "T_DASH", "T_ELSE", "T_END", "T_EQ", "T_FATARROW", "T_FN", "T_FUN",
  "T_ICON", "T_IDENT", "T_IDIV", "T_IF", "T_IMOD", "T_IN", "T_LE", "T_LET",
  "T_LBRACK", "T_LPAREN", "T_LT", "T_OP", "T_PLUS", "T_RBRACK", "T_RCON",
  "T_RDIV", "T_RPAREN", "T_SCON", "T_SEMI", "T_STAR", "T_THEN", "T_VAL",
  "$accept", "program", "alldecs", "opt_semi", "topdec", "exp", "lam_exp",
  "if_exp", "infl3exp", "infl4exp", "infl4op", "infr5exp", "infl6exp",
  "infl6op", "infl7exp", "infl7op", "app_exp", "at_exp", "operator",
  "exp_plus", "fun", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const unsigned short int yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    35,    36,    37,    37,    38,    38,    39,    39,    40,
      41,    41,    42,    42,    43,    43,    44,    44,    45,    45,
      45,    46,    46,    47,    47,    48,    48,    49,    49,    50,
      50,    50,    50,    51,    51,    52,    52,    52,    52,    52,
      52,    52,    52,    52,    52,    52,    52,    52,    52,    53,
      53,    53,    53,    53,    54,    54,    55,    55
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     1,     0,     3,     1,     0,     4,     3,     1,
       1,     4,     1,     6,     1,     3,     1,     3,     1,     1,
       1,     1,     3,     1,     3,     1,     1,     1,     3,     1,
       1,     1,     1,     1,     2,     1,     1,     1,     1,     2,
       3,     5,     5,     8,     7,     2,     2,     2,     2,     1,
       1,     1,     1,     1,     2,     3,     3,     2
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned char yydefact[] =
{
       3,     0,     0,     0,     2,     6,     0,     0,     1,     5,
       3,     0,     8,     0,     4,     0,    57,     0,    35,    38,
       0,     0,     0,     0,     0,    36,    37,     7,     9,    10,
      12,    14,    16,    21,    23,    27,    33,    56,     0,     0,
       0,     0,    45,     0,    46,    39,     0,    50,    49,    25,
      18,    48,    29,    30,    19,    20,    26,    31,    32,    51,
      52,    53,    47,     0,     0,     0,     0,     0,    34,     0,
       0,     0,     0,     0,    54,     0,    40,     0,    15,    17,
      22,    24,    28,    11,     0,     0,     0,    55,     0,     0,
       0,     0,     0,    41,    42,    13,     0,     0,    44,     0,
      43
};

/* YYDEFGOTO[NTERM-NUM]. */
static const yysigned_char yydefgoto[] =
{
      -1,     3,     4,    10,     5,    43,    28,    29,    30,    31,
      64,    32,    33,    66,    34,    67,    35,    36,    62,    44,
      12
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -33
static const yysigned_char yypact[] =
{
      -8,    -1,     8,    20,   -33,    -2,     9,    23,   -33,   -33,
      -8,    31,   -33,    99,   -33,    99,   -33,    27,   -33,   -33,
      99,     3,    69,    87,     2,   -33,   -33,   -33,   -33,   -33,
      38,     5,    40,     6,    21,    45,   -33,   -33,    34,    14,
      32,    37,   -33,    13,   -33,   -33,     4,   -33,   -33,   -33,
     -33,   -33,   -33,   -33,   -33,   -33,   -33,   -33,   -33,   -33,
     -33,   -33,   -33,    45,    45,    45,    45,    45,   -33,    99,
      99,     9,    39,    99,   -33,    99,   -33,    99,     5,    40,
       6,    21,    45,   -33,    47,    42,    99,   -33,    26,    41,
      99,    99,    50,   -33,   -33,   -33,    44,    99,   -33,    55,
     -33
};

/* YYPGOTO[NTERM-NUM].  */
static const yysigned_char yypgoto[] =
{
     -33,   -33,    61,   -33,   -33,   -13,   -33,   -33,   -33,    11,
      52,    15,    16,    62,    22,    63,    25,   -32,   -33,    24,
     -10
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const unsigned char yytable[] =
{
      27,    16,    37,    68,     1,    47,    48,    39,    49,    75,
      46,    50,    49,     6,    50,    40,    51,    52,    73,    53,
       8,    54,     7,    11,    54,    55,     2,    56,    55,     9,
      57,    56,    13,    76,    58,    77,    52,    41,    53,    74,
      15,    38,    63,    65,    69,    11,    71,    70,    86,    57,
      68,    72,    98,    58,    90,    93,    83,    84,    18,    19,
      91,    85,    88,   100,    89,    21,    22,    23,    97,    24,
      94,    14,    25,    92,    78,    26,    59,    95,    96,    79,
      17,    80,    18,    19,    99,    20,    60,    61,    81,    21,
      22,    23,    82,    24,     0,    42,    25,    87,    17,    26,
      18,    19,     0,    20,     0,     0,     0,    21,    22,    23,
      17,    24,    18,    19,    25,    20,    45,    26,     0,    21,
      22,    23,     0,    24,     0,     0,    25,     0,     0,    26
};

static const yysigned_char yycheck[] =
{
      13,    11,    15,    35,    12,     3,     4,    20,     6,     5,
      23,     9,     6,    14,     9,    12,    14,    15,     5,    17,
       0,    19,    14,    14,    19,    23,    34,    25,    23,    31,
      28,    25,     9,    29,    32,    31,    15,    34,    17,    26,
       9,    14,     4,     3,    10,    14,    14,    33,     9,    28,
      82,    14,     8,    32,     7,    29,    69,    70,    13,    14,
      18,    71,    75,     8,    77,    20,    21,    22,    18,    24,
      29,    10,    27,    86,    63,    30,    24,    90,    91,    64,
      11,    65,    13,    14,    97,    16,    24,    24,    66,    20,
      21,    22,    67,    24,    -1,    26,    27,    73,    11,    30,
      13,    14,    -1,    16,    -1,    -1,    -1,    20,    21,    22,
      11,    24,    13,    14,    27,    16,    29,    30,    -1,    20,
      21,    22,    -1,    24,    -1,    -1,    27,    -1,    -1,    30
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,    12,    34,    36,    37,    39,    14,    14,     0,    31,
      38,    14,    55,     9,    37,     9,    55,    11,    13,    14,
      16,    20,    21,    22,    24,    27,    30,    40,    41,    42,
      43,    44,    46,    47,    49,    51,    52,    40,    14,    40,
      12,    34,    26,    40,    54,    29,    40,     3,     4,     6,
       9,    14,    15,    17,    19,    23,    25,    28,    32,    45,
      48,    50,    53,     4,    45,     3,    48,    50,    52,    10,
      33,    14,    14,     5,    26,     5,    29,    31,    44,    46,
      47,    49,    51,    40,    40,    55,     9,    54,    40,    40,
       7,    18,    40,    29,    29,    40,    40,    18,     8,    40,
       8
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
#define YYERROR		goto yyerrorlab


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
# define YYLLOC_DEFAULT(Current, Rhs, N)		\
   ((Current).first_line   = (Rhs)[1].first_line,	\
    (Current).first_column = (Rhs)[1].first_column,	\
    (Current).last_line    = (Rhs)[N].last_line,	\
    (Current).last_column  = (Rhs)[N].last_column)
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
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_stack_print (short int *bottom, short int *top)
#else
static void
yy_stack_print (bottom, top)
    short int *bottom;
    short int *top;
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

#if defined (YYMAXDEPTH) && YYMAXDEPTH == 0
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
  short int yyssa[YYINITDEPTH];
  short int *yyss = yyssa;
  register short int *yyssp;

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
	short int *yyss1 = yyss;


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
	short int *yyss1 = yyss;
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
#line 64 "parser.y"
    { yylval.voidp = yyvsp[0].voidp; YYACCEPT; }
    break;

  case 3:
#line 66 "parser.y"
    { yyval.voidp = mk_nil(); }
    break;

  case 4:
#line 67 "parser.y"
    { yyval.voidp = mk_cons(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 7:
#line 73 "parser.y"
    { yyval.voidp = pu_dec_val(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 8:
#line 75 "parser.y"
    { yyval.voidp = pu_dec_val(yyvsp[-1].voidp, pu_exp_letrec(yyvsp[-1].voidp, yyvsp[0].voidp, pu_exp_var(yyvsp[-1].voidp))); }
    break;

  case 11:
#line 81 "parser.y"
    { yyval.voidp = pu_exp_lam(pu_lambda(yyvsp[-2].voidp, yyvsp[0].voidp)); }
    break;

  case 13:
#line 85 "parser.y"
    { yyval.voidp = pu_exp_if(yyvsp[-4].voidp, yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 15:
#line 89 "parser.y"
    { yyval.voidp = pu_exp_app(pu_bop_var(BOP_SET), pu_exp_pair(yyvsp[-2].voidp, yyvsp[0].voidp)); }
    break;

  case 17:
#line 93 "parser.y"
    { yyval.voidp = pu_exp_app(pu_bop_var(yyvsp[-1].bop), pu_exp_pair(yyvsp[-2].voidp, yyvsp[0].voidp)); }
    break;

  case 18:
#line 95 "parser.y"
    { yyval.bop = BOP_EQ; }
    break;

  case 19:
#line 96 "parser.y"
    { yyval.bop = BOP_LE; }
    break;

  case 20:
#line 97 "parser.y"
    { yyval.bop = BOP_LT; }
    break;

  case 22:
#line 101 "parser.y"
    { yyval.voidp = pu_exp_app(pu_bop_var(BOP_CONS), pu_exp_pair(yyvsp[-2].voidp, yyvsp[0].voidp)); }
    break;

  case 24:
#line 105 "parser.y"
    { yyval.voidp = pu_exp_app(pu_bop_var(yyvsp[-1].bop), pu_exp_pair(yyvsp[-2].voidp, yyvsp[0].voidp)); }
    break;

  case 25:
#line 107 "parser.y"
    { yyval.bop = BOP_SUB; }
    break;

  case 26:
#line 108 "parser.y"
    { yyval.bop = BOP_ADD; }
    break;

  case 28:
#line 112 "parser.y"
    { yyval.voidp = pu_exp_app(pu_bop_var(yyvsp[-1].bop), pu_exp_pair(yyvsp[-2].voidp, yyvsp[0].voidp)); }
    break;

  case 29:
#line 114 "parser.y"
    { yyval.bop = BOP_IDIV; }
    break;

  case 30:
#line 115 "parser.y"
    { yyval.bop = BOP_IMOD; }
    break;

  case 31:
#line 116 "parser.y"
    { yyval.bop = BOP_RDIV; }
    break;

  case 32:
#line 117 "parser.y"
    { yyval.bop = BOP_MUL; }
    break;

  case 34:
#line 120 "parser.y"
    { yyval.voidp = pu_exp_app(yyvsp[-1].voidp, yyvsp[0].voidp); }
    break;

  case 35:
#line 122 "parser.y"
    { yyval.voidp = pu_exp_icon(yyvsp[0].voidp); }
    break;

  case 36:
#line 123 "parser.y"
    { yyval.voidp = pu_exp_rcon(yyvsp[0].voidp); }
    break;

  case 37:
#line 124 "parser.y"
    { yyval.voidp = pu_exp_scon(yyvsp[0].voidp); }
    break;

  case 38:
#line 125 "parser.y"
    { yyval.voidp = pu_exp_var(yyvsp[0].voidp); }
    break;

  case 39:
#line 126 "parser.y"
    { yyval.voidp = pu_exp_unit(); }
    break;

  case 40:
#line 127 "parser.y"
    { yyval.voidp = yyvsp[-1].voidp; }
    break;

  case 41:
#line 128 "parser.y"
    { yyval.voidp = pu_exp_pair(yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 42:
#line 130 "parser.y"
    { yyval.voidp = pu_exp_let(mk_scon("_"), yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 43:
#line 132 "parser.y"
    { yyval.voidp = pu_exp_let(yyvsp[-5].voidp, yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 44:
#line 134 "parser.y"
    { yyval.voidp = pu_exp_letrec(yyvsp[-4].voidp, yyvsp[-3].voidp, yyvsp[-1].voidp); }
    break;

  case 45:
#line 135 "parser.y"
    { yyval.voidp = pu_exp_nil(); }
    break;

  case 46:
#line 136 "parser.y"
    { yyval.voidp = yyvsp[0].voidp; }
    break;

  case 47:
#line 137 "parser.y"
    { yyval.voidp = pu_bop_var(yyvsp[0].bop); }
    break;

  case 48:
#line 138 "parser.y"
    { yyval.voidp = pu_exp_var(yyvsp[0].voidp); }
    break;

  case 49:
#line 140 "parser.y"
    { yyval.bop = BOP_SET; }
    break;

  case 50:
#line 141 "parser.y"
    { yyval.bop = BOP_CONS; }
    break;

  case 54:
#line 147 "parser.y"
    { yyval.voidp = pu_exp_app(pu_bop_var(BOP_CONS),
				  pu_exp_pair(yyvsp[-1].voidp, pu_exp_nil())); }
    break;

  case 55:
#line 150 "parser.y"
    { yyval.voidp = pu_exp_app(pu_bop_var(BOP_CONS), pu_exp_pair(yyvsp[-2].voidp, yyvsp[0].voidp)); }
    break;

  case 56:
#line 152 "parser.y"
    { yyval.voidp = pu_lambda(yyvsp[-2].voidp, yyvsp[0].voidp); }
    break;

  case 57:
#line 153 "parser.y"
    { yyval.voidp = pu_lambda(yyvsp[-1].voidp, pu_exp_lam(yyvsp[0].voidp)); }
    break;


    }

/* Line 1010 of yacc.c.  */
#line 1358 "y.tab.c"

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

      if (yychar <= YYEOF)
        {
          /* If at end of input, pop the error token,
	     then the rest of the stack, then return failure.  */
	  if (yychar == YYEOF)
	     for (;;)
	       {
		 YYPOPSTACK;
		 if (yyssp == yyss)
		   YYABORT;
		 YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
		 yydestruct (yystos[*yyssp], yyvsp);
	       }
        }
      else
	{
	  YYDSYMPRINTF ("Error: discarding", yytoken, &yylval, &yylloc);
	  yydestruct (yytoken, &yylval);
	  yychar = YYEMPTY;

	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

#ifdef __GNUC__
  /* Pacify GCC when the user code never invokes YYERROR and the label
     yyerrorlab therefore never appears in user code.  */
  if (0)
     goto yyerrorlab;
#endif

  yyvsp -= yylen;
  yyssp -= yylen;
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
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
      YYPOPSTACK;
      yystate = *yyssp;
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


#line 154 "parser.y"


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

