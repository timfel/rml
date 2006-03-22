/* interface Absyn */
extern void Absyn_5finit(void);
extern struct rml_gval Absyn__var_5fadd;
extern struct rml_gval Absyn__var_5fcons;
extern struct rml_gval Absyn__var_5feq;
extern struct rml_gval Absyn__var_5fidiv;
extern struct rml_gval Absyn__var_5fimod;
extern struct rml_gval Absyn__var_5fle;
extern struct rml_gval Absyn__var_5flt;
extern struct rml_gval Absyn__var_5fmul;
extern struct rml_gval Absyn__var_5fnil;
extern struct rml_gval Absyn__var_5frdiv;
extern struct rml_gval Absyn__var_5fset;
extern struct rml_gval Absyn__var_5fsub;
#define Absyn__VAL_3dBOX2 0
#define Absyn__VAL(X1,X2) (mk_box2(0,(X1),(X2)))
#define Absyn__LAMBDA_3dBOX2 0
#define Absyn__LAMBDA(X1,X2) (mk_box2(0,(X1),(X2)))
#define Absyn__LETREC_3dBOX3 10
#define Absyn__LETREC(X1,X2,X3) (mk_box3(10,(X1),(X2),(X3)))
#define Absyn__LET_3dBOX3 9
#define Absyn__LET(X1,X2,X3) (mk_box3(9,(X1),(X2),(X3)))
#define Absyn__IF_3dBOX3 8
#define Absyn__IF(X1,X2,X3) (mk_box3(8,(X1),(X2),(X3)))
#define Absyn__PAIR_3dBOX2 7
#define Absyn__PAIR(X1,X2) (mk_box2(7,(X1),(X2)))
#define Absyn__APP_3dBOX2 6
#define Absyn__APP(X1,X2) (mk_box2(6,(X1),(X2)))
#define Absyn__LAM_3dBOX1 5
#define Absyn__LAM(X1) (mk_box1(5,(X1)))
#define Absyn__VAR_3dBOX1 4
#define Absyn__VAR(X1) (mk_box1(4,(X1)))
#define Absyn__UNIT_3dBOX0 3
#define Absyn__UNIT (mk_box0(3))
#define Absyn__STRING_3dBOX1 2
#define Absyn__STRING(X1) (mk_box1(2,(X1)))
#define Absyn__REAL_3dBOX1 1
#define Absyn__REAL(X1) (mk_box1(1,(X1)))
#define Absyn__INT_3dBOX1 0
#define Absyn__INT(X1) (mk_box1(0,(X1)))
