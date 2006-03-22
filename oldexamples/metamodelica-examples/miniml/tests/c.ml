(* c.ml -- some polymorphic combinators *)
fun I x = x
val it = print(I 27)
fun K x y = y
val it = print(K 0 "foo")
fun compose F G x = F(G x)
val it = print(compose (fn x => x+1) (fn y => y+y) 9)
