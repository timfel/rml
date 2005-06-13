(* rdb.sig *)

signature RDB =
  sig

    structure Dynamic : DYNAMIC
    type CPos sharing type CPos = int
    type Ident sharing type Ident = string
    datatype FrameDesc	= FRAME of (Ident * Dynamic.Type) vector
    datatype BptState	= IGNORE | BREAK | STEP
    datatype ModDesc	= MODULE of {modId	: Ident,
				     srcFile	: string,
				     frameDesc	: FrameDesc,
				     frameVals	: Dynamic.Value vector,
				     bptArr	: BptState array,
				     siteDescs	: SiteDesc vector ref	}
    and SiteDesc	= SITE of {region	: CPos * CPos,
				   procId	: string,
				   frameDesc	: FrameDesc,
				   modDesc	: ModDesc,
				   siteNo	: int	}

    val sayFrame	: FrameDesc * Dynamic.Value vector -> unit

    type Event

    val initMod	: ModDesc -> unit
    val reset	: unit -> unit
    val stepMode: unit -> unit
    val entry	: SiteDesc * Dynamic.Value vector -> Event
    val call	: SiteDesc * Dynamic.Value vector * Event -> Event

  end (* signature RDB *)
