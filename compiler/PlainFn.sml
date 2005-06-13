(* code/plain.sml *)

functor PlainFn(structure MakeString : MAKESTRING
		structure ConRep : CONREP
		structure Mangle : MANGLE
		  ) : PLAIN =
  struct

    structure ConRep	= ConRep
    structure Mangle	= Mangle


    (* datatype gvar'	= GVAR of string *)
    datatype gvar_name	= SPgvn | FCgvn | SCgvn | ARGgvn of int
    datatype gvar_scope	= INTRAgvs | INTERgvs
    datatype gvar'	= GVARSTR of string | GVAR of {scope: gvar_scope, name: gvar_name}    
    
	type gvar		= gvar'
    
    datatype lvar	= LVAR of int

    datatype variable	= GLOvar of gvar
			| LOCvar of lvar

    datatype label	= LABEL of Mangle.name

    datatype litname	= LITNAME of int
    datatype litref	= INTlr of int
			| HDRlr of {len: int, con: int}
			| LABELlr of label
			| EXTERNlr of label
			| REALlr of litname
			| STRINGlr of litname
			| STRUCTlr of litname
    datatype litdef	= REALld of real
			| STRINGld of string
			| STRUCTld of int * litref list

    datatype value	= VAR of variable
			| LITERAL of litref
			| OFFSET of value * int
			| FETCH of value
			| UNTAGPTR of value
			| TAGPTR of value
			| CALL of label * value list

    datatype casetag	= INTct of int
			| HDRct of {len: int, con: int}
			| REALct of real
			| STRINGct of string

    datatype gototarget = LOCALg of label
			| EXTERNg of label
			| VALUEg of value

    datatype code'	= GOTO of gototarget * int
			| STORE of value * value * code
			| BIND of variable option * value * code
			| SWITCH of value * (casetag * code) list * code option

    and code		= CODE of {fvars: lvar list ref, code: code'}

    datatype labdef	= LABDEF of {	globalP	: bool,
					label	: label,
					varHP	: lvar,
					nalloc	: int,
					nargs	: int,
					code	: code		}

    datatype module	= MODULE of {	modname	: string,
					ctors	: (string * ConRep.conrep) list,
					xmods	: string list,
					xlabs	: label list,
					xvals	: label list,
					values	: (label * litref) list,
					litdefs	: (litname * litdef) list,
					labdefs	: labdef list	}

    fun gvarString(GVARSTR name) = name
    fun lvarString(LVAR tag) = "tmp" ^ MakeString.icvt tag

    fun prGoto(os, prLabel, prValue, target, nargs) =
      let fun continue() =
	    (TextIO.output(os, ",");
	     TextIO.output(os, Int.toString nargs);
	     TextIO.output(os, ");"))
	  fun prGotoLabel label =
	    (TextIO.output(os, "\n\tRML_TAILCALLQ(");
	     prLabel os label;
	     continue())
      in
	case target
	  of LOCALg label => prGotoLabel label
	   | EXTERNg label => prGotoLabel label
	   | VALUEg value =>
	      (TextIO.output(os, "\n\tRML_TAILCALL(");
	       prValue os value;
	       continue())
      end

    fun mklab str = LABEL(Mangle.encode str)

    fun mkcode c = CODE{fvars=ref[], code=c}
    fun mkGOTO(target, nargs) = mkcode(GOTO(target, nargs))
    fun mkSTORE(v1,v2,c) = mkcode(STORE(v1,v2,c))
    fun mkBIND(xopt,v,c) = mkcode(BIND(xopt,v,c))
    fun mkSWITCH(v,cases,def) = mkcode(SWITCH(v,cases,def))

    val intraSP		= GLOvar(GVARSTR "rmlSP")
    val intraFC		= GLOvar(GVARSTR "rmlFC")
    val intraSC		= GLOvar(GVARSTR "rmlSC")
    val intraArgs	=
      Vector.fromList[	GLOvar(GVARSTR "rmlA0"),
			GLOvar(GVARSTR "rmlA1"),
			GLOvar(GVARSTR "rmlA2"),
			GLOvar(GVARSTR "rmlA3"),
			GLOvar(GVARSTR "rmlA4"),
			GLOvar(GVARSTR "rmlA5"),
			GLOvar(GVARSTR "rmlA6"),
			GLOvar(GVARSTR "rmlA7"),
			GLOvar(GVARSTR "rmlA8"),
			GLOvar(GVARSTR "rmlA9"),
			GLOvar(GVARSTR "rmlA10"),
			GLOvar(GVARSTR "rmlA11"),
			GLOvar(GVARSTR "rmlA12"),
			GLOvar(GVARSTR "rmlA13"),
			GLOvar(GVARSTR "rmlA14"),
			GLOvar(GVARSTR "rmlA15"),
			(* 2004-09-28 adrpo added 16 more parameters *)
			GLOvar(GVARSTR "rmlA16"),
			GLOvar(GVARSTR "rmlA17"),
			GLOvar(GVARSTR "rmlA18"),
			GLOvar(GVARSTR "rmlA19"),
			GLOvar(GVARSTR "rmlA20"),
			GLOvar(GVARSTR "rmlA21"),
			GLOvar(GVARSTR "rmlA22"),
			GLOvar(GVARSTR "rmlA23"),
			GLOvar(GVARSTR "rmlA24"),
			GLOvar(GVARSTR "rmlA25"),
			GLOvar(GVARSTR "rmlA26"),
			GLOvar(GVARSTR "rmlA27"),
			GLOvar(GVARSTR "rmlA28"),
			GLOvar(GVARSTR "rmlA29"),
			GLOvar(GVARSTR "rmlA30"),
			GLOvar(GVARSTR "rmlA31")  ]

    val interSP		= intraSP
    val interFC		= intraFC
    val interSC		= intraSC
    val interArgs	= intraArgs

    (* These internal names are NOT mangled *)

    val primMARKER	= LABEL(Mangle.NAME "rml_prim_marker")
    val primUNWIND	= LABEL(Mangle.NAME "rml_prim_unwind")
    val primEQUAL	= LABEL(Mangle.NAME "rml_prim_equal")
    val primBOOL_NOT	= LABEL(Mangle.NAME "RML_PRIM_BOOL_NOT")
    val primINT_NEG	= LABEL(Mangle.NAME "RML_PRIM_INT_NEG")
    val primINT_ABS	= LABEL(Mangle.NAME "RML_PRIM_INT_ABS")
    val primBOOL_AND	= LABEL(Mangle.NAME "RML_PRIM_BOOL_AND")
    val primBOOL_OR	= LABEL(Mangle.NAME "RML_PRIM_BOOL_OR")
    val primINT_ADD	= LABEL(Mangle.NAME "RML_PRIM_INT_ADD")
    val primINT_SUB	= LABEL(Mangle.NAME "RML_PRIM_INT_SUB")
    val primINT_MUL	= LABEL(Mangle.NAME "RML_PRIM_INT_MUL")
    val primINT_DIV	= LABEL(Mangle.NAME "RML_PRIM_INT_DIV")
    val primINT_MOD	= LABEL(Mangle.NAME "RML_PRIM_INT_MOD")
    val primINT_MAX	= LABEL(Mangle.NAME "RML_PRIM_INT_MAX")
    val primINT_MIN	= LABEL(Mangle.NAME "RML_PRIM_INT_MIN")
    val primINT_LT	= LABEL(Mangle.NAME "RML_PRIM_INT_LT")
    val primINT_LE	= LABEL(Mangle.NAME "RML_PRIM_INT_LE")
    val primINT_EQ	= LABEL(Mangle.NAME "RML_PRIM_INT_EQ")
    val primINT_NE	= LABEL(Mangle.NAME "RML_PRIM_INT_NE")
    val primINT_GE	= LABEL(Mangle.NAME "RML_PRIM_INT_GE")
    val primINT_GT	= LABEL(Mangle.NAME "RML_PRIM_INT_GT")

  end (* functor PlainFn *)
