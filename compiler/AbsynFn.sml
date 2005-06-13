(* absyn/absyn.sml *)

functor AbsynFn(structure MakeString : MAKESTRING
		structure Source : SOURCE
		  ) : ABSYN =
  struct

    structure Source	= Source

    (* --- start RML AST --- *)
    (* start line, start column, end line, endcolumn *)
	datatype loc = LOC of int * int * int * int

    (* filename, pos start, pos end *)
	datatype info = INFO of string * int * int * loc ref

    datatype ident	= IDENT of string * info ref
    type var		= ident
    type tyvar		= ident

    datatype longid	= LONGID of ident option * ident * info ref

    datatype lit = CCONlit of char * info ref
				 | ICONlit of int * info ref
				 | RCONlit of real * info ref
				 | SCONlit of string * info ref

    datatype ty	= VARty of tyvar * info ref
				| CONSty of ty list * longid * info ref
				| TUPLEty of ty list * info ref
				| RELty of ty list * ty list * info ref

    datatype pat = WILDpat of info ref
				 | LITpat of lit * info ref
				 | CONpat of longid * info ref
				 | STRUCTpat of longid option * pat list * info ref
				 | BINDpat of var * pat * info ref
				 | IDENTpat of ident * pat ref * info ref

    datatype exp = LITexp of lit * info ref
				 | CONexp of longid * info ref
				 | VARexp of longid * info ref
				 | STRUCTexp of longid option * exp list * info ref
				 | IDENTexp of longid * exp ref * info ref

    datatype goal = CALLgoal of longid * exp list * pat list * info ref
				  | EQUALgoal of var * exp * info ref
				  | LETgoal of pat * exp * info ref
				  | NOTgoal of goal * info ref
				  | ANDgoal of goal * goal * info ref

    datatype result	= RETURN of exp list * info ref
					| FAIL of info ref
					
    datatype clause	= CLAUSE1 of goal option * ident * pat list * result * info ref
					| CLAUSE2 of clause * clause * info ref 

    datatype conbind = CONcb of ident * info ref
					 | CTORcb of ident * ty list * info ref

    datatype datbind = DATBIND of tyvar list * ident * conbind list * info ref

    datatype typbind = TYPBIND of tyvar list * ident * ty * info ref

    datatype relbind = RELBIND of ident * ty option * clause * info ref

    datatype spec = WITHspec of string * interface ref * info ref
				  | ABSTYPEspec of bool * tyvar list * ident * info ref
				  | TYPEspec of typbind list * info ref
				  | DATAspec of datbind list * typbind list * info ref
				  | VALspec of ident * ty * info ref
				  | RELspec of ident * ty * info ref

    and interface = INTERFACE of {modid: ident,
					specs: spec list,
					source: Source.source} * info ref

    datatype dec = WITHdec of string * interface ref * info ref
			| TYPEdec of typbind list * info ref
			| DATAdec of datbind list * typbind list * info ref
			| VALdec of ident * exp * info ref
			| RELdec of relbind list * info ref

	datatype module	= MODULE of interface * dec list * info ref
    (* --- end RML AST --- *)


  (* adrpo added *)
  (* -- start Modelica+ AST *)
  datatype Path = QUALIFIED of ident * Path * info ref
	      	| PATHIDENT of ident * info ref
	      	| TYPEVARIABLE of ident * info ref	      	
  (** A component reference is the fully or partially qualified name of *)
  (** a component.  It is represented as a list of *)
  (** identifier--subscript pairs.  The type `Path', on the other hand, *)
  (** is used to store references to class names, or names inside *)
  (** class definitions. *)

  (** Within statements *)
  datatype Within = WITHIN of Path | TOP

  (** - Each attribute *)
  (** The each keyword can be present in both MODIFICATION's and REDECLARATION's. *)
  datatype Each = EACH | NON_EACH

  (** - Restrictions *)
  datatype Restriction = R_CLASS of info ref
		       | R_MODEL of info ref
		       | R_RECORD of info ref
		       | R_TYPE of info ref
		       | R_PACKAGE of info ref
		       | R_FUNCTION of info ref
		       | R_ENUMERATION of info ref
		       | R_UNIONTYPE of info ref
		       | R_TYPEVARIABLE of info ref
		       
  (** These constructors each correspond to a different kind of class *)
  (** declaration in Modelica, except the last four, which are used *)
  (** for the predefined types.  The parser assigns each class *)
  (** declaration one of the restrictions, and the actual class *)
  (** definition is checked for conformance during translation.  The *)
  (** predefined types are created in the `Builtin' module and are *)
  (** assigned special restrictions. *)

  (** - Expressions *)
  datatype Operator = 
             (* integer operators *)
			  ADD of info ref  
			| SUB of info ref
			| MUL of info ref     
			| DIV of info ref
			| POW of info ref
		    | UPLUS of info ref 
		    | UMINUS of info ref
		    | LESS of info ref  
		    | LESSEQ of info ref 
		    | GREATER of info ref 
		    | GREATEREQ of info ref 
		    | EQUAL of info ref 
		    | NEQUAL of info ref  
		    (* real operators *)
			| ADD_REAL of info ref  
			| SUB_REAL of info ref
			| MUL_REAL of info ref     
			| DIV_REAL of info ref
			| POW_REAL of info ref
		    | UPLUS_REAL of info ref 
		    | UMINUS_REAL of info ref
		    | LESS_REAL of info ref  
		    | LESSEQ_REAL of info ref 
		    | GREATER_REAL of info ref 
		    | GREATEREQ_REAL of info ref 
		    | EQUAL_REAL of info ref 
		    | NEQUAL_REAL of info ref  
		    (* boolean operators *)
		    | AND of info ref   
		    | OR of info ref
		    | NOT of info ref

  datatype Exp = INTEGER of int * info ref
	       | REAL of real * info ref
	       | CREF of ComponentRef * info ref
	       | STRING of string * info ref
	       | BOOL of bool * info ref
	       | BINARY of Exp * Operator * Exp  * info ref (* Binary operations, e.g. a*b *)
	       | UNARY of Operator * Exp  * info ref (* Unary operations, e.g. -(x) *)
	       | LBINARY of Exp * Operator * Exp  * info ref (* Logical binary operations: and, or *)
	       | LUNARY of Operator * Exp  * info ref (* Logical unary operations: not *)
	       | RELATION of Exp * Operator * Exp  * info ref (* Relations, e.g. a >= 0 *)
	       | IFEXP of Exp * Exp * Exp * (Exp * Exp) list * info ref (* If expressions *)
	       | CALL of ComponentRef * FunctionArgs  * info ref (* Function calls *)
	       | ARRAY of FunctionArgs * info ref
	       | MATRIX of Exp list list * info ref
	       | RANGE of Exp * Exp option * Exp  * info ref(* Range expressions, e.g. 1:10 or 1:0.5:10 *)
	       | TUPLE of FunctionArgs  * info ref (*PR.*) (* Tuples used in function calls returning several values *)
	       | END of info ref (* array access operator for last element, e.g. a[end]:=1; *)
	       | MSTRUCTexp of Path option * FunctionArgs * info ref (* returned from match exps *)
	       | MWILDexp of info ref
	       | MATCHexp of MatchType * (* match or matchcontinue *)
						 Exp * (* match expression of *)
						 ElementItem list * (* local decls *)
						 Case list * (* case list + else in the end with pat = [] *)
						 info ref

  and MatchType = MATCH | MATCHCONTINUE (* type of matching *)	  
  
  and FunctionArgs =  FUNCTIONARGS of NamedArg list * info ref
			| FOR_ITER_FARG of Exp list * ForIndices list * info ref
  (** The `FunctionArgs' datatype consists of a list of positional arguments *)
  (** followed by a list of named arguments (Modelica v2.0) *)
							  
  and NamedArg = NAMEDARG of ident option * Exp * info ref
  (** The `NamedArg' datatype consist of an identifier for the argument and an expression *)
  (** giving the value of the argument *)
  
  (** - Subscripts *)
  and Subscript = NOSUB of info ref
		     | SUBSCRIPT of Exp * info ref
  (** The `Subscript' datatype is used both in array declarations and *)
  (** component references.  This might seem strange, but it is *)
  (** inherited from the grammar.  The `NOSUB' constructor means that *)
  (** the dimension size is undefined when used in a declaration, and *)
  (** when it is used in a component reference it means a slice of the *)
  (** whole dimension. *)

  (** - Component references and paths *)
  and ComponentRef = CREF_QUAL of ident * ArrayDim * ComponentRef * info ref
		    	| CREF_IDENT of ident * ArrayDim * info ref
		    	| CREF_IDENT_TYPES of ident * Path list * info ref
		    	
  (** - Modifications *)
  (** Modifications are described by the `Modification' type.  There *)
  (** are two forms of modifications: redeclarations and component *)
  (** modifications. *)
  and Modification = CLASSMOD of ElementArg list * Exp option * info ref

  (* Wrapper for things that modify elements, modifications and redeclarations *)
  and ElementArg = MODIFICATION of 
					bool * 
					Each * 
					ComponentRef * 
					Modification option * 
					string option * 
					info ref
		      | REDECLARATION of 
					bool * 
					Each * 
					ElementSpec * 
					ConstrainClass option * 
					info ref

  (* ExternalDecl *)
  and ExternalDecl = EXTERNALDECL of 
				  ident option  * (* The name of the external function *)
				  string option * (* Lanugage of the external function *)
				  ComponentRef option * (* ouput parameter as return value*)
				  Exp list * (* only positional arguments, i.e. expression list*)
				  info ref      
    
  (** - Programs, the top level construct *)
  (** A program is simply a list of class definitions declared at top
   ** level in the source file, combined with a within statement that
   ** indicates the hieractical position of the program. 
   **)
  and Program = PROGRAM of Class list (* List of classes *)
				* Within (* Within statement *)
				* interface 
				* info ref

  (** - Classes *)
  (** A class definition consists of a name, a flag to indicate if this *)
  (** class is declared as `partial', the declared class restriction, *)
  (** and the body of the declaration. *)
  and Class = CLASS of ident	 (* Name *)
			  * bool		     (* Partial *)
			  * bool		     (* Final *)
			  * bool		     (* Encapsulated *)
			  * Restriction	     (* Restricion *)
			  * ClassDef         (* Body *) (* not needed for type Type_a; declarations so: PARTS([],NONE,_) *)
			  * info ref
 
  (** The `ClassDef' type contains the definition part of a class *)
  (** declaration.  The definition is either explicit, with a list of *)
  (** parts (`public', `protected', `equationc' and `algorithm'), or it *)
  (** is a definition derived from another class or an enumeration type. *)
  (** For a derived type, the  type contains the name of the derived class and an optional *)
  (** array dimension and a list of modifications. An enumeration type contains a list of *)
  and ClassDef = PARTS of ClassPart list
			       * string option	     (* string comment *)
			       * info ref
		    | DERIVED of Path
			       * ArrayDim option     (* *)
			       * ElementAttributes   
			       * ElementArg list
			       * Comment option	     (* comment *)
			       * info ref
		    | ENUMERATION of EnumLiteral list   
				* Comment option     (* comment*)		
				* info ref
	        | OVERLOAD of Path list (* function names *)
				* Comment option
				* info ref				
		    | DERIVED_TYPE of Path * Path list * Comment option * info ref (* derived type *)
		    (* 
		     type X = option<Type>            -> option type
		     type O = list<Type>              -> list type
		     type Y = record<Type,Type,Type>  -> tuple type
		     type Z = Tree<Type>              -> uniontype with replaceable type variables
		    *)
		    
  (** EnumLiteral, which is a name in an enumeration and an optional
   Comment.*)
  and EnumLiteral = ENUMLITERAL of ident (* Literal *)
			 * Comment option	     (* comment *)
			 * info ref

  (** A class definition contains several parts.  There are public and *)
  (** protected component declarations, type definitions and `extends' *)
  (** clauses, collectively called elements.  There are also equation *)
  (** sections and algorithm sections. The EXTERNAL part is used only by functions *)
  (** which can be declared as external C or FORTRAN functions. *)
  and ClassPart = PUBLIC of ElementItem list * info ref
		     | PROTECTED of ElementItem list * info ref
		     | EQUATIONS of EquationItem list * info ref
		     | INITIALEQUATIONS of EquationItem list * info ref
		     | ALGORITHMS of AlgorithmItem list * info ref
		     | INITIALALGORITHMS of AlgorithmItem list * info ref
		     | EXTERNAL of ExternalDecl * Annotation option * Annotation option * info ref

  (** An element item is either an element or an annotation *)
  and ElementItem = ELEMENTITEM of Element * info ref
		       | ANNOTATIONITEM of Annotation * info ref

  (** - Elements *)
  (* The basic element type in Modelica *)
  and Element = ELEMENT of bool		      (* final *)
			      * bool		      (* replaceable *)
			      * InnerOuter	      (* inner/outer *)	     
			      * ident                 (* Element name *)
			      * ElementSpec           (* Actual element specification*)
			      * info ref              (* file/location *)
			      * ConstrainClass option (* only valid for classdef and component*)

  (** An element is something that occurs in a public or protected
   ** section in a class definition.  There is one constructor in the
   ** `ElementSpec' type for each possible element type.  There are
   ** class definitions (`CLASSDEF'), `extends' clauses (`EXTENDS')
   ** and component declarations (`COMPONENTS').
   ** 
   ** As an example, if the element `extends TwoPin;' appears
   ** in the source, it is represented in the AST as
   ** `EXTENDS(IDENT("TwoPin"),[])'.
   **)
  and ElementSpec = CLASSDEF of bool	     (* replaceable *)
				   * Class * info ref
		       | EXTENDS of Path * ElementArg list * info ref
		       | IMPORT of Import * Comment option * info ref
		       | COMPONENTS of ElementAttributes (*1.1 contains Araydim also.*)
				     * Path	     (* type name *)
				     * ComponentItem list
				     * info ref
  (** One of the keyword inner and outer CAN be given to reference an inner or
      outer component. Thus there are three disjoint possibilities. **)		     
  and InnerOuter = INNER of info ref
				| OUTER of info ref
				| INNEROUTER of info ref
				| UNSPECIFIED

  (* Import statements, different kinds  *) 				     
  and Import = NAMED_IMPORT of ident * Path * info ref
		  | QUAL_IMPORT of Path * info ref
		  | UNQUAL_IMPORT of Path * info ref

  (* Collection of component and an optional comment *)
  and ComponentItem = COMPONENTITEM of Component
					  * Comment option
					  * info ref

  (* Some kind of Modelica entity (object or variable) *)
  and Component = COMPONENT of ident 	     (* component name *)
				  * ArrayDim         (* Array dimensions, if any *) 
				  * Modification option (* Optional modification *)
				  * info ref 

  (** Several component declarations can be grouped together in one *)
  (** `ElementSpec' by writing them on the same line in the source. *)
  (** This type contains the information specific to one component. *)
  and EquationItem = EQUATIONITEM of Equation * Comment option * info ref
			| EQUATIONITEMANN of Annotation * info ref 

  (** Info specific for an algorithm item. *)
  and AlgorithmItem = ALGORITHMITEM  of Algorithm * Comment option * info ref
			 |  ALGORITHMITEMANN of Annotation * info ref

  and ForIndices = FORINDICE of ident * Exp option * info ref
  (* Information on one (kind) of equation, different constructors for different
     kinds of equations *)
  and Equation = EQ_IF of Exp                     (* Conditional expression *)
			     * EquationItem list	     (* true branch *)  
			     * (Exp * EquationItem list) list (* elseif branches *)
			     * EquationItem list	     (* else branch *)
			     * info ref
		    | EQ_EQUALS of Exp * Exp * info ref (* Standard 2-side eqn*)
		    | EQ_CONNECT of ComponentRef * ComponentRef * info ref (* Connect stmt *)
		    | EQ_FOR of ForIndices list * EquationItem list * info ref (* For-loops *)
		    | EQ_WHEN_E of Exp (* Condition *)
				* EquationItem list (* Loop body *)
				* (Exp * EquationItem list) list (* else when *)
				* info ref
		    | EQ_NORETCALL of ComponentRef * FunctionArgs * info ref(* fcalls without return value *)
		    | EQ_FAILURE of Equation * info ref (* not goals *)
		    | EQ_EQUALITY of Equation * info ref(* unification goals *)
		    
  (** The `Algorithm' type describes one algorithm statement in an *)
  (** algorithm section.  It does not describe a whole algorithm.  The *)
  (** reason this type is named like this is that the name of the *)
  (** grammar rule for algorithm statements is `algorithm'. *)
  and Algorithm = ALG_ASSIGN of Exp * Exp * info ref
		     | ALG_TUPLE_ASSIGN of Exp 		(*tuple*)  
					* Exp 		(* value*) 	
					* info ref
		     | ALG_IF of Exp
			       * AlgorithmItem list	     (* true branch *)  
			       * (Exp * AlgorithmItem list) list (* elseif *)
			       * AlgorithmItem list	     (* else branch *)
			       * info ref
		     | ALG_FOR of ForIndices list * AlgorithmItem list * info ref
		     | ALG_WHILE of Exp * AlgorithmItem list * info ref
		     | ALG_WHEN_A of Exp 
					* AlgorithmItem list 
					* (Exp * AlgorithmItem list) list (* elsewhen *)
					* info ref
		     | ALG_NORETCALL of ComponentRef * FunctionArgs * info ref(* general fcalls without return value *)
		     | ALG_FAILURE of Algorithm (* not goals *)
		     | ALG_EQUALITY of Algorithm (* unification goals *)

  and Case = CASE of Pattern list * (* patterns to be matched *) 
					 ElementItem list * (* local decls *)
					 ClassPart  * (* equations [] for no equations: axioms *)
					 Exp * (* result: 
					          when nothing is returned: MSTRUCTexp(NONE,   [], _)
					          when fail is returned:    MSTRUCTexp(SOME("FAIL"), [], _) *) 
					 string option * (* comment after case like: case pattern string_comment *) 
					 string option * (* comment after case like: case pattern ... then expr; string_comment *)					 
					 info ref
					 
  (* Dete *) 
  and Variability = VAR
				| DISCRETE of info ref 
				| PARAM of info ref
				| CONST of info ref
				
  and Direction = INPUT of info ref
				| OUTPUT of info ref
				| BIDIR of info ref
  
  (** - Component attributes *)
  and ElementAttributes = ATTR of bool	(* flow *)
			     	     * Variability (* parameter, constant etc. *)
			     	     * Direction
						 * ArrayDim  (*1.1*)
						 * info ref
  (** Component attributes are *)
  (** properties of components which are applied by type prefixes. *)
  (** As an example, declaring a component as `input Real x;' will *)
  (** give the attributes `ATTR([],false,VAR,INPUT)'. *)
  
  (** Annotation *)
  and Annotation = ANNOTATION of ElementArg list * info ref
  (** An Annotation is a class_modification. *)

  (** Comment *)	
  and Comment = COMMENT of Annotation option 
				* string option 
				* info ref
				
  (** Modelica+ Patterns **)
  and Pattern = MWILDpat of info ref
			| MLITpat of Exp * info ref
			| MCONpat of Path * info ref
			| MSTRUCTpat of Path option * Pattern list * info ref
			| MBINDpat of var * Pattern * info ref
			| MIDENTpat of ident * Pattern ref * info ref

  (** Components in Modelica can be scalar or arrays with one or more *)
  (** dimensions. This datatype is used to indicate the dimensionality *)
  (** of a component or a type definition. *)
  (** - Array dimensions *)
  withtype ArrayDim = Subscript list
  (* Constraining type, must be extendes *)
  and ConstrainClass = ElementSpec
  
  datatype Package = PACKAGE of ident *    (* the package name, example: Absyn *)
								Class list (* the public package classes, example: Absyn.PROGRAM ... *)
  datatype modelica = 
	MODELICA of Program *  (* the actual program *) 
                Package list (* the externaly defined record constructors patched with
                              the package name *)
  (* --- end Modelica+ AST --- *)

    structure IdentDict =
      AADictFn(
      struct
		 type ord_key = ident
		 fun compare(IDENT(s1,_), IDENT(s2,_)) = String.compare(s1, s2)
	  end)

    val dummyLoc  = LOC(0, 0, 0, 0)

    val dummyInfo = INFO("RML", 0, 0, ref dummyLoc)

    fun makeIdent(name, info) = IDENT(name, info)
    fun rmlIdent name = IDENT(name, ref dummyInfo)
    fun identName(IDENT(name,_)) = name
    fun identCtxInfo(IDENT(_, ref(info))) = info
    fun lidentName(LONGID(SOME(IDENT(name1,_)),IDENT(name2,_),_)) = name1^"."^name2
    | lidentName(LONGID(NONE,IDENT(name,_),_)) = name
    fun lidentCtxInfo(LONGID(_, _, ref(info))) = info    
    fun identEqual(IDENT(s1,_), IDENT(s2,_)) = (s1 = s2)

    fun litEqual(CCONlit(c1, _), CCONlit(c2, _)) = (c1 = c2)
      | litEqual(ICONlit(i1, _), ICONlit(i2, _)) = (i1 = i2)
      | litEqual(RCONlit(r1, _), RCONlit(r2, _)) = Real.==(r1, r2)
      | litEqual(SCONlit(s1, _), SCONlit(s2, _)) = (s1 = s2)
      | litEqual(_, _) = false

    fun litString(CCONlit(c, _)) = MakeString.ccvt c
      | litString(ICONlit(i, _)) = MakeString.icvt i
      | litString(RCONlit(r, _)) = MakeString.rcvt r
      | litString(SCONlit(s, _)) = MakeString.scvt s
    
    val dummyInterface =
      INTERFACE({modid = rmlIdent "", specs = [], source = Source.dummy}, ref dummyInfo)

  end (* functor AbsynFn *)
