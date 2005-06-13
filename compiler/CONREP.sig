(* conrep/conrep.sig *)

signature CONREP =
  sig

    datatype conrep	= INT of int
			| TRANSPARENT
			| BOX of {arity: int, tag: int}

  end (* signature CONREP *)
