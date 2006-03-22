/* parsutil.h */
enum bop {
    BOP_ADD,
    BOP_CONS,
    BOP_EQ,
    BOP_IDIV,
    BOP_IMOD,
    BOP_LE,
    BOP_LT,
    BOP_MUL,
    BOP_RDIV,
    BOP_SET,
    BOP_SUB
};

extern void *pu_dec_val(void *varid, void *exp);
extern void *pu_lambda(void *argid, void *body);
extern void *pu_exp_nil(void);
extern void *pu_exp_unit(void);
extern void *pu_exp_icon(void *icon);
extern void *pu_exp_rcon(void *rcon);
extern void *pu_exp_scon(void *scon);
extern void *pu_exp_var(void *varid);
extern void *pu_exp_lam(void *lambda);
extern void *pu_exp_if(void *e0, void *e1, void *e2);
extern void *pu_bop_var(enum bop bop);
extern void *pu_exp_app(void *f, void *x);
extern void *pu_exp_pair(void *e0, void *e1);
extern void *pu_exp_let(void *id, void *rhs, void *body);
extern void *pu_exp_letrec(void *id, void *lam, void *body);
