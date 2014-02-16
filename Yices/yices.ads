with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Yices is
   
   pragma Preelaborate ;
   
   --------------
   -- Typedefs --
   --------------
   
   -- Yices context 
   type Yices_Context is new System.Address ;
   
   -- Yices types (abstract syntax tree). 
   type Yices_Type is new System.Address ;
   
   type Yices_Type_Array is array(Integer range <>) of Yices_Type ;
   pragma Convention(C,Yices_Type_Array) ;
   --for Yices_Type_Array'Component_size use Yices_Type'Size ;
   
   -- Yices expressions (abstract syntax tree). 
   type Yices_Expr is new System.Address ;
   
   type Yices_Expr_Array is array(Integer range <>) of Yices_Expr ;
   pragma Convention(C,Yices_Expr_Array) ;
   --for Yices_Expr_Array'Component_size use System.Address'Size ;
      
   -- Variable declaration. 
   type Yices_Var_Decl is new System.Address ;

   -- Assertion index, to identify weighted and retractable assertions.  
   subtype Assertion_Id is Interfaces.C.Int ;
   
   type Assertion_Id_Array is array(Integer range <>) of Assertion_Id ;
   pragma Convention(C,Assertion_Id_Array) ;
   for Assertion_Id_Array'Component_size use Interfaces.C.Int'Size ;

   -- Model
   type Yices_Model is new System.Address ;
   
   --Iterator for scanning the boolean variables. 
   type Yices_Var_Decl_Iterator is new System.Address ;

   -- Extended booleans: to represent the value of literals in the context
   type Lbool is
     ( L_False ,
       L_Undef ,
       L_True ) ;
   
   for Lbool use
     ( L_False => -1 ,
       L_Undef => 0,
       L_True => 1 );
   
   pragma Convention(C,Lbool);
   
   -- String allocation structure used by:
   -- * yices_get_arith_value_as_string 
   -- * yices_free_string.
   type Srec_T is record
      Flag : Interfaces.C.Int ;
      Str : Interfaces.C.Strings.Chars_Ptr ;
   end record;
   
   pragma Convention(C,Srec_T) ;
   
   type Srec_T_Access is access all Srec_T ;
   
   type Bv_Array is array(Integer range <>) of Interfaces.C.Int ;
   pragma Convention(C,Bv_Array) ;
   for Bv_Array'Component_Size use Interfaces.C.int'Size;
   
   ---------------
   -- Functions --
   ---------------
   
   -- Return the yices version number. 
   function Yices_Version return Interfaces.C.Strings.Chars_Ptr ;
   pragma Import(C,Yices_Version,"yices_version") ;
   
   -- Set the verbosity level. 
   procedure Yices_Set_Verbosity( L : in Interfaces.C.Int ) ;
   pragma Import(C,Yices_Set_Verbosity,"yices_set_verbosity") ;

   -- Force Yices to type check expressions when they are asserted (default = false). 
   procedure Yices_Enable_Type_Checker( Flag : in Interfaces.C.Int ) ;
   pragma Import(C,Yices_Enable_Type_Checker,"yices_enable_type_checker") ;

   -- Enable a log file that will store the assertions, checks, declartationss, etc. 
   function Yices_Enable_Log_File( File_Name : in Interfaces.C.Strings.Chars_Ptr ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Enable_Log_File,"yices_enable_log_file") ;
   
   -- Inform Yices that only the arithmetic theory is going to be used.
   procedure Yices_Set_Arith_Only( Flag : in Interfaces.C.Int ) ;
   pragma Import(C,Yices_Set_Arith_Only,"yices_set_arith_only") ;
   
   -- Set the maximum number of conflicts that are allowed in a maxsat iteration. 
   procedure Yices_Set_Max_Num_Conflicts_In_Maxsat_Iteration( N : in Interfaces.C.Unsigned ) ;
   pragma Import(C,Yices_Set_Max_Num_Conflicts_In_Maxsat_Iteration,"yices_set_max_num_conflicts_in_maxsat_iteration") ;
   
   -- Set the maximum number of iterations in the MaxSAT algorithm. 
   procedure Yices_Set_Max_Num_Iterations_In_Maxsat( N : in Interfaces.C.Unsigned ) ;
   pragma Import(C,Yices_Set_Max_Num_Iterations_In_Maxsat,"yices_set_max_num_iterations_in_maxsat") ;

   -- Set the initial cost for a maxsat problem. 
   procedure Yices_Set_Maxsat_Initial_Cost( C : in Long_Long_Integer ) ;
   pragma Import(C,Yices_Set_Maxsat_Initial_Cost,"yices_set_maxsat_initial_cost") ;
   
   -- Create the logical context. 
   function Yices_Mk_Context return Yices_Context ;
   pragma Import(C,Yices_Mk_Context,"yices_mk_context") ;
   
   -- Delete the logical context. 
   procedure Yices_Del_Context( Ctx : in Yices_Context ) ;
   pragma Import(C,Yices_Del_Context,"yices_del_context") ;
   
   -- Reset the logical context. 
   procedure Yices_Reset( Ctx : in Yices_Context ) ;
   pragma Import(C,Yices_Reset,"yices_reset") ;
   
   -- Display the internal representation of the logical context on stderr. 
   procedure Yices_Dump_Context( Ctx : in Yices_Context ) ;
   pragma Import(C,Yices_Dump_Context,"yices_dump_context") ;
   
   -- Create a backtracking point. 
   procedure Yices_Push( Ctx : in Yices_Context ) ;
   pragma Import(C,Yices_Push,"yices_push") ;
   
   -- Backtrack. 
   procedure Yices_Pop( Ctx : in Yices_Context ) ;
   pragma Import(C,Yices_Pop,"yices_pop") ;
   
   -- Assert a constraint in the logical context. 
   procedure Yices_Assert( Ctx : in Yices_Context ; Expr : in Yices_Expr ) ;
   pragma Import(C,Yices_Assert,"yices_assert") ;
   
   -- Assert a constraint in the logical context with weight w.
   function Yices_Assert_Weighted( Ctx : in Yices_Context ; Expr : in Yices_Expr ; W : in Long_Long_Integer ) return Assertion_Id ;
   pragma Import(C,Yices_Assert_Weighted,"yices_assert_weighted") ;
   
   -- Assert a constraint that can be later retracted. 
   function Yices_Assert_Retractable( Ctx : in Yices_Context ; Expr : in Yices_Expr ) return Assertion_Id ;
   pragma Import(C,Yices_Assert_Retractable,"yices_assert_retractable") ;
   
   -- Retract a retractable or weighted constraint. 
   procedure Yices_Retract( Ctx : in Yices_Context ; Id : in Assertion_Id ) ;
   pragma Import(C,Yices_Retract,"yices_retract") ;
   
   -- Check whether the logical context is known to be inconsistent. 
   function Yices_Inconsistent( Ctx : in Yices_Context ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Inconsistent,"yices_inconsistent") ;
   
   -- Check if the logical context is satisfiable. 
   function Yices_Check( Ctx : in Yices_Context ) return Lbool ;
   pragma Import(C,Yices_Check,"yices_check") ;
   
   -- Compute the maximal satisfying assignment for the asserted weighted constraints. 
   function Yices_Max_Sat( Ctx : in Yices_Context ) return Lbool ;
   pragma Import(C,Yices_Max_Sat,"yices_max_sat") ;
   
   -- Similar to yices_max_sat, but start looking for models with cost less than of equal to max_cost. 
   function Yices_Max_Sat_Cost_Leq( C : in Yices_Context ; Max_Cost : Long_Long_Integer ) return Lbool ;
   pragma Import(C,Yices_Max_Sat_Cost_Leq,"yices_max_sat_cost_leq") ;
   
   -- Search for a model of the constraints asserted in ctx and compute its cost. 
   function Yices_Find_Weighted_Model( Ctx : in Yices_Context ; Random : Interfaces.C.Int ) return Lbool ;
   pragma Import(C,Yices_Find_Weighted_Model,"yices_find_weighted_model") ;
   
   -- Return the size of the unsatisfiable core.
   function Yices_Get_Unsat_Core_Size( Ctx : in Yices_Context ) return Interfaces.C.Unsigned ;
   pragma Import(C,Yices_Get_Unsat_Core_Size,"yices_get_unsat_core_size") ;
   
   -- Return the unsatisfiable core. 
   function Yices_Get_Unsar_Core( Ctx : in Yices_Context ; A : in Assertion_Id_Array ) return Interfaces.C.Unsigned ;
   pragma Import(C,Yices_Get_Unsar_Core,"yices_get_unsat_core") ;
   
   -- Return a model for a satisfiable context. 
   function Yices_Get_Model( Ctx : in Yices_Context ) return Yices_Model ;
   pragma Import(C,Yices_Get_Model,"yices_get_model") ;
   
   -- Return the value of variable v in model m. 
   function Yices_Get_Value( M : in Yices_Model ; V : out Yices_Var_Decl ) return Lbool ;
   pragma Import(C,Yices_Get_Value,"yices_get_value") ;
   
   -- Get the integer value assigned to variable v in model m. 
   function Yices_Get_Int_Value( M : in Yices_Model ; D : in Yices_Var_Decl ; Value : access Interfaces.C.Long ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Get_Int_Value,"yices_get_int_value") ;
   
   -- Get the rational value assigned to variable v in model m.
   function Yices_Get_Arith_Value( M : in Yices_Model ; D : in Yices_Var_Decl ; Num, Den : access Interfaces.C.Long ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Get_Arith_Value,"yices_get_arith_value") ;
   
   -- Convert the value assigned to variable v in model m to a floating poin number. 
   function Yices_Get_Double_Value( M : in Yices_Model ; D : in Yices_Var_Decl ; Value : access Long_Float) return Interfaces.C.Int ;
   pragma Import(C,Yices_Get_Double_Value,"yices_get_double_value") ;
   
   -- Convert the value assigned to variable v in model m to a GMP rational (mpq_t). 
   --  int 	yices_get_mpq_value (yices_model m, yices_var_decl d, mpq_t value)
   
   -- Convert the value assigned to variable v in model m to a GMP integer (mpz_t). 
   --  int 	yices_get_mpz_value (yices_model m, yices_var_decl d, mpz_t value)
   
   -- Get the value assigned to variable v in model m as a string. 
   function Yices_Get_Arith_Value_As_String( M : in Yices_Model ; D : in Yices_Var_Decl ; R : Srec_T_Access ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Get_Arith_Value_As_String,"yices_get_arith_value_as_string") ;
   
   -- Free a string allocated by Yices
   function Yices_Free_String( R : Srec_T_Access ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Free_String,"yices_free_string") ;
   
   -- Get the bitvector constant assigned to a variable v in model m. 
   function Yices_Get_Bitvector_Value( M : in Yices_Model ; D : in Yices_Var_Decl ; N : in Interfaces.C.Unsigned ; Bv : Bv_Array ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Get_Bitvector_Value,"yices_get_bitvector_value") ;
   
   -- Get the value assigned to a scalar variable v in model m. 
   function Yices_Get_Scalar_Value( M : in Yices_Model ; D : in Yices_Var_Decl ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Get_Scalar_Value,"yices_get_scalar_value") ;
   
   -- Get the value assigned to a scalar variable v in model m. 
   function Yices_Get_Scalar_Value_Name( M : in Yices_Model ; D : in Yices_Var_Decl ) return Interfaces.C.Strings.Chars_Ptr ;
   pragma Import(C,Yices_Get_Scalar_Value_Name,"yices_get_scalar_value_name") ;
   
   -- Return 1 (0) if the assertion of the given id is satisfied (not satisfied) in the model m. 
   function Yices_Get_Assertion_Value( M : in Yices_Model ; Id : in Assertion_Id ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Get_Assertion_Value,"yices_get_assertion_value") ;
   
   -- Evaluate a formula in a model. 
   function Yices_Evaluate_In_Model( M : in Yices_Model ; E : in Yices_Expr ) return Lbool ;
   pragma Import(C,Yices_Evaluate_In_Model,"yices_evaluate_in_model") ;
   
   -- Display the given model in the standard output. 
   procedure Yices_Display_Model( M : in Yices_Model ) ;
   pragma Import(C,Yices_Display_Model,"yices_display_model") ;
   
   -- Return the cost of model m. 
   function Yices_Get_Cost( M : in Yices_Model ) return Long_Long_Integer ;
   pragma Import(C,Yices_Get_Cost,"yices_get_cost") ;
   
   -- Return the cost of the model m, converted to a double-precision floating point number. 
   function Yices_Get_Cost_As_Double( M : in Yices_Model ) return Interfaces.C.Double ;
   pragma Import(C,Yices_Get_Cost_As_Double,"yices_get_cost_as_double") ;
   
   -- Create an iterator that can be used to traverse the boolean variables (var_decl objects) in the logical context. 
   function Yices_Create_Var_Decl_Iterator( C : in Yices_Context ) return Yices_Var_Decl_Iterator ;
   pragma Import(C,Yices_Create_Var_Decl_Iterator,"yices_create_var_decl_iterator") ;
   
   -- Return 1 if the iterator it still has elements to be iterated. Return 0 otherwise. 
   function Yices_Iterator_Has_Next( It : in Yices_Var_Decl_Iterator) return Interfaces.C.Int ;
   pragma Import(C,Yices_Iterator_Has_Next,"yices_iterator_has_next") ;
   
   -- Return the next variable, and move the iterator. 
   function Yices_Iterator_Next( It : in Yices_Var_Decl_Iterator ) return Yices_Var_Decl ;
   pragma Import(C,Yices_Iterator_Next,"yices_iterator_next") ;
   
   -- Reset the given iterator, that is, move it back to the first element. 
   procedure Yices_Iterator_Reset( It : in Yices_Var_Decl_Iterator ) ;
   pragma Import(C,Yices_Iterator_Reset,"yices_iterator_reset") ;
   
   -- Delete an iterator created with yices_create_var_decl_iterator. 
   procedure Yices_Del_Iterator( It : in Yices_Var_Decl_Iterator ) ;
   pragma Import(C,Yices_Del_Iterator,"yices_del_iterator") ;
   
   -- Parse string s as an expression in the Yices syntax. 
   function Yices_Parse_Expression( Ctx : in Yices_Context ; S : Interfaces.C.Strings.Chars_Ptr ) return Yices_Expr ;
   pragma Import(C,Yices_Parse_Expression,"yices_parse_expression") ;
   
   -- Parse string s as a type in the Yices syntax. 
   function Yices_Parse_Type( Ctx : in Yices_Context ; S : Interfaces.C.Strings.Chars_Ptr ) return Yices_Type ;
   pragma Import(C,Yices_Parse_Type,"yices_parse_type") ;
   
   -- Parse string s as a command in the Yices syntax and execute the command. 
   function Yices_Parse_Command( Ctx : in Yices_Context ; S : Interfaces.C.Strings.Chars_Ptr ) return Interfaces.C.Int ;
   pragma Import(C,Yices_Parse_Command,"yices_parse_command") ;
   
   -- Return the last error message. 
   function Yices_Get_Last_Error_Message return Interfaces.C.Strings.Chars_Ptr ;
   pragma Import(C,Yices_Get_Last_Error_Message,"yices_get_last_error_message") ;
   
   -- Return the type associated with the given name. If the type does not exist, a new uninterpreted type is created. 
   function Yices_Mk_Type( Ctx : in Yices_Context ; Name : Interfaces.C.Strings.Chars_Ptr ) return Yices_Type ;
   pragma Import(C,Yices_Mk_Type,"yices_mk_type") ;
   
   -- Returns the bitvector type (bv[size]). 
   function Yices_Mk_Bitvector_Type( Ctx : in Yices_Context ; Size : in Interfaces.C.Unsigned ) return Yices_Type ;
   pragma Import(C,Yices_Mk_Bitvector_Type,"yices_mk_bitvector_type") ;
   
   -- Return a function type (-> d1 ... dn r). 
   function Yices_Mk_Function_Type( Ctx : in Yices_Context ; Domain : in Yices_Type_Array ; Domain_Size : in Interfaces.C.Unsigned ; R : in Yices_Type ) return Yices_Type ;
   pragma Import(C,Yices_Mk_Function_Type,"yices_mk_function_type") ;
   
   -- Constructs the tuple type (arg[0], ..., arg[size-1]). 
   function Yices_Mk_Tuple_Type( Ctx : in Yices_Context ; Args : in Yices_Type_Array ; Size : in Interfaces.C.Unsigned ) return Yices_Type ;
   pragma Import(C,Yices_Mk_Tuple_Type,"yices_mk_tuple_type") ;
   
   -- Return a new boolean variable declaration. 
   function Yices_Mk_Bool_Var_Decl( Ctx : in Yices_Context ; Name : Interfaces.C.Strings.Chars_Ptr ) return Yices_Var_Decl ;
   pragma Import(C,Yices_Mk_Bool_Var_Decl,"yices_mk_bool_var_decl") ;
   
   -- Return a new (global) variable declaration. It is an error to create two variables with the same name. 
   function Yices_Mk_Var_Decl( Ctx : in Yices_Context ; Name : in Interfaces.C.Strings.Chars_Ptr ; Ty : in Yices_Type ) return Yices_Var_Decl ;
   pragma Import(C,Yices_Mk_Var_Decl,"yices_mk_var_decl") ;
   
   -- Return a variable declaration associated with the given name. 
   function Yices_Get_Var_Decl_From_Name( Ctx : in Yices_Context ; Name : in Interfaces.C.Strings.Chars_Ptr ) return Yices_Var_Decl ;
   pragma Import(C,Yices_Get_Var_Decl_From_Name,"yices_get_var_decl_from_name") ;
   
   -- Return the variable declaration object associated with the given name expression. 
   function Yices_Get_Var_Decl( E : in Yices_Expr ) return Yices_Var_Decl ;
   pragma Import(C,Yices_Get_Var_Decl,"yices_get_var_decl") ;
   
   -- Return the name of a variable declaration. 
   function Yices_Get_Var_Decl_Name( D : in Yices_Var_Decl ) return Interfaces.C.Strings.Chars_Ptr ;
   pragma Import(C,Yices_Get_Var_Decl_Name,"yices_get_var_decl_name") ;
   
   -- Return a name expression (instance) using the given variable declaration. 
   function Yices_Mk_Var_From_Decl( Ctx : in Yices_Context ; D : in Yices_Var_Decl ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Var_From_Decl,"yices_mk_var_from_decl") ;
   
   -- Return a name expression (instance) using the given variable declaration. 
   function Yices_Mk_Bool_Var_From_Decl( Ctx : in Yices_Context ; D : in Yices_Var_Decl ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bool_Var_From_Decl,"yices_mk_bool_var_from_decl") ;
   
   -- Return a name expression for the given variable name. 
   function Yices_Mk_Bool_Var( Ctx : in Yices_Context ; Name : in Interfaces.C.Strings.Chars_Ptr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bool_Var,"yices_mk_bool_var") ;
   
   -- Return a fresh boolean variable. 
   function Yices_Mk_Fresh_Bool_Var( Ctx : in Yices_Context ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Fresh_Bool_Var,"yices_mk_fresh_bool_var") ;
   
   -- Return an expression representing true.    
   function Yices_Mk_True( Ctx : in Yices_Context ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_True,"yices_mk_true") ;

   -- Return an expression representing false. 
   function Yices_Mk_False( Ctx : in Yices_Context ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_False,"yices_mk_false") ;
   
   -- Return an expression representing the or of the given arguments. 
   function Yices_Mk_Or( Ctx : in Yices_Context ; Args : in Yices_Expr_Array ; N : in Interfaces.C.Int ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Or,"yices_mk_or") ;
   
   -- Return an expression representing the and of the given arguments. 
   function Yices_Mk_And( Ctx : in Yices_Context ; Args : in Yices_Expr_Array ; N : in Interfaces.C.Int ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_And,"yices_mk_and") ;
   
   -- Return an expression representing (not a). 
   function Yices_Mk_Not( Ctx : in Yices_Context ; A : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Not,"yices_mk_not") ;
   
   -- Return an expression representing a1 = a2. 
   function Yices_Mk_Eq( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Eq,"yices_mk_eq") ;
   
   -- Return an expression representing a1 /= a2.
   function Yices_Mk_Diseq( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Diseq,"yices_mk_or") ;
   
   -- Return an expression representing (if c t e).
   function Yices_Mk_Ite( Ctx : in Yices_Context ; C, T, E : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Ite,"yices_mk_ite") ;
   
   -- Return a function application term (f t1 ... tn). 
   function Yices_Mk_App( Ctx : in Yices_Context ; F : in Yices_Expr ; Args : in Yices_Expr_Array ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_App,"yices_mk_app") ;   
   
   -- Build a function update term (update f (t1 ... tn) v). 
   function Yices_Mk_Function_Update( Ctx : in Yices_Context ; F : in Yices_Expr ; Args : in Yices_Expr_Array ; N : in Interfaces.C.Unsigned ; V : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Function_Update,"yices_mk_function_update") ;
   
   -- Build a tuple term (tuple t1 ... tn). 
   function Yices_Mk_Tuple_Literal( Ctx : in Yices_Context ; Args : in Yices_Expr_Array ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Tuple_Literal,"yices_mk_tuple_literal") ;
      
   -- Return an expression representing the given integer. 
   function Yices_Mk_Num( Ctx : in Yices_Context ; N : in Interfaces.C.Int ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Num,"yices_mk_num") ;
   
   -- Return an expression representing the number provided in ASCII format. 
   function Yices_Mk_Num_From_String( Ctx : in Yices_Context ; N : in Interfaces.C.Strings.Chars_Ptr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Num_From_String,"yices_mk_num_from_string") ;
   
   -- Construct a numerical expression form a GMP integer.
   --  yices_expr 	yices_mk_num_from_mpz (yices_context ctx, const mpz_t z)
   
   -- Construct a numerical expression form a GMP rational. 
   --  yices_expr 	yices_mk_num_from_mpq (yices_context ctx, const mpq_t q)
   
   -- Return an expression representing args[0] + ... + args[n-1]. 
   function Yices_Mk_Sum( Ctx : in Yices_Context ; Args : in Yices_Expr_Array ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Sum,"yices_mk_sum") ;
   
   -- Return an expression representing args[0] - ... - args[n-1]. 
   function Yices_Mk_Sub( Ctx : in Yices_Context ; Args : in Yices_Expr_Array ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Sub,"yices_mk_sub") ;
   
   -- Return an expression representing args[0] * ... * args[n-1]. 
   function Yices_Mk_Mul( Ctx : in Yices_Context ; Args : in Yices_Expr_Array ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Mul,"yices_mk_mul") ;
   
   -- Return an expression representing a1 < a2. 
   function Yices_Mk_Lt( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Lt,"yices_mk_lt") ;
   
   -- Return an expression representing a1 <= a2. 
   function Yices_Mk_Le( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Le,"yices_mk_le") ;
   
   -- Return an expression representing a1 > a2. 
   function Yices_Mk_Gt( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Gt,"yices_mk_gt") ;
   
   -- Return an expression representing a1 >= a2. 
   function Yices_Mk_Ge( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Ge,"yices_mk_ge") ;
   
   -- Create a bit vector constant of size bits and of the given value. 
   function Yices_Mk_Bv_Constant( Ctx : in Yices_Context ; Size : in Interfaces.C.Unsigned ; Value : in Interfaces.C.Unsigned_Long ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Constant,"yices_mk_bv_constant") ;
   
   -- Create a bit vector constant from an array. 
   function Yices_Mk_Bv_Constant_From_Array( Ctx : in Yices_Context ; Size : in Interfaces.C.Unsigned ; Bv : in Bv_Array ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Constant_From_Array,"yices_mk_bv_constant_from_array") ;
   
   -- Bitvector addition. 
   function Yices_Mk_Bv_Add( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Add,"yices_mk_bv_add") ;
   
   -- Bitvector subtraction. 
   function Yices_Mk_Bv_Sub( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Sub,"yices_mk_bv_sub") ;
   
   -- Bitvector multiplication. 
   function Yices_Mk_Bv_Mul( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Mul,"yices_mk_bv_mul") ;
   
   -- Bitvector opposite. 
   function Yices_Mk_Bv_Minus( Ctx : in Yices_Context ; A1 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Minus,"yices_mk_bv_minus") ;
   
   -- Bitwise and. 
   function Yices_Mk_Bv_And( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_And,"yices_mk_bv_and") ;
   
   -- Bitwise or. 
   function Yices_Mk_Bv_Or( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Or,"yices_mk_bv_or") ;
   
   -- Bitwise exclusive or. 
   function Yices_Mk_Bv_Xor( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Xor,"yices_mk_bv_xor") ;
   
   -- Bitwise negation. 
   function Yices_Mk_Bv_Not( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Not,"yices_mk_bv_not") ;
   
   -- Bitvector concatenation. 
   function Yices_Mk_Bv_Concat( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Concat,"yices_mk_bv_concat");
   
   -- Bitvector extraction. 
   function Yices_Mk_Bv_Extract( Ctx : in Yices_Context ; E,B : in Interfaces.C.Unsigned ; A : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Extract,"yices_mk_bv_extract") ;
   
   -- Sign extension. 
   function Yices_Mk_Bv_Sign_Extend( Ctx : in Yices_Context ; E,B : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Sign_Extend,"yices_mk_bv_sign_extend") ;
   
   -- Left shift by n bits, padding with zeros. 
   function Yices_Mk_Bv_Shift_Left0( Ctx : in Yices_Context ; A : in Yices_Expr ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Shift_Left0,"yices_mk_bv_shift_left0") ;
   
   -- Left shift by n bits, padding with ones. 
   function Yices_Mk_Bv_Shift_Left1( Ctx : in Yices_Context ; A : in Yices_Expr ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Shift_Left1,"yices_mk_bv_shift_left1") ;
   
   -- Right shift by n bits, padding with zeros. 
   function Yices_Mk_Bv_Shift_Right0( Ctx : in Yices_Context ; A : in Yices_Expr ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Shift_Right0,"yices_mk_bv_shift_right0") ;
   
   -- Right shift by n bits, padding with ones. 
   function Yices_Mk_Bv_Shift_Right1( Ctx : in Yices_Context ; A : in Yices_Expr ; N : in Interfaces.C.Unsigned ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Shift_Right1,"yices_mk_bv_shift_right1") ; 
   
   -- Unsigned comparison: (a1 < a2).
   function Yices_Mk_Bv_Lt( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Lt,"yices_mk_bv_lt") ;
   
   -- Unsigned comparison: (a1 <= a2). 
   function Yices_Mk_Bv_Le( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Le,"yices_mk_bv_le") ;
   
   -- Unsigned comparison: (a1 > a2). 
   function Yices_Mk_Bv_Gt( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Gt,"yices_mk_bv_gt") ;
   
   -- Unsigned comparison: (a1 >= a2). 
   function Yices_Mk_Bv_Ge( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Ge,"yices_mk_bv_ge") ;
   
   -- Signed comparison: (a1 < a2). 
   function Yices_Mk_Bv_Slt( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Slt,"yices_mk_bv_slt") ;
   
   -- Signed comparison: (a1 <= a2). 
   function Yices_Mk_Bv_Sle( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Sle,"yices_mk_bv_sle") ;
   
   -- Signed comparison: (a1 > a2). 
   function Yices_Mk_Bv_Sgt( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Sgt,"yices_mk_bv_sle") ;
   
   -- Signed comparison: (a1 >= a2). 
   function Yices_Mk_Bv_Sge( Ctx : in Yices_Context ; A1, A2 : in Yices_Expr ) return Yices_Expr ;
   pragma Import(C,Yices_Mk_Bv_Sge,"yices_mk_bv_sle") ;
   
   -- Pretty print the given expression in the standard output. 
   procedure Yices_Pp_Expr( E : in Yices_Expr ) ;
   pragma Import(C,Yices_Pp_Expr,"yices_pp_expr") ;
      
end Yices ;
