/* module Env */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Env")
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fin02);
extern RML_FORWARD_LABEL(RML__debug);
extern RML_FORWARD_LABEL(RML__debug_5fpush_5fout01);

RML_FORWARD_LABEL(Env__initial);
static RML_FORWARD_LABEL(Env_2dsclam178);
static RML_FORWARD_LABEL(Env_2dsclam177);
RML_FORWARD_LABEL(Env__lookup);
static RML_FORWARD_LABEL(Env_2dsclam211);
static RML_FORWARD_LABEL(Env_2dsclam210);
static RML_FORWARD_LABEL(Env_2dsclam207);
static RML_FORWARD_LABEL(Env_2dsclam206);
RML_FORWARD_LABEL(Env__lookuptype);
static RML_FORWARD_LABEL(Env_2dsclam244);
static RML_FORWARD_LABEL(Env_2dsclam243);
static RML_FORWARD_LABEL(Env_2dsclam240);
static RML_FORWARD_LABEL(Env_2dsclam239);
RML_FORWARD_LABEL(Env__update);
static RML_FORWARD_LABEL(Env_2dsclam264);
static RML_FORWARD_LABEL(Env_2dsclam263);
static RML_FORWARD_LABEL(Env_2dsclam262);

static const RML_DEFSTRINGLIT(lit0,7,"env.rml");
static const RML_DEFSTRINGLIT(lit1,6,"update");
static const RML_DEFSTRINGLIT(lit2,29,"let:newenv=[BIND(id,ty,v),env");
static const RML_DEFSTRINGLIT(lit3,6,"newenv");
static const RML_DEFSTRINGLIT(lit4,18,"[BIND(id,ty,v),env");
static const RML_DEFSTRINGLIT(lit5,10,"lookuptype");
static const RML_DEFSTRINGLIT(lit6,14,"equal:id=idenv");
static const RML_DEFSTRINGLIT(lit7,2,"id");
static const RML_DEFSTRINGLIT(lit8,5,"idenv");
static const RML_DEFSTRINGLIT(lit9,4,"rest");
static const RML_DEFSTRINGLIT(lit10,31,"call:lookuptype(rest,id) => (t)");
static const RML_DEFSTRINGLIT(lit11,6,"lookup");
static const RML_DEFSTRINGLIT(lit12,27,"call:lookup(rest,id) => (v)");
static const RML_DEFSTRINGLIT(lit13,7,"initial");
static const RML_DEFSTRINGLIT(lit14,96,"axiom:initial() => ([BIND(\"false\",BOOLTYPE,BOOLVAL(false)),BIND(\"true\",BOOLTYPE,BOOLVAL(true))])");
static const RML_DEFSTRINGLIT(lit15,75,"[BIND(\"false\",BOOLTYPE,BOOLVAL(false)),BIND(\"true\",BOOLTYPE,BOOLVAL(true))]");
static const RML_DEFSTRINGLIT(lit16,5,"false");
static const RML_DEFSTRUCTLIT(lit17,1,2) {RML_IMMEDIATE(RML_TAGFIXNUM(0))}};
static const RML_DEFSTRUCTLIT(lit18,3,0) {RML_REFSTRINGLIT(lit16),RML_IMMEDIATE(RML_TAGFIXNUM(2)),RML_REFSTRUCTLIT(lit17)}};
static const RML_DEFSTRINGLIT(lit19,4,"true");
static const RML_DEFSTRUCTLIT(lit20,1,2) {RML_IMMEDIATE(RML_TAGFIXNUM(1))}};
static const RML_DEFSTRUCTLIT(lit21,3,0) {RML_REFSTRINGLIT(lit19),RML_IMMEDIATE(RML_TAGFIXNUM(2)),RML_REFSTRUCTLIT(lit20)}};
static const RML_DEFSTRUCT0LIT(lit22,0);
static const RML_DEFSTRUCTLIT(lit23,2,1) {RML_REFSTRUCTLIT(lit21),RML_REFSTRUCTLIT(lit22)}};
static const RML_DEFSTRUCTLIT(lit24,2,1) {RML_REFSTRUCTLIT(lit18),RML_REFSTRUCTLIT(lit23)}};

extern void RML_5finit(void);

void Env_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	RML_5finit();
	rmldb_load_db("env.rdb");
}

