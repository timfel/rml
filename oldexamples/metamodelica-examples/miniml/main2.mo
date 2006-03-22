package Main " main2.rml "
import parse;
import static;

protected function parse
  input String in_string;
  output AbsynDecList out_absyndeclist;
protected 
  type AbsynDecList = list<Absyn.Dec>;
algorithm 
  out_absyndeclist:=
  matchcontinue (in_string)
    local
      AbsynDecList decs;
      String file;
    case file
      equation 
        decs = Parse.parse(file); then decs;
    case file
      equation 
        failure(_ = Parse.parse(file));
        print("parsing failed\n"); then fail();
  end matchcontinue;
end parse;

protected function elaborate
  input TupleStringSchemeSchemeList in_tuplestringschemeschemelist;
  input Absyn.Dec in_dec;
  output TupleStringSchemeSchemeList out_tuplestringschemeschemelist;
protected 
  type TupleStringSchemeScheme = tuple<String,SchemeScheme>;
  type TupleStringSchemeSchemeList = list<TupleStringSchemeScheme>;
algorithm 
  out_tuplestringschemeschemelist:=
  matchcontinue (in_tuplestringschemeschemelist,in_dec)
    local
      TupleStringSchemeSchemeList statenv_1,statenv;
      Absyn.Dec dec;
    case (statenv,dec)
      equation 
        statenv_1 = Static.elaborate(statenv, dec); then statenv_1;
    case (statenv,dec)
      equation 
        failure(_ = Static.elaborate(statenv, dec));
        print("type checking failed\n"); then fail();
  end matchcontinue;
end elaborate;

protected function doall
  input AbsynDecList in_absyndeclist;
  input TupleStringSchemeSchemeList in_tuplestringschemeschemelist;
  output Boolean dummy;
protected 
  type AbsynDecList = list<Absyn.Dec>;
  type TupleStringSchemeScheme = tuple<String,SchemeScheme>;
  type TupleStringSchemeSchemeList = list<TupleStringSchemeScheme>;
algorithm 
  dummy:=
  matchcontinue (in_absyndeclist,in_tuplestringschemeschemelist)
    local
      TupleStringSchemeSchemeList statenv_1,statenv;
      Absyn.Dec dec;
      AbsynDecList decs;
    case ({},_) then true; 
    case (dec :: decs,statenv)
      equation 
        statenv_1 = elaborate(statenv, dec);
        doall(decs, statenv_1); then true;
  end matchcontinue;
end doall;

public function main
  input StringList in_stringlist;
  output Boolean dummy;
protected 
  type StringList = list<String>;
algorithm 
  dummy:=
  matchcontinue (in_stringlist)
    local
      type AbsynDecList = list<Absyn.Dec>;
      AbsynDecList decs;
      String file;
    case file :: _
      equation 
        decs = parse(file);
        doall(decs, Static.env0); then true;
  end matchcontinue;
end main;
end Main;

