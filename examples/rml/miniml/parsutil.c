/* parsutil.c */
#include <stdio.h>
#include "rml.h"
#include "yacclib.h"
#include "absyn.h"
#include "parsutil.h"

void *pu_dec_val(void *varid, void *exp)		/* Absyn.VAL=BOX2 */
{
    return mk_box2(Absyn__VAL_3dBOX2, varid, exp);
}

void *pu_lambda(void *argid, void *exp)			/* Absyn.LAMBDA=BOX2 */
{
    return mk_box2(Absyn__LAMBDA_3dBOX2, argid, exp);
}

void *pu_exp_nil(void)
{
    return RML_GVAL_VALUE(Absyn__var_5fnil);
}

void *pu_exp_unit(void)					/* Absyn.UNIT=BOX0 */
{
    static struct rml_header unit = { RML_STRUCTHDR(0, Absyn__UNIT_3dBOX0) };
    return RML_TAGPTR(&unit);
}

void *pu_exp_icon(void *icon)				/* Absyn.INT=BOX1 */
{
    return mk_box1(Absyn__INT_3dBOX1, icon);
}

void *pu_exp_rcon(void *rcon)				/* Absyn.REAL=BOX1 */
{
    return mk_box1(Absyn__REAL_3dBOX1, rcon);
}

void *pu_exp_scon(void *scon)				/* Absyn.STRING=BOX1 */
{
    return mk_box1(Absyn__STRING_3dBOX1, scon);
}

void *pu_exp_var(void *varid)				/* Absyn.VAR=BOX1 */
{
    return mk_box1(Absyn__VAR_3dBOX1, varid);
}

void *pu_exp_lam(void *lambda)				/* Absyn.LAM=BOX1 */
{
    return mk_box1(Absyn__LAM_3dBOX1, lambda);
}

void *pu_exp_if(void *e0, void *e1, void *e2)		/* Absyn.IF=BOX3 */
{
    return mk_box3(Absyn__IF_3dBOX3, e0, e1, e2);
}

void *pu_bop_var(enum bop bop)
{
    switch( bop ) {
      default:
	fprintf(stderr, "Parsutil: pu_bop_var(%d)\n", bop);
	exit(1);
      case BOP_ADD:	return RML_GVAL_VALUE(Absyn__var_5fadd);
      case BOP_CONS:	return RML_GVAL_VALUE(Absyn__var_5fcons);
      case BOP_EQ:	return RML_GVAL_VALUE(Absyn__var_5feq);
      case BOP_IDIV:	return RML_GVAL_VALUE(Absyn__var_5fidiv);
      case BOP_IMOD:	return RML_GVAL_VALUE(Absyn__var_5fimod);
      case BOP_LE:	return RML_GVAL_VALUE(Absyn__var_5fle);
      case BOP_LT:	return RML_GVAL_VALUE(Absyn__var_5flt);
      case BOP_MUL:	return RML_GVAL_VALUE(Absyn__var_5fmul);
      case BOP_RDIV:	return RML_GVAL_VALUE(Absyn__var_5frdiv);
      case BOP_SET:	return RML_GVAL_VALUE(Absyn__var_5fset);
      case BOP_SUB:	return RML_GVAL_VALUE(Absyn__var_5fsub);
    }
}

void *pu_exp_app(void *f, void *x)			/* Absyn.APP=BOX2 */
{
    return mk_box2(Absyn__APP_3dBOX2, f, x);
}

void *pu_exp_pair(void *e0, void *e1)			/* Absyn.PAIR=BOX2 */
{
    return mk_box2(Absyn__PAIR_3dBOX2, e0, e1);
}

void *pu_exp_let(void *id, void *rhs, void *body)	/* Absyn.LET=BOX3 */
{
    return mk_box3(Absyn__LET_3dBOX3, id, rhs, body);
}

void *pu_exp_letrec(void *id, void *lam, void *body)	/* Absyn.LETREC=BOX3 */
{
    return mk_box3(Absyn__LETREC_3dBOX3, id, lam, body);
}
