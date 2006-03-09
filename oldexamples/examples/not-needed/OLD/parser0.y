%token CLASS MODEL RECORD BLOCK CONNECTOR PACKAGE FUNCTION
%token FLOW DISCRETE PARAMETER CONST INPUT OUTPUT
%token ENCAPSULATED PARTIAL WITHIN

%token T_and T_as T_abstype T_axiom T_datatype T_default
%token T_end T_eqtype T_fail T_interface T_let T_module
%token T_not T_of T_relation T_rule T_type T_val T_with T_withtype

%token LBRACK RBRACK LBRACE RBRACE LPAR RPAR
%token DOT COLON COLONCOLON COMMA DASHES PIPEBAR AMPERSAND
%token SEMICOLON YIELDS STAR WILD EQUALS PLUS MINUS DIV

%token STRING
%token IDENT TYVARIDENT
%token CCON ICON RCON SCON 
%{
#include "../absyn.h"
%}

%%

stored_definition:
	optENCAPSULATED optPARTIAL class_type IDENT
	{
	  $0 = Absyn__BEGIN_5fDEFINITION(
			Absyn__IDENT(to_rml_str($4)), $3, $2, $1);

	}
|
	T_end IDENT SEMICOLON
	{
          $0 = Absyn__END_5fDEFINITION(to_rml_str($2));
	}
|
	component_clause SEMICOLON
	{
	  $0 = Absyn__COMP_5fDEFINITION($1,mk_none());
	}
|
	import_clause SEMICOLON
	{
	  $0 = Absyn__IMPORT_5fDEFINITION($1,mk_none());
	}
|
	optWITHIN class_definition_sequence
	{
	  $0 = Absyn__PROGRAM(make_rml_list_from_stack(el_stack),$1);
        }
|
	rml_file
	{
	  $0 = $1;
	}
;


optENCAPSULATED:
	ENCAPSULATED { $0 = RML_PRIM_MKBOOL(1);}
|
	{ $0 = RML_PRIM_MKBOOL(0);}
;

optPARTIAL:
	PARTIAL { $0 = RML_PRIM_MKBOOL(1);}
|
	{ $0 = RML_PRIM_MKBOOK(0);}
;

optWITHIN:
	within_clause { $0 = $1;}
|
	{ $0 = mk_none();}
;


within_clause:
	WITHIN name_path
;


class_definition:
	optENCAPSULATED optPARTIAL class_type IDENT class_specifier
	{
	  $0 = Absyn__CLASS(to_rml_str($4,RML_PRIM_MKBOOL($2)),0,0,0,0,0 /* FIXME*/); 
	}
;


class_type:
	CLASS     { $0 = Absyn__R_5fCLASS;}
|	MODEL     { $0 = Absyn__R_5fMODEL;}
|	RECORD    { $0 = Absyn__R_5fMODEL;}
|	BLOCK     { $0 = Absyn__R_5fBLOCK;}
|	CONNECTOR { $0 = Absyn__R_5fCONNECTOR;}
|	T_type    { $0 = Absyn__R_5fTYPE;}
|	PACKAGE   { $0 = Absyn__R_5fPACKAGE;}
|	FUNCTION  { $0 = Absyn__R_5fFUNCTION;}
;


class_specifier:
	string_comment composition T_end IDENT
	{
	  $0 = Absyn__PARTS($2, $1 : mk_some($1) : mk_none()); 
	}
|
	EQUALS base_prefix name_path
		opt_array_subscripts
		opt_class_modification
		comment
	{
	  $0 = Absyn__DERIVED($3, /* name path */
		              $4, /* array subscripts */
                              $2, /* prefix attributes */
                              $5, /* class modification */
                              $6); /* comment */
	}
|
	EQUALS enumeration
	
|
	EQUALS overloading
;


base_prefix:
	flow_prefix variability_prefix direction_prefix
          { $0 = Absyn__ATTR($1, $2, $3, 0 /* FIXME */);}
