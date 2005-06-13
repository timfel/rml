(* fol/fol.sml *)

functor FOLFn(structure Util : UTIL) : FOL =
  struct

    type ident		= string
    datatype longid	= LONGID of ident option * ident

    datatype lit	= ICON of int
			| RCON of real
			| SCON of string

    datatype var	= VAR of {name	: ident,
				  uses	: int ref,
				  inst	: var option ref}

    datatype pat'	= WILDpat
			| LITpat of lit
			| CONpat of longid
			| STRUCTpat of longid option * pat list
    and pat		= PAT of var * pat'

    datatype varref	= GVAR of longid
			| BVAR of var

    datatype exp	= LITexp of lit
			| CONexp of longid
			| VARexp of varref
			| STRUCTexp of longid option * exp list

    datatype conj	= CALL of varref * exp list * var list
			| MATCH of (var * pat) list
			| EQUAL of var * exp
			| BIND of var * exp
			| NOT of conj
			| AND of conj * conj

    datatype disj	= RETURN of exp list
			| FAIL
			| ORELSE of disj * disj
			| ANDTHEN of conj * disj
			| COND of conj * disj * disj
			| CASE of var list * (pat list * disj) list

    datatype rel	= REL of ident * var list * disj

    datatype condesc	= CONcd of ident
			| CTORcd of ident * int
    datatype datdesc	= DATDESC of ident * condesc list

    datatype spec	= WITHspec of interface
			| DATAspec of datdesc list
			| VALspec of ident
			| RELspec of ident
    and interface	= INTERFACE of ident * spec list

    datatype dec	= WITHdec of interface
			| DATAdec of datdesc list
			| VALdec of ident * exp
			| RELdec of rel list

    datatype module	= MODULE of interface * dec list

    fun litEqual(ICON i1, ICON i2) = i1=i2
      | litEqual(RCON r1, RCON r2) = Real.==(r1,r2)
      | litEqual(SCON s1, SCON s2) = s1=s2
      | litEqual(_, _) = false

    fun newvar() =
      VAR{name="$"^(Int.toString(Util.tick())), uses=ref 0, inst=ref NONE}

    fun deref(var as VAR{inst,...}) =
      case !inst
	of SOME var	=> deref var
	 | NONE		=> var

  end (* functor FOLFn *)
