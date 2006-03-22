/* interface Types */
extern void Types_5finit(void);
extern RML_FORWARD_LABEL(Types__alpha_5fovld);
extern RML_FORWARD_LABEL(Types__deref);
extern RML_FORWARD_LABEL(Types__mkEqAlpha);
extern RML_FORWARD_LABEL(Types__mkAlpha);
extern RML_FORWARD_LABEL(Types__mkFreeAlpha);
extern RML_FORWARD_LABEL(Types__mkOvldAlpha);
#define Types__CONS_3dBOX2 1
#define Types__CONS(X1,X2) (mk_box2(1,(X1),(X2)))
#define Types__VAR_3dBOX1 0
#define Types__VAR(X1) (mk_box1(0,(X1)))
#define Types__ALPHA_3dBOX5 0
#define Types__ALPHA(X1,X2,X3,X4,X5) (mk_box5(0,(X1),(X2),(X3),(X4),(X5)))
