(* parse.sml *)

functor ParseFun(structure Scan : SCAN) : PARSE =
  struct

    datatype Point	= POINT of string * int	(* <scon><icon> *)
    datatype Command	= ALLBREAKS		(* $b *)
			| ALLCLEAR		(* :z *)
			| ALLVARS		(* $r *)
			| BREAK of Point	(* <point>:b *)
			| CLEAR of Point	(* <point>:d *)
			| CONTINUE		(* :c *)
			| DOWN			(* $d *)
			| HELP			(* ? *)
			| PRINT of string	(* <ident>/p *)
			| QUIT			(* $q *)
			| STEP			(* :s *)
			| UP			(* $u *)
			| WHERE			(* $c *)

    fun sayOut s = TextIO.output(TextIO.stdOut, s)
    fun flushOut() = TextIO.flushOut TextIO.stdOut

    structure Token = Scan.UserDeclarations

    fun parser scan =
      let fun expected(wanted, got) =
	    (sayOut "Expected: "; sayOut wanted; sayOut ", got: ";
	     sayOut(Token.tokStr got); sayOut "\^G\n"; skipLine got)
	  and skipLine(Token.NEWLINE) = prompt()
	    | skipLine(Token.EOF) = QUIT
	    | skipLine(_) = skipLine(scan())
	  and prompt() = (sayOut "rdb> "; flushOut(); command())
	  and command() =
	    case scan()
	      of Token.ALLBREAKS => newline ALLBREAKS
	       | Token.ALLCLEAR => newline ALLCLEAR
	       | Token.ALLVARS => newline ALLVARS
	       | Token.CONTINUE => newline CONTINUE
	       | Token.DOWN => newline DOWN
	       | Token.EOF => QUIT
	       | Token.HELP => newline HELP
	       | Token.IDENT id => afterIdent id
	       | Token.NEWLINE => prompt()
	       | Token.QUIT => newline QUIT
	       | Token.SCON str => afterSCon str
	       | Token.STEP => newline STEP
	       | Token.UP => newline UP
	       | Token.WHERE => newline WHERE
	       | tok => expected("<command>", tok)
	  and afterSCon str =
	    case scan()
	      of Token.ICON i => afterPoint(POINT(str,i))
	       | tok => expected("<icon>", tok)
	  and afterPoint pt =
	    case scan()
	      of Token.BREAK => newline(BREAK pt)
	       | Token.CLEAR => newline(CLEAR pt)
	       | tok => expected(":b or :d", tok)
	  and afterIdent id =
	    case scan()
	      of Token.PRINT => newline(PRINT id)
	       | tok => expected("/p", tok)
	  and newline cmd =
	    case scan()
	      of Token.NEWLINE => cmd
	       | Token.EOF => cmd
	       | tok => expected("<newline>", tok)
      in
	prompt()
      end

    fun parse() = parser(Scan.makeLexer(fn _ => TextIO.inputLine TextIO.stdIn))

  end (* functor ParseFun *)
