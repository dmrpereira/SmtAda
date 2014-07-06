with Interfaces.C ;

package CVC3_Kinds is

  --*************************************************************************** 
  -- The commonly used kinds and the kinds needed by the parser.  All
  -- these kinds are registered by the ExprManager and are readily
  -- available for everyone else.
  -- Constant (Leaf) Exprs
  -- All constants should have kinds less than MAX_CONST
  -- Generic LISP kinds for representing raw parsed expressions
  --!< May have any number of children >= 0
  --! Identifier is (ID (STRING_EXPR "name"))
  -- Types
  --   TUPLE_TYPE,
  -- The "type" of any expression type (as in BOOLEAN : TYPE).
  -- Declaration of new (uninterpreted) types: T1, T2, ... : TYPE
  -- (TYPEDECL T1 T2 ...)
  -- Declaration of a defined type T : TYPE = type === (TYPEDEF T type)
  -- Equality
  -- Propositional connectives
  --  BOOL_VAR, //!< Boolean variables are treated as 0-ary predicates
  -- Propositional relations (for circuit propagation)
  -- (ITE c e1 e2) == IF c THEN e1 ELSE e2 ENDIF, the internal
  -- representation of the conditional.  Parser produces (IF ...).
  -- Quantifiers
  -- Uninterpreted function
  -- Application of a function
  -- Top-level Commands
  -- Kinds used mostly in the parser
  -- Variable declaration (VARDECL v1 v2 ... v_n type).  A variable
  -- can be an ID or a BOUNDVAR.
  -- A list of variable declarations (VARDECLS (VARDECL ...) (VARDECL ...) ...)
  -- Bound variables have a "printable name", the one the user typed
  -- in, and a uniqueID used to distinguish it from other bound
  -- variables, which is effectively the alpha-renaming:
  -- Op(BOUND_VAR (BOUND_ID "user_name" "uniqueID")).  Note that
  -- BOUND_VAR is an operator (Expr without children), just as UFUNC
  -- and UCONST.
  -- The uniqueID normally is just a number, so one can print a bound
  -- variable X as X_17.
  -- NOTE that in the parsed expressions like LET x: T = e IN foo(x),
  -- the second instance of 'x' will be an ID, and *not* a BOUNDVAR.
  -- The parser does not know how to resolve bound variables, and it
  -- has to be resolved later.
  -- Updator "e1 WITH <bunch of stuff> := e2" is represented as
  -- (UPDATE e1 (UPDATE_SELECT <bunch of stuff>) e2), where <bunch
  -- of stuff> is the list of accessors:
  -- (READ idx)
  -- ID (what's that for?)
  -- (REC_SELECT ID)
  -- and (TUPLE_SELECT num).
  --   UPDATE,
  --   UPDATE_SELECT,
  -- Record type [# f1 : t1, f2 : t2 ... #] is represented as
  -- (RECORD_TYPE (f1 t1) (f2 t2) ... )
  --   RECORD_TYPE,
  --   // (# f1=e1, f2=e2, ...#) == (RECORD (f1 e1) ...)
  --   RECORD,
  --   RECORD_SELECT,
  --   RECORD_UPDATE,
  --   // (e1, e2, ...) == (TUPLE e1 e2 ...)
  --   TUPLE,
  --   TUPLE_SELECT,
  --   TUPLE_UPDATE,
  --   SUBRANGE,
  -- Enumerated type (SCALARTYPE v1 v2 ...)
  --   SCALARTYPE,
  -- Predicate subtype: the argument is the predicate (lambda-expression)
  -- Datatype is Expr(DATATYPE, Constructors), where Constructors is a
  -- vector of Expr(CONSTRUCTOR, id [ , arg ]), where 'id' is an ID,
  -- and 'arg' a VARDECL node (list of variable declarations with
  -- types).  If 'arg' is present, the constructor has arguments
  -- corresponding to the declared variables.
  --   DATATYPE,
  --   THISTYPE, // Used to indicate recursion in recursive datatypes
  --   CONSTRUCTOR,
  --   SELECTOR,
  --   TESTER,
  -- Expression e WITH accessor := e2 is transformed by the command
  -- processor into (DATATYPE_UPDATE e accessor e2), where e is the
  -- original datatype value C(a1, ..., an) (here C is the
  -- constructor), and "accessor" is the name of one of the arguments
  -- a_i of C.
  --  DATATYPE_UPDATE,
  -- Statement IF c1 THEN e1 ELSIF c2 THEN e2 ... ELSE e_n ENDIF is
  -- represented as (IF (IFTHEN c1 e1) (IFTHEN c2 e2) ... (ELSE e_n))
  -- Lisp version of multi-branch IF:
  -- (COND (c1 e1) (c2 e2) ... (ELSE en))
  -- LET x1: t1 = e1, x2: t2 = e2, ... IN e
  -- Parser builds:
  -- (LET (LETDECLS (LETDECL x1 t1 e1) (LETDECL x2 t2 e2) ... ) e)
  -- where each x_i is a BOUNDVAR.
  -- After processing, it is rebuilt to have (LETDECL var def); the
  -- type is set as the attribute to var.
  -- Lambda-abstraction LAMBDA (<vars>) : e  === (LAMBDA <vars> e)
  -- Symbolic simulation operator
  -- Uninterpreted constants (variables) x1, x2, ... , x_n : type
  -- (CONST (VARLIST x1 x2 ... x_n) type)
  -- Uninterpreted functions are declared as constants of functional type.
  -- After processing, uninterpreted functions and constants
  -- (a.k.a. variables) are represented as Op(UFUNC, (ID "name")) and
  -- Op(UCONST, (ID "name")) with the appropriate type attribute.
  -- User function definition f(args) : type = e === (DEFUN args type e)
  -- Here 'args' are bound var declarations
  -- Arithmetic types and operators
  --   REAL,
  --   INT,
  --   UMINUS,
  --   PLUS,
  --   MINUS,
  --   MULT,
  --   DIVIDE,
  --   INTDIV,
  --   MOD,
  --   LT,
  --   LE,
  --   GT,
  --   GE,
  --   IS_INTEGER,
  --   NEGINF,
  --   POSINF,
  --   DARK_SHADOW,
  --   GRAY_SHADOW,
  --   //Floor theory operators
  --   FLOOR,
  -- Kind for Extension to Non-linear Arithmetic
  --   POW,
  -- Kinds for proof terms
  --   // Mlss
  --   EMPTY, // {}
  --   UNION, // +
  --   INTER, // *
  --   DIFF,
  --   SINGLETON,
  --   IN,
  --   INCS,
  --   INCIN,
  --Skolem variable
  -- Expr that holds a theorem
  --! Must always be the last kind
   type Kind is
     ( NULL_KIND ,
       TRUE_EXPR ,
       FALSE_EXPR ,
       RATIONAL_EXPR ,
       STRING_EXPR ,
       MAX_CONST ,
       RAW_LIST ,
       ID ,
       BOOLEAN ,
       ANY_TYPE ,
       ARROW ,
       C_TYPE ,
       TYPEDECL ,
       TYPEDEF ,
       EQ ,
       NEQ ,
       DISTINCT ,
       C_NOT ,
       C_AND ,
       C_OR ,
       C_XOR ,
       IFF ,
       IMPLIES ,
       AND_R ,
       IFF_R ,
       ITE_R ,
       ITE ,
       FORALL ,
       EXISTS ,
       UFUNC ,
       APPLY ,
       ASSERT ,
       QUERY ,
       CHECKSAT ,
       CONTINUE ,
       RESTART ,
       DBG ,
       TRACE ,
       UNTRACE ,
       OPTION ,
       HELP ,
       TRANSFORM ,
       PRINT ,
       CALL ,
       ECHO ,
       INCLUDE ,
       GET_VALUE ,
       GET_ASSIGNMENT ,
       DUMP_PROOF ,
       DUMP_ASSUMPTIONS ,
       DUMP_SIG ,
       DUMP_TCC ,
       DUMP_TCC_ASSUMPTIONS ,
       DUMP_TCC_PROOF ,
       DUMP_CLOSURE ,
       DUMP_CLOSURE_PROOF ,
       WHERE ,
       ASSERTIONS ,
       ASSUMPTIONS ,
       COUNTEREXAMPLE ,
       COUNTERMODEL ,
       PUSH ,
       POP ,
       POPTO ,
       PUSH_SCOPE ,
       POP_SCOPE ,
       POPTO_SCOPE ,
       RESET ,
       CONTEXT ,
       FORGET ,
       GET_TYPE ,
       CHECK_TYPE ,
       GET_CHILD ,
       SUBSTITUTE ,
       SEQ ,
       ARITH_VAR_ORDER ,
       ANNOTATION ,
       TCC ,
       VARDECL ,
       VARDECLS ,
       BOUND_VAR ,
       BOUND_ID ,
       C_SUBTYPE ,
       C_IF ,
       IFTHEN ,
       C_ELSE ,
       COND ,
       LET ,
       LETDECLS ,
       LETDECL ,
       LAMBDA ,
       SIMULATE ,
       CONST ,
       VARLIST ,
       UCONST ,
       DEFUN ,
       PF_APPLY ,
       PF_HOLE ,
       SKOLEM_VAR ,
       THEOREM_KIND ,
       LAST_KIND ) ;
   
   for Kind use  
     ( NULL_KIND => 0, 
       TRUE_EXPR => 1 ,
       FALSE_EXPR => 2 ,
       RATIONAL_EXPR => 3 ,
       STRING_EXPR => 4 ,
       MAX_CONST => 100 ,
       RAW_LIST => 101 ,
       ID => 102 ,
       BOOLEAN => 103 ,
       ANY_TYPE => 104 ,
       ARROW => 105 ,
       C_TYPE => 106 ,
       TYPEDECL => 107 ,
       TYPEDEF => 108 ,
       EQ => 109 ,
       NEQ => 110 ,
       DISTINCT => 111 ,
       C_NOT => 112 ,
       C_AND => 113 ,
       C_OR => 114 ,
       C_XOR => 115 ,
       IFF => 116 ,
       IMPLIES => 117 ,
       AND_R => 118 ,
       IFF_R => 119 ,
       ITE_R => 120 ,
       ITE => 121 ,
       FORALL => 122 ,
       EXISTS => 123 ,
       UFUNC => 124 ,
       APPLY => 125 ,
       ASSERT => 126 ,
       QUERY => 127 ,
       CHECKSAT => 128 ,
       CONTINUE => 129 ,
       RESTART => 130 ,
       DBG => 131 ,
       TRACE => 132 ,
       UNTRACE => 133 ,
       OPTION => 134 ,
       HELP => 135 ,
       TRANSFORM => 136 ,
       PRINT => 137 ,
       CALL => 138 ,
       ECHO => 139 ,
       INCLUDE => 140 ,
       GET_VALUE => 141 ,
       GET_ASSIGNMENT => 142 ,
       DUMP_PROOF => 143 ,
       DUMP_ASSUMPTIONS => 144 ,
       DUMP_SIG => 145 ,
       DUMP_TCC => 146 ,
       DUMP_TCC_ASSUMPTIONS => 147 ,
       DUMP_TCC_PROOF => 148 ,
       DUMP_CLOSURE => 149 ,
       DUMP_CLOSURE_PROOF => 150 ,
       WHERE => 151 ,
       ASSERTIONS => 152 ,
       ASSUMPTIONS => 153 ,
       COUNTEREXAMPLE => 154 ,
       COUNTERMODEL => 155 ,
       PUSH => 156 ,
       POP => 157 ,
       POPTO => 158 ,
       PUSH_SCOPE => 159 ,
       POP_SCOPE => 160 ,
       POPTO_SCOPE => 161 ,
       RESET => 162 ,
       CONTEXT => 163 ,
       FORGET => 164 ,
       GET_TYPE => 165 ,
       CHECK_TYPE => 166 ,
       GET_CHILD => 167 ,
       SUBSTITUTE => 168 ,
       SEQ => 169 ,
       ARITH_VAR_ORDER => 170 ,
       ANNOTATION => 171 ,
       TCC => 172 ,
       VARDECL => 173 ,
       VARDECLS => 174 ,
       BOUND_VAR => 175 ,
       BOUND_ID => 176 ,
       C_SUBTYPE => 177 ,
       C_IF => 178 ,
       IFTHEN => 179 ,
       C_ELSE => 180 ,
       COND => 181 ,
       LET => 182 ,
       LETDECLS => 183 ,
       LETDECL => 184 ,
       LAMBDA => 185 ,
       SIMULATE => 186 ,
       CONST => 187 ,
       VARLIST => 188 ,
       UCONST => 189 ,
       DEFUN => 190 ,
       PF_APPLY => 191 ,
       PF_HOLE => 192 ,
       SKOLEM_VAR => 193 ,
       THEOREM_KIND => 194 ,
       LAST_KIND => 195 )  ;
   
   pragma Convention(C,Kind) ;
   

  -- end of namespace CVC3
end CVC3_Kinds ;
