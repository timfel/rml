/* module Main */
#include "rml.h"
#include <stdlib.h>
#include <stdio.h>
RML_DEFINE_MODULE("Main")
extern RML_FORWARD_LABEL(RML__string_5fappend);
extern RML_FORWARD_LABEL(LoadProgramDB__parse);
extern RML_FORWARD_LABEL(ScanParse__scanparse);
extern RML_FORWARD_LABEL(ModDump__dump);
extern RML_FORWARD_LABEL(RMLToMod__transform);
extern RML_FORWARD_LABEL(ModDump__unparse_5fstr);
extern RML_FORWARD_LABEL(RML__print);

RML_FORWARD_LABEL(Main__main);
static RML_FORWARD_LABEL(Main_2dsclam594);
static RML_FORWARD_LABEL(Main_2dsclam593);
static RML_FORWARD_LABEL(Main_2dsclam592);
static RML_FORWARD_LABEL(Main_2dsclam591);
static RML_FORWARD_LABEL(Main_2dsclam665);
static RML_FORWARD_LABEL(Main_2dsclam664);
static RML_FORWARD_LABEL(Main_2dfclam651);
static RML_FORWARD_LABEL(Main_2dsclam650);
static RML_FORWARD_LABEL(Main_2dsclam649);
static RML_FORWARD_LABEL(Main_2dfclam636);
static RML_FORWARD_LABEL(Main_2dsclam635);
static RML_FORWARD_LABEL(Main_2dfclam629);
static RML_FORWARD_LABEL(Main_2dsclam628);
static RML_FORWARD_LABEL(Main_2dfclam622);
static RML_FORWARD_LABEL(Main_2dsclam621);
static RML_FORWARD_LABEL(Main_2dsclam620);
static RML_FORWARD_LABEL(Main__is_5foption_5fset);

static const RML_DEFSTRINGLIT(lit0,4,".rdb");
static const RML_DEFSTRINGLIT(lit1,4,".rml");
static const RML_DEFSTRINGLIT(lit2,3,"ntf");
static const RML_DEFSTRINGLIT(lit3,11,"notransform");
static const RML_DEFSTRINGLIT(lit4,2,"dm");
static const RML_DEFSTRINGLIT(lit5,12,"dumpmodelica");

extern void ScanParse_5finit(void);
extern void RMLToMod_5finit(void);
extern void RMLDump_5finit(void);
extern void RML_5finit(void);
extern void RMLRefactor_5finit(void);
extern void LoadProgramDB_5finit(void);
extern void Absyn_5finit(void);
extern void ModDump_5finit(void);

void Main_5finit(void)
{
	static int done = 0;
	if( done ) return;
	done = 1;
	ScanParse_5finit();
	RMLToMod_5finit();
	RMLDump_5finit();
	RML_5finit();
	RMLRefactor_5finit();
	LoadProgramDB_5finit();
	Absyn_5finit();
	ModDump_5finit();
}

