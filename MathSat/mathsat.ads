pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
-- with sys_utypes_usize_t_h;
with Interfaces.C.Strings;
-- limited with stdio_h;
-- limited with gmp_h;

package Mathsat is

   --  arg-macro: function MSAT_ERROR_CONFIG (cfg)
   --    return (cfg).repr = NULL;
   --  arg-macro: function MSAT_ERROR_ENV (env)
   --    return (env).repr = NULL;
   --  arg-macro: function MSAT_ERROR_TERM (term)
   --    return (term).repr = NULL;
   --  arg-macro: function MSAT_MAKE_ERROR_TERM (term)
   --    return (term).repr := NULL;
   --  arg-macro: function MSAT_ERROR_DECL (decl)
   --    return (decl).repr = NULL;
   --  arg-macro: function MSAT_ERROR_TYPE (tp)
   --    return (tp).repr = NULL;
   --  arg-macro: function MSAT_ERROR_MODEL_ITERATOR (iter)
   --    return (iter).repr = NULL;
   --  arg-macro: function MSAT_ERROR_PROOF_MANAGER (mgr)
   --    return (mgr).repr = NULL;
   --  arg-macro: function MSAT_ERROR_PROOF (p)
   --    return (p).repr = NULL;
  
   -- Data types and special values
   type Msat_Config is record
      Repr : System.Address ;  
   end record;
   pragma Convention(C_Pass_By_Copy,Msat_Config) ;  

   -- MathSAT environment.
   type Msat_Env is record
      Repr : System.Address ;  
   end record;
   pragma Convention(C_Pass_By_Copy,Msat_Env) ;  

   -- MathSAT term.
   -- 
   -- A term is a constant, a number, an atom, or an arbitrary boolean
   -- combination of those. It is the basic block of MathSAT abstract syntax
   -- trees.
   type Msat_Term is record
      Repr : System.Address ;  
   end record;
   pragma Convention(C_Pass_By_Copy,Msat_Term) ;  

   -- MathSAT declaration.
   -- 
   --  Declaration of constants and uninterpreted functions/predicates.
   type Msat_Decl is record
      Repr : System.Address ;
   end record;
   pragma Convention(C_Pass_By_Copy,Msat_Decl) ;

   -- MathSAT data types.
   type Msat_Type is record
      Repr : System.Address ;
   end record;
   pragma Convention(C_Pass_By_Copy Msat_Type) ;  

   -- MathSAT result.
   --  
   -- Unknown.  
   -- Unsatisfiable.  
   -- Satisfiable. 
   type Msat_Result is  ( MSAT_UNKNOWN , MSAT_UNSAT , MSAT_SAT ) ;
   for Msat_Result use  ( -1 , 0 , 1 );
   pragma Convention(C,Msat_Result) ;
   

   -- MathSAT truth value.
   type Msat_Truth_Value is  ( MSAT_UNDEF , MSAT_FALSE , MSAT_TRUE ) ; 
   for Msat_Truth_Value use  ( -1 , 0 , 1 ) ;
   pragma Convention(C,Msat_Truth_Value) ;

   -- MathSAT symbol tag.
   type Msat_Symbol_Tag is 
     ( MSAT_TAG_ERROR,
       MSAT_TAG_UNKNOWN,
       MSAT_TAG_TRUE,
       MSAT_TAG_FALSE,
       MSAT_TAG_AND,
       MSAT_TAG_OR,
       MSAT_TAG_NOT,
       MSAT_TAG_IFF,
       MSAT_TAG_PLUS,
       MSAT_TAG_TIMES,
       MSAT_TAG_FLOOR,
       MSAT_TAG_LEQ,
       MSAT_TAG_EQ,
       MSAT_TAG_ITE,
       MSAT_TAG_INT_MOD_CONGR,
       MSAT_TAG_BV_CONCAT,
       MSAT_TAG_BV_EXTRACT,
       MSAT_TAG_BV_NOT,
       MSAT_TAG_BV_AND,
       MSAT_TAG_BV_OR,
       MSAT_TAG_BV_XOR,
       MSAT_TAG_BV_ULT,
       MSAT_TAG_BV_SLT,
       MSAT_TAG_BV_ULE,
       MSAT_TAG_BV_SLE,
       MSAT_TAG_BV_COMP,
       MSAT_TAG_BV_NEG,
       MSAT_TAG_BV_ADD,
       MSAT_TAG_BV_SUB,
       MSAT_TAG_BV_MUL,
       MSAT_TAG_BV_UDIV,
       MSAT_TAG_BV_SDIV,
       MSAT_TAG_BV_UREM,
       MSAT_TAG_BV_SREM,
       MSAT_TAG_BV_LSHL,
       MSAT_TAG_BV_LSHR,
       MSAT_TAG_BV_ASHR,
       MSAT_TAG_BV_ROL,
       MSAT_TAG_BV_ROR,
       MSAT_TAG_BV_ZEXT,
       MSAT_TAG_BV_SEXT,
       MSAT_TAG_ARRAY_READ,
       MSAT_TAG_ARRAY_WRITE,
       MSAT_TAG_FP_EQ,
       MSAT_TAG_FP_LT,
       MSAT_TAG_FP_LE,
       MSAT_TAG_FP_NEG,
       MSAT_TAG_FP_ADD,
       MSAT_TAG_FP_SUB,
       MSAT_TAG_FP_MUL,
       MSAT_TAG_FP_DIV,
       MSAT_TAG_FP_CAST,
       MSAT_TAG_FP_FROM_SBV,
       MSAT_TAG_FP_FROM_UBV,
       MSAT_TAG_FP_TO_BV,
       MSAT_TAG_FP_AS_IEEEBV,
       MSAT_TAG_FP_ISNAN,
       MSAT_TAG_FP_ISINF,
       MSAT_TAG_FP_ISZERO,
       MSAT_TAG_FP_ISSUBNORMAL,
       MSAT_TAG_FP_FROM_IEEEBV ) ;
   
   for Msat_Symbol_Tag'Size use  Interfaces.C.Unsigned'Size ;
   
   for Msat_Symbol_Tag use  
     ( MSAT_TAG_ERROR => -1,
       MSAT_TAG_UNKNOWN => 0,
       MSAT_TAG_TRUE => 1,
       MSAT_TAG_FALSE => 2,
       MSAT_TAG_AND => 3,
       MSAT_TAG_OR => 4,
       MSAT_TAG_NOT => 5,
       MSAT_TAG_IFF => 6,
       MSAT_TAG_PLUS => 7,
       MSAT_TAG_TIMES => 8,
       MSAT_TAG_FLOOR => 9,
       MSAT_TAG_LEQ => 10,
       MSAT_TAG_EQ => 11,
       MSAT_TAG_ITE => 12,
       MSAT_TAG_INT_MOD_CONGR => 13,
       MSAT_TAG_BV_CONCAT => 14,
       MSAT_TAG_BV_EXTRACT => 15,
       MSAT_TAG_BV_NOT => 16,
       MSAT_TAG_BV_AND => 17,
       MSAT_TAG_BV_OR => 18,
       MSAT_TAG_BV_XOR => 19,
       MSAT_TAG_BV_ULT => 20,
       MSAT_TAG_BV_SLT => 21,
       MSAT_TAG_BV_ULE => 22,
       MSAT_TAG_BV_SLE => 23,
       MSAT_TAG_BV_COMP => 24,
       MSAT_TAG_BV_NEG => 25,
       MSAT_TAG_BV_ADD => 26,
       MSAT_TAG_BV_SUB => 27,
       MSAT_TAG_BV_MUL => 28,
       MSAT_TAG_BV_UDIV => 29,
       MSAT_TAG_BV_SDIV => 30,
       MSAT_TAG_BV_UREM => 31,
       MSAT_TAG_BV_SREM => 32,
       MSAT_TAG_BV_LSHL => 33,
       MSAT_TAG_BV_LSHR => 34,
       MSAT_TAG_BV_ASHR => 35,
       MSAT_TAG_BV_ROL => 36,
       MSAT_TAG_BV_ROR => 37,
       MSAT_TAG_BV_ZEXT => 38,
       MSAT_TAG_BV_SEXT => 39,
       MSAT_TAG_ARRAY_READ => 40,
       MSAT_TAG_ARRAY_WRITE => 41,
       MSAT_TAG_FP_EQ => 42,
       MSAT_TAG_FP_LT => 43,
       MSAT_TAG_FP_LE => 44,
       MSAT_TAG_FP_NEG => 45,
       MSAT_TAG_FP_ADD => 46,
       MSAT_TAG_FP_SUB => 47,
       MSAT_TAG_FP_MUL => 48,
       MSAT_TAG_FP_DIV => 49,
       MSAT_TAG_FP_CAST => 50,
       MSAT_TAG_FP_FROM_SBV => 51,
       MSAT_TAG_FP_FROM_UBV => 52,
       MSAT_TAG_FP_TO_BV => 53,
       MSAT_TAG_FP_AS_IEEEBV => 54,
       MSAT_TAG_FP_ISNAN => 55,
       MSAT_TAG_FP_ISINF => 56,
       MSAT_TAG_FP_ISZERO => 57,
       MSAT_TAG_FP_ISSUBNORMAL => 58,
       MSAT_TAG_FP_FROM_IEEEBV => 59 ) ;
   
   pragma Convention(C,Msat_Symbol_Tag) ;
   
   
  -- Callback function to be notified about models found by ::msat_all_sat
   type Msat_All_Sat_Model_Callback is access function( Arg1 : access Msat_Term ; 
							Arg2 : Interfaces.C.Int ; 
							Arg3 : System.Address) return Interfaces.C.Int ;
   pragma Convention (C,Msat_All_Sat_Model_Callback) ;

   -- MathSAT model iterator.
   type Msat_Model_Iterator is record
      Repr : System.Address ;  
   end record;
   pragma Convention (C_Pass_By_Copy,Msat_Model_Iterator) ;

  -- Callback function to be notified about models found by
  --  ::msat_solve_diversify
   type Msat_Solve_Diversify_Model_Callback is access function ( Arg1 : Msat_Model_Iterator ;
								 Arg2 : System.Address ) return Interfaces.C.Int ;
   pragma Convention (C, Msat_Solve_Diversify_Model_Callback) ; 

   -- MathSAT status for the callback passed to ::msat_visit_term
   type Msat_Visit_Status is 
     (MSAT_VISIT_PROCESS,
      MSAT_VISIT_SKIP,
      MSAT_VISIT_ABORT);
   pragma Convention(C,Msat_Visit_Status) ;

   -- Callback function to visit a term DAG with ::msat_visit_term
   type Msat_Visit_Term_Callback is access function( Arg1 : Msat_Env ;
						     Arg2 : Msat_Term ;
						     Arg3 : Interfaces.C.Int ;
						     Arg4 : System.Address ) return Msat_Visit_Status ;
   pragma Convention (C,Msat_Visit_Term_Callback) ;

   -- Custom test for early termination of search
   type Msat_Termination_Test is access function ( Arg1 : System.Address ) return Interfaces.C.Int ;
   pragma Convention (C,Msat_Termination_Test); 

   -- Manager for proofs generated by MathSAT
   type Msat_Proof_Manager is record
      Repr : System.Address;  
   end record;
   pragma Convention (C_Pass_By_Copy,Msat_Proof_Manager) ;  

   -- Proof objects created by MathSAT
   type Msat_Proof is record
      Repr : System.Address;
   end record;
   pragma Convention (C_Pass_By_Copy,Msat_Proof);  -- mathsat.h:239

   -- External Boolean unsat core extraction function, to be used with
   -- ::msat_get_unsat_core_ext.
   type Msat_Ext_Unsat_Core_Extractor is access function( Arg1, Arg2  : access Interfaces.C.Int ;
							  Arg3 : access sys_utypes_usize_t_h.size_t;
							  Arg4 : System.Address ) return Interfaces.C.Int ;
   pragma Convention (C,Msat_Ext_Unsat_Core_Extractor); 

  --*
  -- * \brief Error checking for configurations
  -- *
  -- * Use this macro to check whether returned values of type ::msat_config are
  -- * valid
  --  

  --*
  -- * \brief Error checking for environments
  -- *
  -- * Use this macro to check whether returned values of type ::msat_env are valid
  --  

  --*
  -- * \brief Error checking for terms
  -- *
  -- * Use this macro to check whether returned values of type ::msat_term are valid
  --  

  --*
  -- * \brief Sets given term to be an error term
  -- *
  -- * Use this macro to make terms error terms.
  --  

  --*
  -- * \brief Error checking for declarations
  -- *
  -- * Use this macro to check whether returned values of type ::msat_decl are valid
  --  

  --*
  -- * \brief Error checking for data types
  -- *
  -- * Use this macro to check whether returned values of type ::msat_type are valid
  --  

  --*
  -- * \brief Error checking for model iterators
  -- *
  -- * Use this macro to check whether returned values of type
  -- * ::msat_model_iterator are valid
  --  

  --*
  -- * \brief Error checking for proof managers
  -- *
  -- * Use this macro to check whether returned values of type
  -- * ::msat_proof_manager are valid
  --  

  --*
  -- * \brief Error checking for proofs
  -- *
  -- * Use this macro to check whether returned values of type
  -- * ::msat_proof are valid
  --  

   -- Function for deallocating the memory accessible by pointers returned by MathSAT
   procedure Msat_Free( Arg1 : System.Address ) ;
   pragma Import(C,Msat_Free,"msat_free") ;

   -- Gets the current MathSAT version.
   function Msat_Get_Version return Interfaces.C.Strings.Chars_Ptr ;
   pragma Import(C,Msat_Get_Version,"msat_get_version") ; 

   -- Retrieves the last error message generated while operating in the
   -- given enviroment.
   function Msat_Last_Error_Message( Arg1 : Msat_Env ) return Interfaces.C.Strings.Chars_Ptr ; 
   pragma Import(C,Msat_Last_Error_Message,"msat_last_error_message") ;
   
   --------------------------
   -- Environment creation --
   --------------------------  

   -- Creates a new MathSAT configuration.
   function Msat_Create_Config return Msat_Config ;
   pragma Import (C,Msat_Create_Config,"msat_create_config") ;

   -- Creates a new MathSAT configuration with the default settings for
   -- the given logic.
   function Msat_Create_Default_Config( Arg1 : Interfaces.C.Strings.Chars_Ptr ) return Msat_Config ;
   pragma Import(C,Msat_Create_Default_Config,"msat_create_default_config");

   -- Creates a new MathSAT configuration by parsing the given data.
   function msat_parse_config (arg1 : Interfaces.C.Strings.chars_ptr) return msat_config;  -- mathsat.h:391
   pragma Import (C, msat_parse_config, "msat_parse_config");

   -- Creates a new MathSAT configuration by parsing the given file.
   -- 
   -- See ::msat_parse_config for the format of the config file.
   function Msat_Parse_Config_File( Arg1 : access stdio_h.FILE ) return Msat_Config ;
   pragma Import(C,Msat_Parse_Config_File,"msat_parse_config_file") ;

   -- Destroys a configuration.
   procedure Msat_Destroy_Config( Arg1 : Msat_Config ) ;
   pragma Import(C,Msat_Destroy_Config,"msat_destroy_config") ;

  --*
  -- * \brief Creates a new MathSAT environment from the given configuration.
  -- * \param cfg The configuration to use.
  -- * \return A new environment. Use ::MSAT_ERROR_ENV to check for errors
  --  

   function msat_create_env (arg1 : msat_config) return msat_env;  -- mathsat.h:419
   pragma Import (C, msat_create_env, "msat_create_env");

  --*
  -- * \brief Creates an environment that can share terms with its \a sibling
  -- * \param cfg The configuration to use.
  -- * \param sibling The environment with which to share terms.
  -- * \return A new environment. Use ::MSAT_ERROR_ENV to check for errors
  --  

   function Msat_Create_Shared_Env( Arg1 : in Msat_Config ; Arg2 : in Msat_Env ) return Msat_Env ;  -- mathsat.h:427
   pragma Import (C, Msat_Create_Shared_Env, "msat_create_shared_env");

  --*
  -- * \brief Destroys an environment.
  -- * \param e The environment to destroy.
  --  

   procedure msat_destroy_env (arg1 : msat_env);  -- mathsat.h:433
   pragma Import (C, msat_destroy_env, "msat_destroy_env");

  --*
  -- * \brief Performs garbage collection on the given environment
  -- *
  -- * This function will perform garbage collection on the given environment.
  -- * All the internal caches of the environment will be cleared (including those
  -- * in the active solvers and preprocessors). If the environment is not shared,
  -- * all the terms that are not either in \a tokeep or in the current asserted
  -- * formulas will be deleted.
  -- *
  -- * \param env The environment in which to operate.
  -- * \param tokeep List of terms to not delete.
  -- * \param num_tokeep Size of the \a tokeep array.
  -- * \return zero on success, nonzero on error.
  --  

   function msat_gc_env
     (arg1 : msat_env;
      arg2 : access msat_term;
      arg3 : sys_utypes_usize_t_h.size_t) return int;  -- mathsat.h:449
   pragma Import (C, msat_gc_env, "msat_gc_env");

  --*
  -- * \brief Sets an option in the given configuration.
  -- *
  -- * Notice that the best thing to do is set options right after having created
  -- * a configuration, before creating an environment with it. The library tries to
  -- * capture and report errors, but it does not always succeed.
  -- *
  -- * \param cfg The configuration in which to operate.
  -- * \param option The name of the option to set.
  -- * \param value The value for the option. For boolean options, use "true" or
  -- *        "false" (case matters). For flags, the value can be anything.
  -- * \return zero on success, nonzero on error.
  --  

   function msat_set_option
     (arg1 : msat_config;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : Interfaces.C.Strings.chars_ptr) return int;  -- mathsat.h:464
   pragma Import (C, msat_set_option, "msat_set_option");

  --*
  -- * \brief Installs a custom termination test in the given environment
  -- *
  -- * The \a func function will be polled periodically by \a env,
  -- * terminating the current search as soon as \a func returns non-zero.
  -- *
  -- * \param env The environment in which to operate.
  -- * \param func The user-defined termination criterion. If it is NULL,
  -- *             no termination criterion will be used.
  -- * \param user_data Generic data pointer which will be passed to \a func. Can
  -- *                  be anything, its value will not be interpreted.
  -- * \return zero on success, nonzero on error
  --  

   function msat_set_termination_test
     (arg1 : msat_env;
      arg2 : msat_termination_test;
      arg3 : System.Address) return int;  -- mathsat.h:479
   pragma Import (C, msat_set_termination_test, "msat_set_termination_test");

  --*
  -- * \brief returns the data type for Booleans in the given env.
  --  

   function msat_get_bool_type (arg1 : msat_env) return msat_type;  -- mathsat.h:485
   pragma Import (C, msat_get_bool_type, "msat_get_bool_type");

  --*
  -- * \brief returns the data type for rationals in the given env.
  --  

   function msat_get_rational_type (arg1 : msat_env) return msat_type;  -- mathsat.h:490
   pragma Import (C, msat_get_rational_type, "msat_get_rational_type");

  --*
  -- * \brief returns the data type for integers in the given env.
  --  

   function msat_get_integer_type (arg1 : msat_env) return msat_type;  -- mathsat.h:495
   pragma Import (C, msat_get_integer_type, "msat_get_integer_type");

  --*
  -- * \brief returns the data type for bit-vectors of the given width.
  --  

   function msat_get_bv_type (arg1 : msat_env; arg2 : sys_utypes_usize_t_h.size_t) return msat_type;  -- mathsat.h:500
   pragma Import (C, msat_get_bv_type, "msat_get_bv_type");

  --*
  -- * \brief returns the data type for arrays with indices of \a itp type and
  -- * elements of \a etp type.
  --  

   function msat_get_array_type
     (arg1 : msat_env;
      arg2 : msat_type;
      arg3 : msat_type) return msat_type;  -- mathsat.h:506
   pragma Import (C, msat_get_array_type, "msat_get_array_type");

  --*
  -- * \brief returns the data type for floats with the given exponent and
  -- * significand/mantissa width.
  --  

   function msat_get_fp_type
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t) return msat_type;  -- mathsat.h:512
   pragma Import (C, msat_get_fp_type, "msat_get_fp_type");

  --*
  -- * \brief returns the type for float rounding modes in the given env.
  --  

   function msat_get_fp_roundingmode_type (arg1 : msat_env) return msat_type;  -- mathsat.h:517
   pragma Import (C, msat_get_fp_roundingmode_type, "msat_get_fp_roundingmode_type");

  --*
  -- * \brief returns an atomic type with the given name in the given env.
  --  

   function msat_get_simple_type (arg1 : msat_env; arg2 : Interfaces.C.Strings.chars_ptr) return msat_type;  -- mathsat.h:522
   pragma Import (C, msat_get_simple_type, "msat_get_simple_type");

  --*
  -- * \brief returns a function type in the given env.
  -- * \param env The environment in which to operate
  -- * \param param_types The types of the function arguments
  -- * \param num_params The arity of the function type
  -- * \param return_type The type of the return value
  -- * \return a function type
  --  

   function msat_get_function_type
     (arg1 : msat_env;
      arg2 : access msat_type;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : msat_type) return msat_type;  -- mathsat.h:532
   pragma Import (C, msat_get_function_type, "msat_get_function_type");

  --*
  -- * \brief checks whether the given type is bool.
  -- *
  -- * \param env The environment in which to operate
  -- * \param tp The data type to check
  -- * \return 1 if the type is bool, 0 otherwise
  --  

   function msat_is_bool_type (arg1 : msat_env; arg2 : msat_type) return int;  -- mathsat.h:542
   pragma Import (C, msat_is_bool_type, "msat_is_bool_type");

  --*
  -- * \brief checks whether the given type is rat.
  -- *
  -- * \param env The environment in which to operate
  -- * \param tp The data type to check
  -- * \return 1 if the type is rat, 0 otherwise
  --  

   function msat_is_rational_type (arg1 : msat_env; arg2 : msat_type) return int;  -- mathsat.h:551
   pragma Import (C, msat_is_rational_type, "msat_is_rational_type");

  --*
  -- * \brief checks whether the given type is int.
  -- *
  -- * \param env The environment in which to operate
  -- * \param tp The data type to check
  -- * \return 1 if the type is int, 0 otherwise
  --  

   function msat_is_integer_type (arg1 : msat_env; arg2 : msat_type) return int;  -- mathsat.h:560
   pragma Import (C, msat_is_integer_type, "msat_is_integer_type");

  --*
  -- * \brief checks whether the given type is a bit-vector.
  -- *
  -- * \param env The environment in which to operate
  -- * \param tp The data type to check
  -- * \param out_width Pointer to a variable where to store the width of the
  -- *                  BV type in case of success (can be NULL)
  -- * \return 1 if the type is a bit-vector, 0 otherwise
  --  

   function msat_is_bv_type
     (arg1 : msat_env;
      arg2 : msat_type;
      arg3 : access sys_utypes_usize_t_h.size_t) return int;  -- mathsat.h:571
   pragma Import (C, msat_is_bv_type, "msat_is_bv_type");

  --*
  -- * \brief checks whether the given type is an array.
  -- * 
  -- * \param env The environment in which to operate
  -- * \param tp The data type to check
  -- * \param out_itp Pointer to a variable where to store the type of
  -- *                the array indices (can be NULL)
  -- * \param out_itp Pointer to a variable where to store the type of
  -- *                the array elements (can be NULL)
  -- * \return 1 if the type is an array, 0 otherwise
  --  

   function msat_is_array_type
     (arg1 : msat_env;
      arg2 : msat_type;
      arg3 : access msat_type;
      arg4 : access msat_type) return int;  -- mathsat.h:584
   pragma Import (C, msat_is_array_type, "msat_is_array_type");

  --*
  -- * \brief checks whether the given type is a float.
  -- *
  -- * \param env The environment in which to operate
  -- * \param tp The data type to check
  -- * \param out_exp_width Pointer to a variable where to store the width of the
  -- *                      exponent of the float in case of success (can be NULL)
  -- * \param out_mant_width Pointer to a variable where to store the width of the
  -- *                       significand/mantissa of the float in case of success
  -- *                       (can be NULL)
  -- * \return 1 if the type is a float, 0 otherwise
  --  

   function msat_is_fp_type
     (arg1 : msat_env;
      arg2 : msat_type;
      arg3 : access sys_utypes_usize_t_h.size_t;
      arg4 : access sys_utypes_usize_t_h.size_t) return int;  -- mathsat.h:599
   pragma Import (C, msat_is_fp_type, "msat_is_fp_type");

  --*
  -- * \brief checks whether the given type is a float rounding mode type.
  --  

   function msat_is_fp_roundingmode_type (arg1 : msat_env; arg2 : msat_type) return int;  -- mathsat.h:605
   pragma Import (C, msat_is_fp_roundingmode_type, "msat_is_fp_roundingmode_type");

  --*
  -- * \brief checks whether two data types are the same
  -- * \return 1 if the types are the same, 0 otherwise
  --  

   function msat_type_equals (arg1 : msat_type; arg2 : msat_type) return int;  -- mathsat.h:612
   pragma Import (C, msat_type_equals, "msat_type_equals");

  --*
  -- * \brief Returns an internal string representation of a type
  -- *
  -- * The returned string can be useful for debugging purposes only, as
  -- * it is an internal representation of a type
  -- *
  -- * \param t A type.
  -- * \return a string reprsentation of \a t, or NULL in case of errors. The
  -- *         string must be dellocated by the caller with ::msat_free().
  --  

   function msat_type_repr (arg1 : msat_type) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:624
   pragma Import (C, msat_type_repr, "msat_type_repr");

  --*
  -- * \brief Declares a new uninterpreted function/constant
  -- *
  -- * \param e The environment of the declaration.
  -- * \param name A name for the function. It must be unique in the environment.
  -- * \param type The type of the function.
  -- * \return A constant declaration, or a val s.t. ::MSAT_ERROR_DECL(val) is true
  -- *         in case of errors.
  --  

   function msat_declare_function
     (arg1 : msat_env;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : msat_type) return msat_decl;  -- mathsat.h:636
   pragma Import (C, msat_declare_function, "msat_declare_function");

  --@} 
  --*
  -- * \name Term creation
  --  

  --@{ 
  --*
  -- * \brief Returns a term representing logical truth.
  -- * \param e The environment of the definition
  -- * \return The term TRUE, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- * in case of errors.
  --  

   function msat_make_true (arg1 : msat_env) return msat_term;  -- mathsat.h:651
   pragma Import (C, msat_make_true, "msat_make_true");

  --*
  -- * \brief Returns a term representing logical falsity.
  -- * \param e The environment of the definition
  -- * \return The term FALSE, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_false (arg1 : msat_env) return msat_term;  -- mathsat.h:659
   pragma Import (C, msat_make_false, "msat_make_false");

  --*
  -- * \brief Returns a term representing the equivalence of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. Must have type ::MSAT_BOOL.
  -- * \param t2 The second argument. Must have type ::MSAT_BOOL.
  -- * \return The term t1 <-> t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_iff
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:669
   pragma Import (C, msat_make_iff, "msat_make_iff");

  --*
  -- * \brief Returns a term representing the logical OR of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. Must have type ::MSAT_BOOL.
  -- * \param t2 The second argument. Must have type ::MSAT_BOOL.
  -- * \return The term t1 | t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_or
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:679
   pragma Import (C, msat_make_or, "msat_make_or");

  --*
  -- * \brief Returns a term representing the logical AND of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. Must have type ::MSAT_BOOL.
  -- * \param t2 The second argument. Must have type ::MSAT_BOOL.
  -- * \return The term t1 & t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_and
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:689
   pragma Import (C, msat_make_and, "msat_make_and");

  --*
  -- * \brief Returns a term representing the logical negation of t1.
  -- * \param e The environment of the definition
  -- * \param t1 The argument to negate. Must have type ::MSAT_BOOL.
  -- * \return The term !t1, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_not (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:698
   pragma Import (C, msat_make_not, "msat_make_not");

  --*
  -- * \brief Returns a term representing the equivalence of t1 and t2.
  -- *
  -- * If ::t1 and ::t2 have type ::MSAT_BOOL, this is equivalent to
  -- * ::make_iff(t1, t2). Otherwise, the atom (t1 = t2) is returned.
  -- * 
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \return The term (t1 = t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_equal
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:712
   pragma Import (C, msat_make_equal, "msat_make_equal");

  --*
  -- * \brief Returns an atom representing (t1 <= t2).
  -- *
  -- * The arguments must have the same type. The exception is for integer
  -- * numbers, which can be casted to rational if necessary. 
  -- * 
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. Must be of type rational or integer
  -- * \param t2 The second argument. Must be of type rational or integer
  -- * \return The term (t1 <= t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_leq
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:726
   pragma Import (C, msat_make_leq, "msat_make_leq");

  --*
  -- * \brief Returns an expression representing (t1 + t2).
  -- *
  -- * The arguments must have the same type. The exception is for integer
  -- * numbers, which can be casted to rational if necessary. 
  -- * 
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. Must be of type rational or integer
  -- * \param t2 The second argument. Must be of type rational or integer
  -- * \return The term (t1 + t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_plus
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:740
   pragma Import (C, msat_make_plus, "msat_make_plus");

  --*
  -- * \brief Returns an expression representing (t1 * t2).
  -- *
  -- * The arguments must have the same type, with the usual exception for integer
  -- * numbers. Moreover, at least one of them must be a number.
  -- * 
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. Must be of type rational or integer
  -- * \param t2 The second argument. Must be of type rational or integer
  -- * \return The term (t1 * t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_times
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:754
   pragma Import (C, msat_make_times, "msat_make_times");

  --*
  -- * \brief Returns an expression representing (t1 = t2 mod modulus).
  -- *
  -- * \param e The environment of the definition
  -- * \param modulus The value of the modulus. Must be > 0
  -- * \param t1 The first argument. 
  -- * \param t2 The second argument.
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_int_modular_congruence
     (arg1 : msat_env;
      arg2 : access gmp_h.uu_mpz_struct;
      arg3 : msat_term;
      arg4 : msat_term) return msat_term;  -- mathsat.h:767
   pragma Import (C, msat_make_int_modular_congruence, "msat_make_int_modular_congruence");

  --*
  -- * \brief Returns an expression representing (floor t)
  -- * \param e The environment of the definition
  -- * \param t The argument. 
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_floor (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:777
   pragma Import (C, msat_make_floor, "msat_make_floor");

  --*
  -- * \brief Returns an expression representing an integer or rational number.
  -- *
  -- * \param e The environment of the definition
  -- * \param num_rep A string representation for the number
  -- * 
  -- * \return The numeric term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_number (arg1 : msat_env; arg2 : Interfaces.C.Strings.chars_ptr) return msat_term;  -- mathsat.h:788
   pragma Import (C, msat_make_number, "msat_make_number");

  --*
  -- * \brief Returns an expression representing a term if-then-else construct.
  -- *
  -- * The two arguments ::tt and ::te must have compatible types.
  -- *
  -- * \param e The environment of the definition
  -- * \param c The condition of the test. Must be of type ::MSAT_BOOL
  -- * \param tt The "then" branch
  -- * \param te The "else" branch
  -- * 
  -- * \return The term representing the if-then-else, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_term_ite
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term;
      arg4 : msat_term) return msat_term;  -- mathsat.h:803
   pragma Import (C, msat_make_term_ite, "msat_make_term_ite");

  --*
  -- * \brief Creates a constant from a declaration.
  -- * \param e The environment of the definition
  -- * \param var The declaration of the constant. Must come from the same
  -- *            environment
  -- * \return The term representing the constant, or a t s.t. ::MSAT_ERROR_TERM(t)
  -- *         is true in case of errors.
  --  

   function msat_make_constant (arg1 : msat_env; arg2 : msat_decl) return msat_term;  -- mathsat.h:814
   pragma Import (C, msat_make_constant, "msat_make_constant");

  --*
  -- * \brief Creates an uninterpreted function application.
  -- *
  -- * The number and type of the arguments must match those of the declaration.
  -- * 
  -- * \param e The environment of the definition
  -- * \param func The declaration of the function
  -- * \param args The actual parameters
  -- * \return The term representing the function/predicate call, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.  

   function msat_make_uf
     (arg1 : msat_env;
      arg2 : msat_decl;
      arg3 : access msat_term) return msat_term;  -- mathsat.h:826
   pragma Import (C, msat_make_uf, "msat_make_uf");

  --*
  -- * \brief Creates an array read operation.
  -- *
  -- * \param e The environment of the definition
  -- * \param arr The array term
  -- * \param idx The index term
  -- * \return The term representing the array read, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.  

   function msat_make_array_read
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:836
   pragma Import (C, msat_make_array_read, "msat_make_array_read");

  --*
  -- * \brief Creates an array write operation.
  -- *
  -- * \param e The environment of the definition
  -- * \param arr The array term
  -- * \param idx The index term
  -- * \param elem The element term
  -- * \return The term representing the array write, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.  

   function msat_make_array_write
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term;
      arg4 : msat_term) return msat_term;  -- mathsat.h:847
   pragma Import (C, msat_make_array_write, "msat_make_array_write");

  --*
  -- * \brief Returns an expression representing a bit-vector number.
  -- *
  -- * \param e The environment of the definition
  -- * \param num_rep A string representation for the number.
  -- *                The number must be non-negative.
  -- * \param width The width in bits of the number
  -- * \param base The base of the representation. Can be 2, 10 or 16.
  -- * 
  -- * \return The numeric term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_number
     (arg1 : msat_env;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : sys_utypes_usize_t_h.size_t) return msat_term;  -- mathsat.h:862
   pragma Import (C, msat_make_bv_number, "msat_make_bv_number");

  --*
  -- * \brief Returns a term representing the concatenation of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. 
  -- * \param t2 The second argument.
  -- * \return The term t1 :: t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_concat
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:873
   pragma Import (C, msat_make_bv_concat, "msat_make_bv_concat");

  --*
  -- * \brief Returns a term representing the selection of t[msb:lsb].
  -- * \param e The environment of the definition
  -- * \param msb The most significant bit of the selection.
  -- * \param lsb The least significant bit of the selection.
  -- * \param t The argument.
  -- * \return The term t[msb:lsb], or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_extract
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : msat_term) return msat_term;  -- mathsat.h:885
   pragma Import (C, msat_make_bv_extract, "msat_make_bv_extract");

  --*
  -- * \brief Returns a term representing the bit-wise OR of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. 
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 | t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_or
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:896
   pragma Import (C, msat_make_bv_or, "msat_make_bv_or");

  --*
  -- * \brief Returns a term representing the bit-wise XOR of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 xor t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_xor
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:907
   pragma Import (C, msat_make_bv_xor, "msat_make_bv_xor");

  --*
  -- * \brief Returns a term representing the bit-wise AND of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 \& t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_and
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:918
   pragma Import (C, msat_make_bv_and, "msat_make_bv_and");

  --*
  -- * \brief Returns a term representing the bit-wise negation of t.
  -- * \param e The environment of the definition
  -- * \param t The argument to negate.
  -- * \return The term !t, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_not (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:927
   pragma Import (C, msat_make_bv_not, "msat_make_bv_not");

  --*
  -- * \brief Returns a term representing the logical left shift of t1 by t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. 
  -- * \param t2 The second argument.
  -- * \pre \a t1 and \a t2 must have the same width.
  -- * \return The term t1 << t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_lshl
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:938
   pragma Import (C, msat_make_bv_lshl, "msat_make_bv_lshl");

  --*
  -- * \brief Returns a term representing the logical right shift of t1 by t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 >> t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_lshr
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:949
   pragma Import (C, msat_make_bv_lshr, "msat_make_bv_lshr");

  --*
  -- * \brief Returns a term representing the arithmetic right shift of t1 by t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 >> t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_ashr
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:960
   pragma Import (C, msat_make_bv_ashr, "msat_make_bv_ashr");

  --*
  -- * \brief Returns a term representing the zero extension of t.
  -- * \param e The environment of the definition
  -- * \param amount The amount of the extension
  -- * \param t The first argument. 
  -- * \return The term zext(amount, t), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_zext
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : msat_term) return msat_term;  -- mathsat.h:970
   pragma Import (C, msat_make_bv_zext, "msat_make_bv_zext");

  --*
  -- * \brief Returns a term representing the sign extension of t1 by amount.
  -- * \param e The environment of the definition
  -- * \param amount The amount of the extension
  -- * \param t The first argument.
  -- * \return The term sext(amount, t), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_sext
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : msat_term) return msat_term;  -- mathsat.h:980
   pragma Import (C, msat_make_bv_sext, "msat_make_bv_sext");

  --*
  -- * \brief Returns a term representing the addition of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 + t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_plus
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:991
   pragma Import (C, msat_make_bv_plus, "msat_make_bv_plus");

  --*
  -- * \brief Returns a term representing the subtraction of t1 by t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 - t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_minus
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1002
   pragma Import (C, msat_make_bv_minus, "msat_make_bv_minus");

  --*
  -- * \brief Returns a term representing the negation of t, te two's-complement.
  -- * \param e The environment of the definition
  -- * \param t The argument.
  -- * \return The term -t, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_neg (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:1011
   pragma Import (C, msat_make_bv_neg, "msat_make_bv_neg");

  --*
  -- * \brief Returns a term representing the multiplication of t1 and t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 * t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_times
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1022
   pragma Import (C, msat_make_bv_times, "msat_make_bv_times");

  --*
  -- * \brief Returns a term representing the unsigned division of t1 by t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. 
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 / t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_udiv
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1033
   pragma Import (C, msat_make_bv_udiv, "msat_make_bv_udiv");

  --*
  -- * \brief Returns a term representing the unsigned remainder of t1 by t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 % t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_urem
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1044
   pragma Import (C, msat_make_bv_urem, "msat_make_bv_urem");

  --*
  -- * \brief Returns a term representing the signed division of t1 by t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 / t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_sdiv
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1055
   pragma Import (C, msat_make_bv_sdiv, "msat_make_bv_sdiv");

  --*
  -- * \brief Returns a term representing the signed remainder of t1 by t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 % t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_srem
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1066
   pragma Import (C, msat_make_bv_srem, "msat_make_bv_srem");

  --*
  -- * \brief Returns a term representing the unsigned t1 < t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 < t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_ult
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1077
   pragma Import (C, msat_make_bv_ult, "msat_make_bv_ult");

  --*
  -- * \brief Returns a term representing the unsigned t1 <= t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument. 
  -- * \param t2 The second argument. 
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 <= t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_uleq
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1088
   pragma Import (C, msat_make_bv_uleq, "msat_make_bv_uleq");

  --*
  -- * \brief Returns a term representing the signed t1 < t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 < t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_slt
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1099
   pragma Import (C, msat_make_bv_slt, "msat_make_bv_slt");

  --*
  -- * \brief Returns a term representing the signed t1 <= t2.
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term t1 <= t2, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_sleq
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1110
   pragma Import (C, msat_make_bv_sleq, "msat_make_bv_sleq");

  --*
  -- * \brief Returns a term representing the left rotation of \a 1 by
  -- *        \a amount bits.
  -- * \param e The environment of the definition
  -- * \param amount The amount of the rotation
  -- * \param t The argument of the rotation.
  -- * \return The term rol(amount, t), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_rol
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1121
   pragma Import (C, msat_make_bv_rol, "msat_make_bv_rol");

  --*
  -- * \brief Returns a term representing the right rotation of \a 1 by
  -- *        \a amount bits.
  -- * \param e The environment of the definition
  -- * \param amount The amount of the rotation
  -- * \param t The argument of the rotation.
  -- * \return The term ror(amount, t), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_ror
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1132
   pragma Import (C, msat_make_bv_ror, "msat_make_bv_ror");

  --*
  -- * \brief Returns a term representing the comparison of \a t1 and \a t2,
  -- *        resulting in a bit-vector of size 1
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \pre \p t1 and \p t2 must have the same width.
  -- * \return The term bvcomp(t1, t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_bv_comp
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1144
   pragma Import (C, msat_make_bv_comp, "msat_make_bv_comp");

  --*
  -- * \brief Returns a term representing the FP rounding mode ROUND_TO_NEAREST_EVEN
  -- * \param e The environment of the definition
  -- * \return The term ROUND_TO_NEAREST_EVEN, or a t s.t. ::MSAT_ERROR_TERM(t)
  -- *         is true in case of errors.
  --  

   function msat_make_fp_roundingmode_nearest_even (arg1 : msat_env) return msat_term;  -- mathsat.h:1152
   pragma Import (C, msat_make_fp_roundingmode_nearest_even, "msat_make_fp_roundingmode_nearest_even");

  --*
  -- * \brief Returns a term representing the FP rounding mode ROUND_TO_ZERO
  -- * \param e The environment of the definition
  -- * \return The term ROUND_TO_ZERO, or a t s.t. ::MSAT_ERROR_TERM(t)
  -- *         is true in case of errors.
  --  

   function msat_make_fp_roundingmode_zero (arg1 : msat_env) return msat_term;  -- mathsat.h:1160
   pragma Import (C, msat_make_fp_roundingmode_zero, "msat_make_fp_roundingmode_zero");

  --*
  -- * \brief Returns a term representing the FP rounding mode ROUND_TO_PLUS_INF
  -- * \param e The environment of the definition
  -- * \return The term ROUND_TO_PLUS_INF, or a t s.t. ::MSAT_ERROR_TERM(t)
  -- *         is true in case of errors.
  --  

   function msat_make_fp_roundingmode_plus_inf (arg1 : msat_env) return msat_term;  -- mathsat.h:1168
   pragma Import (C, msat_make_fp_roundingmode_plus_inf, "msat_make_fp_roundingmode_plus_inf");

  --*
  -- * \brief Returns a term representing the FP rounding mode ROUND_TO_MINUS_INF
  -- * \param e The environment of the definition
  -- * \return The term ROUND_TO_MINUS_INF, or a t s.t. ::MSAT_ERROR_TERM(t)
  -- *         is true in case of errors.
  --  

   function msat_make_fp_roundingmode_minus_inf (arg1 : msat_env) return msat_term;  -- mathsat.h:1176
   pragma Import (C, msat_make_fp_roundingmode_minus_inf, "msat_make_fp_roundingmode_minus_inf");

  --*
  -- * \brief Returns a term representing the FP equality predicate between
  -- *        \a t1 and \a t2.
  -- *
  -- * FP equality is different from the "regular" equality predicate in the
  -- * handling of NaN values: (fpeq NaN NaN) is always false, whereas (= NaN NaN)
  -- * is always true
  -- *        
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \return The term (fpeq t1 t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_fp_equal
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1192
   pragma Import (C, msat_make_fp_equal, "msat_make_fp_equal");

  --*
  -- * \brief Returns a term representing the FP < predicate between
  -- *        \a t1 and \a t2.
  -- *        
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \return The term (fplt t1 t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_fp_lt
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1204
   pragma Import (C, msat_make_fp_lt, "msat_make_fp_lt");

  --*
  -- * \brief Returns a term representing the FP <= predicate between
  -- *        \a t1 and \a t2.
  -- *        
  -- * \param e The environment of the definition
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \return The term (fpleq t1 t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_fp_leq
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term) return msat_term;  -- mathsat.h:1216
   pragma Import (C, msat_make_fp_leq, "msat_make_fp_leq");

  --*
  -- * \brief Returns a term representing the FP negation of \a t.
  -- *        
  -- * \param e The environment of the definition
  -- * \param t The argument to negate.
  -- * \return The term (fpneg t), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_fp_neg (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:1226
   pragma Import (C, msat_make_fp_neg, "msat_make_fp_neg");

  --*
  -- * \brief Returns a term representing the FP addition of \a t1 and \a t2,
  -- *        according to the given \a rounding mode.
  -- *        
  -- * \param e The environment of the definition
  -- * \param rounding The desired rounding mode.
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \return The term (+ rounding t1 t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_fp_plus
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term;
      arg4 : msat_term) return msat_term;  -- mathsat.h:1239
   pragma Import (C, msat_make_fp_plus, "msat_make_fp_plus");

  --*
  -- * \brief Returns a term representing the FP subtraction of \a t1 and \a t2,
  -- *        according to the given \a rounding mode.
  -- *        
  -- * \param e The environment of the definition
  -- * \param rounding The desired rounding mode.
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \return The term (- rounding t1 t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_fp_minus
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term;
      arg4 : msat_term) return msat_term;  -- mathsat.h:1253
   pragma Import (C, msat_make_fp_minus, "msat_make_fp_minus");

  --*
  -- * \brief Returns a term representing the FP multiplication of \a t1 and \a t2,
  -- *        according to the given \a rounding mode.
  -- *        
  -- * \param e The environment of the definition
  -- * \param rounding The desired rounding mode.
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \return The term (* rounding t1 t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_fp_times
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term;
      arg4 : msat_term) return msat_term;  -- mathsat.h:1267
   pragma Import (C, msat_make_fp_times, "msat_make_fp_times");

  --*
  -- * \brief Returns a term representing the FP division of \a t1 and \a t2,
  -- *        according to the given \a rounding mode.
  -- *        
  -- * \param e The environment of the definition
  -- * \param rounding The desired rounding mode.
  -- * \param t1 The first argument.
  -- * \param t2 The second argument.
  -- * \return The term (/ rounding t1 t2), or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_fp_div
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_term;
      arg4 : msat_term) return msat_term;  -- mathsat.h:1281
   pragma Import (C, msat_make_fp_div, "msat_make_fp_div");

  --*
  -- * \brief Returns a term representing the FP format conversion of the given
  -- *        input term.
  -- *        
  -- * \param e The environment of the definition
  -- * \param exp_w The target exponent width.
  -- * \param mant_w The target mantissa width.
  -- * \param rounding The desired rounding mode.
  -- * \param t The argument to convert.
  -- * \return The term representing the conversion, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_cast
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : msat_term;
      arg5 : msat_term) return msat_term;  -- mathsat.h:1296
   pragma Import (C, msat_make_fp_cast, "msat_make_fp_cast");

  --*
  -- * \brief Returns a term representing the conversion of a FP term to bit-vector.
  -- *        
  -- * \param e The environment of the definition
  -- * \param width The target bit-vector width.
  -- * \param rounding The desired rounding mode.
  -- * \param t The argument to convert.
  -- * \return The term representing the conversion, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_to_bv
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : msat_term;
      arg4 : msat_term) return msat_term;  -- mathsat.h:1309
   pragma Import (C, msat_make_fp_to_bv, "msat_make_fp_to_bv");

  --*
  -- * \brief Returns a term representing the conversion of a signed bit-vector
  -- *        term to FP.
  -- *        
  -- * \param e The environment of the definition
  -- * \param exp_w The target exponent width.
  -- * \param mant_w The target mantissa width.
  -- * \param rounding The desired rounding mode.
  -- * \param t The argument to convert.
  -- * \return The term representing the conversion, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_from_sbv
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : msat_term;
      arg5 : msat_term) return msat_term;  -- mathsat.h:1324
   pragma Import (C, msat_make_fp_from_sbv, "msat_make_fp_from_sbv");

  --*
  -- * \brief Returns a term representing the conversion of an unsigned bit-vector
  -- *        term to FP.
  -- *        
  -- * \param e The environment of the definition
  -- * \param exp_w The target exponent width.
  -- * \param mant_w The target mantissa width.
  -- * \param rounding The desired rounding mode.
  -- * \param t The argument to convert.
  -- * \return The term representing the conversion, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_from_ubv
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : msat_term;
      arg5 : msat_term) return msat_term;  -- mathsat.h:1339
   pragma Import (C, msat_make_fp_from_ubv, "msat_make_fp_from_ubv");

  --*
  -- * \brief Returns a term for interpreting a FP term as a bit-vector.
  -- *
  -- * This is different from ::make_fp_to_bv in that the latter takes the integer
  -- * part of the FP number and stores it in a bit-vector, while this function
  -- * simply takes the bits of the representation of the input and interprets
  -- * them as a bit-vector (of size 1+ width of exponent + width of mantissa).
  -- *        
  -- * \param e The environment of the definition
  -- * \param t The argument to convert.
  -- * \return The term representing the conversion, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_as_ieeebv (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:1355
   pragma Import (C, msat_make_fp_as_ieeebv, "msat_make_fp_as_ieeebv");

  --*
  -- * \brief Returns a term representing the FP number whose IEEE 754 encoding is
  -- * the given bit-vector.
  -- *        
  -- * \param e The environment of the definition
  -- * \param exp_w The target exponent width.
  -- * \param mant_w The target mantissa width.
  -- * \param t The argument to convert.
  -- * \return The term representing the conversion, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_from_ieeebv
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : msat_term) return msat_term;  -- mathsat.h:1368
   pragma Import (C, msat_make_fp_from_ieeebv, "msat_make_fp_from_ieeebv");

  --*
  -- * \brief Returns the predicate for testing whether a FP term is NaN.
  -- *        
  -- * \param e The environment of the definition
  -- * \param t The argument to test.
  -- * \return The term representing (isnan t), or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_isnan (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:1379
   pragma Import (C, msat_make_fp_isnan, "msat_make_fp_isnan");

  --*
  -- * \brief Returns the predicate for testing whether a FP term is infinity.
  -- *        
  -- * \param e The environment of the definition
  -- * \param t The argument to test.
  -- * \return The term representing (isinf t), or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_isinf (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:1389
   pragma Import (C, msat_make_fp_isinf, "msat_make_fp_isinf");

  --*
  -- * \brief Returns the predicate for testing whether a FP term is zero.
  -- *        
  -- * \param e The environment of the definition
  -- * \param t The argument to test.
  -- * \return The term representing (iszero t), or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_iszero (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:1399
   pragma Import (C, msat_make_fp_iszero, "msat_make_fp_iszero");

  --*
  -- * \brief Returns the predicate for testing whether a FP term is a subnormal.
  -- *        
  -- * \param e The environment of the definition
  -- * \param t The argument to test.
  -- * \return The term representing (issubnormal t), or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_issubnormal (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:1409
   pragma Import (C, msat_make_fp_issubnormal, "msat_make_fp_issubnormal");

  --*
  -- * \brief Returns the FP term representing +Inf of the given format.
  -- *        
  -- * \param e The environment of the definition
  -- * \param exp_w The desired exponent width
  -- * \param mant_w The desired mantissa width
  -- * \return A term representing +Inf, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_plus_inf
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t) return msat_term;  -- mathsat.h:1421
   pragma Import (C, msat_make_fp_plus_inf, "msat_make_fp_plus_inf");

  --*
  -- * \brief Returns the FP term representing -Inf of the given format.
  -- *        
  -- * \param e The environment of the definition
  -- * \param exp_w The desired exponent width
  -- * \param mant_w The desired mantissa width
  -- * \return A term representing -Inf, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_minus_inf
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t) return msat_term;  -- mathsat.h:1432
   pragma Import (C, msat_make_fp_minus_inf, "msat_make_fp_minus_inf");

  --*
  -- * \brief Returns the FP term representing NaN of the given format.
  -- *        
  -- * \param e The environment of the definition
  -- * \param exp_w The desired exponent width
  -- * \param mant_w The desired mantissa width
  -- * \return A term representing NaN, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_nan
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : sys_utypes_usize_t_h.size_t) return msat_term;  -- mathsat.h:1443
   pragma Import (C, msat_make_fp_nan, "msat_make_fp_nan");

  --*
  -- * \brief Creates an FP number from a rational number.
  -- *        
  -- * \param e The environment of the definition
  -- * \param num_rep A string representation for the rational number
  -- * \param exp_w The desired exponent width
  -- * \param mant_w The desired mantissa width
  -- * \param rounding The desired rounding mode.
  -- * \return The numeric term, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_rat_number
     (arg1 : msat_env;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : sys_utypes_usize_t_h.size_t;
      arg5 : msat_term) return msat_term;  -- mathsat.h:1456
   pragma Import (C, msat_make_fp_rat_number, "msat_make_fp_rat_number");

  --*
  -- * \brief Creates an FP number from a string of bits.
  -- *        
  -- * \param e The environment of the definition
  -- * \param num_rep A string representation of a base-10 integer number
  -- * \param exp_w The desired exponent width
  -- * \param mant_w The desired mantissa width
  -- * \return The numeric term, or a t s.t.
  -- *         ::MSAT_ERROR_TERM(t) is true in case of errors.
  --  

   function msat_make_fp_bits_number
     (arg1 : msat_env;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : sys_utypes_usize_t_h.size_t) return msat_term;  -- mathsat.h:1470
   pragma Import (C, msat_make_fp_bits_number, "msat_make_fp_bits_number");

  --*
  -- * \brief Creates a term from a declaration and a list of arguments
  -- *
  -- * \param e The environment in which to create the term
  -- * \param d The declaration
  -- * \param args The arguments
  -- * \pre The length of \a args should be equal to the arity of \a d
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_term
     (arg1 : msat_env;
      arg2 : msat_decl;
      arg3 : access msat_term) return msat_term;  -- mathsat.h:1483
   pragma Import (C, msat_make_term, "msat_make_term");

  --*
  -- * \brief Creates a term in \a e from an equivalent term \a t that was created
  -- *        in \a src.
  -- *
  -- * \param e The environment in which to create the term
  -- * \param t The term to copy
  -- * \param src The environment in which \a t was created
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_make_copy_from
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_env) return msat_term;  -- mathsat.h:1495
   pragma Import (C, msat_make_copy_from, "msat_make_copy_from");

  --@} 
  -- end of term creation group  
  --*
  -- * \name Term access and navigation
  --  

  --@{ 
  --*
  -- * \brief Returns a numeric identifier for \a t
  -- *
  -- * The returned value is guaranteed to be unique within the environment in
  -- * which \a t was defined. Therefore, it can be used to test two terms for
  -- * equality, as well as a hash value.
  -- *
  -- * \param t A term. 
  -- * \return a unique (within the defining env) numeric identifier
  --  

   function msat_term_id (arg1 : msat_term) return sys_utypes_usize_t_h.size_t;  -- mathsat.h:1514
   pragma Import (C, msat_term_id, "msat_term_id");

  --*
  -- * \brief Returns the arity of \a t
  -- * \param t A term. 
  -- * \return The number of arguments of \a t
  --  

   function msat_term_arity (arg1 : msat_term) return sys_utypes_usize_t_h.size_t;  -- mathsat.h:1521
   pragma Import (C, msat_term_arity, "msat_term_arity");

  --*
  -- * \brief Returns the nth argument of \a t
  -- * \param t A term. 
  -- * \param n The index of the argument. Must be lower than the arity of \a t
  -- * \return The nth argument of arguments of \a t
  --  

   function msat_term_get_arg (arg1 : msat_term; arg2 : sys_utypes_usize_t_h.size_t) return msat_term;  -- mathsat.h:1529
   pragma Import (C, msat_term_get_arg, "msat_term_get_arg");

  --*
  -- * \brief Returns the type of \a t
  -- * \param t A term. 
  -- * \return The type of \a t
  --  

   function msat_term_get_type (arg1 : msat_term) return msat_type;  -- mathsat.h:1536
   pragma Import (C, msat_term_get_type, "msat_term_get_type");

  --*
  -- * \brief Checks whether \a t is the TRUE term
  -- * \param t A term. 
  -- * \return nonzero if \a t is TRUE
  --  

   function msat_term_is_true (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1543
   pragma Import (C, msat_term_is_true, "msat_term_is_true");

  --*
  -- * \brief Checks whether \a t is the FALSE term
  -- * \param t A term. 
  -- * \return nonzero if \a t is FALSE
  --  

   function msat_term_is_false (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1550
   pragma Import (C, msat_term_is_false, "msat_term_is_false");

  --*
  -- * \brief Checks whether \a t is a boolean constant
  -- * \param t A term. 
  -- * \return nonzero if \a t is a constant of type ::MSAT_BOOL
  --  

   function msat_term_is_boolean_constant (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1557
   pragma Import (C, msat_term_is_boolean_constant, "msat_term_is_boolean_constant");

  --*
  -- * \brief Checks whether \a t is an atom
  -- * \param t A term. 
  -- * \return nonzero if \a t is an atom, i.e. either a boolean constant or
  -- *         a relation between terms
  --  

   function msat_term_is_atom (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1565
   pragma Import (C, msat_term_is_atom, "msat_term_is_atom");

  --*
  -- * \brief Checks whether \a t is a number
  -- * \param t A term. 
  -- * \return nonzero if \a t is a number
  --  

   function msat_term_is_number (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1572
   pragma Import (C, msat_term_is_number, "msat_term_is_number");

  --*
  -- * \brief converts the given term to an mpq_t rational number
  -- *
  -- * The term must be a number, otherwise an error is reported.
  -- *
  -- * \param e the environment in which to operate 
  -- * \param t the number to convert
  -- * \param out the result of the conversion. Before calling this function,
  -- *            \a out should be initialized with a call to mpq_init()
  -- * \return zero on success, nonzero on error
  --  

   function msat_term_to_number
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access gmp_h.uu_mpq_struct) return int;  -- mathsat.h:1585
   pragma Import (C, msat_term_to_number, "msat_term_to_number");

  --*
  -- * \brief Checks whether \a t is an AND
  -- * \param t A term. 
  -- * \return nonzero if \a t is an AND
  --  

   function msat_term_is_and (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1592
   pragma Import (C, msat_term_is_and, "msat_term_is_and");

  --*
  -- * \brief Checks whether \a t is an OR
  -- * \param t A term. 
  -- * \return nonzero if \a t is an OR
  --  

   function msat_term_is_or (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1599
   pragma Import (C, msat_term_is_or, "msat_term_is_or");

  --*
  -- * \brief Checks whether \a t is a NOT
  -- * \param t A term. 
  -- * \return nonzero if \a t is a NOT
  --  

   function msat_term_is_not (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1606
   pragma Import (C, msat_term_is_not, "msat_term_is_not");

  --*
  -- * \brief Checks whether \a t is an equivalence between boolean terms
  -- * \param t A term. 
  -- * \return nonzero if \a t is an IFF
  --  

   function msat_term_is_iff (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1613
   pragma Import (C, msat_term_is_iff, "msat_term_is_iff");

  --*
  -- * \brief Checks whether \a t is a term if-then-else
  -- * \param t A term. 
  -- * \return nonzero if \a t is a term if-then-else
  --  

   function msat_term_is_term_ite (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1620
   pragma Import (C, msat_term_is_term_ite, "msat_term_is_term_ite");

  --*
  -- * \brief Checks whether \a t is a constant
  -- * \param t A term. 
  -- * \return nonzero if \a t is a constant
  --  

   function msat_term_is_constant (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1627
   pragma Import (C, msat_term_is_constant, "msat_term_is_constant");

  --*
  -- * \brief Checks whether \a t is an uninterpreted function application
  -- * \param t A term. 
  -- * \return nonzero if \a t is a uf application
  --  

   function msat_term_is_uf (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1634
   pragma Import (C, msat_term_is_uf, "msat_term_is_uf");

  --*
  -- * \brief Checks whether \a t is an equality
  -- * \param t A term. 
  -- * \return nonzero if \a t is an equality atom
  --  

   function msat_term_is_equal (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1641
   pragma Import (C, msat_term_is_equal, "msat_term_is_equal");

  --*
  -- * \brief Checks whether \a t is a (t1 <= t2) atom
  -- * \param t A term. 
  -- * \return nonzero if \a t is a (t1 <= t2) atom
  --  

   function msat_term_is_leq (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1648
   pragma Import (C, msat_term_is_leq, "msat_term_is_leq");

  --*
  -- * \brief Checks whether \a t is a (t1 + t2) expression
  -- * \param t A term. 
  -- * \return nonzero if \a t is a (t1 + t2) expression
  --  

   function msat_term_is_plus (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1655
   pragma Import (C, msat_term_is_plus, "msat_term_is_plus");

  --*
  -- * \brief Checks whether \a t is a (t1 * t2) expression
  -- * \param t A term. 
  -- * \return nonzero if \a t is a (t1 * t2) expression
  --  

   function msat_term_is_times (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1662
   pragma Import (C, msat_term_is_times, "msat_term_is_times");

  --*
  -- * \brief Checks whether \a t is an integer modular congruence expression.
  -- *        If so, stores in \a out_mod the value of the modulus as a GMP bigint
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is an integer modular congruence
  --  

   function msat_term_is_int_modular_congruence
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access gmp_h.uu_mpz_struct) return int;  -- mathsat.h:1671
   pragma Import (C, msat_term_is_int_modular_congruence, "msat_term_is_int_modular_congruence");

  --*
  -- * \brief Checks whether \a t is a (floor t1) expression
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a floor expression
  --  

   function msat_term_is_floor (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1679
   pragma Import (C, msat_term_is_floor, "msat_term_is_floor");

  --*
  -- * \brief Checks whether \a t is an array read
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is an array read
  --  

   function msat_term_is_array_read (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1687
   pragma Import (C, msat_term_is_array_read, "msat_term_is_array_read");

  --*
  -- * \brief Checks whether \a t is an array write
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is an array write
  --  

   function msat_term_is_array_write (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1695
   pragma Import (C, msat_term_is_array_write, "msat_term_is_array_write");

  --*
  -- * \brief Checks whether \a t is a BV concatenation
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a concatenation 
  --  

   function msat_term_is_bv_concat (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1703
   pragma Import (C, msat_term_is_bv_concat, "msat_term_is_bv_concat");

  --*
  -- * \brief Checks whether \a t is a BV extraction
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \param out_msb If not NULL, the msb of the selection will be stored here
  -- * \param out_lsb If not NULL, the lsb of the selection will be stored here
  -- * \return nonzero if \a t is an extraction
  --  

   function msat_term_is_bv_extract
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access sys_utypes_usize_t_h.size_t;
      arg4 : access sys_utypes_usize_t_h.size_t) return int;  -- mathsat.h:1713
   pragma Import (C, msat_term_is_bv_extract, "msat_term_is_bv_extract");

  --*
  -- * \brief Checks whether \a t is a bit-wise or
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-wise or
  --  

   function msat_term_is_bv_or (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1722
   pragma Import (C, msat_term_is_bv_or, "msat_term_is_bv_or");

  --*
  -- * \brief Checks whether \a t is a bit-wise xor
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-wise xor
  --  

   function msat_term_is_bv_xor (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1730
   pragma Import (C, msat_term_is_bv_xor, "msat_term_is_bv_xor");

  --*
  -- * \brief Checks whether \a t is a bit-wise and
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-wise and
  --  

   function msat_term_is_bv_and (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1738
   pragma Import (C, msat_term_is_bv_and, "msat_term_is_bv_and");

  --*
  -- * \brief Checks whether \a t is a bit-wise not
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-wise not
  --  

   function msat_term_is_bv_not (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1746
   pragma Import (C, msat_term_is_bv_not, "msat_term_is_bv_not");

  --*
  -- * \brief Checks whether \a t is a bit-vector addition
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector addition
  --  

   function msat_term_is_bv_plus (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1754
   pragma Import (C, msat_term_is_bv_plus, "msat_term_is_bv_plus");

  --*
  -- * \brief Checks whether \a t is a bit-vector subtraction
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector subtraction
  --  

   function msat_term_is_bv_minus (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1762
   pragma Import (C, msat_term_is_bv_minus, "msat_term_is_bv_minus");

  --*
  -- * \brief Checks whether \a t is a bit-vector multiplication
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector multiplication
  --  

   function msat_term_is_bv_times (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1770
   pragma Import (C, msat_term_is_bv_times, "msat_term_is_bv_times");

  --*
  -- * \brief Checks whether \a t is a bit-vector unary negation
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector unary negation
  --  

   function msat_term_is_bv_neg (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1778
   pragma Import (C, msat_term_is_bv_neg, "msat_term_is_bv_neg");

  --*
  -- * \brief Checks whether \a t is a bit-vector unsigned division
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector unsigned division
  --  

   function msat_term_is_bv_udiv (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1786
   pragma Import (C, msat_term_is_bv_udiv, "msat_term_is_bv_udiv");

  --*
  -- * \brief Checks whether \a t is a bit-vector unsigned remainder
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector unsigned remainder
  --  

   function msat_term_is_bv_urem (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1794
   pragma Import (C, msat_term_is_bv_urem, "msat_term_is_bv_urem");

  --*
  -- * \brief Checks whether \a t is a bit-vector signed division
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector signed division
  --  

   function msat_term_is_bv_sdiv (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1802
   pragma Import (C, msat_term_is_bv_sdiv, "msat_term_is_bv_sdiv");

  --*
  -- * \brief Checks whether \a t is a bit-vector signed remainder
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector signed remainder
  --  

   function msat_term_is_bv_srem (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1810
   pragma Import (C, msat_term_is_bv_srem, "msat_term_is_bv_srem");

  --*
  -- * \brief Checks whether \a t is a bit-vector unsigned lt
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector unsigned lt
  --  

   function msat_term_is_bv_ult (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1818
   pragma Import (C, msat_term_is_bv_ult, "msat_term_is_bv_ult");

  --*
  -- * \brief Checks whether \a t is a bit-vector unsigned leq
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector unsigned leq
  --  

   function msat_term_is_bv_uleq (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1826
   pragma Import (C, msat_term_is_bv_uleq, "msat_term_is_bv_uleq");

  --*
  -- * \brief Checks whether \a t is a bit-vector signed lt
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector signed lt
  --  

   function msat_term_is_bv_slt (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1834
   pragma Import (C, msat_term_is_bv_slt, "msat_term_is_bv_slt");

  --*
  -- * \brief Checks whether \a t is a bit-vector signed leq
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a bit-vector signed leq
  --  

   function msat_term_is_bv_sleq (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1842
   pragma Import (C, msat_term_is_bv_sleq, "msat_term_is_bv_sleq");

  --*
  -- * \brief Checks whether \a t is a logical shift left
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a logical shift left
  --  

   function msat_term_is_bv_lshl (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1850
   pragma Import (C, msat_term_is_bv_lshl, "msat_term_is_bv_lshl");

  --*
  -- * \brief Checks whether \a t is a logical shift right
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is a logical shift right
  --  

   function msat_term_is_bv_lshr (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1858
   pragma Import (C, msat_term_is_bv_lshr, "msat_term_is_bv_lshr");

  --*
  -- * \brief Checks whether \a t is an arithmetic shift right
  -- * \param e The environment in which to operate
  -- * \param t A term. 
  -- * \return nonzero if \a t is an arithmetic shift right
  --  

   function msat_term_is_bv_ashr (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1866
   pragma Import (C, msat_term_is_bv_ashr, "msat_term_is_bv_ashr");

  --*
  -- * \brief Checks whether \a t is a zero extension
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \param out_amount If not NULL, the amount of the zero extension
  -- *                   will be stored here
  -- * \return nonzero if \a t is a zero extension
  --  

   function msat_term_is_bv_zext
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access sys_utypes_usize_t_h.size_t) return int;  -- mathsat.h:1876
   pragma Import (C, msat_term_is_bv_zext, "msat_term_is_bv_zext");

  --*
  -- * \brief Checks whether \a t is a sign extension
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \param out_amount If not NULL, the amount of the sign extension
  -- *                   will be stored here
  -- * \return nonzero if \a t is a sign extension
  --  

   function msat_term_is_bv_sext
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access sys_utypes_usize_t_h.size_t) return int;  -- mathsat.h:1886
   pragma Import (C, msat_term_is_bv_sext, "msat_term_is_bv_sext");

  --*
  -- * \brief Checks whether \a t is a rotate left
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \param out_amount If not NULL, the amount of the left rotation
  -- *                   will be stored here
  -- * \return nonzero if \a t is a rotate left
  --  

   function msat_term_is_bv_rol
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access sys_utypes_usize_t_h.size_t) return int;  -- mathsat.h:1896
   pragma Import (C, msat_term_is_bv_rol, "msat_term_is_bv_rol");

  --*
  -- * \brief Checks whether \a t is a rotate right
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \param out_amount If not NULL, the amount of the right rotation
  -- *                   will be stored here
  -- * \return nonzero if \a t is a rotate right
  --  

   function msat_term_is_bv_ror
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access sys_utypes_usize_t_h.size_t) return int;  -- mathsat.h:1906
   pragma Import (C, msat_term_is_bv_ror, "msat_term_is_bv_ror");

  --*
  -- * \brief Checks whether \a t is a BV comparison
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a BV comparison
  --  

   function msat_term_is_bv_comp (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1914
   pragma Import (C, msat_term_is_bv_comp, "msat_term_is_bv_comp");

  --*
  -- * \brief Checks whether \a t is the ROUND_TO_NEAREST_EVEN FP
  -- *        rounding mode constant
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is ROUND_TO_NEAREST_EVEN
  --  

   function msat_term_is_fp_roundingmode_nearest_even (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1923
   pragma Import (C, msat_term_is_fp_roundingmode_nearest_even, "msat_term_is_fp_roundingmode_nearest_even");

  --*
  -- * \brief Checks whether \a t is the ROUND_TO_ZERO FP
  -- *        rounding mode constant
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is ROUND_TO_ZERO
  --  

   function msat_term_is_fp_roundingmode_zero (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1932
   pragma Import (C, msat_term_is_fp_roundingmode_zero, "msat_term_is_fp_roundingmode_zero");

  --*
  -- * \brief Checks whether \a t is the ROUND_TO_PLUS_INF FP
  -- *        rounding mode constant
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is ROUND_TO_PLUS_INF
  --  

   function msat_term_is_fp_roundingmode_plus_inf (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1941
   pragma Import (C, msat_term_is_fp_roundingmode_plus_inf, "msat_term_is_fp_roundingmode_plus_inf");

  --*
  -- * \brief Checks whether \a t is the ROUND_TO_MINUS_INF FP
  -- *        rounding mode constant
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is ROUND_TO_MINUS_INF
  --  

   function msat_term_is_fp_roundingmode_minus_inf (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1950
   pragma Import (C, msat_term_is_fp_roundingmode_minus_inf, "msat_term_is_fp_roundingmode_minus_inf");

  --*
  -- * \brief Checks whether \a t is a FP equality
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP equality
  --  

   function msat_term_is_fp_equal (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1958
   pragma Import (C, msat_term_is_fp_equal, "msat_term_is_fp_equal");

  --*
  -- * \brief Checks whether \a t is a FP less than
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP less than
  --  

   function msat_term_is_fp_lt (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1966
   pragma Import (C, msat_term_is_fp_lt, "msat_term_is_fp_lt");

  --*
  -- * \brief Checks whether \a t is a FP <=
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP <=
  --  

   function msat_term_is_fp_leq (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1974
   pragma Import (C, msat_term_is_fp_leq, "msat_term_is_fp_leq");

  --*
  -- * \brief Checks whether \a t is a FP negation
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP negation
  --  

   function msat_term_is_fp_neg (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1982
   pragma Import (C, msat_term_is_fp_neg, "msat_term_is_fp_neg");

  --*
  -- * \brief Checks whether \a t is a FP plus
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP plus
  --  

   function msat_term_is_fp_plus (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1990
   pragma Import (C, msat_term_is_fp_plus, "msat_term_is_fp_plus");

  --*
  -- * \brief Checks whether \a t is a FP minus
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP minus
  --  

   function msat_term_is_fp_minus (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:1998
   pragma Import (C, msat_term_is_fp_minus, "msat_term_is_fp_minus");

  --*
  -- * \brief Checks whether \a t is a FP times
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP times
  --  

   function msat_term_is_fp_times (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2006
   pragma Import (C, msat_term_is_fp_times, "msat_term_is_fp_times");

  --*
  -- * \brief Checks whether \a t is a FP div
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP div
  --  

   function msat_term_is_fp_div (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2014
   pragma Import (C, msat_term_is_fp_div, "msat_term_is_fp_div");

  --*
  -- * \brief Checks whether \a t is a FP cast
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP cast
  --  

   function msat_term_is_fp_cast (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2022
   pragma Import (C, msat_term_is_fp_cast, "msat_term_is_fp_cast");

  --*
  -- * \brief Checks whether \a t is a FP to BV conversion
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP to BV conversion
  --  

   function msat_term_is_fp_to_bv (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2030
   pragma Import (C, msat_term_is_fp_to_bv, "msat_term_is_fp_to_bv");

  --*
  -- * \brief Checks whether \a t is a FP from signed BV conversion
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP from signed BV conversion
  --  

   function msat_term_is_fp_from_sbv (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2038
   pragma Import (C, msat_term_is_fp_from_sbv, "msat_term_is_fp_from_sbv");

  --*
  -- * \brief Checks whether \a t is a FP from unsigned BV conversion
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP from unsigned BV conversion
  --  

   function msat_term_is_fp_from_ubv (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2046
   pragma Import (C, msat_term_is_fp_from_ubv, "msat_term_is_fp_from_ubv");

  --*
  -- * \brief Checks whether \a t is a FP as BV conversion
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP as BV conversion
  --  

   function msat_term_is_fp_as_ieeebv (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2054
   pragma Import (C, msat_term_is_fp_as_ieeebv, "msat_term_is_fp_as_ieeebv");

  --*
  -- * \brief Checks whether \a t is a FP from IEEE BV conversion
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP from unsigned BV conversion
  --  

   function msat_term_is_fp_from_ieeebv (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2062
   pragma Import (C, msat_term_is_fp_from_ieeebv, "msat_term_is_fp_from_ieeebv");

  --*
  -- * \brief Checks whether \a t is a FP isnan predicate
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP isnan predicate
  --  

   function msat_term_is_fp_isnan (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2070
   pragma Import (C, msat_term_is_fp_isnan, "msat_term_is_fp_isnan");

  --*
  -- * \brief Checks whether \a t is a FP isinf predicate
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP isinf predicate
  --  

   function msat_term_is_fp_isinf (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2078
   pragma Import (C, msat_term_is_fp_isinf, "msat_term_is_fp_isinf");

  --*
  -- * \brief Checks whether \a t is a FP iszero predicate
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP iszero predicate
  --  

   function msat_term_is_fp_iszero (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2086
   pragma Import (C, msat_term_is_fp_iszero, "msat_term_is_fp_iszero");

  --*
  -- * \brief Checks whether \a t is a FP issubnormal predicate
  -- * \param e The environment in which to operate
  -- * \param t A term.
  -- * \return nonzero if \a t is a FP iszero predicate
  --  

   function msat_term_is_fp_issubnormal (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2094
   pragma Import (C, msat_term_is_fp_issubnormal, "msat_term_is_fp_issubnormal");

  --*
  -- * \brief visits the DAG of the given term \a t, calling the callback \a func
  -- * for every suberm
  -- *
  -- * \param e The environment in which to operate
  -- * \param t The term to visit
  -- * \param func The callback function
  -- * \param user_data Generic data pointer which will be passed to \a func. Can
  -- *                  be anything, its value will not be interpreted
  -- * \return zero on success, nonzero on error
  --  

   function msat_visit_term
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : msat_visit_term_callback;
      arg4 : System.Address) return int;  -- mathsat.h:2107
   pragma Import (C, msat_visit_term, "msat_visit_term");

  --*
  -- * \brief Returns the declaration of the given \a symbol in the given
  -- *        environment (if any)
  -- *
  -- * If \a symbol is not declared in \a e, the returned value \a ret will be s.t.
  -- * MSAT_ERROR_DECL(ret) is true
  -- *
  -- * \param e The environment in which to operate
  -- *
  -- * \return The declaration of \a symbol in \a e, or a \a ret
  -- *         s.t. MSAT_ERROR_DECL(ret) is true
  --  

   function msat_find_decl (arg1 : msat_env; arg2 : Interfaces.C.Strings.chars_ptr) return msat_decl;  -- mathsat.h:2122
   pragma Import (C, msat_find_decl, "msat_find_decl");

  --*
  -- * \brief Returns the declaration associated to \a t (if any)
  -- *
  -- * If \a t is not a constant or a function application, the returned value \a
  -- * ret will be s.t. MSAT_ERROR_DECL(ret) is true
  -- *
  -- * \param t The term for which to retrieve the declaration
  -- * 
  -- * \return If \a t is a constant, its declaration is returned; if it
  -- *         is an uif, the declaration of the function is returned; otherwise,
  -- *         a \a ret s.t. MSAT_ERROR_DECL(ret) is true is returned
  --  

   function msat_term_get_decl (arg1 : msat_term) return msat_decl;  -- mathsat.h:2136
   pragma Import (C, msat_term_get_decl, "msat_term_get_decl");

  --*
  -- * \brief Returns a numeric identifier for the input declaration
  -- *
  -- * The returned value is guaranteed to be unique within the environment in
  -- * which \a d was defined. Therefore, it can be used to test
  -- * two declarations for equality, as well as a hash value.
  -- *
  -- * \param d A declaration. 
  -- * \return a unique (within the defining env) numeric identifier
  --  

   function msat_decl_id (arg1 : msat_decl) return sys_utypes_usize_t_h.size_t;  -- mathsat.h:2148
   pragma Import (C, msat_decl_id, "msat_decl_id");

  --*
  -- * \brief Returns the symbol tag associated to the given declaration
  -- *
  -- * \param e The environment in which to operate
  -- * \param d A declaration
  -- * \return the tag of the declaration
  --  

   function msat_decl_get_tag (arg1 : msat_env; arg2 : msat_decl) return msat_symbol_tag;  -- mathsat.h:2157
   pragma Import (C, msat_decl_get_tag, "msat_decl_get_tag");

  --*
  -- * \brief Returns the return type of the given declaration
  -- *
  -- * The return type for a constant is simply the constant's type.
  -- *
  -- * \param d A declaration
  -- *
  -- * \return The return type. In case of error, MSAT_U is returned.
  --  

   function msat_decl_get_return_type (arg1 : msat_decl) return msat_type;  -- mathsat.h:2168
   pragma Import (C, msat_decl_get_return_type, "msat_decl_get_return_type");

  --*
  -- * \brief Returns the arity (number of arguments) of the given
  -- * declaration.
  -- *
  -- * \param d A declaration
  -- *
  -- * \return The arity of the declaration.
  --  

   function msat_decl_get_arity (arg1 : msat_decl) return sys_utypes_usize_t_h.size_t;  -- mathsat.h:2178
   pragma Import (C, msat_decl_get_arity, "msat_decl_get_arity");

  --*
  -- * \brief Returns the type of the given argument for the input declaration.
  -- *
  -- * \param d A declaration
  -- * \param n The index of the argument for which the type is needed
  -- *
  -- * \return The type of the given argument, or MSAT_U on error.
  --  

   function msat_decl_get_arg_type (arg1 : msat_decl; arg2 : sys_utypes_usize_t_h.size_t) return msat_type;  -- mathsat.h:2188
   pragma Import (C, msat_decl_get_arg_type, "msat_decl_get_arg_type");

  --*
  -- * \brief Returns the name corresponding to the given declaration.
  -- *
  -- * \param d A declaration
  -- *
  -- * \return The name of the given declaration. The returned string must be
  -- *         deallocated by the user with ::msat_free(). NULL is returned in
  -- *         case of error.
  --  

   function msat_decl_get_name (arg1 : msat_decl) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2199
   pragma Import (C, msat_decl_get_name, "msat_decl_get_name");

  --*
  -- * \brief Returns an internal string representation of a declaration.
  -- *
  -- * The returned string can be useful for debugging purposes only, as
  -- * it is an internal representation of a declaration
  -- *
  -- * \param d A declaration.
  -- * \return a string reprsentation of \a d, or NULL in case of errors. The
  -- *         string must be dellocated by the caller with ::msat_free().
  --  

   function msat_decl_repr (arg1 : msat_decl) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2212
   pragma Import (C, msat_decl_repr, "msat_decl_repr");

  --*
  -- * \brief Returns an internal string representation of a term
  -- *
  -- * The returned string can be useful for debugging purposes only, as
  -- * it is an internal representation of a term
  -- *
  -- * \param t A term.
  -- * \return a string reprsentation of \a t, or NULL in case of errors. The
  -- *         string must be dellocated by the caller with ::msat_free().
  --  

   function msat_term_repr (arg1 : msat_term) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2225
   pragma Import (C, msat_term_repr, "msat_term_repr");

  --@} 
  -- end of Term access and navigation group  
  --*
  -- * \name Term parsing/printing
  --  

  --*
  -- * \brief Creates a term from its string representation
  -- *
  -- * The syntax of \a repr is that of the SMT-LIB v2. All
  -- * the variables and functions must have been previously declared in \a e.
  -- *
  -- * \param e The environment of the definition
  -- * \param repr The string to parse, in SMT-LIB v2 syntax
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_from_string (arg1 : msat_env; arg2 : Interfaces.C.Strings.chars_ptr) return msat_term;  -- mathsat.h:2245
   pragma Import (C, msat_from_string, "msat_from_string");

  --*
  -- * \brief Creates a term from a string in SMT-LIB v1 format.
  -- *
  -- * \param e The environment in which to create the term.
  -- * \param data The string representation in SMT-LIB v1 format.
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_from_smtlib1 (arg1 : msat_env; arg2 : Interfaces.C.Strings.chars_ptr) return msat_term;  -- mathsat.h:2256
   pragma Import (C, msat_from_smtlib1, "msat_from_smtlib1");

  --*
  -- * \brief Creates a term from a file in SMT-LIB v1 format.
  -- *
  -- * \param e The environment in which to create the term.
  -- * \param f The file in SMT-LIB v1 format.
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_from_smtlib1_file (arg1 : msat_env; arg2 : access stdio_h.FILE) return msat_term;  -- mathsat.h:2266
   pragma Import (C, msat_from_smtlib1_file, "msat_from_smtlib1_file");

  --*
  -- * \brief Creates a term from a string in SMT-LIB v2 format.
  -- *
  -- * \param e The environment in which to create the term.
  -- * \param data The string representation in SMT-LIB v2 format.
  -- *             It can't contain commands other than functions and type
  -- *             declarations, definitions, and assertions
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_from_smtlib2 (arg1 : msat_env; arg2 : Interfaces.C.Strings.chars_ptr) return msat_term;  -- mathsat.h:2278
   pragma Import (C, msat_from_smtlib2, "msat_from_smtlib2");

  --*
  -- * \brief Creates a term from a file in SMT-LIB v2 format.
  -- *
  -- * \param e The environment in which to create the term.
  -- * \param f The file in SMT-LIB v2 format.
  -- *          It can't contain commands other than functions and type
  -- *          declarations, definitions, and assertions
  -- * \return The created term, or a t s.t. ::MSAT_ERROR_TERM(t) is true
  -- *         in case of errors.
  --  

   function msat_from_smtlib2_file (arg1 : msat_env; arg2 : access stdio_h.FILE) return msat_term;  -- mathsat.h:2290
   pragma Import (C, msat_from_smtlib2_file, "msat_from_smtlib2_file");

  --*
  -- * \brief Converts the given \a term to SMT-LIB v1 format
  -- *
  -- * \param e The environment in which \a term is defined
  -- * \param term The term to convert
  -- * 
  -- * \return a string in SMT-LIB v1 format for the formula represented by \a
  -- *         term, or NULL in case of errors. If not NULL, the returned string
  -- *         must be deallocated by the user with ::msat_free().
  --  

   function msat_to_smtlib1 (arg1 : msat_env; arg2 : msat_term) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2303
   pragma Import (C, msat_to_smtlib1, "msat_to_smtlib1");

  --*
  -- * \brief Dumps the given \a term in SMT-LIB v1 format to the given output file
  -- *
  -- * \param e The environment in which \a term is defined
  -- * \param term The term to convert
  -- * \param out The output file
  -- * \return zero on success, nonzero on error.
  --  

   function msat_to_smtlib1_file
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access stdio_h.FILE) return int;  -- mathsat.h:2314
   pragma Import (C, msat_to_smtlib1_file, "msat_to_smtlib1_file");

  --*
  -- * \brief Converts the given \a term to SMT-LIB v2 format
  -- *
  -- * \param e The environment in which \a term is defined
  -- * \param term The term to convert
  -- * 
  -- * \return a string in SMT-LIB v2 format for the formula represented by \a
  -- *         term, or NULL in case of errors. If not NULL, the returned string
  -- *         must be deallocated by the user with ::msat_free().
  --  

   function msat_to_smtlib2 (arg1 : msat_env; arg2 : msat_term) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2327
   pragma Import (C, msat_to_smtlib2, "msat_to_smtlib2");

  --*
  -- * \brief Dumps the given \a term in SMT-LIB v2 format to the given output file
  -- *
  -- * \param e The environment in which \a term is defined
  -- * \param term The term to convert
  -- * \param out The output file
  -- * \return zero on success, nonzero on error.
  --  

   function msat_to_smtlib2_file
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : access stdio_h.FILE) return int;  -- mathsat.h:2338
   pragma Import (C, msat_to_smtlib2_file, "msat_to_smtlib2_file");

  --*
  -- * \brief Converts the given \a term to SMT-LIB v2 format
  -- * 
  -- * \param e The environment in which \a term is defined
  -- * \param term The term to convert
  -- * \param logic_name Name of the SMT-LIBv2 logic for the output. Can be NULL
  -- * \param use_defines If nonzero, the output will contain define-funs instead
  -- *                    of let bindings
  -- * 
  -- * \return a string in SMT-LIB v2 format for the formula represented by \a
  -- *         term, or NULL in case of errors. If not NULL, the returned string
  -- *         must be deallocated by the user with ::msat_free().
  --  

   function msat_to_smtlib2_ext
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : int) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2354
   pragma Import (C, msat_to_smtlib2_ext, "msat_to_smtlib2_ext");

  --*
  -- * \brief Prints a single term in SMT-LIB v2 format
  -- *
  -- * Contrary to ::msat_to_smtlib2(), this function does not print symbol
  -- * declarations, and so it can be used to obtain a valid SMT-LIBv2
  -- * representation of the given \a term.
  -- *
  -- * \param The environment in which \a term is defined
  -- * \param term The term to print
  -- *
  -- * \return a string in SMT-LIB v2 format for the given \a term, or NULL in
  -- *         case of errors. If not NULL, the returned string must be
  -- *         deallocated by the user with ::msat_free().
  --  

   function msat_to_smtlib2_term (arg1 : msat_env; arg2 : msat_term) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2372
   pragma Import (C, msat_to_smtlib2_term, "msat_to_smtlib2_term");

  --*
  -- * \brief Dumps the given \a term in SMT-LIB v2 format to the given output file
  -- * 
  -- * \param e The environment in which \a term is defined
  -- * \param term The term to convert
  -- * \param logic_name Name of the SMT-LIBv2 logic for the output. Can be NULL
  -- * \param use_defines If nonzero, the output will contain define-funs instead
  -- *                    of let bindings
  -- * \param out The output file
  -- *                    
  -- * \return zero on success, nonzero on error.
  --  

   function msat_to_smtlib2_ext_file
     (arg1 : msat_env;
      arg2 : msat_term;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : int;
      arg5 : access stdio_h.FILE) return int;  -- mathsat.h:2387
   pragma Import (C, msat_to_smtlib2_ext_file, "msat_to_smtlib2_ext_file");

  --*
  -- * \brief Parses a list of named terms from a strin SMT-LIB v2 format.
  -- *
  -- * Given a string in SMT-LIB v2 format, collect and return all the terms with
  -- * a :named annotation.
  -- *
  -- * \param e Then environment in which terms are created
  -- * \param data The input string in SMT-LIBv2 format
  -- * 
  -- * \param out_n On success, the number of named terms is stored here. Must not
  -- *              be NULL.
  -- *
  -- * \param out_names On success, the names of the parsed terms are stored here.
  -- *                  Must not be NULL. Both the array and its elements are
  -- *                  dynamically allocated, and must be deallocated by the user
  -- *                  with ::msat_free()
  -- *
  -- * \param out_terms On success, the parsed named terms are stored here. Must
  -- *                  not be NULL. The array is dynamically allocated, and must
  -- *                  be deallocated by the user with ::msat_free()
  -- *
  -- * \return zero on success, nonzero on error.
  --  

   function msat_named_list_from_smtlib2
     (arg1 : msat_env;
      arg2 : Interfaces.C.Strings.chars_ptr;
      arg3 : access sys_utypes_usize_t_h.size_t;
      arg4 : System.Address;
      arg5 : System.Address) return int;  -- mathsat.h:2414
   pragma Import (C, msat_named_list_from_smtlib2, "msat_named_list_from_smtlib2");

  --*
  -- * \brief Like ::msat_named_list_from_smtlib2(), but reads from a file instead
  -- * of a string.
  -- *
  -- * Given a FILE in SMT-LIB v2 format, collect and return all the terms with
  -- * a :named annotation.
  -- *
  -- * \param e Then environment in which terms are created
  -- * \param f The input file in SMT-LIBv2 format
  -- * 
  -- * \param out_n On success, the number of named terms is stored here. Must not
  -- *              be NULL.
  -- *
  -- * \param out_names On success, the names of the parsed terms are stored here.
  -- *                  Must not be NULL. Both the array and its elements are
  -- *                  dynamically allocated, and must be deallocated by the user
  -- *                  with ::msat_free()
  -- *
  -- * \param out_terms On success, the parsed named terms are stored here. Must
  -- *                  not be NULL. The array is dynamically allocated, and must
  -- *                  be deallocated by the user with ::msat_free()
  -- *
  -- * \return zero on success, nonzero on error.
  --  

   function msat_named_list_from_smtlib2_file
     (arg1 : msat_env;
      arg2 : access stdio_h.FILE;
      arg3 : access sys_utypes_usize_t_h.size_t;
      arg4 : System.Address;
      arg5 : System.Address) return int;  -- mathsat.h:2443
   pragma Import (C, msat_named_list_from_smtlib2_file, "msat_named_list_from_smtlib2_file");

  --*
  -- * \brief Converts the given list of named terms to SMT-LIB v2 format
  -- *
  -- * \param e The environment in which the terms are defined
  -- * \param n The number of terms/names to dump
  -- * \param names An array of names for the terms
  -- * \param terms The terms to convert
  -- *
  -- * \return a string in SMT-LIB v2 format storing all the named input terms, or
  -- *         NULL in case of errors. If not NULL, the returned string must be
  -- *         deallocated by the user with ::msat_free().
  --  

   function msat_named_list_to_smtlib2
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : System.Address;
      arg4 : access msat_term) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2459
   pragma Import (C, msat_named_list_to_smtlib2, "msat_named_list_to_smtlib2");

  --*
  -- * \brief Dumps the given list of named terms in SMT-LIB v2 format to the
  -- * given output file.
  -- *
  -- * \param e The environment in which the terms are defined
  -- * \param n The number of terms/names to dump
  -- * \param names An array of names for the terms
  -- * \param terms The terms to convert
  -- * \param out The output file
  -- *
  -- * \return zero on success, nonzero on error.
  --  

   function msat_named_list_to_smtlib2_file
     (arg1 : msat_env;
      arg2 : sys_utypes_usize_t_h.size_t;
      arg3 : System.Address;
      arg4 : access msat_term;
      arg5 : access stdio_h.FILE) return int;  -- mathsat.h:2475
   pragma Import (C, msat_named_list_to_smtlib2_file, "msat_named_list_to_smtlib2_file");

  --@} 
  -- end of Term parsing/printing group  
  --*
  -- * \name Problem solving
  --  

  --@{ 
  --*
  -- * \brief Pushes a checkpoint for backtracking in an environment
  -- *
  -- * \param e The environment in which to operate
  -- * \return zero on success, nonzero on error
  --  

   function msat_push_backtrack_point (arg1 : msat_env) return int;  -- mathsat.h:2493
   pragma Import (C, msat_push_backtrack_point, "msat_push_backtrack_point");

  --*
  -- * \brief Backtracks to the last checkpoint set in the environment \a e
  -- *
  -- * \param e The environment in which to operate
  -- * \return zero on success, nonzero on error
  --  

   function msat_pop_backtrack_point (arg1 : msat_env) return int;  -- mathsat.h:2501
   pragma Import (C, msat_pop_backtrack_point, "msat_pop_backtrack_point");

  --*
  -- * \brief returns the number of backtrack points in the given environment
  --  

   function msat_num_backtrack_points (arg1 : msat_env) return sys_utypes_usize_t_h.size_t;  -- mathsat.h:2506
   pragma Import (C, msat_num_backtrack_points, "msat_num_backtrack_points");

  --*
  -- * \brief Resets an environment.
  -- *
  -- * Clears the assertion stack (see ::msat_assert_formula,
  -- * ::msat_push_backtrack_point, ::msat_pop_backtrack_point) of \a e.
  -- * However, terms created in \a e are still valid.
  -- * 
  -- * \param e The environment to reset
  -- * \return zero on success, nonzero on error
  --  

   function msat_reset_env (arg1 : msat_env) return int;  -- mathsat.h:2518
   pragma Import (C, msat_reset_env, "msat_reset_env");

  --*
  -- * \brief Adds a logical formula to an environment
  -- * \param e The environment in which the formula is asserted
  -- * \param formula The formula to assert. Must have been created in \a e,
  -- *        otherwise bad things will happen (probably a crash)
  -- * \return zero on success, nonzero on error
  --  

   function msat_assert_formula (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2527
   pragma Import (C, msat_assert_formula, "msat_assert_formula");

  --*
  -- * \brief Adds a Boolean variable at the end of the list of preferred
  -- *        variables for branching when solving the problem
  -- *
  -- * \param e The environment in which to operate
  -- * \param boolvar The Boolean variable to add to the preferred list
  -- * \return zero on success, nonzero on error
  --  

   function msat_add_preferred_for_branching (arg1 : msat_env; arg2 : msat_term) return int;  -- mathsat.h:2537
   pragma Import (C, msat_add_preferred_for_branching, "msat_add_preferred_for_branching");

  --*
  -- * \brief Clears the list of preferred variables for branching
  -- *
  -- * \param e The environment in which to operate
  -- * \return zero on success, nonzero on error
  --  

   function msat_clear_preferred_for_branching (arg1 : msat_env) return int;  -- mathsat.h:2545
   pragma Import (C, msat_clear_preferred_for_branching, "msat_clear_preferred_for_branching");

  --*
  -- * \brief Checks the satiafiability of the given environment.
  -- *
  -- * Checks the satisfiability of the conjunction of all the formulas asserted
  -- * in \a e (see ::msat_assert_formula). Before calling this function, the
  -- * right theory solvers must have been enabled (see ::msat_add_theory).
  -- *
  -- * \param e The environment to check.
  -- * \return ::MSAT_SAT if the problem is satisfiable, ::MSAT_UNSAT if it is
  -- *         unsatisfiable, and ::MSAT_UNKNOWN if there was some error or if
  -- *         the satisfiability can't be determined.
  --  

   function msat_solve (arg1 : msat_env) return msat_result;  -- mathsat.h:2559
   pragma Import (C, msat_solve, "msat_solve");

  --*
  -- * \brief Checks the satiafiability of the given environment
  -- *        under the given assumptions
  -- *
  -- * Checks the satisfiability of the conjunction of all the formulas asserted
  -- * in \a e (see ::msat_assert_formula), plus the conjunction of the given
  -- * assumptions, which can only be (negated) Boolean constants.
  -- * If ::MSAT_UNSAT is returned, the function ::msat_get_unsat_assumptions()
  -- * can be used to retrieve the list of assumptions responsible for the
  -- * inconsistency.
  -- *
  -- * \param e The environment to check.
  -- * \param assumptions The list of assumptions. Can only be (negated) Boolean
  -- *                    constants
  -- * \param num_assumptions The number of assumptions.
  -- * \return ::MSAT_SAT if the problem is satisfiable, ::MSAT_UNSAT if it is
  -- *         unsatisfiable, and ::MSAT_UNKNOWN if there was some error or if
  -- *         the satisfiability can't be determined.
  -- *         This function is not compatible with the incremental interface. If
  -- *         there are some active backtracking points, ::MSAT_UNKNOWN will be
  -- *         returned.
  --  

   function msat_solve_with_assumptions
     (arg1 : msat_env;
      arg2 : access msat_term;
      arg3 : sys_utypes_usize_t_h.size_t) return msat_result;  -- mathsat.h:2583
   pragma Import (C, msat_solve_with_assumptions, "msat_solve_with_assumptions");

  --*
  -- * \brief Performs AllSat over the \a important atoms of the conjunction
  -- * of all formulas asserted in \a e (see ::msat_assert_formula). When used
  -- * in incremental mode, a backtrack point should be pushed before calling this
  -- * function, and popped after this call has completed. Not doing this changes
  -- * the satisfiability of the formula.
  -- *
  -- * \param e The environment to use
  -- * \param important An array of important atoms. If NULL, all atoms are
  -- *                  considered important
  -- * \param num_important The size of the \a important array. If \a important is
  -- *                      NULL, set this to zero
  -- * \param func The callback function to be notified about models found (see
  -- *             ::msat_all_sat_model_callback). Cannot be NULL
  -- * \param user_data Generic data pointer which will be passed to \a func. Can
  -- *                  be anything, its value will not be interpreted
  -- * \return The number of models found, or -1 on error. If the formula has an
  -- *         infinite number of models, -2 is returned.
  --  

   function msat_all_sat
     (arg1 : msat_env;
      arg2 : access msat_term;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : msat_all_sat_model_callback;
      arg5 : System.Address) return int;  -- mathsat.h:2606
   pragma Import (C, msat_all_sat, "msat_all_sat");

  --*
  -- * \brief Enumerates diverse models over the asserted stack.
  -- *
  -- * Can only be called when model generation is on and proof generation is off.
  -- * 
  -- * Notice that this function changes the asserted formula in order to generate
  -- * the diverse models, by adding clauses based on the diversifiers. When used
  -- * in incremental mode a backtrack point should be pushed before calling this
  -- * function, and popped after this call has completed. Not doing this changes
  -- * the satisfiability of the formula.
  -- * 
  -- * \param e The environment to use
  -- * \param diversifiers the terms over which to diversify. On each
  -- *        succesive model, at least one of these terms will have a different
  -- *        value.
  -- * \param num_diversifiers the size of the \a diversifiers array.
  -- * \param func The callback function to be notified about models found (see
  -- *             ::msat_solve_diversify_model_callback). Cannot be NULL.
  -- * \param user_data Generic data pointer which will be passed to \a func. Can
  -- *                  be anything, its value will not be interpreted
  -- *                  
  -- * \return The number of models found, or -1 on error.
  -- *         (If the formula is unsat, 0 is returned).
  --  

   function msat_solve_diversify
     (arg1 : msat_env;
      arg2 : access msat_term;
      arg3 : sys_utypes_usize_t_h.size_t;
      arg4 : msat_solve_diversify_model_callback;
      arg5 : System.Address) return int;  -- mathsat.h:2633
   pragma Import (C, msat_solve_diversify, "msat_solve_diversify");

  --*
  -- * \brief Returns the list of formulas in the assertion stack.
  -- *
  -- * The return value is a dynamically-allocated array of *num_asserted
  -- * elements, which must be deallocated by the user. NULL is returned in case of
  -- * errors. The array elements are formulas that are logically equivalent to
  -- * the one asserted using ::msat_assert_formula
  -- *
  -- * \param e The environment in which to operate.
  -- * \param num_asserted Pointer to a valid address for storing the number
  -- *                     of formulas currently in the assertion stack.
  -- *                     
  -- * \return An array with the asserted formulas, or NULL in case of errors.
  -- *         The array is must be deallocated by allocated the user with
  -- *         ::msat_free().
  --  

   function msat_get_asserted_formulas (arg1 : msat_env; arg2 : access sys_utypes_usize_t_h.size_t) return access msat_term;  -- mathsat.h:2654
   pragma Import (C, msat_get_asserted_formulas, "msat_get_asserted_formulas");

  --*
  -- * \brief Retrieves the theory lemmas used in the last search (see
  -- *        ::msat_solve).
  -- *
  -- * For the function to work, the option "dpll.store_tlemmas" must be set to
  -- * "true" in the configuration object for the environment.
  -- *        
  -- * \param e The environment in which to operate.
  -- * \param num_tlemmas Pointer to a valid address for storing the number
  -- *                    of theory lemmas returned.
  -- *                    
  -- * \return An array with the theory lemmas, or NULL in case of errors.
  -- *         The array must be deallocated by the user with ::msat_free().
  --  

   function msat_get_theory_lemmas (arg1 : msat_env; arg2 : access sys_utypes_usize_t_h.size_t) return access msat_term;  -- mathsat.h:2670
   pragma Import (C, msat_get_theory_lemmas, "msat_get_theory_lemmas");

  --*
  -- * \brief Returns a string with search statistics for the given environment.
  -- *
  -- * The returned string will contain newline-separated statistics for the DPLL
  -- * engine and the active theory solvers in the given environment.
  -- *
  -- * \param e The environment in which to operate.
  -- * \return A string with search statistics, or NULL in case of errors.
  -- *         The string must be deallocated by the oser with ::msat_free(). 
  --  

   function msat_get_search_stats (arg1 : msat_env) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2683
   pragma Import (C, msat_get_search_stats, "msat_get_search_stats");

  --@} 
  -- end of Problem solving group  
  --*
  -- * \name Interpolation
  --  

  --@{ 
  --*
  -- * \brief Creates a new group for interpolation.
  -- *
  -- * When computing an interpolant, formulas are organized into several groups,
  -- * which are partitioned into two sets GA and GB. The conjuction of formulas
  -- * in GA will play the role of A, and that of formulas in GB will play the
  -- * role of B (see ::msat_set_itp_group, ::msat_get_interpolant).
  -- *
  -- * \param e The environment in which to operate.
  -- * \return an identifier for the new group, or -1 in case of error.
  --  

   function msat_create_itp_group (arg1 : msat_env) return int;  -- mathsat.h:2704
   pragma Import (C, msat_create_itp_group, "msat_create_itp_group");

  --*
  -- * \brief Sets the current interpolation group.
  -- *
  -- * All the formulas asserted after this call (with ::msat_assert_formula) will
  -- * belong to \a group.
  -- *
  -- * \param e The environment in which to operate.
  -- * \param group The group. Must have been previously created with
  -- *        ::msat_create_itp_group.
  -- * \return zero on success, nonzero on error.
  --  

   function msat_set_itp_group (arg1 : msat_env; arg2 : int) return int;  -- mathsat.h:2717
   pragma Import (C, msat_set_itp_group, "msat_set_itp_group");

  --*
  -- * \brief Computes an interpolant for a pair (A, B) of formulas.
  -- *
  -- * A is the conjucntion of all the assumed formulas in the \a groups_of_a
  -- * groups (see ::msat_create_itp_group), and B is the rest of assumed
  -- * formulas.
  -- *
  -- * This function must be called only after ::msat_solve, and only if
  -- * MSAT_UNSAT was returned. Moreover, interpolation must have been enabled in
  -- * the configuration for the environment
  -- *
  -- * \param e The environment in which to operate.
  -- * \param groups_of_a An array of group identifiers.
  -- * \param n The size of the \a groups_of_a array.
  -- * \return The interpolating term, or a t s.t. MSAT_ERROR_TERM(t) is true in
  -- *         case of errors.
  --  

   function msat_get_interpolant
     (arg1 : msat_env;
      arg2 : access int;
      arg3 : sys_utypes_usize_t_h.size_t) return msat_term;  -- mathsat.h:2736
   pragma Import (C, msat_get_interpolant, "msat_get_interpolant");

  --@} 
  -- end of interpolation group  
  --*
  -- * \name Model Computation
  --  

  --@{ 
  --*
  -- * \brief Returns the value of the term \a term in the current model
  -- *
  -- * Preconditions:
  -- * - model computation was enabled in the configuration of the environment
  -- * - the last call to ::msat_solve returned a ::MSAT_SAT result
  -- * - no assert/push/pop/allsat commands have been issued in the meantime
  -- * 
  -- * \param e The environment in use
  -- * \param term The term of interest.
  -- * \return The model value for \a term. If an error occurs, the return value
  -- *         \a ret is such that MSAT_ERROR_TERM(ret) is true
  --  

   function msat_get_model_value (arg1 : msat_env; arg2 : msat_term) return msat_term;  -- mathsat.h:2759
   pragma Import (C, msat_get_model_value, "msat_get_model_value");

  --*
  -- * \brief Creates a model iterator
  -- * \param e The environment in use
  -- * \return an iterator for the current model
  --  

   function msat_create_model_iterator (arg1 : msat_env) return msat_model_iterator;  -- mathsat.h:2766
   pragma Import (C, msat_create_model_iterator, "msat_create_model_iterator");

  --*
  -- * \brief Checks whether \a i can be incremented
  -- * \param i A model iterator
  -- * \return nonzero if \a i can be incremented, zero otherwise
  --  

   function msat_model_iterator_has_next (arg1 : msat_model_iterator) return int;  -- mathsat.h:2773
   pragma Import (C, msat_model_iterator_has_next, "msat_model_iterator_has_next");

  --*
  -- * \brief Returns the next (term, value) pair in the model, and increments the
  -- *        given iterator.
  -- * \param i The model iterator to increment.
  -- * \param t Output value for the next variable/function call in the model.
  -- * \param v Output value for the next value in the model.
  -- * \return nonzero in case of error.
  --  

   function msat_model_iterator_next
     (arg1 : msat_model_iterator;
      arg2 : access msat_term;
      arg3 : access msat_term) return int;  -- mathsat.h:2783
   pragma Import (C, msat_model_iterator_next, "msat_model_iterator_next");

  --*
  -- * \brief Destroys a model iterator.
  -- * \param i the iterator to destroy.
  --  

   procedure msat_destroy_model_iterator (arg1 : msat_model_iterator);  -- mathsat.h:2789
   pragma Import (C, msat_destroy_model_iterator, "msat_destroy_model_iterator");

  --@} 
  -- end of model computation group  
  --*
  -- * \name Unsat Core Computation
  --  

  --@{ 
  --*
  -- * \brief Returns the unsatisfiable core of the last search (see ::msat_solve)
  -- *        as a subset of the asserted formulas, if the problem was
  -- *        unsatisfiable.
  -- *
  -- * \param e The environment in which to operate.
  -- * \param core_size Pointer to a valid address for storing the number
  -- *                  of formulas in the unsat core.
  -- * \return An array with the unsat core, or NULL in case of errors.
  -- *         The array must be deallocated by the user with ::msat_free().
  --  

   function msat_get_unsat_core (arg1 : msat_env; arg2 : access sys_utypes_usize_t_h.size_t) return access msat_term;  -- mathsat.h:2809
   pragma Import (C, msat_get_unsat_core, "msat_get_unsat_core");

  --*
  -- * \brief Returns the unsatisfiable core of the last search (see ::msat_solve)
  -- *        as a subset of the asserted formulas, computed using an external
  -- *        Boolean unsat core extractor (see ::msat_ext_unsat_core_extractor).
  -- *
  -- * \param e The environment in which to operate.
  -- * \param core_size Pointer to a valid address for storing the number of
  -- *                  formulas in the unsat core.
  -- * \param extractor The external Boolean core extractor.
  -- * \param user_data Generic data pointer which will be passed to \a extractor.
  -- *                  Can be anything, its value will not be interpreted.
  -- * \return An array with the unsat core, or NULL in case of errors.
  -- *         The array must be deallocated by the user with ::msat_free().
  --  

   function msat_get_unsat_core_ext
     (arg1 : msat_env;
      arg2 : access sys_utypes_usize_t_h.size_t;
      arg3 : msat_ext_unsat_core_extractor;
      arg4 : System.Address) return access msat_term;  -- mathsat.h:2825
   pragma Import (C, msat_get_unsat_core_ext, "msat_get_unsat_core_ext");

  --*
  -- * \brief Returns the list of assumptions resposible for the unsatisfiability
  -- * detected by the last search (see ::msat_solve_with_assumptions).
  -- *
  -- * \param e The environment in which to operate.
  -- * \param assumps_size Pointer to a valid address for storing the number
  -- *                     of formulas in the returned array.
  -- *                     
  -- * \return An array with the list of inconsistent assumptions, or NULL in case
  -- *         of errors. The array must be deallocated by the user with
  -- *         ::msat_free().
  --  

   function msat_get_unsat_assumptions (arg1 : msat_env; arg2 : access sys_utypes_usize_t_h.size_t) return access msat_term;  -- mathsat.h:2842
   pragma Import (C, msat_get_unsat_assumptions, "msat_get_unsat_assumptions");

  --*
  -- * \brief Returns a proof manager for the given environment.
  -- *
  -- * The manager must be destroyed by the user, with ::msat_destroy_proof_manager.
  -- * In order to obtain a non-error result, the option "proof_generation" must
  -- * be set to "true" in the configuration used for creating the environment.
  -- *
  -- * \param e The environment in which to operate.
  -- * 
  -- * \return A proof manager for the environment. MSAT_ERROR_PROOF_MANAGER can
  -- *         be used to check whether an error occurred.
  --  

   function msat_get_proof_manager (arg1 : msat_env) return msat_proof_manager;  -- mathsat.h:2856
   pragma Import (C, msat_get_proof_manager, "msat_get_proof_manager");

  --*
  -- * \brief Destroys a proof manager.
  -- *
  -- * Destroying a proof manager will also destroy all the proofs associated with
  -- * it.
  -- * 
  -- * \param m The proof manager to destroy.
  --  

   procedure msat_destroy_proof_manager (arg1 : msat_proof_manager);  -- mathsat.h:2866
   pragma Import (C, msat_destroy_proof_manager, "msat_destroy_proof_manager");

  --*
  -- * \brief Returns a proof of unsatisfiability.
  -- *
  -- * a proof is recursively defined as:
  -- *
  -- *   msat_proof ::= msat_term
  -- *               |  name msat_proof*
  -- * 
  -- * i.e., it is either a term or a list of a name and children proofs.
  -- * Proofs can be distinguished by their name, or by whether they are
  -- * terms. Relevant proofs include:
  -- * 
  -- * "clause-hyp", which are the clauses of the (CNF conversion of the) input
  -- * problem. They have a list of terms as children
  -- * 
  -- * "res-chain", representing Boolean resolution chains. The children are an
  -- * interleaving of proofs and terms, where terms are the pivots for the
  -- * resolution. For example:
  -- *    "res-chain p1 v p2" represents a resolution step between p1 and p2 on
  -- *    the pivot v
  -- * 
  -- * "theory-lemma", representing theory lemmas. They have as
  -- * children a list of terms that consititute the lemma, plus an optional
  -- * last element which is a more detailed proof produced by a theory solver.
  -- *
  -- * \param m The proof manager in which to operate.
  -- * 
  -- * \return The proof of unsatisfiability associated to the latest
  -- *         ::msat_solve() call, or an object p s.t. MSAT_ERROR_PROOF(p) is
  -- *         true in case of errors.
  --  

   function msat_get_proof (arg1 : msat_proof_manager) return msat_proof;  -- mathsat.h:2899
   pragma Import (C, msat_get_proof, "msat_get_proof");

  --*
  -- * \brief Returns a numeric identifier for \a p
  -- *
  -- * The returned value is guaranteed to be unique within the proof manager in
  -- * which \a p was defined. Therefore, it can be used to test two proofs for
  -- * equality, as well as a hash value.
  -- *
  -- * \param p A proof. 
  -- * \return a unique (within the defining manager) numeric identifier
  --  

   function msat_proof_id (arg1 : msat_proof) return sys_utypes_usize_t_h.size_t;  -- mathsat.h:2911
   pragma Import (C, msat_proof_id, "msat_proof_id");

  --*
  -- * \brief Checks whether a proof object is a term.
  -- *
  -- * \param p The proof to test.
  -- *
  -- * \return nonzero if \a p is a term proof, zero otherwise.
  --  

   function msat_proof_is_term (arg1 : msat_proof) return int;  -- mathsat.h:2920
   pragma Import (C, msat_proof_is_term, "msat_proof_is_term");

  --*
  -- * \brief Retrieves the term associated to a term proof.
  -- *
  -- * \param p The proof from which to get the term. Must be a term proof.
  -- *
  -- * \return The term associated with the input proof.
  --  

   function msat_proof_get_term (arg1 : msat_proof) return msat_term;  -- mathsat.h:2929
   pragma Import (C, msat_proof_get_term, "msat_proof_get_term");

  --*
  -- * \brief Retrieves the name of a non-term proof.
  -- *
  -- * \param p A non-term proof.
  -- *
  -- * \return The name of the given proof.
  --  

   function msat_proof_get_name (arg1 : msat_proof) return Interfaces.C.Strings.chars_ptr;  -- mathsat.h:2938
   pragma Import (C, msat_proof_get_name, "msat_proof_get_name");

  --*
  -- * \brief Retrieves the number of children of a non-term proof.
  -- *
  -- * \param p A non-term proof.
  -- *
  -- * \return The arity of the given proof.
  --  

   function msat_proof_get_arity (arg1 : msat_proof) return sys_utypes_usize_t_h.size_t;  -- mathsat.h:2947
   pragma Import (C, msat_proof_get_arity, "msat_proof_get_arity");

  --*
  -- * \brief Retrieves a sub-proof of a given proof.
  -- *
  -- * \param p A non-term proof.
  -- * \param i The index of the child proof to retrieve.
  -- *
  -- * \return a Child proof of the given proof.
  --  

   function msat_proof_get_child (arg1 : msat_proof; arg2 : sys_utypes_usize_t_h.size_t) return msat_proof;  -- mathsat.h:2957
   pragma Import (C, msat_proof_get_child, "msat_proof_get_child");

  --@} 
  -- end of unsat core computation group  
  --*
  -- * \name External SAT Solver Interface
  --  

  --@{ 
  --*
  -- * \brief Callback object for using an external SAT solver as DPLL engine in
  -- * MathSAT.
  --  

   type msat_dpll_callback is record
      repr : System.Address;  -- mathsat.h:2970
   end record;
   pragma Convention (C_Pass_By_Copy, msat_dpll_callback);  -- mathsat.h:2970

  --*
  -- * \brief Interface that external SAT solvers must implement.
  --  

  --*
  --     * \brief Creates a new variable in the SAT solver.
  --     * \param self Pointer to the SAT solver.
  --     * \return the DIMACS index of the new variable, or -1 in case of errors.
  --      

   type msat_ext_dpll_interface is record
      new_var : access function (arg1 : System.Address) return int;  -- mathsat.h:2981
      set_decision_var : access function
           (arg1 : System.Address;
            arg2 : int;
            arg3 : int) return int;  -- mathsat.h:2990
      set_frozen : access function
           (arg1 : System.Address;
            arg2 : int;
            arg3 : int) return int;  -- mathsat.h:2999
      add_clause : access function
           (arg1 : System.Address;
            arg2 : access int;
            arg3 : int;
            arg4 : int) return int;  -- mathsat.h:3010
      solve : access function
           (arg1 : System.Address;
            arg2 : access int;
            arg3 : System.Address) return msat_result;  -- mathsat.h:3028
      model_value : access function (arg1 : System.Address; arg2 : int) return msat_truth_value;  -- mathsat.h:3037
      enqueue_assignment : access function (arg1 : System.Address; arg2 : int) return int;  -- mathsat.h:3045
      remove_clauses_containing : access function (arg1 : System.Address; arg2 : int) return int;  -- mathsat.h:3054
      reset : access function (arg1 : System.Address) return int;  -- mathsat.h:3061
      set_callback : access function (arg1 : System.Address; arg2 : msat_dpll_callback) return int;  -- mathsat.h:3070
   end record;
   pragma Convention (C_Pass_By_Copy, msat_ext_dpll_interface);  -- mathsat.h:2975

  --*
  --     * \brief Marks a variable as a decision variable.
  --     * \param self Pointer to the SAT solver.
  --     * \param var the DIMACS index for the variable.
  --     * \param yes decision flag.
  --     * \return zero on success, nonzero on error.
  --      

  --*
  --     * \brief Sets the frozen status of a variable.
  --     * \param self Pointer to the SAT solver.
  --     * \param var the DIMACS index for the variable.
  --     * \param yes frozen flag.
  --     * \return zero on success, nonzero on error.
  --      

  --*
  --     * \brief Adds a clause to the SAT solver.
  --     * \param self Pointer to the SAT solver.
  --     * \param clause array of literals in DIMACS format, terminated by 0.
  --     * \param permanent If nonzero, the clause is meant to be permanent.
  --     * \param during_callback If nonzero, the function is called by one of the
  --     *                        ::msat_dpll_callback methods
  --     * \return zero on success, nonzero on error
  --      

  --*
  --     * \brief Checks the satisfiability (possibly under assumptions)
  --     *        of the list of added clauses.
  --     * \param self Pointer to the SAT solver.
  --     * \param assumptions array of literals in DIMACS format, terminated by 0.
  --     * \param out_conflicting_assumptions if the problem is unsatisfiable,
  --     *                                    this pointer should be set to a
  --     *                                    (zero-terminated) list of the
  --     *                                    assumptions responsible for the
  --     *                                    unsatisfiability. The solver should
  --     *                                    use its own internal storage for the
  --     *                                    array.
  --     * \return ::MSAT_SAT if the problem is satisfiable,
  --     *         ::MSAT_UNSAT if it is unsat, or ::MSAT_UNKNOWN in case of errors.
  --      

  --*
  --     * \brief Retrieves the model value for the given literal
  --     * \param self Pointer to the SAT solver.
  --     * \param lit literal in DIMACS format.
  --     * \return The truth value for the literal.
  --      

  --*
  --     * \brief Adds a (theory-deduced) literal to the current trail.
  --     * \param self Pointer to the SAT solver.
  --     * \param lit literal in DIMACS format.
  --     * \return zero on success, nonzero on error.
  --      

  --*
  --     * \brief Tells the solver to delete all the clauses containing the given
  --     *        variable.
  --     * \param self Pointer to the SAT solver.
  --     * \param var variable in DIMACS format.
  --     * \return zero on success, nonzero on error.
  --      

  --*
  --     * \brief Completely resets the state of the solver.
  --     * \param self Pointer to the SAT solver.
  --     * \return zero on success, nonzero on error.
  --      

  --*
  --     * \brief Associates to the solver a callback object for interacting with
  --     *        MathSAT.
  --     * \param self Pointer to the SAT solver.
  --     * \param cb The ::msat_dpll_callback object.
  --     * \return zero on success, nonzero on error.
  --      

  --*
  -- * \brief Sets an external dpll engine to be used by an environment
  -- * \param env The environment in which to operate.
  -- * \param engine The engine to use
  -- * \return zero on success, nonzero on error
  --  

   function msat_set_external_dpll_engine (arg1 : msat_env; arg2 : access msat_ext_dpll_interface) return int;  -- mathsat.h:3079
   pragma Import (C, msat_set_external_dpll_engine, "msat_set_external_dpll_engine");

  --*
  -- * \brief Callback function that the external SAT solver must call when a
  -- *        round of BCP has been completed without finding a Boolean conflict.
  -- *
  -- * The \a code value set by callback function tells the SAT solver what to do.
  -- *  - if it is ::MSAT_TRUE, the SAT solver can go on.
  -- * 
  -- *  - if it is ::MSAT_FALSE, MathSAT found a theory conflict, which is
  -- *    stored in \a conflict. The SAT solver is expected to perform conflict
  -- *    analysis on it and backjump.
  -- *
  -- *  - if it is ::MSAT_UNDEF, the SAT solver needs to perform another
  -- *    round of BCP, because MathSAT enqueued some new literals on the trail.
  -- *
  -- * \param cb The callback object to use.
  -- * \param code Pointer to a variable set by the callback function.
  -- * \param conflict Pointer for retrieving the theory conflict,
  -- *        when the \a code value is set to ::MSAT_FALSE.
  -- * \return zero on success, nonzero on error.
  --  

   function msat_dpll_callback_no_conflict_after_bcp
     (arg1 : msat_dpll_callback;
      arg2 : access msat_truth_value;
      arg3 : System.Address) return int;  -- mathsat.h:3102
   pragma Import (C, msat_dpll_callback_no_conflict_after_bcp, "msat_dpll_callback_no_conflict_after_bcp");

  --*
  -- * \brief Callback function that the external SAT solver must call when a
  -- *        Boolean model has been found.
  -- *
  -- * The \a code value set by callback function tells the SAT solver what to do.
  -- *  - if it is ::MSAT_TRUE, the model is theory satisfiable,
  -- *    so the formula is satisfiable.
  -- * 
  -- *  - if it is ::MSAT_FALSE, MathSAT found a theory conflict, which is
  -- *    stored in \a conflict. The SAT solver is expected to perform conflict
  -- *    analysis on it and backjump.
  -- *
  -- *  - if it is ::MSAT_UNDEF, MathSAT created some new variables
  -- *    that need to be assigned by the SAT solver, so the search should continue.
  -- *
  -- * \param cb The callback object to use.
  -- * \param code Pointer to a variable set by the callback function.
  -- * \param conflict Pointer for retrieving the theory conflict,
  -- *        when the \a code value is set to ::MSAT_FALSE.
  -- * \return zero on success, nonzero on error.
  --  

   function msat_dpll_callback_model_found
     (arg1 : msat_dpll_callback;
      arg2 : access msat_truth_value;
      arg3 : System.Address) return int;  -- mathsat.h:3127
   pragma Import (C, msat_dpll_callback_model_found, "msat_dpll_callback_model_found");

  --*
  -- * \brief Callback function that the external SAT solver must call whenever
  -- *        a literal is added to the trail.
  -- *
  -- * \param cb The callback object to use.
  -- * \param lit The assigned literal in DIMACS format.
  -- * \return zero on success, nonzero on error.
  --  

   function msat_dpll_callback_notify_assignment (arg1 : msat_dpll_callback; arg2 : int) return int;  -- mathsat.h:3138
   pragma Import (C, msat_dpll_callback_notify_assignment, "msat_dpll_callback_notify_assignment");

  --*
  -- * \brief Callback function that the external SAT solver must call whenever
  -- *        a new decision level is opened.
  -- *
  -- * \param cb The callback object to use.
  -- * \return zero on success, nonzero on error.
  --  

   function msat_dpll_callback_notify_new_level (arg1 : msat_dpll_callback) return int;  -- mathsat.h:3147
   pragma Import (C, msat_dpll_callback_notify_new_level, "msat_dpll_callback_notify_new_level");

  --*
  -- * \brief Callback function that the external SAT solver must call whenever
  -- *        it backtracks.
  -- *
  -- * \param cb The callback object to use.
  -- * \param level The target decision level for backtracking.
  -- * \return zero on success, nonzero on error.
  --  

   function msat_dpll_callback_notify_backtrack (arg1 : msat_dpll_callback; arg2 : int) return int;  -- mathsat.h:3157
   pragma Import (C, msat_dpll_callback_notify_backtrack, "msat_dpll_callback_notify_backtrack");

  --*
  -- * \brief Callback function that the external SAT solver must call for asking
  -- *        MathSAT the reason for a theory-deduced literal, during conflict
  -- *        analysis.
  -- *
  -- * \param cb The callback object to use.
  -- * \param level The literal whose reason needs to be computed.
  -- * \param reason Pointer to the zero-terminated reason clause for \a lit, with
  -- *               the first element being \a lit itself.
  -- * \return zero on success, nonzero on error.
  --  

   function Msat_Dpll_Callback_Ask_Theory_Reason( Arg1 : Msat_Dpll_Callback ;
						  Arg2 : Interfaces.C.Int ;
						  Arg3 : System.Address ) return Interfaces.C.Int ;
   pragma Import(C,Msat_Dpll_Callback_Ask_Theory_Reason,"msat_dpll_callback_ask_theory_reason") ;
   
end Mathsat;
