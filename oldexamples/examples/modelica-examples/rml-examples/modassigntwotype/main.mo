package Main " file: main.rml "
import parse;
import eval;

protected function printvalue
  input Eval.Value in_value;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_value)
    local
      String x_1;
      Integer x;
    case (Eval.INTval(x))
      equation 
        x_1 = int_string(x);
        print(x_1); then true;
    case (Eval.REALval(x))
      local Real x;
      equation 
        x_1 = real_string(x);
        print(x_1); then true;
  end matchcontinue;
end printvalue;

protected function eval_loop
  input Eval.Env in_env;
  output Boolean dummy;
algorithm 
  dummy:=
  matchcontinue (in_env)
    local
      type TupleStringEvalValue = tuple<String,EvalValue>;
      type TupleStringEvalValueList = list<TupleStringEvalValue>;
      Absyn.Exp ast;
      TupleStringEvalValueList env2,env;
      Eval.Value value;
    case (env)
      equation 
        print("\n> ");
        ast = Parse.parse();
        (env2,value) = Eval.eval(env, ast);
        printvalue(value);
        eval_loop(env2); then true;
    case (env) "** INCOMPLETE!! "
      equation 
        failure(ast = Parse.parse());
        print("Syntax error in input line\n"); then true;
  end matchcontinue;
end eval_loop;

public function main "
relation safe_parse_expr   (t.ex. via option NONE vid fel or SOME vid OK )


relation safe_eval 
  * om evaluering går fel; två fall eval.eval och not eval.eval vid fail "
  input StringList in_stringlist;
  output Boolean dummy;
protected 
  type StringList = list<String>;
algorithm 
  dummy:=
  matchcontinue (in_stringlist)
    case _
      equation 
        eval_loop(Eval.init_env); then true;
  end matchcontinue;
end main;
end Main;

