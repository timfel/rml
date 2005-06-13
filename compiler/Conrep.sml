(* conrep/conrep.sml *)

structure ConRep : CONREP =
  struct

    datatype conrep	= INT of int
			| TRANSPARENT
			| BOX of {arity: int, tag: int}

  end (* structure ConRep *)
