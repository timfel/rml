(* dynamic.sml *)

structure Dynamic : DYNAMIC =
  struct

    fun sayOut s = TextIO.output(TextIO.stdOut, s)

    datatype Value	= INT of int
			| REAL of real
			| STRING of string
			| STRUCT of int * Value vector

    datatype Type	= ALPHA of int
			| APPLY of Type vector * SayFn
    and SayFn		= SAY_IMMED of (int * string) list
			| SAY_BOXED of (int * string * Type vector) list
			| SAY_TRANS of string * Type
			| SAY_LIST
			| SAY_TUPLE
			| SAY_UNKNOWN
			| SAY_INT
			| SAY_REAL
			| SAY_STRING

    datatype DatDesc	= IMMED of (int * string) list
			| BOXED of (int * string * Type vector) list
			| TRANS of string * Type

    fun untagInt(INT i) = i | untagInt _ = raise Match
    fun untagReal(REAL r) = r | untagReal _ = raise Match
    fun untagString(STRING s) = s | untagString _ = raise Match
    fun untagTuple(STRUCT(_,xvec)) = xvec | untagTuple _ = raise Match
    fun untagStruct(STRUCT x) = x | untagStruct _ = raise Match

    fun saySP true = sayOut " "
      | saySP false = ()

    fun sayLP true = sayOut "("
      | sayLP false = ()

    fun sayRP true = sayOut ")"
      | sayRP false = ()

    fun sayUnknown isArg = (saySP isArg; sayOut "-")
    fun sayInt(isArg, x) = (saySP isArg; sayOut(Int.toString(untagInt x)))
    fun sayReal(isArg, x) = (saySP isArg; sayOut(Real.toString(untagReal x)))
    fun sayString(isArg, x) =
      (saySP isArg; sayOut "\""; sayOut(untagString x); sayOut "\"")

    fun sayImmed(descs, isArg, x) =
      let val tag = untagInt x
	  fun look([]) = raise Match
	    | look((tag',con)::rest) = if tag = tag' then sayOut con else look rest
      in
	saySP isArg; look descs
      end

    val width = ref 10

    fun sayType(ty, aenv, isArg, depth, x) =
      let fun loop(ALPHA _, []) = raise Match
	    | loop(ALPHA i, avec::aenv) = loop(Vector.sub(avec,i), aenv)
	    | loop(APPLY(tyvec,sayFn), aenv) =
		case sayFn
		  of SAY_IMMED descs	=> sayImmed(descs,isArg,x)
		   | SAY_BOXED descs	=> sayBoxed(descs,tyvec,aenv,isArg,depth,x)
		   | SAY_TRANS(con,ty)	=> sayTrans(con,ty,tyvec,aenv,isArg,depth,x)
		   | SAY_LIST		=> sayList'(tyvec,aenv,depth,x)
		   | SAY_TUPLE		=> sayTuple'(tyvec,aenv,depth,x)
		   | SAY_UNKNOWN	=> sayUnknown(isArg)
		   | SAY_INT		=> sayInt(isArg,x)
		   | SAY_REAL		=> sayReal(isArg,x)
		   | SAY_STRING		=> sayString(isArg,x)
      in
	if depth < 0 then (saySP isArg; sayOut "#")
	else loop(ty, aenv)
      end

    and sayVector(tyvec, aenv, depth, xvec) =
      let val depth = depth - 1
	  fun appif(i,ty) =
	    (if i = 0 then () else sayOut ",";
	     sayType(ty, aenv, false, depth, Vector.sub(xvec,i)))
	  val len = Vector.length tyvec
      in
	sayOut "(";
	Vector.appi appif (tyvec,0,SOME(if len > !width then !width else len));
	if len > !width then sayOut ",..." else ();
	sayOut ")"
      end

    and sayTuple'(tyvec,aenv,depth,x) = sayVector(tyvec,aenv,depth,untagTuple x)

    and sayBoxed(descs, tyvec, aenv, isArg, depth, x) =
      let val (tag,xvec) = untagStruct x
	  fun look([]) = raise Match
	    | look((tag',con,tyvec')::rest) =
		if tag = tag' then
		  if Vector.length tyvec' = 0 then (saySP isArg; sayOut con)
		  else (sayLP isArg; sayOut con;
			sayVector(tyvec', tyvec::aenv, depth, xvec);
			sayRP isArg)
		else look rest
      in
	look descs
      end

    and sayTrans(con, ty, tyvec, aenv, isArg, depth, x) =
      (sayLP isArg; sayOut con; sayOut "(";
       sayType(ty, tyvec::aenv, true, depth-1, x);
       sayOut ")"; sayRP isArg)

    and sayList'(tyvec, aenv, depth, x) =
      let val alpha = Vector.sub(tyvec,0)
	  val depth = depth - 1
	  fun loop(widthAvail, cons) =
	    if widthAvail <= 0 then sayOut "..."
	    else
	      (sayType(alpha, aenv, false, depth, Vector.sub(cons,0));
	       case untagStruct(Vector.sub(cons,1))
		 of (0,_) => ()
		  | (_,cons) => (sayOut ","; loop(widthAvail-1, cons)))
      in
	sayOut "[";
	case untagStruct x
	  of (0,_) => ()
	   | (_,cons) => loop(!width, cons);
	sayOut "]"
      end

    fun mkSayFn(IMMED descs) = SAY_IMMED descs
      | mkSayFn(BOXED descs) = SAY_BOXED descs
      | mkSayFn(TRANS(con,ty)) = SAY_TRANS(con,ty)

    val sayTuple = SAY_TUPLE
    val sayList = SAY_LIST
    val sayOption = SAY_BOXED[(0,"NONE",#[]), (1,"SOME",#[ALPHA 0])]

    val tyAlpha = APPLY(#[],SAY_UNKNOWN)
    val tyBool = APPLY(#[],SAY_IMMED[(0,"false"), (1, "true")])
    val tyInt = APPLY(#[],SAY_INT)
    val tyReal = APPLY(#[],SAY_REAL)
    val tyString = APPLY(#[],SAY_STRING)

    val depth = ref 5
    fun say(ty, x) = sayType(ty, [], false, !depth, x)

  end (* structure Dynamic *)
