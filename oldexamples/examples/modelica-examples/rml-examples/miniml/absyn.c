/* module Absyn */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Absyn")

static const RML_DEFSTRINGLIT(lit0,1,"+");
static const RML_DEFSTRUCTLIT(lit1,1,4) {RML_REFSTRINGLIT(lit0)}};
static const RML_DEFSTRINGLIT(lit2,2,"::");
static const RML_DEFSTRUCTLIT(lit3,1,4) {RML_REFSTRINGLIT(lit2)}};
static const RML_DEFSTRINGLIT(lit4,1,"=");
static const RML_DEFSTRUCTLIT(lit5,1,4) {RML_REFSTRINGLIT(lit4)}};
static const RML_DEFSTRINGLIT(lit6,4,"idiv");
static const RML_DEFSTRUCTLIT(lit7,1,4) {RML_REFSTRINGLIT(lit6)}};
static const RML_DEFSTRINGLIT(lit8,4,"imod");
static const RML_DEFSTRUCTLIT(lit9,1,4) {RML_REFSTRINGLIT(lit8)}};
static const RML_DEFSTRINGLIT(lit10,2,"<=");
static const RML_DEFSTRUCTLIT(lit11,1,4) {RML_REFSTRINGLIT(lit10)}};
static const RML_DEFSTRINGLIT(lit12,1,"<");
static const RML_DEFSTRUCTLIT(lit13,1,4) {RML_REFSTRINGLIT(lit12)}};
static const RML_DEFSTRINGLIT(lit14,1,"*");
static const RML_DEFSTRUCTLIT(lit15,1,4) {RML_REFSTRINGLIT(lit14)}};
static const RML_DEFSTRINGLIT(lit16,3,"nil");
static const RML_DEFSTRUCTLIT(lit17,1,4) {RML_REFSTRINGLIT(lit16)}};
static const RML_DEFSTRINGLIT(lit18,4,"rdiv");
static const RML_DEFSTRUCTLIT(lit19,1,4) {RML_REFSTRINGLIT(lit18)}};
static const RML_DEFSTRINGLIT(lit20,2,":=");
static const RML_DEFSTRUCTLIT(lit21,1,4) {RML_REFSTRINGLIT(lit20)}};
static const RML_DEFSTRINGLIT(lit22,1,"-");
static const RML_DEFSTRUCTLIT(lit23,1,4) {RML_REFSTRINGLIT(lit22)}};

const struct rml_gval Absyn__var_5fadd = {{RML_REFSTRUCTLIT(lit1)},0,"Absyn__var_5fadd"};
const struct rml_gval Absyn__var_5fcons = {{RML_REFSTRUCTLIT(lit3)},0,"Absyn__var_5fcons"};
const struct rml_gval Absyn__var_5feq = {{RML_REFSTRUCTLIT(lit5)},0,"Absyn__var_5feq"};
const struct rml_gval Absyn__var_5fidiv = {{RML_REFSTRUCTLIT(lit7)},0,"Absyn__var_5fidiv"};
const struct rml_gval Absyn__var_5fimod = {{RML_REFSTRUCTLIT(lit9)},0,"Absyn__var_5fimod"};
const struct rml_gval Absyn__var_5fle = {{RML_REFSTRUCTLIT(lit11)},0,"Absyn__var_5fle"};
const struct rml_gval Absyn__var_5flt = {{RML_REFSTRUCTLIT(lit13)},0,"Absyn__var_5flt"};
const struct rml_gval Absyn__var_5fmul = {{RML_REFSTRUCTLIT(lit15)},0,"Absyn__var_5fmul"};
const struct rml_gval Absyn__var_5fnil = {{RML_REFSTRUCTLIT(lit17)},0,"Absyn__var_5fnil"};
const struct rml_gval Absyn__var_5frdiv = {{RML_REFSTRUCTLIT(lit19)},0,"Absyn__var_5frdiv"};
const struct rml_gval Absyn__var_5fset = {{RML_REFSTRUCTLIT(lit21)},0,"Absyn__var_5fset"};
const struct rml_gval Absyn__var_5fsub = {{RML_REFSTRUCTLIT(lit23)},0,"Absyn__var_5fsub"};

extern void RML_5finit(void);

void Absyn_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
	rmldb_load_db("absyn.rdb");
}
