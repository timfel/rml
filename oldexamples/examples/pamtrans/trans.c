/* module Trans */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Trans")
extern RML_FORWARD_LABEL(RML__tick);
extern RML_FORWARD_LABEL(RML__list_5fappend);

RML_FORWARD_LABEL(Trans__trans_5fprogram);
static RML_FORWARD_LABEL(Trans_2dsclam725);
static RML_FORWARD_LABEL(Trans__trans_5fstmt);
static RML_FORWARD_LABEL(Trans_2dsclam1010);
static RML_FORWARD_LABEL(Trans_2dsclam993);
static RML_FORWARD_LABEL(Trans_2dsclam992);
static RML_FORWARD_LABEL(Trans_2dsclam991);
static RML_FORWARD_LABEL(Trans_2dfclam967);
static RML_FORWARD_LABEL(Trans_2dsclam961);
static RML_FORWARD_LABEL(Trans_2dsclam960);
static RML_FORWARD_LABEL(Trans_2dsclam959);
static RML_FORWARD_LABEL(Trans_2dsclam958);
static RML_FORWARD_LABEL(Trans_2dsclam923);
static RML_FORWARD_LABEL(Trans_2dsclam909);
static RML_FORWARD_LABEL(Trans_2dsclam895);
static RML_FORWARD_LABEL(Trans_2dsclam894);
static RML_FORWARD_LABEL(Trans_2dsclam875);
static RML_FORWARD_LABEL(Trans_2dsclam874);
static RML_FORWARD_LABEL(Trans_2dsclam873);
static RML_FORWARD_LABEL(Trans_2dsclam872);
static RML_FORWARD_LABEL(Trans_2dsclam871);
static RML_FORWARD_LABEL(Trans_2dsclam457);
static RML_FORWARD_LABEL(Trans_2dlab819);
static RML_FORWARD_LABEL(Trans_2dsclam818);
static RML_FORWARD_LABEL(Trans_2dsclam817);
static RML_FORWARD_LABEL(Trans_2dsclam816);
static RML_FORWARD_LABEL(Trans_2dsclam815);
static RML_FORWARD_LABEL(Trans_2dsclam814);
static RML_FORWARD_LABEL(Trans__genlabel);
static RML_FORWARD_LABEL(Trans_2dsclam409);
static RML_FORWARD_LABEL(Trans__gentemp);
static RML_FORWARD_LABEL(Trans_2dsclam416);
static RML_FORWARD_LABEL(Trans__list_5fappend3);
static RML_FORWARD_LABEL(Trans_2dsclam433);
static RML_FORWARD_LABEL(Trans__list_5fappend5);
static RML_FORWARD_LABEL(Trans_2dsclam476);
static RML_FORWARD_LABEL(Trans__list_5fappend6);
static RML_FORWARD_LABEL(Trans_2dsclam502);
static RML_FORWARD_LABEL(Trans_2dsclam501);
static RML_FORWARD_LABEL(Trans__trans_5fexpr);
static RML_FORWARD_LABEL(Trans_2dsclam604);
static RML_FORWARD_LABEL(Trans_2dsclam603);
static RML_FORWARD_LABEL(Trans_2dsclam602);
static RML_FORWARD_LABEL(Trans_2dfclam588);
static RML_FORWARD_LABEL(Trans_2dlab580);
static RML_FORWARD_LABEL(Trans_2dsclam579);
static RML_FORWARD_LABEL(Trans_2dsclam578);
static RML_FORWARD_LABEL(Trans_2dsclam577);
static RML_FORWARD_LABEL(Trans__trans_5fcomparison);
static RML_FORWARD_LABEL(Trans_2dsclam701);
static RML_FORWARD_LABEL(Trans_2dsclam700);
static RML_FORWARD_LABEL(Trans_2dsclam699);
static RML_FORWARD_LABEL(Trans_2dfclam683);
static RML_FORWARD_LABEL(Trans_2dlab675);
static RML_FORWARD_LABEL(Trans_2dsclam674);
static RML_FORWARD_LABEL(Trans_2dsclam673);
static RML_FORWARD_LABEL(Trans__trans_5frelop);
static RML_FORWARD_LABEL(Trans__trans_5fbinop);

static const RML_DEFSTRUCT0LIT(lit0,0);
static const RML_DEFSTRUCTLIT(lit1,1,1) {RML_IMMEDIATE(RML_TAGFIXNUM(1))}};
static const RML_DEFSTRUCTLIT(lit2,2,0) {RML_IMMEDIATE(RML_TAGFIXNUM(1)),RML_REFSTRUCTLIT(lit1)}};
static const RML_DEFSTRUCTLIT(lit3,2,1) {RML_REFSTRUCTLIT(lit2),RML_REFSTRUCTLIT(lit0)}};
static const RML_DEFSTRUCT0LIT(lit4,8);
static const RML_DEFSTRUCTLIT(lit5,2,1) {RML_REFSTRUCTLIT(lit4),RML_REFSTRUCTLIT(lit0)}};

extern void RML_5finit(void);
extern void Absyn_5finit(void);
extern void Mcode_5finit(void);

void Trans_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
	Absyn_5finit();
	Mcode_5finit();
}

