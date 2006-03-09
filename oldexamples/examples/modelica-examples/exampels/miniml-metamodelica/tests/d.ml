(* d.ml -- lists misc. *)
fun length lst = if null lst then 0 else 1 + length (tl lst)
val it = print(length[true,true,true])
fun map F =
  let fun M lst = if null lst then nil else F(hd lst) :: M(tl lst)
  in M end
fun app P =
  let fun A lst = if null lst then () else (P(hd lst); A(tl lst))
  in A end
fun times2plus1 x = x + x + 1
val it = app print (map times2plus1 [1,2,3])
