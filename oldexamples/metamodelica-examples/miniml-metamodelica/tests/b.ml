(* b.ml -- fac 5 *)
fun fac n = if n < 2 then 1 else n * (fac (n - 1))
val it = print(fac 5)
