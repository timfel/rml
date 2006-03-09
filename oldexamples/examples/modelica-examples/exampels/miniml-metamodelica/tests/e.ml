(* e.ml -- refs misc. *)
val c = ref 0
fun tick _ = let val c' = !c + 1 in (c := c'; c') end
val it = print(tick())
val it = print(tick())
val it = print(tick())
