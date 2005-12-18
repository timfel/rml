(* lexer/rml.lex -- ML-Lex lexical specification for RML *)

(* parameters for ML-Yacc *)
type arg = LexArg.lexarg
type pos = LexArg.pos
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue,pos) token

fun eof(lexarg) =
  let val pos = LexArg.readPos lexarg
  in
    if !(LexArg.eofFlag lexarg) then Tokens.EOF_HARD(pos, pos)
    else
      let val pos1 = !(LexArg.leftPos lexarg)
	  val _ = LexArg.eofFlag lexarg := true
      in
		if !(LexArg.comLev lexarg) > 0 then
		LexArg.error2 lexarg ("unterminated comment at EOF", pos1, pos)
		else if !(LexArg.strList lexarg) <> [] then
		LexArg.error2 lexarg ("unterminated string at EOF", pos1, pos)
		else ();
		Tokens.EOF_SOFT(pos, pos)
      end
  end

fun makeDECINT(pos1, str) =
  let val pos2 = pos1 + String.size str - 1
  in
    Tokens.ICON(LexUtil.decint str, pos1, pos2)
  end

fun makeHEXINT(pos1, str) =
  let val pos2 = pos1 + String.size str - 1
  in
    Tokens.ICON(LexUtil.hexint str, pos1, pos2)
  end

fun makeRCON(pos1, str) =
  let val pos2 = pos1 + String.size str - 1
  in
    (*print "Our real string:"; print str; print " the counted REAL: "; 
    print (Real.toString (LexUtil.rcon str));
    print "\n";*)
    Tokens.RCON(LexUtil.rcon str, pos1, pos2)
  end

fun makeCCON(pos1, str) =
  let val pos2 = pos1 + String.size str - 1
  in
    Tokens.CCON(LexUtil.ccon str, pos1, pos2)
  end

(* The regular expression for a string literal used to be:
 *	white=[\ \t\n\013\012];
 *	gap=\\{white}+\\;
 *	sitem={cdesc}|{gap};
 *	scon=\"{sitem}*\";
 * but due to error handling and position reporting reasons,
 * we now scan strings piecemeal using several lex start states.
 *)
fun addString(lexarg, yytext) =
  let val strList = LexArg.strList lexarg
  in
    strList := yytext :: !strList
  end

fun errBadStr(lexarg, pos, yytext) =
  let val msg = "illegal character in string " ^ MakeString.scvt yytext
  in
    LexArg.error2 lexarg (msg,pos,pos)
  end

fun makeSCON(lexarg, pos2) =
  let val strList = LexArg.strList lexarg
      val str = String.concat(List.rev("\"" :: !strList))
      val _ = strList := []
  in
    Tokens.SCON(LexUtil.scon str, !(LexArg.leftPos lexarg), pos2)
  end

fun makeTYVAR(pos1, str) =
  let val len_1 = String.size str - 1
  in
    Tokens.TYVAR(
		substring(str, 1, len_1), pos1 + 1, pos1 + len_1)
  end

val kwds = [
	    ("and",	Tokens.AND),
	    ("as",	Tokens.AS),
	    ("axiom",	Tokens.AXIOM),
	    ("datatype",Tokens.DATATYPE),
	    ("default",	Tokens.DEFAULT),
	    ("end",	Tokens.END),
	    ("eqtype",	Tokens.EQTYPE),
	    ("fail",	Tokens.FAIL),
	    ("let",	Tokens.LET),
	    ("module",	Tokens.MODULE),
	    ("not",	Tokens.NOT),
	    ("of",	Tokens.OF),
	    ("relation",Tokens.RELATION),
	    ("rule",	Tokens.RULE),
	    ("type",	Tokens.TYPE),
	    ("val",	Tokens.VAL),
	    ("with",	Tokens.WITH),
	    ("withtype",Tokens.WITHTYPE)
	    ]