;

flow_prefix:
	FLOW { $0 = RML_PRIM_MKBOOL(1);}
|	 { $0 = RML_PRIM_MKBOOL(0);}
;

variability_prefix:
	DISCRETE  { $0 = Absyn__DISCRETE;}
|	PARAMETER { $0 = Absyn__PARAM;}
|	CONST     { $0 = Absyn__CONST;}
|		  { $0 = Absyn__VAR;}
;

direction_prefix:
	INPUT   { $0 = Absyn__INPUT;}
|	OUTPUT  { $0 = Absyn__OUTPUT;}
|	{ $0 = Absyn__BIDIR;}
;

component_clause: ;
import_clause: ;
class_definition_sequence: ;
name_path: ;
string_comment: ;
composition: ;
opt_array_subscripts: ;
opt_class_modification: ;
comment: ;
enumeration: ;
overloading: ;
condbind: ;
name_list: ;
enum_list: ;
enumeration_literal: ;
external_clause: ;
public_element_list: ;
protected_element_list: ;
language_specification: ;
external_function_call: ;
element_list: ;
element: ;
explicit_import_name: ;
implicit_import_name: ;
extends_clause: ;
constraining_clause: ;
type_prefix: ;
type_specifier: ;
component_list: ;
component_declaration: ;
declaration: ;
modification: ;
class_modification: ;
argument_list: ;
argument: ;
element_modification: ;
element_redeclaration: ;
component_clause1: ;
initial_equation_clause: ;
equation_clause: ;
equation_annotation_list: ;
algorithm_clause: ;
initial_algorithm_clause: ;
equation: ;
algorithm: ;
assign_clause_a: ;
equality_equation: ;
conditional_equation_e: ;
conditional_equation_a: ;
for_clause_e: ;
for_clause_a: ;
while_clause: ;
when_clause_e: ;
else_when_e: ;
when_clause_a: ;
else_when_a: ;
equation_elseif: ;
algorithm_elseif: ;
equation_list: ;
algorithm_list: ;
connect_clause: ;
connector_ref: ;
connector_ref_2: ;
expression: ;
if_expression: ;
elseif_expression: ;
for_indices: ;
for_indices2: ;
for_index: ;
simple_expression: ;
code_expression: ;
code_equation_clause: ;
code_initial_equation_clause: ;
code_algorithm_clause: ;
code_initial_algorithm_clause: ;
logical_expression: ;
logical_term: ;
logical_factor: ;
relation: ;

rel_op:
	LESS | LESSEQ | GREATER | GREATEREQ | EQEQ | LESSGT ;

arithmetic_expression:
	unary_arithmetic_expression
	|
	unary_arithmetic_expression PLUS arithmetic_expression
		{ $0 = Absyn__BINARY($1,Absyn__ADD,$3);}
	|
	unary_arithmetic_expression MINUS arithmetic_expression
		{ $0 = Absyn__BINARY($1,Absyn__SUB,$3);}
	;

unary_arithmetic_expression:
	PLUS term { $0 = Absyn__UNARY(Absyn__UPLUS,$2);}
	|
	MINUS term { $0 = Absyn__UNARY(Absyn__UMINUS,$2);}
	|
	term { $0 = $1;}
	;

term:
	factor STAR term { $0 = Absyn__BINARY($1,Absyn__MUL,$3);}
	|
	factor SLASH term { $0 = Absyn__BINARY($1,Absyn__DIV,$3);}
	|
	factor { $0 = $1;}
	;

factor:
	primary POWER primary { $0 = Absyn__BINARY($1,Absyn__POW,$3);}
	|
	primary { $0 = $1;}
	;

expression_list_semicolon_list:
	expression_list SEMICOLON expression_list_semicolon_list
		{ /* FIXME -- Absyn__MATRIX */ }
	|
	expression_list
		{ /* FIXME -- Absyn__MATRIX */ }
	;

