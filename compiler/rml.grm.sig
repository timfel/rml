signature RML_TOKENS =
sig
type ('a,'b) token
type svalue
val UNARY:  'a * 'a -> (svalue,'a) token
val ADD_LIST:  'a * 'a -> (svalue,'a) token
val ADD_STRING:  'a * 'a -> (svalue,'a) token
val NE_REAL:  'a * 'a -> (svalue,'a) token
val LT_REAL:  'a * 'a -> (svalue,'a) token
val LE_REAL:  'a * 'a -> (svalue,'a) token
val GT_REAL:  'a * 'a -> (svalue,'a) token
val GE_REAL:  'a * 'a -> (svalue,'a) token
val EQ_REAL:  'a * 'a -> (svalue,'a) token
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
val WITHTYPE:  'a * 'a -> (svalue,'a) token
val WITH:  'a * 'a -> (svalue,'a) token
val WILD:  'a * 'a -> (svalue,'a) token
val VAL:  'a * 'a -> (svalue,'a) token
val TYVAR: (string) *  'a * 'a -> (svalue,'a) token
val TYPE:  'a * 'a -> (svalue,'a) token
val START_INTERFACE:  'a * 'a -> (svalue,'a) token
val START_MODULE:  'a * 'a -> (svalue,'a) token
val STAR:  'a * 'a -> (svalue,'a) token
val SCON: (string) *  'a * 'a -> (svalue,'a) token
val RULE:  'a * 'a -> (svalue,'a) token
val RPAREN:  'a * 'a -> (svalue,'a) token
val RBRACK:  'a * 'a -> (svalue,'a) token
val RELATION:  'a * 'a -> (svalue,'a) token
val RCON: (real) *  'a * 'a -> (svalue,'a) token
val OF:  'a * 'a -> (svalue,'a) token
val NOT:  'a * 'a -> (svalue,'a) token
val MODULE:  'a * 'a -> (svalue,'a) token
val LPAREN:  'a * 'a -> (svalue,'a) token
val LET:  'a * 'a -> (svalue,'a) token
val LBRACK:  'a * 'a -> (svalue,'a) token
val IDENT: (string) *  'a * 'a -> (svalue,'a) token
val ICON: (int) *  'a * 'a -> (svalue,'a) token
val FATARROW:  'a * 'a -> (svalue,'a) token
val FAIL:  'a * 'a -> (svalue,'a) token
val EQTYPE:  'a * 'a -> (svalue,'a) token
val EQ:  'a * 'a -> (svalue,'a) token
val EOF_SOFT:  'a * 'a -> (svalue,'a) token
val EOF_HARD:  'a * 'a -> (svalue,'a) token
val END:  'a * 'a -> (svalue,'a) token
val DOT:  'a * 'a -> (svalue,'a) token
val DEFAULT:  'a * 'a -> (svalue,'a) token
val DATATYPE:  'a * 'a -> (svalue,'a) token
val DASHES:  'a * 'a -> (svalue,'a) token
val COMMA:  'a * 'a -> (svalue,'a) token
val COLONCOLON:  'a * 'a -> (svalue,'a) token
val COLON:  'a * 'a -> (svalue,'a) token
val CCON: (char) *  'a * 'a -> (svalue,'a) token
val BAR:  'a * 'a -> (svalue,'a) token
val AXIOM:  'a * 'a -> (svalue,'a) token
val AS:  'a * 'a -> (svalue,'a) token
val AND:  'a * 'a -> (svalue,'a) token
val AMPERSAND:  'a * 'a -> (svalue,'a) token
end
signature RML_LRVALS=
sig
structure Tokens : RML_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
