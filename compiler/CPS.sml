(* CPS.sml *)

structure CPS =
  CPSFn(
	structure Util = Util
	structure ConRep = ConRep);