RML_BEGIN_LABEL(Main__main)
{

	{ void *tmp335 = rmlSC;
	{ void *tmp334 = rmlFC;
	{ void *tmp795 = rmlSP;
	{ void *tmp336 = rmlA0;
	{ void *tmp562 = RML_FETCH(RML_UNTAGPTR(tmp336));
	switch( (rml_sint_t)tmp562 ) {
	case RML_STRUCTHDR(2,1):
	{ void *tmp563 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp336), 2));
	{ void *tmp564 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp336), 1));
	RML_STORE(RML_OFFSET(tmp795, -1), tmp564);
	RML_STORE(RML_OFFSET(tmp795, -2), tmp334);
	RML_STORE(RML_OFFSET(tmp795, -3), tmp335);
	RML_STORE(RML_OFFSET(tmp795, -4), tmp563);
	RML_STORE(RML_OFFSET(tmp795, -5), RML_LABVAL(Main_2dsclam594));
	rmlA1 = RML_REFSTRINGLIT(lit0);
	rmlA0 = tmp564;
	rmlSC = RML_OFFSET(tmp795, -5);
	rmlSP = RML_OFFSET(tmp795, -5);
	RML_TAILCALLQ(RML__string_5fappend,2);}}
	default:
	RML_TAILCALL(RML_FETCH(tmp334),0);
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam594)
{

	{ void *tmp798 = rmlSC;
	{ void *tmp563 = RML_FETCH(RML_OFFSET(tmp798, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp798, 2));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp798, 3));
	{ void *tmp564 = RML_FETCH(RML_OFFSET(tmp798, 4));
	{ void *tmp797 = RML_OFFSET(tmp798, 5);
	{ void *tmp566 = rmlA0;
	RML_STORE(RML_OFFSET(tmp797, -1), tmp566);
	RML_STORE(RML_OFFSET(tmp797, -2), tmp334);
	RML_STORE(RML_OFFSET(tmp797, -3), tmp335);
	RML_STORE(RML_OFFSET(tmp797, -4), tmp563);
	RML_STORE(RML_OFFSET(tmp797, -5), RML_LABVAL(Main_2dsclam593));
	rmlA1 = RML_REFSTRINGLIT(lit1);
	rmlA0 = tmp564;
	rmlFC = tmp334;
	rmlSC = RML_OFFSET(tmp797, -5);
	rmlSP = RML_OFFSET(tmp797, -5);
	RML_TAILCALLQ(RML__string_5fappend,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam593)
{

	{ void *tmp801 = rmlSC;
	{ void *tmp563 = RML_FETCH(RML_OFFSET(tmp801, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp801, 2));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp801, 3));
	{ void *tmp566 = RML_FETCH(RML_OFFSET(tmp801, 4));
	{ void *tmp800 = RML_OFFSET(tmp801, 5);
	{ void *tmp571 = rmlA0;
	RML_STORE(RML_OFFSET(tmp800, -1), tmp571);
	RML_STORE(RML_OFFSET(tmp800, -2), tmp334);
	RML_STORE(RML_OFFSET(tmp800, -3), tmp335);
	RML_STORE(RML_OFFSET(tmp800, -4), tmp563);
	RML_STORE(RML_OFFSET(tmp800, -5), RML_LABVAL(Main_2dsclam592));
	rmlA0 = tmp566;
	rmlFC = tmp334;
	rmlSC = RML_OFFSET(tmp800, -5);
	rmlSP = RML_OFFSET(tmp800, -5);
	RML_TAILCALLQ(LoadProgramDB__parse,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam592)
{

	{ void *tmp804 = rmlSC;
	{ void *tmp563 = RML_FETCH(RML_OFFSET(tmp804, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp804, 2));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp804, 3));
	{ void *tmp571 = RML_FETCH(RML_OFFSET(tmp804, 4));
	{ void *tmp803 = RML_OFFSET(tmp804, 5);
	{ void *tmp576 = rmlA0;
	RML_STORE(RML_OFFSET(tmp803, -1), tmp576);
	RML_STORE(RML_OFFSET(tmp803, -2), tmp334);
	RML_STORE(RML_OFFSET(tmp803, -3), tmp335);
	RML_STORE(RML_OFFSET(tmp803, -4), tmp563);
	RML_STORE(RML_OFFSET(tmp803, -5), RML_LABVAL(Main_2dsclam591));
	rmlA0 = tmp571;
	rmlFC = tmp334;
	rmlSC = RML_OFFSET(tmp803, -5);
	rmlSP = RML_OFFSET(tmp803, -5);
	RML_TAILCALLQ(ScanParse__scanparse,1);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam591)
{

	{ void *tmp807 = rmlSC;
	{ void *tmp563 = RML_FETCH(RML_OFFSET(tmp807, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp807, 2));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp807, 3));
	{ void *tmp576 = RML_FETCH(RML_OFFSET(tmp807, 4));
	{ void *tmp806 = RML_OFFSET(tmp807, 5);
	{ void *tmp585 = rmlA0;
	{ void *tmp600 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp806, -1), tmp600);
	RML_STORE(RML_OFFSET(tmp806, -2), tmp585);
	RML_STORE(RML_OFFSET(tmp806, -3), tmp576);
	RML_STORE(RML_OFFSET(tmp806, -4), tmp334);
	RML_STORE(RML_OFFSET(tmp806, -5), tmp335);
	RML_STORE(RML_OFFSET(tmp806, -6), tmp563);
	RML_STORE(RML_OFFSET(tmp806, -7), RML_LABVAL(Main_2dfclam651));
	{ void *tmp601 = RML_OFFSET(tmp806, -7);
	RML_STORE(RML_OFFSET(tmp806, -8), tmp585);
	RML_STORE(RML_OFFSET(tmp806, -9), tmp576);
	RML_STORE(RML_OFFSET(tmp806, -10), tmp601);
	RML_STORE(RML_OFFSET(tmp806, -11), tmp335);
	RML_STORE(RML_OFFSET(tmp806, -12), RML_LABVAL(Main_2dsclam665));
	rmlA1 = RML_REFSTRINGLIT(lit5);
	rmlA0 = tmp563;
	rmlFC = tmp601;
	rmlSC = RML_OFFSET(tmp806, -12);
	rmlSP = RML_OFFSET(tmp806, -12);
	RML_TAILCALLQ(Main__is_5foption_5fset,2);}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam665)
{

	{ void *tmp840 = rmlSC;
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp840, 1));
	{ void *tmp601 = RML_FETCH(RML_OFFSET(tmp840, 2));
	{ void *tmp576 = RML_FETCH(RML_OFFSET(tmp840, 3));
	{ void *tmp585 = RML_FETCH(RML_OFFSET(tmp840, 4));
	{ void *tmp839 = RML_OFFSET(tmp840, 5);
	{ void *tmp653 = rmlA0;
	switch( (rml_sint_t)tmp653 ) {
	case RML_TAGFIXNUM(1):
	RML_STORE(RML_OFFSET(tmp839, -1), tmp601);
	RML_STORE(RML_OFFSET(tmp839, -2), tmp335);
	RML_STORE(RML_OFFSET(tmp839, -3), RML_LABVAL(Main_2dsclam664));
	rmlA1 = tmp576;
	rmlA0 = tmp585;
	rmlFC = tmp601;
	rmlSC = RML_OFFSET(tmp839, -3);
	rmlSP = RML_OFFSET(tmp839, -3);
	RML_TAILCALLQ(RMLToMod__transform,2);
	default:
	rmlFC = tmp601;
	rmlSP = tmp839;
	RML_TAILCALL(RML_FETCH(tmp601),0);
	}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam664)
{

	{ void *tmp843 = rmlSC;
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp843, 1));
	{ void *tmp601 = RML_FETCH(RML_OFFSET(tmp843, 2));
	{ void *tmp842 = RML_OFFSET(tmp843, 3);
	rmlFC = tmp601;
	rmlSC = tmp335;
	rmlSP = tmp842;
	RML_TAILCALLQ(ModDump__dump,1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dfclam651)
{

	{ void *tmp810 = rmlFC;
	{ void *tmp563 = RML_FETCH(RML_OFFSET(tmp810, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp810, 2));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp810, 3));
	{ void *tmp576 = RML_FETCH(RML_OFFSET(tmp810, 4));
	{ void *tmp585 = RML_FETCH(RML_OFFSET(tmp810, 5));
	{ void *tmp600 = RML_FETCH(RML_OFFSET(tmp810, 6));
	{ void *tmp809 = RML_OFFSET(tmp810, 7);
	rml_prim_unwind(tmp600);
	{ void *tmp602 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp809, -1), tmp602);
	RML_STORE(RML_OFFSET(tmp809, -2), tmp585);
	RML_STORE(RML_OFFSET(tmp809, -3), tmp576);
	RML_STORE(RML_OFFSET(tmp809, -4), tmp334);
	RML_STORE(RML_OFFSET(tmp809, -5), tmp335);
	RML_STORE(RML_OFFSET(tmp809, -6), tmp563);
	RML_STORE(RML_OFFSET(tmp809, -7), RML_LABVAL(Main_2dfclam636));
	{ void *tmp603 = RML_OFFSET(tmp809, -7);
	RML_STORE(RML_OFFSET(tmp809, -8), tmp585);
	RML_STORE(RML_OFFSET(tmp809, -9), tmp576);
	RML_STORE(RML_OFFSET(tmp809, -10), tmp603);
	RML_STORE(RML_OFFSET(tmp809, -11), tmp335);
	RML_STORE(RML_OFFSET(tmp809, -12), RML_LABVAL(Main_2dsclam650));
	rmlA1 = RML_REFSTRINGLIT(lit4);
	rmlA0 = tmp563;
	rmlFC = tmp603;
	rmlSC = RML_OFFSET(tmp809, -12);
	rmlSP = RML_OFFSET(tmp809, -12);
	RML_TAILCALLQ(Main__is_5foption_5fset,2);}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam650)
{

	{ void *tmp834 = rmlSC;
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp834, 1));
	{ void *tmp603 = RML_FETCH(RML_OFFSET(tmp834, 2));
	{ void *tmp576 = RML_FETCH(RML_OFFSET(tmp834, 3));
	{ void *tmp585 = RML_FETCH(RML_OFFSET(tmp834, 4));
	{ void *tmp833 = RML_OFFSET(tmp834, 5);
	{ void *tmp638 = rmlA0;
	switch( (rml_sint_t)tmp638 ) {
	case RML_TAGFIXNUM(1):
	RML_STORE(RML_OFFSET(tmp833, -1), tmp603);
	RML_STORE(RML_OFFSET(tmp833, -2), tmp335);
	RML_STORE(RML_OFFSET(tmp833, -3), RML_LABVAL(Main_2dsclam649));
	rmlA1 = tmp576;
	rmlA0 = tmp585;
	rmlFC = tmp603;
	rmlSC = RML_OFFSET(tmp833, -3);
	rmlSP = RML_OFFSET(tmp833, -3);
	RML_TAILCALLQ(RMLToMod__transform,2);
	default:
	rmlFC = tmp603;
	rmlSP = tmp833;
	RML_TAILCALL(RML_FETCH(tmp603),0);
	}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam649)
{

	{ void *tmp837 = rmlSC;
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp837, 1));
	{ void *tmp603 = RML_FETCH(RML_OFFSET(tmp837, 2));
	{ void *tmp836 = RML_OFFSET(tmp837, 3);
	rmlFC = tmp603;
	rmlSC = tmp335;
	rmlSP = tmp836;
	RML_TAILCALLQ(ModDump__dump,1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dfclam636)
{

	{ void *tmp813 = rmlFC;
	{ void *tmp563 = RML_FETCH(RML_OFFSET(tmp813, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp813, 2));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp813, 3));
	{ void *tmp576 = RML_FETCH(RML_OFFSET(tmp813, 4));
	{ void *tmp585 = RML_FETCH(RML_OFFSET(tmp813, 5));
	{ void *tmp602 = RML_FETCH(RML_OFFSET(tmp813, 6));
	{ void *tmp812 = RML_OFFSET(tmp813, 7);
	rml_prim_unwind(tmp602);
	{ void *tmp604 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp812, -1), tmp604);
	RML_STORE(RML_OFFSET(tmp812, -2), tmp585);
	RML_STORE(RML_OFFSET(tmp812, -3), tmp576);
	RML_STORE(RML_OFFSET(tmp812, -4), tmp334);
	RML_STORE(RML_OFFSET(tmp812, -5), tmp335);
	RML_STORE(RML_OFFSET(tmp812, -6), tmp563);
	RML_STORE(RML_OFFSET(tmp812, -7), RML_LABVAL(Main_2dfclam629));
	{ void *tmp605 = RML_OFFSET(tmp812, -7);
	RML_STORE(RML_OFFSET(tmp812, -8), tmp335);
	RML_STORE(RML_OFFSET(tmp812, -9), tmp605);
	RML_STORE(RML_OFFSET(tmp812, -10), RML_LABVAL(Main_2dsclam635));
	rmlA1 = RML_REFSTRINGLIT(lit3);
	rmlA0 = tmp563;
	rmlFC = tmp605;
	rmlSC = RML_OFFSET(tmp812, -10);
	rmlSP = RML_OFFSET(tmp812, -10);
	RML_TAILCALLQ(Main__is_5foption_5fset,2);}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam635)
{

	{ void *tmp831 = rmlSC;
	{ void *tmp605 = RML_FETCH(RML_OFFSET(tmp831, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp831, 2));
	{ void *tmp830 = RML_OFFSET(tmp831, 3);
	{ void *tmp631 = rmlA0;
	switch( (rml_sint_t)tmp631 ) {
	case RML_TAGFIXNUM(1):
	rmlSC = tmp335;
	rmlSP = tmp830;
	RML_TAILCALL(RML_FETCH(tmp335),0);
	default:
	rmlFC = tmp605;
	rmlSP = tmp830;
	RML_TAILCALL(RML_FETCH(tmp605),0);
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dfclam629)
{

	{ void *tmp816 = rmlFC;
	{ void *tmp563 = RML_FETCH(RML_OFFSET(tmp816, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp816, 2));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp816, 3));
	{ void *tmp576 = RML_FETCH(RML_OFFSET(tmp816, 4));
	{ void *tmp585 = RML_FETCH(RML_OFFSET(tmp816, 5));
	{ void *tmp604 = RML_FETCH(RML_OFFSET(tmp816, 6));
	{ void *tmp815 = RML_OFFSET(tmp816, 7);
	rml_prim_unwind(tmp604);
	{ void *tmp606 = rml_prim_marker();
	RML_STORE(RML_OFFSET(tmp815, -1), tmp606);
	RML_STORE(RML_OFFSET(tmp815, -2), tmp585);
	RML_STORE(RML_OFFSET(tmp815, -3), tmp576);
	RML_STORE(RML_OFFSET(tmp815, -4), tmp334);
	RML_STORE(RML_OFFSET(tmp815, -5), tmp335);
	RML_STORE(RML_OFFSET(tmp815, -6), RML_LABVAL(Main_2dfclam622));
	{ void *tmp607 = RML_OFFSET(tmp815, -6);
	RML_STORE(RML_OFFSET(tmp815, -7), tmp335);
	RML_STORE(RML_OFFSET(tmp815, -8), tmp607);
	RML_STORE(RML_OFFSET(tmp815, -9), RML_LABVAL(Main_2dsclam628));
	rmlA1 = RML_REFSTRINGLIT(lit2);
	rmlA0 = tmp563;
	rmlFC = tmp607;
	rmlSC = RML_OFFSET(tmp815, -9);
	rmlSP = RML_OFFSET(tmp815, -9);
	RML_TAILCALLQ(Main__is_5foption_5fset,2);}}}}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam628)
{

	{ void *tmp828 = rmlSC;
	{ void *tmp607 = RML_FETCH(RML_OFFSET(tmp828, 1));
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp828, 2));
	{ void *tmp827 = RML_OFFSET(tmp828, 3);
	{ void *tmp624 = rmlA0;
	switch( (rml_sint_t)tmp624 ) {
	case RML_TAGFIXNUM(1):
	rmlSC = tmp335;
	rmlSP = tmp827;
	RML_TAILCALL(RML_FETCH(tmp335),0);
	default:
	rmlFC = tmp607;
	rmlSP = tmp827;
	RML_TAILCALL(RML_FETCH(tmp607),0);
	}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dfclam622)
{

	{ void *tmp819 = rmlFC;
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp819, 1));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp819, 2));
	{ void *tmp576 = RML_FETCH(RML_OFFSET(tmp819, 3));
	{ void *tmp585 = RML_FETCH(RML_OFFSET(tmp819, 4));
	{ void *tmp606 = RML_FETCH(RML_OFFSET(tmp819, 5));
	{ void *tmp818 = RML_OFFSET(tmp819, 6);
	rml_prim_unwind(tmp606);
	RML_STORE(RML_OFFSET(tmp818, -1), tmp334);
	RML_STORE(RML_OFFSET(tmp818, -2), tmp335);
	RML_STORE(RML_OFFSET(tmp818, -3), RML_LABVAL(Main_2dsclam621));
	rmlA1 = tmp576;
	rmlA0 = tmp585;
	rmlFC = tmp334;
	rmlSC = RML_OFFSET(tmp818, -3);
	rmlSP = RML_OFFSET(tmp818, -3);
	RML_TAILCALLQ(RMLToMod__transform,2);}}}}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam621)
{

	{ void *tmp822 = rmlSC;
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp822, 1));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp822, 2));
	{ void *tmp821 = RML_OFFSET(tmp822, 3);
	RML_STORE(RML_OFFSET(tmp821, -1), tmp334);
	RML_STORE(RML_OFFSET(tmp821, -2), tmp335);
	RML_STORE(RML_OFFSET(tmp821, -3), RML_LABVAL(Main_2dsclam620));
	rmlFC = tmp334;
	rmlSC = RML_OFFSET(tmp821, -3);
	rmlSP = RML_OFFSET(tmp821, -3);
	RML_TAILCALLQ(ModDump__unparse_5fstr,1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main_2dsclam620)
{

	{ void *tmp825 = rmlSC;
	{ void *tmp335 = RML_FETCH(RML_OFFSET(tmp825, 1));
	{ void *tmp334 = RML_FETCH(RML_OFFSET(tmp825, 2));
	{ void *tmp824 = RML_OFFSET(tmp825, 3);
	rmlFC = tmp334;
	rmlSC = tmp335;
	rmlSP = tmp824;
	RML_TAILCALLQ(RML__print,1);}}}}
}
RML_END_LABEL

static RML_BEGIN_LABEL(Main__is_5foption_5fset)
{

	{ void *tmp305 = rmlSC;
	{ void *tmp306 = rmlA0;
	{ void *tmp307 = rmlA1;
	{ void *tmp545 = RML_FETCH(RML_UNTAGPTR(tmp306));
	switch( (rml_sint_t)tmp545 ) {
	case RML_STRUCTHDR(0,0):
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	RML_TAILCALL(RML_FETCH(tmp305),1);
	/*case RML_STRUCTHDR(2,1)*/
	default:
	{ void *tmp546 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp306), 2));
	{ void *tmp547 = RML_FETCH(RML_OFFSET(RML_UNTAGPTR(tmp306), 1));
	{ void *tmp548 = RML_FETCH(RML_UNTAGPTR(tmp546));
	switch( (rml_sint_t)tmp548 ) {
	case RML_STRUCTHDR(0,0):
	{ void *tmp551 = rml_prim_marker();
	{ void *tmp554 = rml_prim_equal(tmp547, tmp307);
	switch( (rml_sint_t)tmp554 ) {
	case RML_TAGFIXNUM(0):
	rml_prim_unwind(tmp551);
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(0));
	RML_TAILCALL(RML_FETCH(tmp305),1);
	default:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	RML_TAILCALL(RML_FETCH(tmp305),1);
	}}}
	default:
	{ void *tmp534 = rml_prim_marker();
	{ void *tmp543 = rml_prim_equal(tmp547, tmp307);
	switch( (rml_sint_t)tmp543 ) {
	case RML_TAGFIXNUM(0):
	rml_prim_unwind(tmp534);
	rmlA0 = tmp546;
	RML_TAILCALLQ(Main__is_5foption_5fset,2);
	default:
	rmlA0 = RML_IMMEDIATE(RML_TAGFIXNUM(1));
	RML_TAILCALL(RML_FETCH(tmp305),1);
	}}}
	}}}}
	}}}}}
}
RML_END_LABEL
