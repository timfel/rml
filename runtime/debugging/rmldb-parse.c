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

/* If NAME_PREFIX is specified substitute the variables and functions
   names.  */
#define yyparse aaparse
#define yylex   aalex
#define yyerror aaerror
#define yylval  aalval
#define yychar  aachar
#define yydebug aadebug
#define yynerrs aanerrs


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




/* Copy the first part of user declarations.  */
#line 1 "rmldb-parse.y"


#include "rml.h"

extern int aalex(void);

#define YYDEBUG 1
#define YYERROR_VERBOSE                  /* Have this defined to give better
                                            error messages. Using it causes
					    some bison warnings at compiler
					    compile time, however. Use as you
					    wish. Not mandatory. */


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
#line 19 "rmldb-parse.y"
typedef union YYSTYPE {
  int   v_int;
  float v_float;
  char *to_print;
  char *id;
} YYSTYPE;
/* Line 191 of yacc.c.  */
#line 190 "rmldb-parse.c"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 214 of yacc.c.  */
#line 202 "rmldb-parse.c"

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
#define YYFINAL  79
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   116

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  43
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  2
/* YYNRULES -- Number of rules. */
#define YYNRULES  47
/* YYNRULES -- Number of states. */
#define YYNSTATES  119

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   297

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
      35,    36,    37,    38,    39,    40,    41,    42
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned char yyprhs[] =
{
       0,     0,     3,     8,    13,    18,    23,    26,    29,    32,
      35,    39,    42,    46,    51,    55,    58,    62,    65,    69,
      74,    78,    81,    84,    89,    93,    98,   102,   105,   108,
     111,   114,   118,   122,   126,   130,   133,   138,   142,   147,
     151,   154,   158,   161,   165,   168,   172,   176
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const yysigned_char yyrhs[] =
{
      44,     0,    -1,     7,    14,    42,     5,    -1,     7,    15,
      42,     5,    -1,     8,    11,    14,     5,    -1,     8,    11,
      15,     5,    -1,    11,     5,    -1,    36,     5,    -1,    10,
       5,    -1,    30,     5,    -1,    31,    42,     5,    -1,    32,
       5,    -1,    33,    42,     5,    -1,     8,    29,    42,     5,
      -1,    29,    42,     5,    -1,    38,     5,    -1,    39,    42,
       5,    -1,    40,     5,    -1,    41,    42,     5,    -1,     8,
      37,    42,     5,    -1,    37,    42,     5,    -1,     6,     5,
      -1,    13,     5,    -1,     8,    16,    42,     5,    -1,    16,
      42,     5,    -1,     8,    34,    42,     5,    -1,    34,    42,
       5,    -1,     9,     5,    -1,    17,     5,    -1,    12,     5,
      -1,    18,     5,    -1,    21,    42,     5,    -1,    23,    42,
       5,    -1,    35,    42,     5,    -1,    24,    42,     5,    -1,
      22,     5,    -1,     8,    22,    14,     5,    -1,    22,    14,
       5,    -1,     8,    22,    15,     5,    -1,    22,    15,     5,
      -1,    25,     5,    -1,    25,    42,     5,    -1,    26,     5,
      -1,    26,    42,     5,    -1,    28,     5,    -1,    27,    42,
       5,    -1,    20,    14,     5,    -1,    20,    15,     5,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short yyrline[] =
{
       0,    49,    49,    58,    67,    75,    83,   101,   109,   118,
     126,   134,   142,   150,   158,   166,   174,   182,   190,   198,
     206,   214,   222,   230,   238,   246,   254,   262,   270,   278,
     286,   294,   302,   310,   318,   326,   334,   342,   350,   358,
     366,   374,   382,   390,   398,   410,   418,   425
};
#endif

#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "T_EOF", "T_ERROR", "T_EOL", "T_HELP", 
  "T_BREAKPOINT", "T_SET", "T_SETTINGS", "T_RUN", "T_STEP", "T_CLEAR", 
  "T_QUIT", "T_ON", "T_OFF", "T_DEPTH", "T_SHOW", "T_STATUS", "T_END", 
  "T_DEBUGPARSER", "T_OUTPUT", "T_LIVEVARS", "T_PRINT", "T_SIZEOF", 
  "T_DISPLAY", "T_UNDISPLAY", "T_GRAPH", "T_FAST", "T_MAXBT", 
  "T_BACKTRACE", "T_FILTERED_BACKTRACE", "T_GRAPH_BACKTRACE", 
  "T_GRAPH_FILTERED_BACKTRACE", "T_MAXSTR", "T_PRINT_TYPE", "T_NEXT", 
  "T_MAXCALLCHAIN", "T_CALLCHAIN", "T_FILTERED_CALLCHAIN", 
  "T_GRAPH_CALLCHAIN", "T_GRAPH_FILTERED_CALLCHAIN", "T_ID", "$accept", 
  "command", 0
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
     295,   296,   297
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    43,    44,    44,    44,    44,    44,    44,    44,    44,
      44,    44,    44,    44,    44,    44,    44,    44,    44,    44,
      44,    44,    44,    44,    44,    44,    44,    44,    44,    44,
      44,    44,    44,    44,    44,    44,    44,    44,    44,    44,
      44,    44,    44,    44,    44,    44,    44,    44
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     4,     4,     4,     4,     2,     2,     2,     2,
       3,     2,     3,     4,     3,     2,     3,     2,     3,     4,
       3,     2,     2,     4,     3,     4,     3,     2,     2,     2,
       2,     3,     3,     3,     3,     2,     4,     3,     4,     3,
       2,     3,     2,     3,     2,     3,     3,     3
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned char yydefact[] =
{
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    21,     0,     0,     0,     0,
       0,     0,     0,     0,    27,     8,     6,    29,    22,     0,
      28,    30,     0,     0,     0,    35,     0,     0,     0,     0,
      40,     0,    42,     0,     0,    44,     0,     9,     0,    11,
       0,     0,     0,     7,     0,    15,     0,    17,     0,     1,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      24,    46,    47,    31,    37,    39,    32,    34,    41,    43,
      45,    14,    10,    12,    26,    33,    20,    16,    18,     2,
       3,     4,     5,    23,    36,    38,    13,    25,    19
};

/* YYDEFGOTO[NTERM-NUM]. */
static const yysigned_char yydefgoto[] =
{
      -1,    34
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -20
static const yysigned_char yypact[] =
{
      23,     1,   -11,    -9,     5,    13,    14,    16,    17,   -19,
      19,    21,    -6,   -15,     0,    24,    25,    -5,    -4,    26,
      37,    27,    60,    28,    66,    30,    31,    32,    70,    34,
      72,    36,    74,    38,    81,   -20,    40,    41,    -3,    42,
       2,    43,    44,    45,   -20,   -20,   -20,   -20,   -20,    83,
     -20,   -20,    84,    85,    86,   -20,    87,    88,    89,    90,
     -20,    91,   -20,    92,    93,   -20,    94,   -20,    95,   -20,
      96,    97,    98,   -20,    99,   -20,   100,   -20,   101,   -20,
     102,   103,   104,   105,   106,   107,   108,   109,   110,   111,
     -20,   -20,   -20,   -20,   -20,   -20,   -20,   -20,   -20,   -20,
     -20,   -20,   -20,   -20,   -20,   -20,   -20,   -20,   -20,   -20,
     -20,   -20,   -20,   -20,   -20,   -20,   -20,   -20,   -20
};

/* YYPGOTO[NTERM-NUM].  */
static const yysigned_char yypgoto[] =
{
     -20,   -20
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const unsigned char yytable[] =
{
      60,    62,    38,    36,    37,    55,    35,    39,    52,    53,
      44,    82,    83,    40,    56,    57,    85,    86,    45,    46,
      41,    47,    48,    49,    50,    42,    51,    54,    43,     1,
       2,     3,     4,     5,     6,     7,     8,    61,    63,     9,
      10,    11,    65,    12,    13,    14,    15,    16,    17,    18,
      19,    20,    21,    22,    23,    24,    25,    26,    27,    28,
      29,    30,    31,    32,    33,    67,    58,    59,    64,    66,
      68,    69,    70,    71,    72,    73,    74,    75,    76,    77,
      78,    79,    80,    81,    84,    87,    88,    89,    90,    91,
      92,    93,    94,    95,    96,    97,    98,    99,   100,   101,
     102,   103,   104,   105,   106,   107,   108,   109,   110,   111,
     112,   113,   114,   115,   116,   117,   118
};

static const unsigned char yycheck[] =
{
       5,     5,    11,    14,    15,     5,     5,    16,    14,    15,
       5,    14,    15,    22,    14,    15,    14,    15,     5,     5,
      29,     5,     5,    42,     5,    34,     5,    42,    37,     6,
       7,     8,     9,    10,    11,    12,    13,    42,    42,    16,
      17,    18,     5,    20,    21,    22,    23,    24,    25,    26,
      27,    28,    29,    30,    31,    32,    33,    34,    35,    36,
      37,    38,    39,    40,    41,     5,    42,    42,    42,    42,
      42,     5,    42,    42,    42,     5,    42,     5,    42,     5,
      42,     0,    42,    42,    42,    42,    42,    42,     5,     5,
       5,     5,     5,     5,     5,     5,     5,     5,     5,     5,
       5,     5,     5,     5,     5,     5,     5,     5,     5,     5,
       5,     5,     5,     5,     5,     5,     5
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,     6,     7,     8,     9,    10,    11,    12,    13,    16,
      17,    18,    20,    21,    22,    23,    24,    25,    26,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    37,
      38,    39,    40,    41,    44,     5,    14,    15,    11,    16,
      22,    29,    34,    37,     5,     5,     5,     5,     5,    42,
       5,     5,    14,    15,    42,     5,    14,    15,    42,    42,
       5,    42,     5,    42,    42,     5,    42,     5,    42,     5,
      42,    42,    42,     5,    42,     5,    42,     5,    42,     0,
      42,    42,    14,    15,    42,    14,    15,    42,    42,    42,
       5,     5,     5,     5,     5,     5,     5,     5,     5,     5,
       5,     5,     5,     5,     5,     5,     5,     5,     5,     5,
       5,     5,     5,     5,     5,     5,     5,     5,     5
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
#line 50 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  /* set On the filter on this relation */
  rmldb_add_relation_filter(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 3:
#line 59 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  /* set Off the filter on this relation */
  rmldb_del_relation_filter(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 4:
#line 68 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_execution_type = RMLDB_STEP;
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 5:
#line 76 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_execution_type = RMLDB_RUN;
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 6:
#line 84 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_execution_type = RMLDB_STEP;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 7:
#line 102 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_execution_type = RMLDB_NEXT;  
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 8:
#line 110 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_execution_type = RMLDB_RUN;
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_show = RMLDB_HIDE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 9:
#line 119 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_backtrace_print(NULL);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 10:
#line 127 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_backtrace_print(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;   
;}
    break;

  case 11:
#line 135 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_backtrace_send(NULL);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 12:
#line 143 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_backtrace_send(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;   
;}
    break;

  case 13:
#line 151 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_max_backtrace(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 14:
#line 159 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_max_backtrace(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 15:
#line 167 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_callchain_print(NULL);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 16:
#line 175 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_callchain_print(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;   
;}
    break;

  case 17:
#line 183 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_callchain_send(NULL);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 18:
#line 191 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_callchain_send(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;   
;}
    break;

  case 19:
#line 199 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_max_callchain(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 20:
#line 207 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_max_callchain(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 21:
#line 215 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_show_help(); 
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 22:
#line 223 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  printf("end the program\n");
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  rml_exit(2);
;}
    break;

  case 23:
#line 231 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_depth(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 24:
#line 239 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_depth(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 25:
#line 247 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_maxstr(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 26:
#line 255 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_maxstr(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 27:
#line 263 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_print_settings();
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 28:
#line 271 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_show_breakpoints();
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 29:
#line 279 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_clear_breakpoints();
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 30:
#line 287 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_show_status();
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 31:
#line 295 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_set_output(aalval.id);
  rmldb_last_command = RMLDB_REPEAT_PARSE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 32:
#line 303 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_print_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 33:
#line 311 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_print_type_info_id(aalval.id, stdout);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 34:
#line 319 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_print_sizeof_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 35:
#line 327 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_print_vars();
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 36:
#line 335 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_set_print_vars(RMLDB_LIVEVARS_ON);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 37:
#line 343 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_set_print_vars(RMLDB_LIVEVARS_ON);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 38:
#line 351 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_set_print_vars(RMLDB_LIVEVARS_OFF);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 39:
#line 359 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_set_print_vars(RMLDB_LIVEVARS_OFF);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 40:
#line 367 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_show_displayvars();
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 41:
#line 375 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_display_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 42:
#line 383 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_clear_displayvars();
#endif /* RML_DEBUG */
  YYACCEPT;	
;}
    break;

  case 43:
#line 391 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_undisplay_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 44:
#line 399 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  printf("Entering in fast debug mode, no backtrace generation, no live variables.\n");
  printf("Only verifying breakpoints, if they exist. \n");
  printf("Hit CTRL+C to enter again in Step execution mode when you want.\n");
  rmldb_last_command = RMLDB_BREAK_PARSE;
  rmldb_execution_type = RMLDB_FAST;
  rmldb_show = RMLDB_HIDE;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 45:
#line 411 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  rmldb_last_command = RMLDB_REPEAT_PARSE;
  rmldb_view_variable(aalval.id);
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 46:
#line 419 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  aadebug = 1;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;

  case 47:
#line 426 "rmldb-parse.y"
    {
#ifdef RML_DEBUG
  aadebug = 0;
#endif /* RML_DEBUG */
  YYACCEPT;
;}
    break;


    }

/* Line 999 of yacc.c.  */
#line 1678 "rmldb-parse.c"

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


#line 434 "rmldb-parse.y"


int aaerror(char *s) 
{
  fprintf(stderr, "%s or command not recognized\n", s);
  return -1;
}

