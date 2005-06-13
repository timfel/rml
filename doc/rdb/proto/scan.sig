(* scan.sig *)

signature SCAN =
  sig

    structure UserDeclarations:
      sig
	datatype Token	= ALLBREAKS | ALLCLEAR | ALLVARS | BREAK | CLEAR | CONTINUE
			| DOWN | EOF | ERROR | HELP | ICON of int | IDENT of string
			| NEWLINE | PRINT | QUIT | SCON of string | STEP | UP | WHERE
	val tokStr	: Token -> string
      end

    val makeLexer: (int -> string) -> unit -> UserDeclarations.Token

  end (* signature SCAN *)
