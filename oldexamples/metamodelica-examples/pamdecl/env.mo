package Env

type Ident = String;

uniontype Value
  record INTVAL
    Integer x1;
  end INTVAL;
  record REALVAL
    Real x1;
  end REALVAL;
  record BOOLVAL
    Boolean x1;
  end BOOLVAL;
end Value;

uniontype Value2
  record INTVAL2
    Integer x1;
    Integer x2;
  end INTVAL2;
  record REALVAL2
    Real x1;
    Real x2;
  end REALVAL2;
end Value2;

uniontype Type
  record INTTYPE
  end INTTYPE;
  record REALTYPE
  end REALTYPE;
  record BOOLTYPE
  end BOOLTYPE;
end Type;

uniontype Bind
  record BIND
    Ident x1;
    Type x2;
    Value x3;
  end BIND;
end Bind;

type Env = list<Bind>;

public function initial_
  output BindList out_bindlist;
protected 
  type BindList = list<Bind>;
algorithm 
  out_bindlist:=
  matchcontinue (true)
    case true then list(BIND("false",BOOLTYPE(),BOOLVAL(false)),
          BIND("true",BOOLTYPE(),BOOLVAL(true))); 
  end matchcontinue;
end initial_;

public function lookup
  input Env in_env;
  input Ident in_ident;
  output Value out_value;
algorithm 
  out_value:=
  matchcontinue (in_env,in_ident)
    local
      Ident idenv,id;
      Value v;
      Env rest;
    case (BIND(idenv,_,v) :: _,id)
      equation 
        equality(id = idenv); then v;
    case (BIND(idenv,_,_) :: rest,id)
      equation 
        failure(equality(id = idenv));
        v = lookup(rest, id); then v;
  end matchcontinue;
end lookup;

public function lookuptype
  input Env in_env;
  input Ident in_ident;
  output Type out_type;
algorithm 
  out_type:=
  matchcontinue (in_env,in_ident)
    local
      Ident idenv,id;
      Type t;
      Env rest;
    case (BIND(idenv,t,_) :: _,id)
      equation 
        equality(id = idenv); then t;
    case (BIND(idenv,_,_) :: rest,id)
      equation 
        failure(equality(id = idenv));
        t = lookuptype(rest, id); then t;
  end matchcontinue;
end lookuptype;

public function update
  input Env env;
  input Ident id;
  input Type ty;
  input Value v;
  output Env newenv;
algorithm 
  newenv := BIND(id,ty,v) :: env;
end update;
end Env;

