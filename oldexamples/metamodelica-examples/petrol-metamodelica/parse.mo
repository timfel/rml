package Parse " parse.rml "
import absyn;

public function parse
  input String in_string;
  output Absyn.Prog out_prog;

  external "C" ;
end parse;
end Parse;

