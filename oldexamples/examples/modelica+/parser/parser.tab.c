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
     EOF = 258,
     AMPERSAND = 259,
     AND = 260,
     AS = 261,
     AXIOM = 262,
     BAR = 263,
     CCON = 264,
     COLON = 265,
     COLONCOLON = 266,
     COMMA = 267,
     DASHES = 268,
     DATATYPE = 269,
     DEFAULT = 270,
     DOT = 271,
     END = 272,
     EQ = 273,
     EQTYPE = 274,
     FAIL = 275,
     FATARROW = 276,
     ICON = 277,
     IDENT = 278,
     LBRACK = 279,
     LET = 280,
     LPAREN = 281,
     MODULE = 282,
     NOT = 283,
     OF = 284,
     RCON = 285,
     RELATION = 286,
     RBRACK = 287,
     RPAREN = 288,
     RULE = 289,
     SCON = 290,
     STAR = 291,
     START_INTERFACE = 292,
     TYPE = 293,
     TYVAR = 294,
     VAL = 295,
     WILD = 296,
     WITH = 297,
     WITHTYPE = 298,
     ADD_INT = 299,
     SUB_INT = 300,
     NEG_INT = 301,
     DIV_INT = 302,
     MOD_INT = 303,
     EQEQ_INT = 304,
     GE_INT = 305,
     GT_INT = 306,
     LE_INT = 307,
     LT_INT = 308,
     NE_INT = 309,
     ADD_REAL = 310,
     SUB_REAL = 311,
     NEG_REAL = 312,
     MUL_REAL = 313,
     DIV_REAL = 314,
     MOD_REAL = 315,
     POW_REAL = 316,
     EQ_REAL = 317,
     GE_REAL = 318,
     GT_REAL = 319,
     LE_REAL = 320,
     LT_REAL = 321,
     NE_REAL = 322,
     ADD_STRING = 323,
     ADD_LIST = 324,
     SEMICOLON = 325,
     LBRACE = 326,
     RBRACE = 327,
     POWER = 328,
     ASSIGN = 329,
     ALGORITHM = 330,
     ANNOTATION = 331,
     BLOCK = 332,
     BOUNDARY = 333,
     CODE = 334,
     CLASS = 335,
     CONNECT = 336,
     CONNECTOR = 337,
     CONSTANT = 338,
     DISCRETE = 339,
     EACH = 340,
     ELSE = 341,
     ELSEIF = 342,
     ELSEWHEN = 343,
     ENUMERATION = 344,
     EQUATION = 345,
     ENCAPSULATED = 346,
     EXTENDS = 347,
     EXTERNAL = 348,
     FALSE = 349,
     TRUE = 350,
     FINAL = 351,
     FLOW = 352,
     FOR = 353,
     FUNCTION = 354,
     IF = 355,
     IMPORT = 356,
     IN = 357,
     INITIAL = 358,
     INNER = 359,
     INPUT = 360,
     LOOP = 361,
     MODEL = 362,
     OUTER = 363,
     OVERLOAD = 364,
     OR = 365,
     OUTPUT = 366,
     PACKAGE = 367,
     PARAMETER = 368,
     PARTIAL = 369,
     PROTECTED = 370,
     PUBLIC = 371,
     RECORD = 372,
     REDECLARE = 373,
     REPLACEABLE = 374,
     RESULTS = 375,
     THEN = 376,
     WHEN = 377,
     WHILE = 378,
     WITHIN = 379,
     UNIONTYPE = 380,
     MATCH = 381,
     CASE = 382,
     LOCAL = 383,
     DOTSTAR = 384,
     START_MODELICA = 385,
     START_MODULE = 386
   };
#endif
#define EOF 258
#define AMPERSAND 259
#define AND 260
#define AS 261
#define AXIOM 262
#define BAR 263
#define CCON 264
#define COLON 265
#define COLONCOLON 266
#define COMMA 267
#define DASHES 268
#define DATATYPE 269
#define DEFAULT 270
#define DOT 271
#define END 272
#define EQ 273
#define EQTYPE 274
#define FAIL 275
#define FATARROW 276
#define ICON 277
#define IDENT 278
#define LBRACK 279
#define LET 280
#define LPAREN 281
#define MODULE 282
#define NOT 283
#define OF 284
#define RCON 285
#define RELATION 286
#define RBRACK 287
#define RPAREN 288
#define RULE 289
#define SCON 290
#define STAR 291
#define START_INTERFACE 292
#define TYPE 293
#define TYVAR 294
#define VAL 295
#define WILD 296
#define WITH 297
#define WITHTYPE 298
#define ADD_INT 299
#define SUB_INT 300
#define NEG_INT 301
#define DIV_INT 302
#define MOD_INT 303
#define EQEQ_INT 304
#define GE_INT 305
#define GT_INT 306
#define LE_INT 307
#define LT_INT 308
#define NE_INT 309
#define ADD_REAL 310
#define SUB_REAL 311
#define NEG_REAL 312
#define MUL_REAL 313
#define DIV_REAL 314
#define MOD_REAL 315
#define POW_REAL 316
#define EQ_REAL 317
#define GE_REAL 318
#define GT_REAL 319
#define LE_REAL 320
#define LT_REAL 321
#define NE_REAL 322
#define ADD_STRING 323
#define ADD_LIST 324
#define SEMICOLON 325
#define LBRACE 326
#define RBRACE 327
#define POWER 328
#define ASSIGN 329
#define ALGORITHM 330
#define ANNOTATION 331
#define BLOCK 332
#define BOUNDARY 333
#define CODE 334
#define CLASS 335
#define CONNECT 336
#define CONNECTOR 337
#define CONSTANT 338
#define DISCRETE 339
#define EACH 340
#define ELSE 341
#define ELSEIF 342
#define ELSEWHEN 343
#define ENUMERATION 344
#define EQUATION 345
#define ENCAPSULATED 346
#define EXTENDS 347
#define EXTERNAL 348
#define FALSE 349
#define TRUE 350
#define FINAL 351
#define FLOW 352
#define FOR 353
#define FUNCTION 354
#define IF 355
#define IMPORT 356
#define IN 357
#define INITIAL 358
#define INNER 359
#define INPUT 360
#define LOOP 361
#define MODEL 362
#define OUTER 363
#define OVERLOAD 364
#define OR 365
#define OUTPUT 366
#define PACKAGE 367
#define PARAMETER 368
#define PARTIAL 369
#define PROTECTED 370
#define PUBLIC 371
#define RECORD 372
#define REDECLARE 373
#define REPLACEABLE 374
#define RESULTS 375
#define THEN 376
#define WHEN 377
#define WHILE 378
#define WITHIN 379
#define UNIONTYPE 380
#define MATCH 381
#define CASE 382
#define LOCAL 383
#define DOTSTAR 384
#define START_MODELICA 385
#define START_MODULE 386




