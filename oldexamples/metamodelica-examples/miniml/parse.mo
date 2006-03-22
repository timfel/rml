package Parse " parse.rml "
import absyn;

public function parse
  input String in_string;
  output AbsynDecList out_absyndeclist;
protected 
  type AbsynDecList = list<Absyn.Dec>;

  external "C" ;
end parse;
end Parse;

