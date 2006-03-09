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




/* Copy the first part of user declarations.  */
#line 31 "parser.y"

#include <stdio.h> 
#include "yacclib.h" 
#include "rml.h" 
#include "absyn.h" 
#include "defs.h"
#define MAXCOMMENT 2000
extern int yylineno;
extern char yaccCommentBuffer[];
extern char parserCommentBuffer[];

#define mkIDENT(x) mk_scon(((struct Token*)x)->u.ident)

#define YYSTYPE rml_t
extern rml_t *absyntree;



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
#line 227 "parser.c"

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
#define YYFINAL  10
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   420

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  62
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  65
/* YYNRULES -- Number of rules. */
#define YYNRULES  146
/* YYNRULES -- Number of states. */
#define YYNSTATES  254

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   316

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
      55,    56,    57,    58,    59,    60,    61
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned short yyprhs[] =
{
       0,     0,     3,     5,     7,    13,    18,    19,    23,    26,
      27,    30,    34,    37,    41,    46,    51,    54,    55,    58,
      61,    65,    70,    73,    76,    78,    85,    86,    89,    93,
      95,   100,   104,   106,   111,   115,   117,   119,   123,   124,
     127,   130,   132,   139,   144,   145,   148,   151,   152,   154,
     158,   160,   164,   168,   173,   176,   180,   184,   186,   190,
     192,   195,   199,   203,   205,   209,   211,   214,   216,   220,
     224,   226,   230,   234,   236,   239,   241,   243,   245,   249,
     253,   256,   257,   259,   263,   265,   269,   270,   272,   274,
     278,   280,   284,   286,   289,   293,   299,   301,   305,   307,
     310,   313,   315,   317,   319,   321,   323,   327,   328,   331,
     332,   334,   336,   340,   341,   343,   347,   349,   351,   353,
     355,   357,   361,   363,   367,   369,   372,   376,   378,   380,
     384,   388,   391,   395,   397,   401,   403,   407,   408,   410,
     412,   416,   418,   420,   422,   424,   426
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const yysigned_char yyrhs[] =
{
      63,     0,    -1,    64,    -1,    65,    -1,    14,   124,    32,
      66,    70,    -1,    12,   124,    32,    66,    -1,    -1,    68,
      67,     9,    -1,    69,    68,    -1,    -1,    22,    61,    -1,
      20,   119,   124,    -1,    20,    75,    -1,     7,    77,    74,
      -1,    21,   124,    32,   113,    -1,    18,   124,    32,   113,
      -1,    71,    70,    -1,    -1,    22,    61,    -1,    20,    75,
      -1,     7,    77,    74,    -1,    21,   124,    42,    88,    -1,
      18,    73,    -1,    32,   113,    -1,   126,    -1,   124,    72,
      42,    82,    81,     9,    -1,    -1,    23,    75,    -1,    76,
       3,    75,    -1,    76,    -1,   120,   124,    42,   113,    -1,
      78,     3,    77,    -1,    78,    -1,   120,   124,    42,    79,
      -1,    80,    36,    79,    -1,    80,    -1,   124,    -1,   124,
      16,   114,    -1,    -1,     8,    82,    -1,    83,    82,    -1,
      83,    -1,    19,    85,    35,   124,   108,    84,    -1,     6,
     124,   108,    84,    -1,    -1,    39,   100,    -1,    39,    11,
      -1,    -1,    86,    -1,    87,    37,    86,    -1,    87,    -1,
     122,   100,   107,    -1,   124,    42,    88,    -1,    13,   101,
      42,    88,    -1,    15,    87,    -1,    28,    86,    29,    -1,
      90,    33,    88,    -1,    90,    -1,    88,    34,    89,    -1,
      88,    -1,    28,    29,    -1,    28,    88,    29,    -1,    28,
      89,    29,    -1,    92,    -1,    92,    33,    91,    -1,    92,
      -1,   122,    99,    -1,    93,    -1,    94,    43,    93,    -1,
      94,    44,    93,    -1,    94,    -1,    95,    40,    94,    -1,
      95,    45,    94,    -1,    95,    -1,    44,    95,    -1,    96,
      -1,   112,    -1,   122,    -1,    24,    97,    25,    -1,    28,
      88,    29,    -1,    28,    29,    -1,    -1,    98,    -1,    88,
      34,    98,    -1,    88,    -1,    28,    97,    29,    -1,    -1,
      91,    -1,    99,    -1,   124,     4,   101,    -1,   102,    -1,
     103,    33,   102,    -1,   103,    -1,    28,    29,    -1,    28,
     101,    29,    -1,    28,   101,    34,   111,    29,    -1,   105,
      -1,   105,    33,   104,    -1,   105,    -1,   122,   109,    -1,
     122,   106,    -1,   106,    -1,    41,    -1,   112,    -1,   121,
      -1,   124,    -1,    24,   110,    25,    -1,    -1,    39,   108,
      -1,    -1,   104,    -1,   109,    -1,    28,   110,    29,    -1,
      -1,   111,    -1,   101,    34,   111,    -1,   101,    -1,    58,
      -1,    59,    -1,    60,    -1,    61,    -1,   117,    39,   117,
      -1,   114,    -1,   115,    40,   114,    -1,   115,    -1,   115,
     122,    -1,    28,   113,    29,    -1,   125,    -1,   122,    -1,
     113,    34,   116,    -1,   113,    34,   113,    -1,    28,    29,
      -1,    28,   116,    29,    -1,   114,    -1,   125,    34,   118,
      -1,   125,    -1,    28,   118,    29,    -1,    -1,   125,    -1,
     119,    -1,   123,    31,   123,    -1,   121,    -1,   124,    -1,
      56,    -1,   123,    -1,    57,    -1,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short yyrline[] =
{
       0,    51,    51,    84,    96,    99,   105,   104,   110,   113,
     117,   120,   123,   126,   129,   132,   137,   140,   144,   147,
     150,   153,   156,   161,   164,   169,   174,   176,   181,   184,
     189,   194,   197,   202,   207,   210,   215,   218,   222,   225,
     230,   233,   238,   241,   247,   250,   253,   259,   261,   266,
     269,   274,   277,   280,   283,   286,   293,   296,   301,   304,
     309,   312,   315,   318,   323,   326,   331,   334,   339,   342,
     345,   350,   353,   356,   361,   364,   369,   372,   375,   378,
     381,   387,   389,   394,   397,   402,   408,   410,   413,   420,
     423,   428,   431,   436,   439,   442,   445,   450,   453,   458,
     461,   464,   469,   472,   475,   478,   481,   487,   489,   495,
     497,   500,   506,   512,   514,   519,   522,   529,   532,   537,
     542,   549,   554,   559,   562,   568,   574,   577,   580,   585,
     588,   593,   596,   599,   604,   607,   612,   618,   620,   623,
     630,   635,   637,   643,   650,   662,   675
};
#endif

#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "KW_AND", "KW_AS", "KW_ABSTYPE", 
  "KW_AXIOM", "KW_DATATYPE", "KW_DEFAULT", "KW_END", "KW_EQTYPE", 
  "KW_FAIL", "KW_INTERFACE", "KW_LET", "KW_MODULE", "KW_NOT", "KW_OF", 
  "KW_OR", "KW_RELATION", "KW_RULE", "KW_TYPE", "KW_VAL", "KW_WITH", 
  "KW_WITHTYPE", "LBRACK", "RBRACK", "LBRACE", "RBRACE", "LPAR", "RPAR", 
  "ASSIGN", "DOT", "COLON", "COLONCOLON", "COMMA", "DASHES", "BAR", 
  "AMPERSAND", "SEMICOLON", "YIELDS", "STAR", "UNDERSCORE", "EQUALS", 
  "PLUS", "MINUS", "DIV", "LESS", "LESSEQ", "GREATER", "GREATEREQ", 
  "EQEQ", "LESSGT", "SLASH", "POWER", "UNSIGNED_INTEGER", "UNSIGNED_REAL", 
  "IDENT", "TYVARIDENT", "CCON", "ICON", "RCON", "SCON", "$accept", 
  "start", "stored_definition", "rml_file", "rml_interface", "@1", 
  "rml_interface_item_star", "rml_interface_item", "rml_definitions", 
  "rml_definition_item", "opt_type", "relbind", "withbind", 
  "typbind_plus", "typbind", "datbind_plus", "datbind", "conbind_plus", 
  "conbind", "default_opt", "clause_plus", "clause", "result", 
  "conjunctive_goal_opt", "conjunctive_goal", "atomic_goal", 
  "rml_expression", "rml_expression_list", "rml_exp_a", "rml_exp_b", 
  "rml_exp_c", "rml_addsub", "rml_muldiv", "rml_unary", "rml_primary", 
  "rml_exp_comma_star", "rml_exp_comma_plus", "rml_exp_star", "seq_exp", 
  "pat", "pat_a", "pat_b", "pat_c", "pat_d", "pat_e", "res_pat", 
  "seq_pat", "pat_star", "pat_comma_star", "pat_comma_plus", 
  "rml_literal", "ty", "tuple_ty", "ty_sans_star", "ty_comma_seq2", 
  "seq_ty", "tyvarseq1", "tyvarparseq", "tyvarseq", "longid", 
  "longorshortid", "ident", "rml_ident", "tyvar", "empty", 0
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
     315,   316
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    62,    63,    64,    65,    65,    67,    66,    68,    68,
      69,    69,    69,    69,    69,    69,    70,    70,    71,    71,
      71,    71,    71,    72,    72,    73,    74,    74,    75,    75,
      76,    77,    77,    78,    79,    79,    80,    80,    81,    81,
      82,    82,    83,    83,    84,    84,    84,    85,    85,    86,
      86,    87,    87,    87,    87,    87,    88,    88,    89,    89,
      90,    90,    90,    90,    91,    91,    92,    92,    93,    93,
      93,    94,    94,    94,    95,    95,    96,    96,    96,    96,
      96,    97,    97,    98,    98,    99,   100,   100,   100,   101,
     101,   102,   102,   103,   103,   103,   103,   104,   104,   105,
     105,   105,   106,   106,   106,   106,   106,   107,   107,   108,
     108,   108,   109,   110,   110,   111,   111,   112,   112,   112,
     112,   113,   113,   114,   114,   115,   115,   115,   115,   116,
     116,   117,   117,   117,   118,   118,   119,   120,   120,   120,
     121,   122,   122,   123,   124,   125,   126
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     1,     1,     5,     4,     0,     3,     2,     0,
       2,     3,     2,     3,     4,     4,     2,     0,     2,     2,
       3,     4,     2,     2,     1,     6,     0,     2,     3,     1,
       4,     3,     1,     4,     3,     1,     1,     3,     0,     2,
       2,     1,     6,     4,     0,     2,     2,     0,     1,     3,
       1,     3,     3,     4,     2,     3,     3,     1,     3,     1,
       2,     3,     3,     1,     3,     1,     2,     1,     3,     3,
       1,     3,     3,     1,     2,     1,     1,     1,     3,     3,
       2,     0,     1,     3,     1,     3,     0,     1,     1,     3,
       1,     3,     1,     2,     3,     5,     1,     3,     1,     2,
       2,     1,     1,     1,     1,     1,     3,     0,     2,     0,
       1,     1,     3,     0,     1,     3,     1,     1,     1,     1,
       1,     3,     1,     3,     1,     2,     3,     1,     1,     3,
       3,     2,     3,     1,     3,     1,     3,     0,     1,     1,
       3,     1,     1,     1,     1,     1,     0
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned char yydefact[] =
{
       0,     0,     0,     0,     2,     3,   143,   144,     0,     0,
       1,     9,     9,   137,     0,   137,     0,     0,     5,     6,
       9,    17,     0,   145,    26,    32,   139,     0,   138,     0,
      12,    29,     0,     0,     0,    10,     0,     8,   137,     0,
     137,     0,     0,     4,    17,     0,   135,   137,    13,   137,
       0,     0,   137,    11,     0,     0,     7,    26,    22,   146,
      19,     0,    18,    16,   136,     0,    27,    31,     0,     0,
      15,   122,   124,     0,   141,   128,   144,   142,   127,    28,
       0,    14,    20,     0,     0,    24,     0,   134,    33,    35,
      36,   131,     0,     0,     0,   125,     0,     0,    30,    23,
       0,    81,     0,     0,   117,   118,   119,   120,    21,    57,
      63,    67,    70,    73,    75,    76,    77,     0,     0,   126,
       0,   132,     0,   123,   133,   121,   140,     0,    47,    38,
      41,    84,     0,    82,    60,     0,     0,     0,    74,    77,
       0,     0,     0,     0,     0,    81,    66,    34,    37,   130,
     129,     0,   109,     0,     0,     0,     0,    48,    50,    86,
     142,     0,     0,    40,     0,    78,    61,     0,    62,    80,
       0,    56,    68,    69,    71,    72,     0,   113,   113,   102,
     110,    98,   101,    44,   111,   103,   104,     0,   105,     0,
       0,    90,    92,    96,   142,    54,     0,     0,     0,     0,
      87,    65,    88,   107,     0,    39,    25,    83,    59,    58,
      79,    85,   116,     0,   114,     0,     0,    86,    43,   100,
      99,   104,   105,    93,     0,     0,     0,     0,    55,   109,
      49,     0,     0,   109,    51,    52,     0,   106,   112,    97,
      46,    45,    94,     0,    53,    91,    89,    44,    64,   108,
     115,     0,    42,    95
};

/* YYDEFGOTO[NTERM-NUM]. */
static const short yydefgoto[] =
{
      -1,     3,     4,     5,    18,    36,    19,    20,    43,    44,
      84,    58,    48,    30,    31,    24,    25,    88,    89,   162,
     129,   130,   218,   156,   157,   158,   131,   136,   109,   200,
     110,   111,   112,   113,   114,   176,   133,   202,   203,   212,
     191,   192,   180,   193,   182,   234,   183,   184,   213,   214,
     115,    70,    71,    72,    93,    73,    45,    26,    33,    74,
     116,    76,    77,    78,    85
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -217
static const short yypact[] =
{
      67,   -34,   -34,    12,  -217,  -217,  -217,  -217,    30,    39,
    -217,   325,   325,   -11,   -34,   -11,   -34,    24,  -217,  -217,
     325,   375,    38,  -217,    70,   132,  -217,   -34,  -217,   101,
    -217,   134,   -34,   -34,   111,  -217,   154,  -217,   -11,   -34,
     -11,   -34,   114,  -217,   375,   151,   149,   -11,  -217,   -11,
     142,     0,   -11,  -217,   148,     0,  -217,    70,  -217,   155,
    -217,   152,  -217,  -217,  -217,    38,  -217,  -217,   -34,   145,
    -217,   156,   -35,   159,  -217,  -217,   162,  -217,  -217,  -217,
       0,  -217,  -217,     0,   158,  -217,   259,  -217,  -217,   168,
     192,  -217,    80,   180,    84,  -217,     0,   -34,  -217,  -217,
      18,   259,   240,   297,  -217,  -217,  -217,  -217,  -217,   177,
    -217,  -217,   118,    78,  -217,  -217,   183,   -34,    84,  -217,
       0,  -217,     0,  -217,  -217,  -217,  -217,   -34,    36,   205,
      18,   189,   199,  -217,    10,   110,   185,   246,  -217,  -217,
     259,   297,   297,   297,   297,   259,  -217,  -217,  -217,   197,
    -217,   204,   303,   309,    36,    36,   202,  -217,   201,   347,
     206,    18,   225,  -217,   259,  -217,    60,   259,  -217,  -217,
     210,  -217,  -217,  -217,  -217,  -217,   215,   309,   309,  -217,
    -217,   213,  -217,   212,  -217,  -217,   353,   303,   359,   252,
     207,  -217,   220,  -217,    73,  -217,   230,   -34,    36,   246,
    -217,   227,  -217,   228,   259,  -217,  -217,  -217,   237,  -217,
    -217,  -217,   239,   253,  -217,   248,    89,   161,  -217,  -217,
    -217,  -217,  -217,  -217,   130,   259,   309,   309,  -217,   303,
    -217,   131,   297,   303,  -217,  -217,   309,  -217,  -217,  -217,
    -217,  -217,  -217,   309,  -217,  -217,  -217,   212,  -217,  -217,
    -217,   256,  -217,  -217
};

/* YYPGOTO[NTERM-NUM].  */
static const short yypgoto[] =
{
    -217,  -217,  -217,  -217,   270,  -217,   266,  -217,   244,  -217,
    -217,  -217,   232,    49,  -217,   -19,  -217,   174,  -217,  -217,
    -116,  -217,    45,  -217,  -146,   140,   -79,   128,  -217,    65,
    -157,    37,    27,   211,  -217,   208,   160,   200,   105,  -147,
      97,  -217,   112,  -142,   139,  -217,  -170,   143,   157,  -216,
    -105,   -44,   -28,  -217,   209,   238,   271,   323,    -5,    29,
      14,     2,    -1,   214,  -217
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -143
static const short yytable[] =
{
       8,     9,   201,     7,     7,    94,   190,   108,    27,   196,
     181,    81,    10,    29,   163,    34,     7,    22,     7,    57,
     250,     6,     6,   135,   127,    92,    50,   251,    69,     7,
      67,    53,    54,    27,     7,     7,    98,   128,    59,    99,
      61,     7,   224,     7,    27,   205,    23,   185,   185,   153,
     -80,   154,   230,   -80,   -80,   -80,     6,    23,   170,   247,
     201,   171,    11,   249,   155,    75,   123,    90,   124,    75,
       7,    12,   185,   185,   181,   201,   149,   227,   151,     1,
     246,     2,   185,    75,   185,    35,    95,   181,   208,    60,
     148,   181,     6,    47,    75,    23,    66,    75,  -105,   126,
     -79,    79,  -105,   -79,   -79,   -79,  -105,  -105,    75,   119,
      75,   185,   122,   177,   120,  -105,    90,   139,   143,     7,
     231,   185,   185,   144,   185,   235,   152,   160,   185,     7,
     179,   185,    75,    51,    75,    49,    75,    52,   185,   166,
       6,    23,   159,    55,   167,     6,   244,   104,   105,   106,
     107,   188,   194,   160,   160,   139,   139,   139,   139,   242,
     210,   141,   142,    56,   243,   164,   187,   187,   159,   159,
     174,   175,   240,    69,    91,    62,   194,   194,   172,   173,
      64,   186,   186,    65,    68,   101,   222,    83,   194,   199,
      80,   187,   187,    97,    86,  -133,   229,   160,    96,     7,
     100,     6,    23,   187,   117,   103,   186,   186,   118,   121,
     140,   145,   159,   161,   168,   188,   221,     6,   186,   104,
     105,   106,   107,   164,   165,   188,   194,    28,   188,    28,
     187,   120,   188,   119,   206,   194,    46,   197,   198,   210,
     187,   187,   194,   187,   211,   186,   216,   187,   204,   225,
     187,   217,    28,   226,    28,   186,   186,   187,   186,   228,
     232,    28,   186,    28,   101,   186,    28,   233,   102,   134,
     101,   167,   186,   236,   102,   169,   177,   238,   237,    46,
     189,   223,    21,   101,   103,   253,    37,   102,    63,    82,
     103,   147,   252,   179,   195,   209,     6,   248,   104,   105,
     106,   107,     6,   103,   104,   105,   106,   107,     6,   132,
     104,   105,   106,   107,   138,     6,   146,   104,   105,   106,
     107,   101,   241,   245,   207,   137,   219,   177,   239,   150,
     220,   178,    13,   177,   125,   215,    87,   189,    32,     0,
       0,   103,     0,    14,   179,    15,    16,    17,     0,     0,
     179,     0,     0,     6,     0,   104,   105,   106,   107,     6,
       0,   104,   105,   106,   107,     6,     0,   104,   105,   106,
     107,   101,     0,     0,     0,   199,     0,  -141,     0,     0,
       0,  -141,    38,  -142,     0,     0,     0,  -142,     0,     0,
       0,   103,     0,    39,  -141,    40,    41,    42,     0,     0,
    -142,     0,     0,     6,     0,   104,   105,   106,   107,  -141,
       0,  -141,  -141,  -141,  -141,  -142,     0,  -142,  -142,  -142,
    -142
};

static const short yycheck[] =
{
       1,     2,   159,     1,     2,    40,   153,    86,    13,   155,
     152,    55,     0,    14,   130,    16,    14,    28,    16,    38,
     236,    56,    56,   102,     6,    69,    27,   243,    28,    27,
      49,    32,    33,    38,    32,    33,    80,    19,    39,    83,
      41,    39,   189,    41,    49,   161,    57,   152,   153,    13,
      40,    15,   198,    43,    44,    45,    56,    57,   137,   229,
     217,   140,    32,   233,    28,    51,    94,    68,    96,    55,
      68,    32,   177,   178,   216,   232,   120,     4,   122,    12,
     227,    14,   187,    69,   189,    61,    72,   229,   167,    40,
     118,   233,    56,    23,    80,    57,    47,    83,    25,    97,
      40,    52,    29,    43,    44,    45,    33,    34,    94,    29,
      96,   216,    28,    24,    34,    42,   117,   103,    40,   117,
     199,   226,   227,    45,   229,   204,   127,   128,   233,   127,
      41,   236,   118,    32,   120,     3,   122,     3,   243,    29,
      56,    57,   128,    32,    34,    56,   225,    58,    59,    60,
      61,   152,   153,   154,   155,   141,   142,   143,   144,    29,
      29,    43,    44,     9,    34,    34,   152,   153,   154,   155,
     143,   144,    11,    28,    29,    61,   177,   178,   141,   142,
      29,   152,   153,    34,    42,    24,   187,    32,   189,    28,
      42,   177,   178,    31,    42,    39,   197,   198,    39,   197,
      42,    56,    57,   189,    36,    44,   177,   178,    16,    29,
      33,    28,   198,     8,    29,   216,   187,    56,   189,    58,
      59,    60,    61,    34,    25,   226,   227,    13,   229,    15,
     216,    34,   233,    29,     9,   236,    22,    35,    37,    29,
     226,   227,   243,   229,    29,   216,    33,   233,    42,    42,
     236,    39,    38,    33,    40,   226,   227,   243,   229,    29,
      33,    47,   233,    49,    24,   236,    52,    39,    28,    29,
      24,    34,   243,    34,    28,    29,    24,    29,    25,    65,
      28,    29,    12,    24,    44,    29,    20,    28,    44,    57,
      44,   117,   247,    41,   154,   167,    56,   232,    58,    59,
      60,    61,    56,    44,    58,    59,    60,    61,    56,   101,
      58,    59,    60,    61,   103,    56,   116,    58,    59,    60,
      61,    24,   217,   226,   164,    28,   187,    24,   216,   120,
     187,    28,     7,    24,    96,   178,    65,    28,    15,    -1,
      -1,    44,    -1,    18,    41,    20,    21,    22,    -1,    -1,
      41,    -1,    -1,    56,    -1,    58,    59,    60,    61,    56,
      -1,    58,    59,    60,    61,    56,    -1,    58,    59,    60,
      61,    24,    -1,    -1,    -1,    28,    -1,    24,    -1,    -1,
      -1,    28,     7,    24,    -1,    -1,    -1,    28,    -1,    -1,
      -1,    44,    -1,    18,    41,    20,    21,    22,    -1,    -1,
      41,    -1,    -1,    56,    -1,    58,    59,    60,    61,    56,
      -1,    58,    59,    60,    61,    56,    -1,    58,    59,    60,
      61
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,    12,    14,    63,    64,    65,    56,   123,   124,   124,
       0,    32,    32,     7,    18,    20,    21,    22,    66,    68,
      69,    66,    28,    57,    77,    78,   119,   120,   125,   124,
      75,    76,   119,   120,   124,    61,    67,    68,     7,    18,
      20,    21,    22,    70,    71,   118,   125,    23,    74,     3,
     124,    32,     3,   124,   124,    32,     9,    77,    73,   124,
      75,   124,    61,    70,    29,    34,    75,    77,    42,    28,
     113,   114,   115,   117,   121,   122,   123,   124,   125,    75,
      42,   113,    74,    32,    72,   126,    42,   118,    79,    80,
     124,    29,   113,   116,    40,   122,    39,    31,   113,   113,
      42,    24,    28,    44,    58,    59,    60,    61,    88,    90,
      92,    93,    94,    95,    96,   112,   122,    36,    16,    29,
      34,    29,    28,   114,   114,   117,   123,     6,    19,    82,
      83,    88,    97,    98,    29,    88,    89,    28,    95,   122,
      33,    43,    44,    40,    45,    28,    99,    79,   114,   113,
     116,   113,   124,    13,    15,    28,    85,    86,    87,   122,
     124,     8,    81,    82,    34,    25,    29,    34,    29,    29,
      88,    88,    93,    93,    94,    94,    97,    24,    28,    41,
     104,   105,   106,   108,   109,   112,   121,   122,   124,    28,
     101,   102,   103,   105,   124,    87,    86,    35,    37,    28,
      91,    92,    99,   100,    42,    82,     9,    98,    88,    89,
      29,    29,   101,   110,   111,   110,    33,    39,    84,   106,
     109,   121,   124,    29,   101,    42,    33,     4,    29,   124,
      86,    88,    33,    39,   107,    88,    34,    25,    29,   104,
      11,   100,    29,    34,    88,   102,   101,   108,    91,   108,
     111,   111,    84,    29
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
#line 52 "parser.y"
    { 
          absyntree = yyvsp[0];
;}
    break;

  case 3:
#line 85 "parser.y"
    {
	  yyval = yyvsp[0];
	;}
    break;

  case 4:
#line 97 "parser.y"
    { yyval = Absyn__RML_5fFILE(yyvsp[-3], yyvsp[-1], yyvsp[0]); ;}
    break;

  case 5:
#line 100 "parser.y"
    { yyval = Absyn__RML_5fFILE(yyvsp[-2], yyvsp[0], mk_nil()); ;}
    break;

  case 6:
#line 105 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 8:
#line 111 "parser.y"
    { yyval = mk_cons(yyvsp[-1], yyvsp[0]); ;}
    break;

  case 9:
#line 113 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 10:
#line 118 "parser.y"
    { yyval = Absyn__WITH(mk_scon(((struct Token*)yyvsp[0])->u.string)); ;}
    break;

  case 11:
#line 121 "parser.y"
    { yyval = mk_nil(); /* FIXME!! */; ;}
    break;

  case 12:
#line 124 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 13:
#line 127 "parser.y"
    { yyval = Absyn__DATATYPEDECL(yyvsp[-1]); ;}
    break;

  case 14:
#line 130 "parser.y"
    { yyval = Absyn__VALINTERFACE(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 15:
#line 133 "parser.y"
    { yyval = Absyn__RELATION_5fINTERFACE(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 16:
#line 138 "parser.y"
    { yyval = mk_cons(yyvsp[-1], yyvsp[0]); ;}
    break;

  case 17:
#line 140 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 18:
#line 145 "parser.y"
    { yyval = Absyn__WITH(mk_scon(((struct Token*)yyvsp[0])->u.string)); ;}
    break;

  case 19:
#line 148 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 20:
#line 151 "parser.y"
    { yyval = Absyn__DATATYPEDECL(yyvsp[-1]); /* FIXME: support withbind */ ;}
    break;

  case 21:
#line 154 "parser.y"
    { yyval = Absyn__VALDEF(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 22:
#line 157 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 23:
#line 162 "parser.y"
    { yyval = mk_some(yyvsp[0]); ;}
    break;

  case 24:
#line 165 "parser.y"
    { yyval = mk_none(); ;}
    break;

  case 25:
#line 170 "parser.y"
    { yyval = Absyn__RELATION_5fDEFINITION(yyvsp[-5], yyvsp[-4], yyvsp[-2]); ;}
    break;

  case 26:
#line 174 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 27:
#line 177 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 28:
#line 182 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 29:
#line 185 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 30:
#line 190 "parser.y"
    { yyval = Absyn__TYPE(yyvsp[-2],yyvsp[0]); /* FIXME: $1 */ ;}
    break;

  case 31:
#line 195 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 32:
#line 198 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 33:
#line 203 "parser.y"
    { yyval = Absyn__DATATYPE(mk_nil(),yyvsp[-2], yyvsp[0]); /* FIXME: $1 */ ;}
    break;

  case 34:
#line 208 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 35:
#line 211 "parser.y"
    { yyval = mk_cons(yyvsp[0], mk_nil()); ;}
    break;

  case 36:
#line 216 "parser.y"
    { yyval = Absyn__DTCONS(yyvsp[0], mk_nil()); ;}
    break;

  case 37:
#line 219 "parser.y"
    { yyval = Absyn__DTCONS(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 39:
#line 226 "parser.y"
    { /* FIXME */;}
    break;

  case 40:
#line 231 "parser.y"
    { yyval = mk_cons(yyvsp[-1], yyvsp[0]); ;}
    break;

  case 41:
#line 234 "parser.y"
    { yyval = mk_cons(yyvsp[0], mk_nil()); ;}
    break;

  case 42:
#line 239 "parser.y"
    { yyval = Absyn__RMLRULE(yyvsp[-2], yyvsp[-1], yyvsp[-4], yyvsp[0]); ;}
    break;

  case 43:
#line 242 "parser.y"
    { yyval = Absyn__RMLRULE(yyvsp[-2], yyvsp[-1], mk_none(), yyvsp[0]); ;}
    break;

  case 44:
#line 247 "parser.y"
    { 
		  yyval = Absyn__RMLNoResult; ;}
    break;

  case 45:
#line 251 "parser.y"
    { yyval = Absyn__RMLResultExp(yyvsp[0]); ;}
    break;

  case 46:
#line 254 "parser.y"
    { yyval = Absyn__RMLResultFail; ;}
    break;

  case 47:
#line 259 "parser.y"
    { yyval = mk_none(); ;}
    break;

  case 48:
#line 262 "parser.y"
    { yyval = mk_some(yyvsp[0]); ;}
    break;

  case 49:
#line 267 "parser.y"
    { yyval = Absyn__RMLGOAL_5fAND(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 50:
#line 270 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 51:
#line 275 "parser.y"
    { yyval = Absyn__RMLGOAL_5fRELATION(yyvsp[-2], yyvsp[-1], yyvsp[0]); ;}
    break;

  case 52:
#line 278 "parser.y"
    { yyval = Absyn__RMLGOAL_5fEQUAL(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 53:
#line 281 "parser.y"
    { yyval = Absyn__RMLGOAL_5fLET(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 54:
#line 284 "parser.y"
    { yyval = Absyn__RMLGOAL_5fNOT(yyvsp[0]); ;}
    break;

  case 55:
#line 287 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 56:
#line 294 "parser.y"
    { yyval = Absyn__RMLCONS(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 57:
#line 297 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 58:
#line 302 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 59:
#line 305 "parser.y"
    { yyval = mk_cons(yyvsp[0], mk_nil()); ;}
    break;

  case 60:
#line 310 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 61:
#line 313 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 62:
#line 316 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 63:
#line 319 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 64:
#line 324 "parser.y"
    { yyval = Absyn__RMLCONS(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 65:
#line 327 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 66:
#line 332 "parser.y"
    { yyval = Absyn__RMLCALL(yyvsp[-1], yyvsp[0]); ;}
    break;

  case 67:
#line 335 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 68:
#line 340 "parser.y"
    { yyval = Absyn__BINARY(yyvsp[-2], Absyn__ADD, yyvsp[0]); ;}
    break;

  case 69:
#line 343 "parser.y"
    { yyval = Absyn__BINARY(yyvsp[-2], Absyn__SUB, yyvsp[0]); ;}
    break;

  case 70:
#line 346 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 71:
#line 351 "parser.y"
    { yyval = Absyn__BINARY(yyvsp[-2], Absyn__MUL, yyvsp[0]); ;}
    break;

  case 72:
#line 354 "parser.y"
    { yyval = Absyn__BINARY(yyvsp[-2], Absyn__DIV, yyvsp[0]); ;}
    break;

  case 73:
#line 357 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 74:
#line 362 "parser.y"
    { yyval = Absyn__UNARY(Absyn__UMINUS, yyvsp[0]); ;}
    break;

  case 75:
#line 365 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 76:
#line 370 "parser.y"
    { yyval = Absyn__RMLLIT(yyvsp[0]); ;}
    break;

  case 77:
#line 373 "parser.y"
    { yyval = Absyn__RML_5fREFERENCE(yyvsp[0]); ;}
    break;

  case 78:
#line 376 "parser.y"
    { yyval = Absyn__RMLLIST(yyvsp[-1]); ;}
    break;

  case 79:
#line 379 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 80:
#line 382 "parser.y"
    { yyval = Absyn__RMLNIL; ;}
    break;

  case 81:
#line 387 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 82:
#line 390 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 83:
#line 395 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 84:
#line 398 "parser.y"
    { yyval = mk_cons(yyvsp[0], mk_nil()); ;}
    break;

  case 85:
#line 403 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 86:
#line 408 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 87:
#line 411 "parser.y"
    { yyval = mk_cons(yyvsp[0], mk_nil()); ;}
    break;

  case 88:
#line 414 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 89:
#line 421 "parser.y"
    { yyval = Absyn__RMLPAT_5fAS(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 90:
#line 424 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 91:
#line 429 "parser.y"
    { yyval = Absyn__RMLPAT_5fCONS(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 92:
#line 432 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 93:
#line 437 "parser.y"
    { yyval = Absyn__RMLPAT_5fNIL; ;}
    break;

  case 94:
#line 440 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 95:
#line 443 "parser.y"
    { yyval = Absyn__RMLPAT_5fSTRUCT(mk_none(),mk_cons(yyvsp[-3], yyvsp[-1])); ;}
    break;

  case 96:
#line 446 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 97:
#line 451 "parser.y"
    { yyval = Absyn__RMLPAT_5fCONS(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 98:
#line 454 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 99:
#line 459 "parser.y"
    { yyval = Absyn__RMLPAT_5fSTRUCT(mk_some(yyvsp[-1]), yyvsp[0]); ;}
    break;

  case 100:
#line 462 "parser.y"
    { yyval = Absyn__RMLPAT_5fSTRUCT(mk_some(yyvsp[-1]), yyvsp[0]); ;}
    break;

  case 101:
#line 465 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 102:
#line 470 "parser.y"
    { yyval = Absyn__RMLPAT_5fWILDCARD; ;}
    break;

  case 103:
#line 473 "parser.y"
    { yyval = Absyn__RMLPAT_5fLITERAL(yyvsp[0]); ;}
    break;

  case 104:
#line 476 "parser.y"
    { yyval = Absyn__RMLPAT_5fIDENT(yyvsp[0]); ;}
    break;

  case 105:
#line 479 "parser.y"
    { yyval = Absyn__RMLPAT_5fIDENT(yyvsp[0]); ;}
    break;

  case 106:
#line 482 "parser.y"
    { yyval = Absyn__RMLPAT_5fLIST(yyvsp[-1]); ;}
    break;

  case 107:
#line 487 "parser.y"
    { yyval = mk_none(); ;}
    break;

  case 108:
#line 490 "parser.y"
    { yyval = mk_some(yyvsp[0]); ;}
    break;

  case 109:
#line 495 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 110:
#line 498 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 111:
#line 501 "parser.y"
    { yyval = Absyn__RMLPAT_5fSTRUCT(mk_none(),yyvsp[0]); ;}
    break;

  case 112:
#line 507 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 113:
#line 512 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 114:
#line 515 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 115:
#line 520 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 116:
#line 523 "parser.y"
    { yyval = mk_cons(yyvsp[0], mk_nil()); ;}
    break;

  case 117:
#line 530 "parser.y"
    { yyval = Absyn__RMLLIT_5fCHAR(mk_icon(((struct Token*)yyvsp[0])->u.number)); ;}
    break;

  case 118:
#line 533 "parser.y"
    { 
		  yyval = Absyn__RMLLIT_5fINTEGER(mk_icon(((struct Token*)yyvsp[0])->u.number));
                  ;}
    break;

  case 119:
#line 538 "parser.y"
    { 
		  yyval = Absyn__RMLLIT_5fREAL(mk_rcon(((struct Token*)yyvsp[0])->u.realnumber));
		;}
    break;

  case 120:
#line 543 "parser.y"
    { yyval = Absyn__RMLLIT_5fSTRING(mk_scon(((struct Token*)yyvsp[0])->u.string)); ;}
    break;

  case 121:
#line 550 "parser.y"
    { yyval = Absyn__RMLTYPE_5fSIGNATURE(
		       Absyn__CALLSIGN(yyvsp[-2], yyvsp[0])); ;}
    break;

  case 122:
#line 555 "parser.y"
    { yyval = Absyn__RMLTYPE_5fTUPLE(yyvsp[0]); ;}
    break;

  case 123:
#line 560 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 124:
#line 563 "parser.y"
    { yyval = mk_cons(yyvsp[0], mk_nil()); ;}
    break;

  case 125:
#line 569 "parser.y"
    { yyval = Absyn__RMLTYPE_5fTYCONS(mk_cons(yyvsp[-1],mk_nil()),yyvsp[0]) ;}
    break;

  case 126:
#line 575 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 127:
#line 578 "parser.y"
    { yyval = Absyn__RMLTYPE_5fTYVAR(yyvsp[0]); ;}
    break;

  case 128:
#line 581 "parser.y"
    { yyval = Absyn__RMLTYPE_5fUSERDEFINED(yyvsp[0]); ;}
    break;

  case 129:
#line 586 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 130:
#line 589 "parser.y"
    { yyval = mk_cons(yyvsp[-2], mk_cons(yyvsp[0], mk_nil())); ;}
    break;

  case 131:
#line 594 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 132:
#line 597 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 133:
#line 600 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 134:
#line 605 "parser.y"
    { yyval = mk_cons(yyvsp[-2], yyvsp[0]); ;}
    break;

  case 135:
#line 608 "parser.y"
    { yyval = mk_cons(yyvsp[0], mk_nil()); ;}
    break;

  case 136:
#line 613 "parser.y"
    { yyval = yyvsp[-1]; ;}
    break;

  case 137:
#line 618 "parser.y"
    { yyval = mk_nil(); ;}
    break;

  case 138:
#line 621 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 139:
#line 624 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 140:
#line 631 "parser.y"
    { yyval = Absyn__RMLLONGID(mkIDENT(yyvsp[-2]), mkIDENT(yyvsp[0])); ;}
    break;

  case 141:
#line 636 "parser.y"
    { yyval = yyvsp[0]; ;}
    break;

  case 142:
#line 638 "parser.y"
    { yyval = yyvsp[0];
          ;}
    break;

  case 143:
#line 644 "parser.y"
    { 
	  yyval = yyvsp[0];
	;}
    break;

  case 144:
#line 651 "parser.y"
    {
	    yyval = Absyn__RMLSHORTID(mkIDENT(yyvsp[0]),
		  Absyn__INFO(
                    mk_scon(((struct Token*)yyvsp[0])->file),
		    mk_icon(((struct Token*)yyvsp[0])->firstline),
		    mk_icon(((struct Token*)yyvsp[0])->firstcol),
		    mk_icon(((struct Token*)yyvsp[0])->lastline),
		    mk_icon(((struct Token*)yyvsp[0])->lastcol))); 
         ;}
    break;

  case 145:
#line 663 "parser.y"
    {
	  yyval = Absyn__RMLSHORTID(mk_scon(((struct Token*)yyvsp[0])->u.string),
		  Absyn__INFO(
                    mk_scon(((struct Token*)yyvsp[0])->file),
		    mk_icon(((struct Token*)yyvsp[0])->firstline),
		    mk_icon(((struct Token*)yyvsp[0])->firstcol),
		    mk_icon(((struct Token*)yyvsp[0])->lastline),
		    mk_icon(((struct Token*)yyvsp[0])->lastcol))); 
	    /* $$ = mk_scon(((struct Token*)$1)->u.string); */
        ;}
    break;


    }

/* Line 999 of yacc.c.  */
#line 2131 "parser.c"

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


#line 678 "parser.y"


#define PCOMMENTBUF 2000
static int yylineno;
static char parserCommentBuffer[PCOMMENTBUF+10];
static char yaccCommentBuffer[PCOMMENTBUF+10];
extern rml_t *absyntree;

#define MAXPOSINDEX   50
static int posIndex  = 0;
static int posLineNo[MAXPOSINDEX+1];

void positionPush()
{
    if (++posIndex > 50)
	yyerror("Internal error: positionPush(): overflow.\n");
    posLineNo[posIndex] = yylineno;
}

void positionPop()
{
    if (--posIndex < 0)
	yyerror("Internal error: positionPop(): underflow.\n");
}

int positionLineNo()
{
    return posLineNo[posIndex];
}

char *positionFileName()
{
    return "NoFile";
}

void *parser_make_element(int   is_final,
			  void *innerouter,
			  int   is_replaceable,
			  void *classdef,
			  void *componentclause,
			  void *constraint,
			  void *comment)
{
    void *final       = is_final ? RML_TRUE : RML_FALSE;
    void *replaceable = is_replaceable ? RML_TRUE : RML_FALSE;

    if (componentclause)
    {
	/* Declaration. */
	return Absyn__ELEMENT(final,
			      replaceable,
			      is_replaceable ? Absyn__UNSPECIFIED : innerouter,
			      mk_scon((is_replaceable ? "replaceable component"
                                                     : "component")),
			      componentclause,
			      mk_scon(positionFileName()),
			      mk_scon(positionLineNo()),
			      constraint ? mk_some(constraint) : mk_none());
    }
    else if (classdef)
    {
	/* Definition. */
	return Absyn__ELEMENT(final,
			      replaceable,
			      is_replaceable ? Absyn__UNSPECIFIED : innerouter,
			      mk_scon((is_replaceable ? "?replaceable classdef?"
                                                     : "?classdef?")),
			      Absyn__CLASSDEF(replaceable, classdef),
			      mk_scon(positionFileName()),
			      mk_scon(positionLineNo()),
			      constraint ? mk_some(constraint) : mk_none());

    }
    else
	yyerror("Internal error in parser_make_element().\n");
}

void **tempQuadMake(void *v1, void *v2, void *v3, void *v4)
{
    void **quad = malloc(sizeof(void *)*4);
    if (!quad)
	yyerror("Out of memory.");
    quad[0] = v1;
    quad[1] = v2;
    quad[2] = v3;
    quad[3] = v4;
    return quad;
}

void *tempQuadGet(void **quad, int element)
{
    if (!quad || element < 0 || element > 3)
	yyerror("Internal error: tempQuadGet(): bad arguments.");
    return quad[element];
}

void tempQuadFree(void **quad)
{
    if (quad)
	free(quad);
}


