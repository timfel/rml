package Main " main.rml "
import parse;
import absyn;
import static;
import flatten;
import fcode;
import tcode;
import fcemit;

public function main
  input StringList in_stringlist;
  output Boolean dummy;
protected 
  type StringList = list<String>;
algorithm 
  dummy:=
  matchcontinue (in_stringlist)
    local String file;
    case (file :: _)
      equation 
        parse(file); then true;
  end matchcontinue;
end main;

protected function parse
  input String in_string;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_string)
    local
      Absyn.Prog ast;
      String file;
    case (file)
      equation 
        ast = Parse.parse(file);
        static(ast); then true;
    case (file)
      equation 
        failure(_ = Parse.parse(file));
        print("Parse.parse failed\n"); then fail();
  end matchcontinue;
end parse;

protected function static
  input Absyn.Prog in_prog;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_prog)
    local
      TCode.Prog tcode;
      Absyn.Prog ast;
    case (ast)
      equation 
        tcode = Static.elaborate(ast);
        flatten(tcode); then true;
    case (ast)
      equation 
        failure(_ = Static.elaborate(ast));
        print("Static.elaborate failed\n"); then fail();
  end matchcontinue;
end static;

protected function flatten
  input TCode.Prog in_prog;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_prog)
    local
      FCode.Prog fcode;
      TCode.Prog tcode;
    case (tcode)
      equation 
        fcode = Flatten.flatten(tcode);
        emit(fcode); then true;
    case (tcode)
      equation 
        failure(_ = Flatten.flatten(tcode));
        print("Flatten.flatten failed\n"); then fail();
  end matchcontinue;
end flatten;

protected function emit
  input FCode.Prog in_prog;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_prog)
    local FCode.Prog fcode;
    case (fcode)
      equation 
        FCEmit.emit(fcode); then true;
    case (fcode)
      equation 
        failure(FCEmit.emit(fcode));
        print("FCEmit.emit failed\n"); then fail();
  end matchcontinue;
end emit;
end Main;

