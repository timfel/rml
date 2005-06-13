typedef union 
{
  int   v_int;
  float v_float;
  char *to_print;
  char *id;
} YYSTYPE;
#define	T_EOF	258
#define	T_ERROR	259
#define	T_EOL	260
#define	T_HELP	261
#define	T_BREAKPOINT	262
#define	T_SET	263
#define	T_RUN	264
#define	T_STEP	265
#define	T_BACKTRACE	266
#define	T_PRINT	267
#define	T_END	268
#define	T_QUIT	269
#define	T_ON	270
#define	T_OFF	271
#define	T_STRING	272
#define	T_ID	273


extern YYSTYPE aalval;
