(* link.sml *)

structure Parse = ParseFun(structure Scan = Scan);
structure RDB =
  RDBFun(structure Dynamic = Dynamic
	 structure Parse = Parse);
