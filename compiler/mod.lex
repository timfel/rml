(* lexer/mo.lex -- ML-Lex lexical specification for Modelica+ *)

(* parameters for ML-Yacc *)
type arg = LexArg.lexarg
type pos = LexArg.pos
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue, pos) token

val tyVarStr = "Type_"

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
    (*
    print "Our real string:"; print str; print " the counted REAL: "; 
    print (Real.toString (LexUtil.rcon str));
    print "\n";
    *)
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

fun errBadStr(lexarg, pos, text) =
  let val msg = "illegal character in string " ^ MakeString.scvt text
  in
    LexArg.error2 lexarg (msg, pos, pos)
  end

fun makeSCON(lexarg, pos2) =
  let val strList = LexArg.strList lexarg
      val str = String.concat(List.rev("\"" :: !strList))
      val _ = strList := []
  in
    Tokens.SCON(LexUtil.scon str, !(LexArg.leftPos lexarg), pos2)
  end

fun makeTYVAR(pos1, str) =
  let val lenTyVarStr = String.size tyVarStr
	  val lenSubStr = String.size str - lenTyVarStr
  in
    Tokens.TYVAR(substring(str, lenTyVarStr, lenSubStr), pos1, pos1 + lenSubStr)
  end

val kwds = [
	    ("and",	Tokens.AND),
	    ("as",	Tokens.AS),
	    ("end",	Tokens.END),
	    ("not",	Tokens.NOT),
	    ("of",	Tokens.OF),
	    ("type",	Tokens.TYPE),	    
	    (* adrpo added MODELICA keywords *) 
		("algorithm", Tokens.ALGORITHM),
		("annotation", Tokens.ANNOTATION),
		("block", Tokens.BLOCK),
		("boundary", Tokens.BOUNDARY),
		(* not needed ("Code", Tokens.CODE), *)
		("class", Tokens.CLASS),
		("connect", Tokens.CONNECT),
		("connector", Tokens.CONNECTOR),
		("constant", Tokens.CONSTANT),
		("discrete", Tokens.DISCRETE),
		("each", Tokens.EACH),
		("else", Tokens.ELSE),
		("elseif", Tokens.ELSEIF),
		("elsewhen", Tokens.ELSEWHEN),
		("enumeration", Tokens.ENUMERATION),
		("equation", Tokens.EQUATION),
		("encapsulated", Tokens.ENCAPSULATED),
		("extends", Tokens.EXTENDS),
		("external", Tokens.EXTERNAL),
		("false", Tokens.FALSE), 
		("final", Tokens.FINAL),
		("flow", Tokens.FLOW),
		("for", Tokens.FOR),
		("function", Tokens.FUNCTION),
		("if", Tokens.IF),
		("import", Tokens.IMPORT),
		("in", Tokens.IN),
		("initial", Tokens.INITIAL),
		("inner", Tokens.INNER),
		("input", Tokens.INPUT),
		("loop", Tokens.LOOP),
		("model", Tokens.MODEL),
		("outer", Tokens.OUTER),
		("overload", Tokens.OVERLOAD),
		("or", Tokens.OR),
		("output", Tokens.OUTPUT),
		("package", Tokens.PACKAGE),
		("parameter", Tokens.PARAMETER),
		("partial", Tokens.PARTIAL),
		("protected", Tokens.PROTECTED),
		("public", Tokens.PUBLIC),
		("record", Tokens.RECORD),
		("failure", Tokens.FAILURE),
		("equality", Tokens.EQUALITY),		
		("tuple", Tokens.TUPLE),		
		("redeclare", Tokens.REDECLARE),
		("replaceable", Tokens.REPLACEABLE),
		("results", Tokens.RESULTS),
		("then", Tokens.THEN),
		("true", Tokens.TRUE),
		("when", Tokens.WHEN),
		("while", Tokens.WHILE),
		("within", Tokens.WITHIN),
		(* new modelica+ constructs *)
		("uniontype", Tokens.UNIONTYPE),
		("match", Tokens.MATCH),
		("matchcontinue", Tokens.MATCHCONTINUE),		
		("case", Tokens.CASE),
		("local", Tokens.LOCAL),
		("list", Tokens.LIST),
		("fail",	Tokens.FAIL)		
		]

fun makeIDENT(pos1, str) =
  if (String.isPrefix tyVarStr str)
  then 
    makeTYVAR(pos1, str)
  else
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

%header (functor MODLexFn(structure Tokens : MOD_TOKENS
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
exponent=[eE][+-]?{decint};
rcon={decint}({fraction}{exponent}?|{exponent});

echar=[\\"nrtfabv];
cntrl=[?-_];
escseq={ddigit}{3}|"^"{cntrl}|{echar};
pchar=[\ -!#-[^-~\128-\255]|"]";
cdesc={pchar}|\\{escseq}|"\\";
ccon="#\""{cdesc}\";

alpha=[A-Za-z];
alnum={alpha}|[_'0-9];
id={alpha}{alnum}*;

tyvar=tyVarStr+{alpha}{alnum}*;

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
	(LexArg.error2 lexarg ("unmatched close comment",yypos,yypos+1); continue());
<INITIAL>"*"		=>
	(Tokens.STAR(yypos, yypos));
<INITIAL>","		=>
	(Tokens.COMMA(yypos, yypos));
<INITIAL>"."		=>
	(Tokens.DOT(yypos, yypos));
<INITIAL>"::"		=>
	(Tokens.COLONCOLON(yypos, yypos+1));
<INITIAL>":"		=>
	(Tokens.COLON(yypos, yypos));
<INITIAL>";"		=>
	(Tokens.SEMICOLON(yypos, yypos));
<INITIAL>"{"		=>
	(Tokens.LBRACE(yypos, yypos));
<INITIAL>"}"		=>
	(Tokens.RBRACE(yypos, yypos));
<INITIAL>":="		=>
	(Tokens.ASSIGN(yypos, yypos+1));			
<INITIAL>"="		=>
	(Tokens.EQ(yypos, yypos));
<INITIAL>"["		=>
	(Tokens.LBRACK(yypos, yypos));
<INITIAL>"]"		=>
	(Tokens.RBRACK(yypos, yypos));
<INITIAL>"_"		=>
	(Tokens.WILD(yypos, yypos));
<INITIAL>{decint}	=>
	(makeDECINT(yypos, yytext));
<INITIAL>{hexint}	=>
	(makeHEXINT(yypos, yytext));
<INITIAL>{rcon}		=>
	(makeRCON(yypos, yytext));
<INITIAL>{ccon}		=>
	(makeCCON(yypos, yytext));
<INITIAL>{tyvar}	=>
	(makeTYVAR(yypos, yytext));
<INITIAL>{id}		=>
	(makeIDENT(yypos, yytext));
		
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
	(Tokens.EQEQ_REAL(yypos, yypos+2));
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

<INITIAL>"+^"	=>
	(Tokens.ADD_STRING(yypos, yypos));
	
<INITIAL>"@"	=>
	(Tokens.ADD_LIST(yypos, yypos));

<INITIAL>"^"	=>
	(Tokens.POWER(yypos, yypos));

<INITIAL>".*"		=>
	(Tokens.DOTSTAR(yypos, yypos));

		
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
