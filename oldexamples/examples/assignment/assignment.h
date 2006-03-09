/* interface assignment */
extern void assignment_5finit(void);
extern RML_FORWARD_LABEL(assignment__evalprogram);
#define assignment__PROGRAM_3dBOX2 0
#define assignment__PROGRAM(X1,X2) (mk_box2(0,(X1),(X2)))
#define assignment__IDENT_3dBOX1 4
#define assignment__IDENT(X1) (mk_box1(4,(X1)))
#define assignment__ASSIGN_3dBOX2 3
#define assignment__ASSIGN(X1,X2) (mk_box2(3,(X1),(X2)))
#define assignment__UNARY_3dBOX2 2
#define assignment__UNARY(X1,X2) (mk_box2(2,(X1),(X2)))
#define assignment__BINARY_3dBOX3 1
#define assignment__BINARY(X1,X2,X3) (mk_box3(1,(X1),(X2),(X3)))
#define assignment__INT_3dBOX1 0
#define assignment__INT(X1) (mk_box1(0,(X1)))
#define assignment__DIV_3dINT 3
#define assignment__DIV (mk_icon(3))
#define assignment__MUL_3dINT 2
#define assignment__MUL (mk_icon(2))
#define assignment__SUB_3dINT 1
#define assignment__SUB (mk_icon(1))
#define assignment__ADD_3dINT 0
#define assignment__ADD (mk_icon(0))
#define assignment__NEG_3dINT 0
#define assignment__NEG (mk_icon(0))
