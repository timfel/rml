(* util/source.sig *)

signature SOURCE =
  sig

    datatype source
      = SOURCE of
	  { fileName: string,
	    newLines: int list }	(* _descending_ order *)

    val dummy	: source
    val sayMsg	: source -> string * int * int -> unit

	val lookup : int list * int -> {line:int, column:int}
	
	val getLoc : source * int * int -> {fileName: string, sline:int, scolumn:int, eline:int, ecolumn:int}	
	
  end (* signature SOURCE *)
