package Main " main1.rml "
import parse;
import static;
import dynamic;

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

protected function evaluate
  input TupleIntegerDynamicValList in_tupleintegerdynamicvallist;
  input TupleStringDynamicValList in_tuplestringdynamicvallist;
  input Absyn.Dec in_dec;
  output TupleIntegerDynamicValList out_tupleintegerdynamicvallist;
  output TupleStringDynamicValList out_tuplestringdynamicvallist;
protected 
  type TupleIntegerDynamicVal = tuple<Integer,DynamicVal>;
  type TupleIntegerDynamicValList = list<TupleIntegerDynamicVal>;
  type TupleStringDynamicVal = tuple<String,DynamicVal>;
  type TupleStringDynamicValList = list<TupleStringDynamicVal>;
algorithm 
  (out_tupleintegerdynamicvallist,out_tuplestringdynamicvallist):=
  matchcontinue (in_tupleintegerdynamicvallist,in_tuplestringdynamicvallist,in_dec)
    local
      TupleIntegerDynamicValList dynstate_1,dynstate;
      TupleStringDynamicValList dynenv_1,dynenv;
      Absyn.Dec dec;
    case (dynstate,dynenv,dec)
      equation 
        (dynstate_1,dynenv_1) = Dynamic.evaluate(dynstate, dynenv, dec); then (dynstate_1,dynenv_1);
    case (dynstate,dynenv,dec)
      equation 
        failure((_,_) = Dynamic.evaluate(dynstate, dynenv, dec));
        print("evaluation failed\n"); then fail();
  end matchcontinue;
end evaluate;

protected function doall
  input AbsynDecList in_absyndeclist;
  input TupleStringSchemeSchemeList in_tuplestringschemeschemelist;
  input TupleIntegerDynamicValList in_tupleintegerdynamicvallist;
  input TupleStringDynamicValList in_tuplestringdynamicvallist;
  output Boolean dummy;
protected 
  type AbsynDecList = list<Absyn.Dec>;
  type TupleStringSchemeScheme = tuple<String,SchemeScheme>;
  type TupleStringSchemeSchemeList = list<TupleStringSchemeScheme>;
  type TupleIntegerDynamicVal = tuple<Integer,DynamicVal>;
  type TupleIntegerDynamicValList = list<TupleIntegerDynamicVal>;
  type TupleStringDynamicVal = tuple<String,DynamicVal>;
  type TupleStringDynamicValList = list<TupleStringDynamicVal>;
algorithm 
  dummy:=
  matchcontinue (in_absyndeclist,in_tuplestringschemeschemelist,in_tupleintegerdynamicvallist,in_tuplestringdynamicvallist)
    local
      TupleStringSchemeSchemeList statenv_1,statenv;
      TupleIntegerDynamicValList dynstate_1,dynstate;
      TupleStringDynamicValList dynenv_1,dynenv;
      Absyn.Dec dec;
      AbsynDecList decs;
    case ({},_,_,_) then true; 
    case (dec :: decs,statenv,dynstate,dynenv)
      equation 
        statenv_1 = elaborate(statenv, dec);
        (dynstate_1,dynenv_1) = evaluate(dynstate, dynenv, dec);
        doall(decs, statenv_1, dynstate_1, dynenv_1); then true;
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
        doall(decs, Static.env0, Dynamic.state0, Dynamic.env0); then true;
  end matchcontinue;
end main;
end Main;

