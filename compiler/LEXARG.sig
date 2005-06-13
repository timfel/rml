(* lexer/lexarg.sig *)

signature LEXARG =
  sig

    structure Source: SOURCE

    type pos = int
    type lexarg
    val new	: string * TextIO.instream -> lexarg * (int -> string)
    val newLine	: lexarg * pos -> unit
    val newTab	: lexarg * int ref * pos -> unit
    val leftPos	: lexarg -> pos ref
    val strList	: lexarg -> string list ref
    val comLev	: lexarg -> pos ref
    val eofFlag	: lexarg -> bool ref
    val readPos	: lexarg -> pos
    val seenErr	: lexarg -> bool
    val error2	: lexarg -> string * pos * pos -> unit
    val source	: lexarg -> Source.source
    val getLoc	: lexarg -> pos * pos -> {fileName:string, sline:pos, scolumn:pos, eline:pos, ecolumn:pos}
  end (* signature LEXARG *)
