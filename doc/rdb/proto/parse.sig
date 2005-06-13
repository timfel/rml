(* parse.sig *)

signature PARSE =
  sig

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

    val parse		: unit -> Command

  end (* signature PARSE *)
