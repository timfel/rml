(* fol/fol_print.sig *)

signature FOL_PRINT =
  sig

    structure FOL	: FOL
    val printModule	: TextIO.outstream * FOL.module -> unit
    val printConj	: TextIO.outstream * FOL.module * FOL.conj -> unit

  end (* signature FOL_PRINT *)
