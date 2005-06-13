(* MODParseFn.sml *)

functor MODParseFn(structure Absyn : ABSYN
		structure MODParser : ARG_PARSER
				      where type arg = 
							   (int*int) -> 
							   {fileName: string, sline:int, scolumn:int, eline:int, ecolumn:int}
					  and type pos = int
		structure Tokens : MOD_TOKENS
		structure LexArg : LEXARG
		structure MOToRML : PARSE
		sharing type Tokens.token = MODParser.Token.token
		sharing type Tokens.svalue = MODParser.svalue
		sharing type MODParser.result = Absyn.modelica = MOToRML.Absyn.modelica
		sharing type Absyn.module = MOToRML.Absyn.module
		sharing type Absyn.Package = MOToRML.Absyn.Package 
		sharing type MODParser.lexarg = LexArg.lexarg
		sharing Absyn.Source = LexArg.Source
		(* sharing MOToRML.Absyn = Absyn *)
		  ) : PARSE =
  struct
    structure Absyn = Absyn

	val debugFlag = false
	fun debug s = if (debugFlag) then print ("MODParseFn."^s) else ()	

    fun parse(startToken, file) =
    let val is = TextIO.openIn file
		(* val _ = print ("parsing file: "^file^"\n") *)
    in
	(let val (lexarg, inputf) = LexArg.new(file, is)
	     val pos = 2	(*XXX: ML-Lex*)
	     val lexer = MODParser.makeLexer inputf lexarg
	     val lexer = MODParser.Stream.cons(startToken(pos,pos), lexer)
	     val (result,_) = 
			MODParser.parse(
				0,
				lexer,
				LexArg.error2 lexarg,
				LexArg.getLoc lexarg)
	 in
	   if LexArg.seenErr lexarg then raise MODParser.ParseError else ();
	   TextIO.closeIn is;
	   let val Absyn.MODELICA(
				Absyn.PROGRAM(
				 classes,
				 within, 
				 Absyn.INTERFACE({modid,specs,...}, infoI), 
				 infoM),
				 _) = result
	       val interface = Absyn.INTERFACE({modid=modid,specs=specs,
					       source=LexArg.source lexarg}, 
					       infoI)				 
	   in
	     Absyn.MODELICA(
			Absyn.PROGRAM(
				classes,
				within,
				interface, infoM),
			[])
	   end
	end) handle e => (TextIO.closeIn is; raise e)
    end

	fun mo2rmlmodule(module)          = MOToRML.mo2rmlmodule(module)
	fun mo2rmlinterface(module)       = MOToRML.mo2rmlinterface(module)
	fun mo2imports(module)            = MOToRML.mo2imports(module)
	fun mo2recordconstructors(module) = MOToRML.mo2recordconstructors(module)	

    fun parseModule    file = 
		let val _ = debug("parsing main file: "^file^"\n");
			val (importList, modelica) = mo2imports(parse(Tokens.START_MODELICA,  file))
			val Absyn.MODELICA(program, _) = modelica		
		    fun loop([]) = []
		    |   loop(importFile::rest) =
				 (
				 debug("parsing imported file: "^importFile^"\n");		    
				 mo2recordconstructors(parse(Tokens.START_MODELICA, importFile)) @ loop(rest)
				 )
		in
		  mo2rmlmodule(Absyn.MODELICA(program, mo2recordconstructors(modelica) @ loop(importList)))
		end
		
    fun parseInterface file = 
		let val _ = debug("parsing interface of file: "^file^"\n");
		in
			mo2rmlinterface (parse(Tokens.START_MODELICA,  file))
		end
  end (* functor MODParseFn *)
