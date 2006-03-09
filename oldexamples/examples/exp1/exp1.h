/* interface exp1 */
extern void exp1_5finit(void);
extern RML_FORWARD_LABEL(exp1__eval);
#define exp1__NEGop_3dBOX1 5
#define exp1__NEGop(X1) (mk_box1(5,(X1)))
#define exp1__DIVop_3dBOX2 4
#define exp1__DIVop(X1,X2) (mk_box2(4,(X1),(X2)))
#define exp1__MULop_3dBOX2 3
#define exp1__MULop(X1,X2) (mk_box2(3,(X1),(X2)))
#define exp1__SUBop_3dBOX2 2
#define exp1__SUBop(X1,X2) (mk_box2(2,(X1),(X2)))
#define exp1__ADDop_3dBOX2 1
#define exp1__ADDop(X1,X2) (mk_box2(1,(X1),(X2)))
#define exp1__INTconst_3dBOX1 0
#define exp1__INTconst(X1) (mk_box1(0,(X1)))
