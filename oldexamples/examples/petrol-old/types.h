/* interface Types */
extern void Types_5finit(void);
extern RML_FORWARD_LABEL(Types__asg_5fcnv);
extern RML_FORWARD_LABEL(Types__bin_5fcnv);
extern RML_FORWARD_LABEL(Types__cast_5fcnv);
extern RML_FORWARD_LABEL(Types__cond_5fcnv);
extern RML_FORWARD_LABEL(Types__decay);
extern RML_FORWARD_LABEL(Types__eq_5fcnv);
extern RML_FORWARD_LABEL(Types__rel_5fcnv);
extern RML_FORWARD_LABEL(Types__rec_5fcnv);
extern RML_FORWARD_LABEL(Types__ty_5fcnv);
extern RML_FORWARD_LABEL(Types__unfold_5frec);
#define Types__UNFOLD_3dBOX1 5
#define Types__UNFOLD(X1) (mk_box1(5,(X1)))
#define Types__REC_3dBOX1 4
#define Types__REC(X1) (mk_box1(4,(X1)))
#define Types__ARR_3dBOX2 3
#define Types__ARR(X1,X2) (mk_box2(3,(X1),(X2)))
#define Types__PTRNIL_3dBOX0 2
#define Types__PTRNIL (mk_box0(2))
#define Types__PTR_3dBOX1 1
#define Types__PTR(X1) (mk_box1(1,(X1)))
#define Types__ARITH_3dBOX1 0
#define Types__ARITH(X1) (mk_box1(0,(X1)))
#define Types__RECORD_3dBOX2 0
#define Types__RECORD(X1,X2) (mk_box2(0,(X1),(X2)))
#define Types__REAL_3dINT 2
#define Types__REAL (mk_icon(2))
#define Types__INT_3dINT 1
#define Types__INT (mk_icon(1))
#define Types__CHAR_3dINT 0
#define Types__CHAR (mk_icon(0))
