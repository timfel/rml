%token CLASS MODEL RECORD BLOCK CONNECTOR PACKAGE FUNCTION
%token FLOW DISCRETE PARAMETER CONST INPUT OUTPUT
%token ENCAPSULATED PARTIAL WITHIN
%token ENUMERATION PUBLIC EXTERNAL OVERLOAD IMPORT PROTECTED
%token INNER OUTER IF THEN ELSE ELSEIF END FOR LOOP IN
%token REPLACEABLE WHEN WHILE ELSEWHEN CONNECT
%token LESS LESSEQ GREATER GREATEREQ EQEQ LESSGT
%token SLASH POWER UNSIGNED_INTEGER UNSIGNED_REAL
%token INITIAL ANNOTATION TRUE FALSE FINAL

%token AND OR NOT

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
	optENCAPSULATED optPARTIAL class_type ident
	{
	  $0 = Absyn__BEGIN_5fDEFINITION(Absyn__IDENT($4), $3, $2, $1);
	}
	|
	T_end ident SEMICOLON
	{
          $0 = Absyn__END_5fDEFINITION($2);
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
	opt_within_clause class_definition_list
	{
	  $0 = Absyn__PROGRAM($2,$1);
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
	{ $0 = RML_PRIM_MKBOOL(0);}
	;

optFINAL:
	FINAL { $0 = 1;}
	|
	{ $0 = 0;}
	;

optSEMICOLON:
	SEMICOLON { $0 = 1;}
	|
	{ $0 = 0;}
	;

opt_within_clause:
	within_clause { $0 = $1;}
	|
	{ $0 = Absyn__TOP;}
	;


within_clause:
	WITHIN name_path
		{ $0 = Absyn__WITHIN($2);}
	;


class_definition:
	optENCAPSULATED optPARTIAL class_type IDENT class_specifier
	{
	  $0 = Absyn__CLASS($4,RML_PRIM_MKBOOL($2)),0,0,0,0,0 /* FIXME*/); 
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

base_prefix:
	flow_prefix variability_prefix direction_prefix
		{ $0 = Absyn__ATTR($1, $2, $3, mk_nil());}
	;

class_specifier:
	string_comment composition T_end IDENT
	{
	  $0 = Absyn__PARTS($2, $1);
	}
|
	EQUALS	base_prefix
		name_path
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
		{ $0 = $1;}
|
	EQUALS overloading
		{ $0 = $1;}
;


enumeration:
	ENUMERATION LPAR enum_list RPAR comment
		{ $0 = Absyn__ENUMERATION($3,$5);}	
	;

enum_list:
	enumeration_literal COMMA enum_list
		{ $0 = mk_cons($1, $3);}
	|
	enumeration_literal
		{ $0 = mk_cons($1, mk_nil());}
	;

enumeration_literal:
	ident comment
		{ $0 = Absyn__ENUMLITERAL($1,$2);}
	;

overloading:
	OVERLOAD LPAR name_path_list RPAR comment
		{ $0 = Absyn__OVERLOAD($3, $5);}
	;

name_path_list:
	name_path COMMA name_path_list
		{ $0 = mk_cons($1,$3);}
	|
	name_path
		{ $0 = mk_cons($1,mk_nil());}
	;
	
flow_prefix:
	FLOW
		{ $0 = RML_PRIM_MKBOOL(1);}
	|
		{ $0 = RML_PRIM_MKBOOL(0);}
;

variability_prefix:
	DISCRETE	{ $0 = Absyn__DISCRETE;}
|	PARAMETER	{ $0 = Absyn__PARAM;}
|	CONST		{ $0 = Absyn__CONST;}
|			{ $0 = Absyn__VAR;}
;

direction_prefix:
	INPUT		{ $0 = Absyn__INPUT;}
|	OUTPUT		{ $0 = Absyn__OUTPUT;}
|			{ $0 = Absyn__BIDIR;}
;

component_clause:
	flow_prefix variability_prefix direction_prefix
	type_specifier opt_array_subscripts component_list
	{
		$0 = Absyn__COMPONENTS(Absyn__ATTR($1,$2,$3,$5),$4,$6);
	}
	;

component_clause1:
	flow_prefix variability_prefix direction_prefix
	type_specifier component_declaration
	{
		$0 = Absyn__COMPONENTS(Absyn__ATTR($1,$2,$3,mk_nil()),$4,$5);
	}
	;

composition:
	flow_prefix variability_prefix direction_prefix
	type_specifier opt_array_subscripts opt_class_modification
		{ /* FIXME */ }
	;

import_clause:
	IMPORT explicit_import_name comment
		{ $0 = Absyn__IMPORT($2,$3);}
	|
	IMPORT implicit_import_name comment
		{ $0 = Absyn__IMPORT($2,$3);}
	;

explicit_import_name:
	ident EQUALS name_path
		{ $0 = Absyn__NAMED_5fIMPORT($1,$3);}
	;

implicit_import_name:
	name_path DOT STAR
		{ $0 = Absyn__UNQUAL_5fIMPORT($1);}
	|
	name_path
		{ $0 = Absyn__QUAL_5fIMPORT($1);}
	;

class_definition_list:
	optFINAL class_definition class_definition_list
		{ $0 = $1 ? mk_cons($2,$3) : $3; /* FIXME: Correct? */ }
	|
		{ $0 = 	mk_nil();}
	;

composition:
	element_list composition_sublist
	{
		$0 = mk_cons(Absyn__PUBLIC($1), $2);
	}
	;

composition_sublist:
	PUBLIC element_list composition_sublist
		{ $0 = mk_cons(Absyn__PUBLIC($1), $2);}
	|
	PROTECTED element_list composition_sublist
		{ $0 = mk_cons(Absyn__PROTECTED($1), $2);}
	|
	equation_clause composition_sublist
		{ /* FIXME */ }
	|
	initial_equation_clause composition_sublist
		{ /* FIXME */ }
	|
	algorithm_clause composition_sublist
		{ /* FIXME */ }
	|
	initial_algorithm_clause composition_sublist
		{ /* FIXME */ }
	|
	EXTERNAL
		opt_language_specification
		opt_external_function_call
		optSEMICOLON
		opt_annotation
	{ /* an external_clause must be the last composition item, so
	   * we don't have composition_sublist at the end of this rule.
	   * This also means we must add the NIL at the end of the list
	   * ourselves.
	   */
		$0 = mk_cons($1, mk_nil());
	}
	|
		{ $0 = mk_nil();}
	;

language_specification:
	STRING
		{ $0 = to_rml_string($1);}
	;

opt_language_specification:
	language_specification
		{ $0 = $1;}
	|
		{ $0 = 0;}
	;

element_list:
	element SEMICOLON element_list
		{ $0 = mk_cons(Absyn__ELEMENTITEM($1), $3);}
	|
	annotation SEMICOLON element_list
		{ $0 = mk_cons(Absyn__ANNOTATIONITEM($1), $3);}
	|
		{ $0 = mk_nil();}
	;

element:
		{ positionPush();}
	element1
		{
		  $0 = $1;
		  positionPop();
		}
	;

element1:
	import_clause
	{
	  $0 = Absyn__ELEMENT(RML_FALSE,RML_FALSE,Absyn__UNSPECIFIED,
				mk_scon("import"),$1,
				mk_scon(positionFileName()),
				mk_icon(positionLineNo()),mk_none());
	}
	|
	extends_clause
	{
	  $0 = Absyn__ELEMENT(RML_FALSE,RML_FALSE,Absyn__UNSPECIFIED,
				mk_scon("extends"),$1,
				mk_scon(positionFileName()),
				mk_icon(positionLineNo()),mk_none());
	}
	|
	optFINAL inner_outer REPLACEABLE class_definition
		opt_constraining_clause comment
		{ $0 = parser_make_element($1, $2,  1, $4,  0,  $5, $6);}
	|
	optFINAL inner_outer class_definition
		{ $0 = parser_make_element($1, $2,  0, $3,  0,   0,  0);}
	|
	optFINAL inner_outer REPLACEABLE component_clause
		opt_constraining_clause comment
		{ $0 = parser_make_element($1, $2,  1,  0,  $4, $5, $6);}
	|
	optFINAL inner_outer component_clause
		{ $0 = parser_make_element($1, $2,  0,  0,  $3,  0, 0);}
	;

inner_outer:
	INNER	{ $0 = Absyn__INNER;}
|	OUTER	{ $0 = Absyn__OUTER;}
|		{ $0 = Absyn__UNSPECIFIED;}
;

subscript:
	expression
		{ $0 = Absyn__SUBSCRIPT($1);}
	|
	COLON
		{ $0 = Absyn__NOSUB;}
	;

subscript_list:
	subscript COMMA subscript_list
		{ $0 = mk_cons($1,$3);}
	|
	subscript
		{ $0 = mk_cons($1,mk_nil();}
	;

array_subscripts:
	LBRACK subscript_list RBRACK
		{ $0 = $1;}
	;

opt_array_subscripts:
	array_subscripts
		{ $0 = $1;}
	|
		{ $0 = mk_nil();}
	;

opt_class_modification: ;
condbind: ;
public_element_list: ;
protected_element_list: ;
external_function_call: ;
element_list: ;
element: ;
explicit_import_name: ;
implicit_import_name: ;
extends_clause: ;
constraining_clause: ;
component_list: ;
component_declaration: ;
declaration: ;
modification: ;
class_modification: ;
argument_list: ;
argument: ;
element_modification: ;
element_redeclaration: ;
initial_equation_clause: ;
equation_clause: ;
equation_annotation_list: ;
algorithm_clause: ;
initial_algorithm_clause: ;
equation: ;
algorithm: ;
assign_clause_a: ;
equality_equation: ;

equation_elseif:
	ELSEIF expression THEN equation_list equation_elseif
		{ $0 = mk_cons(mk_box2(0,$2,$4), $5);}
	|
		{ $0 = mk_nil();}
	;

algorithm_elseif:
	ELSEIF expression THEN algorithm_list equation_elseif
		{ $0 = mk_cons(mk_box2(0,$2,$4), $5);}
	|
		{ $0 = mk_nil();}
	;

opt_equation_else:
	ELSE equation_list
		{ $0 = $2;}
	|
		{ $0 = mk_nil();}
	;

opt_algorithm_else:
	ELSE algorithm_list
		{ $0 = $2;}
	|
		{ $0 = mk_nil();}
	;

conditional_equation_e:
	IF expression THEN
	    equation_list
	    equation_elseif
	    opt_equation_else
	END IF
		{ $0 = Absyn__EQ_5fIF($1,$4,$5,$6);}
	;

conditional_equation_a:
	IF expression THEN
	    algorithm_list
	    algorithm_elseif
	    opt_algorithm_else
	END IF
		{ $0 = Absyn__ALG_5fIF($1,$4,$5,$6);}
	;

for_clause_e:
	FOR ident LOOP equation_list END FOR
		{ $0 = Absyn__EQ_5fFOR($2,mk_nil(),$6);}
	|
	FOR ident IN expression LOOP equation_list END FOR
		{ $0 = Absyn__EQ_5fFOR($2,$4,$6);}
	;

for_clause_a:
	FOR ident LOOP algorithm_list END FOR
		{ $0 = Absyn__ALG_5fFOR($2,mk_nil(),$6);}
	|
	FOR ident IN expression LOOP algorithm_list END FOR
		{ $0 = Absyn__ALG_5fFOR($2,$4,$6);}
	;

while_clause:
	WHILE expression LOOP algorithm_list END WHILE
		{ $0 = Absyn__ALG_5fWHILE($2,$4);}
	;

when_clause_e:
	WHEN expression THEN equation_list else_when_e END WHEN
		{ $0 = Absyn__EQ_5fWHEN_5fE($2,$4,$5);}
	;

else_when_e:
	ELSEWHEN expression THEN equation_list else_when_e
		{ $0 = mk_cons(mk_box2(0,$2,$4), $5);}
	|
		{ $0 = mk_nil();}
	;

when_clause_a:
	WHEN expression THEN algorithm_list else_when_a END WHEN
		{ $0 = Absyn__ALG_5fWHEN_5fA($2,$4,$5);}
	;

else_when_a:
	ELSEWHEN expression THEN algorithm_list else_when_e
		{ $0 = mk_cons(mk_box2(0,$2,$4), $5);}
	|
		{ $0 = mk_nil();}
	;

equation_list:
	equation SEMICOLON equation_list
		{ $0 = mk_cons($1,$3);}
	|
		{ $0 = mk_nil();}
	;

algorithm_list:
	algorithm SEMICOLON algorithm_list
		{ $0 = mk_cons($1,$3);}
	|
		{ $0 = mk_nil();}
	;

connect_clause:
	CONNECT LPAR connector_ref COMMA connector_ref RPAR
		{ $0 = Absyn__EQ_5fCONNECT($3,$5);}
	;

connector_ref:
	ident opt_array_subscripts DOT ident opt_array_subscripts
		{ $0 = Absyn__CREF_5fQUAL($1,$2,Absyn__CREF_5fIDENT($4,$5));}
	|
	ident opt_array_subscripts
		{ $0 = Absyn__CREF_5fIDENT($1,$2);}
	;

expression:
	code_expression
		{ $0 = $1;}
	|
	if_expression
		{ $0 = $1;}
	|
	simple_expression
		{ $0 = $1;}
	;

code_expression: ;
code_equation_clause: ;
code_initial_equation_clause: ;
code_algorithm_clause: ;
code_initial_algorithm_clause: ;


if_expression:
	IF expression THEN expression elseif_expression_list ELSE expression
		{ $0 = Absyn__IFEXP($2,$4,$7,$5);}
	;

elseif_expression_list:
	ELSEIF expression THEN expression elseif_expression_list
		{ $0 = mk_cons(mk_box2(0,$2,$4), $5);}
	|
		{ $0 = mk_nil();}
	;

simple_expression:
	logical_expression COLON logical_expression COLON logical_expression
		{ $0 = Absyn__RANGE($1,mk_some($3),$5);}
	|
	logical_expression COLON logical_expression
		{ $0 = Absyn__RANGE($1,mk_none(),$3);}
	|
	logical_expression
		{ $0 = $1;}
	;

logical_expression:
	logical_term OR logical_expression
		{ $0 = Absyn__LBINARY($1,Absyn__OR,$3);}
	|
	logical_term
		{ $0 = $1;}
	;

logical_term:
	logical_factor AND logical_term
		{ $0 = Absyn__LBINARY($1,Absyn__AND,$3);}
	|
	logical_factor
		{ $0 = $1;}
	;

logical_factor:
	NOT relation
		{ $0 = Absyn__LUNARY(Absyn__NOT,$2);}
	|
	relation
		{ $0 = $1;}
	;

relation:
	arithmetic_expression rel_op arithmetic_expression
		{ $0 = Absyn__RELATION($1,$2,$3);}
	;

rel_op:
	LESS		{ $0 = Absyn__LESS;}
|	LESSEQ		{ $0 = Absyn__LESSEQ;}
|	GREATER		{ $0 = Absyn__GREATER;}
|	GREATEREQ	{ $0 = Absyn__GREATEREQ;}
|	EQEQ		{ $0 = Absyn__EQUAL;}
|	LESSGT		{ $0 = Absyn__NEQUAL;}
;


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
	ident DOT name_path { $0 = Absyn__QUALIFIED($1, $3);}
	|
	ident { $0 = Absyn__IDENT($1);}
	;

component_reference:
	ident opt_array_subscripts DOT component_reference
		{ $0 = Absyn__CREF_5fQUAL($1,$2,$4);}
	|
	ident opt_array_subscripts
		{ $0 = Absyn__CREF_5fIDENT($1,$2);}
	;

function_call:
	LPAR function_arguments RPAR
		{ $0 = $2;}
	;

function_arguments:
	for_or_expression_list
	opt_named_arguments
		{ /* FIXME */;}
	;

opt_named_arguments:
	named_arguments
		{ /* FIXME */; }
	|
		{ $0 = mk_nil();}
	;

for_or_expression_list:
	expression COMMA expression_list
		{ $0 = mk_cons($1,$2);}
	|
	expression FOR IDENT IN expression
		{ $0 = Absyn__FOR_5fITER_5fFARG($1,$3,$5);}
	|
	expression FOR IDENT
		{ $0 = Absyn__FOR_5fITER_5fFARG($1,$3,mk_nil());}
	;

named_arguments:
	named_argument named_arguments
		{ $0 = mk_cons($1,$2);}
	|
		{ $0 = mk_nil();}
	;

named_arguments2: { /* ANTLR relic? should this rule do anything? */};

named_argument:
	IDENT EQUALS expression
		{ $0 = Absyn__NAMEDARG(to_rml_str($1),$3);}
	;

expression_list:
	expression COMMA expression_list
		{ $0 = mk_cons($1,$3);}
	|
	expression
		{ $0 = mk_cons($1,mk_nil());}
	;

comment:
	string_comment opt_annotation
		{ $0 = mk_some(Absyn__COMMENT($2, $1));}
	|
		{ $0 = mk_none();}
	;

string_comment:
		{ parserCommentBuffer[0] = 0;}
	string_concats
		{ $0 = mk_some(to_rml_str(parserCommentBuffer));}
	;

string_comment_part:
	STRING
		{
		    if (strlen(yaccCommentBuffer)+strlen($1) < MAXCOMMENT)
			strcat(yaccCommentBuffer, $1);
		}
	;

string_concats:
	string_part PLUS string_concats
	|
	string_part
	;
		    
annotation:
	ANNOTATION class_modification
		{ $0 = Absyn__ANNOTATION($2);}
	;

opt_annotation:
	annotation
		{ $0 = $1;}
	|
		{ $0 = mk_none();}
	;

ident:
	IDENT
		{ $0 = to_rml_string($1);}
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

#define PCOMMENTBUF 2000

static char parserCommentBuffer[PCOMMENTBUF+10];

#define MAXPOSINDEX   50
static int posIndex  = 0;
static int posLineNo[MAXPOSINDEX+1];

void positionPush()
{
    if (++posIndex > 50)
	yyerror("Internal error: positionPush(): overflow.\n");
    posLineNo[posIndex] = yylineno;
}

void positionPop()
{
    if (--posIndex < 0)
	yyerror("Internal error: positionPop(): underflow.\n");
}

int positionLineNo()
{
    return posLineNo[posIndex];
}

char *positionFileName()
{
    return "NoFile";
}

void *parser_make_element(int   is_final,
			  void *innerouter,
			  int   is_replaceable,
			  void *classdef,
			  void *componentclause,
			  void *constraint,
			  void *comment)
{
    void *final      = is_final ? RML_TRUE : RML_FALSE;
    void *replacable = is_replaceable ? RML_TRUE : RML_FALSE;

    if (component_clause)
    {
	/* Declaration. */
	return Absyn__ELEMENT(final,
			      replaceable,
			      is_replaceable ? Absyn__UNSPECIFIED : innerouter,
			      mk_scon(is_replacable ? "replaceable component"
                                                    : "component"),
			      componentclause,
			      mk_scon(positionFileName()),
			      mk_scon(positionLineNo()),
			      constraint ? mk_some(constraint) : mk_none());
    }
    else if (classdef)
    {
	/* Definition. */
	return Absyn__ELEMENT(final,
			      replaceable,
			      is_replaceable ? Absyn__UNSPECIFIED : innerouter,
			      mk_scon(is_replacable ? "?replaceable classdef?"
                                                    : "?classdef?"),
			      Absyn__CLASSDEF(replaceable, classdef),
			      mk_scon(positionFileName()),
			      mk_scon(positionLineNo()),
			      constraint ? mk_some(constraint) : mk_none());

    }
    else
	yyerror("Internal error in parser_make_element().\n");
}

void **tempQuadMake(void *v1, void *v2, void *v3, void *v4)
{
    void **quad = malloc(sizeof(void *)*4);
    if (!quad)
	yyerror("Out of memory.");
    quad[0] = v1;
    quad[1] = v2;
    quad[2] = v3;
    quad[3] = v4;
    return quad;
}

void *tempQuadGet(void **quad, int element)
{
    if (!quad || element < 0 || element > 3)
	yyerror("Internal error: tempQuadGet(): bad arguments.");
    return quad[element];
}

void tempQuadFree(void **quad)
{
    if (quad)
	free(quad);
}