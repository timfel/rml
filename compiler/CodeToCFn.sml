(* code/codetoc.sml *)

functor CodeToCFn(structure MakeString : MAKESTRING
		  structure Util : UTIL
		  structure Code : CODE
		  structure Control : CONTROL
		    ) : CODETOC =
  struct

    structure Code = Code

    fun bug s = Util.bug("CodeToC."^s)

    val output = TextIO.output

    fun prInt os i = output(os, MakeString.icvt i)
    fun prReal os r = output(os, MakeString.rcvt r)
    fun prSCON os s = output(os, MakeString.scvt s)

    fun prGVar os gvar = output(os, Code.gvarString gvar)
    fun prLVar os lvar = output(os, Code.lvarString lvar)
    fun prVar os (Code.GLOvar gvar) = prGVar os gvar
      | prVar os (Code.LOCvar lvar) = prLVar os lvar

    fun prLabel os (Code.LABEL(Code.Mangle.NAME str)) = output(os, str)
    fun prLabelUnmangled os (Code.LABEL(Code.Mangle.NAME str)) = output(os, Code.Mangle.decode str)    

    fun mangle name =
      let val (Code.Mangle.NAME name) = Code.Mangle.encode name
      in
		name
      end

    fun prLitName os (Code.LITNAME name) = (output(os, "lit"); prInt os name)

    fun prFixNum(os, i) =
      (output(os, "RML_TAGFIXNUM("); prInt os i; output(os, ")"))

    fun prStructHdr(os, len, con) =
      (output(os, "RML_STRUCTHDR("); prInt os len; output(os, ",");
       prInt os con; output(os, ")"))

    fun prEXTERNlr(os, lab) =
      (output(os, "RML_GVAL_VALUE("); prLabel os lab; output(os, ")"))

    fun prLitRef os lr =
    case lr
	of Code.INTlr i =>
	    (output(os, "RML_IMMEDIATE("); prFixNum(os, i); output(os, ")"))
	 | Code.HDRlr{len,con} =>
	    (output(os, "RML_IMMEDIATE("); prStructHdr(os,len,con); output(os, ")"))
	 | Code.LABELlr lab =>
	    (output(os, "RML_LABVAL("); prLabel os lab; output(os, ")"))
	 | Code.EXTERNlr lab => prEXTERNlr(os, lab)
	 | Code.REALlr name =>
	    (output(os, "RML_REFREALLIT("); prLitName os name; output(os, ")"))
	 | Code.STRINGlr name =>
	    (output(os, "RML_REFSTRINGLIT("); prLitName os name; output(os, ")"))
	 | Code.STRUCTlr name =>
	    (output(os, "RML_REFSTRUCTLIT("); prLitName os name; output(os, ")"))

    fun prLitRefInit os (Code.EXTERNlr _) = output(os, "0")
      | prLitRefInit os lr = prLitRef os lr

    fun litref_is_extern(Code.EXTERNlr _) = true
      | litref_is_extern _ = false

    fun prVal os =
      let fun pVal(Code.VAR var) = prVar os var
	    | pVal(Code.LITERAL litref) = prLitRef os litref
	    | pVal(Code.OFFSET(v,off)) =
		(output(os, "RML_OFFSET("); pVal v; output(os, ", ");
		 prInt os off; output(os, ")"))
	    | pVal(Code.FETCH v) = (output(os,"RML_FETCH("); pVal v; output(os,")"))
	    | pVal(Code.UNTAGPTR v) = (output(os,"RML_UNTAGPTR("); pVal v; output(os,")"))
	    | pVal(Code.TAGPTR v) = (output(os,"RML_TAGPTR("); pVal v; output(os,")"))
	    | pVal(Code.CALL(lab,args)) =
		let fun loop([]) = ()
		      | loop(arg::args) = (output(os,", "); pVal arg; loop args)
		in
		  prLabel os lab;
		  output(os, "(");
		  (case args
		     of []		=> ()
		      | (arg::args)	=> (pVal arg; loop args));
		     output(os, ")")
		end
      in
		pVal
      end

    fun prNaiveIntCt(os, Code.INTct i) = prFixNum(os, i)
      | prNaiveIntCt _ = bug "prNaiveIntCt"
    fun prIntCt(os, Code.INTct i) = prInt os i
      | prIntCt _ = bug "prIntCt"

    fun prNaiveHdrCt(os, Code.HDRct{len,con}) = prStructHdr(os, len, con)
      | prNaiveHdrCt _ = bug "prNaiveHdrCt"
    fun prHdrCt(os, Code.HDRct{con,...}) = prInt os con
      | prHdrCt _ = bug "prHdrCt"

    fun prCode os (Code.CODE{code,...}) = prCode' os code

    and prCode' os (Code.GOTO(target, nargs)) =
	  Code.prGoto(os, prLabel, prVal, target, nargs)
      | prCode' os (Code.STORE(dst,src,code)) =
	  (output(os, "\n\tRML_STORE("); prVal os dst; output(os, ", ");
	  (* adrpo 2005-12-29 changed this to the one below! 
	   prVal os src; output(os, ");"); prCode os code)
	   *)
	   prVal os src; output(os, ");"); 
	   (case code of 
	        (* open a new sope only when a decl follows. *)
			Code.CODE{code=Code.BIND(SOME(Code.LOCvar lvar), v, c),...} => 
			(output(os, "\n\t{"); prCode os code; output(os, "}"))
			(* else, don't open a new scope *)
		| _ => prCode os code)
	  )
      | prCode' os (Code.BIND(SOME(Code.LOCvar lvar), v, code)) =
	  (* adrpo 2005-12-29 changed this to the one below! 
	  (output(os, "\n\t{ void *"); prLVar os lvar; output(os, " = "); 
	  *)
	  (output(os, "\n\tvoid *"); prLVar os lvar; output(os, " = ");
	  (* adrpo 2005-12-29 changed this to the one below!       
	   prVal os v; output(os, ";"); prCode os code; output(os, "}"))
	  *)
	   prVal os v; output(os, ";"); prCode os code)	  
      | prCode' os (Code.BIND(SOME(Code.GLOvar gvar), v,  code)) =
	  (output(os, "\n\t"); prGVar os gvar; output(os, " = "); prVal os v;
	  (* adrpo 2005-12-29 changed this to the one below!       
	   output(os, ";"); prCode os code)
	  *)
	   output(os, ";"); 
	   (case code of 
	        (* open a new sope only when a decl follows. *)
			Code.CODE{code=Code.BIND(SOME(Code.LOCvar lvar), v, c),...} => 
			(output(os, "{"); prCode os code; output(os, "}"))
			(* else, don't open a new scope *)
		| _ => prCode os code)
	  )	  
      | prCode' os (Code.BIND(NONE, v, code)) =
	  (* adrpo 2005-12-29 changed this to the one below!       
	  (output(os, "\n\t"); prVal os v; output(os, ";"); prCode os code)
	  *)
	  (output(os, "\n\t"); prVal os v; output(os, ";");
	   (case code of 
	        (* open a new sope only when a decl follows. *)
			Code.CODE{code=Code.BIND(SOME(Code.LOCvar lvar), v, c),...} => 
			(output(os, "{"); prCode os code; output(os, "}"))
			(* else, don't open a new scope *)
		| _ => prCode os code)
	  )	   
      | prCode' os (Code.SWITCH(_, [], NONE)) = bug "prCode': SWITCH(_,[],NONE)"
      | prCode' os (Code.SWITCH(v, [], SOME default)) = (* == BIND(NONE,v,default) *)
	  (output(os, "\n\t"); prVal os v; output(os, ";"); prCode os default)
      | prCode' os (Code.SWITCH(v, (case0 as (Code.INTct _,_))::cases, default)) =
	  if List.length cases < !Control.switchRewriteThreshold then
	    (output(os, "\n\tswitch( (rml_sint_t)");
	     prVal os v;
	     output(os, " ) {");
	     prCases(prNaiveIntCt, os, case0, cases, default);
	     output(os, "\n\t}"))
	  else
	    (output(os, "\n\tswitch( RML_UNTAGFIXNUM(");
	     prVal os v;
	     output(os, ") ) {");
	     prCases(prIntCt, os, case0, cases, default);
	     output(os, "\n\t}"))
      | prCode' os (Code.SWITCH(v, (case0 as (Code.HDRct _,_))::cases, default)) =
	  if List.length cases < !Control.switchRewriteThreshold then
	    (output(os, "\n\tswitch( (rml_sint_t)");
	     prVal os v;
	     output(os, " ) {");
	     prCases(prNaiveHdrCt, os, case0, cases, default);
	     output(os, "\n\t}"))
	  else
	    (output(os, "\n\tswitch( RML_HDRCTOR((rml_uint_t)");
	     prVal os v;
	     output(os, ") ) {");
	     prCases(prHdrCt, os, case0, cases, default);
	     output(os, "\n\t}"))
      | prCode' os (Code.SWITCH(v, cases as ((Code.REALct _,_)::_), default)) =
	  let val dvar = Code.LVAR(Util.tick())
	  in
	    output(os, "\n\t{ double "); prLVar os dvar; output(os, " = ");
	    output(os, " = rml_prim_get_real("); prVal os v; output(os, ";\n\t");
	    List.app (prRealCase os dvar) cases; output(os, "{");
	    prRealDefault os default; output(os, "}}")
	  end
      | prCode' os (Code.SWITCH(v, cases as ((Code.STRINGct _,_)::_), default)) =
	  let val xvar = Code.LVAR(Util.tick())
	  in
	    output(os, "\n\t{ void *"); prLVar os xvar; output(os, " = ");
	    prVal os v; output(os, ";\n\t");
	    List.app (prStringCase os xvar) cases; output(os, "{");
	    prStringDefault os default; output(os, "}}")
	  end

    and prCases(prCaseTag, os, case0, cases, default) =
      let fun prCase(ct, code) =
	    (output(os, "\n\tcase "); prCaseTag(os, ct);
		(* adrpo 2005-12-29 changed this to the one below! 	     
		output(os, ":"); prCode os code) 
		 *)
	    output(os, ": {"); prCode os code; output(os, "}"))
	  fun prDefault code = 
	    (* adrpo 2005-12-29 changed this to the one below!
		(output(os, "\n\tdefault:"); prCode os code)
		*)
		(output(os, "\n\tdefault:{"); prCode os code; output(os, "}"))
	  fun loop((ct,code), []) =
		(case default
		   of NONE =>
			(output(os, "\n\t/*case "); prCaseTag(os,ct);
			 output(os, "*/"); prDefault code)
		    | SOME code' => (prCase(ct,code); prDefault code'))
	    | loop((ct,code), (case0::cases)) =
		(prCase(ct,code); loop(case0, cases))
      in
		loop(case0, cases)
      end

    and prRealCase os dvar (Code.REALct r, code) =
	  (output(os, "if( "); prLVar os dvar; output(os, " == "); prReal os r;
	   output(os, " ) {"); prCode os code; output(os, "\n\t} else "))
      | prRealCase _ _ (_, _) = bug "prRealCase"

    and prRealDefault os (SOME code) = prCode os code
      | prRealDefault _ NONE = bug "prRealDefault"

    and prStringCase os xvar (Code.STRINGct s, code) =
	  (output(os, "if( rml_prim_stringeq("); prLVar os xvar;
	   output(os, ", RML_STRINGHDR("); prInt os (String.size s);
	   output(os, "), "); prSCON os s; output(os, ") ) {");
	   prCode os code; output(os, "\n\t} else "))
      | prStringCase _ _ (_, _) = bug "prStringCase"

    and prStringDefault os (SOME code) = prCode os code
      | prStringDefault _ NONE = bug "prStringDefault"

    fun prImpLab os lab =
      (output(os, "extern RML_FORWARD_LABEL("); prLabel os lab; output(os, ");\n"))

    fun prLitDef os (litname, litdef) =
    case litdef
	of Code.REALld r		=>
	    (output(os, "static const RML_DEFREALLIT("); prLitName os litname;
	     output(os, ","); prReal os r; output(os, ");\n"))
	 | Code.STRINGld s		=>
	    (output(os, "static const RML_DEFSTRINGLIT("); prLitName os litname;
	     output(os, ","); prInt os (String.size s); output(os, ",");
	     prSCON os s; output(os, ");\n"))
	 | Code.STRUCTld(con, [])		=>
	    (output(os, "static const RML_DEFSTRUCT0LIT("); prLitName os litname;
	     output(os, ","); prInt os con; output(os, ");\n"))
	 | Code.STRUCTld(con, litref::litrefs)	=>
	    let fun loop(litref, litrefs) =
		  (prLitRefInit os litref;
		   case litrefs
		     of []	=> output(os, "}};\n")
		      | (litref::litrefs) => (output(os,","); loop(litref,litrefs)))
	    in
	      output(os, "static ");
	      if List.exists litref_is_extern (litref::litrefs) then ()
	      else output(os, "const ");
	      output(os, "RML_DEFSTRUCTLIT(");
	      prLitName os litname;
	      output(os, ",");
	      prInt os (1 + length litrefs);
	      output(os, ",");
	      prInt os con;
	      output(os, ") {");
	      loop(litref, litrefs)
	    end

    fun emitLitdefs _ [] = ()
      | emitLitdefs os litdefs =
	  (output(os, "\n"); List.app (prLitDef os) litdefs)

    fun prLitDefPatch os (litname, Code.STRUCTld(_,litrefs)) =
	  let fun loop([], _) = ()
		| loop(litref::litrefs, off) =
		    ((case litref
			of Code.EXTERNlr lab	=> 
			    (output(os, "\t"); prLitName os litname;
			     output(os, ".data["); prInt os off; output(os, "] = ");
			     prEXTERNlr(os, lab); output(os, ";\n"))
			 | _			=> ());
		     loop(litrefs, off+1))
	  in
	    loop(litrefs, 0)
	  end
      | prLitDefPatch _ (_, _) = ()

    fun prValDec os lab =
      (output(os, "extern struct rml_gval "); prLabel os lab; output(os, ";\n"))

    fun prValDef os (lab,lr) =
      let fun prLitRefConst(_, Code.EXTERNlr _) = ()
	    | prLitRefConst(os, _) = output(os, "const ")
	  fun prLitRefDefn(os, Code.EXTERNlr extlab) =
		(output(os, "&"); prLabel os extlab)
	    | prLitRefDefn(os, _) = output(os, "0")
      in
		prLitRefConst(os, lr);
		output(os, "struct rml_gval ");
		prLabel os lab;
		output(os, " = {{");
		prLitRefInit os lr;
		output(os, "},");
		prLitRefDefn(os, lr);
		output(os, ",\034");
		prLabel os lab;
		output(os, "\034};\n")
      end

    fun emitValues _ [] = ()
      | emitValues os values =
	  (output(os, "\n"); List.app (prValDef os) values)

    fun prInitVal os (lab,lr) =
      case lr
	of Code.EXTERNlr _ =>
	    (output(os, "\trml_gval_init(&"); prLabel os lab; output(os, ");\n"))
	 | _ => ()

    val mangled_init = mangle "_init"

    fun prDecInitProc os xmod =
      (output(os, "extern void "); output(os, xmod);
       output(os, mangled_init); output(os, "(void);\n"))

    fun prCallInitProc os xmod =
      (output(os, "\t"); output(os,xmod); output(os, mangled_init);
       output(os, "();\n"))

    fun prInitProc (os, prefix)  hookfn (Code.MODULE{modname,xmods,litdefs,values,...}) =
      let val modname_not_mangled = modname
          val xmods = map mangle xmods
	      val modname = mangle modname
      in
		output(os, "\n");
		List.app (prDecInitProc os) xmods;
		output(os, "\nvoid "); output(os, modname);
		output(os, mangled_init); output(os, "(void)\n{\n");
		output(os, "\tstatic int done = 0;\n");
		output(os, "\tif( done ) return;\n");
		output(os, "\tdone = 1;\n");
		hookfn();	(* only used by DiffToCFn *)
		List.app (prCallInitProc os) xmods;
		List.app (prInitVal os) values;
		List.app (prLitDefPatch os) litdefs;
		if !Control.doDebug 
		then
		(
		output(os, "\trmldb_load_db(\"");
		output(os, prefix^".rdb");
		output(os, "\");\n")	
		)
		else ();
		output(os, "}\n")
      end

    fun prInterfaceValDec os (lab,_) = prValDec os lab

    fun prInterfaceLabDec os (Code.LABDEF{globalP,label,...}) =
      if globalP then prImpLab os label else ()

    val mangled_eq = mangle "="

    fun prInterfaceCtorDec os (ctor,rep) =
      let val ctor = mangle ctor
      in
		output(os, "#define "); output(os, ctor); output(os, mangled_eq);
		case rep
		of Code.ConRep.INT tag	=>
			(output(os,"INT "); prInt os tag; output(os,"\n#define "); output(os,ctor);
			output(os, " (mk_icon("); prInt os tag; output(os, "))\n"))
		| Code.ConRep.TRANSPARENT	=>
			(output(os, "TRANSPARENT"); output(os, "\n#define ");
			output(os, ctor); output(os, "(X) (X)\n"))
		| Code.ConRep.BOX{arity,tag}	=>
			let fun prActuals() =
				let fun loop n =
					if n > arity then ()
					else (output(os,",(X"); prInt os n; output(os,")"); loop(n+1))
				in
					loop 1
				end
				fun prFormals() =
				let fun loop n =
					if n > arity then output(os, ")")
					else (output(os, ",X"); prInt os n; loop(n+1))
				in
					case arity
					of 0	=> ()
					| _	=> (output(os, "(X1"); loop 2)
				end
			in
				output(os, "BOX"); prInt os arity; output(os, " "); prInt os tag;
				output(os, "\n#define "); output(os, ctor); prFormals();
				output(os, " (mk_box"); prInt os arity; output(os, "(");
				prInt os tag; prActuals(); output(os, "))\n")
			end
      end
      
    fun prInterfaceCtorDecArrays os (ctor,rep) =
      let val ctor = ctor
      in
		output(os, "#define "); output(os, ctor); output(os, "="(* mangled_eq *));
		case rep
		of Code.ConRep.INT tag	=>
			(output(os,"INT "); prInt os tag; output(os,"\n#define ");output(os,ctor);
			output(os, " (mk_icon("); prInt os tag; output(os, "))\n"))
		| Code.ConRep.TRANSPARENT	=>
			(output(os, "TRANSPARENT"); output(os, "\n#define ");
			output(os, ctor); output(os, "(X) (X)\n"))
		| Code.ConRep.BOX{arity,tag}	=>
			let fun prActuals() =
				let fun loop n =
					if n > arity then ()
					else (output(os,",(X"); prInt os n; output(os,")"); loop(n+1))
				in
					loop 1
				end
				fun prFormals() =
				let fun loop n =
					if n > arity then output(os, ")")
					else (output(os, ",X"); prInt os n; loop(n+1))
				in
					case arity
					of 0	=> ()
					| _	=> (output(os, "(X1"); loop 2)
				end
			in
				output(os, "BOX"); prInt os arity; output(os, " "); prInt os tag;
				output(os, "\n#define "); output(os, ctor); prFormals();
				output(os, " (mk_box"); prInt os arity; output(os, "(");
				prInt os tag; prActuals(); output(os, "))\n")
			end
      end      

    fun prInterface os (Code.MODULE{modname,ctors,values,labdefs,...}) =
      let val modname = mangle modname
      in
		output(os, "/* interface "); output(os, modname); output(os, " */\n");
		prDecInitProc os modname;
		List.app (prInterfaceValDec os) values;
		List.app (prInterfaceLabDec os) labdefs;
		List.app (prInterfaceCtorDec os) ctors
		(* List.app (prInterfaceCtorDecArrays os) ctors *)
      end

  end (* functor CodeToCFn *)
