(* lexer/lexarg.sml *)

functor LexArgFn(structure Source : SOURCE) : LEXARG =
  struct

    structure Source = Source

    type pos = int
    datatype lexarg
      = A of {	
		fileName	: string,
		newLines	: int list ref,
		thisLine	: pos ref,
		leftPos		: pos ref,
		strList		: string list ref,
		comLev		: int ref,
		eofFlag		: bool ref,
		errFlag		: bool ref,
		readPos		: int ref }

    fun new(fileName, is) =
      let val readPos = ref 2	(*XXX: ML-Lex*)
	  fun yyinput n =
	    let val string = TextIO.inputN(is, n)
		val _ = readPos := !readPos + String.size string
	    in
	      string
	    end
	  val lexarg =
	    A{fileName = fileName,
	      newLines = ref [],
	      thisLine = ref 2,
	      leftPos = ref 0,
	      strList = ref [],
	      comLev = ref 0,
	      eofFlag = ref false,
	      errFlag = ref false,
	      readPos = readPos}
      in
		(lexarg, yyinput)
      end

    fun newLine(A{newLines,thisLine,...}, pos) =
      (newLines := pos :: !newLines; thisLine := pos+1)

    fun newTab(A{thisLine,readPos,...}, yygone, yypos) =
      let val lpos = yypos - !thisLine
      (* adrpo changed 2005-01-18: TAB SHOULD BE 1 CHARACTER *)
	  val incr = 0 (* 7 - Int.rem(lpos, 8) *)
      in
		readPos := !readPos + incr;
		yygone  := !yygone + incr
      end

    fun leftPos(A{leftPos,...}) = leftPos
    fun strList(A{strList,...}) = strList
    fun comLev(A{comLev,...})   = comLev
    fun eofFlag(A{eofFlag,...}) = eofFlag
    fun readPos(A{readPos,...}) = !readPos
    fun seenErr(A{errFlag,...}) = !errFlag

    fun source(A{fileName,newLines,...}) =
      Source.SOURCE{fileName = fileName, newLines = !newLines}

    fun error2 (lexarg as A{errFlag,...}) (msg,left,right) =
      (errFlag := true;
       Source.sayMsg (source lexarg) ("Error: "^msg, left, right))

    fun getLoc lexarg  (left, right) =
      (Source.getLoc(source lexarg, left, right))

  end (* functor LexArgFn *)
