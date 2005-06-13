(* static/statobj.sig *)

signature STAT_OBJ =
  sig

    structure Absyn	: ABSYN
    structure IdentDict	: ORD_DICT (* = Absyn.IdentDict *)
    sharing IdentDict = Absyn.IdentDict
    structure Ty	: TY
    structure TyFcn	: TY_FCN
    structure TyScheme	: TY_SCHEME
    sharing Ty = TyFcn.Ty = TyScheme.Ty

    datatype valkind	= CON | VAR | REL
    datatype valstr	= VALSTR of {vk: valkind,
				     sigma: TyScheme.tyscheme}
    datatype tystr	= TYSTR of {theta: TyFcn.tyfcn,
				    abstract: bool}
    datatype modstr	= MODSTR of {TE: tystr IdentDict.dict,
				     VE: valstr IdentDict.dict,
				     source: Absyn.Source.source}

    val t_list		: Ty.tyname
    val tau_char	: Ty.ty
    val tau_int		: Ty.ty
    val tau_real	: Ty.ty
    val tau_string	: Ty.ty

    val sourceInit	: Absyn.Source.source
    val VE_init		: valstr IdentDict.dict
    val TE_init		: tystr IdentDict.dict
    val ME_init		: modstr IdentDict.dict

  end (* signature STAT_OBJ *)
