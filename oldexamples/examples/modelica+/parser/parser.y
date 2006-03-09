/* parser */

%token EOF
%token AMPERSAND AND AS AXIOM 
%token BAR 
%token CCON COLON COLONCOLON COMMA 
%token DASHES DATATYPE DEFAULT DOT
%token END EQ EQTYPE 
%token FAIL FATARROW 
%token ICON IDENT 
%token LBRACK LET LPAREN MODULE 
%token NOT 
%token OF 
%token RCON RELATION RBRACK RPAREN RULE
%token SCON STAR START_INTERFACE
%token TYPE TYVAR
%token VAL
%token WILD WITH WITHTYPE
%token ADD_INT SUB_INT NEG_INT DIV_INT MOD_INT EQEQ_INT GE_INT GT_INT LE_INT LT_INT NE_INT
%token ADD_REAL SUB_REAL NEG_REAL MUL_REAL DIV_REAL MOD_REAL POW_REAL EQ_REAL GE_REAL GT_REAL LE_REAL LT_REAL NE_REAL
%token ADD_STRING ADD_LIST
%token SEMICOLON LBRACE RBRACE POWER 
%token ASSIGN ALGORITHM ANNOTATION 
%token BLOCK BOUNDARY 
%token CODE CLASS CONNECT CONNECTOR CONSTANT DISCRETE
%token EACH ELSE ELSEIF ELSEWHEN ENUMERATION EQUATION ENCAPSULATED EXTENDS EXTERNAL
%token FALSE TRUE	
%token FINAL FLOW FOR FUNCTION
%token IF IMPORT IN INITIAL INNER INPUT
%token LOOP
%token MODEL
%token OUTER OVERLOAD OR OUTPUT
%token PACKAGE PARAMETER PARTIAL PROTECTED PUBLIC 
%token RECORD REDECLARE REPLACEABLE RESULTS
%token THEN 
%token WHEN WHILE WITHIN
%token UNIONTYPE
%token MATCH CASE LOCAL 
%token DOTSTAR
%token START_MODELICA START_MODULE START_INTERFACE

%left ADD_INT SUB_INT ADD_STRING ADD_LIST
%left STAR DIV_INT

%left ADD_REAL SUB_REAL
%left MUL_REAL DIV_REAL

%right POW_REAL

/* %glr-parser */
%%

start: 
	stored_definition 

/* SHORT IDENTIFIERS */
ident: 
	IDENT
	;

/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/
/*                adrpo added Modelica+ grammar                    */
/*-----------------------------------------------------------------*/
/*-----------------------------------------------------------------*/

/* last rule is the normal case, all the others are handling split models */
stored_definition: 
	| within_clause class_definition_list EOF
	;

optENCAPSULATED:
	ENCAPSULATED 
	| /* empty */
	;	

optPARTIAL:
	PARTIAL 
	| /* empty */ 
	;
	
optFINAL:
	FINAL 
	| /* empty */
	;
	
optEACH:
	EACH 
	| /* empty */
	;	
			
within_clause:
	WITHIN name_path SEMICOLON
	| /* empty */
	;
	
class_definition_list:
	optFINAL class_definition SEMICOLON class_definition_list
	| /* empty */
	;
	
/* the FINAL prefix gets patched one level UP by fixClassDefinition function */
class_definition:
	optENCAPSULATED optPARTIAL class_type ident class_specifier
	;
	
class_type: CLASS|MODEL|RECORD|BLOCK|CONNECTOR|TYPE|PACKAGE|FUNCTION;

base_prefix:
	flow_prefix variability_prefix direction_prefix
	;	

class_specifier:
	string_comment composition END IDENT
	| EQ base_prefix name_path opt_array_subscripts class_modification comment
	| EQ enumeration
	| EQ overloading
	;
	
enumeration:
	ENUMERATION LPAREN enum_list RPAREN comment
	;	

enum_list:
	enumeration_literal COMMA enum_list
	| enumeration_literal
	;

enumeration_literal:
	ident comment
	;	

overloading:
	OVERLOAD LPAREN name_path_list RPAREN comment
	;	

name_path_list:
	name_path COMMA name_path_list
	| name_path
	;	
	
flow_prefix:
	FLOW
	| /* empty */
	;

variability_prefix: DISCRETE|PARAMETER|CONSTANT|/* empty */;

direction_prefix: INPUT|OUTPUT|/* empty */;