/* Copy the first part of user declarations.  */


/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 1
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 214 of yacc.c.  */
#line 350 "parser.tab.c"

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
#define YYFINAL  7
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   669

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  132
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  110
/* YYNRULES -- Number of rules. */
#define YYNRULES  237
/* YYNRULES -- Number of states. */
#define YYNSTATES  463

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   386

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
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,    71,    72,    73,    74,
      75,    76,    77,    78,    79,    80,    81,    82,    83,    84,
      85,    86,    87,    88,    89,    90,    91,    92,    93,    94,
      95,    96,    97,    98,    99,   100,   101,   102,   103,   104,
     105,   106,   107,   108,   109,   110,   111,   112,   113,   114,
     115,   116,   117,   118,   119,   120,   121,   122,   123,   124,
     125,   126,   127,   128,   129,   130,   131
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned short yyprhs[] =
{
       0,     0,     3,     5,     7,     8,    12,    14,    15,    17,
      18,    20,    21,    23,    24,    28,    29,    34,    35,    41,
      43,    45,    47,    49,    51,    53,    55,    57,    61,    66,
      73,    76,    79,    85,    89,    91,    94,   100,   104,   106,
     108,   109,   111,   113,   115,   116,   118,   120,   121,   128,
     134,   138,   142,   146,   149,   151,   154,   158,   162,   165,
     168,   171,   174,   176,   179,   180,   185,   186,   188,   190,
     191,   193,   194,   202,   208,   210,   211,   215,   219,   220,
     222,   224,   231,   235,   242,   246,   248,   250,   253,   254,
     256,   258,   262,   264,   268,   270,   271,   273,   277,   279,
     282,   286,   290,   292,   295,   298,   300,   301,   305,   308,
     312,   314,   320,   327,   334,   339,   344,   348,   351,   355,
     359,   360,   362,   364,   365,   369,   372,   376,   380,   384,
     385,   390,   393,   396,   399,   402,   406,   411,   419,   422,
     425,   428,   431,   437,   438,   444,   445,   448,   449,   452,
     453,   462,   471,   475,   477,   479,   483,   490,   497,   504,
     512,   518,   519,   527,   533,   534,   538,   539,   543,   544,
     551,   553,   555,   563,   569,   570,   576,   580,   582,   586,
     588,   592,   594,   597,   599,   603,   605,   607,   609,   611,
     613,   615,   617,   621,   625,   628,   631,   633,   637,   641,
     643,   647,   649,   653,   655,   657,   659,   661,   663,   665,
     667,   669,   673,   677,   681,   685,   688,   690,   694,   698,
     700,   705,   708,   712,   716,   719,   722,   723,   727,   731,
     733,   736,   737,   739,   742,   745,   748,   750
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const short yyrhs[] =
{
     133,     0,    -1,   135,    -1,    23,    -1,    -1,   140,   141,
       3,    -1,    91,    -1,    -1,   114,    -1,    -1,    96,    -1,
      -1,    85,    -1,    -1,   124,   230,    70,    -1,    -1,   138,
     142,    70,   141,    -1,    -1,   136,   137,   143,   134,   145,
      -1,    80,    -1,   107,    -1,   117,    -1,    77,    -1,    82,
      -1,    38,    -1,   112,    -1,    99,    -1,   151,   152,   153,
      -1,   238,   159,    17,    23,    -1,    18,   144,   230,   174,
     181,   237,    -1,    18,   146,    -1,    18,   149,    -1,    89,
      26,   147,    33,   237,    -1,   148,    12,   147,    -1,   148,
      -1,   134,   237,    -1,   109,    26,   150,    33,   237,    -1,
     230,    12,   150,    -1,   230,    -1,    97,    -1,    -1,    84,
      -1,   113,    -1,    83,    -1,    -1,   105,    -1,   111,    -1,
      -1,   151,   152,   153,   175,   173,   176,    -1,   151,   152,
     153,   175,   177,    -1,   101,   157,   237,    -1,   101,   158,
     237,    -1,   134,    18,   230,    -1,   230,   129,    -1,   230,
      -1,   168,   160,    -1,   116,   168,   160,    -1,   115,   168,
     160,    -1,   185,   160,    -1,   184,   160,    -1,   190,   160,
      -1,   191,   160,    -1,   162,    -1,   240,    70,    -1,    -1,
      93,   166,   161,   161,    -1,    -1,    35,    -1,   163,    -1,
      -1,   231,    -1,    -1,   164,   165,    18,   134,    26,   167,
      33,    -1,   164,   134,    26,   167,    33,    -1,   236,    -1,
      -1,   169,    70,   168,    -1,   240,    70,   168,    -1,    -1,
     156,    -1,   189,    -1,   138,   170,   119,   142,   188,   237,
      -1,   138,   170,   142,    -1,   138,   170,   119,   154,   188,
     237,    -1,   138,   170,   154,    -1,   104,    -1,   108,    -1,
     104,   108,    -1,    -1,   213,    -1,    10,    -1,   171,    12,
     172,    -1,   171,    -1,    24,   172,    32,    -1,   173,    -1,
      -1,   230,    -1,   177,    12,   176,    -1,   177,    -1,   178,
     237,    -1,   134,   173,   180,    -1,   181,    18,   213,    -1,
     181,    -1,    18,   213,    -1,    74,   213,    -1,   179,    -1,
      -1,    26,   182,    33,    -1,    26,    33,    -1,   183,    12,
     182,    -1,   183,    -1,   139,   138,   231,   180,   238,    -1,
     118,   139,   138,   119,   142,   188,    -1,   118,   139,   138,
     119,   155,   188,    -1,   118,   139,   138,   142,    -1,   118,
     139,   138,   155,    -1,   103,    90,   186,    -1,    90,   186,
      -1,   193,    70,   186,    -1,   240,    70,   186,    -1,    -1,
     189,    -1,   187,    -1,    -1,    92,   230,   181,    -1,    75,
     192,    -1,   103,    75,   192,    -1,   194,    70,   192,    -1,
     240,    70,   192,    -1,    -1,   216,    18,   213,   237,    -1,
     199,   237,    -1,   203,   237,    -1,   212,   237,    -1,   206,
     237,    -1,   134,   232,   237,    -1,   231,    74,   213,   237,
      -1,    26,   236,    33,    74,   231,   232,   237,    -1,   200,
     237,    -1,   204,   237,    -1,   205,   237,    -1,   208,   237,
      -1,    87,   213,   121,   210,   195,    -1,    -1,    87,   213,
     121,   211,   196,    -1,    -1,    86,   210,    -1,    -1,    86,
     211,    -1,    -1,   100,   213,   121,   210,   195,   197,    17,
     100,    -1,   100,   213,   121,   211,   196,   198,    17,   100,
      -1,   202,    12,   201,    -1,   202,    -1,   134,    -1,   134,
     102,   213,    -1,    98,   201,   106,   210,    17,    98,    -1,
      98,   201,   106,   211,    17,    98,    -1,   123,   213,   106,
     211,    17,   123,    -1,   122,   213,   121,   210,   207,    17,
     122,    -1,    88,   213,   121,   210,   207,    -1,    -1,   122,
     213,   121,   211,   209,    17,   122,    -1,    88,   213,   121,
     211,   209,    -1,    -1,   193,    70,   210,    -1,    -1,   194,
      70,   211,    -1,    -1,    81,    26,   231,    12,   231,    33,
      -1,   214,    -1,   216,    -1,   100,   213,   121,   213,   215,
      86,   213,    -1,    87,   213,   121,   213,   215,    -1,    -1,
     217,    10,   217,    10,   217,    -1,   217,    10,   217,    -1,
     217,    -1,   218,   110,   217,    -1,   218,    -1,   219,     5,
     218,    -1,   219,    -1,    28,   220,    -1,   220,    -1,   222,
     221,   222,    -1,    53,    -1,    52,    -1,    51,    -1,    50,
      -1,    49,    -1,    54,    -1,   223,    -1,   223,    44,   222,
      -1,   223,    45,   222,    -1,    44,   224,    -1,    45,   224,
      -1,   224,    -1,   225,    36,   224,    -1,   225,    47,   224,
      -1,   225,    -1,   228,    73,   228,    -1,   228,    -1,   236,
      70,   226,    -1,   236,    -1,   226,    -1,    22,    -1,    30,
      -1,    35,    -1,    94,    -1,    95,    -1,   229,    -1,    26,
     236,    33,    -1,    24,   227,    32,    -1,    71,   236,    72,
      -1,    71,   233,    72,    -1,   231,   232,    -1,   231,    -1,
     103,    26,    33,    -1,    23,    16,   230,    -1,    23,    -1,
     134,   173,    16,   231,    -1,   134,   173,    -1,    26,   233,
      33,    -1,   236,    98,   201,    -1,   236,   234,    -1,   235,
     234,    -1,    -1,   134,    18,   213,    -1,   213,    12,   236,
      -1,   213,    -1,   238,   241,    -1,    -1,    35,    -1,    35,
     239,    -1,    44,   238,    -1,    76,   181,    -1,   240,    -1,
      -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short yyrline[] =
{
       0,    54,    54,    58,    68,    69,    73,    74,    78,    79,
      83,    84,    88,    89,    93,    94,    98,    99,   104,   107,
     107,   107,   107,   107,   107,   107,   107,   110,   114,   115,
     116,   117,   121,   125,   126,   130,   134,   138,   139,   143,
     144,   147,   147,   147,   147,   149,   149,   149,   152,   156,
     160,   161,   165,   169,   170,   174,   178,   179,   180,   181,
     182,   183,   184,   188,   189,   193,   194,   198,   202,   203,
     207,   208,   212,   213,   217,   218,   222,   223,   224,   228,
     229,   230,   231,   232,   233,   236,   236,   236,   236,   239,
     240,   244,   245,   249,   253,   254,   258,   262,   263,   267,
     271,   275,   276,   277,   278,   282,   283,   287,   288,   292,
     293,   297,   298,   299,   300,   301,   305,   309,   313,   314,
     315,   319,   323,   324,   328,   332,   336,   340,   341,   342,
     346,   347,   348,   349,   350,   351,   355,   356,   357,   358,
     359,   360,   364,   365,   369,   370,   374,   375,   379,   380,
     384,   388,   392,   393,   397,   398,   402,   406,   410,   414,
     418,   419,   423,   427,   428,   432,   433,   437,   438,   442,
     446,   447,   451,   455,   456,   460,   461,   462,   466,   467,
     471,   472,   476,   477,   481,   485,   485,   485,   485,   485,
     485,   488,   489,   490,   494,   495,   496,   500,   501,   502,
     506,   507,   511,   512,   516,   520,   521,   522,   523,   524,
     525,   526,   527,   528,   529,   533,   534,   535,   539,   540,
     544,   545,   549,   553,   554,   558,   559,   563,   567,   568,
     572,   573,   577,   578,   582,   586,   590,   591
};
#endif

#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "EOF", "AMPERSAND", "AND", "AS", "AXIOM", 
  "BAR", "CCON", "COLON", "COLONCOLON", "COMMA", "DASHES", "DATATYPE", 
  "DEFAULT", "DOT", "END", "EQ", "EQTYPE", "FAIL", "FATARROW", "ICON", 
  "IDENT", "LBRACK", "LET", "LPAREN", "MODULE", "NOT", "OF", "RCON", 
  "RELATION", "RBRACK", "RPAREN", "RULE", "SCON", "STAR", 
  "START_INTERFACE", "TYPE", "TYVAR", "VAL", "WILD", "WITH", "WITHTYPE", 
  "ADD_INT", "SUB_INT", "NEG_INT", "DIV_INT", "MOD_INT", "EQEQ_INT", 
  "GE_INT", "GT_INT", "LE_INT", "LT_INT", "NE_INT", "ADD_REAL", 
  "SUB_REAL", "NEG_REAL", "MUL_REAL", "DIV_REAL", "MOD_REAL", "POW_REAL", 
  "EQ_REAL", "GE_REAL", "GT_REAL", "LE_REAL", "LT_REAL", "NE_REAL", 
  "ADD_STRING", "ADD_LIST", "SEMICOLON", "LBRACE", "RBRACE", "POWER", 
  "ASSIGN", "ALGORITHM", "ANNOTATION", "BLOCK", "BOUNDARY", "CODE", 
  "CLASS", "CONNECT", "CONNECTOR", "CONSTANT", "DISCRETE", "EACH", "ELSE", 
  "ELSEIF", "ELSEWHEN", "ENUMERATION", "EQUATION", "ENCAPSULATED", 
  "EXTENDS", "EXTERNAL", "FALSE", "TRUE", "FINAL", "FLOW", "FOR", 
  "FUNCTION", "IF", "IMPORT", "IN", "INITIAL", "INNER", "INPUT", "LOOP", 
  "MODEL", "OUTER", "OVERLOAD", "OR", "OUTPUT", "PACKAGE", "PARAMETER", 
  "PARTIAL", "PROTECTED", "PUBLIC", "RECORD", "REDECLARE", "REPLACEABLE", 
  "RESULTS", "THEN", "WHEN", "WHILE", "WITHIN", "UNIONTYPE", "MATCH", 
  "CASE", "LOCAL", "DOTSTAR", "START_MODELICA", "START_MODULE", "$accept", 
  "start", "ident", "stored_definition", "optENCAPSULATED", "optPARTIAL", 
  "optFINAL", "optEACH", "within_clause", "class_definition_list", 
  "class_definition", "class_type", "base_prefix", "class_specifier", 
  "enumeration", "enum_list", "enumeration_literal", "overloading", 
  "name_path_list", "flow_prefix", "variability_prefix", 
  "direction_prefix", "component_clause", "component_clause1", 
  "import_clause", "explicit_import_name", "implicit_import_name", 
  "composition", "composition_sublist", "opt_annotation_semicolon", 
  "opt_external_clause", "language_specification", 
  "opt_language_specification", "opt_component_reference", 
  "external_function_call", "opt_expression_list", "element_list", 
  "element", "inner_outer", "subscript", "subscript_list", 
  "array_subscripts", "opt_array_subscripts", "type_specifier", 
  "component_list", "component_declaration", "declaration", 
  "modification", "opt_modification", "class_modification", 
  "argument_list", "argument", "initial_equation_clause", 
  "equation_clause", "equation_annotation_list", "constraining_clause", 
  "opt_constraining_clause", "extends_clause", "algorithm_clause", 
  "initial_algorithm_clause", "algorithm_annotation_list", "equation", 
  "algorithm", "equation_elseif", "algorithm_elseif", "opt_equation_else", 
  "opt_algorithm_else", "conditional_equation_e", 
  "conditional_equation_a", "for_indices", "for_indice", "for_clause_e", 
  "for_clause_a", "while_clause", "when_clause_e", "else_when_e", 
  "when_clause_a", "else_when_a", "equation_list", "algorithm_list", 
  "connect_clause", "expression", "if_expression", 
  "elseif_expression_list", "simple_expression", "logical_expression", 
  "logical_term", "logical_factor", "relation", "rel_op", 
  "arithmetic_expression", "unary_arithmetic_expression", "term", 
  "factor", "expression_matrix_list", "expression_matrix", "primary", 
  "component_ref_function_call", "name_path", "component_reference", 
  "function_call", "function_arguments", "named_arguments", 
  "named_argument", "expression_list", "comment", "string_comment", 
  "string_comment_add", "annotation", "opt_annotation", 0
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
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323,   324,
     325,   326,   327,   328,   329,   330,   331,   332,   333,   334,
     335,   336,   337,   338,   339,   340,   341,   342,   343,   344,
     345,   346,   347,   348,   349,   350,   351,   352,   353,   354,
     355,   356,   357,   358,   359,   360,   361,   362,   363,   364,
     365,   366,   367,   368,   369,   370,   371,   372,   373,   374,
     375,   376,   377,   378,   379,   380,   381,   382,   383,   384,
     385,   386
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,   132,   133,   134,   135,   135,   136,   136,   137,   137,
     138,   138,   139,   139,   140,   140,   141,   141,   142,   143,
     143,   143,   143,   143,   143,   143,   143,   144,   145,   145,
     145,   145,   146,   147,   147,   148,   149,   150,   150,   151,
     151,   152,   152,   152,   152,   153,   153,   153,   154,   155,
     156,   156,   157,   158,   158,   159,   160,   160,   160,   160,
     160,   160,   160,   161,   161,   162,   162,   163,   164,   164,
     165,   165,   166,   166,   167,   167,   168,   168,   168,   169,
     169,   169,   169,   169,   169,   170,   170,   170,   170,   171,
     171,   172,   172,   173,   174,   174,   175,   176,   176,   177,
     178,   179,   179,   179,   179,   180,   180,   181,   181,   182,
     182,   183,   183,   183,   183,   183,   184,   185,   186,   186,
     186,   187,   188,   188,   189,   190,   191,   192,   192,   192,
     193,   193,   193,   193,   193,   193,   194,   194,   194,   194,
     194,   194,   195,   195,   196,   196,   197,   197,   198,   198,
     199,   200,   201,   201,   202,   202,   203,   204,   205,   206,
     207,   207,   208,   209,   209,   210,   210,   211,   211,   212,
     213,   213,   214,   215,   215,   216,   216,   216,   217,   217,
     218,   218,   219,   219,   220,   221,   221,   221,   221,   221,
     221,   222,   222,   222,   223,   223,   223,   224,   224,   224,
     225,   225,   226,   226,   227,   228,   228,   228,   228,   228,
     228,   228,   228,   228,   228,   229,   229,   229,   230,   230,
     231,   231,   232,   233,   233,   234,   234,   235,   236,   236,
     237,   237,   238,   238,   239,   240,   241,   241
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     1,     1,     0,     3,     1,     0,     1,     0,
       1,     0,     1,     0,     3,     0,     4,     0,     5,     1,
       1,     1,     1,     1,     1,     1,     1,     3,     4,     6,
       2,     2,     5,     3,     1,     2,     5,     3,     1,     1,
       0,     1,     1,     1,     0,     1,     1,     0,     6,     5,
       3,     3,     3,     2,     1,     2,     3,     3,     2,     2,
       2,     2,     1,     2,     0,     4,     0,     1,     1,     0,
       1,     0,     7,     5,     1,     0,     3,     3,     0,     1,
       1,     6,     3,     6,     3,     1,     1,     2,     0,     1,
       1,     3,     1,     3,     1,     0,     1,     3,     1,     2,
       3,     3,     1,     2,     2,     1,     0,     3,     2,     3,
       1,     5,     6,     6,     4,     4,     3,     2,     3,     3,
       0,     1,     1,     0,     3,     2,     3,     3,     3,     0,
       4,     2,     2,     2,     2,     3,     4,     7,     2,     2,
       2,     2,     5,     0,     5,     0,     2,     0,     2,     0,
       8,     8,     3,     1,     1,     3,     6,     6,     6,     7,
       5,     0,     7,     5,     0,     3,     0,     3,     0,     6,
       1,     1,     7,     5,     0,     5,     3,     1,     3,     1,
       3,     1,     2,     1,     3,     1,     1,     1,     1,     1,
       1,     1,     3,     3,     2,     2,     1,     3,     3,     1,
       3,     1,     3,     1,     1,     1,     1,     1,     1,     1,
       1,     3,     3,     3,     3,     2,     1,     3,     3,     1,
       4,     2,     3,     3,     2,     2,     0,     3,     3,     1,
       2,     0,     1,     2,     2,     2,     1,     0
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned char yydefact[] =
{
      15,     0,     0,     2,    11,   219,     0,     1,    10,     7,
       0,     0,    14,     6,     9,     0,     5,   218,     8,     0,
      11,    24,    22,    19,    23,    26,    20,    25,    21,     0,
      16,     3,     0,    40,   232,    18,    11,     0,    39,     0,
       0,    30,    31,    44,     0,   233,     0,     0,     0,    88,
      79,     0,    66,     0,    80,     0,     0,     0,    95,    43,
      41,    42,    47,   234,    13,   235,     0,   219,     0,   231,
     231,    54,    85,    86,     7,     0,   129,   120,    69,     0,
      11,    11,    55,    62,    66,    66,    66,    66,    11,    11,
     231,     0,    34,     0,    38,     0,    94,     0,    45,    46,
      27,   108,    12,    13,    11,     0,   110,   124,     0,    50,
     237,    51,    53,    87,     7,    82,    44,    84,    28,     0,
       0,     0,     0,     0,     0,   125,     0,   231,   231,   231,
     231,     0,     0,   205,     0,     0,     0,   206,   207,     0,
       0,     0,     0,   208,   209,     0,     0,     0,     0,     0,
     117,     0,   231,   231,   231,   231,     0,   177,   179,   181,
     183,     0,   191,   196,   199,   201,   210,   216,     0,    67,
      68,    71,    64,   129,   120,    66,    66,    59,    58,    60,
      61,    76,    77,    35,   231,     0,   231,     0,    90,     0,
      92,     0,    89,   170,   171,   231,    11,     0,   107,    13,
      52,   236,   230,   123,   123,    47,   229,     0,   154,     0,
     153,     0,     0,     0,   221,   129,   138,   139,   140,   141,
       0,   129,   204,     0,   203,     0,   182,   194,   195,     0,
       0,     0,     0,     0,     0,     0,     0,   231,   120,   131,
     132,   134,   133,     0,     0,     0,     0,   189,   188,   187,
     186,   185,   190,     0,     0,     0,     0,     0,     0,   215,
     120,     0,     0,    70,    64,     0,   126,   116,    57,    56,
      32,    33,    36,    37,     0,     0,    93,    29,     7,   106,
     109,   122,   231,   121,   231,     0,     0,     0,     0,   168,
       0,   168,   168,   168,     0,   127,   231,   128,   212,     0,
     211,   214,   213,     0,     0,   224,   226,     0,   166,   166,
     217,   166,     0,   226,   135,   118,   231,   176,   178,   180,
     184,   192,   193,   197,   198,   200,   119,    75,     0,    65,
      63,     0,    91,     7,   114,    44,   115,     0,     0,   105,
       0,   102,    81,    83,     0,    96,   228,     0,   155,     0,
       0,   152,   145,   164,     0,   220,   136,   202,   223,     0,
     225,     0,     0,     0,   143,   161,   222,   130,     0,     0,
      74,     0,   174,   123,   123,    47,   103,   104,   111,     0,
       0,     0,   168,     0,     0,   149,     0,     0,     0,   227,
       0,   166,     0,     0,   147,     0,     0,   175,    73,    75,
       0,     0,   112,   113,     0,   101,     0,    48,    98,   231,
     231,   167,   157,     0,   168,     0,     0,     0,   158,   169,
     165,   156,     0,   166,     0,     0,     0,     0,     0,     0,
       0,   106,     0,    99,   137,   168,   148,     0,   168,   162,
     166,   146,     0,   166,   159,    72,     0,   172,    49,   100,
      97,   145,   151,   164,   143,   150,   161,   174,   144,   163,
     142,   160,   173
};

/* YYDEFGOTO[NTERM-NUM]. */
static const short yydefgoto[] =
{
      -1,     2,   124,     3,    14,    19,    49,   104,     4,    10,
      15,    29,    40,    35,    41,    91,    92,    42,    93,   116,
      62,   100,   117,   336,    50,    69,    70,    51,    82,   264,
      83,   170,   171,   262,   172,   369,    52,    53,    74,   190,
     191,   214,    97,   344,   407,   408,   409,   339,   340,   341,
     105,   106,    84,    85,   150,   281,   282,    54,    86,    87,
     125,   362,   349,   394,   385,   424,   415,   152,   127,   209,
     210,   153,   128,   129,   154,   396,   130,   387,   363,   350,
     155,   206,   193,   401,   194,   157,   158,   159,   160,   253,
     161,   162,   163,   164,   222,   223,   165,   166,    94,   167,
     237,   229,   305,   306,   224,   109,   110,    45,    55,   202
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -289
static const short yypact[] =
{
      22,    36,    85,  -289,    32,    50,    24,  -289,  -289,     6,
     101,    36,  -289,  -289,    -7,    41,  -289,  -289,  -289,   518,
      32,  -289,  -289,  -289,  -289,  -289,  -289,  -289,  -289,    97,
    -289,  -289,    29,    35,    79,  -289,   256,   100,  -289,   108,
      36,  -289,  -289,     5,   106,  -289,   121,    36,   131,   -50,
    -289,   148,   -10,   104,  -289,   107,    97,    36,   161,  -289,
    -289,  -289,   -48,  -289,     1,  -289,   121,   155,   168,   106,
     106,    60,    91,  -289,   354,   181,    14,   360,   173,   -13,
     256,   256,  -289,  -289,   -10,   -10,   -10,   -10,   256,   256,
     106,   177,   200,   180,   204,   484,  -289,   121,  -289,  -289,
    -289,  -289,  -289,   133,   140,   194,   225,  -289,    36,  -289,
     166,  -289,  -289,  -289,   373,  -289,     5,  -289,  -289,   509,
      97,   509,   509,   509,   161,  -289,   178,   106,   106,   106,
     106,   172,   179,  -289,   509,   509,   566,  -289,  -289,   217,
     217,   509,   224,  -289,  -289,    97,   509,   234,   509,    58,
    -289,   192,   106,   106,   106,   106,   233,   254,   157,   260,
    -289,   205,    26,  -289,    66,   195,  -289,   243,   201,  -289,
    -289,    97,   166,    14,   360,   -10,   -10,  -289,  -289,  -289,
    -289,  -289,  -289,  -289,   106,    97,   106,    36,  -289,   509,
     266,   240,  -289,  -289,  -289,   106,   140,    97,  -289,   -40,
    -289,  -289,  -289,   189,   189,   -48,   271,   252,   188,   191,
     282,   174,   182,   198,   285,    14,  -289,  -289,  -289,  -289,
     509,    14,  -289,   273,   228,   276,  -289,  -289,  -289,   242,
      23,    97,   210,   185,   284,   197,   509,   106,   360,  -289,
    -289,  -289,  -289,   509,   537,   537,   537,  -289,  -289,  -289,
    -289,  -289,  -289,   566,   566,   566,   217,   217,   217,  -289,
     360,   176,   301,  -289,   166,   258,  -289,  -289,  -289,  -289,
    -289,  -289,  -289,  -289,   203,   484,  -289,  -289,   392,    34,
    -289,  -289,   106,  -289,   106,    36,   509,   248,   509,    53,
      97,    53,    53,    53,    97,  -289,   106,  -289,  -289,   509,
    -289,  -289,  -289,    97,   311,  -289,    97,   318,   398,   398,
    -289,   398,   300,    33,  -289,  -289,   106,   324,  -289,  -289,
    -289,  -289,  -289,  -289,  -289,  -289,  -289,   509,    97,  -289,
    -289,   509,  -289,   373,  -289,     5,  -289,   509,   509,  -289,
     106,   319,  -289,  -289,   161,  -289,  -289,    97,  -289,   268,
     322,  -289,   253,   255,   327,  -289,  -289,  -289,  -289,   509,
    -289,    97,   275,   333,   269,   270,  -289,  -289,   537,   308,
    -289,   334,   274,   189,   189,   -48,  -289,  -289,  -289,   509,
      97,   243,    53,   267,   509,   283,   509,   353,   250,  -289,
     342,   398,   278,   509,   292,   509,   362,  -289,  -289,   509,
     509,   294,  -289,  -289,    36,  -289,   161,  -289,   369,   106,
     106,  -289,  -289,   264,    53,   370,   272,   277,  -289,  -289,
    -289,  -289,   279,   398,   372,   281,   286,   359,   288,   509,
      97,    34,    97,  -289,  -289,    53,  -289,   297,    53,  -289,
     398,  -289,   298,   398,  -289,  -289,   509,  -289,  -289,  -289,
    -289,   253,  -289,   255,   269,  -289,   270,   274,  -289,  -289,
    -289,  -289,  -289
};

/* YYPGOTO[NTERM-NUM].  */
static const short yypgoto[] =
{
    -289,  -289,   -29,  -289,  -289,  -289,    11,   304,  -289,   390,
     -63,  -289,  -289,  -289,  -289,   227,  -289,  -289,   229,   -25,
    -109,  -179,   305,    90,  -289,  -289,  -289,  -289,   -12,   154,
    -289,  -289,  -289,  -289,  -289,    28,   117,  -289,  -289,  -289,
     150,   -52,  -289,    25,    -2,     4,  -289,  -289,     8,    -5,
     236,  -289,  -289,  -289,  -138,  -289,  -186,  -194,  -289,  -289,
    -134,   -57,   -43,   -22,   -11,  -289,  -289,  -289,  -289,  -133,
    -289,  -289,  -289,  -289,  -289,    -9,  -289,    -3,  -288,  -224,
    -289,   -93,  -289,    -4,   -76,  -220,   206,  -289,   310,  -289,
    -115,  -289,   -96,  -289,   145,  -289,   208,  -289,     2,   -72,
    -153,   226,   162,  -289,  -103,    39,   -27,  -289,   153,  -289
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -79
static const short yytable[] =
{
      32,   156,   192,     6,   131,    36,    96,   205,    43,   283,
     283,   115,   232,    17,   259,     9,   207,    63,   284,    68,
     151,   364,    -4,   365,   317,   318,   285,    90,   211,   212,
     213,     9,   225,   126,   101,   -17,   267,    31,   230,   266,
     119,    65,    58,   227,   228,   102,    31,    33,   149,    66,
      71,   203,   337,   233,    72,   235,    31,    98,    73,     5,
      64,   107,   173,    99,    34,    76,    11,   352,   353,   354,
     254,   255,   177,   178,   179,   180,    31,   174,   103,   119,
      77,   295,    95,    78,   236,     7,   102,   297,    59,    60,
      46,   208,   195,    79,    12,   302,   274,    13,   156,   263,
     315,   131,   256,   420,    16,    80,    81,    18,   338,   111,
     200,    20,   120,   257,   121,   197,   208,   151,    61,   103,
      31,   303,   326,    44,    37,   279,    56,   296,     8,   183,
     126,   303,    38,   313,    57,   441,   122,   123,   320,   321,
     322,    34,   261,   131,    39,   149,     1,    64,   397,   131,
     316,   120,   454,   121,    67,   456,    90,   351,   411,   307,
     323,   324,   156,   268,   269,    75,   216,   217,   218,   219,
     358,    11,   126,    -3,    88,   122,   123,    89,   126,   283,
     283,   151,   192,   346,   156,    95,   108,   402,   403,   112,
     436,   239,   240,   241,   242,   348,   404,   175,   176,   113,
      95,   304,   327,   151,   118,   181,   182,   278,   169,   149,
     184,   451,   185,   186,   453,   334,   187,   131,   102,   131,
     131,   131,   355,   270,   370,   272,   375,   198,   410,   132,
     168,   149,   156,   156,   277,   156,     8,   199,   372,   133,
      31,   134,    46,   135,   376,   377,   220,   137,   215,   221,
     231,   243,   138,   335,   247,   248,   249,   250,   251,   252,
     234,   208,   238,   201,   244,   246,   389,   245,   258,   236,
     373,   260,   276,   -78,   208,   381,   314,   304,   275,   149,
     149,    47,   149,   286,   304,   287,   405,   345,   141,   390,
     288,   413,   380,   416,   290,   291,   370,   289,   299,   371,
     422,   294,   425,   292,   293,   298,   309,   428,   335,   300,
     131,   143,   144,   378,   301,   156,   308,   310,   311,   328,
     147,   342,   347,   343,   331,   265,   132,   168,   330,   359,
     361,   -78,    46,   366,   368,   356,   447,   379,   382,   383,
     384,   398,   131,   386,   388,   391,   -78,   156,    47,   -78,
     392,   406,     8,   457,   431,   367,   393,    48,   395,   -78,
     399,   400,   149,   131,   156,   412,   131,   156,   132,   414,
     417,   -78,   -78,   418,   132,   419,   421,   -40,   423,   426,
     429,   432,   133,    31,   134,   435,   135,   437,   136,   442,
     137,   168,   445,   438,   149,   138,   -40,   452,   455,   439,
     440,   406,   443,   406,   139,   140,   345,   196,   444,   446,
      30,   149,   271,   168,   149,   -40,   273,   265,   329,   204,
     133,    31,   134,   374,   135,   332,   136,   427,   137,   430,
     450,   141,   460,   138,   448,   280,    46,   -40,   -40,   449,
     458,   142,   139,   140,   357,    13,   226,   461,   433,   434,
     459,    38,   319,   462,   143,   144,   -40,   -40,   145,   -40,
     146,     0,   312,   147,    13,   -40,   325,   -40,   360,   141,
      38,     0,     0,   114,     0,   -40,   -40,     0,   -40,   142,
       0,     0,   148,    13,   -40,     0,   -40,     0,     0,    38,
       0,     0,   143,   144,   188,     0,   145,   -40,   146,     0,
       0,   147,     0,   -40,     0,   -40,   133,    31,   134,     0,
     135,   333,   136,     0,   137,     0,     0,     0,     0,   138,
     148,     0,     0,     0,     0,     0,     0,     0,   139,   140,
       0,   133,    31,   134,     0,   135,     0,   136,     0,   137,
       0,     0,     0,     0,   138,     0,     0,     0,     0,     0,
       0,     0,     0,   139,   140,   141,    21,     0,     0,   133,
      31,   134,     0,   135,     0,   136,     0,   137,     0,     0,
       0,     0,   138,     0,     0,     0,     0,     0,   143,   144,
     141,   139,   140,     0,   189,     0,     0,   147,   133,    31,
     134,     0,   135,     0,     0,    22,   137,     0,    23,     0,
      24,   138,     0,   143,   144,     0,     0,     0,   141,   189,
     139,   140,   147,     0,     0,     0,     0,    25,     0,     0,
       0,     0,     0,     0,     0,    26,     0,     0,     0,     0,
      27,   143,   144,     0,     0,    28,     0,   141,     0,     0,
     147,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     143,   144,     0,     0,     0,     0,     0,     0,     0,   147
};

static const short yycheck[] =
{
      29,    77,    95,     1,    76,    32,    58,   116,    33,   203,
     204,    74,   145,    11,   167,     4,   119,    44,   204,    48,
      77,   309,     0,   311,   244,   245,   205,    56,   121,   122,
     123,    20,   135,    76,    33,     3,   174,    23,   141,   173,
      26,    46,    40,   139,   140,    85,    23,    18,    77,    47,
      48,   114,    18,   146,   104,   148,    23,   105,   108,    23,
      26,    66,    75,   111,    35,    75,    16,   291,   292,   293,
      44,    45,    84,    85,    86,    87,    23,    90,   118,    26,
      90,   215,    24,    93,    26,     0,    85,   221,    83,    84,
      76,   120,    97,   103,    70,    72,   189,    91,   174,   171,
     238,   173,    36,   391,     3,   115,   116,   114,    74,    70,
     108,    70,    98,    47,   100,   104,   145,   174,   113,   118,
      23,    98,   260,    44,    89,   197,    26,   220,    96,    90,
     173,    98,    97,   236,    26,   423,   122,   123,   253,   254,
     255,    35,   171,   215,   109,   174,   124,    26,   368,   221,
     243,    98,   440,   100,    23,   443,   185,   290,   382,   231,
     256,   257,   238,   175,   176,    17,   127,   128,   129,   130,
     303,    16,   215,    18,    70,   122,   123,    70,   221,   373,
     374,   238,   275,   286,   260,    24,    18,   373,   374,   129,
     414,   152,   153,   154,   155,   288,   375,    80,    81,   108,
      24,   230,    26,   260,    23,    88,    89,   196,    35,   238,
      33,   435,    12,    33,   438,   278,    12,   289,    85,   291,
     292,   293,   294,   184,   327,   186,   335,    33,   381,    76,
      77,   260,   308,   309,   195,   311,    96,    12,   331,    22,
      23,    24,    76,    26,   337,   338,    74,    30,    70,    70,
      26,    18,    35,   278,    49,    50,    51,    52,    53,    54,
      26,   290,    70,   110,    10,     5,   359,   110,    73,    26,
     333,    70,    32,    17,   303,   347,   237,   306,    12,   308,
     309,    92,   311,    12,   313,    33,   379,   285,    71,   361,
     102,   384,   344,   386,    12,   121,   399,   106,    70,   328,
     393,    16,   395,   121,   106,    32,   121,   400,   333,    33,
     382,    94,    95,   340,    72,   391,   106,    33,   121,    18,
     103,   282,    74,   284,   121,   172,   173,   174,    70,    18,
      12,    75,    76,    33,    10,   296,   429,    18,    70,    17,
      87,    33,   414,    88,    17,    70,    90,   423,    92,    93,
      17,   380,    96,   446,   406,   316,    87,   101,    88,   103,
      26,    87,   391,   435,   440,    98,   438,   443,   215,    86,
      17,   115,   116,   123,   221,    33,    98,    23,    86,    17,
      86,    12,    22,    23,    24,   121,    26,    17,    28,    17,
      30,   238,    33,   121,   423,    35,    23,   100,   100,   122,
     121,   430,   121,   432,    44,    45,   404,   103,   122,   121,
      20,   440,   185,   260,   443,    23,   187,   264,   264,   114,
      22,    23,    24,   333,    26,   275,    28,   399,    30,   404,
     432,    71,   454,    35,   430,   199,    76,    83,    84,   431,
     451,    81,    44,    45,   299,    91,   136,   456,   409,   410,
     453,    97,   246,   457,    94,    95,    83,    84,    98,   105,
     100,    -1,   236,   103,    91,   111,   258,   113,   306,    71,
      97,    -1,    -1,   119,    -1,    83,    84,    -1,   105,    81,
      -1,    -1,   122,    91,   111,    -1,   113,    -1,    -1,    97,
      -1,    -1,    94,    95,    10,    -1,    98,   105,   100,    -1,
      -1,   103,    -1,   111,    -1,   113,    22,    23,    24,    -1,
      26,   119,    28,    -1,    30,    -1,    -1,    -1,    -1,    35,
     122,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    44,    45,
      -1,    22,    23,    24,    -1,    26,    -1,    28,    -1,    30,
      -1,    -1,    -1,    -1,    35,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    44,    45,    71,    38,    -1,    -1,    22,
      23,    24,    -1,    26,    -1,    28,    -1,    30,    -1,    -1,
      -1,    -1,    35,    -1,    -1,    -1,    -1,    -1,    94,    95,
      71,    44,    45,    -1,   100,    -1,    -1,   103,    22,    23,
      24,    -1,    26,    -1,    -1,    77,    30,    -1,    80,    -1,
      82,    35,    -1,    94,    95,    -1,    -1,    -1,    71,   100,
      44,    45,   103,    -1,    -1,    -1,    -1,    99,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,   107,    -1,    -1,    -1,    -1,
     112,    94,    95,    -1,    -1,   117,    -1,    71,    -1,    -1,
     103,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      94,    95,    -1,    -1,    -1,    -1,    -1,    -1,    -1,   103
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,   124,   133,   135,   140,    23,   230,     0,    96,   138,
     141,    16,    70,    91,   136,   142,     3,   230,   114,   137,
      70,    38,    77,    80,    82,    99,   107,   112,   117,   143,
     141,    23,   134,    18,    35,   145,   238,    89,    97,   109,
     144,   146,   149,   151,    44,   239,    76,    92,   101,   138,
     156,   159,   168,   169,   189,   240,    26,    26,   230,    83,
      84,   113,   152,   238,    26,   181,   230,    23,   134,   157,
     158,   230,   104,   108,   170,    17,    75,    90,    93,   103,
     115,   116,   160,   162,   184,   185,   190,   191,    70,    70,
     134,   147,   148,   150,   230,    24,   173,   174,   105,   111,
     153,    33,    85,   118,   139,   182,   183,   181,    18,   237,
     238,   237,   129,   108,   119,   142,   151,   154,    23,    26,
      98,   100,   122,   123,   134,   192,   194,   200,   204,   205,
     208,   231,   240,    22,    24,    26,    28,    30,    35,    44,
      45,    71,    81,    94,    95,    98,   100,   103,   122,   134,
     186,   193,   199,   203,   206,   212,   216,   217,   218,   219,
     220,   222,   223,   224,   225,   228,   229,   231,   240,    35,
     163,   164,   166,    75,    90,   168,   168,   160,   160,   160,
     160,   168,   168,   237,    33,    12,    33,    12,    10,   100,
     171,   172,   213,   214,   216,   181,   139,   138,    33,    12,
     230,   240,   241,   142,   154,   152,   213,   236,   134,   201,
     202,   213,   213,   213,   173,    70,   237,   237,   237,   237,
      74,    70,   226,   227,   236,   236,   220,   224,   224,   233,
     236,    26,   201,   213,    26,   213,    26,   232,    70,   237,
     237,   237,   237,    18,    10,   110,     5,    49,    50,    51,
      52,    53,    54,   221,    44,    45,    36,    47,    73,   232,
      70,   134,   165,   231,   161,   240,   192,   186,   160,   160,
     237,   147,   237,   150,   213,    12,    32,   237,   138,   231,
     182,   187,   188,   189,   188,   153,    12,    33,   102,   106,
      12,   121,   121,   106,    16,   192,   213,   192,    32,    70,
      33,    72,    72,    98,   134,   234,   235,   231,   106,   121,
      33,   121,   233,   236,   237,   186,   213,   217,   217,   218,
     222,   222,   222,   224,   224,   228,   186,    26,    18,   161,
      70,   121,   172,   119,   142,   151,   155,    18,    74,   179,
     180,   181,   237,   237,   175,   230,   236,    74,   213,   194,
     211,   201,   211,   211,   211,   231,   237,   226,   201,    18,
     234,    12,   193,   210,   210,   210,    33,   237,    10,   167,
     236,   134,   213,   142,   155,   152,   213,   213,   238,    18,
     173,   231,    70,    17,    87,   196,    88,   209,    17,   213,
     231,    70,    17,    87,   195,    88,   207,   217,    33,    26,
      87,   215,   188,   188,   153,   213,   134,   176,   177,   178,
     232,   211,    98,   213,    86,   198,   213,    17,   123,    33,
     210,    98,   213,    86,   197,   213,    17,   167,   213,    86,
     175,   173,    12,   237,   237,   121,   211,    17,   121,   122,
     121,   210,    17,   121,   122,    33,   121,   213,   177,   180,
     176,   211,   100,   211,   210,   100,   210,   213,   196,   209,
     195,   207,   215
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
      
    }

/* Line 999 of yacc.c.  */
#line 1745 "parser.tab.c"

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




