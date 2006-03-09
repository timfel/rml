/* interface Exp1 */
extern void Exp1_5finit(void);
#define Exp1__SPECop_3dBOX2 2
#define Exp1__SPECop(X1,X2) (mk_box2(2,(X1),(X2)))
#define Exp1__ICONST_3dBOX1 1
#define Exp1__ICONST(X1) (mk_box1(1,(X1)))
#define Exp1__RCONST_3dBOX1 0
#define Exp1__RCONST(X1) (mk_box1(0,(X1)))