component_clause:
	flow_prefix variability_prefix direction_prefix type_specifier array_subscripts component_list
	;	

component_clause1:
	flow_prefix variability_prefix direction_prefix type_specifier component_declaration
	;
	
import_clause:
	IMPORT explicit_import_name comment
	| IMPORT implicit_import_name comment
	;	

explicit_import_name:
	ident EQ name_path
	;	

implicit_import_name:
	name_path DOTSTAR
	| name_path
	;
		
composition:
	element_list composition_sublist
	;
		
composition_sublist:
	PUBLIC element_list composition_sublist
	| PROTECTED element_list composition_sublist
	| equation_clause composition_sublist
	| initial_equation_clause composition_sublist
	| algorithm_clause composition_sublist
	| initial_algorithm_clause composition_sublist
	| opt_external_clause
	;
	
opt_annotation_semicolon:
	annotation SEMICOLON
	| /* empty */
	;
	
opt_external_clause:
	EXTERNAL external_function_call opt_annotation_semicolon opt_annotation_semicolon
	| /* empty */ 
	;
		
language_specification:
	SCON
	;
		
opt_language_specification:
	language_specification
	|
	;
	
opt_component_reference:
	component_reference
	|
	;
	
external_function_call:
	opt_language_specification opt_component_reference EQ ident LPAREN opt_expression_list RPAREN
	| opt_language_specification ident LPAREN opt_expression_list RPAREN
	;
		
opt_expression_list:
	expression_list
	| /* empty */
	;
		
element_list:
	  element SEMICOLON element_list
	| annotation SEMICOLON element_list
	| /* empty */
	;	

element:
	  import_clause
	| extends_clause
	| optFINAL inner_outer REPLACEABLE class_definition opt_constraining_clause comment
	| optFINAL inner_outer class_definition
	| optFINAL inner_outer REPLACEABLE component_clause opt_constraining_clause comment
	| optFINAL inner_outer component_clause
	;
	
inner_outer: INNER|OUTER|INNER OUTER|/* empty */;

subscript:
	expression
	| COLON
	;	

subscript_list:
	subscript COMMA subscript_list
	| subscript
	;	

array_subscripts:
	LBRACK subscript_list RBRACK
	;	

opt_array_subscripts:
	array_subscripts
	|
	;	

type_specifier:
	name_path
	;	

component_list:
	component_declaration COMMA component_list
	| component_declaration
	;	

component_declaration:
	declaration comment
	;	

declaration:
	ident array_subscripts opt_modification
	;
			
modification:
	class_modification EQ expression
	| class_modification
	| EQ expression
	| ASSIGN expression
	;	

opt_modification:
	modification
	|
	;
	
class_modification:
	LPAREN argument_list RPAREN
	| LPAREN RPAREN
	;	
	
argument_list:
	argument COMMA argument_list
	| argument
	;
	
argument:
	optEACH optFINAL component_reference opt_modification string_comment
	| REDECLARE optEACH optFINAL REPLACEABLE class_definition opt_constraining_clause
	| REDECLARE optEACH optFINAL REPLACEABLE component_clause1 opt_constraining_clause
	| REDECLARE optEACH optFINAL class_definition
	| REDECLARE optEACH optFINAL component_clause1
	;
		
initial_equation_clause:
	INITIAL EQUATION equation_annotation_list
	;	

equation_clause:
	EQUATION equation_annotation_list
	;	

equation_annotation_list:
	  equation SEMICOLON equation_annotation_list
	| annotation SEMICOLON equation_annotation_list
	| /* empty */
	;
		
constraining_clause:
	extends_clause
	;	

opt_constraining_clause:
	constraining_clause
	|
	;
		
extends_clause:
	EXTENDS name_path class_modification
	;	

algorithm_clause:
	ALGORITHM algorithm_annotation_list
	;	

initial_algorithm_clause:
	INITIAL ALGORITHM algorithm_annotation_list
	;	

algorithm_annotation_list:
	algorithm SEMICOLON algorithm_annotation_list
	| annotation SEMICOLON algorithm_annotation_list
	|
	;
		
equation:
	simple_expression EQ expression comment
	| conditional_equation_e comment
	| for_clause_e comment
	| connect_clause comment
	| when_clause_e comment
	| ident function_call comment
	;	

algorithm:
	component_reference ASSIGN expression comment
	| LPAREN expression_list RPAREN ASSIGN component_reference function_call comment
	| conditional_equation_a comment
	| for_clause_a comment
	| while_clause comment
	| when_clause_a comment
	;	

