/* interface Main */
extern void Main_5finit(void);
extern RML_FORWARD_LABEL(Main__main);
extern RML_FORWARD_LABEL(Main__print_5farray);
#define Main__Vec_3dBOX2 1
#define Main__Vec(X1,X2) (mk_box2(1,(X1),(X2)))
#define Main__V_3dBOX1 0
#define Main__V(X1) (mk_box1(0,(X1)))
#define Main__C3_3dBOX2 2
#define Main__C3(X1,X2) (mk_box2(2,(X1),(X2)))
#define Main__C2_3dBOX1 1
#define Main__C2(X1) (mk_box1(1,(X1)))
#define Main__C1_3dBOX2 0
#define Main__C1(X1,X2) (mk_box2(0,(X1),(X2)))
#define Main__C_3dBOX2 0
#define Main__C(X1,X2) (mk_box2(0,(X1),(X2)))
#define Main__HANDLERS_3dTRANSPARENT
#define Main__HANDLERS(X) (X)
