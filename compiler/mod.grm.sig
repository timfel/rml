signature MOD_TOKENS =
sig
type ('a,'b) token
type svalue
val UNARY:  'a * 'a -> (svalue,'a) token
val START_MODELICA:  'a * 'a -> (svalue,'a) token
val LIST:  'a * 'a -> (svalue,'a) token
val DOTSTAR:  'a * 'a -> (svalue,'a) token
val LOCAL:  'a * 'a -> (svalue,'a) token
val CASE:  'a * 'a -> (svalue,'a) token
val MATCHCONTINUE:  'a * 'a -> (svalue,'a) token
val MATCH:  'a * 'a -> (svalue,'a) token
val UNIONTYPE:  'a * 'a -> (svalue,'a) token
val EQUALITY:  'a * 'a -> (svalue,'a) token
val FAILURE:  'a * 'a -> (svalue,'a) token
val TUPLE:  'a * 'a -> (svalue,'a) token
val WITHIN:  'a * 'a -> (svalue,'a) token
val WHILE:  'a * 'a -> (svalue,'a) token
val WHEN:  'a * 'a -> (svalue,'a) token
val THEN:  'a * 'a -> (svalue,'a) token
val RESULTS:  'a * 'a -> (svalue,'a) token
val REPLACEABLE:  'a * 'a -> (svalue,'a) token
val REDECLARE:  'a * 'a -> (svalue,'a) token
val RECORD:  'a * 'a -> (svalue,'a) token
val PUBLIC:  'a * 'a -> (svalue,'a) token
val PROTECTED:  'a * 'a -> (svalue,'a) token
val PARTIAL:  'a * 'a -> (svalue,'a) token
val PARAMETER:  'a * 'a -> (svalue,'a) token
val PACKAGE:  'a * 'a -> (svalue,'a) token
val OUTPUT:  'a * 'a -> (svalue,'a) token
val OR:  'a * 'a -> (svalue,'a) token
val OUTER:  'a * 'a -> (svalue,'a) token
val MODEL:  'a * 'a -> (svalue,'a) token
val LOOP:  'a * 'a -> (svalue,'a) token
val INPUT:  'a * 'a -> (svalue,'a) token
val INNER:  'a * 'a -> (svalue,'a) token
val IN:  'a * 'a -> (svalue,'a) token
val IMPORT:  'a * 'a -> (svalue,'a) token
val IF:  'a * 'a -> (svalue,'a) token
val FUNCTION:  'a * 'a -> (svalue,'a) token
val FOR:  'a * 'a -> (svalue,'a) token
val FLOW:  'a * 'a -> (svalue,'a) token
val FINAL:  'a * 'a -> (svalue,'a) token
val TRUE:  'a * 'a -> (svalue,'a) token
val FALSE:  'a * 'a -> (svalue,'a) token
val EXTERNAL:  'a * 'a -> (svalue,'a) token
val EXTENDS:  'a * 'a -> (svalue,'a) token
val ENCAPSULATED:  'a * 'a -> (svalue,'a) token
val EQUATION:  'a * 'a -> (svalue,'a) token
val ENUMERATION:  'a * 'a -> (svalue,'a) token
val ELSEWHEN:  'a * 'a -> (svalue,'a) token
val ELSEIF:  'a * 'a -> (svalue,'a) token
val ELSE:  'a * 'a -> (svalue,'a) token
val EACH:  'a * 'a -> (svalue,'a) token
val DISCRETE:  'a * 'a -> (svalue,'a) token
val CONSTANT:  'a * 'a -> (svalue,'a) token
val CONNECTOR:  'a * 'a -> (svalue,'a) token
val CONNECT:  'a * 'a -> (svalue,'a) token
val CLASS:  'a * 'a -> (svalue,'a) token
val CODE:  'a * 'a -> (svalue,'a) token
val BOUNDARY:  'a * 'a -> (svalue,'a) token
val BLOCK:  'a * 'a -> (svalue,'a) token
val ANNOTATION:  'a * 'a -> (svalue,'a) token
val ALGORITHM:  'a * 'a -> (svalue,'a) token
val POWER:  'a * 'a -> (svalue,'a) token
val ASSIGN:  'a * 'a -> (svalue,'a) token
val RBRACE:  'a * 'a -> (svalue,'a) token
val LBRACE:  'a * 'a -> (svalue,'a) token
val SEMICOLON:  'a * 'a -> (svalue,'a) token
val ADD_LIST:  'a * 'a -> (svalue,'a) token
val EQEQ_STRING:  'a * 'a -> (svalue,'a) token
val ADD_STRING:  'a * 'a -> (svalue,'a) token
val NE_REAL:  'a * 'a -> (svalue,'a) token
val LT_REAL:  'a * 'a -> (svalue,'a) token
val LE_REAL:  'a * 'a -> (svalue,'a) token
val GT_REAL:  'a * 'a -> (svalue,'a) token
val GE_REAL:  'a * 'a -> (svalue,'a) token
val EQEQ_REAL:  'a * 'a -> (svalue,'a) token
val POW_REAL:  'a * 'a -> (svalue,'a) token
val MOD_REAL:  'a * 'a -> (svalue,'a) token
val DIV_REAL:  'a * 'a -> (svalue,'a) token
val MUL_REAL:  'a * 'a -> (svalue,'a) token
val NEG_REAL:  'a * 'a -> (svalue,'a) token
val SUB_REAL:  'a * 'a -> (svalue,'a) token
val ADD_REAL:  'a * 'a -> (svalue,'a) token
val NE_INT:  'a * 'a -> (svalue,'a) token
val LT_INT:  'a * 'a -> (svalue,'a) token
val LE_INT:  'a * 'a -> (svalue,'a) token
val GT_INT:  'a * 'a -> (svalue,'a) token
val GE_INT:  'a * 'a -> (svalue,'a) token
val EQEQ_INT:  'a * 'a -> (svalue,'a) token
val MOD_INT:  'a * 'a -> (svalue,'a) token
val DIV_INT:  'a * 'a -> (svalue,'a) token
val NEG_INT:  'a * 'a -> (svalue,'a) token
val SUB_INT:  'a * 'a -> (svalue,'a) token
val ADD_INT:  'a * 'a -> (svalue,'a) token
val WILD:  'a * 'a -> (svalue,'a) token
val TYPE:  'a * 'a -> (svalue,'a) token
val STAR:  'a * 'a -> (svalue,'a) token
val SCON: (string) *  'a * 'a -> (svalue,'a) token
val RPAREN:  'a * 'a -> (svalue,'a) token
val RBRACK:  'a * 'a -> (svalue,'a) token
val RCON: (real) *  'a * 'a -> (svalue,'a) token
val OF:  'a * 'a -> (svalue,'a) token
val NOT:  'a * 'a -> (svalue,'a) token
val LPAREN:  'a * 'a -> (svalue,'a) token
val LBRACK:  'a * 'a -> (svalue,'a) token
val IDENT: (string) *  'a * 'a -> (svalue,'a) token
val ICON: (int) *  'a * 'a -> (svalue,'a) token
val FAIL:  'a * 'a -> (svalue,'a) token
val EQEQ:  'a * 'a -> (svalue,'a) token
val EQ:  'a * 'a -> (svalue,'a) token
val EOF_SOFT:  'a * 'a -> (svalue,'a) token
val EOF_HARD:  'a * 'a -> (svalue,'a) token
val END:  'a * 'a -> (svalue,'a) token
val DOT:  'a * 'a -> (svalue,'a) token
val COMMA:  'a * 'a -> (svalue,'a) token
val COLONCOLON:  'a * 'a -> (svalue,'a) token
val COLON:  'a * 'a -> (svalue,'a) token
val BAR:  'a * 'a -> (svalue,'a) token
val AS:  'a * 'a -> (svalue,'a) token
val AND:  'a * 'a -> (svalue,'a) token
end
signature MOD_LRVALS=
sig
structure Tokens : MOD_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