equation_elseif:
	ELSEIF expression THEN equation_list equation_elseif
	|
	;	

algorithm_elseif:
	ELSEIF expression THEN algorithm_list algorithm_elseif
	|
	;	

opt_equation_else:
	ELSE equation_list
	|
	;	

opt_algorithm_else:
	ELSE algorithm_list
	|
	;	

conditional_equation_e:
	IF expression THEN equation_list equation_elseif opt_equation_else END IF
	;	

conditional_equation_a:
	IF expression THEN algorithm_list algorithm_elseif opt_algorithm_else END IF
	;
		
for_indices:
	for_indice COMMA for_indices
	| for_indice
	;
		
for_indice:
	ident
	| ident IN expression
	;
	
for_clause_e:
	FOR for_indices LOOP equation_list END FOR
	;
	
for_clause_a:
	FOR for_indices LOOP algorithm_list END FOR
	;	

while_clause:
	WHILE expression LOOP algorithm_list END WHILE
	;	

when_clause_e:
	WHEN expression THEN equation_list else_when_e END WHEN
	;	

else_when_e:
	ELSEWHEN expression THEN equation_list else_when_e
	|
	;	

when_clause_a:
	WHEN expression THEN algorithm_list else_when_a END WHEN
	;	

else_when_a:
	ELSEWHEN expression THEN algorithm_list else_when_a
	|
	;	

equation_list:
	equation SEMICOLON equation_list
	|
	;	

algorithm_list:
	algorithm SEMICOLON algorithm_list
	|
	;	

connect_clause:
	CONNECT LPAREN component_reference COMMA component_reference RPAREN
	;	

expression:
	  if_expression
	| simple_expression
	;
	
if_expression:
	IF expression THEN expression elseif_expression_list ELSE expression
	;

elseif_expression_list:
	ELSEIF expression THEN expression elseif_expression_list
	|
	;
	
simple_expression:
	logical_expression COLON logical_expression COLON logical_expression
	| logical_expression COLON logical_expression
	| logical_expression
	;
	
logical_expression:
	logical_term OR logical_expression
	| logical_term
	;	

logical_term:
	logical_factor AND logical_term
	| logical_factor
	;	

logical_factor:
	NOT relation
	| relation
	;	

relation:
	arithmetic_expression rel_op arithmetic_expression
	;	

rel_op:
	LT_INT|LE_INT|GT_INT|GE_INT|EQEQ_INT|NE_INT;

arithmetic_expression:
	unary_arithmetic_expression
	| unary_arithmetic_expression ADD_INT arithmetic_expression
	| unary_arithmetic_expression SUB_INT arithmetic_expression	
	;
	
unary_arithmetic_expression:
	ADD_INT term 
	| SUB_INT term 
	| term 
	;
	
term:
	factor STAR term 
	| factor DIV_INT term 
	| factor
	;

factor:
	primary POWER primary
	| primary
	;

expression_matrix_list:
	expression_list SEMICOLON expression_matrix_list
	| expression_list
	;	

expression_matrix:
	expression_matrix_list
	;	

primary:
	ICON 
	| RCON 
	| SCON 
	| FALSE
	| TRUE 
	| component_ref_function_call 
	| LPAREN expression_list RPAREN 
	| LBRACK expression_matrix RBRACK 
	| LBRACE expression_list RBRACE 
	| LBRACE function_arguments RBRACE
	;	

component_ref_function_call:
	component_reference function_call
	| component_reference
	| INITIAL LPAREN RPAREN
	;	

name_path:
	IDENT DOT name_path 
	| IDENT
	;

component_reference:
	ident array_subscripts DOT component_reference
	| ident array_subscripts
	;
	
function_call:
	LPAREN function_arguments RPAREN
	;	

function_arguments:
	  expression_list FOR for_indices
	| expression_list named_arguments
	;
	
named_arguments:
	named_argument named_arguments
	|
	;
	
named_argument:
	ident EQ expression
	;	

expression_list:
	expression COMMA expression_list
	| expression
	;	

comment:
	string_comment opt_annotation
	|
	;	

string_comment:
	  SCON
	| SCON string_comment_add
	; 
	
string_comment_add:
	  ADD_INT string_comment
	;	
		    
annotation:
	ANNOTATION class_modification
	;
		
opt_annotation
    : annotation
	| /* empty */
	;
	