primary:
	UNSIGNED_INTEGER { $0 = Absyn__INTEGER(mk_icon(str_to_int($1)));}
	|
	UNSIGNED_REAL { $0 = Absyn__REAL(mk_rcon(str_to_double($1)));}
	|
	STRING { $0 = Absyn__STRING(to_rml_str($1));}
	|
	FALSE { $0 = Absyn__BOOL(RML_FALSE);}
	|
	TRUE { $0 = Absyn__BOOL(RML_TRUE);}
	|
	component_reference__function_call { $0 = $1;}
	|
	LPAR tuple_expression_list RPAR { $0 = $1;}
	|
	LBRACK expression_list_semicolon_list RBRACK { $0 = $2;}
	|
	LBRACE for_or_expression_list RBRACE { $0 = $2;}
	;

component_reference__function_call:
	component_reference function_call
		{ $0 = Absyn__CALL($1, $2);}
	|
	component_reference
		{ $0 = Absyn__CREF($1);}
	|
	INITIAL LPAR RPAR
		{ $0 = Absyn__CALL(Absyn__CREF_5fIDENT(
					mk_scon("initial"), mknil()),
				   Absyn__FUNCTIONARGS(mk_nil(), mk_nil()));
 		}
	;

name_path:
	IDENT DOT name_path { $0 = Absyn__QUALIFIED(to_rml_str($1), $3);}
	|
	IDENT { $0 = Absyn__IDENT(to_rml_str($1));}
	;

component_reference:
	IDENT opt_array_subscripts opt_dot_component_reference
	;

function_call:
	LPAR function_arguments RPAR
		{ $0 = $2;}
	;

function_arguments:
	for_or_expression_list
	opt_named_arguments
	;

for_or_expression_list:
	;

for_or_expression_list2:
	;

named_arguments: ;

named_arguments2: ;

named_argument: ;

expression_list:
	;

expression_list2:
	;

subscript:
	;

comment:
	;

string_comment:
	;

annotation:
	;


/*********************************************/
/**************** RML Grammar ****************/
/*********************************************/

rml_file:
	T_module STRING COLON rml_interface rml_definitions
		{ $0 = Absyn__RML_5fFILE($2, $4, $5);}
	|
	T_interface STRING COLON rml_interface
		{ $0 = Absyn__RML_5fFILE($2, $4, mk_nil());}
	;

rml_interface:
	rml_interface_item_star
		{ $0 = $1;}
	T_end
	;

rml_interface_item_star:
	rml_interface_item rml_interface_item_star
		{ $0 = mk_cons($1, $2);}
	|
		{ $0 = mk_nil();}
	;

rml_interface_item:
	T_with STRING
		{ $0 = Absyn__WITH($2);}
	|
	T_type tyvarparseq IDENT
		{ $0 = mk_nil(); /* FIXME!! */;}
	|
	T_type typbind_plus
		{ $0 = $1;}
	|
	T_datatype datbind_plus withbind
		{ $0 = $2;}
	|
	T_val ident COLON ty
		{ $0 = Absyn__VALINTERFACE($2, $4);}
	|
	T_relation ident COLON ty
		{ $0 = Absyn__RELATION_5fINTERFACE($2, $4);}
	;

rml_definitions:
	rml_definition_item rml_definitions
		{ $0 = mk_cons($1, $2);}
	|
		{ $0 = mk_nil();}
	;

rml_definition_item:
	T_with STRING
		{ $0 = Absyn__WITH($2);}
	|
	T_type typbind_plus
		{ $0 = $2;}
	|
	T_datatype datbind_plus withbind
		{ $0 = $2; /* FIXME: support withbind */}
	|
	T_val ident EQUALS rml_expression
		{ $0 = Absyn__RMLVAL($2, $4);}
	|
	T_relation relbind
		{ $0 = $1;}
	;

opt_type:
	COLON ty
		{ $0 = $2;}
	|
	empty
		{ $0 = mk_nil();}
	;

