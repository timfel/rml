/* interface exp2 */
extern void exp2_5finit(void);
extern RML_FORWARD_LABEL(exp2__eval);
#define exp2__UNARY_3dBOX2 2
#define exp2__UNARY(X1,X2) (mk_box2(2,(X1),(X2)))
#define exp2__BINARY_3dBOX3 1
#define exp2__BINARY(X1,X2,X3) (mk_box3(1,(X1),(X2),(X3)))
#define exp2__INT_3dBOX1 0
#define exp2__INT(X1) (mk_box1(0,(X1)))
#define exp2__DIV_3dINT 3
#define exp2__DIV (mk_icon(3))
#define exp2__MUL_3dINT 2
#define exp2__MUL (mk_icon(2))
#define exp2__SUB_3dINT 1
#define exp2__SUB (mk_icon(1))
#define exp2__ADD_3dINT 0
#define exp2__ADD (mk_icon(0))
#define exp2__NEG_3dINT 0
#define exp2__NEG (mk_icon(0))
