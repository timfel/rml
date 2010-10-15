(* static/tyscheme.sig *)

signature TY_SCHEME =
  sig

    structure Ty	: TY
    type tyscheme

    val genAll		: Ty.ty -> tyscheme
    val genNone		: Ty.ty -> tyscheme
    val instFree	: tyscheme * string option -> Ty.ty
    val instRigid	: tyscheme * string option -> Ty.ty

  end (* signature TY_SCHEME *)
