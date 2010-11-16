(* util/util.sig *)

signature UTIL =
  sig

    val bug			: string -> 'a
    val error		: string -> 'a
    val warn		: string -> unit
    
    val outStdErr	: string -> unit    

    val tick		: unit -> int

    val member		: ''a * ''a list -> bool
    val maybeCons	: ''a * ''a list -> ''a list

    val counterReset: unit -> unit
    val counterValueSCIncrease: unit -> int
    val counterValueFCIncrease: unit -> int
    val counterValueSC: unit -> int
    val counterValueFC: unit -> int

  end (* signature UTIL *)