fun makeIDENT(pos1, str) =
  let val pos2 = pos1 + String.size str - 1
      fun loop [] = Tokens.IDENT(str, pos1, pos2)
	| loop((str',mktok)::rest) =
	    if str=str' then mktok(pos1, pos2) else loop rest
  in
    loop kwds
  end

fun inc(ri) = ri := !ri + 1
fun dec(ri) = let val j = !ri - 1 in ri := j; j end

%%

%header (functor RMLLexFn(structure Tokens : RML_TOKENS
			  structure LexArg : LEXARG
			  structure MakeString : MAKESTRING
			  structure LexUtil : LEXUTIL) : ARG_LEXER);
			  
%S STRING GAP COMMENT COMMENTLINE;
%arg (lexarg);
%full

white=[\ \013\012];
eol="\010";
tab=\t;

ddigit=[0-9];
decint=[-~]?{ddigit}+;
xdigit=[0-9a-fA-F];
hexint=[-~]?"0x"{xdigit}+;

fraction="."{ddigit}+;
exponent=[eE]{decint};
rcon={decint}({fraction}{exponent}?|{exponent});

echar=[\\"nrtfabv];
cntrl=[?-_];
escseq={ddigit}{3}|"^"{cntrl}|{echar};
pchar=[\ -!#-[^-~\128-\255]|"]";
cdesc={pchar}|\\{escseq};
ccon="#\""{cdesc}\";

alpha=[A-Za-z];
alnum={alpha}|[_'0-9];
id={alpha}{alnum}*;

tyvar="'"+{alpha}{alnum}*;

%%

<INITIAL>{eol}		=>
	(LexArg.newLine(lexarg, yypos);
	 continue());
<INITIAL>{tab}		=>
	(LexArg.newTab(lexarg, yygone, yypos);
	 continue());
<INITIAL>{white}	=>
	(continue());
<INITIAL>\"		=>
	(LexArg.strList lexarg := [yytext];
	 LexArg.leftPos lexarg := yypos;
	 YYBEGIN STRING;
	 continue());
<INITIAL>"&"		=>
	(Tokens.AMPERSAND(yypos, yypos));
<INITIAL>"(*"|"/*"		=>
	(LexArg.comLev lexarg := 1;
	 LexArg.leftPos lexarg := yypos;
	 YYBEGIN COMMENT;
	 continue());
<INITIAL>"//"		=>
	(LexArg.comLev lexarg := 1;
	 LexArg.leftPos lexarg := yypos;
	 YYBEGIN COMMENTLINE;
	 continue());
<INITIAL>"("		=>
	(Tokens.LPAREN(yypos, yypos));
<INITIAL>")"		=>
	(Tokens.RPAREN(yypos, yypos));
<INITIAL>"*)"|"*/"		=>
	(LexArg.error2 lexarg ("unmatched close comment",
	 yypos,
	 yypos+1); continue());
<INITIAL>"*"		=>
	(Tokens.STAR(yypos, yypos));
<INITIAL>","		=>
	(Tokens.COMMA(yypos, yypos));
<INITIAL>"-""-"+	=>
	(Tokens.DASHES(yypos, yypos + String.size yytext - 1));
<INITIAL>"."		=>
	(Tokens.DOT(yypos, yypos));
<INITIAL>"::"		=>
	(Tokens.COLONCOLON(yypos, yypos+1));
<INITIAL>":"		=>
	(Tokens.COLON(yypos, yypos));
<INITIAL>"="		=>
	(Tokens.EQ(yypos, yypos));
<INITIAL>"=>"		=>
	(Tokens.FATARROW(yypos, yypos+1));
<INITIAL>"["		=>
	(Tokens.LBRACK(yypos, yypos));
<INITIAL>"]"		=>
	(Tokens.RBRACK(yypos, yypos));
<INITIAL>"_"		=>
	(Tokens.WILD(yypos, yypos));
<INITIAL>"|"		=>
	(Tokens.BAR(yypos, yypos));
<INITIAL>{decint}	=>
	(makeDECINT(yypos, yytext));
<INITIAL>{hexint}	=>
	(makeHEXINT(yypos, yytext));
<INITIAL>{rcon}		=>
	(makeRCON(yypos, yytext));
<INITIAL>{ccon}		=>
	(makeCCON(yypos, yytext));
<INITIAL>{id}		=>
	(makeIDENT(yypos, yytext));
<INITIAL>{tyvar}	=>
	(makeTYVAR(yypos, yytext));
		
<INITIAL>"+"	=> 
	(Tokens.ADD_INT(yypos, yypos));
<INITIAL>"-"	=>
	(Tokens.SUB_INT(yypos, yypos));
<INITIAL>"~"	=>
	(Tokens.NEG_INT(yypos, yypos));	
<INITIAL>"/"	=>
	(Tokens.DIV_INT(yypos, yypos));
<INITIAL>"%"	=>
	(Tokens.MOD_INT(yypos, yypos));
<INITIAL>"=="	=>
	(Tokens.EQEQ_INT(yypos, yypos+1));
<INITIAL>">="	=>
	(Tokens.GE_INT(yypos, yypos+1));
<INITIAL>">"	=>
	(Tokens.GT_INT(yypos, yypos));
<INITIAL>"<="	=>
	(Tokens.LE_INT(yypos, yypos+1));
<INITIAL>"<"	=>
	(Tokens.LT_INT(yypos, yypos));
<INITIAL>"!="	=>
	(Tokens.NE_INT(yypos, yypos+1));
<INITIAL>"<>"	=>
	(Tokens.NE_INT(yypos, yypos+1));

<INITIAL>"+."	=>
	(Tokens.ADD_REAL(yypos, yypos+1));
<INITIAL>"-."	=>
	(Tokens.SUB_REAL(yypos, yypos+1));
<INITIAL>"~."	=>
	(Tokens.NEG_REAL(yypos, yypos+1));	
<INITIAL>"*."	=>
	(Tokens.MUL_REAL(yypos, yypos+1));
<INITIAL>"/."	=>
	(Tokens.DIV_REAL(yypos, yypos+1)); 
<INITIAL>"%."	=>
	(Tokens.MOD_REAL(yypos, yypos+1));
<INITIAL>"^."	=>
	(Tokens.POW_REAL(yypos, yypos+1));		
<INITIAL>"==."	=>
	(Tokens.EQ_REAL(yypos, yypos+2));
<INITIAL>">=."	=>
	(Tokens.GE_REAL(yypos, yypos+2));
<INITIAL>">."	=>
	(Tokens.GT_REAL(yypos, yypos+1));
<INITIAL>"<=."	=>
	(Tokens.LE_REAL(yypos, yypos+2));
<INITIAL>"<."	=>
	(Tokens.LT_REAL(yypos, yypos+1));
<INITIAL>"!=."	=>
	(Tokens.NE_REAL(yypos, yypos+2));
<INITIAL>"<>."	=>
	(Tokens.NE_REAL(yypos, yypos+2));

<INITIAL>"^"	=>
	(Tokens.ADD_STRING(yypos, yypos));
	
<INITIAL>"@"	=>
	(Tokens.ADD_LIST(yypos, yypos));
		
<INITIAL>.		=>
	(let val msg = "illegal character " ^ MakeString.scvt yytext
	 in
	   LexArg.error2 lexarg (msg,yypos,yypos);
	   continue()
	 end);

<STRING>\"		=>
	(YYBEGIN INITIAL; makeSCON(lexarg, yypos));
<STRING>\\{eol}		=>
	(LexArg.newLine(lexarg, yypos+1);
	 YYBEGIN GAP; continue());
<STRING>\\{tab}		=>
	(LexArg.newTab(lexarg, yygone, yypos+1);
	 YYBEGIN GAP; continue());
<STRING>\\{white}	=>
	(YYBEGIN GAP; continue());
<STRING>{cdesc}		=>
	(addString(lexarg, yytext); continue());
<STRING>{eol}		=>
	(LexArg.newLine(lexarg, yypos);
	 addString(lexarg, yytext); continue());
<STRING>{tab}		=>
	(LexArg.newTab(lexarg, yygone, yypos);
	 addString(lexarg, yytext); continue());
<STRING>.		=>
	(errBadStr(lexarg, yypos, yytext); continue());

<GAP>\\			=>
	(YYBEGIN STRING; continue());
<GAP>{eol}		=>
	(LexArg.newLine(lexarg, yypos);
	 continue());
<GAP>{tab}		=>
	(LexArg.newTab(lexarg, yygone, yypos);
	 continue());
<GAP>{white}		=>
	(continue());
<GAP>.			=>
	(let val msg = "illegal character in string gap " ^ MakeString.scvt yytext
	 in
	   LexArg.error2 lexarg (msg,yypos,yypos);
	   continue()
	 end);

<COMMENT>"(*"|"/*"		=>
	(inc(LexArg.comLev lexarg); continue());
<COMMENT>"*)"|"*/"		=>
	(if dec(LexArg.comLev lexarg) > 0 then () else YYBEGIN INITIAL; continue());
<COMMENT>{eol}		=>
	(LexArg.newLine(lexarg, yypos);
	 continue());
<COMMENT>{tab}		=>
	(LexArg.newTab(lexarg, yygone, yypos);
	 continue());
<COMMENT>.		=>
	(continue());

<COMMENTLINE>{eol}		=>
	(LexArg.newLine(lexarg, yypos);
	 if dec(LexArg.comLev lexarg) > 0 then () else YYBEGIN INITIAL; continue());
<COMMENTLINE>{tab}		=>
	(LexArg.newTab(lexarg, yygone, yypos);
	 continue());
<COMMENTLINE>.		=>
	(continue());