relbind:
	ident opt_type EQUALS clause_plus default_opt T_end
		{ $0 = Absyn__RELATION_DEFINITION($1, $2, $4);}
	;

withbind:
		{ $0 = mk_nil();}
	|
	T_withtype typbind_plus
		{ $0 = $2;}
	;

typbind_plus:
	typbind T_and typbind_plus /* do we really want to support this? */
		{ $0 = mk_cons($1, $3);}
	|
	typbind
		{ $0 = $1;}
	;

typbind:
	tyvarseq ident EQUALS ty
		{ $0 = mk_nil(); /* FIXME! */ }
	;

datbind_plus:
	datbind T_and datbind_plus
		{ $0 = mk_cons($1, $3);}
	|
	datbind
		{ $0 = mk_cons($1, mk_nil());}
	;

datbind:
	tyvarseq ident EQUALS conbind_plus
		{ $0 = Absyn__DATATYPE($2, $3); /* FIXME: $1 */ }
	;

conbind_plus:
	conbind PIPEBAR conbind_plus
		{ $0 = mk_cons($1, $3);}
	|
	condbind
		{ $0 = mk_cons($1, mk_nil());}
	;

conbind:
	ident
		{ $0 = Absyn__DTCONS($1, mk_nil());}
	|
	ident T_of tuple_ty
		{ $0 = Absyn__DTCONS($1, $3);}
	;

default_opt:
	/* empty */
	|
	T_default clause_plus
		{ /* FIXME */}
	;

clause_plus:
	clause clause_plus
		{ $0 = mk_cons($1, $2);}
	|
	clause
		{ $0 = mk_cons($1, mk_nil());}
	;

clause:
	T_rule conjunctive_goal_opt DASHES ident seq_pat result
		{ $0 = Absyn__RMLRULE($4, $5, $2, $6);}
	|
	T_axiom ident seq_pat result
		{ $0 = Absyn__RMLRULE($2, $3, mk_nil(), $4);}
	;

result:
	/* empty */
		{ $0 = Absyn__RMLNoResult;}
	|
	YIELDS seq_exp
		{ $0 = Absyn__RMLResultExp($2);}
	|
	YIELDS T_fail
		{ $0 = Absyn__RMLResultFail;}
	;

conjunctive_goal_opt:
	/* empty */
		{ $0 = mk_nil();}
	|
	conjunctive_goal
		{ $0 = $1;}
	;

conjunctive_goal:
	atomic_goal AMPERSAND conjunctive_goal
		{ $0 = mkcons($1, $3);}
|
	atomic_goal
		{ $0 = mkcons($1, mk_nil());}
	;

atomic_goal:
	longorshortid seq_exp res_pat
		{ $0 = Absyn__RMLGOAL_5fRELATION($1, $2, $3);}
	|
	ident EQUALS rml_expression
		{ $0 = Absyn__RMLGOAL_5fEQUAL($1, $3);}
	|
	T_let ident EQUALS rml_expression
		{ $0 = Absyn__RMLGOAL_5fLET($2, $4);}
	|
	T_not atomic_goal
		{ $0 = Absyn__RMLGOAL_5fNOT($2);}
	|
	LPAR conjunctive_goal RPAR
		{ $0 = $2;}
	;

/* RML Expressions */

rml_expression:
	rml_exp_a COLONCOLON rml_expression
		{ $0 = Absyn__RMLCONS($1, $2);}
	|
	rml_exp_a
		{ $0 = $1;}
	;

rml_expression_list:
	rml_expression ',' rml_expression_list
		{ $0 = mk_cons($1, $3);}
|
	rml_expression
		{ $0 = mk_cons($1, mk_nil());}
;

rml_exp_a:
	LPAR RPAR
		{ $0 = mk_nil();}
	|
	LPAR rml_expression RPAR
		{ $0 = $2;}
	|
	LPAR rml_expression_list RPAR
		{ $0 = $2;}
	|
	rml_exp_c
		{ $0 = $1;}
	;

