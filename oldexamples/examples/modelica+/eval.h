/* interface Eval */
extern void Eval_5finit(void);
extern RML_FORWARD_LABEL(Eval__eval);
#define Eval__NEG_3dBOX1 5
#define Eval__NEG(X1) (mk_box1(5,(X1)))
#define Eval__DIV_3dBOX2 4
#define Eval__DIV(X1,X2) (mk_box2(4,(X1),(X2)))
#define Eval__MUL_3dBOX2 3
#define Eval__MUL(X1,X2) (mk_box2(3,(X1),(X2)))
#define Eval__SUB_3dBOX2 2
#define Eval__SUB(X1,X2) (mk_box2(2,(X1),(X2)))
#define Eval__PLUS_3dBOX2 1
#define Eval__PLUS(X1,X2) (mk_box2(1,(X1),(X2)))
#define Eval__RCONST_3dBOX1 0
#define Eval__RCONST(X1) (mk_box1(0,(X1)))