RML_BEGIN_LABEL(Env__initial)
{

	{ void *tmp162 = rmlSC;
	{ void *tmp161 = rmlFC;
	{ void *tmp305 = rmlSP;
	RML_STORE(RML_OFFSET(tmp305, -1), tmp161);
	RML_STORE(RML_OFFSET(tmp305, -2), tmp162);
	RML_STORE(RML_OFFSET(tmp305, -3), RML_LABVAL(Env_2dsclam178));
	rmlA6 = RML_REFSTRINGLIT(lit14);
	rmlA5 = RML_REFSTRINGLIT(lit13);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(58));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(26));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(3));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(25));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp305, -3);
	rmlSP = RML_OFFSET(tmp305, -3);
	RML_TAILCALLQ(RML__debug,7);}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam178)
{

	{ void *tmp308 = rmlSC;
	{ void *tmp162 = RML_FETCH(RML_OFFSET(tmp308, 1));
	{ void *tmp161 = RML_FETCH(RML_OFFSET(tmp308, 2));
	{ void *tmp307 = RML_OFFSET(tmp308, 3);
	RML_STORE(RML_OFFSET(tmp307, -1), tmp162);
	RML_STORE(RML_OFFSET(tmp307, -2), RML_LABVAL(Env_2dsclam177));
	rmlA1 = RML_REFSTRUCTLIT(lit24);
	rmlA0 = RML_REFSTRINGLIT(lit15);
	rmlFC = tmp161;
	rmlSC = RML_OFFSET(tmp307, -2);
	rmlSP = RML_OFFSET(tmp307, -2);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam177)
{

	{ void *tmp311 = rmlSC;
	{ void *tmp162 = RML_FETCH(RML_OFFSET(tmp311, 1));
	{ void *tmp310 = RML_OFFSET(tmp311, 2);
	rmlA0 = RML_REFSTRUCTLIT(lit24);
	rmlSC = tmp162;
	rmlSP = tmp310;
	RML_TAILCALL(RML_FETCH(tmp162),1);}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Env__lookup)
{

	{ void *tmp158 = rmlSC;
	{ void *tmp157 = rmlFC;
	{ void *tmp291 = rmlSP;
	{ void *tmp159 = rmlA0;
	{ void *tmp160 = rmlA1;
	{ void *tmp189 = RML_FETCH(RML_UNTAGPTR(tmp159));
	switch( (rml_sint_t)tmp189 ) {
	case RML_STRUCTHDR(2,1):
	{ void *tmp190 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp159), 2));
	{ void *tmp191 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp159), 1));
	{ void *tmp192 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp191), 3));
	{ void *tmp193 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp191), 1));
	RML_STORE(RML_OFFSET(tmp291, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp291, -2), tmp193);
	RML_STORE(RML_OFFSET(tmp291, -3), tmp157);
	RML_STORE(RML_OFFSET(tmp291, -4), tmp190);
	RML_STORE(RML_OFFSET(tmp291, -5), tmp158);
	RML_STORE(RML_OFFSET(tmp291, -6), tmp192);
	RML_STORE(RML_OFFSET(tmp291, -7), RML_LABVAL(Env_2dsclam211));
	rmlA6 = RML_REFSTRINGLIT(lit6);
	rmlA5 = RML_REFSTRINGLIT(lit11);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(18));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(31));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(31));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp291, -7);
	rmlSP = RML_OFFSET(tmp291, -7);
	RML_TAILCALLQ(RML__debug,7);}}}}
	default:
	RML_TAILCALL(RML_FETCH(tmp157),0);
	}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam211)
{

	{ void *tmp294 = rmlSC;
	{ void *tmp192 = RML_FETCH(RML_OFFSET(tmp294, 1));
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp294, 2));
	{ void *tmp190 = RML_FETCH(RML_OFFSET(tmp294, 3));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp294, 4));
	{ void *tmp193 = RML_FETCH(RML_OFFSET(tmp294, 5));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp294, 6));
	{ void *tmp293 = RML_OFFSET(tmp294, 7);
	RML_STORE(RML_OFFSET(tmp293, -1), tmp160);
	RML_STORE(RML_OFFSET(tmp293, -2), tmp193);
	RML_STORE(RML_OFFSET(tmp293, -3), tmp190);
	RML_STORE(RML_OFFSET(tmp293, -4), tmp157);
	RML_STORE(RML_OFFSET(tmp293, -5), tmp158);
	RML_STORE(RML_OFFSET(tmp293, -6), tmp192);
	RML_STORE(RML_OFFSET(tmp293, -7), RML_LABVAL(Env_2dsclam210));
	rmlA3 = tmp193;
	rmlA2 = RML_REFSTRINGLIT(lit8);
	rmlA1 = tmp160;
	rmlA0 = RML_REFSTRINGLIT(lit7);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp293, -7);
	rmlSP = RML_OFFSET(tmp293, -7);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam210)
{

	{ void *tmp297 = rmlSC;
	{ void *tmp192 = RML_FETCH(RML_OFFSET(tmp297, 1));
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp297, 2));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp297, 3));
	{ void *tmp190 = RML_FETCH(RML_OFFSET(tmp297, 4));
	{ void *tmp193 = RML_FETCH(RML_OFFSET(tmp297, 5));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp297, 6));
	{ void *tmp296 = RML_OFFSET(tmp297, 7);
	{ void *tmp196 = rml_prim_marker();
	{ void *tmp209 = rml_prim_equal(tmp160, tmp193);
	switch( (rml_sint_t)tmp209 ) {
	case RML_TAGFIXNUM(0):
	rml_prim_unwind(tmp196);
	RML_STORE(RML_OFFSET(tmp296, -1), tmp157);
	RML_STORE(RML_OFFSET(tmp296, -2), tmp190);
	RML_STORE(RML_OFFSET(tmp296, -3), tmp160);
	RML_STORE(RML_OFFSET(tmp296, -4), tmp158);
	RML_STORE(RML_OFFSET(tmp296, -5), RML_LABVAL(Env_2dsclam207));
	rmlA3 = tmp160;
	rmlA2 = RML_REFSTRINGLIT(lit7);
	rmlA1 = tmp190;
	rmlA0 = RML_REFSTRINGLIT(lit9);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp296, -5);
	rmlSP = RML_OFFSET(tmp296, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);
	default:
	rmlA0 = tmp192;
	rmlSC = tmp158;
	rmlSP = tmp296;
	RML_TAILCALL(RML_FETCH(tmp158),1);
	}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam207)
{

	{ void *tmp300 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp300, 1));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp300, 2));
	{ void *tmp190 = RML_FETCH(RML_OFFSET(tmp300, 3));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp300, 4));
	{ void *tmp299 = RML_OFFSET(tmp300, 5);
	RML_STORE(RML_OFFSET(tmp299, -1), tmp190);
	RML_STORE(RML_OFFSET(tmp299, -2), tmp160);
	RML_STORE(RML_OFFSET(tmp299, -3), tmp157);
	RML_STORE(RML_OFFSET(tmp299, -4), tmp158);
	RML_STORE(RML_OFFSET(tmp299, -5), RML_LABVAL(Env_2dsclam206));
	rmlA6 = RML_REFSTRINGLIT(lit12);
	rmlA5 = RML_REFSTRINGLIT(lit11);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(40));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(35));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(26));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(35));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlFC = tmp157;
	rmlSC = RML_OFFSET(tmp299, -5);
	rmlSP = RML_OFFSET(tmp299, -5);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam206)
{

	{ void *tmp303 = rmlSC;
	{ void *tmp158 = RML_FETCH(RML_OFFSET(tmp303, 1));
	{ void *tmp157 = RML_FETCH(RML_OFFSET(tmp303, 2));
	{ void *tmp160 = RML_FETCH(RML_OFFSET(tmp303, 3));
	{ void *tmp190 = RML_FETCH(RML_OFFSET(tmp303, 4));
	{ void *tmp302 = RML_OFFSET(tmp303, 5);
	rmlA1 = tmp160;
	rmlA0 = tmp190;
	rmlFC = tmp157;
	rmlSC = tmp158;
	rmlSP = tmp302;
	RML_TAILCALLQ(Env__lookup,2);}}}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Env__lookuptype)
{

	{ void *tmp154 = rmlSC;
	{ void *tmp153 = rmlFC;
	{ void *tmp277 = rmlSP;
	{ void *tmp155 = rmlA0;
	{ void *tmp156 = rmlA1;
	{ void *tmp222 = RML_FETCH(RML_UNTAGPTR(tmp155));
	switch( (rml_sint_t)tmp222 ) {
	case RML_STRUCTHDR(2,1):
	{ void *tmp223 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp155), 2));
	{ void *tmp224 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp155), 1));
	{ void *tmp225 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp224), 2));
	{ void *tmp226 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp224), 1));
	RML_STORE(RML_OFFSET(tmp277, -1), tmp156);
	RML_STORE(RML_OFFSET(tmp277, -2), tmp226);
	RML_STORE(RML_OFFSET(tmp277, -3), tmp153);
	RML_STORE(RML_OFFSET(tmp277, -4), tmp223);
	RML_STORE(RML_OFFSET(tmp277, -5), tmp154);
	RML_STORE(RML_OFFSET(tmp277, -6), tmp225);
	RML_STORE(RML_OFFSET(tmp277, -7), RML_LABVAL(Env_2dsclam244));
	rmlA6 = RML_REFSTRINGLIT(lit6);
	rmlA5 = RML_REFSTRINGLIT(lit5);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(18));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(43));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(43));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp277, -7);
	rmlSP = RML_OFFSET(tmp277, -7);
	RML_TAILCALLQ(RML__debug,7);}}}}
	default:
	RML_TAILCALL(RML_FETCH(tmp153),0);
	}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam244)
{

	{ void *tmp280 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp280, 1));
	{ void *tmp154 = RML_FETCH(RML_OFFSET(tmp280, 2));
	{ void *tmp223 = RML_FETCH(RML_OFFSET(tmp280, 3));
	{ void *tmp153 = RML_FETCH(RML_OFFSET(tmp280, 4));
	{ void *tmp226 = RML_FETCH(RML_OFFSET(tmp280, 5));
	{ void *tmp156 = RML_FETCH(RML_OFFSET(tmp280, 6));
	{ void *tmp279 = RML_OFFSET(tmp280, 7);
	RML_STORE(RML_OFFSET(tmp279, -1), tmp156);
	RML_STORE(RML_OFFSET(tmp279, -2), tmp226);
	RML_STORE(RML_OFFSET(tmp279, -3), tmp223);
	RML_STORE(RML_OFFSET(tmp279, -4), tmp153);
	RML_STORE(RML_OFFSET(tmp279, -5), tmp154);
	RML_STORE(RML_OFFSET(tmp279, -6), tmp225);
	RML_STORE(RML_OFFSET(tmp279, -7), RML_LABVAL(Env_2dsclam243));
	rmlA3 = tmp226;
	rmlA2 = RML_REFSTRINGLIT(lit8);
	rmlA1 = tmp156;
	rmlA0 = RML_REFSTRINGLIT(lit7);
	rmlFC = tmp153;
	rmlSC = RML_OFFSET(tmp279, -7);
	rmlSP = RML_OFFSET(tmp279, -7);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam243)
{

	{ void *tmp283 = rmlSC;
	{ void *tmp225 = RML_FETCH(RML_OFFSET(tmp283, 1));
	{ void *tmp154 = RML_FETCH(RML_OFFSET(tmp283, 2));
	{ void *tmp153 = RML_FETCH(RML_OFFSET(tmp283, 3));
	{ void *tmp223 = RML_FETCH(RML_OFFSET(tmp283, 4));
	{ void *tmp226 = RML_FETCH(RML_OFFSET(tmp283, 5));
	{ void *tmp156 = RML_FETCH(RML_OFFSET(tmp283, 6));
	{ void *tmp282 = RML_OFFSET(tmp283, 7);
	{ void *tmp229 = rml_prim_marker();
	{ void *tmp242 = rml_prim_equal(tmp156, tmp226);
	switch( (rml_sint_t)tmp242 ) {
	case RML_TAGFIXNUM(0):
	rml_prim_unwind(tmp229);
	RML_STORE(RML_OFFSET(tmp282, -1), tmp153);
	RML_STORE(RML_OFFSET(tmp282, -2), tmp223);
	RML_STORE(RML_OFFSET(tmp282, -3), tmp156);
	RML_STORE(RML_OFFSET(tmp282, -4), tmp154);
	RML_STORE(RML_OFFSET(tmp282, -5), RML_LABVAL(Env_2dsclam240));
	rmlA3 = tmp156;
	rmlA2 = RML_REFSTRINGLIT(lit7);
	rmlA1 = tmp223;
	rmlA0 = RML_REFSTRINGLIT(lit9);
	rmlFC = tmp153;
	rmlSC = RML_OFFSET(tmp282, -5);
	rmlSP = RML_OFFSET(tmp282, -5);
	RML_TAILCALLQ(RML__debug_5fpush_5fin02,4);
	default:
	rmlA0 = tmp225;
	rmlSC = tmp154;
	rmlSP = tmp282;
	RML_TAILCALL(RML_FETCH(tmp154),1);
	}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam240)
{

	{ void *tmp286 = rmlSC;
	{ void *tmp154 = RML_FETCH(RML_OFFSET(tmp286, 1));
	{ void *tmp156 = RML_FETCH(RML_OFFSET(tmp286, 2));
	{ void *tmp223 = RML_FETCH(RML_OFFSET(tmp286, 3));
	{ void *tmp153 = RML_FETCH(RML_OFFSET(tmp286, 4));
	{ void *tmp285 = RML_OFFSET(tmp286, 5);
	RML_STORE(RML_OFFSET(tmp285, -1), tmp223);
	RML_STORE(RML_OFFSET(tmp285, -2), tmp156);
	RML_STORE(RML_OFFSET(tmp285, -3), tmp153);
	RML_STORE(RML_OFFSET(tmp285, -4), tmp154);
	RML_STORE(RML_OFFSET(tmp285, -5), RML_LABVAL(Env_2dsclam239));
	rmlA6 = RML_REFSTRINGLIT(lit10);
	rmlA5 = RML_REFSTRINGLIT(lit5);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(44));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(47));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(26));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(47));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlFC = tmp153;
	rmlSC = RML_OFFSET(tmp285, -5);
	rmlSP = RML_OFFSET(tmp285, -5);
	RML_TAILCALLQ(RML__debug,7);}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam239)
{

	{ void *tmp289 = rmlSC;
	{ void *tmp154 = RML_FETCH(RML_OFFSET(tmp289, 1));
	{ void *tmp153 = RML_FETCH(RML_OFFSET(tmp289, 2));
	{ void *tmp156 = RML_FETCH(RML_OFFSET(tmp289, 3));
	{ void *tmp223 = RML_FETCH(RML_OFFSET(tmp289, 4));
	{ void *tmp288 = RML_OFFSET(tmp289, 5);
	rmlA1 = tmp156;
	rmlA0 = tmp223;
	rmlFC = tmp153;
	rmlSC = tmp154;
	rmlSP = tmp288;
	RML_TAILCALLQ(Env__lookuptype,2);}}}}}}
}
RML_END_LABEL

RML_BEGIN_LABEL(Env__update)
{

	{ void *tmp148 = rmlSC;
	{ void *tmp147 = rmlFC;
	{ void *tmp266 = rmlSP;
	{ void *tmp149 = rmlA0;
	{ void *tmp150 = rmlA1;
	{ void *tmp151 = rmlA2;
	{ void *tmp152 = rmlA3;
	RML_STORE(RML_OFFSET(tmp266, -1), tmp150);
	RML_STORE(RML_OFFSET(tmp266, -2), tmp151);
	RML_STORE(RML_OFFSET(tmp266, -3), tmp152);
	RML_STORE(RML_OFFSET(tmp266, -4), tmp149);
	RML_STORE(RML_OFFSET(tmp266, -5), tmp147);
	RML_STORE(RML_OFFSET(tmp266, -6), tmp148);
	RML_STORE(RML_OFFSET(tmp266, -7), RML_LABVAL(Env_2dsclam264));
	rmlA6 = RML_REFSTRINGLIT(lit2);
	rmlA5 = RML_REFSTRINGLIT(lit1);
	rmlA4 = RML_IMMEDIATE(RML_TAGFIXNUM(41));
	rmlA3 = RML_IMMEDIATE(RML_TAGFIXNUM(56));
	rmlA2 = RML_IMMEDIATE(RML_TAGFIXNUM(9));
	rmlA1 = RML_IMMEDIATE(RML_TAGFIXNUM(56));
	rmlA0 = RML_REFSTRINGLIT(lit0);
	rmlSC = RML_OFFSET(tmp266, -7);
	rmlSP = RML_OFFSET(tmp266, -7);
	RML_TAILCALLQ(RML__debug,7);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam264)
{
	void *tmp267;
	RML_ALLOC(tmp267,7,0,Env_2dsclam264);
	{ void *tmp269 = rmlSC;
	{ void *tmp148 = RML_FETCH(RML_OFFSET(tmp269, 1));
	{ void *tmp147 = RML_FETCH(RML_OFFSET(tmp269, 2));
	{ void *tmp149 = RML_FETCH(RML_OFFSET(tmp269, 3));
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp269, 4));
	{ void *tmp151 = RML_FETCH(RML_OFFSET(tmp269, 5));
	{ void *tmp150 = RML_FETCH(RML_OFFSET(tmp269, 6));
	{ void *tmp268 = RML_OFFSET(tmp269, 7);
	RML_STORE(tmp267, RML_IMMEDIATE(RML_STRUCTHDR(3,0)));
	RML_STORE(RML_OFFSET(tmp267, 1), tmp150);
	RML_STORE(RML_OFFSET(tmp267, 2), tmp151);
	RML_STORE(RML_OFFSET(tmp267, 3), tmp152);
	{ void *tmp252 = RML_TAGPTR(tmp267);
	RML_STORE(RML_OFFSET(tmp267, 4), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp267, 5), tmp252);
	RML_STORE(RML_OFFSET(tmp267, 6), tmp149);
	{ void *tmp253 = RML_TAGPTR(RML_OFFSET(tmp267, 4));
	RML_STORE(RML_OFFSET(tmp268, -1), tmp150);
	RML_STORE(RML_OFFSET(tmp268, -2), tmp151);
	RML_STORE(RML_OFFSET(tmp268, -3), tmp152);
	RML_STORE(RML_OFFSET(tmp268, -4), tmp149);
	RML_STORE(RML_OFFSET(tmp268, -5), tmp147);
	RML_STORE(RML_OFFSET(tmp268, -6), tmp148);
	RML_STORE(RML_OFFSET(tmp268, -7), tmp253);
	RML_STORE(RML_OFFSET(tmp268, -8), RML_LABVAL(Env_2dsclam263));
	rmlA1 = tmp253;
	rmlA0 = RML_REFSTRINGLIT(lit3);
	rmlFC = tmp147;
	rmlSC = RML_OFFSET(tmp268, -8);
	rmlSP = RML_OFFSET(tmp268, -8);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam263)
{
	void *tmp270;
	RML_ALLOC(tmp270,7,0,Env_2dsclam263);
	{ void *tmp272 = rmlSC;
	{ void *tmp253 = RML_FETCH(RML_OFFSET(tmp272, 1));
	{ void *tmp148 = RML_FETCH(RML_OFFSET(tmp272, 2));
	{ void *tmp147 = RML_FETCH(RML_OFFSET(tmp272, 3));
	{ void *tmp149 = RML_FETCH(RML_OFFSET(tmp272, 4));
	{ void *tmp152 = RML_FETCH(RML_OFFSET(tmp272, 5));
	{ void *tmp151 = RML_FETCH(RML_OFFSET(tmp272, 6));
	{ void *tmp150 = RML_FETCH(RML_OFFSET(tmp272, 7));
	{ void *tmp271 = RML_OFFSET(tmp272, 8);
	RML_STORE(tmp270, RML_IMMEDIATE(RML_STRUCTHDR(3,0)));
	RML_STORE(RML_OFFSET(tmp270, 1), tmp150);
	RML_STORE(RML_OFFSET(tmp270, 2), tmp151);
	RML_STORE(RML_OFFSET(tmp270, 3), tmp152);
	{ void *tmp259 = RML_TAGPTR(tmp270);
	RML_STORE(RML_OFFSET(tmp270, 4), RML_IMMEDIATE(RML_STRUCTHDR(2,1)));
	RML_STORE(RML_OFFSET(tmp270, 5), tmp259);
	RML_STORE(RML_OFFSET(tmp270, 6), tmp149);
	{ void *tmp260 = RML_TAGPTR(RML_OFFSET(tmp270, 4));
	RML_STORE(RML_OFFSET(tmp271, -1), tmp148);
	RML_STORE(RML_OFFSET(tmp271, -2), tmp253);
	RML_STORE(RML_OFFSET(tmp271, -3), RML_LABVAL(Env_2dsclam262));
	rmlA1 = tmp260;
	rmlA0 = RML_REFSTRINGLIT(lit4);
	rmlFC = tmp147;
	rmlSC = RML_OFFSET(tmp271, -3);
	rmlSP = RML_OFFSET(tmp271, -3);
	RML_TAILCALLQ(RML__debug_5fpush_5fout01,2);}}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Env_2dsclam262)
{

	{ void *tmp275 = rmlSC;
	{ void *tmp253 = RML_FETCH(RML_OFFSET(tmp275, 1));
	{ void *tmp148 = RML_FETCH(RML_OFFSET(tmp275, 2));
	{ void *tmp274 = RML_OFFSET(tmp275, 3);
	rmlA0 = tmp253;
	rmlSC = tmp148;
	rmlSP = tmp274;
	RML_TAILCALL(RML_FETCH(tmp148),1);}}}}
}
RML_END_LABEL
