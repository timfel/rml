(* Plain.sml *)

structure Plain =
  PlainFn(structure MakeString = MakeString
	  structure ConRep = ConRep
	  structure Mangle = Mangle);
