(* RMLParseFn.sml *)

functor RMLParseFn(structure Absyn : ABSYN
		structure RMLParser : ARG_PARSER
				      where type arg = 
							   (int*int) -> 
							   {fileName: string, sline:int, scolumn:int, eline:int, ecolumn:int}
					  and type pos = int
		structure Tokens : RML_TOKENS
		structure LexArg : LEXARG
		structure MOToRML : PARSE
		structure Control : CONTROL
		sharing type Tokens.token = RMLParser.Token.token
		sharing type Tokens.svalue = RMLParser.svalue
		sharing type RMLParser.result = Absyn.module = MOToRML.Absyn.module
		sharing type Absyn.modelica = MOToRML.Absyn.modelica
		sharing type Absyn.Package = MOToRML.Absyn.Package		
		sharing type RMLParser.lexarg = LexArg.lexarg
		sharing Absyn.Source = LexArg.Source
		(*sharing MOToRML.Absyn = Absyn*)		
		  ) : PARSE =
  struct
  
    structure Absyn = Absyn

    fun parse(startToken, file) =
      let val is = TextIO.openIn file
      in
	(let val (lexarg, inputf) = LexArg.new(file, is)
	     val pos = 2	(*XXX: ML-Lex*)
	     val lexer = RMLParser.makeLexer inputf lexarg
	     val lexer = RMLParser.Stream.cons(startToken(pos,pos), lexer)
	     val (result,_) = 
			RMLParser.parse(
				0,
				lexer,
				LexArg.error2 lexarg,
				LexArg.getLoc lexarg)
	 in
	   if LexArg.seenErr lexarg then raise RMLParser.ParseError else ();
	   TextIO.closeIn is;
	   let val Absyn.MODULE(
					Absyn.INTERFACE({modid,specs,...}, infoI), decs, infoM) = result
	       val interface = Absyn.INTERFACE({modid=modid,specs=specs,
					       source=LexArg.source lexarg}, 
					       infoI)
	   in
	     Absyn.MODULE(interface, decs, infoM)
	   end
	 end) handle e => (TextIO.closeIn is; raise e)
      end

    fun parseModule    file = parse(Tokens.START_MODULE,    file)
    fun parseInterface file = parse(Tokens.START_INTERFACE, file)

    fun mo2rmlmodule           (module) = MOToRML.mo2rmlmodule           (module) 
    fun mo2rmlinterface        (module) = MOToRML.mo2rmlinterface        (module) 
    fun mo2imports             (module) = MOToRML.mo2imports             (module)
	fun mo2recordconstructors  (module) = MOToRML.mo2recordconstructors  (module)	
    
  end (* functor ParseFn *)
