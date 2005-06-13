(* RMLParse.sml *)

structure RMLParse =
  RMLParseFn(
	  structure Absyn = Absyn
	  structure RMLParser = RMLParser
	  structure Tokens = RMLLrVals.Tokens
	  structure LexArg = LexArg
	  structure MOToRML = MOToRML
	  structure Control = Control);