rml_exp_b:
	rml_exp_c COLONCOLON rml_exp_b
		{ $0 = Absyn__RMLCONS($1, $3);}
	|
	rml_exp_c
		{ $0 = $1;}
	;

rml_exp_c:
	longorshortid rml_exp_star
		{ $0 = Absyn__RMLCALL($1, $2);}
	|
	rml_addsub
		{ $0 = $1;}
	;

rml_addsub:
	rml_muldiv PLUS rml_addsub
		{ $0 = Absyn__BINARY($1, RML_ADD, $3);}
	|
	rml_muldiv MINUS rml_addsub
		{ $0 = Absyn__BINARY($1, RML_SUB, $3);}
	|
	rml_muldiv
		{ $0 = $1;}
	;

rml_muldiv:
	rml_unary STAR rml_muldiv
		{ $0 = Absyn__BINARY($1, RML_MUL, $3);}
	|
	rml_unary DIV rml_muldiv
		{ $0 = Absyn__BINARY($1, RML_DIV, $3);}
	|
	rml_unary 
		{ $0 = $1;}
	;

rml_unary:
	MINUS rml_unary
		{ $0 = Absyn__UNARY(RML_UMINUS, $2);}
	|
	rml_primary
		{ $0 = $1;}
	;

rml_primary:
	rml_literal
		{ $0 = $1;}
	|
	longorshortid
		{ $0 = $1;}
	|
	LBRACK rml_exp_comma_star RBRACK
		{ $0 = $2;}
	|
	LPAR rml_expression RPAR
		{ $0 = $2;}
	;

rml_exp_comma_star:
	/* empty */
		{ $0 = mk_nil();}
	|
	rml_exp_comma_plus
		{ $0 = $1;}
	;

rml_exp_comma_plus:
	rml_expression COMMA rml_exp_comma_plus
		{ $0 = mk_cons($1, $3);}
|
	rml_expression
		{ $0 = mk_cons($1, mk_nil());}
	;

rml_exp_star:
	LPAR rml_exp_comma_star RPAR
		{ $0 = $2;}
;

seq_exp:
	/* empty */
		{ $0 = mk_nil();}
	|
	rml_exp_b
		{ $0 = mk_cons($1, mk_nil());}
	|
	rml_exp_star
		{ $0 = $1;}
;

/* RML Patterns */

pat:
	ident T_as pat
		{ $0 = Absyn_RMLPAT_5fAS($1, $3);}
	|
	pat_a
		{ $0 = $1;}
	;

pat_a:
	pat_b COLONCOLON pat_a
		{ $0 = Absyn__RMLPAT_5fCONS($1, $3);}
	|
	pat_b
		{ $0 = $1;}
	;

pat_b:
	LPAR RPAR
		{ $0 = Absyn__RMLPAT_5fNIL;}
	|
	LPAR pat RPAR
		{ $0 = $1;}
	|
	LPAR pat COMMA pat_comma_plus RPAR
		{ $0 = Absyn__RMLPAT_5fSTRUCT(mk_cons($2, $4));}
	|
	pat_d
		{ $0 = $1;}
	;

pat_c:
	pat_d COLONCOLON pat_c
		{ $0 = Absyn__RMLPAT_5fCONS($1, $3);}
	|
	pat_d
		{ $0 = $1;}
	;

pat_d:
	longorshortid pat_star
		{ $0 = Absyn__RMLPAT_5fCALL($1, $2);}
	|
	longorshortid pat_e
		{ $0 = Absyn__RMLPAT_5fCALL($1, $2);}
	|
	pat_e
		{ $0 = $1;}
	;

pat_e:
	WILD
		{ $0 = Absyn__RMLPAT_5fWILDCARD;}
	|
	rml_literal
		{ $0 = Absyn__RMLPAT_5fLITERAL($1);}
	|
	longid
		{ $0 = Absyn__RMLPAT_5fIDENT($1);}
	|
	ident
		{ $0 = Absyn__RMLPAT_5fIDENT($1);}
	|
	LBRACK pat_comma_star RBRACK
		{ $0 = $1; /* CHECKME */}
	;

