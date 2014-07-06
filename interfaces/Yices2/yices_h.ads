with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with yices_types_h;
limited with stdio_h;
with sys_utypes_uint32_t_h;
with utypes_uuint32_t_h;
with sys_utypes_uint64_t_h;
with utypes_uuint64_t_h;
with System;

package yices_h is

  -- * YICES API
  --  

  -- * On windows/cygwin/mingw:
  -- *
  -- *   __YICES_DLLSPEC__ is '__declspec(dllimport) by default
  -- * 
  -- * This can be overridden as follows:
  -- *
  -- * 1) give -DNOYICES_DLL as a compilation flag (if you want to
  -- *    link with libyices.a rather than the DLL)
  -- *
  -- * 2) define __YICES_DLLSPEC__ to '__declspec(dllexport)' before
  -- *      #include "yices.h"
  -- *    when building yices.
  -- *
  -- * On any system other than Windows: __YICES_DLLSPEC__ is empty.
  --  

  -- * WARNING: yices requires the header file <stdint.h>
  -- *
  -- * It's not available in Microsoft Visual Studio (prior to Visual Studio 2010),
  -- * and it's possibly missing from other compilers too.
  -- *
  -- * If necessary, there are open-source 'stdint.h' that can 
  -- * be downloaded at
  -- *      http://code.google.com/p/msinttypes/   (for MS Visual Studio only)
  -- *   or http://www.azillionmonkeys.com/qed/pstdint.h
  --  

  --********************
  -- *  VERSION NUMBERS  *
  -- ******************* 

  -- * The version as a string "x.y.z"
  --  

   Yices_Version : Interfaces.C.Strings.Chars_Ptr ;
   pragma Import(C,Yices_Version,"yices_version");

  -- * More details about the release:
  -- * - build_arch is a string like "x86_64-unknown-linux-gnu"
  -- * - build_mode is "release" or "debug"
  -- * - build_date is the compilation date as in "Wed Jun 16 11:11:57 PDT 2010"
  --  

   Yices_Build_Arch : Interfaces.C.Strings.Chars_Ptr ;  -- /Users/dpereira/Provers/yices2/include/yices.h:84
   pragma Import(C,Yices_Build_Arch,"yices_build_arch");

   Yices_Build_Mode : Interfaces.C.Strings.Chars_Ptr ;  -- /Users/dpereira/Provers/yices2/include/yices.h:85
   pragma Import(C,Yices_Build_Mode,"yices_build_mode");

   Yices_Build_Date : Interfaces.C.Strings.Chars_Ptr ;  -- /Users/dpereira/Provers/yices2/include/yices.h:86
   pragma Import(C,Yices_Build_Date,"yices_build_date");

  --**************************************
  -- *  GLOBAL INITIALIZATION AND CLEANUP  *
  -- ************************************* 

  -- * This function must be called before anything else to initialize
  -- * internal data structures.
  --  

   procedure Yices_Init ;
   pragma Import(C,Yices_Init,"yices_init") ;

  -- * Delete all internal data structures and objects
  -- * - this must be called to avoid memory leaks
  --  

   procedure Yices_Exit ;
   pragma Import(C,Yices_Exit,"yices_exit") ;
   
   -- Full reset
   -- * delete all terms and types and reset the symbol tables
   -- * delete all contexts, models, configuration descriptor and 
   --   parameter records.
   procedure Yices_Reset;  
   pragma Import(C,Yices_Reset,"yices_reset");

   ---------------------
   -- ERROR REPORTING --
   ---------------------

   -- Get the last error code
   function Yices_Error_Code return Error_Code_T ;  
   pragma Import(C,Yices_Error_Code,"yices_error_code") ;

   -- Get the last error report
   function Yices_Error_Report return access Error_Report_T ;
   pragma Import(C,Yices_Error_Report,"yices_error_report") ;

   -- Clear the error report
   procedure Yices_Clear_Error ;
   pragma Import (C, Yices_Clear_Error,"yices_clear_error") ;

  -- * Print an error message on stream f.  This converts the current error
  -- * code + error report structure into an error message.
  -- * - f must be a non-NULL open stream (writable)
  -- *
  -- * Return -1 if there's an error while writing to f (as reported by fprintf).
  -- * Return 0 otherwise.
  -- *
  -- * If there's an error, errno, perror, and friends can be used for diagnostic.
  --  

   -- function yices_print_error (arg1 : access stdio_h.FILE) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:151
   -- pragma Import (C, yices_print_error, "yices_print_error");

  --**********************
  -- *  TYPE CONSTRUCTORS  *
  -- ********************* 

  -- * All constructors return NULL_TYPE (-1) if the type definition is wrong.
  --  

  -- * Built-in types bool, int, real.
   function yices_bool_type return Type_T ;
   pragma Import (C, Yices_Bool_Type, "yices_bool_type");

   function yices_int_type return Type_T ;
   pragma Import (C, yices_int_type, "yices_int_type");

   function yices_real_type return Type_T ;
   pragma Import (C, yices_real_type, "yices_real_type");

  -- * Bitvectors of given size (number of bits)
  -- * Requires size > 0
   function Yices_Bv_Type( Arg1 : Interfaces.C.Int ) return Type_T with
     Pre => (Arg1 > 0) ;
   pragma Import(C,Yices_Bv_Type,"yices_bv_type") ;

  -- * New scalar type of given cardinality.
  -- * Requires card > 0
  -- * 
  -- * If card = 0, set error report to
  -- *   code = POS_INT_REQUIRED
  -- *   badval = size
  --  

   function Yices_New_Scalar_Type( Arg1 : Interfaces.C.Int ) return Type_T ;
   pragma Import(C,Yices_New_Scalar_Type,"yices_new_scalar_type") ;

   -- New uninterpreted type. No error report.
   function Yices_New_Uninterpreted_Type return Type_T ;
   pragma Import(C,Yices_New_Uninterpreted_Type,"yices_new_uninterpreted_type") ;

  -- * Tuple type tau[0] x ... x tau[n-1].
  -- * Requires n>0 and tau[0] ... tau[n-1] to be well defined types.
   function Yices_Tuple_Type( Arg1 : Iterfaces.C.Int ; Arg2 : access Type_T ) return Type_T with
     Pre => ( Integer(Arg1) > 0 );
   pragma Import(C,Yices_Tuple_Type,"yices_tuple_type") ;

  -- * Function type: dom[0] ... dom[n-1] -> range
  -- * Requires n>0, and dom[0] ... dom[n-1] and range to be well defined
  -- *
  -- * Error report
  -- * if n ==0,
  -- *   code = POS_INT_REQUIRED
  -- *   badval = n
  -- * if n > YICES_MAX_ARITY
  -- *   code = TOO_MANY_ARGUMENTS
  -- *   badval = n
  -- * if range undefined
  -- *   code = INVALID_TYPE
  -- *   type1 = range
  -- * if dom[i] is undefined (and dom[0] ... dom[i-1] are)
  -- *   code = INVALID_TYPE
  -- *   type1 = dom[i]
  --  

   function Yices_Function_Type( Arg1 : Interfaces.C.Int ; Arg2 : access Type_T ;  Arg3 : Type_T ) return Type_T ;
   pragma Import(C,Yices_Function_Type,"yices_function_type") ;

  --**********************
  -- *  TERM CONSTRUCTORS  *
  -- ********************* 

  -- * Constructors do type checking and simplification.
  -- * They return NULL_TERM (< 0) if there's a type error.
  -- *
  -- * Type checking rules for function applications:
  -- * - if f has type [tau_1 ... tau_n -> u]
  -- *   x_1 has type sigma_1, ..., x_n has type sigma_n
  -- * - then (f x1 ... xn) is type correct if sigma_i
  -- *   is a subtype of tau_i for i=1,...,n.
  -- * Examples: 
  -- * - x_i has type int and tau_i is real: OK
  -- * - x_i has type real and tau_i is int: type error
  --  

  -- * Boolean constants: no error report
  --  

   function Yices_True return Term_T ;  
   pragma Import(C,Yices_True,"yices_true") ;

   function Yices_False return Term_T ;
   pragma Import(C,Yices_False,"yices_false") ;

   -- Constant of type tau and id = index
   -- * tau must be a scalar type or an uninterpreted type
   -- * index must be non-negative, and, if tau is scalar,
   --   index must be less than tau's cardinality.
   function Yices_Constant( Arg1 : Type_T ; arg2 : Interfaces.C.Int ) return Term_T ;
   pragma Import(C,Yices_Constant,"yices_constant") ;

   -- Uninterpreted term of type tau
   -- 
   -- An uninterpreted term is like a global variable of type tau. But, we
   -- don't call it a variable, because variables have a different meaning
   -- in Yices (see next function). 
   -- 
   -- If tau is a function type, then this creates an uninterpreted
   -- function (see yices_application).
   function Yices_New_Uninterpreted_Term( Arg1 : Type_T ) return Term_T ;
   pragma Import(C,Yices_New_Uninterpreted_Term,"yices_new_uninterpreted_term") ;
   
   -- Variable of type tau. This creates a new variable.
   -- Variables are different form uninterpreted terms. They are used
   -- in quantifiers and to support substitutions.
   function Yices_New_Variable(arg1 : yices_types_h.type_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:323
   pragma Import (C, yices_new_variable, "yices_new_variable");

  -- * Application of an uninterpreted function to n arguments.
  -- * 
  -- * Error report:
  -- * if n == 0,
  -- *   code = POS_INT_REQUIRED
  -- *   badval = n
  -- * if fun or arg[i] is not defined
  -- *   code = INVALID_TERM
  -- *   term1 = fun or arg[i]
  -- * if fun is not a function
  -- *   code = FUNCTION_REQUIRED
  -- *   term1 = fun
  -- * if n != number of arguments required for fun
  -- *   code = WRONG_NUMBER_OF_ARGUMENTS
  -- *   type1 = type of fun
  -- *   badval = n
  -- * if arg[i] has a wrong type
  -- *   code = TYPE_MISMATCH
  -- *   term1 = arg[i]
  -- *   type1 = expected type
  --  

   function yices_application
     (arg1 : yices_types_h.term_t;
      arg2 : utypes_uuint32_t_h.uint32_t;
      arg3 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:348
   pragma Import (C, yices_application, "yices_application");

  -- * if-then-else
  -- *
  -- * Error report:
  -- * if cond, then_term, or else_term is not a valid term
  -- *   code = INVALID_TERM
  -- *   term1 = whichever of cond, then_term, or else_term is invalid
  -- * if cond is not boolean
  -- *   code = TYPE_MISMATCH
  -- *   term1 = cond
  -- *   type1 = bool (expected type)
  -- * if then_term and else_term have incompatible types
  -- *   code = INCOMPATIBLE_TYPES
  -- *   term1 = then_term
  -- *   type1 = term1's type
  -- *   term2 = else_term
  -- *   type2 = term2's type
  --  

   function yices_ite
     (arg1 : yices_types_h.term_t;
      arg2 : yices_types_h.term_t;
      arg3 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:369
   pragma Import (C, yices_ite, "yices_ite");

  -- * Equality (= left right)
  -- * Disequality (/= left right)
  -- *
  -- * Error report:
  -- * if left or right is not a valid term
  -- *   code = INVALID_TERM
  -- *   term1 = left or right
  -- * if left and right do not have compatible types
  -- *   code = INCOMPATIBLE_TYPES
  -- *   term1 = left
  -- *   type1 = term1's type
  -- *   term2 = right
  -- *   type2 = term2's type
  --  

   function yices_eq (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:387
   pragma Import (C, yices_eq, "yices_eq");

   function yices_neq (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:388
   pragma Import (C, yices_neq, "yices_neq");

  -- * (not arg)
  -- *
  -- * Error report:
  -- * if arg is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = arg
  -- * if arg is not boolean
  -- *    code = TYPE_MISMATCH
  -- *    term1 = arg
  -- *    type1 = bool (expected type)
  --  

   function yices_not (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:403
   pragma Import (C, yices_not, "yices_not");

  -- * (or  arg[0] ... arg[n-1])
  -- * (and arg[0] ... arg[n-1])
  -- * (xor arg[0] ... arg[n-1])
  -- *
  -- * Note: array arg may be modified.
  -- *
  -- * Error report:
  -- * if n > YICES_MAX_ARITY
  -- *   code = TOO_MANY_ARGUMENTS
  -- *   badval = n
  -- * if arg[i] is not a valid term
  -- *   code = INVALID_TERM
  -- *   term1 = arg[i]
  -- * if arg[i] is not boolean
  -- *   code = TYPE_MISMATCH
  -- *   term1 = arg[i]
  -- *   type1 = bool (expected type)
  --  

   function yices_or (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:425
   pragma Import (C, yices_or, "yices_or");

   function yices_and (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:426
   pragma Import (C, yices_and, "yices_and");

   function yices_xor (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:427
   pragma Import (C, yices_xor, "yices_xor");

  -- * Variants of or/and/xor with 2 or 3 arguments
  --  

   function yices_or2 (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:433
   pragma Import (C, yices_or2, "yices_or2");

   function yices_and2 (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:434
   pragma Import (C, yices_and2, "yices_and2");

   function yices_xor2 (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:435
   pragma Import (C, yices_xor2, "yices_xor2");

   function yices_or3
     (arg1 : yices_types_h.term_t;
      arg2 : yices_types_h.term_t;
      arg3 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:437
   pragma Import (C, yices_or3, "yices_or3");

   function yices_and3
     (arg1 : yices_types_h.term_t;
      arg2 : yices_types_h.term_t;
      arg3 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:438
   pragma Import (C, yices_and3, "yices_and3");

   function yices_xor3
     (arg1 : yices_types_h.term_t;
      arg2 : yices_types_h.term_t;
      arg3 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:439
   pragma Import (C, yices_xor3, "yices_xor3");

  -- * (iff left right)
  -- * (implies left right)
  -- *
  -- * Error report:
  -- * if left or right is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = left/right
  -- * if left or right is not boolean
  -- *    code = TYPE_MISMATCH
  -- *    term1 = left/right
  -- *    type1 = bool (expected type)
  --  

   function yices_iff (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:455
   pragma Import (C, yices_iff, "yices_iff");

   function yices_implies (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:456
   pragma Import (C, yices_implies, "yices_implies");

  -- * Tuple constructor
  -- *
  -- * Error report:
  -- * if n == 0
  -- *   code = POS_INT_REQUIRED
  -- *   badval = n
  -- * if n > YICES_MAX_ARITY
  -- *   code = TOO_MANY_ARGUMENTS
  -- *   badval = n
  -- * if one arg[i] is invalid
  -- *   code = INVALID_TERM
  -- *   term1 = arg[i]
  --  

   function yices_tuple (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:473
   pragma Import (C, yices_tuple, "yices_tuple");

  -- * Tuple projection
  -- *
  -- * The index must be between 1 and n (where n = number of components in tuple)
  -- *
  -- * Error report:
  -- * if tuple is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = tuple
  -- * if tuple does not have a tuple type
  -- *    code = TUPLE_REQUIRED
  -- *    term1 = tuple
  -- * if index = 0 or index > number of components in tuple
  -- *    code = INVALID_TUPLE_INDEX
  -- *    type1 = type of tuple
  -- *    badval = index
  --  

   function yices_select (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:493
   pragma Import (C, yices_select, "yices_select");

  -- * Tuple update: replace component i of tuple by new_v
  -- *
  -- * The index must be between 1 and n (where n = number of components in tuple)
  -- *
  -- * Error report
  -- * if tuple or new_v is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = tuple/new_v
  -- * if tuple doesn't have a tuple type
  -- *    code = TUPLE_REQUIRED
  -- *    term1 = tuple
  -- * if index = 0 or index > number of components in tuple
  -- *    code = INVALID_TUPLE_INDEX
  -- *    type1 = tuple's type
  -- *    badval = index
  -- * if new_v has a wrong type
  -- *    code = TYPE_MISMATCH
  -- *    term1 = new_v
  -- *    type1 = expected type (i-th component type in tuple)
  --  

   function yices_tuple_update
     (arg1 : yices_types_h.term_t;
      arg2 : utypes_uuint32_t_h.uint32_t;
      arg3 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:517
   pragma Import (C, yices_tuple_update, "yices_tuple_update");

  -- * Function update
  -- *
  -- * Error report:
  -- * if n = 0
  -- *    code = POS_INT_REQUIRED
  -- *    badval = n
  -- * if fun or new_v, or one of arg[i] is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = fun, new_v, or arg[i]
  -- * if fun does not have a function type
  -- *    code = FUNCTION_REQUIRED
  -- *    term1 = fun
  -- * if n != number of arguments for fun
  -- *    code = WRONG_NUMBER_OF_ARGUMENTS
  -- *    type1 = type of fun
  -- *    badval = n
  -- * if new_v has a wrong type (not a subtype of fun's range)
  -- *    code = TYPE_MISMATCH
  -- *    term1 = new_v
  -- *    type1 = fun's range (expected type)
  -- * if arg[i] has a wrong type for i-th arg of fun
  -- *    code = TYPE_MISMATCH
  -- *    term1 = arg[i]
  -- *    type1 = expected type
  --  

   function yices_update
     (arg1 : yices_types_h.term_t;
      arg2 : utypes_uuint32_t_h.uint32_t;
      arg3 : access yices_types_h.term_t;
      arg4 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:546
   pragma Import (C, yices_update, "yices_update");

  -- * Distinct
  -- *
  -- * Note: arg many be modified
  -- *
  -- * Error report:
  -- * if n == 0
  -- *    code = POS_INT_REQUIRED
  -- *    badval = n
  -- * if n > YICES_MAX_ARITY
  -- *    code = TOO_MANY_ARGUMENTS
  -- *    badval = n
  -- * if arg[i] is not a valid term
  -- *    code = INVALID_TERM
  -- *    term1 = arg[i]
  -- * if two terms arg[i] and arg[j] don't have compatible types
  -- *    code = INCOMPATIBLE_TYPES
  -- *    term1 = arg[i]
  -- *    type1 = term1's type
  -- *    term2 = arg[j]
  -- *    type2 = term2's type
  --  

   function yices_distinct (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:571
   pragma Import (C, yices_distinct, "yices_distinct");

  -- * Quantified terms
  -- *  (forall (var[0] ... var[n-1]) body)
  -- *  (exists (var[0] ... var[n-1]) body)
  -- * 
  -- * Note: array var may be modified
  -- *
  -- * Error report:
  -- * if n == 0
  -- *    code = POS_INT_REQUIRED
  -- *    badval = n
  -- * if n > YICES_MAX_VARS
  -- *    code = TOO_MANY_VARS
  -- *    badval = n
  -- * if body or one of var[i] is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = body or var[i]
  -- * if body is not boolean
  -- *    code = TYPE_MISMATCH
  -- *    term1 = body
  -- *    type1 = bool (expected type)
  -- * if one of var[i] is not a variable
  -- *    code = VARIABLE_REQUIRED
  -- *    term1 = var[i]
  -- * if one variable occurs twice in var
  -- *    code = DUPLICATE_VARIABLE
  -- *    term1 = var[i]
  --  

   function yices_forall
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access yices_types_h.term_t;
      arg3 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:603
   pragma Import (C, yices_forall, "yices_forall");

   function yices_exists
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access yices_types_h.term_t;
      arg3 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:604
   pragma Import (C, yices_exists, "yices_exists");

  -- * Lambda terms
  -- *
  -- * Error report:
  -- * if n == 0
  -- *    code = POS_INT_REQUIRED
  -- *    badval = n
  -- * if n > YICES_MAX_VARS
  -- *    code = TOO_MANY_VARS
  -- *    badval = n
  -- * if body or one of var[i] is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = body or var[i]
  -- * if one of var[i] is not a variable
  -- *    code = VARIABLE_REQUIRED
  -- *    term1 = var[i]
  -- * if one variable occurs twice in var
  -- *    code = DUPLICATE_VARIABLE
  -- *    term1 = var[i]
  -- *
  --  

   function yices_lambda
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access yices_types_h.term_t;
      arg3 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:629
   pragma Import (C, yices_lambda, "yices_lambda");

  --*********************************
  -- *  ARITHMETIC TERM CONSTRUCTORS  *
  -- ******************************** 

  -- * RATIONAL/INTEGER CONSTANTS
  -- *
  -- * Constant terms can be constructed from integers, GMP numbers,
  -- * or by parsing strings.
  -- *
  -- * The constant term constructors return NULL_TERM (-1) if there's
  -- * an error and set the error report.
  --  

  -- * Zero: no error
  --  

   function yices_zero return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:650
   pragma Import (C, yices_zero, "yices_zero");

  -- * Integer constants
  --  

   function yices_int32 (arg1 : sys_utypes_uint32_t_h.int32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:656
   pragma Import (C, yices_int32, "yices_int32");

   function yices_int64 (arg1 : sys_utypes_uint64_t_h.int64_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:657
   pragma Import (C, yices_int64, "yices_int64");

  -- * Rational constants
  -- * - den must be non-zero
  -- * - common factors are removed
  -- *
  -- * Error report:
  -- * if den is zero
  -- *   code = DIVISION_BY_ZERO
  --  

   function yices_rational32 (arg1 : sys_utypes_uint32_t_h.int32_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:669
   pragma Import (C, yices_rational32, "yices_rational32");

   function yices_rational64 (arg1 : sys_utypes_uint64_t_h.int64_t; arg2 : utypes_uuint64_t_h.uint64_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:670
   pragma Import (C, yices_rational64, "yices_rational64");

  -- * Constant initialized via GMP integers or rationals.
  -- * - q must be canonicalized
  --  

  -- * Convert a string to a rational or integer term. 
  -- * The string format is
  -- *     <optional_sign> <numerator>/<denominator>
  -- *  or <optional_sign> <numerator>
  -- *
  -- * where <optional_sign> is + or - or nothing
  -- * <numerator> and <denominator> are sequences of 
  -- * decimal digits.
  -- *
  -- * Error report:
  -- *   code = INVALID_RATIONAL_FORMAT if s is not in this format
  -- *   code = DIVISION_BY_ZERO if the denominator is zero
  --  

   function yices_parse_rational (arg1 : Interfaces.C.Strings.chars_ptr) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:697
   pragma Import (C, yices_parse_rational, "yices_parse_rational");

  -- * Convert a string in floating point format to a rational
  -- * The string must be in one of the following formats:
  -- *   <optional sign> <integer part> . <fractional part>
  -- *   <optional sign> <integer part> <exp> <optional sign> <integer>
  -- *   <optional sign> <integer part> . <fractional part> <exp> <optional sign> <integer>
  -- * 
  -- * where <optional sign> is + or - or nothing
  -- *       <exp> is either 'e' or 'E'
  -- *
  -- * Error report:
  -- * code = INVALID_FLOAT_FORMAT
  --  

   function yices_parse_float (arg1 : Interfaces.C.Strings.chars_ptr) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:713
   pragma Import (C, yices_parse_float, "yices_parse_float");

  -- * ARITHMETIC OPERATIONS
  --  

  -- * All operations return NULL_TERM if there's an error (NULL_TERM = -1)
  -- *
  -- * Error reports:
  -- * if t1 or t2 is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t1 or t2
  -- * if t1 or t2 is not an arithmetic term
  -- *   code = ARITH_TERM_REQUIRED
  -- *   term1 = t1 or t2
  -- *
  -- * for yices_mul, yices_square, and yices_power,
  -- * if the result's degree is too large,
  -- * then the error report is
  -- *   code = DEGREE_OVERFLOW
  -- *   badval = product degree
  --  

  -- t1 + t2
   function yices_add (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:737
   pragma Import (C, yices_add, "yices_add");

  -- t1 - t2
   function yices_sub (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:738
   pragma Import (C, yices_sub, "yices_sub");

  -- -t1
   function yices_neg (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:739
   pragma Import (C, yices_neg, "yices_neg");

  -- t1 * t2
   function yices_mul (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:740
   pragma Import (C, yices_mul, "yices_mul");

  -- t1 * t1
   function yices_square (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:741
   pragma Import (C, yices_square, "yices_square");

  -- t1 ^ d
   function yices_power (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:742
   pragma Import (C, yices_power, "yices_power");

  -- * POLYNOMIALS
  --  

  -- * The functions below construct the term a_0 t_0 + ... + a_{n-1} t_{n-1}
  -- * given n constant coefficients a_0, ..., a_{n-1} and
  -- *       n arithmetic terms t_0, ..., t_{n-1}.
  -- *
  -- * If there's an error, the functions return NULL_TERM (-1).
  -- *
  -- * Error reports:
  -- * if t[i] is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t[i]
  -- * if t[i] is not an arithmetic term
  -- *   code = ARITH_TERM_REQUIRED
  -- *   term1 = t[i]
  --  

  -- * Polynomial with integer coefficients
  -- * - a and t must both be arrays of size n
  --  

   function yices_poly_int32
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access sys_utypes_uint32_t_h.int32_t;
      arg3 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:769
   pragma Import (C, yices_poly_int32, "yices_poly_int32");

   function yices_poly_int64
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access sys_utypes_uint64_t_h.int64_t;
      arg3 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:770
   pragma Import (C, yices_poly_int64, "yices_poly_int64");

  -- * Polynomial with rational coefficients
  -- * - den, num, and t must be arrays of size n
  -- * - the coefficient a_i is den[i]/num[i]
  -- * 
  -- * Error report:
  -- * if num[i] is 0
  -- *   code = DIVISION_BY_ZERO
  --  

   function yices_poly_rational32
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access sys_utypes_uint32_t_h.int32_t;
      arg3 : access utypes_uuint32_t_h.uint32_t;
      arg4 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:782
   pragma Import (C, yices_poly_rational32, "yices_poly_rational32");

   function yices_poly_rational64
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access sys_utypes_uint64_t_h.int64_t;
      arg3 : access utypes_uuint64_t_h.uint64_t;
      arg4 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:783
   pragma Import (C, yices_poly_rational64, "yices_poly_rational64");

  -- * Coefficients are GMP integers or rationals.
  -- * - the rationals q[0 ... n-1] must all be canonicalized
  --  

  -- * ARITHMETIC ATOMS
  --  

  -- * All operations return NULL_TERM if there's an error (NULL_TERM = -1)
  -- *
  -- * Error reports
  -- * if t1 or t2 is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t1 or t2
  -- * if t1 or t2 is not an arithmetic term
  -- *   code = ARITH_TERM_REQUIRED
  -- *   term1 = t1 or t2
  --  

  -- t1 == t2
   function yices_arith_eq_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:812
   pragma Import (C, yices_arith_eq_atom, "yices_arith_eq_atom");

  -- t1 != t2
   function yices_arith_neq_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:813
   pragma Import (C, yices_arith_neq_atom, "yices_arith_neq_atom");

  -- t1 >= t2
   function yices_arith_geq_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:814
   pragma Import (C, yices_arith_geq_atom, "yices_arith_geq_atom");

  -- t1 <= t2
   function yices_arith_leq_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:815
   pragma Import (C, yices_arith_leq_atom, "yices_arith_leq_atom");

  -- t1 > t2
   function yices_arith_gt_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:816
   pragma Import (C, yices_arith_gt_atom, "yices_arith_gt_atom");

  -- t1 < t2
   function yices_arith_lt_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:817
   pragma Import (C, yices_arith_lt_atom, "yices_arith_lt_atom");

  -- * Comparison with 0:
  -- *
  -- * Return NULL_TERM if there's an error.
  -- *
  -- * Error report:
  -- * if t is not valid:
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * if t is not an arithmetic term
  -- *   code = ARITH_TERM_REQUIRES
  -- *   term1 = t
  --  

  -- t == 0
   function yices_arith_eq0_atom (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:833
   pragma Import (C, yices_arith_eq0_atom, "yices_arith_eq0_atom");

  -- t != 0
   function yices_arith_neq0_atom (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:834
   pragma Import (C, yices_arith_neq0_atom, "yices_arith_neq0_atom");

  -- t >= 0
   function yices_arith_geq0_atom (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:835
   pragma Import (C, yices_arith_geq0_atom, "yices_arith_geq0_atom");

  -- t <= 0
   function yices_arith_leq0_atom (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:836
   pragma Import (C, yices_arith_leq0_atom, "yices_arith_leq0_atom");

  -- t > 0
   function yices_arith_gt0_atom (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:837
   pragma Import (C, yices_arith_gt0_atom, "yices_arith_gt0_atom");

  -- t < 0
   function yices_arith_lt0_atom (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:838
   pragma Import (C, yices_arith_lt0_atom, "yices_arith_lt0_atom");

  --********************************
  -- *  BITVECTOR TERM CONSTRUCTORS  *
  -- ******************************* 

  -- * BITVECTOR CONSTANTS
  -- *
  -- * Constants can be constructed from C integers (32 or 64 bits),
  -- * from GMP integers, from arrays, or by parsing strings.
  -- *
  -- * The constant constructors return NULL_TERM (-1) if there's 
  -- * an error and set the error report.
  --  

  -- * Conversion of an integer to a bitvector constant.
  -- * - n = number of bits
  -- * - x = value
  -- * The value x is truncated (or 0-padded) to n bits
  -- *
  -- * The low-order bit of x is bit 0 of the constant.
  -- *
  -- * Error report:
  -- * if n = 0
  -- *    code = POS_INT_REQUIRED
  -- *    badval = n
  -- * if n > YICES_MAX_BVSIZE
  -- *    code = MAX_BVSIZE_EXCEEDED
  -- *    badval = n
  --  

   function yices_bvconst_uint32 (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:873
   pragma Import (C, yices_bvconst_uint32, "yices_bvconst_uint32");

   function yices_bvconst_uint64 (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : utypes_uuint64_t_h.uint64_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:874
   pragma Import (C, yices_bvconst_uint64, "yices_bvconst_uint64");

  -- * bvconst_zero: set all bits to 0
  -- * bvconst_one: set low-order bit to 1, all the other bits to 0
  -- * bvconst_minus_one: set all bits to 1
  -- *
  -- * Error report:
  -- * if n = 0
  -- *    code = POS_INT_REQUIRED
  -- *    badval = n
  -- * if n > YICES_MAX_BVSIZE
  -- *    code = MAX_BVSIZE_EXCEEDED
  -- *    badval = n
  --  

   function yices_bvconst_zero (arg1 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:894
   pragma Import (C, yices_bvconst_zero, "yices_bvconst_zero");

   function yices_bvconst_one (arg1 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:895
   pragma Import (C, yices_bvconst_one, "yices_bvconst_one");

   function yices_bvconst_minus_one (arg1 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:896
   pragma Import (C, yices_bvconst_minus_one, "yices_bvconst_minus_one");

  -- * Construction from an integer array
  -- * bit i of the constant is 0 if a[i] == 0
  -- * bit i of the constant is 1 if a[i] != 0
  -- *
  -- * Error report:
  -- * if n = 0
  -- *    code = POS_INT_REQUIRED
  -- *    badval = n
  -- * if n > YICES_MAX_BVSIZE
  -- *    code = MAX_BVSIZE_EXCEEDED
  -- *    badval = n
  --  

   function yices_bvconst_from_array (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : access sys_utypes_uint32_t_h.int32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:912
   pragma Import (C, yices_bvconst_from_array, "yices_bvconst_from_array");

  -- * Parsing from a string of characters '0' and '1'
  -- * First character = high order bit
  -- * Last character = low-order bit
  -- * The constant has n bits if the strings has n characters.
  -- *
  -- * Error report:
  -- * if the format is incorrect:
  -- *   code = INVALID_BVBIN_FORMAT
  -- * if the string has more than YICES_MAX_BVSIZE digits
  -- *   code = MAX_BVSIZE_EXCEEDED
  -- *   badval = n
  --  

   function yices_parse_bvbin (arg1 : Interfaces.C.Strings.chars_ptr) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:928
   pragma Import (C, yices_parse_bvbin, "yices_parse_bvbin");

  -- * Parsing from a hexadecimal string
  -- * All characters must be '0' to '9' or 'a' to 'f' or 'A' to 'F'
  -- * - First character = 4 high order bits 
  -- * - Last character = 4 low-order bits
  -- * The constant has 4n bits if s has n characters.
  -- *
  -- * Error report:
  -- * if the format is incorrect:
  -- *   code = INVALID_BVHEX_FORMAT
  -- * if the result would have more than YICES_MAX_BVSIZE digits
  -- *   code = MAX_BVSIZE_EXCEEDED
  -- *   badval = 4n
  --  

   function yices_parse_bvhex (arg1 : Interfaces.C.Strings.chars_ptr) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:945
   pragma Import (C, yices_parse_bvhex, "yices_parse_bvhex");

  -- * BIT-VECTOR ARITHMETIC
  --  

  -- * Binary operations: both arguments must be bitvector terms of the same size.
  -- * The functions return NULL_TERM (-1) if there's an error.
  -- *
  -- * Error reports
  -- * if t1 or t2 is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t1 or t2
  -- * if t1 or t2 is not a bitvector term
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t1 or t2
  -- * if t1 and t2 do not have the same bitvector type
  -- *   code = INCOMPATIBLE_TYPES
  -- *   term1 = t1
  -- *   type1 = type of t1
  -- *   term2 = t2
  -- *   type2 = type of t2
  -- *
  -- * For bvmul, bvsquare, or bvpower, if the degree is too large
  -- *   code = DEGREE_OVERFLOW
  -- *
  -- *
  -- * In case of division by 0, Yices uses the following conventions:
  -- *   
  -- *   (bvdiv  x 0b00...0) is the  largest unsigned integer that can be represented using n bits
  -- *                       (i.e., 0b111....1)
  -- *
  -- *   (bvrem  x 0b00...0) is x
  -- *
  -- *   (bvsdiv x 0b00...0) is   0b00..01 (i.e., +1) if x's sign bit is 1
  -- *                       and  0b111111 (i.e., -1) if x's sign bit is 0
  -- *
  -- *   (bvsrem x 0b00...0) is x
  -- *
  -- *   (bvsmod x 0b00...0) is x
  -- * 
  --  

  -- addition (t1 + t2)
   function yices_bvadd (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:991
   pragma Import (C, yices_bvadd, "yices_bvadd");

  -- subtraction (t1 - t2)
   function yices_bvsub (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:992
   pragma Import (C, yices_bvsub, "yices_bvsub");

  -- negation (- t1)
   function yices_bvneg (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:993
   pragma Import (C, yices_bvneg, "yices_bvneg");

  -- multiplication (t1 * t2)
   function yices_bvmul (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:994
   pragma Import (C, yices_bvmul, "yices_bvmul");

  -- square (t1 * t1)
   function yices_bvsquare (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:995
   pragma Import (C, yices_bvsquare, "yices_bvsquare");

  -- exponentiation (t1 ^ d)
   function yices_bvpower (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:996
   pragma Import (C, yices_bvpower, "yices_bvpower");

  -- unsigned div
   function yices_bvdiv (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:998
   pragma Import (C, yices_bvdiv, "yices_bvdiv");

  -- unsigned rem
   function yices_bvrem (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:999
   pragma Import (C, yices_bvrem, "yices_bvrem");

  -- signed div
   function yices_bvsdiv (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1000
   pragma Import (C, yices_bvsdiv, "yices_bvsdiv");

  -- signed rem
   function yices_bvsrem (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1001
   pragma Import (C, yices_bvsrem, "yices_bvsrem");

  -- signed mod
   function yices_bvsmod (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1002
   pragma Import (C, yices_bvsmod, "yices_bvsmod");

  -- bitwise not
   function yices_bvnot (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1004
   pragma Import (C, yices_bvnot, "yices_bvnot");

  -- bitwise and
   function yices_bvand (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1005
   pragma Import (C, yices_bvand, "yices_bvand");

  -- bitwise or
   function yices_bvor (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1006
   pragma Import (C, yices_bvor, "yices_bvor");

  -- bitwise exclusive or
   function yices_bvxor (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1007
   pragma Import (C, yices_bvxor, "yices_bvxor");

  -- bitwise not and
   function yices_bvnand (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1008
   pragma Import (C, yices_bvnand, "yices_bvnand");

  -- bitwise not or
   function yices_bvnor (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1009
   pragma Import (C, yices_bvnor, "yices_bvnor");

  -- bitwise not xor
   function yices_bvxnor (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1010
   pragma Import (C, yices_bvxnor, "yices_bvxnor");

  -- shift t1 left by k bits where k = value of t2
   function yices_bvshl (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1012
   pragma Import (C, yices_bvshl, "yices_bvshl");

  -- logical shift t1 right by k bits, where k = value of t2
   function yices_bvlshr (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1013
   pragma Import (C, yices_bvlshr, "yices_bvlshr");

  -- arithmetic shift t1 right by k bits, k = value of t2
   function yices_bvashr (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1014
   pragma Import (C, yices_bvashr, "yices_bvashr");

  -- * Shift or rotation by an integer constant n
  -- * - shift_left0 sets the low-order bits to zero
  -- * - shift_left1 sets the low-order bits to one
  -- * - shift_right0 sets the high-order bits to zero
  -- * - shift_right1 sets the high-order bits to one
  -- * - ashift_right is arithmetic shift, it copies the sign bit
  -- * - rotate_left: circular rotation
  -- * - rotate_right: circular rotation 
  -- *
  -- * If t is a vector of m bits, then n must satisfy 0 <= n <= m.
  -- *
  -- * The functions return NULL_TERM (-1) if there's an error.
  -- *
  -- * Error reports:
  -- * if t is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * if t is not a bitvector term
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t
  -- * if n > size of t
  -- *   code = INVALID_BITSHIFT
  -- *   badval = n
  --  

   function yices_shift_left0 (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1042
   pragma Import (C, yices_shift_left0, "yices_shift_left0");

   function yices_shift_left1 (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1043
   pragma Import (C, yices_shift_left1, "yices_shift_left1");

   function yices_shift_right0 (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1044
   pragma Import (C, yices_shift_right0, "yices_shift_right0");

   function yices_shift_right1 (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1045
   pragma Import (C, yices_shift_right1, "yices_shift_right1");

   function yices_ashift_right (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1046
   pragma Import (C, yices_ashift_right, "yices_ashift_right");

   function yices_rotate_left (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1047
   pragma Import (C, yices_rotate_left, "yices_rotate_left");

   function yices_rotate_right (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1048
   pragma Import (C, yices_rotate_right, "yices_rotate_right");

  -- * Extract a subvector of t
  -- * - t must be a bitvector term of size m
  -- * - i and j must satisfy i <= j <= m-1
  -- * The result is the bits i to j of t.
  -- *
  -- * Return NULL_TERM (-1) if there's an error.
  -- *
  -- * Error reports:
  -- * if t is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * if t is not a bitvector term
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t
  -- * if i <= j <= m-1 does not hold
  -- *   code = INVALID_BVEXTRACT
  --  

   function yices_bvextract
     (arg1 : yices_types_h.term_t;
      arg2 : utypes_uuint32_t_h.uint32_t;
      arg3 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1069
   pragma Import (C, yices_bvextract, "yices_bvextract");

  -- * Concatenation
  -- * - t1 and t2 must be bitvector terms
  -- *
  -- * Return NULL_TERM (-1) if there's an error.
  -- *
  -- * Error reports
  -- * if t1 or t2 is not a valid term
  -- *   code = INVALID_TERM
  -- *   term1 = t1 or t2
  -- * if t1 or t2 is not a bitvector term
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t1 or t2
  --  

   function yices_bvconcat (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1086
   pragma Import (C, yices_bvconcat, "yices_bvconcat");

  -- * Repeated concatenation:
  -- * - make n copies of t and concatenate them
  -- * - n must be positive
  -- *
  -- * Return NULL_TERM (-1) if there's an error
  -- *
  -- * Error report:
  -- * if t is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * if t is not a bitvector term
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t
  -- * if n == 0
  -- *   code = POS_INT_REQUIRED
  -- *   badval = n
  -- * if n * size of t > MAX_BVSIZE
  -- *   code = MAX_BVSIZE_EXCEEDED
  -- *   badval = n * size of t
  --  

   function yices_bvrepeat (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1110
   pragma Import (C, yices_bvrepeat, "yices_bvrepeat");

  -- * Sign extension
  -- * - add n copies of t's sign bit
  -- *
  -- * Return NULL_TERM if there's an error.
  -- *
  -- * Error reports:
  -- * if t is invalid
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * if t is not a bitvector
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t
  -- * if n + size of t > MAX_BVSIZE
  -- *   code = MAX_BVSIZE_EXCEEDED
  -- *   badval = n * size of t
  --  

   function yices_sign_extend (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1130
   pragma Import (C, yices_sign_extend, "yices_sign_extend");

  -- * Zero extension
  -- * - add n zeros to t
  -- *
  -- * Return NULL_TERM if there's an error.
  -- *
  -- * Error reports:
  -- * if t is invalid
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * if t is not a bitvector
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t
  -- * if n + size of t > MAX_BVSIZE
  -- *   code = MAX_BVSIZE_EXCEEDED
  -- *   badval = n * size of t
  --  

   function yices_zero_extend (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1150
   pragma Import (C, yices_zero_extend, "yices_zero_extend");

  -- * AND-reduction: 
  -- * if t is b[m-1] ... b[0], then the result is a bit-vector of 1 bit
  -- * equal to the conjunction of all bits of t (i.e., (and b[0] ... b[m-1])
  -- *
  -- * OR-reduction: compute (or b[0] ... b[m-1])
  -- *
  -- * Return NULL_TERM if there's an error
  -- *
  -- * Error reports:
  -- * if t is invalid
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * if t is not a bitvector
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t
  --  

   function yices_redand (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1170
   pragma Import (C, yices_redand, "yices_redand");

   function yices_redor (arg1 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1171
   pragma Import (C, yices_redor, "yices_redor");

  -- * Bitwise equality comparison: if t1 and t2 are bitvectors of size n,
  -- * construct (bvredand (bvxnor t1 t2))
  -- *
  -- * Return NULL_TERM if there's an error
  -- *
  -- * Error reports:
  -- * if t1 or t2 is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t1 or t2
  -- * if t1 or t2 is not a bitvector term
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t1 or t2
  -- * if t1 and t2 do not have the same bitvector type
  -- *   code = INCOMPATIBLE_TYPES
  -- *   term1 = t1
  -- *   type1 = type of t1
  -- *   term2 = t2
  -- *   type2 = type of t2
  --  

   function yices_redcomp (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1194
   pragma Import (C, yices_redcomp, "yices_redcomp");

  -- * Convert an array of boolean terms arg[0 ... n-1] into
  -- * a bitvector term.
  -- *
  -- * Error report:
  -- * if n == 0
  -- *    code = POS_INT_REQUIRED
  -- *    badval = n
  -- * if n > YICES_MAX_BVSIZE
  -- *    code = MAX_BVSIZE_EXCEEDED
  -- *    badval = size
  -- * if arg[i] is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = arg[i]
  -- * if arg[i] is not a boolean
  -- *    code = TYPE_MISMATCH
  -- *    term1 = arg[i]
  -- *    type1 = bool
  --  

   function yices_bvarray (arg1 : utypes_uuint32_t_h.uint32_t; arg2 : access yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1216
   pragma Import (C, yices_bvarray, "yices_bvarray");

  -- * Extract bit i of vector t (as a boolean)
  -- *
  -- * Error report:
  -- * if t is invalid
  -- *    code = INVALID_TERM
  -- *    term1 = t
  -- * if t is not a bitvector term
  -- *    code = BITVECTOR_REQUIRES
  -- *    term1 = t
  -- * if i >= t's bitsize
  -- *    code = INVALID_BVEXTRACT
  --  

   function yices_bitextract (arg1 : yices_types_h.term_t; arg2 : utypes_uuint32_t_h.uint32_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1232
   pragma Import (C, yices_bitextract, "yices_bitextract");

  -- * BITVECTOR ATOMS
  --  

  -- * All operations return NULL_TERM (i.e., a negative index) on error
  -- *
  -- * Error reports
  -- * if t1 or t2 is not valid
  -- *   code = INVALID_TERM
  -- *   term1 = t1 or t2
  -- * if t1 or t2 is not a bitvector term
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t1 or t2
  -- * if t1 and t2 do not have the same bitvector type
  -- *   code = INCOMPATIBLE_TYPES
  -- *   term1 = t1
  -- *   type1 = type of t1
  -- *   term2 = t2
  -- *   type2 = type of t2
  --  

  -- * Equality and disequality
  --  

   function yices_bveq_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1260
   pragma Import (C, yices_bveq_atom, "yices_bveq_atom");

   function yices_bvneq_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1261
   pragma Import (C, yices_bvneq_atom, "yices_bvneq_atom");

  -- * Unsigned inequalities
  --  

  -- t1 >= t2
   function yices_bvge_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1267
   pragma Import (C, yices_bvge_atom, "yices_bvge_atom");

  -- t1 > t2
   function yices_bvgt_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1268
   pragma Import (C, yices_bvgt_atom, "yices_bvgt_atom");

  -- t1 <= t2
   function yices_bvle_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1269
   pragma Import (C, yices_bvle_atom, "yices_bvle_atom");

  -- t1 < t2
   function yices_bvlt_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1270
   pragma Import (C, yices_bvlt_atom, "yices_bvlt_atom");

  -- * Signed inequalities
  --  

  -- t1 >= t2
   function yices_bvsge_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1276
   pragma Import (C, yices_bvsge_atom, "yices_bvsge_atom");

  -- t1 > t2
   function yices_bvsgt_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1277
   pragma Import (C, yices_bvsgt_atom, "yices_bvsgt_atom");

  -- t1 <= t2
   function yices_bvsle_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1278
   pragma Import (C, yices_bvsle_atom, "yices_bvsle_atom");

  -- t1 < t2
   function yices_bvslt_atom (arg1 : yices_types_h.term_t; arg2 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1279
   pragma Import (C, yices_bvslt_atom, "yices_bvslt_atom");

  --*************
  -- *  PARSING   *
  -- ************ 

  -- * Parsing uses the Yices language.
  -- * - convert an input string s to a type or term.
  -- * - s must be terminated by '\0'
  -- *
  -- * The parsing function return NULL_TYPE or NULL_TERM if there's an
  -- * error and set the error report. The line and column fields of the
  -- * error report give information about the error location.
  --  

   function yices_parse_type (arg1 : Interfaces.C.Strings.chars_ptr) return yices_types_h.type_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1297
   pragma Import (C, yices_parse_type, "yices_parse_type");

   function yices_parse_term (arg1 : Interfaces.C.Strings.chars_ptr) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1298
   pragma Import (C, yices_parse_term, "yices_parse_term");

  --******************
  -- *  SUBSTITUTIONS  *
  -- ***************** 

  -- * Apply the substitution defined by arrays var and map to a term t
  -- * - var must be an array of n variables (variables are created using
  -- *   yices_new_variables).
  -- * - map must be an array of n terms
  -- * - the type of map[i] must be a subtype of var[i]'s type
  -- * - every occurrence of var[i] in t is replaced by map[i]
  -- * - if a variable occurs several times in v, the last occurrence 
  -- *   counts. (e.g., if v[i] = x and v[j] = x with i < j, and 
  -- *   there are no other occurrences of x in v, then x is 
  -- *   replaced by map[j]).
  -- * 
  -- * Return the resulting term or NULL_TERM if there's an error.
  -- *
  -- * Error codes:
  -- * - INVALID_TERM if var[i] or map[i] is not valid
  -- * - VARIABLE_REQUIRED if var[i] is not a variable
  -- * - TYPE_MISMATCH if map[i]'s type is not a subtype of var[i]'s type
  -- * - DEGREE_OVERFLOW if the substitution causes an overflow
  --  

   function yices_subst_term
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access yices_types_h.term_t;
      arg3 : access yices_types_h.term_t;
      arg4 : yices_types_h.term_t) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1326
   pragma Import (C, yices_subst_term, "yices_subst_term");

  -- * Apply a substitution to m terms in parallel
  -- * - the substitution is defined by arrays var and map:
  -- *   var must be an array of n variables
  -- *   map must be an array of n terms
  -- *   map[i]'s type must be a subtype of var[i]'s type
  -- * - the substitution is applied to terms t[0] ... t[m-1]
  -- * - on entry to the function: t[i] must be a valid term 
  -- *   the function applies the substitution to t[i]
  -- *   then store the result in place (i.e., t[i] := subst(n, var, map, t[i])).
  -- *
  -- * Note: it's more efficient to call this function than to call
  -- * yices_subst_term m times.
  -- *
  -- * Return code: 
  -- *  0 if all goes well
  -- * -1 if there's an error
  -- *
  -- * Error codes: as above
  --  

   function yices_subst_term_array
     (arg1 : utypes_uuint32_t_h.uint32_t;
      arg2 : access yices_types_h.term_t;
      arg3 : access yices_types_h.term_t;
      arg4 : utypes_uuint32_t_h.uint32_t;
      arg5 : access yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1349
   pragma Import (C, yices_subst_term_array, "yices_subst_term_array");

  --***********
  -- *  NAMES   *
  -- ********** 

  -- * It's possible to assign names to terms and types, and later
  -- * retrieve the term or type from these names.
  -- *
  -- * For each term and type, Yices stores a base name, which
  -- * is used for pretty printing. By default, the base name is NULL.
  -- * The base name is set on the first call to yices_set_term_name or 
  -- * yices_set_type_name.
  -- *
  -- * In addition, Yices stores two symbol tables that maps names to
  -- * terms and types, respectively. The name spaces for types and terms
  -- * are disjoint. The term or type that a name refers to can be changed,
  -- * and Yices provides a scoping mechanism:
  -- * - when function  yices_set_term_name(t, name) is called,
  -- *   then the previous mapping for 'name' (if any) is hidden and now 
  -- *   'name' refers to term 't'.
  -- * - if function yices_remove_term_name(name) is called, then the current
  -- *   mapping for 'name' is removed and the previous mapping (if any)
  -- *   is restored.
  --  

  -- * The following functions attach a name to a type or a term
  -- * - name  must be a '\0'-terminated string
  -- * - if tau or t does not have a base name yet, then name is stored 
  -- *   as base name for tau or t.
  -- * - if name referred to another term or another type, then this 
  -- *   previous mapping is hidden
  -- *
  -- * The functions return -1 and set the error report if the term or
  -- * type is invalid . Otherwise they return 0.
  -- *
  -- * A copy of string name is made internally.
  --  

   function yices_set_type_name (arg1 : yices_types_h.type_t; arg2 : Interfaces.C.Strings.chars_ptr) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1391
   pragma Import (C, yices_set_type_name, "yices_set_type_name");

   function yices_set_term_name (arg1 : yices_types_h.term_t; arg2 : Interfaces.C.Strings.chars_ptr) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1392
   pragma Import (C, yices_set_term_name, "yices_set_term_name");

  -- * Remove the current mapping of name
  -- * - no effect if name is not assigned to a term or type
  -- * - if name is assigned to some term t or type tau, then this current
  -- *   mapping is removed. If name was previously mapped to another term
  -- *   or type, then the previous mapping is restored.
  --  

   procedure yices_remove_type_name (arg1 : Interfaces.C.Strings.chars_ptr);  -- /Users/dpereira/Provers/yices2/include/yices.h:1402
   pragma Import (C, yices_remove_type_name, "yices_remove_type_name");

   procedure yices_remove_term_name (arg1 : Interfaces.C.Strings.chars_ptr);  -- /Users/dpereira/Provers/yices2/include/yices.h:1403
   pragma Import (C, yices_remove_term_name, "yices_remove_term_name");

  -- * Get type or term of the given name
  -- * - return NULL_TYPE or NULL_TERM if there's no type or term with that name
  --  

   function yices_get_type_by_name (arg1 : Interfaces.C.Strings.chars_ptr) return yices_types_h.type_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1410
   pragma Import (C, yices_get_type_by_name, "yices_get_type_by_name");

   function yices_get_term_by_name (arg1 : Interfaces.C.Strings.chars_ptr) return yices_types_h.term_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1411
   pragma Import (C, yices_get_term_by_name, "yices_get_term_by_name");

  -- * Remove the base name of a type tau or of a term t.
  -- *
  -- * The functions return -1 and set the error report if the 
  -- * type or term is invalid. Otherwise, they return 0.
  -- *
  -- * If tau or t doesn't have a name, the functions do nothing
  -- * and return 0.
  --  

   function yices_clear_type_name (arg1 : yices_types_h.type_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1423
   pragma Import (C, yices_clear_type_name, "yices_clear_type_name");

   function yices_clear_term_name (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1424
   pragma Import (C, yices_clear_term_name, "yices_clear_term_name");

  --*********************
  -- *  PRETTY PRINTING   *
  -- ******************** 

  -- * Pretty printing uses a rectangular display area, characterized
  -- * by its width, height, and offset as follows.
  -- * 
  -- *                  <----------- width ------------->
  -- *                   _______________________________ 
  -- * <---- offset --->|                               |   ^
  -- *                  |                               |   |
  -- *                  |                               | Height
  -- *                  |                               |   |
  -- *                  |                               |   v
  -- *                   ------------------------------- 
  -- *
  --  

  -- * Pretty print type tau or term t on file f
  -- * - width, height, offset define the print area
  -- * - f = output file to use. 
  -- *   f must be open and writable.
  -- *
  -- * - return -1 on error
  -- * - return 0 otherwise.
  -- *
  -- * - possible error report for yices_pp_type
  -- *    code = INVALID_TYPE
  -- *    type1 = tau
  -- *
  -- * - possible error report for yices_pp_term
  -- *    code = INVALID_TERM
  -- *    term1 = t
  -- *
  -- * - other errors (for both)
  -- *    code = OUTPUT_ERROR if writing to file f failed.
  -- *    in this case, errno, perror, etc. can be used for diagnostic.
  --  

   function yices_pp_type
     (arg1 : access stdio_h.FILE;
      arg2 : yices_types_h.type_t;
      arg3 : utypes_uuint32_t_h.uint32_t;
      arg4 : utypes_uuint32_t_h.uint32_t;
      arg5 : utypes_uuint32_t_h.uint32_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1469
   pragma Import (C, yices_pp_type, "yices_pp_type");

   function yices_pp_term
     (arg1 : access stdio_h.FILE;
      arg2 : yices_types_h.term_t;
      arg3 : utypes_uuint32_t_h.uint32_t;
      arg4 : utypes_uuint32_t_h.uint32_t;
      arg5 : utypes_uuint32_t_h.uint32_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1470
   pragma Import (C, yices_pp_term, "yices_pp_term");

  --*************************
  -- *  SOME CHECKS ON TERMS  *
  -- ************************ 

  -- * Get the type of term t
  -- * return NULL_TYPE if t is not a valid term
  -- * and set the error report:
  -- *   code = INVALID_TERM
  -- *   term1 = t
  --  

   function yices_type_of_term (arg1 : yices_types_h.term_t) return yices_types_h.type_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1486
   pragma Import (C, yices_type_of_term, "yices_type_of_term");

  -- * Check the type of a term t:
  -- * - return 0 for false, 1 for true
  -- *
  -- * - term_is_arithmetic check whether t's type is either int or real
  -- * - term_is_real check whether t's type is real
  -- * - term_is_int check whether t's type is int 
  -- * - term_is_scalar check whether t has a scalar or uninterpreted type
  -- *
  -- * If t is not a valid term, the check functions return false
  -- * and set the error report as above.
  --  

   function yices_term_is_bool (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1501
   pragma Import (C, yices_term_is_bool, "yices_term_is_bool");

   function yices_term_is_int (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1502
   pragma Import (C, yices_term_is_int, "yices_term_is_int");

   function yices_term_is_real (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1503
   pragma Import (C, yices_term_is_real, "yices_term_is_real");

   function yices_term_is_arithmetic (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1504
   pragma Import (C, yices_term_is_arithmetic, "yices_term_is_arithmetic");

   function yices_term_is_bitvector (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1505
   pragma Import (C, yices_term_is_bitvector, "yices_term_is_bitvector");

   function yices_term_is_tuple (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1506
   pragma Import (C, yices_term_is_tuple, "yices_term_is_tuple");

   function yices_term_is_function (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1507
   pragma Import (C, yices_term_is_function, "yices_term_is_function");

   function yices_term_is_scalar (arg1 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1508
   pragma Import (C, yices_term_is_scalar, "yices_term_is_scalar");

  -- * Size of a bitvector term (i.e., number of bits)
  -- * - return 0 if there's an error
  -- *
  -- * Error report:
  -- * if t is not a valid term
  -- *    code = INVALID_TERM
  -- *    term1 = t
  -- * if t is not a bitvector term
  -- *    code = BITVECTOR_REQUIRED
  -- *    term1 = t
  --  

   function yices_term_bitsize (arg1 : yices_types_h.term_t) return utypes_uuint32_t_h.uint32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1523
   pragma Import (C, yices_term_bitsize, "yices_term_bitsize");

  --***************************
  -- *  CONTEXT CONFIGURATION   *
  -- ************************** 

  -- * When a context is created, it is possible to configure it to use a
  -- * specific solver or a specific combination of solvers.  It is also
  -- * possible to specify whether or not the context should support
  -- * features such as push and pop.
  -- * 
  -- * The following theory solvers are currently available:
  -- * - egraph (solver for uninterpreted functions)
  -- * - bitvector solver
  -- * - array solver
  -- * - solver for linear arithmetic based on simplex
  -- * - solver for integer difference logic (based on Floyd-Warshall)
  -- * - solver for real difference logic (also based on Floyd-Warshall)
  -- *
  -- * The following combinations of theory solvers can be used:
  -- * - no solvers at all
  -- * - egraph alone
  -- * - bitvector solver alone
  -- * - simplex solver alone
  -- * - integer Floyd-Warshall solver alone
  -- * - real Floyd-Warshall solver alone
  -- * - egraph + bitvector solver
  -- * - egraph + simplex solver
  -- * - egraph + array solver
  -- * - egraph + bitvector + array solver
  -- * - egraph + simplex + array solver
  -- * - egraph + simplex + bitvector + array solver
  -- *
  -- * If no solvers are used, the context can deal only with Boolean
  -- * formulas.
  -- *
  -- * When the simplex solver is used, it's also possible to
  -- * specify which arithmetic fragment is intended, namely:
  -- * - integer difference logic              (IDL)
  -- * - real difference logic                 (RDL)
  -- * - real linear arithmetic                (LRA)
  -- * - integer linear arithmetic             (LIA)
  -- * - mixed integer/real linear arithmetic  (LIRA)
  -- *
  -- * In addition to the solver combination, a context can be configured
  -- * for different usage:
  -- * - one-shot mode: check satisfiability of one set of formulas
  -- * - multiple checks: repeated calls to assert/check are allowed
  -- * - push/pop: push and pop are supported (implies multiple checks)
  -- * - clean interrupts are supported (implies push/pop)
  -- * Currently, the Floyd-Warshall solvers can only be used in one-shot mode.
  -- *
  -- * By default, a new solver is configured as follows:
  -- * - solvers: egraph + simplex + bitvector + array solver
  -- * - usage: push/pop supported
  -- *
  -- * To specify another configuration, one must pass a configuration
  -- * descriptor to function yices_new_context. A configuration descriptor
  -- * is an opaque structure that includes the following fields: 
  -- * - arith-fragment: either IDL, RDL, LRA, LIA, or LIRA
  -- * - uf-solver: either NONE, DEFAULT
  -- * - bv-solver: either NONE, DEFAULT
  -- * - array-solver: either NONE, DEFAULT
  -- * - arith-solver: either NONE, DEFAULT, IFW, RFW, SIMPLEX
  -- * - mode: either ONE-SHOT, MULTI-CHECKS, PUSH-POP, INTERACTIVE
  -- *
  -- * This is done as follows:
  -- * 1) allocate a configuration descriptor via yices_new_config
  -- * 2) set the configuration parameters by repeated calls to yices_set_config
  -- *    or using yices_default_config_for_logic
  -- * 3) create one or more context with this configuration by passing the 
  -- *    descriptor to yices_new_context
  -- * 4) free the configuration descriptor when it's no longer needed
  --  

  -- * Allocate a configuration descriptor:
  -- * - the descriptor is set to the default configuration
  --  

   function yices_new_config return System.Address;  -- /Users/dpereira/Provers/yices2/include/yices.h:1607
   pragma Import (C, yices_new_config, "yices_new_config");

  -- * Deletion
  --  

   procedure yices_free_config (arg1 : System.Address);  -- /Users/dpereira/Provers/yices2/include/yices.h:1613
   pragma Import (C, yices_free_config, "yices_free_config");

  -- * Set a configuration parameter:
  -- * - name = the parameter name
  -- * - value = the value
  -- *
  -- * The following table specifies the parameters and allowed values for each parameter name:
  -- *
  -- *            name    |    value            |      meaning
  -- *   ----------------------------------------------------------------------------------------
  -- *            "mode"  | "one-shot"          |  only one call to check is supported
  -- *                    |                     |
  -- *                    | "multi-checks"      |  several calls to assert and check are 
  -- *                    |                     |  possible
  -- *                    |                     | 
  -- *                    | "push-pop"          |  like multi-check and with support for
  -- *                    |                     |  retracting assertions (via push/pop)
  -- *                    |                     |
  -- *                    | "interactive"       |  like push-pop, but with automatic context clean
  -- *                    |                     |  up when search is interrupted.
  -- *   ----------------------------------------------------------------------------------------
  -- *    "uf-solver"     | "default"           |  the uf-solver is included
  -- *                    | "none"              |  no uf-solver
  -- *   ----------------------------------------------------------------------------------------
  -- *    "bv-solver"     | "default"           |  the bitvector solver is included
  -- *                    | "none"              |  no bitvector solver
  -- *   ----------------------------------------------------------------------------------------
  -- *    "array-solver"  | "default"           |  the array solver is included
  -- *                    | "none"              |  no array solver
  -- *   ----------------------------------------------------------------------------------------
  -- *    "arith-solver"  | "ifw"               |  solver for IDL, based on the Floyd-Warshall 
  -- *                    |                     |  algorithm
  -- *                    |                     |
  -- *                    | "rfw"               |  solver for RDL, based on Floyd-Warshall
  -- *                    |                     |
  -- *                    | "simplex"           |  solver for linear arithmetic, based on Simplex
  -- *                    |                     |
  -- *                    | "default"           |  same as "simplex"
  -- *                    |                     |
  -- *                    | "none"              |  no arithmetic solver
  -- *   ----------------------------------------------------------------------------------------
  -- *   "arith-fragment" | IDL                 |  integer difference logic
  -- *                    | RDL                 |  real difference logic
  -- *                    | LIA                 |  linear integer arithmetic
  -- *                    | LRA                 |  linear real arithmetic
  -- *                    | LIRA                |  mixed linear arithmetic (real + integer variables)
  -- *
  -- * 
  -- *
  -- * The function returns -1 if there's an error, 0 otherwise.
  -- *
  -- * Error codes:
  -- *  CTX_UNKNOWN_PARAMETER if name is not a known parameter name
  -- *  CTX_INVALID_PARAMETER_VALUE if name is known but value does not match the parameter type
  --  

   function yices_set_config
     (arg1 : System.Address;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1670
   pragma Import (C, yices_set_config, "yices_set_config");

  -- * Set config to a default solver combination for the given logic
  -- * - return -1 if there's an error
  -- * - return 0 otherwise
  -- *
  -- * The logic must be given as a string, using the SMT-LIB conventions.
  -- * Currently, Yices recognizes and supports the following logics:
  -- *
  -- *   QF_ABV:    arrays and bitvectors
  -- *   QF_AUFBV:  arrays, bitvectors, uninterpreted functions
  -- *   QF_AUFLIA: arrays, uninterpreted functions, and linear integer arithmetic
  -- *   QF_AX:     arrays with extensionality
  -- *   QF_BV:     bitvectors
  -- *   QF_IDL:    integer difference logic
  -- *   QF_LIA:    linear integer arithmetic
  -- *   QF_LRA:    linear real arithmetic
  -- *   QF_RDL:    real difference logic
  -- *   QF_UF:     uninterpreted functions
  -- *   QF_UFBV:   uninterpreted functions + bitvectors
  -- *   QF_UFIDL:  uninterpreted functions + integer difference logic
  -- *   QF_UFLIA:  uninterpreted functions + linear integer arithmetic
  -- *   QF_UFLRA:  uninterpreted functions + linear real arithmetic
  -- *
  -- * In all these logics, QF means quantifier-free.
  -- *
  -- * For future extensions, Yices also recognizes the following names
  -- * for logics that Yices does not support yet. (They require solvers
  -- * that can deal with quantifiers or non-linear arithmetic).
  -- *
  -- *   AUFLIA
  -- *   AUFLIRA
  -- *   AUFNIRA
  -- *   LRA
  -- *   QF_NIA
  -- *   QF_NRA
  -- *   UFLRA
  -- *   UFNIA
  -- *
  -- * 
  -- * Error codes:
  -- *  CTX_UNKNOWN_LOGIC if logic is not a valid name
  -- *  CTX_LOGIC_NOT_SUPPORTED if logic is known but not supported
  --  

   function yices_default_config_for_logic (arg1 : System.Address; arg2 : Interfaces.C.Strings.chars_ptr) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1716
   pragma Import (C, yices_default_config_for_logic, "yices_default_config_for_logic");

  --**************
  -- *  CONTEXTS   *
  -- ************* 

  -- * A context is a stack of assertions.
  -- *
  -- * The intended use is:
  -- * 1) create a context (empty)
  -- * 2) assert one or more formulas in the context.
  -- *    (it's allowed to call assert several times before check).
  -- * 3) check satisfiability
  -- * 4) if the context is satisfiable, optionally build a model
  -- * 5) reset the context or call push or pop, then go back to 2
  -- * 6) delete the context
  -- *
  -- *
  -- * A context can be in one of the following states:
  -- * 1) IDLE: this is the initial state.
  -- *    In this state, it's possible to assert formulas.
  -- *    After assertions, the status may change to UNSAT (if
  -- *    the assertions are trivially unsatisfiable). Otherwise
  -- *    the state remains IDLE.
  -- * 
  -- * 2) SEARCHING: this is the context status during search.
  -- *    The context moves into that state after a call to 'check'
  -- *    and remains in that state until the solver completes
  -- *    or the search is interrupted.
  -- *
  -- * 3) SAT/UNSAT/UNKNOWN: status returned after a search
  -- *    - UNSAT means the assertions are not satisfiable.
  -- *    - SAT means they are satisfiable.
  -- *    - UNKNOWN means that the solver could not determine whether
  -- *      the assertions are SAT or UNSAT. This may happen if 
  -- *      Yices is not complete for the specific logic used (e.g.,
  -- *      if the formula includes quantifiers).
  -- *
  -- * 4) INTERRUPTED: if the context is in the SEARCHING state,
  -- *    then it can be interrupted via a call to stop_search.
  -- *    The status INTERRUPTED indicates that.
  -- *
  -- * For fine tuning: there are options that determine which internal
  -- * simplifications are applied when formulas are asserted, and
  -- * other options to control heuristics used by the solver.
  --  

  -- * Create a new context:
  -- * - config is an optional argument that defines the context configuration
  -- * - the configuration specifies which components the context should
  -- *   include (e.g., egraph, bv_solver, simplex_solver, etc),
  -- *   and which features should be supported (e.g., whether push/pop are
  -- *   needed).
  -- *
  -- * If config is NULL, the default configuration is used:
  -- *   push/pop are enabled
  -- *   the solvers are: egraph + array solver + bv solver + simplex
  -- *   mixed real/integer arithmetic is supported
  -- *
  -- * Otherwise the context is configured as specified by config, provided
  -- * that configuration is valid.
  -- *
  -- * If there's an error (i.e., the configuration is not supported), the
  -- * function returns NULL and set an error code: CTX_INVALID_CONFIG.
  --  

   function yices_new_context (arg1 : System.Address) return System.Address;  -- /Users/dpereira/Provers/yices2/include/yices.h:1787
   pragma Import (C, yices_new_context, "yices_new_context");

  -- * Deletion
  --  

   procedure yices_free_context (arg1 : System.Address);  -- /Users/dpereira/Provers/yices2/include/yices.h:1793
   pragma Import (C, yices_free_context, "yices_free_context");

  -- * Get status: return the context's status flag
  -- * - return one of the codes defined in yices_types.h, 
  -- *   namely one of the constants
  -- *
  -- *    STATUS_IDLE 
  -- *    STATUS_SEARCHING
  -- *    STATUS_UNKNOWN
  -- *    STATUS_SAT
  -- *    STATUS_UNSAT
  -- *    STATUS_INTERRUPTED
  -- *
  --  

   function yices_context_status (arg1 : System.Address) return yices_types_h.smt_status_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1809
   pragma Import (C, yices_context_status, "yices_context_status");

  -- * Reset: remove all assertions and restore ctx's 
  -- * status to IDLE.
  --  

   procedure yices_reset_context (arg1 : System.Address);  -- /Users/dpereira/Provers/yices2/include/yices.h:1816
   pragma Import (C, yices_reset_context, "yices_reset_context");

  -- * Push: mark a backtrack point
  -- * - return 0 if this operation is supported by the context
  -- *         -1 otherwise
  -- *
  -- * Error report:
  -- * - if the context is not configured to support push/pop
  -- *   code = CTX_OPERATION_NOT_SUPPORTED
  -- * - if the context status is UNSAT or SEARCHING or INTERRUPTED
  -- *   code = CTX_INVALID_OPERATION
  --  

   function yices_push (arg1 : System.Address) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1830
   pragma Import (C, yices_push, "yices_push");

  -- * Pop: backtrack to the previous backtrack point (i.e., the matching
  -- * call to yices_push).
  -- * - return 0 if the operation succeeds, -1 otherwise.
  -- *
  -- * Error report:
  -- * - if the context is not configured to support push/pop
  -- *   code = CTX_OPERATION_NOT_SUPPORTED
  -- * - if there's no matching push (i.e., the context stack is empty)
  -- *   or if the context's status is SEARCHING or INTERRUPTED
  -- *   code = CTX_INVALID_OPERATION
  --  

   function yices_pop (arg1 : System.Address) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1845
   pragma Import (C, yices_pop, "yices_pop");

  -- * Several options determine how much simplification is performed
  -- * when formulas are asserted. It's best to leave them untouched
  -- * unless you really know what you're doing.
  -- *
  -- * The following functions selectively enable/disable a preprocessing
  -- * option. Current options include:
  -- *   var-elim: whether to eliminate variables by substitution
  -- *   arith-elim: more variable elimination for arithmetic (Gaussian elimination)
  -- *   flatten: whether to flatten nested (or ...)
  -- *     (e.g., turn (or (or a b) (or c d) ) to (or a b c d))
  -- *   learn_eq: enable/disable heuristics to learn implied equalities
  -- *   keep_ite: whether to eliminate term if-then-else or keep them as terms
  -- *
  -- * The following functions can be used to enable or disable one of these options.
  -- * - return code: -1 if there's an error, 0 otherwise.
  -- *
  -- * Error codes:
  -- *  CTX_UNKNOWN_PARAMETER if the option name is not one of the above.
  --  

   function yices_context_enable_option (arg1 : System.Address; arg2 : Interfaces.C.Strings.chars_ptr) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1868
   pragma Import (C, yices_context_enable_option, "yices_context_enable_option");

   function yices_context_disable_option (arg1 : System.Address; arg2 : Interfaces.C.Strings.chars_ptr) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1869
   pragma Import (C, yices_context_disable_option, "yices_context_disable_option");

  -- * Assert formula t in ctx
  -- * - ctx status must be IDLE or UNSAT or SAT or UNKNOWN
  -- * - t must be a boolean term
  -- *
  -- * If ctx's status is UNSAT, nothing is done.
  -- * 
  -- * If ctx's status is IDLE, SAT, or UNKNOWN, then the formula is
  -- * simplified and asserted in the context. The context status is
  -- * changed to UNSAT if the formula is simplified to 'false' or
  -- * to IDLE otherwise.
  -- * 
  -- * This returns 0 if there's no error or -1 if there's an error.
  -- * 
  -- * Error report:
  -- * if t is invalid
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * if t is not boolean
  -- *   code = TYPE_MISMATCH
  -- *   term1 = t
  -- *   type1 = bool (expected type)
  -- * if ctx's status is not IDLE or UNSAT or SAT or UNKNOWN
  -- *   code = CTX_INVALID_OPERATION
  -- * if ctx's status is neither IDLE nor UNSAT, and the context is 
  -- * not configured for multiple checks
  -- *   code = CTX_OPERATION_NOT_SUPPORTED
  -- *
  -- * Other error codes are defined in yices_types.h to report that t is
  -- * outside the logic supported by ctx.
  --  

   function yices_assert_formula (arg1 : System.Address; arg2 : yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1904
   pragma Import (C, yices_assert_formula, "yices_assert_formula");

  -- * Assert an array of n formulas t[0 ... n-1]
  -- * - ctx's status must be IDLE or UNSAT or SAT or UNKNOWN
  -- * - all t[i]'s must be valid boolean terms.
  -- *
  -- * The function returns -1 on error, 0 otherwise.
  -- *
  -- * The error report is set as in the previous function.
  --  

   function yices_assert_formulas
     (arg1 : System.Address;
      arg2 : utypes_uuint32_t_h.uint32_t;
      arg3 : access yices_types_h.term_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1916
   pragma Import (C, yices_assert_formulas, "yices_assert_formulas");

  -- * Check satisfiability: check whether the assertions stored in ctx
  -- * are satisfiable.  
  -- * - params is an optional structure that stores heuristic parameters.
  -- * - if params is NULL, default parameter settings are used.
  -- *
  -- * It's better to keep params=NULL unless you encounter performance
  -- * problems.  Then you may want to play with the heuristics to see if
  -- * performance improves.
  -- *
  -- * The behavior and returned value depend on ctx's current status:
  -- *
  -- * 1) If ctx's status is SAT, UNSAT, or UNKNOWN, the function 
  -- *    does nothing and just returns the status.
  -- *
  -- * 2) If ctx's status is IDLE, then the solver searches for a
  -- *    satisfying assignment. If param != NULL, the search parameters
  -- *    defined by params are used.
  -- * 
  -- *    The function returns one of the following codes:
  -- *    - SAT: the context is satisfiable
  -- *    - UNSAT: the context is not satisfiable
  -- *    - UNKNOWN: satisfiability can't be proved or disproved 
  -- *    - INTERRUPTED: the search was interrupted
  -- *
  -- *    The returned status is also stored as the new ctx's status flag,
  -- *    with the following exception. If the context was built with 
  -- *    mode = INTERACTIVE and the search was interrupted, then the
  -- *    function returns INTERRUPTED but the ctx's state is restored to
  -- *    what it was before the call to 'yices_check_context' and the
  -- *    status flag is reset to IDLE.
  -- *
  -- * 3) Otherwise, the function does nothing and returns 'STATUS_ERROR', 
  -- *    it also sets the yices error report (code = CTX_INVALID_OPERATION).
  --  

   function yices_check_context (arg1 : System.Address; arg2 : System.Address) return yices_types_h.smt_status_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1954
   pragma Import (C, yices_check_context, "yices_check_context");

  -- * Add a blocking clause: this is intended to help enumerate different models
  -- * for a set of assertions.
  -- * - if ctx's status is SAT or UNKNOWN, then a new clause is added to ctx
  -- *   to remove the current truth assignment from the search space. After this
  -- *   clause is added, the next call to yices_check_context will either produce 
  -- *   a different truth assignment (hence a different model) or return UNSAT.
  -- *
  -- * - ctx's status flag is updated to IDLE (if the new clause is not empty) or 
  -- *   to UNSAT (if the new clause is the empty clause).
  -- *
  -- * Return code: 0 if there's no error, -1 if there's an error.
  -- *
  -- * Error report:
  -- * if ctx's status is different from SAT or UNKNOWN
  -- *    code = CTX_INVALID_OPERATION
  -- * if ctx is not configured to support multiple checks
  -- *    code = CTX_OPERATION_NOT_SUPPORTED
  --  

   function yices_assert_blocking_clause (arg1 : System.Address) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:1976
   pragma Import (C, yices_assert_blocking_clause, "yices_assert_blocking_clause");

  -- * Interrupt the search:
  -- * - this can be called from a signal handler to stop the search,
  -- *   after a call to yices_check_context to interrupt the solver.
  -- *
  -- * If ctx's status is SEARCHING, then the current search is
  -- * interrupted. Otherwise, the function does nothing.
  --  

   procedure yices_stop_search (arg1 : System.Address);  -- /Users/dpereira/Provers/yices2/include/yices.h:1987
   pragma Import (C, yices_stop_search, "yices_stop_search");

  -- * SEARCH PARAMETERS
  --  

  -- * A parameter record is an opaque object that stores various
  -- * search parameters and options that control the heuristics used by
  -- * the solver. 
  -- *
  -- * A parameter structure is created by calling 
  -- * - yices_new_param_structure(void)
  -- * This returns a parameter structure initialized with default
  -- * settings.
  -- *
  -- * Then individual parameters can be set using function
  -- * - yices_set_param(s, name, value) where both name and value are 
  -- *   character strings.
  -- * - an unknown/unsupported parameter name is ignored
  -- *
  -- * Then the param object can be passed on as argument to yices_check_context.
  -- *
  -- * When it's no longer needed, the object must be deleted by 
  -- * calling yices_free_param_structure(param).
  --  

  -- * Return a parameter record initialized with default settings.
  --  

   function yices_new_param_record return System.Address;  -- /Users/dpereira/Provers/yices2/include/yices.h:2020
   pragma Import (C, yices_new_param_record, "yices_new_param_record");

  -- * Set a parameter in record p
  -- * - pname = parameter name
  -- * - value = setting
  -- *
  -- * TBD: describe the parameters and the range of values for each.
  -- *
  -- * Return -1 if there's an error, 0 otherwise
  --  

   function yices_set_param
     (arg1 : System.Address;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2032
   pragma Import (C, yices_set_param, "yices_set_param");

  -- * Delete the record param
  --  

   procedure yices_free_param_record (arg1 : System.Address);  -- /Users/dpereira/Provers/yices2/include/yices.h:2038
   pragma Import (C, yices_free_param_record, "yices_free_param_record");

  --*************
  -- *   MODELS   *
  -- ************ 

  -- * Build a model from ctx 
  -- * - keep_subst indicates whether the model should include
  -- *   the eliminated variables: 
  -- *   keep_subst = 0 means don't keep substitutions,
  -- *   keep_subst != 0 means keep them
  -- * - ctx status must be SAT or UNKNOWN
  -- *
  -- * The function returns NULL if the status isn't SAT or UNKNOWN 
  -- * and sets an error report (code = CTX_INVALID_OPERATION).
  -- *
  -- * When assertions are added to the context, the simplifications may
  -- * eliminate variables (cf. simplification options above).  The flag
  -- * 'keep_subst' indicates whether the model should keep track of these
  -- * eliminated variables and include their value.
  -- *
  -- * Example: after the following assertions 
  -- *
  -- *    (= x (bv-add y z))
  -- *    (bv-gt y 0b000)
  -- *    (bg-gt z 0b000)
  -- *
  -- * variable 'x' gets eliminated. Then a call to 'check_context' will
  -- * return SAT and we can ask for a model 'M'
  -- * - if 'keep_subst' is false then the value of 'x' in 'M' is unavailable.
  -- * - if 'keep_subst' is true then the value of 'x' in 'M' is computed,
  -- *   based on the value of 'y' and 'z' in 'M'.
  -- *
  -- * It's always better to set 'keep_subst' true. The only exceptions
  -- * are some of the large SMT_LIB benchmarks where millions of variables
  -- * are eliminated.  In such cases, it saves memory to set 'keep_subst'
  -- * false, and model construction is faster too.
  --  

   function yices_get_model (arg1 : System.Address; arg2 : sys_utypes_uint32_t_h.int32_t) return System.Address;  -- /Users/dpereira/Provers/yices2/include/yices.h:2081
   pragma Import (C, yices_get_model, "yices_get_model");

  -- * Delete model mdl
  --  

   procedure yices_free_model (arg1 : System.Address);  -- /Users/dpereira/Provers/yices2/include/yices.h:2087
   pragma Import (C, yices_free_model, "yices_free_model");

  -- * Print model mdl on FILE f
  -- * - f must be open/writable
  --  

   procedure yices_print_model (arg1 : access stdio_h.FILE; arg2 : System.Address);  -- /Users/dpereira/Provers/yices2/include/yices.h:2094
   pragma Import (C, yices_print_model, "yices_print_model");

  -- * Pretty printing:
  -- * - f = output file to use
  -- * - witdh, height, offset define the print area
  -- * 
  -- * return -1 on error, 0 otherwise
  -- *
  -- * On error:
  -- *   code = OUTPUT_ERROR (means that writing to f failed)
  -- *   in this case, errno, perror, etc. can be used for diagnostic.
  --  

   function yices_pp_model
     (arg1 : access stdio_h.FILE;
      arg2 : System.Address;
      arg3 : utypes_uuint32_t_h.uint32_t;
      arg4 : utypes_uuint32_t_h.uint32_t;
      arg5 : utypes_uuint32_t_h.uint32_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2108
   pragma Import (C, yices_pp_model, "yices_pp_model");

  -- * Evaluation functions. Once a model is constructed, it's possible
  -- * to query for the value of a term t in that model. The following
  -- * functions do that for different term types.
  -- * 
  -- * The evaluation functions return -1 if the value of t is unknown
  -- * or can't be computed in the model. Otherwise, they return 0.
  -- *
  -- * Possible error codes:
  -- * If t is not valid:
  -- *   code = INVALID_TERM
  -- *   term1 = t
  -- * If t contains a subterm whose value is not known
  -- *   code = EVAL_UNKNOWN_TERM
  -- * If t contains a free variable
  -- *   code = EVAL_FREEVAR_IN_TERM
  -- * If t contains quantifier(s)
  -- *   code = EVAL_QUANTIFIER
  -- * If t contains lamnda terms
  -- *   code = EVAL_LAMBDA
  -- * If the evaluation fails for other reasons:
  -- *   code = EVAL_FAILED
  -- *
  -- * Other codes are possible depending on the specific evaluation function.
  --  

  -- * Value of boolean term t: returned as an integer val
  -- * - val = 0 means t is false in mdl
  -- * - val = 1 means t is true in mdl
  -- *
  -- * Error codes:
  -- * If t is not boolean
  -- *   code = TYPE_MISMATCH
  -- *   term1 = t
  -- *   type1 = bool (expected type)
  -- * + the other evaluation error codes above.
  --  

   function yices_get_bool_value
     (arg1 : System.Address;
      arg2 : yices_types_h.term_t;
      arg3 : access sys_utypes_uint32_t_h.int32_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2149
   pragma Import (C, yices_get_bool_value, "yices_get_bool_value");

  -- * Value of arithmetic term t: it can be returned as an integer, a
  -- * rational (pair num/den), converted to a double, or using the GMP
  -- * mpz_t and mpq_t representations.
  -- *
  -- * Error codes:
  -- * If t is not an arithmetic term:
  -- *   code = ARITH_TERM_REQUIRED
  -- *   term1 = t
  -- * If t's value does not fit in the *val object
  -- *   code = EVAL_OVERFLOW
  --  

   function yices_get_int32_value
     (arg1 : System.Address;
      arg2 : yices_types_h.term_t;
      arg3 : access sys_utypes_uint32_t_h.int32_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2164
   pragma Import (C, yices_get_int32_value, "yices_get_int32_value");

   function yices_get_int64_value
     (arg1 : System.Address;
      arg2 : yices_types_h.term_t;
      arg3 : access sys_utypes_uint64_t_h.int64_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2165
   pragma Import (C, yices_get_int64_value, "yices_get_int64_value");

   function yices_get_rational32_value
     (arg1 : System.Address;
      arg2 : yices_types_h.term_t;
      arg3 : access sys_utypes_uint32_t_h.int32_t;
      arg4 : access utypes_uuint32_t_h.uint32_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2166
   pragma Import (C, yices_get_rational32_value, "yices_get_rational32_value");

   function yices_get_rational64_value
     (arg1 : System.Address;
      arg2 : yices_types_h.term_t;
      arg3 : access sys_utypes_uint64_t_h.int64_t;
      arg4 : access utypes_uuint64_t_h.uint64_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2167
   pragma Import (C, yices_get_rational64_value, "yices_get_rational64_value");

   function yices_get_double_value
     (arg1 : System.Address;
      arg2 : yices_types_h.term_t;
      arg3 : access double) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2168
   pragma Import (C, yices_get_double_value, "yices_get_double_value");

  -- * Value of bitvector term t in mdl
  -- * - the value is returned in array val
  -- * - val must be an integer array of sufficient size to store all bits of t
  -- * - bit i of t is stored in val[i] (val[i] is either 0 or 1)
  -- * - the value is returned using small-endian convention:
  -- *    val[0] is the low-order bit
  -- *    ...
  -- *    val[n-1] is the high-order bit 
  -- *
  -- * If t is not a bitvector term
  -- *   code = BITVECTOR_REQUIRED
  -- *   term1 = t
  --  

   function yices_get_bv_value
     (arg1 : System.Address;
      arg2 : yices_types_h.term_t;
      arg3 : access sys_utypes_uint32_t_h.int32_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2190
   pragma Import (C, yices_get_bv_value, "yices_get_bv_value");

  -- * Value of term t of uninterpreted or scalar type
  -- * - the value is returned as a constant index in *val 
  -- *   (with the same meaning as in function yices_constant):
  -- * - if t has type tau and tau is a scalar type of size n then 
  -- *   the function returns an index k between 0 and n-1
  -- * - if tau is an uninterpreted type, then the function returns an
  -- *   integer index k
  -- * 
  -- * The index k is a unique identifier: if two terms t1 and t2 are not
  -- * equal in the model mdl, then their values will be distinct indices k.
  -- *
  -- * Error codes:
  -- * - if t does not have a scalar or uninterpreted type:
  -- *   code = SCALAR_TERM_REQUIRED
  -- *   term1 = t
  --  

   function yices_get_scalar_value
     (arg1 : System.Address;
      arg2 : yices_types_h.term_t;
      arg3 : access sys_utypes_uint32_t_h.int32_t) return sys_utypes_uint32_t_h.int32_t;  -- /Users/dpereira/Provers/yices2/include/yices.h:2210
   pragma Import (C, yices_get_scalar_value, "yices_get_scalar_value");

  -- close extern "C" {  
end yices_h;
