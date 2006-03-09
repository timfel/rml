/* interface Env */
extern void Env_5finit(void);
extern RML_FORWARD_LABEL(Env__initial);
extern RML_FORWARD_LABEL(Env__lookup);
extern RML_FORWARD_LABEL(Env__lookuptype);
extern RML_FORWARD_LABEL(Env__update);
#define Env__REALVAL2_3dBOX2 1
#define Env__REALVAL2(X1,X2) (mk_box2(1,(X1),(X2)))
#define Env__INTVAL2_3dBOX2 0
#define Env__INTVAL2(X1,X2) (mk_box2(0,(X1),(X2)))
#define Env__BIND_3dBOX3 0
#define Env__BIND(X1,X2,X3) (mk_box3(0,(X1),(X2),(X3)))
#define Env__BOOLTYPE_3dINT 2
#define Env__BOOLTYPE (mk_icon(2))
#define Env__REALTYPE_3dINT 1
#define Env__REALTYPE (mk_icon(1))
#define Env__INTTYPE_3dINT 0
#define Env__INTTYPE (mk_icon(0))
#define Env__BOOLVAL_3dBOX1 2
#define Env__BOOLVAL(X1) (mk_box1(2,(X1)))
#define Env__REALVAL_3dBOX1 1
#define Env__REALVAL(X1) (mk_box1(1,(X1)))
#define Env__INTVAL_3dBOX1 0
#define Env__INTVAL(X1) (mk_box1(0,(X1)))
