(* static/tycomb.sml *)

functor TyCombFn(structure Util : UTIL
		 structure Ty : TY
		   ) : TY_COMB =
  struct

    structure Ty = Ty

    type vname = string (* have a name! *)
    datatype tycomb
      = QUOTE of Ty.ty
      | ARG of int * vname option
      | MKTUPLE of tycomb list * vname option
      | MKREL of tycomb list * tycomb list * vname option
      | MKCONS of tycomb list * Ty.tyname * vname option
      | MKNAMED of string * tycomb * vname option

    fun absBvars(bvars, ty) =
      let 
      fun isQ(QUOTE _) = true
	    |   isQ _ = false
	  
    fun abstract ty =
	    let val ty = Ty.deref ty
	    in
	      case ty of 
          Ty.VAR(alpha, vname) =>
		       let fun look([], _) = QUOTE ty
			         |   look(tyvar::tyvars, i) =
			             if alpha = tyvar 
                   then ARG(i, vname) 
                   else look(tyvars, i+1)
		       in
		         look(bvars, 0)
		       end
		    | Ty.TUPLE(tys, vname) =>
		       let val cs = map abstract tys
		       in
		         if List.all isQ cs 
             then QUOTE ty 
             else MKTUPLE(cs, vname)
		       end
		    | Ty.REL(tys1, tys2, vname) =>
		       let val cs1 = map abstract tys1
			         and cs2 = map abstract tys2
		       in
		         if List.all isQ cs1 andalso List.all isQ cs2 
             then QUOTE ty
		         else MKREL(cs1, cs2, vname)
		       end
		    | Ty.CONS(tys, t, vname) =>
		       let val cs = map abstract tys
		       in
		         if List.all isQ cs 
             then QUOTE ty 
             else MKCONS(cs, t, vname)
		       end
		    | Ty.NAMED(id_str, ty, vname) => MKNAMED(id_str, abstract ty, vname)
	    end
    in
		  abstract ty
    end

    fun absAll ty =
      let 
        fun scan(ty, alphas) =
	       case Ty.deref ty of 
           Ty.VAR(alpha, vname) => Util.maybeCons(alpha, alphas)
	       | Ty.TUPLE(tys, vname) => List.foldl scan alphas tys
	       | Ty.REL(tys1, tys2, vname) =>
		         List.foldl scan (List.foldl scan alphas tys1) tys2
	       | Ty.CONS(tys, _, vname) => List.foldl scan alphas tys
	       | Ty.NAMED(id_str, ty, vname) => scan (ty, alphas)
	      val bvars = scan(ty, [])
      in
	     (bvars, absBvars(bvars, ty))
      end

    fun absNone ty = QUOTE(Ty.deref ty)

    fun apply(comb, args) =
    let 
      val args = Vector.fromList args
	    fun eval(QUOTE ty) = ty
	    |   eval(ARG(i, vname)) = Vector.sub(args, i)
	    |   eval(MKTUPLE(cs, vname)) = Ty.TUPLE(map eval cs, vname)
	    |   eval(MKREL(cs1, cs2, vname)) = Ty.REL(map eval cs1, map eval cs2, vname)
	    |   eval(MKCONS(cs, t, vname)) = Ty.CONS(map eval cs, t, vname)
	    |   eval(MKNAMED(id_str, ty, vname)) = Ty.NAMED(id_str, eval ty, vname)
    in
		  eval comb
    end

  end (* functor TyCombFn *)
