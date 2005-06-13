(* dynamic.sig *)

signature DYNAMIC =
  sig

    datatype Value	= INT of int
			| REAL of real
			| STRING of string
			| STRUCT of int * Value vector

    type SayFn
    datatype Type	= ALPHA of int
			| APPLY of Type vector * SayFn

    datatype DatDesc	= IMMED of (int * string) list
			| BOXED of (int * string * Type vector) list
			| TRANS of string * Type
    val mkSayFn		: DatDesc -> SayFn

    val sayTuple	: SayFn
    val sayList		: SayFn
    val sayOption	: SayFn

    val tyAlpha		: Type
    val tyBool		: Type
    val tyInt		: Type
    val tyReal		: Type
    val tyString	: Type

    val width		: int ref
    val depth		: int ref
    val say		: Type * Value -> unit

  end (* signature DYNAMIC *)
