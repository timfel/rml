/* interface Scheme */
extern void Scheme_5finit(void);
extern RML_FORWARD_LABEL(Scheme__gen_5fnone);
extern RML_FORWARD_LABEL(Scheme__gen_5flimit);
extern RML_FORWARD_LABEL(Scheme__inst);
#define Scheme__SCHEME_3dBOX2 0
#define Scheme__SCHEME(X1,X2) (mk_box2(0,(X1),(X2)))
#define Scheme__MKCONS_3dBOX2 2
#define Scheme__MKCONS(X1,X2) (mk_box2(2,(X1),(X2)))
#define Scheme__BOUND_3dBOX1 1
#define Scheme__BOUND(X1) (mk_box1(1,(X1)))
#define Scheme__QUOTE_3dBOX1 0
#define Scheme__QUOTE(X1) (mk_box1(0,(X1)))
