/* interface Main */
extern void Main_5finit(void);
extern struct rml_gval Main__tree;
extern RML_FORWARD_LABEL(Main__eval);
extern RML_FORWARD_LABEL(Main__main);
#define Main__NEG_3dBOX1 5
#define Main__NEG(X1) (mk_box1(5,(X1)))
#define Main__DIV_3dBOX2 4
#define Main__DIV(X1,X2) (mk_box2(4,(X1),(X2)))
#define Main__MUL_3dBOX2 3
#define Main__MUL(X1,X2) (mk_box2(3,(X1),(X2)))
#define Main__SUB_3dBOX2 2
#define Main__SUB(X1,X2) (mk_box2(2,(X1),(X2)))
#define Main__PLUS_3dBOX2 1
#define Main__PLUS(X1,X2) (mk_box2(1,(X1),(X2)))
#define Main__RCONST_3dBOX1 0
#define Main__RCONST(X1) (mk_box1(0,(X1)))
