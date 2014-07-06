with Interfaces.C; use Interfaces.C;
with sys_utypes_uint32_t_h;
with utypes_uuint32_t_h;
with sys_utypes_uint64_t_h;

package yices_types_h is


   NULL_TERM : constant Integer := -1 ;
   NULL_TYPE : constant Integer := -1 ;  --  /Users/dpereira/Provers/yices2/include/yices_types.h:29

  -- * PUBLIC TYPES
  -- * 
  -- * All types that are part of the API must be defined here.
  --  

  --********************
  -- *  TERMS AND TYPES  *
  -- ******************* 

  -- * Exported types
  -- * - term = index in a term table
  -- * - type = index in a type table
  --  

   subtype term_t is Interfaces.C.Int ; --sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:22

   subtype type_t is Interfaces.C.Int ; --sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:23

  -- * Error values
  --  

  --***********************
  -- *  CONTEXT AND MODELS  *
  -- ********************** 

  -- * Context and models (opaque types)
  --  

   --  skipped empty struct context_s

   --  skipped empty struct context_t

   --  skipped empty struct model_s

   --  skipped empty struct model_t

  -- * Context configuration (opaque type)
  --  

   --  skipped empty struct ctx_config_s

   --  skipped empty struct ctx_config_t

  -- * Search parameters (opaque type)
  --  

   --  skipped empty struct param_s

   --  skipped empty struct param_t

  -- * Context status code
  --  

   type Smt_Status is 
     ( STATUS_IDLE,
       STATUS_SEARCHING,
       STATUS_UNKNOWN,
       STATUS_SAT,
       STATUS_UNSAT,
       STATUS_INTERRUPTED,
       STATUS_ERROR ) ;
   
   pragma Convention(C,Smt_Status) ; 

   subtype Smt_Status_T is Smt_Status ;

  --****************
  -- *  ERROR CODES  * 
  -- *************** 

  -- * Error report for term and type construction
  -- * - when term or type constructor fails, it returns NULL_TYPE or NULL_TERM.
  -- * - details about the cause of the failure are stored in an error_record
  -- * - the error record contains an error code: see below
  -- *    + extra information that depends on the error code. 
  --  
   
   type Error_Code is
     ( NO_ERROR,
       INVALID_TYPE,
       INVALID_TERM,
       INVALID_CONSTANT_INDEX,
       INVALID_VAR_INDEX,
       INVALID_TUPLE_INDEX,
       INVALID_RATIONAL_FORMAT,
       INVALID_FLOAT_FORMAT,
       INVALID_BVBIN_FORMAT,
       INVALID_BVHEX_FORMAT,
       INVALID_BITSHIFT,
       INVALID_BVEXTRACT,
       TOO_MANY_ARGUMENTS,
       TOO_MANY_VARS,
       MAX_BVSIZE_EXCEEDED,
       DEGREE_OVERFLOW,
       DIVISION_BY_ZERO,
       POS_INT_REQUIRED,
       NONNEG_INT_REQUIRED,
       SCALAR_OR_UTYPE_REQUIRED,
       FUNCTION_REQUIRED,
       TUPLE_REQUIRED,
       VARIABLE_REQUIRED,
       ARITHTERM_REQUIRED,
       BITVECTOR_REQUIRED,
       SCALAR_TERM_REQUIRED,
       WRONG_NUMBER_OF_ARGUMENTS,
       TYPE_MISMATCH,
       INCOMPATIBLE_TYPES,
       DUPLICATE_VARIABLE,
       INCOMPATIBLE_BVSIZES,
       EMPTY_BITVECTOR,
       INVALID_TOKEN,
       SYNTAX_ERROR,
       UNDEFINED_TYPE_NAME,
       UNDEFINED_TERM_NAME,
       REDEFINED_TYPE_NAME,
       REDEFINED_TERM_NAME,
       DUPLICATE_NAME_IN_SCALAR,
       DUPLICATE_VAR_NAME,
       INTEGER_OVERFLOW,
       INTEGER_REQUIRED,
       RATIONAL_REQUIRED,
       SYMBOL_REQUIRED,
       TYPE_REQUIRED,
       NON_CONSTANT_DIVISOR,
       NEGATIVE_BVSIZE,
       INVALID_BVCONSTANT,
       TYPE_MISMATCH_IN_DEF,
       ARITH_ERROR,
       BVARITH_ERROR,
       CTX_FREE_VAR_IN_FORMULA,
       CTX_LOGIC_NOT_SUPPORTED,
       CTX_UF_NOT_SUPPORTED,
       CTX_ARITH_NOT_SUPPORTED,
       CTX_BV_NOT_SUPPORTED,
       CTX_ARRAYS_NOT_SUPPORTED,
       CTX_QUANTIFIERS_NOT_SUPPORTED,
       CTX_LAMBDAS_NOT_SUPPORTED,
       CTX_NONLINEAR_ARITH_NOT_SUPPORTED,
       CTX_FORMULA_NOT_IDL,
       CTX_FORMULA_NOT_RDL,
       CTX_TOO_MANY_ARITH_VARS,
       CTX_TOO_MANY_ARITH_ATOMS,
       CTX_TOO_MANY_BV_VARS,
       CTX_TOO_MANY_BV_ATOMS,
       CTX_ARITH_SOLVER_EXCEPTION,
       CTX_BV_SOLVER_EXCEPTION,
       CTX_ARRAY_SOLVER_EXCEPTION,
       CTX_INVALID_OPERATION,
       CTX_OPERATION_NOT_SUPPORTED,
       CTX_INVALID_CONFIG,
       CTX_UNKNOWN_PARAMETER,
       CTX_INVALID_PARAMETER_VALUE,
       CTX_UNKNOWN_LOGIC,
       EVAL_UNKNOWN_TERM,
       EVAL_FREEVAR_IN_TERM,
       EVAL_QUANTIFIER,
       EVAL_LAMBDA,
       EVAL_OVERFLOW,
       EVAL_FAILED,
       OUTPUT_ERROR,
       INTERNAL_EXCEPTION ) ;
   
   for Error_Code use  
      ( NO_ERROR => 0, 
	INVALID_TYPE => 1,
	INVALID_TERM => 2,
	INVALID_CONSTANT_INDEX => 3,
	INVALID_VAR_INDEX => 4,
	INVALID_TUPLE_INDEX => 5,
	INVALID_RATIONAL_FORMAT => 6,
	INVALID_FLOAT_FORMAT => 7,
	INVALID_BVBIN_FORMAT => 8,
	INVALID_BVHEX_FORMAT => 9,
	INVALID_BITSHIFT => 10,
	INVALID_BVEXTRACT =>11,
	TOO_MANY_ARGUMENTS => 12,
	TOO_MANY_VARS => 13,
	MAX_BVSIZE_EXCEEDED => 14,
	DEGREE_OVERFLOW => 15,
	DIVISION_BY_ZERO => 16,
	POS_INT_REQUIRED => 17,
	NONNEG_INT_REQUIRED => 18,
	SCALAR_OR_UTYPE_REQUIRED => 19,
	FUNCTION_REQUIRED => 20,
	TUPLE_REQUIRED => 21,
	VARIABLE_REQUIRED => 22,
	ARITHTERM_REQUIRED => 23,
	BITVECTOR_REQUIRED => 24,
	SCALAR_TERM_REQUIRED => 25,
	WRONG_NUMBER_OF_ARGUMENTS => 26,
	TYPE_MISMATCH => 27,
	INCOMPATIBLE_TYPES => 28,
	DUPLICATE_VARIABLE => 29,
	INCOMPATIBLE_BVSIZES => 30,
	EMPTY_BITVECTOR => 31,
	INVALID_TOKEN => 100,
	SYNTAX_ERROR => 101,
	UNDEFINED_TYPE_NAME => 102,
	UNDEFINED_TERM_NAME => 103,
	REDEFINED_TYPE_NAME => 104,
	REDEFINED_TERM_NAME => 105,
	DUPLICATE_NAME_IN_SCALAR => 106,
	DUPLICATE_VAR_NAME => 107,
	INTEGER_OVERFLOW => 108,
	INTEGER_REQUIRED => 109,
	RATIONAL_REQUIRED => 110,
	SYMBOL_REQUIRED => 111,
	TYPE_REQUIRED => 112,
	NON_CONSTANT_DIVISOR => 113,
	NEGATIVE_BVSIZE => 114,
	INVALID_BVCONSTANT => 115,
	TYPE_MISMATCH_IN_DEF => 116,
	ARITH_ERROR => 117,
	BVARITH_ERROR => 118,
	CTX_FREE_VAR_IN_FORMULA => 300,
	CTX_LOGIC_NOT_SUPPORTED => 301,
	CTX_UF_NOT_SUPPORTED => 302,
	CTX_ARITH_NOT_SUPPORTED => 303,
	CTX_BV_NOT_SUPPORTED => 304,
	CTX_ARRAYS_NOT_SUPPORTED => 305,
	CTX_QUANTIFIERS_NOT_SUPPORTED => 306,
	CTX_LAMBDAS_NOT_SUPPORTED => 307,
	CTX_NONLINEAR_ARITH_NOT_SUPPORTED => 308,
	CTX_FORMULA_NOT_IDL => 309,
	CTX_FORMULA_NOT_RDL => 310,
	CTX_TOO_MANY_ARITH_VARS => 311,
	CTX_TOO_MANY_ARITH_ATOMS => 312,
	CTX_TOO_MANY_BV_VARS => 313,
	CTX_TOO_MANY_BV_ATOMS => 314,
	CTX_ARITH_SOLVER_EXCEPTION => 315,
	CTX_BV_SOLVER_EXCEPTION => 316,
	CTX_ARRAY_SOLVER_EXCEPTION => 317,
	CTX_INVALID_OPERATION => 400,
	CTX_OPERATION_NOT_SUPPORTED => 401,
	CTX_INVALID_CONFIG => 402,
	CTX_UNKNOWN_PARAMETER => 403,
	CTX_INVALID_PARAMETER_VALUE => 404,
	CTX_UNKNOWN_LOGIC => 405,
	EVAL_UNKNOWN_TERM => 406,
	EVAL_FREEVAR_IN_TERM => 407,
	EVAL_QUANTIFIER => 408,
	EVAL_LAMBDA => 409,
	EVAL_OVERFLOW => 410,
	EVAL_FAILED => 411,
	OUTPUT_ERROR => 500,
	INTERNAL_EXCEPTION => 9999) ;  
   
   pragma Convention(C,Error_Code) ; 
	--   * Errors in type or term construc=> tio,
  --    

  -- Not used anymore??
  --   * Parser errors
  --    

  --   * Errors in assertion processing.
  --   * These codes mean that the context, as configured,
  --   * cannot process the assertions.
  --    

  --   * Error codes for other operations
  --    

  --   * Errors in context configurations and search parameter settings
  --    

  --   * Error codes for model queries
  --    

  --   * Input/output and system errors
  --    

  --   * Catch-all code for anything else.
  --   * This is a symptom that a bug has been found.
  --    

   subtype Error_Code_T is Error_Code ;

  -- * Error report = a code + line and column + 1 or 2 terms + 1 or 2 types
  -- * + an (erroneous) integer value.
  -- *
  -- * The yices API returns a negative number and set an error code on
  -- * error. The fields other than the error code depend on the code.  In
  -- * addition, the parsing functions (yices_parse_type and
  -- * yices_parse_term) set the line/column fields on error.
  -- *
  -- *  error code                 meaningful fields
  -- *
  -- *  NO_ERROR                   none
  -- *
  -- *  INVALID_TYPE               type1
  -- *  INVALID_TERM               term1
  -- *  INVALID_CONSTANT_INDEX     type1, badval
  -- *  INVALID_VAR_INDEX          badval
  -- *  INVALID_TUPLE_INDEX        type1, badval
  -- *  INVALID_RATIONAL_FORMAT    none
  -- *  INVALID_FLOAT_FORMAT       none
  -- *  INVALID_BVBIN_FORMAT       none
  -- *  INVALID_BVHEX_FORMAT       none
  -- *  INVALID_BITSHIFT           badval
  -- *  INVALID_BVEXTRACT          none
  -- *  TOO_MANY_ARGUMENTS         badval
  -- *  TOO_MANY_VARS              badval
  -- *  MAX_BVSIZE_EXCEEDED        badval
  -- *  DEGREE_OVERFLOW            badval
  -- *  DIVISION_BY_ZERO           none
  -- *  POS_INT_REQUIRED           badval
  -- *  NONNEG_INT_REQUIRED        none
  -- *  SCALAR_OR_UTYPE_REQUIRED   type1
  -- *  FUNCTION_REQUIRED          term1
  -- *  TUPLE_REQUIRED             term1
  -- *  VARIABLE_REQUIRED          term1
  -- *  ARITHTERM_REQUIRED         term1
  -- *  BITVECTOR_REQUIRED         term1
  -- *  SCALAR_TERM_REQUIRED       term1
  -- *  WRONG_NUMBER_OF_ARGUMENTS  type1, badval
  -- *  TYPE_MISMATCH              term1, type1
  -- *  INCOMPATIBLE_TYPES         term1, type1, term2, type2
  -- *  DUPLICATE_VARIABLE         term1
  -- *  INCOMPATIBLE_BVSIZES       term1, type1, term2, type2
  -- *  EMPTY_BITVECTOR            none
  -- *
  -- * The following error codes are used only by the parsing functions. 
  -- * No field other than line/column is set.
  -- * 
  -- *  INVALID_TOKEN
  -- *  SYNTAX_ERROR
  -- *  UNDEFINED_TERM_NAME
  -- *  UNDEFINED_TYPE_NAME
  -- *  REDEFINED_TERM_NAME
  -- *  REDEFINED_TYPE_NAME
  -- *  DUPLICATE_NAME_IN_SCALAR
  -- *  DUPLICATE_VAR_NAME
  -- *  INTEGER_OVERFLOW
  -- *  INTEGER_REQUIRED
  -- *  RATIONAL_REQUIRED
  -- *  SYMBOL_REQUIRED
  -- *  TYPE_REQUIRED
  -- *  NON_CONSTANT_DIVISOR
  -- *  NEGATIVE_BVSIZE
  -- *  INVALID_BVCONSTANT
  -- *  TYPE_MISMATCH_IN_DEF
  -- *  ARITH_ERROR
  -- *  BVARITH_ERROR
  -- *
  -- * The following error codes are triggered by invalid operations
  -- * on a context. For these errors, no fields of error_report (other 
  -- * than the code) is meaningful.
  -- *
  -- *  CTX_FREE_VAR_IN_FORMULA
  -- *  CTX_LOGIC_NOT_SUPPORTED
  -- *  CTX_UF_NOT_SUPPORTED
  -- *  CTX_ARITH_NOT_SUPPORTED
  -- *  CTX_BV_NOT_SUPPORTED
  -- *  CTX_ARRAYS_NOT_SUPPORTED
  -- *  CTX_QUANTIFIERS_NOT_SUPPORTED
  -- *  CTX_LAMBDAS_NOT_SUPPORTED
  -- *  CTX_NONLINEAR_ARITH_NOT_SUPPORTED
  -- *  CTX_FORMULA_NOT_IDL
  -- *  CTX_FORMULA_NOT_RDL
  -- *  CTX_TOO_MANY_ARITH_VARS
  -- *  CTX_TOO_MANY_ARITH_ATOMS
  -- *  CTX_TOO_MANY_BV_VARS
  -- *  CTX_TOO_MANY_BV_ATOMS
  -- *  CTX_ARITH_SOLVER_EXCEPTION
  -- *  CTX_BV_SOLVER_EXCEPTION
  -- *  CTX_ARRAY_SOLVER_EXCEPTION
  -- *
  -- *  CTX_INVALID_OPERATION
  -- *  CTX_OPERATION_NOT_SUPPORTED
  -- *
  -- *  CTX_INVALID_CONFIG,
  -- *  CTX_UNKNOWN_PARAMETER,
  -- *  CTX_INVALID_PARAMETER_VALUE,
  -- *  CTX_UNKNOWN_LOGIC,
  -- *
  -- *  EVAL_UNKNOWN_TERM
  -- *  EVAL_FREEVAR_IN_TERM
  -- *  EVAL_QUANTIFIER
  -- *  EVAL_LAMBDA
  -- *  EVAL_OVERFLOW
  -- *  EVAL_FAILED
  -- *
  -- *
  -- * Other error codes. No field is meaningful in the error_report, 
  -- * except the error code:
  -- *
  -- *  OUTPUT_ERROR
  -- *  INTERNAL_EXCEPTION
  --  

   type Error_Report_S is record
      Code   : aliased Error_Code_T ;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:323
      Line   : aliased Interfaces.C.Unsigned ;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:324
      Column : aliased Interfaces.C.Unsigned ;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:325
      Term1  : aliased Term_T ;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:326
      Type1  : aliased Type_T ;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:327
      Term2  : aliased Term_T ;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:328
      Type2  : aliased Type_T ;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:329
      Badval : aliased Interfaces.C.Long ;  -- /Users/dpereira/Provers/yices2/include/yices_types.h:330
   end record;
   pragma Convention (C_Pass_By_Copy,Error_Report_S);  -- /Users/dpereira/Provers/yices2/include/yices_types.h:322

   subtype Error_Report_T is Error_Report_S ;

end yices_types_h;
