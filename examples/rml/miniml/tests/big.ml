(* big.ml -- a whole bunch of declarations *)

(*
 * peano arithmetic
 *)
fun add x y = if x = 0 then y else add (x - 1) (y + 1)
fun mul' x y z = if y = 0 then z else mul' x (y - 1) (add x z)
fun mul x y = mul' x y 0
fun pow' x y z = if y = 0 then z else pow' x (y - 1) (mul x z)
fun pow x y = pow' x y 1
fun fac' x y = if x = 0 then y else fac' (x - 1) (mul x y)
fun fac x = fac' x 1

(*
 * lists
 *)
fun length' xs len = if null xs then len else length' (tl xs) (len + 1)
fun length xs = length' xs 0
fun append xs ys = if null xs then ys else hd xs :: append (tl xs) ys
fun rev' xs ys = if null xs then ys else rev' (tl xs) (hd xs :: ys)
fun rev xs = rev' xs []
fun zip xs ys = if null xs then [] else (hd xs, hd ys) :: zip (tl xs) (tl ys)

(*
 * polymorphic combinators
 *)
fun I x = x
fun K x y = y
fun compose F G x = F(G x)

(*
 * higher-order list functions
 *)
fun map F =
  let fun M xs = if null xs then nil else F(hd xs) :: M(tl xs)
  in M end
fun app P =
  let fun A xs = if null xs then () else (P(hd xs); A(tl xs))
  in A end
fun foldl F =
  let fun loop state xs =
	if null xs then state else loop (F (hd xs) state) (tl xs)
  in loop end
fun foldr F init =
  let fun recur xs =
	if null xs then init else F (hd xs) (recur (tl xs))
  in recur end
fun filter F =
  let fun recur xs =
	if null xs then []
	else if F (hd xs) then hd xs :: recur (tl xs)
	else recur (tl xs)
  in recur end

(*
 * not-quite exceptions
 *)
fun bottom s = (print(if true then s else ""); (1 div 0; bottom s))

(*
 * functional dequeues
 *
 * type 'a Queue = 'a list * 'a list
 *)
val emptyq = ([], [])
fun enq q x =
  let val front = fst q
  in
    let val rear = snd q
    in
      (front, x :: rear)
    end
  end
fun deq q =
  let val front = fst q
  in
    let val rear = snd q
    in
      if null front then
	if null rear then bottom "deq failed!" else deq(rev rear,[])
      else (hd front, (tl front, rear))
    end
  end

(*
 * references
 *)
fun inc rx = rx := !rx + 1
fun dec rx = rx := !rx - 1

(*
 * linear algebra
 *)
(*fun vec_plus_vec v1 v2 = map real_add (zip v1 v2)*)
(*fun vec_times_c v c = map (real_mul c) v*)
fun dotprod v1 v2 =
  (* foldl (op +) 0.0 (map (op * ) (zip v1 v2)) *)
  let fun loop v1 v2 sum =
	if null v1 then sum
	else loop (tl v1) (tl v2) (sum + (hd v1 * hd v2))
  in loop v1 v2 0.0 end
fun transpose mat =
  let fun transp row0 rows =
	if null row0 then []
	else (hd row0 :: map hd rows) :: transp (tl row0) (map tl rows)
  in
    if null mat then []
    else transp (hd mat) (tl mat)
  end
fun mat_times_vec mat vec = map (dotprod vec) mat

(*
 * insertion sort
 *)
fun sort lt xs =
  let fun insert x ys =
	if null ys then [x]
	else if lt(x, hd ys) then x :: ys
	else hd ys :: insert x (tl ys)
  in
    foldl insert [] xs
  end

(*
 * An extremely polymorphic expression
 *)
val blow_out =
  let val x0 = fn z => z
  in
    let val x1 = (x0,(x0,x0))
    in
      let val x2 = (x1,(x1,x1))
      in
	let val x3 = (x2,(x2,x2))
	in
	  let val x4 = (x3,(x3,x3))
	  in
	    let val x5 = (x4,(x4,x4))
	    in
	      let val x6 = (x5,(x5,x5))
	      in
		let val x7 = (x6,x6)
		in
		  x7
		end
	      end
	    end
	  end
	end
      end
    end
  end

val it = print "done"