RML_BEGIN_LABEL(Trans__trans_5fprogram)
{

	{ void *tmp401 = rmlSC;
	{ void *tmp400 = rmlFC;
	{ void *tmp1167 = rmlSP;
	RML_STORE(RML_OFFSET(tmp1167, -1), tmp400);
	RML_STORE(RML_OFFSET(tmp1167, -2), tmp401);
	RML_STORE(RML_OFFSET(tmp1167, -3), RML_LABVAL(Trans_2dsclam725));
	rmlSC = RML_OFFSET(tmp1167, -3);
	rmlSP = RML_OFFSET(tmp1167, -3);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam725)
{

	{ void *tmp1170 = rmlSC;
	{ void *tmp401 = RML_FETCH(RML_OFFSET(tmp1170, 1));
	{ void *tmp400 = RML_FETCH(RML_OFFSET(tmp1170, 2));
	{ void *tmp1169 = RML_OFFSET(tmp1170, 3);
	rmlA1 = RML_REFSTRUCTLIT(lit5);
	rmlFC = tmp400;
	rmlSC = tmp401;
	rmlSP = tmp1169;
	RML_TAILCALLQ(RML__list_5fappend,2);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__trans_5fstmt)
{
	void *tmp1090;
	RML_ALLOC(tmp1090,2,1,Trans__trans_5fstmt);
	{ void *tmp398 = rmlSC;
	{ void *tmp397 = rmlFC;
	{ void *tmp1091 = rmlSP;
	{ void *tmp399 = rmlA0;
	{ void *tmp820 = RML_FETCH(RML_UNTAGPTR(tmp399));
	switch( RML_HDRCTOR((rml_uint_t)tmp820) ) {
	case 7:
	rmlA0 = RML_REFSTRUCTLIT(lit0);
	RML_TAILCALL(RML_FETCH(tmp398),1);
	case 3:
	{ void *tmp821 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 2));
	{ void *tmp822 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 1));
	RML_STORE(RML_OFFSET(tmp1091, -1), tmp821);
	RML_STORE(RML_OFFSET(tmp1091, -2), tmp397);
	RML_STORE(RML_OFFSET(tmp1091, -3), tmp398);
	RML_STORE(RML_OFFSET(tmp1091, -4), RML_LABVAL(Trans_2dsclam875));
	rmlA0 = tmp822;
	rmlSC = RML_OFFSET(tmp1091, -4);
	rmlSP = RML_OFFSET(tmp1091, -4);
	RML_TAILCALLQ(Trans__trans_5fexpr,1);}}
	case 6:
	{ void *tmp876 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 2));
	{ void *tmp877 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 1));
	RML_STORE(RML_OFFSET(tmp1091, -1), tmp876);
	RML_STORE(RML_OFFSET(tmp1091, -2), tmp397);
	RML_STORE(RML_OFFSET(tmp1091, -3), tmp398);
	RML_STORE(RML_OFFSET(tmp1091, -4), RML_LABVAL(Trans_2dsclam895));
	rmlA0 = tmp877;
	rmlSC = RML_OFFSET(tmp1091, -4);
	rmlSP = RML_OFFSET(tmp1091, -4);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}
	case 5:
	{ void *tmp896 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 1));
	{ void *tmp897 = RML_FETCH(RML_UNTAGPTR(tmp896));
	switch( (rml_sint_t)tmp897 ) {
	case RML_STRUCTHDR(0,0):
	rmlA0 = RML_REFSTRUCTLIT(lit0);
	RML_TAILCALL(RML_FETCH(tmp398),1);
	/*case RML_STRUCTHDR(2,1)*/
	default:
	{ void *tmp898 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp896), 2));
	{ void *tmp899 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp896), 1));
	RML_STORE(tmp1090, RML_IMMEDIATE(RML_STRUCTHDR(1,5)));
	RML_STORE(RML_OFFSET(tmp1090, 1), tmp898);
	{ void *tmp900 = RML_TAGPTR(tmp1090);
	RML_STORE(RML_OFFSET(tmp1091, -1), tmp899);
	RML_STORE(RML_OFFSET(tmp1091, -2), tmp398);
	RML_STORE(RML_OFFSET(tmp1091, -3), RML_LABVAL(Trans_2dsclam909));
	rmlA0 = tmp900;
	rmlSC = RML_OFFSET(tmp1091, -3);
	rmlSP = RML_OFFSET(tmp1091, -3);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}}
	}}}
	case 4:
	{ void *tmp910 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 1));
	{ void *tmp911 = RML_FETCH(RML_UNTAGPTR(tmp910));
	switch( (rml_sint_t)tmp911 ) {
	case RML_STRUCTHDR(0,0):
	rmlA0 = RML_REFSTRUCTLIT(lit0);
	RML_TAILCALL(RML_FETCH(tmp398),1);
	/*case RML_STRUCTHDR(2,1)*/
	default:
	{ void *tmp912 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp910), 2));
	{ void *tmp913 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp910), 1));
	RML_STORE(tmp1090, RML_IMMEDIATE(RML_STRUCTHDR(1,4)));
	RML_STORE(RML_OFFSET(tmp1090, 1), tmp912);
	{ void *tmp914 = RML_TAGPTR(tmp1090);
	RML_STORE(RML_OFFSET(tmp1091, -1), tmp913);
	RML_STORE(RML_OFFSET(tmp1091, -2), tmp398);
	RML_STORE(RML_OFFSET(tmp1091, -3), RML_LABVAL(Trans_2dsclam923));
	rmlA0 = tmp914;
	rmlSC = RML_OFFSET(tmp1091, -3);
	rmlSP = RML_OFFSET(tmp1091, -3);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}}
	}}}
	case 2:
	{ void *tmp924 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 2));
	{ void *tmp925 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 1));
	RML_STORE(RML_OFFSET(tmp1091, -1), tmp397);
	RML_STORE(RML_OFFSET(tmp1091, -2), tmp925);
	RML_STORE(RML_OFFSET(tmp1091, -3), tmp398);
	RML_STORE(RML_OFFSET(tmp1091, -4), RML_LABVAL(Trans_2dsclam961));
	rmlA0 = tmp924;
	rmlSC = RML_OFFSET(tmp1091, -4);
	rmlSP = RML_OFFSET(tmp1091, -4);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}
	case 1:
	{ void *tmp962 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 3));
	{ void *tmp963 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 2));
	{ void *tmp964 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 1));
	{ void *tmp965 = RML_FETCH(RML_UNTAGPTR(tmp962));
	switch( (rml_sint_t)tmp965 ) {
	case RML_STRUCTHDR(0,7):
	RML_STORE(RML_OFFSET(tmp1091, -1), tmp397);
	RML_STORE(RML_OFFSET(tmp1091, -2), tmp962);
	RML_STORE(RML_OFFSET(tmp1091, -3), tmp963);
	RML_STORE(RML_OFFSET(tmp1091, -4), tmp964);
	RML_STORE(RML_OFFSET(tmp1091, -5), tmp398);
	RML_STORE(RML_OFFSET(tmp1091, -6), RML_LABVAL(Trans_2dfclam967));
	{ void *tmp966 = RML_OFFSET(tmp1091, -6);
	RML_STORE(RML_OFFSET(tmp1091, -7), tmp966);
	RML_STORE(RML_OFFSET(tmp1091, -8), tmp964);
	RML_STORE(RML_OFFSET(tmp1091, -9), tmp398);
	RML_STORE(RML_OFFSET(tmp1091, -10), RML_LABVAL(Trans_2dsclam993));
	rmlA0 = tmp963;
	rmlFC = tmp966;
	rmlSC = RML_OFFSET(tmp1091, -10);
	rmlSP = RML_OFFSET(tmp1091, -10);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}
	default:
	rmlA4 = tmp964;
	rmlA3 = tmp963;
	rmlA2 = tmp962;
	rmlA1 = tmp397;
	rmlA0 = tmp398;
	RML_TAILCALLQ(Trans_2dlab819,5);
	}}}}}
	/*case 0*/
	default:
	{ void *tmp994 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 2));
	{ void *tmp995 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp399), 1));
	RML_STORE(RML_OFFSET(tmp1091, -1), tmp995);
	RML_STORE(RML_OFFSET(tmp1091, -2), tmp397);
	RML_STORE(RML_OFFSET(tmp1091, -3), tmp398);
	RML_STORE(RML_OFFSET(tmp1091, -4), RML_LABVAL(Trans_2dsclam1010));
	rmlA0 = tmp994;
	rmlSC = RML_OFFSET(tmp1091, -4);
	rmlSP = RML_OFFSET(tmp1091, -4);
	RML_TAILCALLQ(Trans__trans_5fexpr,1);}}
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam1010)
{
	void *tmp1163;
	RML_ALLOC(tmp1163,7,1,Trans_2dsclam1010);
	{ void *tmp1165 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1165, 1));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1165, 2));
	{ void *tmp995 = RML_FETCH(RML_OFFSET(tmp1165, 3));
	{ void *tmp1164 = RML_OFFSET(tmp1165, 4);
	RML_STORE(tmp1163, RML_IMMEDIATE(RML_STRUCTHDR(1,0)));
	RML_STORE(RML_OFFSET(tmp1163, 1), tmp995);
	{ void *tmp1001 = RML_TAGPTR(tmp1163);
	RML_STORE(RML_OFFSET(tmp1163, 2), RML_IMMEDIATE(RML_STRUCTHDR(1,4)));
	RML_STORE(RML_OFFSET(tmp1163, 3), tmp1001);
	{ void *tmp1002 = RML_TAGPTR(RML_OFFSET(tmp1163, 2));
	RML_STORE(RML_OFFSET(tmp1163, 4), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1163, 5), tmp1002);
	RML_STORE(RML_OFFSET(tmp1163, 6), RML_REFSTRUCTLIT(lit0));
	{ void *tmp1003 = RML_TAGPTR(RML_OFFSET(tmp1163, 4));
	rmlA1 = tmp1003;
	rmlFC = tmp397;
	rmlSC = tmp398;
	rmlSP = tmp1164;
	RML_TAILCALLQ(RML__list_5fappend,2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam993)
{

	{ void *tmp1156 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1156, 1));
	{ void *tmp964 = RML_FETCH(RML_OFFSET(tmp1156, 2));
	{ void *tmp966 = RML_FETCH(RML_OFFSET(tmp1156, 3));
	{ void *tmp1155 = RML_OFFSET(tmp1156, 4);
	{ void *tmp969 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1155, -1), tmp964);
	RML_STORE(RML_OFFSET(tmp1155, -2), tmp966);
	RML_STORE(RML_OFFSET(tmp1155, -3), tmp969);
	RML_STORE(RML_OFFSET(tmp1155, -4), tmp398);
	RML_STORE(RML_OFFSET(tmp1155, -5), RML_LABVAL(Trans_2dsclam992));
	rmlFC = tmp966;
	rmlSC = RML_OFFSET(tmp1155, -5);
	rmlSP = RML_OFFSET(tmp1155, -5);
	RML_TAILCALLQ(Trans__genlabel,0);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam992)
{

	{ void *tmp1159 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1159, 1));
	{ void *tmp969 = RML_FETCH(RML_OFFSET(tmp1159, 2));
	{ void *tmp966 = RML_FETCH(RML_OFFSET(tmp1159, 3));
	{ void *tmp964 = RML_FETCH(RML_OFFSET(tmp1159, 4));
	{ void *tmp1158 = RML_OFFSET(tmp1159, 5);
	{ void *tmp974 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1158, -1), tmp974);
	RML_STORE(RML_OFFSET(tmp1158, -2), tmp969);
	RML_STORE(RML_OFFSET(tmp1158, -3), tmp966);
	RML_STORE(RML_OFFSET(tmp1158, -4), tmp398);
	RML_STORE(RML_OFFSET(tmp1158, -5), RML_LABVAL(Trans_2dsclam991));
	rmlA1 = tmp974;
	rmlA0 = tmp964;
	rmlFC = tmp966;
	rmlSC = RML_OFFSET(tmp1158, -5);
	rmlSP = RML_OFFSET(tmp1158, -5);
	RML_TAILCALLQ(Trans__trans_5fcomparison,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam991)
{
	void *tmp1160;
	RML_ALLOC(tmp1160,5,1,Trans_2dsclam991);
	{ void *tmp1162 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1162, 1));
	{ void *tmp966 = RML_FETCH(RML_OFFSET(tmp1162, 2));
	{ void *tmp969 = RML_FETCH(RML_OFFSET(tmp1162, 3));
	{ void *tmp974 = RML_FETCH(RML_OFFSET(tmp1162, 4));
	{ void *tmp1161 = RML_OFFSET(tmp1162, 5);
	RML_STORE(tmp1160, RML_IMMEDIATE(RML_STRUCTHDR(1,7)));
	RML_STORE(RML_OFFSET(tmp1160, 1), tmp974);
	{ void *tmp983 = RML_TAGPTR(tmp1160);
	RML_STORE(RML_OFFSET(tmp1160, 2), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1160, 3), tmp983);
	RML_STORE(RML_OFFSET(tmp1160, 4), RML_REFSTRUCTLIT(lit0));
	{ void *tmp984 = RML_TAGPTR(RML_OFFSET(tmp1160, 2));
	rmlA2 = tmp984;
	rmlA1 = tmp969;
	rmlFC = tmp966;
	rmlSC = tmp398;
	rmlSP = tmp1161;
	RML_TAILCALLQ(Trans__list_5fappend3,3);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dfclam967)
{

	{ void *tmp1153 = rmlFC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1153, 1));
	{ void *tmp964 = RML_FETCH(RML_OFFSET(tmp1153, 2));
	{ void *tmp963 = RML_FETCH(RML_OFFSET(tmp1153, 3));
	{ void *tmp962 = RML_FETCH(RML_OFFSET(tmp1153, 4));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1153, 5));
	{ void *tmp1152 = RML_OFFSET(tmp1153, 6);
	rmlA4 = tmp964;
	rmlA3 = tmp963;
	rmlA2 = tmp962;
	rmlA1 = tmp397;
	rmlA0 = tmp398;
	rmlSP = tmp1152;
	RML_TAILCALLQ(Trans_2dlab819,5);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam961)
{

	{ void *tmp1141 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1141, 1));
	{ void *tmp925 = RML_FETCH(RML_OFFSET(tmp1141, 2));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1141, 3));
	{ void *tmp1140 = RML_OFFSET(tmp1141, 4);
	{ void *tmp927 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1140, -1), tmp397);
	RML_STORE(RML_OFFSET(tmp1140, -2), tmp925);
	RML_STORE(RML_OFFSET(tmp1140, -3), tmp927);
	RML_STORE(RML_OFFSET(tmp1140, -4), tmp398);
	RML_STORE(RML_OFFSET(tmp1140, -5), RML_LABVAL(Trans_2dsclam960));
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1140, -5);
	rmlSP = RML_OFFSET(tmp1140, -5);
	RML_TAILCALLQ(Trans__genlabel,0);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam960)
{

	{ void *tmp1144 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1144, 1));
	{ void *tmp927 = RML_FETCH(RML_OFFSET(tmp1144, 2));
	{ void *tmp925 = RML_FETCH(RML_OFFSET(tmp1144, 3));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1144, 4));
	{ void *tmp1143 = RML_OFFSET(tmp1144, 5);
	{ void *tmp932 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1143, -1), tmp925);
	RML_STORE(RML_OFFSET(tmp1143, -2), tmp397);
	RML_STORE(RML_OFFSET(tmp1143, -3), tmp932);
	RML_STORE(RML_OFFSET(tmp1143, -4), tmp927);
	RML_STORE(RML_OFFSET(tmp1143, -5), tmp398);
	RML_STORE(RML_OFFSET(tmp1143, -6), RML_LABVAL(Trans_2dsclam959));
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1143, -6);
	rmlSP = RML_OFFSET(tmp1143, -6);
	RML_TAILCALLQ(Trans__genlabel,0);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam959)
{

	{ void *tmp1147 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1147, 1));
	{ void *tmp927 = RML_FETCH(RML_OFFSET(tmp1147, 2));
	{ void *tmp932 = RML_FETCH(RML_OFFSET(tmp1147, 3));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1147, 4));
	{ void *tmp925 = RML_FETCH(RML_OFFSET(tmp1147, 5));
	{ void *tmp1146 = RML_OFFSET(tmp1147, 6);
	{ void *tmp937 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1146, -1), tmp932);
	RML_STORE(RML_OFFSET(tmp1146, -2), tmp937);
	RML_STORE(RML_OFFSET(tmp1146, -3), tmp927);
	RML_STORE(RML_OFFSET(tmp1146, -4), tmp397);
	RML_STORE(RML_OFFSET(tmp1146, -5), tmp398);
	RML_STORE(RML_OFFSET(tmp1146, -6), RML_LABVAL(Trans_2dsclam958));
	rmlA1 = tmp937;
	rmlA0 = tmp925;
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1146, -6);
	rmlSP = RML_OFFSET(tmp1146, -6);
	RML_TAILCALLQ(Trans__trans_5fcomparison,2);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam958)
{
	void *tmp1148;
	RML_ALLOC(tmp1148,15,1,Trans_2dsclam958);
	{ void *tmp1150 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1150, 1));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1150, 2));
	{ void *tmp927 = RML_FETCH(RML_OFFSET(tmp1150, 3));
	{ void *tmp937 = RML_FETCH(RML_OFFSET(tmp1150, 4));
	{ void *tmp932 = RML_FETCH(RML_OFFSET(tmp1150, 5));
	{ void *tmp1149 = RML_OFFSET(tmp1150, 6);
	{ void *tmp942 = rmlA0;
	RML_STORE(tmp1148, RML_IMMEDIATE(RML_STRUCTHDR(1,7)));
	RML_STORE(RML_OFFSET(tmp1148, 1), tmp932);
	{ void *tmp946 = RML_TAGPTR(tmp1148);
	RML_STORE(RML_OFFSET(tmp1148, 2), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1148, 3), tmp946);
	RML_STORE(RML_OFFSET(tmp1148, 4), RML_REFSTRUCTLIT(lit0));
	{ void *tmp947 = RML_TAGPTR(RML_OFFSET(tmp1148, 2));
	RML_STORE(RML_OFFSET(tmp1148, 5), RML_IMMEDIATE(RML_STRUCTHDR(1,2)));
	RML_STORE(RML_OFFSET(tmp1148, 6), tmp932);
	{ void *tmp948 = RML_TAGPTR(RML_OFFSET(tmp1148, 5));
	RML_STORE(RML_OFFSET(tmp1148, 7), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1148, 8), tmp948);
	RML_STORE(RML_OFFSET(tmp1148, 9), RML_REFSTRUCTLIT(lit0));
	{ void *tmp949 = RML_TAGPTR(RML_OFFSET(tmp1148, 7));
	RML_STORE(RML_OFFSET(tmp1148, 10), RML_IMMEDIATE(RML_STRUCTHDR(1,7)));
	RML_STORE(RML_OFFSET(tmp1148, 11), tmp937);
	{ void *tmp950 = RML_TAGPTR(RML_OFFSET(tmp1148, 10));
	RML_STORE(RML_OFFSET(tmp1148, 12), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1148, 13), tmp950);
	RML_STORE(RML_OFFSET(tmp1148, 14), RML_REFSTRUCTLIT(lit0));
	{ void *tmp951 = RML_TAGPTR(RML_OFFSET(tmp1148, 12));
	rmlA4 = tmp951;
	rmlA3 = tmp949;
	rmlA2 = tmp927;
	rmlA1 = tmp942;
	rmlA0 = tmp947;
	rmlFC = tmp397;
	rmlSC = tmp398;
	rmlSP = tmp1149;
	RML_TAILCALLQ(Trans__list_5fappend5,5);}}}}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam923)
{
	void *tmp1136;
	RML_ALLOC(tmp1136,7,1,Trans_2dsclam923);
	{ void *tmp1138 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1138, 1));
	{ void *tmp913 = RML_FETCH(RML_OFFSET(tmp1138, 2));
	{ void *tmp1137 = RML_OFFSET(tmp1138, 3);
	{ void *tmp916 = rmlA0;
	RML_STORE(tmp1136, RML_IMMEDIATE(RML_STRUCTHDR(1,0)));
	RML_STORE(RML_OFFSET(tmp1136, 1), tmp913);
	{ void *tmp920 = RML_TAGPTR(tmp1136);
	RML_STORE(RML_OFFSET(tmp1136, 2), RML_IMMEDIATE(RML_STRUCTHDR(1,5)));
	RML_STORE(RML_OFFSET(tmp1136, 3), tmp920);
	{ void *tmp921 = RML_TAGPTR(RML_OFFSET(tmp1136, 2));
	RML_STORE(RML_OFFSET(tmp1136, 4), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1136, 5), tmp921);
	RML_STORE(RML_OFFSET(tmp1136, 6), tmp916);
	{ void *tmp922 = RML_TAGPTR(RML_OFFSET(tmp1136, 4));
	rmlA0 = tmp922;
	rmlSC = tmp398;
	rmlSP = tmp1137;
	RML_TAILCALL(RML_FETCH(tmp398),1);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam909)
{
	void *tmp1133;
	RML_ALLOC(tmp1133,7,1,Trans_2dsclam909);
	{ void *tmp1135 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1135, 1));
	{ void *tmp899 = RML_FETCH(RML_OFFSET(tmp1135, 2));
	{ void *tmp1134 = RML_OFFSET(tmp1135, 3);
	{ void *tmp902 = rmlA0;
	RML_STORE(tmp1133, RML_IMMEDIATE(RML_STRUCTHDR(1,0)));
	RML_STORE(RML_OFFSET(tmp1133, 1), tmp899);
	{ void *tmp906 = RML_TAGPTR(tmp1133);
	RML_STORE(RML_OFFSET(tmp1133, 2), RML_IMMEDIATE(RML_STRUCTHDR(1,6)));
	RML_STORE(RML_OFFSET(tmp1133, 3), tmp906);
	{ void *tmp907 = RML_TAGPTR(RML_OFFSET(tmp1133, 2));
	RML_STORE(RML_OFFSET(tmp1133, 4), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1133, 5), tmp907);
	RML_STORE(RML_OFFSET(tmp1133, 6), tmp902);
	{ void *tmp908 = RML_TAGPTR(RML_OFFSET(tmp1133, 4));
	rmlA0 = tmp908;
	rmlSC = tmp398;
	rmlSP = tmp1134;
	RML_TAILCALL(RML_FETCH(tmp398),1);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam895)
{

	{ void *tmp1129 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1129, 1));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1129, 2));
	{ void *tmp876 = RML_FETCH(RML_OFFSET(tmp1129, 3));
	{ void *tmp1128 = RML_OFFSET(tmp1129, 4);
	{ void *tmp879 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1128, -1), tmp879);
	RML_STORE(RML_OFFSET(tmp1128, -2), tmp397);
	RML_STORE(RML_OFFSET(tmp1128, -3), tmp398);
	RML_STORE(RML_OFFSET(tmp1128, -4), RML_LABVAL(Trans_2dsclam894));
	rmlA0 = tmp876;
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1128, -4);
	rmlSP = RML_OFFSET(tmp1128, -4);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam894)
{

	{ void *tmp1132 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1132, 1));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1132, 2));
	{ void *tmp879 = RML_FETCH(RML_OFFSET(tmp1132, 3));
	{ void *tmp1131 = RML_OFFSET(tmp1132, 4);
	{ void *tmp884 = rmlA0;
	rmlA1 = tmp884;
	rmlA0 = tmp879;
	rmlFC = tmp397;
	rmlSC = tmp398;
	rmlSP = tmp1131;
	RML_TAILCALLQ(RML__list_5fappend,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam875)
{

	{ void *tmp1111 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1111, 1));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1111, 2));
	{ void *tmp821 = RML_FETCH(RML_OFFSET(tmp1111, 3));
	{ void *tmp1110 = RML_OFFSET(tmp1111, 4);
	{ void *tmp824 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1110, -1), tmp397);
	RML_STORE(RML_OFFSET(tmp1110, -2), tmp824);
	RML_STORE(RML_OFFSET(tmp1110, -3), tmp398);
	RML_STORE(RML_OFFSET(tmp1110, -4), RML_LABVAL(Trans_2dsclam874));
	rmlA0 = tmp821;
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1110, -4);
	rmlSP = RML_OFFSET(tmp1110, -4);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam874)
{

	{ void *tmp1114 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1114, 1));
	{ void *tmp824 = RML_FETCH(RML_OFFSET(tmp1114, 2));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1114, 3));
	{ void *tmp1113 = RML_OFFSET(tmp1114, 4);
	{ void *tmp829 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1113, -1), tmp397);
	RML_STORE(RML_OFFSET(tmp1113, -2), tmp824);
	RML_STORE(RML_OFFSET(tmp1113, -3), tmp829);
	RML_STORE(RML_OFFSET(tmp1113, -4), tmp398);
	RML_STORE(RML_OFFSET(tmp1113, -5), RML_LABVAL(Trans_2dsclam873));
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1113, -5);
	rmlSP = RML_OFFSET(tmp1113, -5);
	RML_TAILCALLQ(Trans__gentemp,0);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam873)
{

	{ void *tmp1117 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1117, 1));
	{ void *tmp829 = RML_FETCH(RML_OFFSET(tmp1117, 2));
	{ void *tmp824 = RML_FETCH(RML_OFFSET(tmp1117, 3));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1117, 4));
	{ void *tmp1116 = RML_OFFSET(tmp1117, 5);
	{ void *tmp834 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1116, -1), tmp397);
	RML_STORE(RML_OFFSET(tmp1116, -2), tmp834);
	RML_STORE(RML_OFFSET(tmp1116, -3), tmp824);
	RML_STORE(RML_OFFSET(tmp1116, -4), tmp829);
	RML_STORE(RML_OFFSET(tmp1116, -5), tmp398);
	RML_STORE(RML_OFFSET(tmp1116, -6), RML_LABVAL(Trans_2dsclam872));
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1116, -6);
	rmlSP = RML_OFFSET(tmp1116, -6);
	RML_TAILCALLQ(Trans__genlabel,0);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam872)
{

	{ void *tmp1120 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1120, 1));
	{ void *tmp829 = RML_FETCH(RML_OFFSET(tmp1120, 2));
	{ void *tmp824 = RML_FETCH(RML_OFFSET(tmp1120, 3));
	{ void *tmp834 = RML_FETCH(RML_OFFSET(tmp1120, 4));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1120, 5));
	{ void *tmp1119 = RML_OFFSET(tmp1120, 6);
	{ void *tmp839 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1119, -1), tmp834);
	RML_STORE(RML_OFFSET(tmp1119, -2), tmp839);
	RML_STORE(RML_OFFSET(tmp1119, -3), tmp824);
	RML_STORE(RML_OFFSET(tmp1119, -4), tmp397);
	RML_STORE(RML_OFFSET(tmp1119, -5), tmp829);
	RML_STORE(RML_OFFSET(tmp1119, -6), tmp398);
	RML_STORE(RML_OFFSET(tmp1119, -7), RML_LABVAL(Trans_2dsclam871));
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1119, -7);
	rmlSP = RML_OFFSET(tmp1119, -7);
	RML_TAILCALLQ(Trans__genlabel,0);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam871)
{
	void *tmp1121;
	RML_ALLOC(tmp1121,36,1,Trans_2dsclam871);
	{ void *tmp1123 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1123, 1));
	{ void *tmp829 = RML_FETCH(RML_OFFSET(tmp1123, 2));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1123, 3));
	{ void *tmp824 = RML_FETCH(RML_OFFSET(tmp1123, 4));
	{ void *tmp839 = RML_FETCH(RML_OFFSET(tmp1123, 5));
	{ void *tmp834 = RML_FETCH(RML_OFFSET(tmp1123, 6));
	{ void *tmp1122 = RML_OFFSET(tmp1123, 7);
	{ void *tmp844 = rmlA0;
	RML_STORE(tmp1121, RML_IMMEDIATE(RML_STRUCTHDR(1,4)));
	RML_STORE(RML_OFFSET(tmp1121, 1), tmp834);
	{ void *tmp848 = RML_TAGPTR(tmp1121);
	RML_STORE(RML_OFFSET(tmp1121, 2), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1121, 3), tmp848);
	RML_STORE(RML_OFFSET(tmp1121, 4), RML_REFSTRUCTLIT(lit0));
	{ void *tmp849 = RML_TAGPTR(RML_OFFSET(tmp1121, 2));
	RML_STORE(RML_OFFSET(tmp1121, 5), RML_IMMEDIATE(RML_STRUCTHDR(1,7)));
	RML_STORE(RML_OFFSET(tmp1121, 6), tmp839);
	{ void *tmp850 = RML_TAGPTR(RML_OFFSET(tmp1121, 5));
	RML_STORE(RML_OFFSET(tmp1121, 7), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1121, 8), tmp850);
	RML_STORE(RML_OFFSET(tmp1121, 9), RML_REFSTRUCTLIT(lit0));
	{ void *tmp851 = RML_TAGPTR(RML_OFFSET(tmp1121, 7));
	RML_STORE(RML_OFFSET(tmp1121, 10), RML_IMMEDIATE(RML_STRUCTHDR(1,3)));
	RML_STORE(RML_OFFSET(tmp1121, 11), tmp834);
	{ void *tmp852 = RML_TAGPTR(RML_OFFSET(tmp1121, 10));
	RML_STORE(RML_OFFSET(tmp1121, 12), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1121, 13), tmp852);
	RML_STORE(RML_OFFSET(tmp1121, 14), RML_REFSTRUCTLIT(lit0));
	{ void *tmp853 = RML_TAGPTR(RML_OFFSET(tmp1121, 12));
	RML_STORE(RML_OFFSET(tmp1121, 15), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1121, 16), RML_IMMEDIATE(RML_TAGFIXNUM(2)));
	RML_STORE(RML_OFFSET(tmp1121, 17), tmp844);
	{ void *tmp857 = RML_TAGPTR(RML_OFFSET(tmp1121, 15));
	RML_STORE(RML_OFFSET(tmp1121, 18), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1121, 19), tmp857);
	RML_STORE(RML_OFFSET(tmp1121, 20), RML_REFSTRUCTLIT(lit0));
	{ void *tmp858 = RML_TAGPTR(RML_OFFSET(tmp1121, 18));
	RML_STORE(RML_OFFSET(tmp1121, 21), RML_IMMEDIATE(RML_STRUCTHDR(1,4)));
	RML_STORE(RML_OFFSET(tmp1121, 22), tmp834);
	{ void *tmp859 = RML_TAGPTR(RML_OFFSET(tmp1121, 21));
	RML_STORE(RML_OFFSET(tmp1121, 23), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1121, 24), tmp859);
	RML_STORE(RML_OFFSET(tmp1121, 25), RML_REFSTRUCTLIT(lit0));
	{ void *tmp860 = RML_TAGPTR(RML_OFFSET(tmp1121, 23));
	RML_STORE(RML_OFFSET(tmp1121, 26), RML_IMMEDIATE(RML_STRUCTHDR(1,2)));
	RML_STORE(RML_OFFSET(tmp1121, 27), tmp839);
	{ void *tmp861 = RML_TAGPTR(RML_OFFSET(tmp1121, 26));
	RML_STORE(RML_OFFSET(tmp1121, 28), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1121, 29), tmp861);
	RML_STORE(RML_OFFSET(tmp1121, 30), RML_REFSTRUCTLIT(lit0));
	{ void *tmp862 = RML_TAGPTR(RML_OFFSET(tmp1121, 28));
	RML_STORE(RML_OFFSET(tmp1121, 31), RML_IMMEDIATE(RML_STRUCTHDR(1,7)));
	RML_STORE(RML_OFFSET(tmp1121, 32), tmp844);
	{ void *tmp863 = RML_TAGPTR(RML_OFFSET(tmp1121, 31));
	RML_STORE(RML_OFFSET(tmp1121, 33), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1121, 34), tmp863);
	RML_STORE(RML_OFFSET(tmp1121, 35), RML_REFSTRUCTLIT(lit0));
	{ void *tmp864 = RML_TAGPTR(RML_OFFSET(tmp1121, 33));
	RML_STORE(RML_OFFSET(tmp1122, -1), tmp858);
	RML_STORE(RML_OFFSET(tmp1122, -2), tmp860);
	RML_STORE(RML_OFFSET(tmp1122, -3), tmp829);
	RML_STORE(RML_OFFSET(tmp1122, -4), tmp862);
	RML_STORE(RML_OFFSET(tmp1122, -5), tmp864);
	RML_STORE(RML_OFFSET(tmp1122, -6), tmp397);
	RML_STORE(RML_OFFSET(tmp1122, -7), tmp398);
	RML_STORE(RML_OFFSET(tmp1122, -8), RML_LABVAL(Trans_2dsclam457));
	rmlA4 = RML_REFSTRUCTLIT(lit3);
	rmlA3 = tmp853;
	rmlA2 = tmp851;
	rmlA1 = tmp849;
	rmlA0 = tmp824;
	rmlFC = tmp397;
	rmlSC = RML_OFFSET(tmp1122, -8);
	rmlSP = RML_OFFSET(tmp1122, -8);
	RML_TAILCALLQ(Trans__list_5fappend5,5);}}}}}}}}}}}}}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam457)
{

	{ void *tmp1126 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1126, 1));
	{ void *tmp397 = RML_FETCH(RML_OFFSET(tmp1126, 2));
	{ void *tmp864 = RML_FETCH(RML_OFFSET(tmp1126, 3));
	{ void *tmp862 = RML_FETCH(RML_OFFSET(tmp1126, 4));
	{ void *tmp829 = RML_FETCH(RML_OFFSET(tmp1126, 5));
	{ void *tmp860 = RML_FETCH(RML_OFFSET(tmp1126, 6));
	{ void *tmp858 = RML_FETCH(RML_OFFSET(tmp1126, 7));
	{ void *tmp1125 = RML_OFFSET(tmp1126, 8);
	rmlA5 = tmp864;
	rmlA4 = tmp862;
	rmlA3 = tmp829;
	rmlA2 = tmp860;
	rmlA1 = tmp858;
	rmlFC = tmp397;
	rmlSC = tmp398;
	rmlSP = tmp1125;
	RML_TAILCALLQ(Trans__list_5fappend6,6);}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dlab819)
{

	{ void *tmp1093 = rmlSP;
	{ void *tmp398 = rmlA0;
	{ void *tmp773 = rmlA1;
	{ void *tmp774 = rmlA2;
	{ void *tmp775 = rmlA3;
	{ void *tmp776 = rmlA4;
	RML_STORE(RML_OFFSET(tmp1093, -1), tmp774);
	RML_STORE(RML_OFFSET(tmp1093, -2), tmp773);
	RML_STORE(RML_OFFSET(tmp1093, -3), tmp776);
	RML_STORE(RML_OFFSET(tmp1093, -4), tmp398);
	RML_STORE(RML_OFFSET(tmp1093, -5), RML_LABVAL(Trans_2dsclam818));
	rmlA0 = tmp775;
	rmlFC = tmp773;
	rmlSC = RML_OFFSET(tmp1093, -5);
	rmlSP = RML_OFFSET(tmp1093, -5);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam818)
{

	{ void *tmp1096 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1096, 1));
	{ void *tmp776 = RML_FETCH(RML_OFFSET(tmp1096, 2));
	{ void *tmp773 = RML_FETCH(RML_OFFSET(tmp1096, 3));
	{ void *tmp774 = RML_FETCH(RML_OFFSET(tmp1096, 4));
	{ void *tmp1095 = RML_OFFSET(tmp1096, 5);
	{ void *tmp778 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1095, -1), tmp773);
	RML_STORE(RML_OFFSET(tmp1095, -2), tmp776);
	RML_STORE(RML_OFFSET(tmp1095, -3), tmp778);
	RML_STORE(RML_OFFSET(tmp1095, -4), tmp398);
	RML_STORE(RML_OFFSET(tmp1095, -5), RML_LABVAL(Trans_2dsclam817));
	rmlA0 = tmp774;
	rmlFC = tmp773;
	rmlSC = RML_OFFSET(tmp1095, -5);
	rmlSP = RML_OFFSET(tmp1095, -5);
	RML_TAILCALLQ(Trans__trans_5fstmt,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam817)
{

	{ void *tmp1099 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1099, 1));
	{ void *tmp778 = RML_FETCH(RML_OFFSET(tmp1099, 2));
	{ void *tmp776 = RML_FETCH(RML_OFFSET(tmp1099, 3));
	{ void *tmp773 = RML_FETCH(RML_OFFSET(tmp1099, 4));
	{ void *tmp1098 = RML_OFFSET(tmp1099, 5);
	{ void *tmp783 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1098, -1), tmp773);
	RML_STORE(RML_OFFSET(tmp1098, -2), tmp776);
	RML_STORE(RML_OFFSET(tmp1098, -3), tmp778);
	RML_STORE(RML_OFFSET(tmp1098, -4), tmp783);
	RML_STORE(RML_OFFSET(tmp1098, -5), tmp398);
	RML_STORE(RML_OFFSET(tmp1098, -6), RML_LABVAL(Trans_2dsclam816));
	rmlFC = tmp773;
	rmlSC = RML_OFFSET(tmp1098, -6);
	rmlSP = RML_OFFSET(tmp1098, -6);
	RML_TAILCALLQ(Trans__genlabel,0);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam816)
{

	{ void *tmp1102 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1102, 1));
	{ void *tmp783 = RML_FETCH(RML_OFFSET(tmp1102, 2));
	{ void *tmp778 = RML_FETCH(RML_OFFSET(tmp1102, 3));
	{ void *tmp776 = RML_FETCH(RML_OFFSET(tmp1102, 4));
	{ void *tmp773 = RML_FETCH(RML_OFFSET(tmp1102, 5));
	{ void *tmp1101 = RML_OFFSET(tmp1102, 6);
	{ void *tmp788 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1101, -1), tmp776);
	RML_STORE(RML_OFFSET(tmp1101, -2), tmp788);
	RML_STORE(RML_OFFSET(tmp1101, -3), tmp773);
	RML_STORE(RML_OFFSET(tmp1101, -4), tmp778);
	RML_STORE(RML_OFFSET(tmp1101, -5), tmp783);
	RML_STORE(RML_OFFSET(tmp1101, -6), tmp398);
	RML_STORE(RML_OFFSET(tmp1101, -7), RML_LABVAL(Trans_2dsclam815));
	rmlFC = tmp773;
	rmlSC = RML_OFFSET(tmp1101, -7);
	rmlSP = RML_OFFSET(tmp1101, -7);
	RML_TAILCALLQ(Trans__genlabel,0);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam815)
{

	{ void *tmp1105 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1105, 1));
	{ void *tmp783 = RML_FETCH(RML_OFFSET(tmp1105, 2));
	{ void *tmp778 = RML_FETCH(RML_OFFSET(tmp1105, 3));
	{ void *tmp773 = RML_FETCH(RML_OFFSET(tmp1105, 4));
	{ void *tmp788 = RML_FETCH(RML_OFFSET(tmp1105, 5));
	{ void *tmp776 = RML_FETCH(RML_OFFSET(tmp1105, 6));
	{ void *tmp1104 = RML_OFFSET(tmp1105, 7);
	{ void *tmp793 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1104, -1), tmp793);
	RML_STORE(RML_OFFSET(tmp1104, -2), tmp788);
	RML_STORE(RML_OFFSET(tmp1104, -3), tmp778);
	RML_STORE(RML_OFFSET(tmp1104, -4), tmp783);
	RML_STORE(RML_OFFSET(tmp1104, -5), tmp773);
	RML_STORE(RML_OFFSET(tmp1104, -6), tmp398);
	RML_STORE(RML_OFFSET(tmp1104, -7), RML_LABVAL(Trans_2dsclam814));
	rmlA1 = tmp788;
	rmlA0 = tmp776;
	rmlFC = tmp773;
	rmlSC = RML_OFFSET(tmp1104, -7);
	rmlSP = RML_OFFSET(tmp1104, -7);
	RML_TAILCALLQ(Trans__trans_5fcomparison,2);}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam814)
{
	void *tmp1106;
	RML_ALLOC(tmp1106,15,1,Trans_2dsclam814);
	{ void *tmp1108 = rmlSC;
	{ void *tmp398 = RML_FETCH(RML_OFFSET(tmp1108, 1));
	{ void *tmp773 = RML_FETCH(RML_OFFSET(tmp1108, 2));
	{ void *tmp783 = RML_FETCH(RML_OFFSET(tmp1108, 3));
	{ void *tmp778 = RML_FETCH(RML_OFFSET(tmp1108, 4));
	{ void *tmp788 = RML_FETCH(RML_OFFSET(tmp1108, 5));
	{ void *tmp793 = RML_FETCH(RML_OFFSET(tmp1108, 6));
	{ void *tmp1107 = RML_OFFSET(tmp1108, 7);
	RML_STORE(tmp1106, RML_IMMEDIATE(RML_STRUCTHDR(1,2)));
	RML_STORE(RML_OFFSET(tmp1106, 1), tmp793);
	{ void *tmp802 = RML_TAGPTR(tmp1106);
	RML_STORE(RML_OFFSET(tmp1106, 2), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1106, 3), tmp802);
	RML_STORE(RML_OFFSET(tmp1106, 4), RML_REFSTRUCTLIT(lit0));
	{ void *tmp803 = RML_TAGPTR(RML_OFFSET(tmp1106, 2));
	RML_STORE(RML_OFFSET(tmp1106, 5), RML_IMMEDIATE(RML_STRUCTHDR(1,7)));
	RML_STORE(RML_OFFSET(tmp1106, 6), tmp788);
	{ void *tmp804 = RML_TAGPTR(RML_OFFSET(tmp1106, 5));
	RML_STORE(RML_OFFSET(tmp1106, 7), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1106, 8), tmp804);
	RML_STORE(RML_OFFSET(tmp1106, 9), RML_REFSTRUCTLIT(lit0));
	{ void *tmp805 = RML_TAGPTR(RML_OFFSET(tmp1106, 7));
	RML_STORE(RML_OFFSET(tmp1106, 10), RML_IMMEDIATE(RML_STRUCTHDR(1,7)));
	RML_STORE(RML_OFFSET(tmp1106, 11), tmp793);
	{ void *tmp806 = RML_TAGPTR(RML_OFFSET(tmp1106, 10));
	RML_STORE(RML_OFFSET(tmp1106, 12), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1106, 13), tmp806);
	RML_STORE(RML_OFFSET(tmp1106, 14), RML_REFSTRUCTLIT(lit0));
	{ void *tmp807 = RML_TAGPTR(RML_OFFSET(tmp1106, 12));
	rmlA5 = tmp807;
	rmlA4 = tmp783;
	rmlA3 = tmp805;
	rmlA2 = tmp803;
	rmlA1 = tmp778;
	rmlFC = tmp773;
	rmlSC = tmp398;
	rmlSP = tmp1107;
	RML_TAILCALLQ(Trans__list_5fappend6,6);}}}}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__genlabel)
{

	{ void *tmp381 = rmlSC;
	{ void *tmp1086 = rmlSP;
	RML_STORE(RML_OFFSET(tmp1086, -1), tmp381);
	RML_STORE(RML_OFFSET(tmp1086, -2), RML_LABVAL(Trans_2dsclam409));
	rmlSC = RML_OFFSET(tmp1086, -2);
	rmlSP = RML_OFFSET(tmp1086, -2);
	RML_TAILCALLQ(RML__tick,0);}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam409)
{
	void *tmp1087;
	RML_ALLOC(tmp1087,2,1,Trans_2dsclam409);
	{ void *tmp1089 = rmlSC;
	{ void *tmp381 = RML_FETCH(RML_OFFSET(tmp1089, 1));
	{ void *tmp1088 = RML_OFFSET(tmp1089, 2);
	{ void *tmp404 = rmlA0;
	RML_STORE(tmp1087, RML_IMMEDIATE(RML_STRUCTHDR(1,3)));
	RML_STORE(RML_OFFSET(tmp1087, 1), tmp404);
	{ void *tmp408 = RML_TAGPTR(tmp1087);
	rmlA0 = tmp408;
	rmlSC = tmp381;
	rmlSP = tmp1088;
	RML_TAILCALL(RML_FETCH(tmp381),1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__gentemp)
{

	{ void *tmp383 = rmlSC;
	{ void *tmp1081 = rmlSP;
	RML_STORE(RML_OFFSET(tmp1081, -1), tmp383);
	RML_STORE(RML_OFFSET(tmp1081, -2), RML_LABVAL(Trans_2dsclam416));
	rmlSC = RML_OFFSET(tmp1081, -2);
	rmlSP = RML_OFFSET(tmp1081, -2);
	RML_TAILCALLQ(RML__tick,0);}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam416)
{
	void *tmp1082;
	RML_ALLOC(tmp1082,2,1,Trans_2dsclam416);
	{ void *tmp1084 = rmlSC;
	{ void *tmp383 = RML_FETCH(RML_OFFSET(tmp1084, 1));
	{ void *tmp1083 = RML_OFFSET(tmp1084, 2);
	{ void *tmp411 = rmlA0;
	RML_STORE(tmp1082, RML_IMMEDIATE(RML_STRUCTHDR(1,2)));
	RML_STORE(RML_OFFSET(tmp1082, 1), tmp411);
	{ void *tmp415 = RML_TAGPTR(tmp1082);
	rmlA0 = tmp415;
	rmlSC = tmp383;
	rmlSP = tmp1083;
	RML_TAILCALL(RML_FETCH(tmp383),1);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__list_5fappend3)
{

	{ void *tmp349 = rmlSC;
	{ void *tmp348 = rmlFC;
	{ void *tmp1076 = rmlSP;
	{ void *tmp352 = rmlA2;
	RML_STORE(RML_OFFSET(tmp1076, -1), tmp352);
	RML_STORE(RML_OFFSET(tmp1076, -2), tmp348);
	RML_STORE(RML_OFFSET(tmp1076, -3), tmp349);
	RML_STORE(RML_OFFSET(tmp1076, -4), RML_LABVAL(Trans_2dsclam433));
	rmlSC = RML_OFFSET(tmp1076, -4);
	rmlSP = RML_OFFSET(tmp1076, -4);
	RML_TAILCALLQ(RML__list_5fappend,2);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam433)
{

	{ void *tmp1079 = rmlSC;
	{ void *tmp349 = RML_FETCH(RML_OFFSET(tmp1079, 1));
	{ void *tmp348 = RML_FETCH(RML_OFFSET(tmp1079, 2));
	{ void *tmp352 = RML_FETCH(RML_OFFSET(tmp1079, 3));
	{ void *tmp1078 = RML_OFFSET(tmp1079, 4);
	rmlA1 = tmp352;
	rmlFC = tmp348;
	rmlSC = tmp349;
	rmlSP = tmp1078;
	RML_TAILCALLQ(RML__list_5fappend,2);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__list_5fappend5)
{

	{ void *tmp362 = rmlSC;
	{ void *tmp361 = rmlFC;
	{ void *tmp1071 = rmlSP;
	{ void *tmp366 = rmlA3;
	{ void *tmp367 = rmlA4;
	RML_STORE(RML_OFFSET(tmp1071, -1), tmp366);
	RML_STORE(RML_OFFSET(tmp1071, -2), tmp367);
	RML_STORE(RML_OFFSET(tmp1071, -3), tmp361);
	RML_STORE(RML_OFFSET(tmp1071, -4), tmp362);
	RML_STORE(RML_OFFSET(tmp1071, -5), RML_LABVAL(Trans_2dsclam476));
	rmlSC = RML_OFFSET(tmp1071, -5);
	rmlSP = RML_OFFSET(tmp1071, -5);
	RML_TAILCALLQ(Trans__list_5fappend3,3);}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam476)
{

	{ void *tmp1074 = rmlSC;
	{ void *tmp362 = RML_FETCH(RML_OFFSET(tmp1074, 1));
	{ void *tmp361 = RML_FETCH(RML_OFFSET(tmp1074, 2));
	{ void *tmp367 = RML_FETCH(RML_OFFSET(tmp1074, 3));
	{ void *tmp366 = RML_FETCH(RML_OFFSET(tmp1074, 4));
	{ void *tmp1073 = RML_OFFSET(tmp1074, 5);
	rmlA2 = tmp367;
	rmlA1 = tmp366;
	rmlFC = tmp361;
	rmlSC = tmp362;
	rmlSP = tmp1073;
	RML_TAILCALLQ(Trans__list_5fappend3,3);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__list_5fappend6)
{

	{ void *tmp354 = rmlSC;
	{ void *tmp353 = rmlFC;
	{ void *tmp1063 = rmlSP;
	{ void *tmp358 = rmlA3;
	{ void *tmp359 = rmlA4;
	{ void *tmp360 = rmlA5;
	RML_STORE(RML_OFFSET(tmp1063, -1), tmp358);
	RML_STORE(RML_OFFSET(tmp1063, -2), tmp359);
	RML_STORE(RML_OFFSET(tmp1063, -3), tmp360);
	RML_STORE(RML_OFFSET(tmp1063, -4), tmp353);
	RML_STORE(RML_OFFSET(tmp1063, -5), tmp354);
	RML_STORE(RML_OFFSET(tmp1063, -6), RML_LABVAL(Trans_2dsclam502));
	rmlSC = RML_OFFSET(tmp1063, -6);
	rmlSP = RML_OFFSET(tmp1063, -6);
	RML_TAILCALLQ(Trans__list_5fappend3,3);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam502)
{

	{ void *tmp1066 = rmlSC;
	{ void *tmp354 = RML_FETCH(RML_OFFSET(tmp1066, 1));
	{ void *tmp353 = RML_FETCH(RML_OFFSET(tmp1066, 2));
	{ void *tmp360 = RML_FETCH(RML_OFFSET(tmp1066, 3));
	{ void *tmp359 = RML_FETCH(RML_OFFSET(tmp1066, 4));
	{ void *tmp358 = RML_FETCH(RML_OFFSET(tmp1066, 5));
	{ void *tmp1065 = RML_OFFSET(tmp1066, 6);
	{ void *tmp486 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1065, -1), tmp486);
	RML_STORE(RML_OFFSET(tmp1065, -2), tmp353);
	RML_STORE(RML_OFFSET(tmp1065, -3), tmp354);
	RML_STORE(RML_OFFSET(tmp1065, -4), RML_LABVAL(Trans_2dsclam501));
	rmlA2 = tmp360;
	rmlA1 = tmp359;
	rmlA0 = tmp358;
	rmlFC = tmp353;
	rmlSC = RML_OFFSET(tmp1065, -4);
	rmlSP = RML_OFFSET(tmp1065, -4);
	RML_TAILCALLQ(Trans__list_5fappend3,3);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam501)
{

	{ void *tmp1069 = rmlSC;
	{ void *tmp354 = RML_FETCH(RML_OFFSET(tmp1069, 1));
	{ void *tmp353 = RML_FETCH(RML_OFFSET(tmp1069, 2));
	{ void *tmp486 = RML_FETCH(RML_OFFSET(tmp1069, 3));
	{ void *tmp1068 = RML_OFFSET(tmp1069, 4);
	{ void *tmp491 = rmlA0;
	rmlA1 = tmp491;
	rmlA0 = tmp486;
	rmlFC = tmp353;
	rmlSC = tmp354;
	rmlSP = tmp1068;
	RML_TAILCALLQ(RML__list_5fappend,2);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__trans_5fexpr)
{
	void *tmp1037;
	RML_ALLOC(tmp1037,7,1,Trans__trans_5fexpr);
	{ void *tmp388 = rmlSC;
	{ void *tmp387 = rmlFC;
	{ void *tmp1038 = rmlSP;
	{ void *tmp389 = rmlA0;
	{ void *tmp517 = RML_FETCH(RML_UNTAGPTR(tmp389));
	switch( (rml_sint_t)tmp517 ) {
	case RML_STRUCTHDR(1,1):
	{ void *tmp518 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp389), 1));
	RML_STORE(tmp1037, RML_IMMEDIATE(RML_STRUCTHDR(1,0)));
	RML_STORE(RML_OFFSET(tmp1037, 1), tmp518);
	{ void *tmp519 = RML_TAGPTR(tmp1037);
	RML_STORE(RML_OFFSET(tmp1037, 2), RML_IMMEDIATE(RML_STRUCTHDR(1,3)));
	RML_STORE(RML_OFFSET(tmp1037, 3), tmp519);
	{ void *tmp520 = RML_TAGPTR(RML_OFFSET(tmp1037, 2));
	RML_STORE(RML_OFFSET(tmp1037, 4), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1037, 5), tmp520);
	RML_STORE(RML_OFFSET(tmp1037, 6), RML_REFSTRUCTLIT(lit0));
	{ void *tmp521 = RML_TAGPTR(RML_OFFSET(tmp1037, 4));
	rmlA0 = tmp521;
	RML_TAILCALL(RML_FETCH(tmp388),1);}}}}
	case RML_STRUCTHDR(3,2):
	{ void *tmp522 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp389), 3));
	{ void *tmp523 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp389), 2));
	{ void *tmp524 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp389), 1));
	RML_STORE(RML_OFFSET(tmp1038, -1), tmp522);
	RML_STORE(RML_OFFSET(tmp1038, -2), tmp387);
	RML_STORE(RML_OFFSET(tmp1038, -3), tmp523);
	RML_STORE(RML_OFFSET(tmp1038, -4), tmp388);
	RML_STORE(RML_OFFSET(tmp1038, -5), RML_LABVAL(Trans_2dsclam604));
	rmlA0 = tmp524;
	rmlSC = RML_OFFSET(tmp1038, -5);
	rmlSP = RML_OFFSET(tmp1038, -5);
	RML_TAILCALLQ(Trans__trans_5fexpr,1);}}}
	case RML_STRUCTHDR(1,0):
	{ void *tmp605 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp389), 1));
	RML_STORE(tmp1037, RML_IMMEDIATE(RML_STRUCTHDR(1,1)));
	RML_STORE(RML_OFFSET(tmp1037, 1), tmp605);
	{ void *tmp606 = RML_TAGPTR(tmp1037);
	RML_STORE(RML_OFFSET(tmp1037, 2), RML_IMMEDIATE(RML_STRUCTHDR(1,3)));
	RML_STORE(RML_OFFSET(tmp1037, 3), tmp606);
	{ void *tmp607 = RML_TAGPTR(RML_OFFSET(tmp1037, 2));
	RML_STORE(RML_OFFSET(tmp1037, 4), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1037, 5), tmp607);
	RML_STORE(RML_OFFSET(tmp1037, 6), RML_REFSTRUCTLIT(lit0));
	{ void *tmp608 = RML_TAGPTR(RML_OFFSET(tmp1037, 4));
	rmlA0 = tmp608;
	RML_TAILCALL(RML_FETCH(tmp388),1);}}}}
	default:
	RML_TAILCALL(RML_FETCH(tmp387),0);
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam604)
{

	{ void *tmp1041 = rmlSC;
	{ void *tmp388 = RML_FETCH(RML_OFFSET(tmp1041, 1));
	{ void *tmp523 = RML_FETCH(RML_OFFSET(tmp1041, 2));
	{ void *tmp387 = RML_FETCH(RML_OFFSET(tmp1041, 3));
	{ void *tmp522 = RML_FETCH(RML_OFFSET(tmp1041, 4));
	{ void *tmp1040 = RML_OFFSET(tmp1041, 5);
	{ void *tmp526 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1040, -1), tmp523);
	RML_STORE(RML_OFFSET(tmp1040, -2), tmp526);
	RML_STORE(RML_OFFSET(tmp1040, -3), tmp388);
	RML_STORE(RML_OFFSET(tmp1040, -4), tmp387);
	RML_STORE(RML_OFFSET(tmp1040, -5), RML_LABVAL(Trans_2dsclam603));
	rmlA0 = tmp522;
	rmlFC = tmp387;
	rmlSC = RML_OFFSET(tmp1040, -5);
	rmlSP = RML_OFFSET(tmp1040, -5);
	RML_TAILCALLQ(Trans__trans_5fexpr,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam603)
{

	{ void *tmp1044 = rmlSC;
	{ void *tmp387 = RML_FETCH(RML_OFFSET(tmp1044, 1));
	{ void *tmp388 = RML_FETCH(RML_OFFSET(tmp1044, 2));
	{ void *tmp526 = RML_FETCH(RML_OFFSET(tmp1044, 3));
	{ void *tmp523 = RML_FETCH(RML_OFFSET(tmp1044, 4));
	{ void *tmp1043 = RML_OFFSET(tmp1044, 5);
	{ void *tmp531 = rmlA0;
	{ void *tmp581 = RML_FETCH(RML_UNTAGPTR(tmp531));
	switch( (rml_sint_t)tmp581 ) {
	case RML_STRUCTHDR(2,1):
	{ void *tmp582 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp531), 2));
	{ void *tmp583 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp531), 1));
	{ void *tmp584 = RML_FETCH(RML_UNTAGPTR(tmp583));
	switch( (rml_sint_t)tmp584 ) {
	case RML_STRUCTHDR(1,3):
	{ void *tmp585 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp583), 1));
	{ void *tmp586 = RML_FETCH(RML_UNTAGPTR(tmp582));
	switch( (rml_sint_t)tmp586 ) {
	case RML_STRUCTHDR(0,0):
	RML_STORE(RML_OFFSET(tmp1043, -1), tmp387);
	RML_STORE(RML_OFFSET(tmp1043, -2), tmp531);
	RML_STORE(RML_OFFSET(tmp1043, -3), tmp388);
	RML_STORE(RML_OFFSET(tmp1043, -4), tmp526);
	RML_STORE(RML_OFFSET(tmp1043, -5), tmp523);
	RML_STORE(RML_OFFSET(tmp1043, -6), RML_LABVAL(Trans_2dfclam588));
	{ void *tmp587 = RML_OFFSET(tmp1043, -6);
	RML_STORE(RML_OFFSET(tmp1043, -7), tmp585);
	RML_STORE(RML_OFFSET(tmp1043, -8), tmp526);
	RML_STORE(RML_OFFSET(tmp1043, -9), tmp587);
	RML_STORE(RML_OFFSET(tmp1043, -10), tmp388);
	RML_STORE(RML_OFFSET(tmp1043, -11), RML_LABVAL(Trans_2dsclam602));
	rmlA0 = tmp523;
	rmlFC = tmp587;
	rmlSC = RML_OFFSET(tmp1043, -11);
	rmlSP = RML_OFFSET(tmp1043, -11);
	RML_TAILCALLQ(Trans__trans_5fbinop,1);}
	default:
	rmlA4 = tmp531;
	rmlA3 = tmp387;
	rmlA2 = tmp523;
	rmlA1 = tmp526;
	rmlA0 = tmp388;
	rmlSP = tmp1043;
	RML_TAILCALLQ(Trans_2dlab580,5);
	}}}
	default:
	rmlA4 = tmp531;
	rmlA3 = tmp387;
	rmlA2 = tmp523;
	rmlA1 = tmp526;
	rmlA0 = tmp388;
	rmlSP = tmp1043;
	RML_TAILCALLQ(Trans_2dlab580,5);
	}}}}
	default:
	rmlA4 = tmp531;
	rmlA3 = tmp387;
	rmlA2 = tmp523;
	rmlA1 = tmp526;
	rmlA0 = tmp388;
	rmlSP = tmp1043;
	RML_TAILCALLQ(Trans_2dlab580,5);
	}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam602)
{
	void *tmp1059;
	RML_ALLOC(tmp1059,6,1,Trans_2dsclam602);
	{ void *tmp1061 = rmlSC;
	{ void *tmp388 = RML_FETCH(RML_OFFSET(tmp1061, 1));
	{ void *tmp587 = RML_FETCH(RML_OFFSET(tmp1061, 2));
	{ void *tmp526 = RML_FETCH(RML_OFFSET(tmp1061, 3));
	{ void *tmp585 = RML_FETCH(RML_OFFSET(tmp1061, 4));
	{ void *tmp1060 = RML_OFFSET(tmp1061, 5);
	{ void *tmp590 = rmlA0;
	RML_STORE(tmp1059, RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp1059, 1), tmp590);
	RML_STORE(RML_OFFSET(tmp1059, 2), tmp585);
	{ void *tmp594 = RML_TAGPTR(tmp1059);
	RML_STORE(RML_OFFSET(tmp1059, 3), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1059, 4), tmp594);
	RML_STORE(RML_OFFSET(tmp1059, 5), RML_REFSTRUCTLIT(lit0));
	{ void *tmp595 = RML_TAGPTR(RML_OFFSET(tmp1059, 3));
	rmlA1 = tmp595;
	rmlA0 = tmp526;
	rmlFC = tmp587;
	rmlSC = tmp388;
	rmlSP = tmp1060;
	RML_TAILCALLQ(RML__list_5fappend,2);}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dfclam588)
{

	{ void *tmp1058 = rmlFC;
	{ void *tmp523 = RML_FETCH(RML_OFFSET(tmp1058, 1));
	{ void *tmp526 = RML_FETCH(RML_OFFSET(tmp1058, 2));
	{ void *tmp388 = RML_FETCH(RML_OFFSET(tmp1058, 3));
	{ void *tmp531 = RML_FETCH(RML_OFFSET(tmp1058, 4));
	{ void *tmp387 = RML_FETCH(RML_OFFSET(tmp1058, 5));
	{ void *tmp1057 = RML_OFFSET(tmp1058, 6);
	rmlA4 = tmp531;
	rmlA3 = tmp387;
	rmlA2 = tmp523;
	rmlA1 = tmp526;
	rmlA0 = tmp388;
	rmlSP = tmp1057;
	RML_TAILCALLQ(Trans_2dlab580,5);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dlab580)
{

	{ void *tmp1046 = rmlSP;
	{ void *tmp388 = rmlA0;
	{ void *tmp526 = rmlA1;
	{ void *tmp523 = rmlA2;
	{ void *tmp546 = rmlA3;
	{ void *tmp547 = rmlA4;
	RML_STORE(RML_OFFSET(tmp1046, -1), tmp546);
	RML_STORE(RML_OFFSET(tmp1046, -2), tmp526);
	RML_STORE(RML_OFFSET(tmp1046, -3), tmp547);
	RML_STORE(RML_OFFSET(tmp1046, -4), tmp388);
	RML_STORE(RML_OFFSET(tmp1046, -5), RML_LABVAL(Trans_2dsclam579));
	rmlA0 = tmp523;
	rmlFC = tmp546;
	rmlSC = RML_OFFSET(tmp1046, -5);
	rmlSP = RML_OFFSET(tmp1046, -5);
	RML_TAILCALLQ(Trans__trans_5fbinop,1);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam579)
{

	{ void *tmp1049 = rmlSC;
	{ void *tmp388 = RML_FETCH(RML_OFFSET(tmp1049, 1));
	{ void *tmp547 = RML_FETCH(RML_OFFSET(tmp1049, 2));
	{ void *tmp526 = RML_FETCH(RML_OFFSET(tmp1049, 3));
	{ void *tmp546 = RML_FETCH(RML_OFFSET(tmp1049, 4));
	{ void *tmp1048 = RML_OFFSET(tmp1049, 5);
	{ void *tmp549 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1048, -1), tmp546);
	RML_STORE(RML_OFFSET(tmp1048, -2), tmp549);
	RML_STORE(RML_OFFSET(tmp1048, -3), tmp526);
	RML_STORE(RML_OFFSET(tmp1048, -4), tmp547);
	RML_STORE(RML_OFFSET(tmp1048, -5), tmp388);
	RML_STORE(RML_OFFSET(tmp1048, -6), RML_LABVAL(Trans_2dsclam578));
	rmlFC = tmp546;
	rmlSC = RML_OFFSET(tmp1048, -6);
	rmlSP = RML_OFFSET(tmp1048, -6);
	RML_TAILCALLQ(Trans__gentemp,0);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam578)
{

	{ void *tmp1052 = rmlSC;
	{ void *tmp388 = RML_FETCH(RML_OFFSET(tmp1052, 1));
	{ void *tmp547 = RML_FETCH(RML_OFFSET(tmp1052, 2));
	{ void *tmp526 = RML_FETCH(RML_OFFSET(tmp1052, 3));
	{ void *tmp549 = RML_FETCH(RML_OFFSET(tmp1052, 4));
	{ void *tmp546 = RML_FETCH(RML_OFFSET(tmp1052, 5));
	{ void *tmp1051 = RML_OFFSET(tmp1052, 6);
	{ void *tmp554 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1051, -1), tmp554);
	RML_STORE(RML_OFFSET(tmp1051, -2), tmp549);
	RML_STORE(RML_OFFSET(tmp1051, -3), tmp526);
	RML_STORE(RML_OFFSET(tmp1051, -4), tmp547);
	RML_STORE(RML_OFFSET(tmp1051, -5), tmp546);
	RML_STORE(RML_OFFSET(tmp1051, -6), tmp388);
	RML_STORE(RML_OFFSET(tmp1051, -7), RML_LABVAL(Trans_2dsclam577));
	rmlFC = tmp546;
	rmlSC = RML_OFFSET(tmp1051, -7);
	rmlSP = RML_OFFSET(tmp1051, -7);
	RML_TAILCALLQ(Trans__gentemp,0);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam577)
{
	void *tmp1053;
	RML_ALLOC(tmp1053,21,1,Trans_2dsclam577);
	{ void *tmp1055 = rmlSC;
	{ void *tmp388 = RML_FETCH(RML_OFFSET(tmp1055, 1));
	{ void *tmp546 = RML_FETCH(RML_OFFSET(tmp1055, 2));
	{ void *tmp547 = RML_FETCH(RML_OFFSET(tmp1055, 3));
	{ void *tmp526 = RML_FETCH(RML_OFFSET(tmp1055, 4));
	{ void *tmp549 = RML_FETCH(RML_OFFSET(tmp1055, 5));
	{ void *tmp554 = RML_FETCH(RML_OFFSET(tmp1055, 6));
	{ void *tmp1054 = RML_OFFSET(tmp1055, 7);
	{ void *tmp559 = rmlA0;
	RML_STORE(tmp1053, RML_IMMEDIATE(RML_STRUCTHDR(1,4)));
	RML_STORE(RML_OFFSET(tmp1053, 1), tmp554);
	{ void *tmp563 = RML_TAGPTR(tmp1053);
	RML_STORE(RML_OFFSET(tmp1053, 2), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1053, 3), tmp563);
	RML_STORE(RML_OFFSET(tmp1053, 4), RML_REFSTRUCTLIT(lit0));
	{ void *tmp564 = RML_TAGPTR(RML_OFFSET(tmp1053, 2));
	RML_STORE(RML_OFFSET(tmp1053, 5), RML_IMMEDIATE(RML_STRUCTHDR(1,4)));
	RML_STORE(RML_OFFSET(tmp1053, 6), tmp559);
	{ void *tmp565 = RML_TAGPTR(RML_OFFSET(tmp1053, 5));
	RML_STORE(RML_OFFSET(tmp1053, 7), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1053, 8), tmp565);
	RML_STORE(RML_OFFSET(tmp1053, 9), RML_REFSTRUCTLIT(lit0));
	{ void *tmp566 = RML_TAGPTR(RML_OFFSET(tmp1053, 7));
	RML_STORE(RML_OFFSET(tmp1053, 10), RML_IMMEDIATE(RML_STRUCTHDR(1,3)));
	RML_STORE(RML_OFFSET(tmp1053, 11), tmp554);
	{ void *tmp567 = RML_TAGPTR(RML_OFFSET(tmp1053, 10));
	RML_STORE(RML_OFFSET(tmp1053, 12), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1053, 13), tmp567);
	RML_STORE(RML_OFFSET(tmp1053, 14), RML_REFSTRUCTLIT(lit0));
	{ void *tmp568 = RML_TAGPTR(RML_OFFSET(tmp1053, 12));
	RML_STORE(RML_OFFSET(tmp1053, 15), RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp1053, 16), tmp549);
	RML_STORE(RML_OFFSET(tmp1053, 17), tmp559);
	{ void *tmp569 = RML_TAGPTR(RML_OFFSET(tmp1053, 15));
	RML_STORE(RML_OFFSET(tmp1053, 18), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1053, 19), tmp569);
	RML_STORE(RML_OFFSET(tmp1053, 20), RML_REFSTRUCTLIT(lit0));
	{ void *tmp570 = RML_TAGPTR(RML_OFFSET(tmp1053, 18));
	rmlA5 = tmp570;
	rmlA4 = tmp568;
	rmlA3 = tmp566;
	rmlA2 = tmp547;
	rmlA1 = tmp564;
	rmlA0 = tmp526;
	rmlFC = tmp546;
	rmlSC = tmp388;
	rmlSP = tmp1054;
	RML_TAILCALLQ(Trans__list_5fappend6,6);}}}}}}}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__trans_5fcomparison)
{

	{ void *tmp394 = rmlSC;
	{ void *tmp393 = rmlFC;
	{ void *tmp1016 = rmlSP;
	{ void *tmp395 = rmlA0;
	{ void *tmp396 = rmlA1;
	{ void *tmp624 = RML_FETCH(RML_UNTAGPTR(tmp395));
	switch( (rml_sint_t)tmp624 ) {
	case RML_STRUCTHDR(3,3):
	{ void *tmp625 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp395), 3));
	{ void *tmp626 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp395), 2));
	{ void *tmp627 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp395), 1));
	RML_STORE(RML_OFFSET(tmp1016, -1), tmp625);
	RML_STORE(RML_OFFSET(tmp1016, -2), tmp393);
	RML_STORE(RML_OFFSET(tmp1016, -3), tmp626);
	RML_STORE(RML_OFFSET(tmp1016, -4), tmp396);
	RML_STORE(RML_OFFSET(tmp1016, -5), tmp394);
	RML_STORE(RML_OFFSET(tmp1016, -6), RML_LABVAL(Trans_2dsclam701));
	rmlA0 = tmp627;
	rmlSC = RML_OFFSET(tmp1016, -6);
	rmlSP = RML_OFFSET(tmp1016, -6);
	RML_TAILCALLQ(Trans__trans_5fexpr,1);}}}
	default:
	RML_TAILCALL(RML_FETCH(tmp393),0);
	}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam701)
{

	{ void *tmp1019 = rmlSC;
	{ void *tmp394 = RML_FETCH(RML_OFFSET(tmp1019, 1));
	{ void *tmp396 = RML_FETCH(RML_OFFSET(tmp1019, 2));
	{ void *tmp626 = RML_FETCH(RML_OFFSET(tmp1019, 3));
	{ void *tmp393 = RML_FETCH(RML_OFFSET(tmp1019, 4));
	{ void *tmp625 = RML_FETCH(RML_OFFSET(tmp1019, 5));
	{ void *tmp1018 = RML_OFFSET(tmp1019, 6);
	{ void *tmp629 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1018, -1), tmp626);
	RML_STORE(RML_OFFSET(tmp1018, -2), tmp396);
	RML_STORE(RML_OFFSET(tmp1018, -3), tmp629);
	RML_STORE(RML_OFFSET(tmp1018, -4), tmp394);
	RML_STORE(RML_OFFSET(tmp1018, -5), tmp393);
	RML_STORE(RML_OFFSET(tmp1018, -6), RML_LABVAL(Trans_2dsclam700));
	rmlA0 = tmp625;
	rmlFC = tmp393;
	rmlSC = RML_OFFSET(tmp1018, -6);
	rmlSP = RML_OFFSET(tmp1018, -6);
	RML_TAILCALLQ(Trans__trans_5fexpr,1);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam700)
{

	{ void *tmp1022 = rmlSC;
	{ void *tmp393 = RML_FETCH(RML_OFFSET(tmp1022, 1));
	{ void *tmp394 = RML_FETCH(RML_OFFSET(tmp1022, 2));
	{ void *tmp629 = RML_FETCH(RML_OFFSET(tmp1022, 3));
	{ void *tmp396 = RML_FETCH(RML_OFFSET(tmp1022, 4));
	{ void *tmp626 = RML_FETCH(RML_OFFSET(tmp1022, 5));
	{ void *tmp1021 = RML_OFFSET(tmp1022, 6);
	{ void *tmp634 = rmlA0;
	{ void *tmp676 = RML_FETCH(RML_UNTAGPTR(tmp634));
	switch( (rml_sint_t)tmp676 ) {
	case RML_STRUCTHDR(2,1):
	{ void *tmp677 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp634), 2));
	{ void *tmp678 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp634), 1));
	{ void *tmp679 = RML_FETCH(RML_UNTAGPTR(tmp678));
	switch( (rml_sint_t)tmp679 ) {
	case RML_STRUCTHDR(1,3):
	{ void *tmp680 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp678), 1));
	{ void *tmp681 = RML_FETCH(RML_UNTAGPTR(tmp677));
	switch( (rml_sint_t)tmp681 ) {
	case RML_STRUCTHDR(0,0):
	RML_STORE(RML_OFFSET(tmp1021, -1), tmp393);
	RML_STORE(RML_OFFSET(tmp1021, -2), tmp634);
	RML_STORE(RML_OFFSET(tmp1021, -3), tmp394);
	RML_STORE(RML_OFFSET(tmp1021, -4), tmp629);
	RML_STORE(RML_OFFSET(tmp1021, -5), tmp396);
	RML_STORE(RML_OFFSET(tmp1021, -6), tmp626);
	RML_STORE(RML_OFFSET(tmp1021, -7), RML_LABVAL(Trans_2dfclam683));
	{ void *tmp682 = RML_OFFSET(tmp1021, -7);
	RML_STORE(RML_OFFSET(tmp1021, -8), tmp680);
	RML_STORE(RML_OFFSET(tmp1021, -9), tmp396);
	RML_STORE(RML_OFFSET(tmp1021, -10), tmp629);
	RML_STORE(RML_OFFSET(tmp1021, -11), tmp682);
	RML_STORE(RML_OFFSET(tmp1021, -12), tmp394);
	RML_STORE(RML_OFFSET(tmp1021, -13), RML_LABVAL(Trans_2dsclam699));
	rmlA0 = tmp626;
	rmlFC = tmp682;
	rmlSC = RML_OFFSET(tmp1021, -13);
	rmlSP = RML_OFFSET(tmp1021, -13);
	RML_TAILCALLQ(Trans__trans_5frelop,1);}
	default:
	rmlA5 = tmp634;
	rmlA4 = tmp393;
	rmlA3 = tmp626;
	rmlA2 = tmp396;
	rmlA1 = tmp629;
	rmlA0 = tmp394;
	rmlSP = tmp1021;
	RML_TAILCALLQ(Trans_2dlab675,6);
	}}}
	default:
	rmlA5 = tmp634;
	rmlA4 = tmp393;
	rmlA3 = tmp626;
	rmlA2 = tmp396;
	rmlA1 = tmp629;
	rmlA0 = tmp394;
	rmlSP = tmp1021;
	RML_TAILCALLQ(Trans_2dlab675,6);
	}}}}
	default:
	rmlA5 = tmp634;
	rmlA4 = tmp393;
	rmlA3 = tmp626;
	rmlA2 = tmp396;
	rmlA1 = tmp629;
	rmlA0 = tmp394;
	rmlSP = tmp1021;
	RML_TAILCALLQ(Trans_2dlab675,6);
	}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam699)
{
	void *tmp1034;
	RML_ALLOC(tmp1034,12,1,Trans_2dsclam699);
	{ void *tmp1036 = rmlSC;
	{ void *tmp394 = RML_FETCH(RML_OFFSET(tmp1036, 1));
	{ void *tmp682 = RML_FETCH(RML_OFFSET(tmp1036, 2));
	{ void *tmp629 = RML_FETCH(RML_OFFSET(tmp1036, 3));
	{ void *tmp396 = RML_FETCH(RML_OFFSET(tmp1036, 4));
	{ void *tmp680 = RML_FETCH(RML_OFFSET(tmp1036, 5));
	{ void *tmp1035 = RML_OFFSET(tmp1036, 6);
	{ void *tmp685 = rmlA0;
	RML_STORE(tmp1034, RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp1034, 1), RML_IMMEDIATE(RML_TAGFIXNUM(1)));
	RML_STORE(RML_OFFSET(tmp1034, 2), tmp680);
	{ void *tmp689 = RML_TAGPTR(tmp1034);
	RML_STORE(RML_OFFSET(tmp1034, 3), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1034, 4), tmp689);
	RML_STORE(RML_OFFSET(tmp1034, 5), RML_REFSTRUCTLIT(lit0));
	{ void *tmp690 = RML_TAGPTR(RML_OFFSET(tmp1034, 3));
	RML_STORE(RML_OFFSET(tmp1034, 6), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1034, 7), tmp685);
	RML_STORE(RML_OFFSET(tmp1034, 8), tmp396);
	{ void *tmp691 = RML_TAGPTR(RML_OFFSET(tmp1034, 6));
	RML_STORE(RML_OFFSET(tmp1034, 9), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1034, 10), tmp691);
	RML_STORE(RML_OFFSET(tmp1034, 11), RML_REFSTRUCTLIT(lit0));
	{ void *tmp692 = RML_TAGPTR(RML_OFFSET(tmp1034, 9));
	rmlA2 = tmp692;
	rmlA1 = tmp690;
	rmlA0 = tmp629;
	rmlFC = tmp682;
	rmlSC = tmp394;
	rmlSP = tmp1035;
	RML_TAILCALLQ(Trans__list_5fappend3,3);}}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dfclam683)
{

	{ void *tmp1033 = rmlFC;
	{ void *tmp626 = RML_FETCH(RML_OFFSET(tmp1033, 1));
	{ void *tmp396 = RML_FETCH(RML_OFFSET(tmp1033, 2));
	{ void *tmp629 = RML_FETCH(RML_OFFSET(tmp1033, 3));
	{ void *tmp394 = RML_FETCH(RML_OFFSET(tmp1033, 4));
	{ void *tmp634 = RML_FETCH(RML_OFFSET(tmp1033, 5));
	{ void *tmp393 = RML_FETCH(RML_OFFSET(tmp1033, 6));
	{ void *tmp1032 = RML_OFFSET(tmp1033, 7);
	rmlA5 = tmp634;
	rmlA4 = tmp393;
	rmlA3 = tmp626;
	rmlA2 = tmp396;
	rmlA1 = tmp629;
	rmlA0 = tmp394;
	rmlSP = tmp1032;
	RML_TAILCALLQ(Trans_2dlab675,6);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dlab675)
{

	{ void *tmp1024 = rmlSP;
	{ void *tmp394 = rmlA0;
	{ void *tmp629 = rmlA1;
	{ void *tmp396 = rmlA2;
	{ void *tmp626 = rmlA3;
	{ void *tmp649 = rmlA4;
	{ void *tmp650 = rmlA5;
	RML_STORE(RML_OFFSET(tmp1024, -1), tmp649);
	RML_STORE(RML_OFFSET(tmp1024, -2), tmp396);
	RML_STORE(RML_OFFSET(tmp1024, -3), tmp629);
	RML_STORE(RML_OFFSET(tmp1024, -4), tmp650);
	RML_STORE(RML_OFFSET(tmp1024, -5), tmp394);
	RML_STORE(RML_OFFSET(tmp1024, -6), RML_LABVAL(Trans_2dsclam674));
	rmlA0 = tmp626;
	rmlFC = tmp649;
	rmlSC = RML_OFFSET(tmp1024, -6);
	rmlSP = RML_OFFSET(tmp1024, -6);
	RML_TAILCALLQ(Trans__trans_5frelop,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam674)
{

	{ void *tmp1027 = rmlSC;
	{ void *tmp394 = RML_FETCH(RML_OFFSET(tmp1027, 1));
	{ void *tmp650 = RML_FETCH(RML_OFFSET(tmp1027, 2));
	{ void *tmp629 = RML_FETCH(RML_OFFSET(tmp1027, 3));
	{ void *tmp396 = RML_FETCH(RML_OFFSET(tmp1027, 4));
	{ void *tmp649 = RML_FETCH(RML_OFFSET(tmp1027, 5));
	{ void *tmp1026 = RML_OFFSET(tmp1027, 6);
	{ void *tmp652 = rmlA0;
	RML_STORE(RML_OFFSET(tmp1026, -1), tmp652);
	RML_STORE(RML_OFFSET(tmp1026, -2), tmp396);
	RML_STORE(RML_OFFSET(tmp1026, -3), tmp629);
	RML_STORE(RML_OFFSET(tmp1026, -4), tmp650);
	RML_STORE(RML_OFFSET(tmp1026, -5), tmp649);
	RML_STORE(RML_OFFSET(tmp1026, -6), tmp394);
	RML_STORE(RML_OFFSET(tmp1026, -7), RML_LABVAL(Trans_2dsclam673));
	rmlFC = tmp649;
	rmlSC = RML_OFFSET(tmp1026, -7);
	rmlSP = RML_OFFSET(tmp1026, -7);
	RML_TAILCALLQ(Trans__gentemp,0);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans_2dsclam673)
{
	void *tmp1028;
	RML_ALLOC(tmp1028,17,1,Trans_2dsclam673);
	{ void *tmp1030 = rmlSC;
	{ void *tmp394 = RML_FETCH(RML_OFFSET(tmp1030, 1));
	{ void *tmp649 = RML_FETCH(RML_OFFSET(tmp1030, 2));
	{ void *tmp650 = RML_FETCH(RML_OFFSET(tmp1030, 3));
	{ void *tmp629 = RML_FETCH(RML_OFFSET(tmp1030, 4));
	{ void *tmp396 = RML_FETCH(RML_OFFSET(tmp1030, 5));
	{ void *tmp652 = RML_FETCH(RML_OFFSET(tmp1030, 6));
	{ void *tmp1029 = RML_OFFSET(tmp1030, 7);
	{ void *tmp657 = rmlA0;
	RML_STORE(tmp1028, RML_IMMEDIATE(RML_STRUCTHDR(1,4)));
	RML_STORE(RML_OFFSET(tmp1028, 1), tmp657);
	{ void *tmp661 = RML_TAGPTR(tmp1028);
	RML_STORE(RML_OFFSET(tmp1028, 2), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1028, 3), tmp661);
	RML_STORE(RML_OFFSET(tmp1028, 4), RML_REFSTRUCTLIT(lit0));
	{ void *tmp662 = RML_TAGPTR(RML_OFFSET(tmp1028, 2));
	RML_STORE(RML_OFFSET(tmp1028, 5), RML_IMMEDIATE(RML_STRUCTHDR(2,0)));
	RML_STORE(RML_OFFSET(tmp1028, 6), RML_IMMEDIATE(RML_TAGFIXNUM(1)));
	RML_STORE(RML_OFFSET(tmp1028, 7), tmp657);
	{ void *tmp663 = RML_TAGPTR(RML_OFFSET(tmp1028, 5));
	RML_STORE(RML_OFFSET(tmp1028, 8), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1028, 9), tmp663);
	RML_STORE(RML_OFFSET(tmp1028, 10), RML_REFSTRUCTLIT(lit0));
	{ void *tmp664 = RML_TAGPTR(RML_OFFSET(tmp1028, 8));
	RML_STORE(RML_OFFSET(tmp1028, 11), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1028, 12), tmp652);
	RML_STORE(RML_OFFSET(tmp1028, 13), tmp396);
	{ void *tmp665 = RML_TAGPTR(RML_OFFSET(tmp1028, 11));
	RML_STORE(RML_OFFSET(tmp1028, 14), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp1028, 15), tmp665);
	RML_STORE(RML_OFFSET(tmp1028, 16), RML_REFSTRUCTLIT(lit0));
	{ void *tmp666 = RML_TAGPTR(RML_OFFSET(tmp1028, 14));
	rmlA4 = tmp666;
	rmlA3 = tmp664;
	rmlA2 = tmp650;
	rmlA1 = tmp662;
	rmlA0 = tmp629;
	rmlFC = tmp649;
	rmlSC = tmp394;
	rmlSP = tmp1029;
	RML_TAILCALLQ(Trans__list_5fappend5,5);}}}}}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__trans_5frelop)
{

	{ void *tmp391 = rmlSC;
	{ void *tmp392 = rmlA0;
	switch( RML_UNTAGFIXNUM(tmp392) ) {
	case 3:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	RML_TAILCALL(RML_FETCH(tmp391),1);
	case 1:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(3));
	RML_TAILCALL(RML_FETCH(tmp391),1);
	case 5:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(5));
	RML_TAILCALL(RML_FETCH(tmp391),1);
	case 4:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(2));
	RML_TAILCALL(RML_FETCH(tmp391),1);
	case 2:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(4));
	RML_TAILCALL(RML_FETCH(tmp391),1);
	/*case 0*/
	default:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	RML_TAILCALL(RML_FETCH(tmp391),1);
	}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Trans__trans_5fbinop)
{

	{ void *tmp385 = rmlSC;
	{ void *tmp386 = rmlA0;
	switch( RML_UNTAGFIXNUM(tmp386) ) {
	case 1:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	RML_TAILCALL(RML_FETCH(tmp385),1);
	case 3:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(3));
	RML_TAILCALL(RML_FETCH(tmp385),1);
	case 2:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(2));
	RML_TAILCALL(RML_FETCH(tmp385),1);
	/*case 0*/
	default:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	RML_TAILCALL(RML_FETCH(tmp385),1);
	}}}
}
RML_END_LABEL
