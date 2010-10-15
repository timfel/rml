(* static/ty.sig *)

signature TY =
  sig

    datatype tynameeq
      = NEVER
      | MAYBE
      | ALWAYS
    datatype tyname
      = TYNAME of {modid: string,
		   tycon: string,
		   eq: tynameeq ref}	(* patchable *)    
    datatype ty (* vname is the name of the variable where available! *)
      = VAR    of tyvar   * string option 
      | TUPLE  of ty list * string option
      | REL    of ty list * ty list * string option
      | CONS   of ty list * tyname * string option 
      | NAMED  of string  * ty * string option (* type component name and the actual type *)
    and tyvar
      = RIGID of string
      | FREE of {tag: int ref,		(* patchable *)
		 eq: bool,
		 subst: ty option ref}	(* patchable *)

    val makeTyvar	: bool -> tyvar
    val newTyvar	: unit -> tyvar
    val deref		: ty -> ty

    val printType	: ty -> unit
    val printType'	: ty -> unit	(* does not reset alpha counter first *)
    
    val printTypeOs	: TextIO.outstream option * string * ty -> unit

    val admitsEq	: ty * bool -> bool

    datatype tyerr_explanation
      = TY_ERROR of ty * string
      | TY_INST of tyvar * ty * string
      | TY_DIFFER of ty * ty * string
    exception TypeError of tyerr_explanation

    val mustAdmitEq	: ty -> unit
    val unify		: ty * ty -> unit

  end (* signature TY *)
