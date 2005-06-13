(* main/main.sig *)

signature MAIN =
  sig

    val translate	: (string * string option) -> unit
    val run		    : (string * string option) list * string list -> unit
    val main		: string list -> unit 

  end (* signature MAIN *)
