(* static/statelab.sig *)

signature STAT_ELAB =
  sig

    structure Absyn	 : ABSYN
    
    datatype cacheLine = CACHE of string *     (* file *)
                                  Absyn.module (* the cached file *)
                                  
    type entireCache = cacheLine list   

    val checkModule	 : TextIO.outstream option * Absyn.module      -> unit
    val checkProgram : TextIO.outstream option * Absyn.module list -> unit

  end (* signature STAT_ELAB *)
