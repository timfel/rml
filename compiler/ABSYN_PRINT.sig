(* absyn/absyn_print.sig *)

signature ABSYN_PRINT =
  sig

    structure Absyn	: ABSYN
    val printModule	: TextIO.outstream * Absyn.module -> unit
  end (* signature ABSYN_PRINT *)
