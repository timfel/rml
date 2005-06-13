(* scan.lex *)

datatype Token	= ALLBREAKS | ALLCLEAR | ALLVARS | BREAK | CLEAR | CONTINUE
		| DOWN | EOF | ERROR | HELP | ICON of int | IDENT of string
		| NEWLINE | PRINT | QUIT | SCON of string | STEP | UP | WHERE

fun tokStr(ALLBREAKS)	= "$b"
  | tokStr(ALLCLEAR)	= ":z"
  | tokStr(ALLVARS)	= "$r"
  | tokStr(BREAK)	= ":b"
  | tokStr(CLEAR)	= ":d"
  | tokStr(CONTINUE)	= ":c"
  | tokStr(DOWN)	= "$d"
  | tokStr(EOF)		= "<eof>"
  | tokStr(ERROR)	= "<error>"
  | tokStr(HELP)	= "?"
  | tokStr(ICON i)	= "<icon: " ^ Int.toString i ^ ">"
  | tokStr(IDENT id)	= "<ident: " ^ id ^ ">"
  | tokStr(NEWLINE)	= "<newline>"
  | tokStr(PRINT)	= "/p"
  | tokStr(QUIT)	= "$q"
  | tokStr(SCON s)	= "<scon: " ^ s ^ ">"
  | tokStr(STEP)	= ":s"
  | tokStr(UP)		= "$u"
  | tokStr(WHERE)	= "$c"

type lexresult = Token

fun err s =
  (TextIO.output(TextIO.stdErr, s); TextIO.output(TextIO.stdErr, "\n"))

fun eof() = EOF

fun makeICON str =
  case Int.fromString str
    of SOME i	=> ICON i
     | NONE	=> (err("bad integer: "^str); ERROR)

fun makeSCON str = SCON(String.substring(str, 1, String.size str - 2))

fun makeIDENT str = IDENT str

%%

%header (structure Scan : SCAN);
%full
white=[\ \t];
icon=[0-9]+;
scon=\"[^"\n]*\";
alpha=    [A-Za-z_\128-\255];
alnum=[0-9'A-Za-z_\128-\255];
ident={alpha}{alnum}*;
err1=\"[^"\n]*;
err2="$"([^bcdqru\n][^\ \t\n]*)?;
err3="/"([^p\n][^\ \t\n]*)?;
err4=":"([^bcdsz\n][^\ \t\n]*)?;
err5=[^\ \t\n0-9"A-Za-z_\128-\255$/:?][^\ \t\n]*;
error={err1}|{err2}|{err3}|{err4}|{err5};

%%

{white}		=> (continue());
\n		=> (NEWLINE);
{icon}		=> (makeICON yytext);
{scon}		=> (makeSCON yytext);
{ident}		=> (makeIDENT yytext);
"$b"		=> (ALLBREAKS);
"$c"		=> (WHERE);
"$d"		=> (DOWN);
"$q"		=> (QUIT);
"$r"		=> (ALLVARS);
"$u"		=> (UP);
"/p"		=> (PRINT);
":b"		=> (BREAK);
":c"		=> (CONTINUE);
":d"		=> (CLEAR);
":s"		=> (STEP);
":z"		=> (ALLCLEAR);
"?"		=> (HELP);
{error}		=> (err("bad token: " ^ yytext); ERROR);
