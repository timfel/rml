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

/* Substitute the variable and function names.  */
#define yyparse aarmldbparse
#define yylex   aarmldblex
#define yyerror aarmldberror
#define yylval  aarmldblval
#define yychar  aarmldbchar
#define yydebug aarmldbdebug
#define yynerrs aarmldbnerrs


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




/* Copy the first part of user declarations.  */
#line 1 "parse-rdb.y"

#include <string.h>
#include <stdlib.h>
#include "rml.h"

extern int aarmldblex(void);

#define YYMAXDEPTH 100000000
#define YYDEBUG 1             



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
#line 17 "parse-rdb.y"
typedef union YYSTYPE {
  int vint;
  char *vid;
  rmldb_type_t *vtyp;
  rmldb_LISTty_t *vtyplist;
  rmldb_range_db_t *vrangep;
} YYSTYPE;
/* Line 190 of yacc.c.  */
#line 150 "parse-rdb.c"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 213 of yacc.c.  */
#line 162 "parse-rdb.c"

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
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   else
#    define YYSTACK_ALLOC alloca
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
#define YYFINAL  14
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   91

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  24
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  9
/* YYNRULES -- Number of rules. */
#define YYNRULES  26
/* YYNRULES -- Number of states. */
#define YYNSTATES  88

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   278

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
      15,    16,    17,    18,    19,    20,    21,    22,    23
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned char yyprhs[] =
{
       0,     0,     3,     4,     8,    10,    19,    35,    44,    51,
      60,    68,    72,    74,    78,    80,    84,    90,    93,    98,
     102,   104,   106,   110,   114,   117,   121
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const yysigned_char yyrhs[] =
{
      25,     0,    -1,    -1,    26,     4,    25,    -1,     3,    -1,
       5,    22,    15,    27,    14,    20,    15,    28,    -1,     6,
      22,    15,    27,    14,    10,    27,    11,    14,    20,    10,
      20,    15,    28,    11,    -1,     7,    22,    15,    27,    14,
      20,    15,    28,    -1,     8,    22,    15,    27,    14,    20,
      -1,     9,    22,    15,    27,    14,    20,    15,    28,    -1,
      23,    13,    23,    13,    23,    13,    23,    -1,    32,    12,
      32,    -1,    29,    -1,    30,    19,    29,    -1,    30,    -1,
      20,    15,    30,    -1,    20,    15,    30,    19,    29,    -1,
      30,    20,    -1,    16,    31,    17,    20,    -1,    16,    28,
      17,    -1,    21,    -1,    20,    -1,    28,    18,    31,    -1,
      28,    18,    28,    -1,    16,    17,    -1,    16,    31,    17,
      -1,    29,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short int yyrline[] =
{
       0,    65,    65,    66,    67,    74,    87,   100,   113,   122,
     138,   167,   175,   189,   197,   205,   213,   224,   232,   240,
     248,   256,   270,   278,   289,   297,   305
};
#endif

#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "T_EOF", "T_EOL", "T_VAL", "T_VAR",
  "T_CON", "T_TYPE", "T_RELATION", "T_LBRACK", "T_RBRACK", "T_FATARROW",
  "T_DOT", "T_MORE", "T_COLON", "T_LPAR", "T_RPAR", "T_COMMA", "T_STAR",
  "T_id", "T_tyvar", "T_file", "T_number", "$accept", "lines", "line",
  "range", "ty", "tuple_ty", "ty_sans_star", "ty_comma_seq2", "seq_ty", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const unsigned short int yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    24,    25,    25,    25,    26,    26,    26,    26,    26,
      27,    28,    28,    29,    29,    29,    29,    30,    30,    30,
      30,    30,    31,    31,    32,    32,    32
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     0,     3,     1,     8,    15,     8,     6,     8,
       7,     3,     1,     3,     1,     3,     5,     2,     4,     3,
       1,     1,     3,     3,     2,     3,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned char yydefact[] =
{
       2,     4,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     1,     2,     0,     0,     0,     0,
       0,     3,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     8,     0,
       0,     0,     0,     0,     0,     0,     0,    21,    20,     5,
      12,    14,     0,     0,     7,     9,     0,    24,     0,     0,
       0,     0,    17,     0,     0,    10,    19,     0,    25,     0,
      21,    15,    13,    26,    11,     0,    23,    22,    18,     0,
       0,     0,     0,    16,     0,     0,     0,     6
};

/* YYDEFGOTO[NTERM-NUM]. */
static const yysigned_char yydefgoto[] =
{
      -1,     7,     8,    23,    58,    50,    51,    59,    52
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -54
static const yysigned_char yypact[] =
{
       6,   -54,   -21,     3,    18,    23,    24,    43,    44,     7,
      32,    34,    35,    36,   -54,     6,    29,    29,    29,    29,
      29,   -54,    40,    41,    42,    45,    46,    47,    31,    37,
      48,    49,    50,    51,    52,    53,    29,    57,   -54,    58,
      39,     8,    55,     8,     8,    54,     0,    59,   -54,   -54,
      63,    -1,    64,    65,   -54,   -54,    60,   -54,    21,    61,
      14,    16,   -54,     8,    62,   -54,   -54,     8,    66,     8,
     -54,    22,   -54,   -54,   -54,    67,    69,   -54,   -54,    68,
      16,    70,    66,   -54,    73,     8,    78,   -54
};

/* YYPGOTO[NTERM-NUM].  */
static const yysigned_char yypgoto[] =
{
     -54,    76,   -54,   -13,   -41,   -53,     4,   -36,    17
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -27
static const yysigned_char yytable[] =
{
      49,     9,    54,    55,    24,    25,    26,    27,    72,     1,
      73,     2,     3,     4,     5,     6,    46,    57,    61,    62,
      47,    48,    16,    42,    46,    10,    76,    83,    47,    48,
      69,    77,    69,    79,    70,    48,    47,    48,    66,    67,
      11,    80,    62,    14,    86,    12,    13,    17,    15,    18,
      19,    20,    22,    28,    34,    29,    30,    35,    36,    31,
      32,    33,    45,     0,    71,    40,    53,    56,    41,    37,
      38,    39,    43,    44,    60,   -26,    63,    81,    68,    64,
      74,     0,    75,    65,     0,    82,    78,    67,    85,    87,
      84,    21
};

static const yysigned_char yycheck[] =
{
      41,    22,    43,    44,    17,    18,    19,    20,    61,     3,
      63,     5,     6,     7,     8,     9,    16,    17,    19,    20,
      20,    21,    15,    36,    16,    22,    67,    80,    20,    21,
      16,    67,    16,    69,    20,    21,    20,    21,    17,    18,
      22,    19,    20,     0,    85,    22,    22,    15,     4,    15,
      15,    15,    23,    13,    23,    14,    14,    20,    10,    14,
      14,    14,    23,    -1,    60,    13,    11,    13,    15,    20,
      20,    20,    15,    15,    15,    12,    12,    10,    17,    14,
      63,    -1,    20,    23,    -1,    17,    20,    18,    15,    11,
      20,    15
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,     3,     5,     6,     7,     8,     9,    25,    26,    22,
      22,    22,    22,    22,     0,     4,    15,    15,    15,    15,
      15,    25,    23,    27,    27,    27,    27,    27,    13,    14,
      14,    14,    14,    14,    23,    20,    10,    20,    20,    20,
      13,    15,    27,    15,    15,    23,    16,    20,    21,    28,
      29,    30,    32,    11,    28,    28,    13,    17,    28,    31,
      15,    19,    20,    12,    14,    23,    17,    18,    17,    16,
      20,    30,    29,    29,    32,    20,    28,    31,    20,    31,
      19,    10,    17,    29,    20,    15,    28,    11
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


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (N)								\
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (0)
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
              (Loc).first_line, (Loc).first_column,	\
              (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
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

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)		\
do {								\
  if (yydebug)							\
    {								\
      YYFPRINTF (stderr, "%s ", Title);				\
      yysymprint (stderr, 					\
                  Type, Value);	\
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
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
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
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);


# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
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
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

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



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
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
  /* Look-ahead token as an internal (translated) token number.  */
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


  yyvsp[0] = yylval;

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
/* Read a look-ahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to look-ahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
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
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
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

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

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
        case 4:
#line 68 "parse-rdb.y"
    {
		YYACCEPT;
	;}
    break;

  case 5:
#line 75 "parse-rdb.y"
    {
	/* l:<Builtin.rml>:660.5.660.20|n2real2arrayreal:Types.TType*'a option */
	rmldb_var_db_t* rmldb_var_db_node = 
		rmldb_make_rmldb_var_db((yyvsp[-6].vid), (yyvsp[-4].vrangep), (yyvsp[-4].vrangep), "_VL_", (yyvsp[-2].vid), 
			rmldb_make_rmldb_type_db_t((yyvsp[0].vtyp)));		
	rmldb_var_db_add(&rmldb_var_db_start, &rmldb_var_db_end, rmldb_var_db_node);
#ifdef _DEBUG_RDB_
	fprintf(stderr, "file[%s],relation[%s],variable[%s] -> ",(yyvsp[-6].vid),"_VL_",(yyvsp[-2].vid));
	rmldb_print_type((yyvsp[0].vtyp), 1, stderr);
	fprintf(stderr,"\n");
#endif
;}
    break;

  case 6:
#line 88 "parse-rdb.y"
    {
	/* v:<main.rml>:99.53.99.57|[97.9.99.86]|buildNormalAst[stmts:Absyn.Stmt list] */
	rmldb_var_db_t* rmldb_var_db_node = 
		rmldb_make_rmldb_var_db((yyvsp[-13].vid), (yyvsp[-11].vrangep), (yyvsp[-8].vrangep), (yyvsp[-5].vid), (yyvsp[-3].vid), 
			rmldb_make_rmldb_type_db_t((yyvsp[-1].vtyp)));		
	rmldb_var_db_add(&rmldb_var_db_start, &rmldb_var_db_end, rmldb_var_db_node);
#ifdef _DEBUG_RDB_
	fprintf(stderr, "file[%s],relation[%s],variable[%s] -> ",(yyvsp[-13].vid),(yyvsp[-5].vid),(yyvsp[-3].vid));
	rmldb_print_type((yyvsp[-1].vtyp), 1, stderr);
	fprintf(stderr,"\n");
#endif
;}
    break;

  case 7:
#line 101 "parse-rdb.y"
    {
	/* c:<values.rml>:47.20.47.25|Values.RECORD:(Values.Value list,string list) => Values.Value */
	rmldb_con_db_t* rmldb_con_db_node = 
		rmldb_make_rmldb_con_db((yyvsp[-6].vid), (yyvsp[-4].vrangep), (yyvsp[-2].vid), 
			rmldb_make_rmldb_type_db_t((yyvsp[0].vtyp)),0);		
	rmldb_con_db_add(&rmldb_con_db_start, &rmldb_con_db_end, rmldb_con_db_node); 
#ifdef _DEBUG_RDB_
	fprintf(stderr,"file[%s],con[%s],type: ",(yyvsp[-6].vid),(yyvsp[-2].vid));
	rmldb_print_type((yyvsp[0].vtyp), 1, stderr);
	fprintf(stderr,"\n"); 
#endif
;}
    break;

  case 8:
#line 114 "parse-rdb.y"
    {
	/* t:<values.rml>:40.12.40.16|Values.Value */
	rmldb_type_db_t* rmldb_type_db_node = rmldb_make_rmldb_type_db((yyvsp[-4].vid), (yyvsp[-2].vrangep), (yyvsp[0].vid));	
	rmldb_type_db_add(&rmldb_type_db_start, &rmldb_type_db_end, rmldb_type_db_node); 
#ifdef _DEBUG_RDB_
	fprintf(stderr,"file[%s],type[%p]\n",(yyvsp[-4].vid),(yyvsp[0].vid)); 
#endif
;}
    break;

  case 9:
#line 123 "parse-rdb.y"
    {
	/* r:<values.rml>:428.10.428.20|Values.mult_matrix:(Values.Value list,Values.Value list) => Values.Value list */
	rmldb_relation_db_t* rmldb_relation_db_node = 
		rmldb_make_rmldb_relation_db((yyvsp[-6].vid), (yyvsp[-4].vrangep), (yyvsp[-2].vid), 
			rmldb_make_rmldb_type_db_t((yyvsp[0].vtyp)));
	rmldb_relation_db_add(&rmldb_relation_db_start, &rmldb_relation_db_end, rmldb_relation_db_node); 
#ifdef _DEBUG_RDB_
	fprintf(stderr, "file[%s],relation[%s],type: ",(yyvsp[-6].vid),(yyvsp[-2].vid));  
	rmldb_print_type((yyvsp[0].vtyp), 1, stderr);
	fprintf(stderr,"\n");
#endif
;}
    break;

  case 10:
#line 139 "parse-rdb.y"
    {
	  rmldb_range_db_t *pRange;
	  pRange = (rmldb_range_db_t*) malloc (sizeof(rmldb_range_db_t));
	  /* printf ("%d,%d,%d,%d", $1, $3, $5, $7); */
	  pRange->sl = (yyvsp[-6].vint); pRange->sc = (yyvsp[-4].vint);
	  pRange->el = (yyvsp[-2].vint); pRange->ec = (yyvsp[0].vint);
	  (yyval.vrangep)  = pRange;
	;}
    break;

  case 11:
#line 168 "parse-rdb.y"
    {
	  /* 
	  Absyn.RELty(seq_ty1, seq_ty2) 
	  printf ("Ty.REL(%p,%p)",$1,$3);
	  */
	  (yyval.vtyp)  = rmldb_make_rmldb_type(RMLDB_eRELty, (void*)rmldb_make_rmldb_RELty((yyvsp[-2].vtyplist), (yyvsp[0].vtyplist)));
    ;}
    break;

  case 12:
#line 176 "parse-rdb.y"
    {
		/* 
		mktuplety(tuple_ty)
		printf ("Ty.TUPLE(%p)",$1);
		*/
		if ((yyvsp[0].vtyplist)->length > 1)
			(yyval.vtyp) = rmldb_make_rmldb_type(RMLDB_eTUPLEty, (void*)rmldb_make_rmldb_TUPLEty((yyvsp[0].vtyplist)));
		else 
			(yyval.vtyp)  = (yyvsp[0].vtyplist)->list_start;
	;}
    break;

  case 13:
#line 190 "parse-rdb.y"
    {
	   /* 
	   ty_sans_star :: tuple_ty 
	   printf ("Ty.LIST(%p,%p)",$1,$3);
	   */
	  (yyval.vtyplist) = rmldb_make_cons_rmldb_LISTty((yyvsp[-2].vtyp),(yyvsp[0].vtyplist));
	;}
    break;

  case 14:
#line 198 "parse-rdb.y"
    {
		/* 
		[ty_sans_star]
	    printf ("Ty.LIST(%p)",$1);
	    */		
		(yyval.vtyplist)  =  rmldb_make_rmldb_LISTty((yyvsp[0].vtyp),NULL);
	;}
    break;

  case 15:
#line 206 "parse-rdb.y"
    {
		/*
		( [ Absyn.NAMEDty(ident, ty_sans_star, makeInfo lexArg (identleft, ty_sans_starright)) ] )
		*/
		(yyvsp[0].vtyp)->name = (yyvsp[-2].vid);
		(yyval.vtyplist)  =  rmldb_make_rmldb_LISTty((yyvsp[0].vtyp),NULL);
	;}
    break;

  case 16:
#line 214 "parse-rdb.y"
    {
		/*
		( Absyn.NAMEDty(ident, ty_sans_star, makeInfo lexArg (identleft, tuple_tyright)) :: tuple_ty )
		*/
		(yyvsp[-2].vtyp)->name = (yyvsp[-4].vid);
		(yyval.vtyplist)  =  rmldb_make_cons_rmldb_LISTty((yyvsp[-2].vtyp),(yyvsp[0].vtyplist));		
	;}
    break;

  case 17:
#line 225 "parse-rdb.y"
    {
	  /* 
	  ( Absyn.CONSty([ty_sans_star], longorshortid) 
	  printf ("Ty.CONSty(list:%p,%s)",$1,$2);		
	  */
	  (yyval.vtyp)  =  rmldb_make_rmldb_type(RMLDB_eCONSty, (void*)rmldb_make_rmldb_CONSty(rmldb_make_rmldb_LISTty((yyvsp[-1].vtyp),NULL), (yyvsp[0].vid)));
	;}
    break;

  case 18:
#line 233 "parse-rdb.y"
    {
		/*
		printf ("(Ty.CONSty(list:%p,%s))",$2,$4); 
		( Absyn.CONSty(ty_comma_seq2, longorshortid) 
		*/	
	    (yyval.vtyp)  =  rmldb_make_rmldb_type(RMLDB_eCONSty, (void*)rmldb_make_rmldb_CONSty((yyvsp[-2].vtyplist),(yyvsp[0].vid)));
	;}
    break;

  case 19:
#line 241 "parse-rdb.y"
    {
	  /* 
	  ty 
	  printf ("Ty(:%p)",$2);
	  */	  
	  (yyval.vtyp)  =  (yyvsp[-1].vtyp);
	;}
    break;

  case 20:
#line 249 "parse-rdb.y"
    {
		/* 
	    printf ("Tyvar(:%p)",$1);	  
		( Absyn.VARty(tyvar, makeInfo myLoc (tyvarleft, tyvarright)) ) 
		*/
		(yyval.vtyp)  =  rmldb_make_rmldb_type(RMLDB_eVARty, (void*)rmldb_make_rmldb_VARty((yyvsp[0].vid)));
	;}
    break;

  case 21:
#line 257 "parse-rdb.y"
    {
		/* 		
		( Absyn.CONSty([], longorshortid,
	    printf ("Ty.CONSty(:%s)",$1);	  	
	    */
		(yyval.vtyp)  =  rmldb_make_rmldb_type(
				RMLDB_eCONSty, 
				(void*)rmldb_make_rmldb_CONSty(
					rmldb_make_rmldb_LISTty(NULL,NULL), (yyvsp[0].vid)));
	;}
    break;

  case 22:
#line 271 "parse-rdb.y"
    {	  	
		/* 
		( ty :: ty_comma_seq2 )
		printf ("TyList(:%p,%p)",$1,$3); 
		*/
	  	(yyval.vtyplist) = rmldb_make_cons_rmldb_LISTty((yyvsp[-2].vtyp),(yyvsp[0].vtyplist));
	;}
    break;

  case 23:
#line 279 "parse-rdb.y"
    {
		/* 
		( [ty1, ty2] ) 
		printf ("TyList(:%p,%p)",$1,$3);
		*/
	  	(yyval.vtyplist) = rmldb_make_rmldb_LISTty((yyvsp[-2].vtyp),(yyvsp[0].vtyp));
	;}
    break;

  case 24:
#line 290 "parse-rdb.y"
    { 
		/*
		([])
		printf ("seq_ty_empty");
		*/		
		(yyval.vtyplist) = rmldb_make_rmldb_LISTty(NULL, NULL); 
	;}
    break;

  case 25:
#line 298 "parse-rdb.y"
    {
		/* 
		printf ("(Ty_comma_seq2(%p))",$2);
		( ty_comma_seq2 ) 
		*/
		(yyval.vtyplist)  =  (yyvsp[-1].vtyplist);
	;}
    break;

  case 26:
#line 306 "parse-rdb.y"
    {
		/*
		printf ("Ty.TUPLE(%p)",$1);	
		( [mktuplety(tuple_ty)] ) 
		*/
		if ((yyvsp[0].vtyplist)->length > 1)
			(yyval.vtyplist) = rmldb_make_rmldb_LISTty(
						rmldb_make_rmldb_type(
							RMLDB_eTUPLEty, 
							(void*)rmldb_make_rmldb_TUPLEty((yyvsp[0].vtyplist))),NULL);
		else 
			(yyval.vtyplist)  = rmldb_make_rmldb_LISTty((yyvsp[0].vtyplist)->list_start,NULL);
	;}
    break;


    }

/* Line 1037 of yacc.c.  */
#line 1408 "parse-rdb.c"

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
      /* If just tried and failed to reuse look-ahead token after an
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
		 yydestruct ("Error: popping",
                             yystos[*yyssp], yyvsp);
	       }
        }
      else
	{
	  yydestruct ("Error: discarding", yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
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


      yydestruct ("Error: popping", yystos[yystate], yyvsp);
      YYPOPSTACK;
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token. */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

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
  yydestruct ("Error: discarding lookahead",
              yytoken, &yylval);
  yychar = YYEMPTY;
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


#line 322 "parse-rdb.y"


int aarmldberror(char *s) 
{
  fprintf(stderr, "%s at line: %d\n", s, aarmldb_lineno);
  return  -1;
}

