with Interfaces.C, Interfaces.C.Strings, System ;
with CVC3_Kinds, CVC3_Defs  ;
use CVC3_Kinds, CVC3_Defs  ;

package CVC3 is

   ------------------------------
   --                          --
   -- Binding to c_interface.h --
   --                          --
   ------------------------------
   
   -- Flags can be NULL
   function Vc_CreateValidityChecker( Arg1 : CVC_Flags ) return CVC_VC ;  
   pragma Import(C,Vc_CreateValidityChecker,"vc_createValidityChecker") ;

   -- Create validity checker's flags
   function Vc_CreateFlags return CVC_Flags ;  
   pragma Import(C,Vc_CreateFlags,"vc_createFlags") ;

   -- Destroy the validity checker.
   -- Must be called after all other objects are deleted, except the flags  
   procedure Vc_DestroyValidityChecker( Arg1 : CVC_VC ) ;  
   pragma Import(C,Vc_DestroyValidityChecker,"vc_destroyValidityChecker") ;

   -- Delete the flags
   procedure Vc_DeleteFlags( Arg1 : CVC_Flags ) ;  
   pragma Import(C,Vc_DeleteFlags,"vc_deleteFlags") ;

   -- Delete type
   procedure Vc_DeleteType( Arg1 : CVC_Ctype ) ;  
   pragma Import(C,Vc_DeleteType,"vc_deleteType") ;

   -- Delete expression
   procedure vc_deleteExpr( Arg1 : CVC_Expr) ;  
   pragma Import(C,Vc_DeleteExpr,"vc_deleteExpr") ;

   -- Delete operator
   procedure Vc_DeleteOp( Arg1 : CVC_Op ) ;  
   pragma Import(C,Vc_DeleteOp,"vc_deleteOp") ;

   -- Delete vector of expressions
   procedure Vc_DeleteVector( Arg1 : System.Address ) ;  
   pragma Import(C,Vc_DeleteVector,"vc_deleteVector") ;

   -- Delete vector of types
   procedure Vc_DeleteTypeVector( Arg1 : System.Address ) ;  
   pragma Import(C,Vc_DeleteTypeVector,"vc_deleteTypeVector") ;

   -- Setting the flags
   -- Set a boolean flag to true or false
   procedure Vc_SetBoolFlag( Arg1 : CVC_Flags ; Arg2 : Interfaces.C.Strings.Chars_Ptr ; Arg3 : Interfaces.C.Int ) ;  
   pragma Import(C,Vc_SetBoolFlag,"vc_setBoolFlag") ;

   -- Set an integer flag to the given value
   procedure vc_setIntFlag( Arg1 : CVC_Flags ; Arg2 : Interfaces.C.Strings.Chars_Ptr ; Arg3 : Interfaces.C.Int ) ;  
   pragma Import(C,Vc_SetIntFlag,"vc_setIntFlag") ;

   -- Set a string flag to the given value
   procedure vc_setStringFlag( Arg1 : CVC_Flags ; Arg2 : Interfaces.C.Strings.Chars_Ptr ; Arg3 : Interfaces.C.Strings.Chars_Ptr ) ;  
   pragma Import(C,Vc_SetStringFlag,"vc_setStringFlag");

   -- Add a (string, bool) pair to the multy-string flag
   procedure Vc_SetStrSeqFlag( Arg1 : CVC_Flags ; Arg2 : Interfaces.C.Strings.Chars_Ptr ; Arg3 : Interfaces.C.Strings.Chars_Ptr ; Arg4 : Interfaces.C.Int ) ;  
   pragma Import (C,Vc_SetStrSeqFlag,"vc_setStrSeqFlag") ;

   -- Basic types
   function Vc_BoolType( Arg1 : CVC_VC ) return CVC_Ctype ;  
   pragma Import(C,Vc_BoolType,"vc_boolType") ;

   function Vc_RealType( Arg1 : CVC_VC ) return CVC_Ctype ;  
   pragma Import(C,Vc_RealType,"vc_realType") ;

   function Vc_IntType( Arg1 : CVC_VC ) return CVC_Ctype ;  
   pragma Import(C,Vc_IntType,"vc_intType") ;

   -- Create a subrange type
   function Vc_SubRangeType( Arg1 : CVC_VC ; Arg2 : Interfaces.C.Int ; arg3 : Interfaces.C.Int ) return CVC_Ctype ;  
   pragma Import(C,Vc_SubRangeType,"vc_subRangeType") ;

   -- Creates a subtype defined by the given predicate
   --
   -- [pred] is a predicate taking one argument of type T and returning
   -- Boolean.  The resulting type is a subtype of T whose elements x are those
   -- satisfying the predicate pred(x).
   -- 
   -- [witness] is an expression of type T for which pred holds (if a Null
   -- expression is passed as a witness, cvc will try to prove \f$\exists x. pred(x))\f$.
   -- if the witness check fails, a TypecheckException is thrown.
   function Vc_SubtypeType( Arg1 : CVC_VC ; Arg2 : CVC_Expr ; Arg3 : CVC_Expr ) return CVC_Ctype ;  
   pragma Import(C,Vc_SubtypeType,"vc_subtypeType") ;

   -- Tuple types
   function Vc_TupleType2( Arg1 : CVC_VC ; Arg2 : CVC_Ctype ; Arg3 : CVC_Ctype ) return CVC_Ctype ;  
   pragma Import(C,Vc_TupleType2,"vc_tupleType2") ;

   function Vc_TupleType3( Arg1 : CVC_VC ; Arg2 : CVC_Ctype ; arg3 : CVC_Ctype ; arg4 : CVC_Ctype ) return CVC_Ctype ;  
   pragma Import(C,Vc_TupleType3,"vc_tupleType3") ;

  --! Create a tuple type.  'types' is an array of types of length numTypes.
   function vc_tupleTypeN( Arg1 : CVC_VC ; Arg2 : System.Address ; Arg3 : Interfaces.C.Int ) return CVC_Ctype ;  
   pragma Import(C,Vc_TupleTypeN,"vc_tupleTypeN") ;

  -- Record types
   function vc_recordType1
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_recordType1, "vc_recordType1");

   function vc_recordType2
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Ctype;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_recordType2, "vc_recordType2");

   function vc_recordType3
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Ctype;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : CVC_Ctype;
      arg6 : Interfaces.C.Strings.chars_ptr;
      arg7 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_recordType3, "vc_recordType3");

  --! Create a record type.
  --! 'fields' and 'types' are arrays of length numFields.  
   function vc_recordTypeN
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : System.Address;
      arg4 : Interfaces.C.Int ) return CVC_Ctype;  
   pragma Import (C, vc_recordTypeN, "vc_recordTypeN");

  -- Datatypes
  --! Single datatype, single constructor
  --! The types are either type exressions (obtained from a type with
  -- *  getExpr()) or string expressions containing the name of (one of) the
  -- *  dataType(s) being defined.  

   function vc_dataType1
     (Arg1 : CVC_VC ;
      Arg2 : Interfaces.C.Strings.Chars_Ptr ;
      Arg3 : Interfaces.C.Strings.Chars_Ptr ;
      Arg4 : Interfaces.C.Int ;
      Arg5 : System.Address;
      Arg6 : System.Address) return CVC_Ctype;  
   pragma Import (C, vc_dataType1, "vc_dataType1");

  --! Single datatype, multiple constructors
  --! The types are either type exressions (obtained from a type with
  -- *  getExpr()) or string expressions containing the name of (one of) the
  -- *  dataType(s) being defined.  

   function vc_dataTypeN
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Int ;
      arg4 : System.Address;
      arg5 : access Interfaces.C.Int ;
      arg6 : System.Address;
      arg7 : System.Address) return CVC_Ctype;  
   pragma Import (C, vc_dataTypeN, "vc_dataTypeN");

  --! Multiple datatypes
  --! The types are either type exressions (obtained from a type with
  -- *  getExpr()) or string expressions containing the name of (one of) the
  -- *  dataType(s) being defined.
  -- *  Returns an array of size numTypes which must be freed by calling
  -- *  vc_deleteTypeVector.
  --  

   function vc_dataTypeMN
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : System.Address;
      arg4 : access Interfaces.C.Int ;
      arg5 : System.Address;
      arg6 : System.Address;
      arg7 : System.Address;
      arg8 : System.Address) return System.Address;  
   pragma Import (C, vc_dataTypeMN, "vc_dataTypeMN");

  --! Create an array type
   function vc_arrayType
     (arg1 : CVC_VC;
      arg2 : CVC_Ctype;
      arg3 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_arrayType, "vc_arrayType");

  --! Create a bitvector type of length n
   function vc_bvType (arg1 : CVC_VC; arg2 : Interfaces.C.Int ) return CVC_Ctype;  
   pragma Import (C, vc_bvType, "vc_bvType");

  --! Create a function type with 1 argument
   function vc_funType1
     (arg1 : CVC_VC;
      arg2 : CVC_Ctype;
      arg3 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_funType1, "vc_funType1");

  --! Create a function type with 2 arguments
   function vc_funType2
     (arg1 : CVC_VC;
      arg2 : CVC_Ctype;
      arg3 : CVC_Ctype;
      arg4 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_funType2, "vc_funType2");

  --! Create a function type with 3 arguments
   function vc_funType3
     (arg1 : CVC_VC;
      arg2 : CVC_Ctype;
      arg3 : CVC_Ctype;
      arg4 : CVC_Ctype;
      arg5 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_funType3, "vc_funType3");

  --! Create a function type with N arguments
   function vc_funTypeN
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : CVC_Ctype;
      arg4 : Interfaces.C.Int ) return CVC_Ctype;  
   pragma Import (C, vc_funTypeN, "vc_funTypeN");

  -- User-defined types
  --! Create an uninterpreted named type
   function vc_createType (arg1 : CVC_VC; arg2 : Interfaces.C.Strings.chars_ptr) return CVC_Ctype;  
   pragma Import (C, vc_createType, "vc_createType");

  --! Lookup a user-defined (uninterpreted) type by name
   function vc_lookupType (arg1 : CVC_VC; arg2 : Interfaces.C.Strings.chars_ptr) return CVC_Ctype;  
   pragma Import (C, vc_lookupType, "vc_lookupType");

  --///////////////////////////////////////////////////////////////////////////
  -- Expr manipulation methods                                               //
  --///////////////////////////////////////////////////////////////////////////
  --! Return the ExprManager
   function vc_getEM (arg1 : CVC_VC) return System.Address;  
   pragma Import (C, vc_getEM, "vc_getEM");

  --! Create a variable with a given name and type
  --! The type cannot be a function type.  
   function vc_varExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Ctype) return CVC_Expr;  
   pragma Import (C, vc_varExpr, "vc_varExpr");

  --! Create a variable with a given name, type, and value
   function vc_varExprDef
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Ctype;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_varExprDef, "vc_varExprDef");

  --! Get the expression and type associated with a name.
  --!  If there is no such Expr, a NULL Expr is returned.  
   function vc_lookupVar
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address) return CVC_Expr;  
   pragma Import (C, vc_lookupVar, "vc_lookupVar");

  --! Get the type of the Expr.
   function vc_getType (arg1 : CVC_VC; arg2 : CVC_Expr) return CVC_Ctype;  
   pragma Import (C, vc_getType, "vc_getType");

  --! Get the largest supertype of the Expr.
   function vc_getBaseType (arg1 : CVC_VC; arg2 : CVC_Expr) return CVC_Ctype;  
   pragma Import (C, vc_getBaseType, "vc_getBaseType");

  --! Get the largest supertype of the Type.
   function vc_getBaseTypeOfType (arg1 : CVC_VC; arg2 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_getBaseTypeOfType, "vc_getBaseTypeOfType");

  --! Get the subtype predicate
   function vc_getTypePred
     (arg1 : CVC_VC;
      arg2 : CVC_Ctype;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_getTypePred, "vc_getTypePred");

  --! Create a string Expr
   function vc_stringExpr (arg1 : CVC_VC; arg2 : Interfaces.C.Strings.chars_ptr) return CVC_Expr;  
   pragma Import (C, vc_stringExpr, "vc_stringExpr");

  --! Create an ID Expr
   function vc_idExpr (arg1 : CVC_VC; arg2 : Interfaces.C.Strings.chars_ptr) return CVC_Expr;  
   pragma Import (C, vc_idExpr, "vc_idExpr");

  --! Create a list Expr
  --! Intermediate representation for DP-specific expressions.
  -- *  Normally, the first element of the list is a string Expr
  -- *  representing an operator, and the rest of the list are the
  -- *  arguments.  For example,
  -- *
  -- *  kids.push_back(vc->stringExpr("PLUS"));
  -- *  kids.push_back(x); // x and y are previously created Exprs
  -- *  kids.push_back(y);
  -- *  Expr lst = vc->listExpr(kids);
  -- *
  -- * Or, alternatively (using its overloaded version):
  -- *
  -- * Expr lst = vc->listExpr("PLUS", x, y);
  -- *
  -- * or
  -- *
  -- * vector<Expr> summands;
  -- * summands.push_back(x); summands.push_back(y); ...
  -- * Expr lst = vc->listExpr("PLUS", summands);
  --  

   function vc_listExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : System.Address) return CVC_Expr;  
   pragma Import (C, vc_listExpr, "vc_listExpr");

  -- Expr I/O
  --! Expr vc_parseExpr(CVC_VC vc, char* s);
   procedure vc_printExpr (arg1 : CVC_VC; arg2 : CVC_Expr);  
   pragma Import (C, vc_printExpr, "vc_printExpr");

  --! Print e into a char*
  --! Note that the ownership of the char* is given to the caller
  --  which should free the memory when it is done with it.  This
  --  can be done by calling vc_deleteString.  

   function vc_printExprString (arg1 : CVC_VC; arg2 : CVC_Expr) return Interfaces.C.Strings.chars_ptr;  
   pragma Import (C, vc_printExprString, "vc_printExprString");

  --! Delete char* returned by previous function
   procedure vc_deleteString (arg1 : Interfaces.C.Strings.chars_ptr);  
   pragma Import (C, vc_deleteString, "vc_deleteString");

  --! Print 'e' into an open file descriptor
   procedure vc_printExprFile
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Int ) ;  
   pragma Import (C, vc_printExprFile, "vc_printExprFile");

  --! Import the Expr from another instance of CVC_VC
  --! When expressions need to be passed among several instances of
  -- *  CVC_VC, they need to be explicitly imported into the
  -- *  corresponding instance using this method.  The return result is
  -- *  an identical expression that belongs to the current instance of
  -- *  CVC_VC, and can be safely used as part of more complex
  -- *  expressions from the same instance.
  -- \param vc is the instance to be imported into
  -- \param e is the expression created using a different (not vc) instance
  --  

   function vc_importExpr (arg1 : CVC_VC; arg2 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_importExpr, "vc_importExpr");

  --! Import the Type from another instance of CVC_VC
  --! \sa vc_importExpr()  
   function vc_importType (arg1 : CVC_Ctype) return CVC_Ctype;  
   pragma Import (C, vc_importType, "vc_importType");

  --! Create an equality expression.  The two children must have the same type.
   function vc_eqExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_eqExpr, "vc_eqExpr");

  --! Create an all distinct expression. All children must ahve the same type.
   function vc_distinctExpr
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_distinctExpr, "vc_distinctExpr");

  -- Boolean expressions
  -- The following functions create Boolean expressions.  The children provided
  -- as arguments must be of type Boolean.
   function vc_trueExpr (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_trueExpr, "vc_trueExpr");

   function vc_falseExpr (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_falseExpr, "vc_falseExpr");

   function vc_notExpr (arg1 : CVC_VC; arg2 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_notExpr, "vc_notExpr");

   function vc_andExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_andExpr, "vc_andExpr");

   function vc_andExprN
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_andExprN, "vc_andExprN");

   function vc_orExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_orExpr, "vc_orExpr");

   function vc_orExprN
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_orExprN, "vc_orExprN");

   function vc_impliesExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_impliesExpr, "vc_impliesExpr");

   function vc_iffExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_iffExpr, "vc_iffExpr");

   function vc_iteExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_iteExpr, "vc_iteExpr");

  -- Substitution
  -- Substitutes oldTerms for newTerms in e.
  -- This function doesn't actually exist in ValidityChecker interface,
  -- but it does in Expr, and its functionality is needed in the C interface.
  -- For consistency, it is represented here as if it were in ValidityChecker.
   function vc_substExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : System.Address;
      arg4 : Interfaces.C.Int ;
      arg5 : System.Address;
      arg6 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_substExpr, "vc_substExpr");

  -- User-defined (uninterpreted) functions.
  --! Create an operator from a function with a given name and type.
  --! Name is given as an ID Expr, and the type must be a function type.  
   function vc_createOp
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Ctype) return CVC_Op;  
   pragma Import (C, vc_createOp, "vc_createOp");

  --! Create a named user-defined function with a given type
   function vc_createOpDef
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Ctype;
      arg4 : CVC_Expr) return CVC_Op;  
   pragma Import (C, vc_createOpDef, "vc_createOpDef");

  --! Lookup an operator by name.
  --! Returns the operator and the type if the operator exists.
  -- * Returns NULL otherwise
  --  

   function vc_lookupOp
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : System.Address) return CVC_Op;  
   pragma Import (C, vc_lookupOp, "vc_lookupOp");

  --! Create expressions with a user-defined operator.
  --!  op must have a function type.  
   function vc_funExpr1
     (arg1 : CVC_VC;
      arg2 : CVC_Op;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_funExpr1, "vc_funExpr1");

   function vc_funExpr2
     (arg1 : CVC_VC;
      arg2 : CVC_Op;
      arg3 : CVC_Expr;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_funExpr2, "vc_funExpr2");

   function vc_funExpr3
     (arg1 : CVC_VC;
      arg2 : CVC_Op;
      arg3 : CVC_Expr;
      arg4 : CVC_Expr;
      arg5 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_funExpr3, "vc_funExpr3");

   function vc_funExprN
     (arg1 : CVC_VC;
      arg2 : CVC_Op;
      arg3 : System.Address;
      arg4 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_funExprN, "vc_funExprN");

  -- Arithmetic
  --! Create a rational number with numerator n and denominator d.
  --! d cannot be 0.  
   function vc_RatExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_RatExpr, "vc_ratExpr");

  --! Create a rational number n/d; n and d are given as strings
  --! n and d are converted to arbitrary-precision integers according to
  -- *  the given base.  d cannot be 0.   

   function vc_ratExprFromStr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_ratExprFromStr, "vc_ratExprFromStr");

  --! Create a rational from a single string.
  --!
  --  \param n can be a string containing an integer, a pair of integers
  --  "nnn/ddd", or a number in the fixed or floating point format.
  --  \param base is the base in which to interpret the string.
  -- 

   function vc_ratExprFromStr1
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_ratExprFromStr1, "vc_ratExprFromStr1");

  --! Unary minus.  Child must have a numeric type.
   function vc_uminusExpr (arg1 : CVC_VC; arg2 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_uminusExpr, "vc_uminusExpr");

  -- plus, minus, mult.  Children must have numeric types.
   function vc_plusExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_plusExpr, "vc_plusExpr");

   function vc_plusExprN
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_plusExprN, "vc_plusExprN");

   function vc_minusExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_minusExpr, "vc_minusExpr");

   function vc_multExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_multExpr, "vc_multExpr");

   function vc_powExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_powExpr, "vc_powExpr");

   function vc_divideExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_divideExpr, "vc_divideExpr");

  -- The following functions create less-than, less-than or equal,
  -- greater-than, and greater-than or equal expressions of type Boolean.
  -- Their arguments must be of numeric types.
   function vc_ltExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_ltExpr, "vc_ltExpr");

   function vc_leExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_leExpr, "vc_leExpr");

   function vc_gtExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_gtExpr, "vc_gtExpr");

   function vc_geExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_geExpr, "vc_geExpr");

  -- Records
  -- Create record literals;
   function vc_recordExpr1
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_recordExpr1, "vc_recordExpr1");

   function vc_recordExpr2
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Expr;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_recordExpr2, "vc_recordExpr2");

   function vc_recordExpr3
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Expr;
      arg4 : Interfaces.C.Strings.chars_ptr;
      arg5 : CVC_Expr;
      arg6 : Interfaces.C.Strings.chars_ptr;
      arg7 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_recordExpr3, "vc_recordExpr3");

   function vc_recordExprN
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : System.Address;
      arg4 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_recordExprN, "vc_recordExprN");

  --! Create an expression representing the selection of a field from a record.
   function vc_recSelectExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Strings.chars_ptr) return CVC_Expr;  
   pragma Import (C, vc_recSelectExpr, "vc_recSelectExpr");

  --! Record update; equivalent to "record WITH .field := newValue"
   function vc_recUpdateExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_recUpdateExpr, "vc_recUpdateExpr");

  -- Arrays
  --! Create an expression for the value of array at the given index
   function vc_readExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_readExpr, "vc_readExpr");

  --! Array update; equivalent to "array WITH [index] := newValue"
   function vc_writeExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_writeExpr, "vc_writeExpr");

  -- Bitvectors
  -- Additional type constructor
   function vc_bv32Type (arg1 : CVC_VC) return CVC_Ctype;  
   pragma Import (C, vc_bv32Type, "vc_bv32Type");

  -- Bitvector constants
   function vc_bvConstExprFromStr (arg1 : CVC_VC; arg2 : Interfaces.C.Strings.chars_ptr) return CVC_Expr;  
   pragma Import (C, vc_bvConstExprFromStr, "vc_bvConstExprFromStr");

   function vc_bvConstExprFromInt
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : Interfaces.C.Unsigned) return CVC_Expr;  
   pragma Import (C, vc_bvConstExprFromInt, "vc_bvConstExprFromInt");

   function vc_bv32ConstExprFromInt (arg1 : CVC_VC; arg2 : Interfaces.C.Unsigned) return CVC_Expr;  
   pragma Import (C, vc_bv32ConstExprFromInt, "vc_bv32ConstExprFromInt");

   function vc_bvConstExprFromLL
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : Interfaces.C.Unsigned_long) return CVC_Expr;  
   pragma Import (C, vc_bvConstExprFromLL, "vc_bvConstExprFromLL");

  -- Concat and extract
   function vc_bvConcatExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvConcatExpr, "vc_bvConcatExpr");

   function vc_bvConcatExprN
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_bvConcatExprN, "vc_bvConcatExprN");

   function vc_bvExtract
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Int ;
      arg4 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_bvExtract, "vc_bvExtract");

   function vc_bvBoolExtract
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_bvBoolExtract, "vc_bvBoolExtract");

  -- Bitwise Boolean operators: Negation, And, Or, Xor
   function vc_bvNotExpr (arg1 : CVC_VC; arg2 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvNotExpr, "vc_bvNotExpr");

   function vc_bvAndExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvAndExpr, "vc_bvAndExpr");

   function vc_bvOrExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvOrExpr, "vc_bvOrExpr");

   function vc_bvXorExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvXorExpr, "vc_bvXorExpr");

  -- Interfaces.C.Unsigned bitvector inequalities
   function vc_bvLtExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvLtExpr, "vc_bvLtExpr");

   function vc_bvLeExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvLeExpr, "vc_bvLeExpr");

   function vc_bvGtExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvGtExpr, "vc_bvGtExpr");

   function vc_bvGeExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvGeExpr, "vc_bvGeExpr");

  -- Signed bitvector inequalities
   function vc_bvSLtExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvSLtExpr, "vc_bvSLtExpr");

   function vc_bvSLeExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvSLeExpr, "vc_bvSLeExpr");

   function vc_bvSGtExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvSGtExpr, "vc_bvSGtExpr");

   function vc_bvSGeExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvSGeExpr, "vc_bvSGeExpr");

  -- Sign-extend child to a total of nbits bits
   function vc_bvSignExtend
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_bvSignExtend, "vc_bvSignExtend");

  -- Bitvector arithmetic: unary minus, plus, subtract, multiply
   function vc_bvUMinusExpr (arg1 : CVC_VC; arg2 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvUMinusExpr, "vc_bvUMinusExpr");

   function vc_bvPlusExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : CVC_Expr;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvPlusExpr, "vc_bvPlusExpr");

   function vc_bv32PlusExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bv32PlusExpr, "vc_bv32PlusExpr");

   function vc_bvMinusExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : CVC_Expr;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvMinusExpr, "vc_bvMinusExpr");

   function vc_bv32MinusExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bv32MinusExpr, "vc_bv32MinusExpr");

   function vc_bvMultExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : CVC_Expr;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvMultExpr, "vc_bvMultExpr");

   function vc_bv32MultExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bv32MultExpr, "vc_bv32MultExpr");

   function vc_bvUDivExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvUDivExpr, "vc_bvUDivExpr");

   function vc_bvURemExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvURemExpr, "vc_bvURemExpr");

   function vc_bvSDivExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvSDivExpr, "vc_bvSDivExpr");

   function vc_bvSRemExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvSRemExpr, "vc_bvSRemExpr");

   function vc_bvSModExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvSModExpr, "vc_bvSModExpr");

  -- Shift operators
   function vc_bvLeftShiftExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvLeftShiftExpr, "vc_bvLeftShiftExpr");

   function vc_bvRightShiftExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvRightShiftExpr, "vc_bvRightShiftExpr");

   function vc_bv32LeftShiftExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bv32LeftShiftExpr, "vc_bv32LeftShiftExpr");

   function vc_bv32RightShiftExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bv32RightShiftExpr, "vc_bv32RightShiftExpr");

   function vc_bvVar32LeftShiftExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvVar32LeftShiftExpr, "vc_bvVar32LeftShiftExpr");

   function vc_bvVar32RightShiftExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvVar32RightShiftExpr, "vc_bvVar32RightShiftExpr");

   function vc_bvVar32DivByPowOfTwoExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_bvVar32DivByPowOfTwoExpr, "vc_bvVar32DivByPowOfTwoExpr");

  --C pointer support:  C interface to support C memory arrays in CVC3  
   function vc_bvCreateMemoryArray (arg1 : CVC_VC; arg2 : Interfaces.C.Strings.chars_ptr) return CVC_Expr;  
   pragma Import (C, vc_bvCreateMemoryArray, "vc_bvCreateMemoryArray");

   function vc_bvReadMemoryArray
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr;
      arg4 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_bvReadMemoryArray, "vc_bvReadMemoryArray");

   function vc_bvWriteToMemoryArray
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : CVC_Expr;
      arg4 : CVC_Expr;
      arg5 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_bvWriteToMemoryArray, "vc_bvWriteToMemoryArray");

  -- Tuples
  --! Create a tuple expression
  --! 'children' is an array of elements of length numChildren  
   function vc_tupleExprN
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_tupleExprN, "vc_tupleExprN");

  --! Tuple select; equivalent to "tuple.n", where n is an numeral (e.g. tup.5)
   function vc_tupleSelectExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import (C, vc_tupleSelectExpr, "vc_tupleSelectExpr");

  --! Tuple update; equivalent to "tuple WITH index := newValue"
   function vc_tupleUpdateExpr
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Int ;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_tupleUpdateExpr, "vc_tupleUpdateExpr");

  -- Datatypes
  --! Datatype constructor expression
   function vc_datatypeConsExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Int ;
      arg4 : System.Address) return CVC_Expr;  
   pragma Import (C, vc_datatypeConsExpr, "vc_datatypeConsExpr");

  --! Datatype selector expression
   function vc_datatypeSelExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_datatypeSelExpr, "vc_datatypeSelExpr");

  --! Datatype tester expression
   function vc_datatypeTestExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_datatypeTestExpr, "vc_datatypeTestExpr");

  -- Quantifiers
  --! Create a bound variable.
  --! \param name
  -- * \param uid is a fresh unique string to distinguish this variable
  -- * from other bound variables with the same name
  -- * \param type
  --  

   function vc_boundVarExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : CVC_Ctype) return CVC_Expr;  
   pragma Import (C, vc_boundVarExpr, "vc_boundVarExpr");

  --! Create a FORALL quantifier.
  --! Bvars is an array of bound variables of length numBvars.  
   function vc_forallExpr
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : Interfaces.C.Int ;
      arg4 : CVC_Expr) return CVC_Ctype;  
   pragma Import (C, vc_forallExpr, "vc_forallExpr");

  --! Set triggers for a forallExpr
   procedure vc_setTriggers
     (arg1 : CVC_VC;
      arg2 : CVC_Expr;
      arg3 : Interfaces.C.Int ;
      arg4 : System.Address);  
   pragma Import (C, vc_setTriggers, "vc_setTriggers");

  --! Create an EXISTS quantifier.
  --! Bvars is an array of bound variables of length numBvars.  
   function vc_existsExpr
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : Interfaces.C.Int ;
      arg4 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_existsExpr, "vc_existsExpr");

  --! Lambda-expression
   function vc_lambdaExpr
     (arg1 : CVC_VC;
      arg2 : Interfaces.C.Int ;
      arg3 : System.Address;
      arg4 : CVC_Expr) return CVC_Op;  
   pragma Import (C, vc_lambdaExpr, "vc_lambdaExpr");

  --///////////////////////////////////////////////////////////////////////////
  -- Context-related methods                                                 //
  --///////////////////////////////////////////////////////////////////////////
  --! Set the resource limit (0==unlimited, 1==exhausted).
  --! Currently, the limit is the total number of processed facts.  
   procedure vc_setResourceLimit (arg1 : CVC_VC; arg2 : Interfaces.C.Unsigned);  
   pragma Import (C, vc_setResourceLimit, "vc_setResourceLimit");

  --! Assert a new formula in the current context.
  --! The formula must have Boolean type.  
   procedure vc_assertFormula (arg1 : CVC_VC; arg2 : CVC_Expr);  
   pragma Import (C, vc_assertFormula, "vc_assertFormula");

  --! Register an atomic formula of interest.
  --! Registered atoms are tracked by the decision procedures.  If one of them
  --    is deduced to be true or false, it is added to a list of implied literals.
  --    Implied literals can be retrieved with the getImpliedLiteral function  

   procedure vc_registerAtom (arg1 : CVC_VC; arg2 : CVC_Expr);  
   pragma Import (C, vc_registerAtom, "vc_registerAtom");

  --! Return next literal implied by last assertion.  Null if none.
  --! Returned literals are either registered atomic formulas or their negation
  --  

   function vc_getImpliedLiteral (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_getImpliedLiteral, "vc_getImpliedLiteral");

  --! Simplify e with respect to the current context
   function vc_simplify (arg1 : CVC_VC; arg2 : CVC_Expr) return CVC_Expr;  
   pragma Import (C, vc_simplify, "vc_simplify");

  --! Check validity of e in the current context.
  --! Possible results are: 0 = invalid, 1 = valid, 2 = abort, 3 = unknown,
  -- * -100 = exception (type error, internal error, etc).
  -- * If the result is 1, then the resulting context is the same as
  -- * the starting context.  If the result is 0 or 3, then the resulting
  -- * context is a context in which e is false (though the context may be
  -- * inconsistent in the case of an unknown result).  e must have Boolean
  -- * type.  In the case of a result of -100, refer to vc_get_error_string()
  -- * to see what went wrong.  

   function vc_query (arg1 : CVC_VC; arg2 : CVC_Expr) return Interfaces.C.Int ;  
   pragma Import (C, vc_query, "vc_query");

  --! Get the next model
  --! This method should only be called after a query which returns
  --  0.  Its return values are as for vc_query().  

   function vc_checkContinue (arg1 : CVC_VC) return Interfaces.C.Int ;  
   pragma Import (C, vc_checkContinue, "vc_checkContinue");

  --! Restart the most recent query with e as an additional assertion.
  --! This method should only be called after a query which returns
  --  0.  Its return values are as for vc_query().  

   function vc_restart (arg1 : CVC_VC; arg2 : CVC_Expr) return Interfaces.C.Int ;  
   pragma Import (C, vc_restart, "vc_restart");

  --! Returns to context immediately before last invalid query.
  --! This method should only be called after a query which returns 0.
  --  

   procedure vc_returnFromCheck (arg1 : CVC_VC);  
   pragma Import (C, vc_returnFromCheck, "vc_returnFromCheck");

  --! Get assumptions made by the user in this and all previous contexts.
  --! User assumptions are created either by calls to assertFormula or by a
  -- * call to query.  In the latter case, the negated query is added as an
  -- * assumption.  The caller is responsible for freeing the array when
  -- * finished with it.
  --  

   function vc_getUserAssumptions (arg1 : CVC_VC; arg2 : access Interfaces.C.Int ) return System.Address;  
   pragma Import (C, vc_getUserAssumptions, "vc_getUserAssumptions");

  --! Get assumptions made internally in this and all previous contexts.
  --! Internal assumptions are literals assumed by the sat solver.
  -- * The caller is responsible for freeing the array when finished with it by
  -- * calling vc_deleteVector.
  --  

   function vc_getInternalAssumptions (arg1 : CVC_VC; arg2 : access Interfaces.C.Int ) return System.Address;  
   pragma Import (C, vc_getInternalAssumptions, "vc_getInternalAssumptions");

  --! Get all assumptions made in this and all previous contexts.
  --!
  -- * The caller is responsible for freeing the array when finished with it by
  -- * calling vc_deleteVector.
  --  

   function vc_getAssumptions (arg1 : CVC_VC; arg2 : access Interfaces.C.Int ) return System.Address;  
   pragma Import (C, vc_getAssumptions, "vc_getAssumptions");

  --yeting, for proof translation, get the assumptions used.
  --the assumptions used are different from the user assumptions.
  --the assumptions used are preprocessed if 'preprocess' is ena
   function vc_getProofAssumptions (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_getProofAssumptions, "vc_getProofAssumptions");

  --yeting, for proof translation,
   function vc_getProofQuery (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_getProofQuery, "vc_getProofQuery");

  --! Returns the set of assumptions used in the proof of queried formula.
  --! It returns a subset of getAssumptions().  If the last query was false
  -- *  or there has not yet been a query, it does nothing.
  -- * The caller is responsible for freeing the array when finished with it by
  -- * calling vc_deleteVector.
  --  

   function vc_getAssumptionsUsed (arg1 : CVC_VC; arg2 : access Interfaces.C.Int ) return System.Address;  
   pragma Import (C, vc_getAssumptionsUsed, "vc_getAssumptionsUsed");

  --! Return the counterexample after a failed query.
  --! This method should only be called after a query which returns
  -- * false.  It will try to return the simplest possible set of
  -- * assertions which are sufficient to make the queried expression
  -- * false.  The caller is responsible for freeing the array when finished with
  -- * it by calling vc_deleteVector.
  --  

   function vc_getCounterExample (arg1 : CVC_VC; arg2 : access Interfaces.C.Int ) return System.Address;  
   pragma Import (C, vc_getCounterExample, "vc_getCounterExample");

  --! Will assign concrete values to all user created variables
  --! This function should only be called after a query which return false.
  -- * Returns an array of Exprs with size *size.
  -- * The caller is responsible for freeing the array when finished with it by
  -- * calling vc_deleteVector.
  --  

   function vc_getConcreteModel (arg1 : CVC_VC; arg2 : access Interfaces.C.Int ) return System.Address;  
   pragma Import (C, vc_getConcreteModel, "vc_getConcreteModel");

  -- Returns true if the current context is inconsistent.
  --! Also returns a minimal set of assertions used to determine the
  -- * inconsistency. The caller is responsible for freeing the array when finished
  -- * with it by calling vc_deleteVector.
  --  

   function vc_inconsistent
     (arg1 : CVC_VC;
      arg2 : System.Address;
      arg3 : access Interfaces.C.Int ) return Interfaces.C.Int ;  
   pragma Import (C, vc_inconsistent, "vc_inconsistent");

  --! Returns non-NULL if the invalid result from last query() is imprecise
  --!
  -- * The return value is filled with the reasons for incompleteness (it
  -- * is intended to be shown to the end user).  The caller is responsible for
  -- * freeing the string returned by calling vc_deleteString.
  --  

   function vc_incomplete (arg1 : CVC_VC) return Interfaces.C.Strings.chars_ptr;  
   pragma Import (C, vc_incomplete, "vc_incomplete");

  --! Returns the proof for the last proven query
   function vc_getProof (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_getProof, "vc_getProof");

  --! Returns the proof of a .cvc file, if it is valid.
   function vc_getProofOfFile (arg1 : CVC_VC; arg2 : Interfaces.C.Strings.chars_ptr) return CVC_Expr;  
   pragma Import (C, vc_getProofOfFile, "vc_getProofOfFile");

  --! Returns the TCC of the last assumption or query
  --! Returns Null Expr if no assumptions or queries were performed.  
   function vc_getTCC (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_getTCC, "vc_getTCC");

  --! Return the set of assumptions used in the proof of the last TCC
  --! The caller is responsible for freeing the array when finished with it by
  -- * calling vc_deleteVector.
  --  

   function vc_getAssumptionsTCC (arg1 : CVC_VC; arg2 : access Interfaces.C.Int ) return System.Address;  
   pragma Import (C, vc_getAssumptionsTCC, "vc_getAssumptionsTCC");

  --! Returns the proof of TCC of the last assumption or query
  --! Returns Null Expr if no assumptions or queries were performed.  
   function vc_getProofTCC (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_getProofTCC, "vc_getProofTCC");

  --! After successful query, return its closure |- Gamma => phi
  --! Turn a valid query Gamma |- phi into an implication
  -- * |- Gamma => phi.
  -- *
  -- * Returns Null Expr if last query was invalid.
  --  

   function vc_getClosure (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_getClosure, "vc_getClosure");

  --! Construct a proof of the query closure |- Gamma => phi
  --! Returns Null if last query was Invalid.  
   function vc_getProofClosure (arg1 : CVC_VC) return CVC_Expr;  
   pragma Import (C, vc_getProofClosure, "vc_getProofClosure");

  --! Returns the current stack level.  Initial level is 0.
   function vc_stackLevel (arg1 : CVC_VC) return Interfaces.C.Int ;  
   pragma Import (C, vc_stackLevel, "vc_stackLevel");

  --! Checkpoint the current context and increase the scope level
   procedure vc_push (arg1 : CVC_VC);  
   pragma Import (C, vc_push, "vc_push");

  --! Restore the current context to its state at the last checkpoint
   procedure vc_pop (arg1 : CVC_VC);  
   pragma Import (C, vc_pop, "vc_pop");

  --! Restore the current context to the given stackLevel.
  --! stackLevel must be less than or equal to the current stack level.
  --  

   procedure vc_popto (arg1 : CVC_VC; arg2 : Interfaces.C.Int );  
   pragma Import (C, vc_popto, "vc_popto");

   --! Get the current context
   function vc_getCurrentContext (arg1 : CVC_VC) return CVC_Context ;  
   pragma Import (C, vc_getCurrentContext, "vc_getCurrentContext");

  -- ----------------------------------------------------------------------  
  --  Util                                                                   
  -- ----------------------------------------------------------------------  
  -- Order
  --! Compares two expressions
  --! If e1 < e2, e1==e2, and e1 > e2, it returns -1, 0, 1
  -- * respectively.  A return value of -100 signals an error (refer to
  -- * vc_get_error_string() for details).
  -- *
  -- * Can't be 'compare' because already defined in ocaml  

   function vc_compare_exprs (arg1 : CVC_Expr; arg2 : CVC_Expr) return Interfaces.C.Int ;  
   pragma Import (C, vc_compare_exprs, "vc_compare_exprs");

  -- Printing
  --! Convert Expr to string
   function vc_exprString (arg1 : CVC_Expr) return Interfaces.C.Strings.chars_ptr;  
   pragma Import (C, vc_exprString, "vc_exprString");

  --! Convert Type to string
   function vCVC_CtypeString (arg1 : CVC_Ctype) return Interfaces.C.Strings.chars_ptr;  
   pragma Import (C, vCVC_CtypeString, "vCVC_CtypeString");

  -- What kind of Expr?
   function Vc_IsClosure (arg1 : CVC_Expr) return Interfaces.C.Int ;  
   pragma Import (C, Vc_IsClosure , "vc_isClosure");

   function Vc_IsQuantifier(arg1 : CVC_Expr) return Interfaces.C.Int ;  
   pragma Import (C,Vc_IsQuantifier,"vc_isQuantifier");

   function Vc_IsLambda(arg1 : CVC_Expr) return Interfaces.C.Int ;  
   pragma Import (C,Vc_IsLambda,"vc_isLambda");

   function Vc_IsVar(Arg1 : CVC_Expr ) return CVC_Expr;  
   pragma Import(C,Vc_IsVar,"vc_isVar");

   function Vc_Arity( Arg1 : CVC_Expr ) return Interfaces.C.Int ;  
   pragma Import(C,Vc_Arity,"vc_arity");

   function Vc_GetKind( Arg1 : CVC_Expr ) return Interfaces.C.Int ;  
   pragma Import(C,Vc_GetKind,"vc_getKind");

   function Vc_GetChild( Arg1 : CVC_Expr ; Arg2 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import(C,Vc_GetChild,"vc_getChild");

   function Vc_GetNumVars( Arg1 : CVC_Expr ) return Interfaces.C.Int ;  
   pragma Import(C,Vc_GetNumVars,"vc_getNumVars");

   function Vc_GetVar( Arg1 : CVC_Expr ; Arg2 : Interfaces.C.Int ) return CVC_Expr;  
   pragma Import(C,Vc_GetVar,"vc_getVar");

   function Vc_GetBody( Arg1 : CVC_Expr ) return CVC_Expr;  
   pragma Import(C,Vc_GetBody,"vc_getBody");

   function Vc_GetExistential( Arg1 : CVC_Expr ) return CVC_Expr ;  
   pragma Import(C,Vc_GetExistential,"vc_getExistential");

   function Vc_GetFun( Arg1 : CVC_VC ; Arg2 : CVC_Expr ) return CVC_Expr;  
   pragma Import(C,vc_getFun,"vc_getFun");

   function Vc_ToExpr( Arg1 : CVC_Ctype ) return CVC_Expr;  
   pragma Import(C,Vc_ToExpr,"vc_toExpr");

   -- Translate a kind int to a string
   function Vc_GetKindString( Arg1 : CVC_VC ; Arg2 : Interfaces.C.Int ) return Interfaces.C.Strings.Chars_Ptr ;  
   pragma Import(C,Vc_GetKindString,"vc_getKindString") ;

   -- Translate a kind string to an int
   function vc_getKindInt( Arg1 : CVC_VC ; Arg2 : Interfaces.C.Strings.Chars_Ptr ) return Interfaces.C.Int ;  
   pragma Import(C,Vc_GetKindInt,"vc_getKindInt") ;

   -- Return an int from a rational expression
   function Vc_getInt( Arg1 : CVC_Expr ) return Interfaces.C.Int ;  
   pragma Import(C,Vc_GetInt,"vc_getInt");

   -- Return an int from a constant bitvector expression
   function Vc_GetBVInt( Arg1 : CVC_VC ; Arg2 : CVC_Expr ) return Interfaces.C.Int ;  
   pragma Import(C,Vc_GetBVInt,"vc_getBVInt");

   -- Return an Interfaces.C.Unsigned int from a constant bitvector expression
   function Vc_GetBVUnsigned( Arg1 : CVC_VC ; Arg2 : CVC_Expr ) return Interfaces.C.Unsigned;  
   pragma Import(C,Vc_GetBVUnsigned,"vc_getBVUnsigned");

   -- Debug
   function vc_get_error_status return Interfaces.C.Int ;  
   pragma Import(C,Vc_Get_Error_Status,"vc_get_error_status");

   procedure Vc_Reset_Error_Status ;  
   pragma Import (C,Vc_Reset_Error_Status,"vc_reset_error_status");

   function Vc_Get_Error_String return Interfaces.C.Strings.Chars_Ptr ;  
   pragma Import (C,Vc_Get_Error_String,"vc_get_error_string");

  -- Print statistics
   procedure Vc_Print_Statistics( Arg1 : CVC_VC ) ;  
   pragma Import(C,Vc_Print_Statistics,"vc_print_statistics") ;

end CVC3 ;
