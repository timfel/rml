package Types " types.rml "

type Level = Integer;

type TyName = String;

type AlphaTag = Integer;

type AlphaEq = Boolean;

type TyNameList = list<TyName>;

type AlphaOvld = Option<TyNameList>;

type TypeList = list<Type>;

uniontype Type
  record VAR
    Alpha x1;
  end VAR;
  record CONS
    TypeList x1;
    TyName x2;
  end CONS;
end Type;

type Typelvar = lvar<Type>;

uniontype Alpha
  record ALPHA
    AlphaTag x1;
    Level x2;
    AlphaEq x3;
    AlphaOvld x4;
    Typelvar x5;
  end ALPHA;
end Alpha;

public function mkAlpha
  input Integer lev;
  input Boolean eq;
  input StringListOption ovld;
  output Alpha out_alpha;
protected 
  type StringList = list<String>;
  type StringListOption = Option<StringList>;
  AlphaTag tag;
  Typelvar subst;
algorithm 
  tag := tick();
  subst := lvar_new();
  out_alpha := ALPHA(tag,lev,eq,ovld,subst);
end mkAlpha;

public function mkFreeAlpha
  input Integer lev;
  output Alpha alpha;
algorithm 
  alpha := mkAlpha(lev, false, NONE);
end mkFreeAlpha;

public function mkEqAlpha
  input Integer lev;
  output Alpha alpha;
algorithm 
  alpha := mkAlpha(lev, true, NONE);
end mkEqAlpha;

public function mkOvldAlpha
  input StringList ovld;
  input Integer lev;
  output Alpha alpha;
protected 
  type StringList = list<String>;
algorithm 
  alpha := mkAlpha(lev, false, SOME(ovld));
end mkOvldAlpha;

public function alpha_ovld
  input Alpha in_alpha;
  output StringListOption out_stringlistoption;
protected 
  type StringList = list<String>;
  type StringListOption = Option<StringList>;
algorithm 
  out_stringlistoption:=
  matchcontinue (in_alpha)
    local AlphaOvld ovld;
    case (ALPHA(_,_,_,ovld,_)) then ovld; 
  end matchcontinue;
end alpha_ovld;

public function deref
  input Type in_type;
  output Type out_type;
algorithm 
  out_type:=
  matchcontinue (in_type)
    local
      Type ty,ty_1;
      Typelvar subst;
    case ((ty = VAR(ALPHA(_,_,_,_,subst))))
      equation 
        NONE = lvar_get(subst); then ty;
    case (VAR(ALPHA(_,_,_,_,subst)))
      equation 
        SOME(ty_1) = lvar_get(subst);
        ty = deref(ty_1); then ty;
    case ((ty = CONS(_,_))) then ty; 
  end matchcontinue;
end deref;
end Types;

