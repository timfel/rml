(* fol2cps/pmc.sig *)

signature PMC =
  sig

    structure CPS	: CPS

    datatype pat
      = LITpat of CPS.constant
      | CONpat of {ncons: int, con: int}
      | STRUCTpat of {ncons: int, con: int, pats: pat list}
      | WILDpat
      | BINDpat of CPS.var * pat

    val pmc		: (  CPS.var list
			   * (pat list * (CPS.trivexp -> CPS.exp)) list
			   * CPS.trivexp
			   * bool
			   * bool
			   * string)
			  -> CPS.exp

  end (* signature PMC *)
