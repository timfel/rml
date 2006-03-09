*********
COMPARE 1
*********

class Exp 

record RCONST Real x1; end RCONST;
record ADDop Exp x1; Exp x2; end ADDop;


end Exp;

CLASS(Exp,PUBLIC
(ELEMENT( , CLASSDEF
(RECORD(RCONST,PUBLIC
	(ELEMENT( , COMPONENTS(ATTR(,,),Real,COMPONENTITEM(x1,<comment>)), NoFile, 3))))
, NoFile, 3)
ELEMENT( , CLASSDEF
(RECORD(ADDop,PUBLIC
	(ELEMENT( , COMPONENTS(ATTR(,,),Exp,COMPONENTITEM(x1,<comment>)), NoFile, 4)
	ELEMENT( , COMPONENTS(ATTR(,,),Exp,COMPONENTITEM(x2,<comment>)), NoFile, 4)
))), NoFile, 4)))


module exp1:
  datatype Exp = RCONST of real
		| ADDop of Exp * Exp

end

uniontype(Exp,PUBLIC
(ELEMENT( , CLASSDEF
(record(RCONST,PUBLIC
	(ELEMENT( , COMPONENTS(ATTR(,,),real,COMPONENTITEM(x1[:],<comment>)), NoFile, 0))))
, NoFile, 0)
ELEMENT( , CLASSDEF
(record(ADDop,PUBLIC
	(ELEMENT( , COMPONENTS(ATTR(,,),Exp,COMPONENTITEM(x1[:],<comment>)), NoFile, 0)
	ELEMENT( , COMPONENTS(ATTR(,,),Exp,COMPONENTITEM(x1[:],<comment>)), NoFile, 0))))
, NoFile, 0)))

2. COMPONENTITEM(x1[:]) is a vector