res_pat: /* CHECKME */
	/* empty */
		{ $0 = mk_nil();}
	|
	YIELDS seq_pat
		{ $0 = $2;}
	;

seq_pat:
	/* empty */
		{ $0 = mk_nil();}
	|
	pat_c
		{ $0 = $1;}
	|
	pat_star
		{ $0 = $1;}
	;

pat_star:
	LPAR pat_comma_star RPAR
		{ $0 = $2;}
	;

pat_comma_star:
	/* empty */
		{ $0 = mk_nil();}
	|
	pat_comma_plus
		{ $0 = $1;}
	;

pat_comma_plus:
	pat COMMA pat_comma_plus
		{ $0 = mk_cons($1, $3);}
	|
	pat
		{ $0 = mk_cons($1, mk_nil());}
	;

/* RML Literals */

rml_literal:
	CCON
		{ $0 = Absyn__RMLLIT_5fCHAR(mk_ccon($1));}
	|
	ICON
		{ $0 = Absyn__RMLLIT_5fINTEGER(mk_icon($1));}
	|
	RCON
		{ $0 = Absyn__RMLLIT_5fREAL(mk_rcon($1));}
	|
	STRING
		{ $0 = Absyn__RMLLIT_5fSTRING(mk_scon($1));}
	;

/* RML Types */

ty:
	seq_ty YIELDS seq_ty
		{ $0 = Absyn__RMLTYPE_5fSIGNATURE(
                              Absyn__RMLSignature($1, $3));}
	|
	tuple_ty
		{ $0 = Absyn_RMLTYPE_5fTUPLE($1);}
	;

tuple_ty:
	ty_sans_star STAR tuple_ty
		{ $0 = mk_cons($1, $3);}
	|
	ty_sans_star
		{ $0 = mk_cons($1, mk_nil());}
	;

ty_sans_star:
/* **FIXME!**
	ty_sans_star longorshortid
	|
	LPAR ty_comma_seq2 RPAR longorshortid
	|
*/
	LPAR ty RPAR
		{ $0 = $2;}
	|
	tyvar
		{ $0 = RMLTYPE_5fTYVAR($1);}
	|
	longorshortid
		{ $0 = RMLTYPE_5fUSERDEFINED($1);}
	;

ty_comma_seq2:
	ty COMMA ty_comma_seq2
		{ $0 = mk_cons($1, $3);}
	|
	ty COMMA ty
		{ $0 = mk_cons($1, mk_cons($3, mk_nil()));}
	;

seq_ty:
	LPAR RPAR
		{ $0 = mk_nil();}
	|
	LPAR ty_comma_seq2 RPAR
		{ $0 = $2;}
	|
	tuple_ty
		{ $0 = $1;}
	;

tyvarseq1:
	tyvar COMMA tyvarseq1
		{ $0 = mk_cons($1, $3);}
	|
	tyvar
		{ $0 = mk_cons($1, mk_nil());}
	;

tyvarparseq:
	LPAR tyvarseq1 RPAR
		{ $0 = $2;}
	;

tyvarseq:
	/* empty */
		{ $0 = mk_nil();}
	|
	tyvar
		{ $0 = $1;}
	|
	tyvarparseq
		{ $0 = $1;}
	;

/* RML Identifiers */

longid:
	IDENT DOT IDENT
		{ $0 = Absyn__RMLLONGID(mk_scon($1), mk_scon($3));}
	;

longorshortid:
	longid
		{ $0 = $1;}
	|
	ident
		{ $0 = $1;}
	;

ident:
	IDENT
		{ $0 = mk_scon($1);}
	;

tyvar:
	TYVARIDENT
		{ $0 = mk_scon($1);}
	;

empty:	;


%%

