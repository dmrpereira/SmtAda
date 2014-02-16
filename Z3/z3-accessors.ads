with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3.Accessors is
   
   ----------------
   --  Accessors --
   ----------------
   
   -- Return Z3_INT_SYMBOL if the symbol was constructed using Z3_mk_int_symbol, and Z3_STRING_SYMBOL if the symbol was constructed using Z3_mk_string_symbol.    
   function Z3_Get_Symbol_Kind( C : in Z3_Context ; S : in Z3_Symbol ) return Z3_Symbol_Kind ;
   pragma Import(C,Z3_Get_Symbol_Kind,"Z3_get_symbol_kind") ; 

   -- Return the symbol int value.      
   function Z3_Get_Symbol_Int( C : in Z3_Context ; S : in Z3_Symbol ) return Interfaces.C.Int ;
   pragma Import(C,Z3_Get_Symbol_Int,"Z3_get_symbol_int") ;

   -- Return the symbol name. 
   function Z3_Get_Symbol_String( C : in Z3_Context ; S : in Z3_Symbol ) return Z3_String ;
   pragma Import(C,Z3_Get_Symbol_String,"Z3_get_symbol_string") ;

   -- Return the sort name as a symbol.      
   function Z3_Get_Sort_Name(  C : in Z3_Context ; D : in Z3_Sort ) return Z3_Symbol ;
   pragma Import(C,Z3_Get_Sort_Name,"Z3_get_sort_name") ;

   -- Return a unique identifier for s. 
   function Z3_Get_Sort_Id( C : in Z3_Context ; S : in Z3_Sort ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Sort_Id,"Z3_get_sort_id") ;

   -- Convert a Z3_sort into Z3_ast. This is just type casting.    
   function Z3_Sort_To_Ast( C : in Z3_Context ; S : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Sort_To_Ast,"Z3_sort_to_ast") ;

   -- compare sorts. 
   function Z3_Is_Eq_Sort( C : in Z3_Context ; S1, S2 : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Is_Eq_Sort,"Z3_is_eq_sort") ;

   -- Return the sort kind (e.g., array, tuple, int, bool, etc). 
   function Z3_Get_Sort_Kind( C : in Z3_Context ; S : in Z3_Sort ) return Z3_Sort_Kind ;
   pragma Import(C,Z3_Get_Sort_Kind,"Z3_get_sort_kind") ;

   -- Return the size of the given bit-vector sort. 
   function Z3_Get_Bv_Sort_Size( C : in Z3_Context ; S : in Z3_Sort ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Bv_Sort_Size,"Z3_get_bv_sort_size") ;

   -- Store the size of the sort in r. Return Z3_FALSE if the call failed. That is,
   -- Z3_get_sort_kind(s) == Z3_FINITE_DOMAIN_SORT.    
   function Z3_Get_Finite_Domain_Sort_Size( C : in Z3_Context ; S : in Z3_Sort ; R : out Int_64 ) return Z3_Bool ;
   pragma Import(C,Z3_Get_Finite_Domain_Sort_Size,"Z3_get_finite_domain_sort_size") ;

   -- Return the domain of the given array sort.    
   function Z3_Get_Array_Sort_Domain( C : in Z3_Context ; S : in Z3_Sort ) return Z3_Sort ;
   pragma Import(C,Z3_Get_Array_Sort_Domain,"Z3_get_array_sort_domain") ;
   
   -- Return the range of the given array sort.    
   function Z3_Get_Array_Sort_Range( C : in Z3_Context ; T : in Z3_Sort ) return Z3_Sort ;
   pragma Import(C,Z3_Get_Array_Sort_Range,"Z3_get_array_sort_range") ;

   -- Return the constructor declaration of the given tuple sort.    
   function Z3_Get_Tuple_Sort_Mk_Decl( C : in Z3_Context ; T : in Z3_Sort ) return Z3_Func_Decl ;
   pragma Import(C,Z3_Get_Tuple_Sort_Mk_Decl,"Z3_get_tuple_sort_mk_decl") ;

   -- Return the number of fields of the given tuple sort.    
   function Z3_Get_Tuple_Sort_Num_Fields( C : in Z3_Context ; T : in Z3_Sort ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Tuple_Sort_Num_Fields,"Z3_get_tuple_sort_num_fields") ;
   
   -- Return the i-th field declaration (i.e., projection function declaration) of the given tuple sort.    
   function Z3_Get_Tuple_Sort_Field_Decl(  C : in Z3_Context ; T : in Z3_Sort ; I : in Interfaces.C.Unsigned ) return Z3_Func_Decl ;
   pragma Import(C,Z3_Get_Tuple_Sort_Field_Decl,"Z3_get_tuple_sort_field_decl") ;

   -- Return number of constructors for datatype. 
   function Z3_Get_Datatype_Sort_Num_Constructors(  C : in Z3_Context ; S : in Z3_Sort ) return Interfaces.C.Unsigned;
   pragma Import(C,Z3_Get_Datatype_Sort_Num_Constructors,"Z3_get_datatype_sort_num_constructors") ;
   
   -- Return idx'th constructor. 
   function Z3_Get_Datatype_Sort_Construct( C : in Z3_Context ; T : in Z3_Sort ; Idx : in Interfaces.C.Unsigned ) return Z3_Func_Decl ;
   pragma Import(C,Z3_Get_Datatype_Sort_Construct,"Z3_get_datatype_sort_constructor") ;

    -- Return idx'th recognizer. 
   function Z3_Get_Datatype_Sort_Recognizer( C : in Z3_Context ; T : in Z3_Sort ; Idx : in Interfaces.C.Unsigned ) return Z3_Func_Decl ;
   pragma Import(C,Z3_Get_Datatype_Sort_Recognizer,"Z3_get_datatype_sort_recognizer") ;

   -- Return idx_a'th accessor for the idx_c'th constructor.    
   function Z3_Get_Datatype_Sort_Constructor_Accessor( C : in Z3_Context ; T : in Z3_Sort ; Idx_C, Idx_A : in Interfaces.C.Unsigned ) Return Z3_Func_Decl ;
   pragma Import(C,Z3_Get_Datatype_Sort_Constructor_Accessor,"Z3_get_datatype_sort_constructor_accessor") ;
   
   -- Return arity of relation. 
   function Z3_Get_Relation_Arity( C : in Z3_Context ; S : in Z3_Sort ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Relation_Arity,"Z3_get_relation_arity") ;

   -- Return sort at i'th column of relation sort.      
   function Z3_Get_Relation_Column( C : in Z3_Context ; S : in Z3_sort ; Col : in Interfaces.C.Unsigned ) return Z3_Sort ;
   pragma Import(C,Z3_Get_Relation_Column,"Z3_get_relation_column") ;

   -- Convert a Z3_func_decl into Z3_ast. This is just type casting.  
   function Z3_Func_Decl_To_Ast( C : in Z3_Context ; F : in Z3_Func_Decl ) return Z3_Ast ;
   pragma Import(C,Z3_Func_Decl_To_Ast,"Z3_func_decl_to_ast") ;

   -- compare terms.    
   function Z3_Is_Eq_Func_Decl( C : in Z3_Context ; F1, F2 : in Z3_Func_Decl ) return Z3_Bool ;
   pragma Import(C,Z3_Is_Eq_Func_Decl,"Z3_is_eq_func_decl") ;

   -- Return a unique identifier for f.       
   function Z3_Get_Func_Decl_Id( C : in Z3_Context ; F : in Z3_Func_Decl ) return Interfaces.C.Unsigned;
   pragma Import(C,Z3_Get_Func_Decl_Id,"Z3_get_func_decl_id") ;

   -- Return the constant declaration name as a symbol.      
   function Z3_Get_Func_Decl_Name( C : in Z3_Context ; D : in Z3_Func_Decl ) return Z3_Symbol ;
   pragma Import(C,Z3_Get_Func_Decl_Name,"Z3_get_decl_name") ;

   -- Return declaration kind corresponding to declaration. 	  
   function Z3_Get_Func_Decl_Kind( C : in Z3_Context ; F : in Z3_Func_Decl ) return Z3_Decl_Kind ;
   pragma Import(C,Z3_Get_Func_Decl_Kind,"Z3_get_decl_kind") ;

   -- Return the number of parameters of the given declaration.      
   function Z3_Get_Domain_Size( C : in Z3_Context ; D : in Z3_Func_Decl ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Domain_Size,"Z3_get_domain_size") ; 

   -- Alias for Z3_get_domain_size.      
   function Z3_Get_Arity( C : in Z3_Context ; D : in Z3_Func_Decl ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Arity,"Z3_get_arity") ;

   -- Return the sort of the i-th parameter of the given function declaration.    
   function Z3_Get_Domain( C : in Z3_Context ; F : in Z3_Func_Decl ; I : in Interfaces.C.Unsigned ) return Z3_Sort ;
   pragma Import(C,Z3_Get_Domain,"Z3_get_domain") ;

   -- Return the range of the given declaration.      
   function Z3_Get_Range( C : in Z3_Context ; F : in Z3_Func_Decl ) return Z3_Sort ;
   pragma Import(C,Z3_Get_Range,"Z3_get_range") ;

   -- Return the number of parameters associated with a declaration.      
   function Z3_Get_Decl_Num_Parameters( C : in Z3_Context ; D : in Z3_Func_Decl ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Decl_Num_Parameters,"Z3_get_decl_num_parameters") ;

   -- Return the parameter type associated with a declaration.      
   function Z3_Get_Decl_Parameter_Kind( C : in Z3_Context ; D : in Z3_Func_Decl ; Idx : in Interfaces.C.Unsigned ) return Z3_Parameter_Kind;
   pragma Import(C,Z3_Get_Decl_Parameter_Kind,"Z3_get_decl_parameter_kind") ;

   -- Return the integer value associated with an integer parameter.      
   function Z3_Get_Decl_Int_Parameter( C : in Z3_Context ; D : in Z3_Func_Decl ; Idx : in Interfaces.C.Unsigned ) return Interfaces.C.Int ;
   pragma Import(C,Z3_Get_Decl_Int_Parameter,"Z3_get_decl_int_parameter") ;

   -- Return the double value associated with an double parameter.      
   function Z3_Get_Decl_Double_Parameter( C : in Z3_Context ; D : in Z3_Func_Decl ; Idx : in Interfaces.C.Unsigned ) return Interfaces.C.Double ;
   pragma Import(C,Z3_Get_Decl_Double_Parameter,"Z3_get_decl_double_parameter") ;

   -- Return the double value associated with an double parameter.      
   function Z3_Get_Decl_Symbol_Parameter( C : in Z3_Context ; D : in Z3_Func_Decl ; Idx : in Interfaces.C.Unsigned ) return Z3_Symbol ;
   pragma Import(C,Z3_Get_Decl_Symbol_Parameter,"Z3_get_decl_symbol_parameter") ;

   -- Return the sort value associated with a sort parameter.    
   function Z3_Get_Decl_Sort_Parameter( C : in Z3_Context ; D : in Z3_Func_Decl ; Idx : in Interfaces.C.Unsigned ) return Z3_Sort ;
   pragma Import(C,Z3_Get_Decl_Sort_Parameter,"Z3_get_decl_sort_parameter") ;

   -- Return the expresson value associated with an expression parameter.      
   function Z3_Get_Decl_Ast_Parameter( C : in Z3_Context ; D : in Z3_Func_Decl ; Idx : in Interfaces.C.Unsigned ) return Z3_Sort ;
   pragma Import(C,Z3_Get_Decl_Ast_Parameter,"Z3_get_decl_ast_parameter") ;
   
   --  	Return the expresson value associated with an expression parameter. 
   function Z3_Get_Decl_Func_Decl_Parameter( C : in Z3_Context ; D : in Z3_Func_Decl ; Idx : in Interfaces.C.Unsigned ) return Z3_Func_Decl ;
   pragma Import(C,Z3_Get_Decl_Func_Decl_Parameter,"Z3_get_decl_func_decl_parameter") ;
   
   -- Return the rational value, as a string, associated with a rational parameter.    
   function Z3_Get_Decl_Rational_Parameter( C : in Z3_Context ; D : in Z3_Func_Decl ; Idx : in Interfaces.C.Unsigned ) return Z3_String ;     
   pragma Import(C,Z3_Get_Decl_Rational_Parameter,"Z3_get_decl_rational_parameter") ;

   -- Convert a Z3_app into Z3_ast. This is just type casting.    
   function Z3_App_To_Ast( C : in Z3_Context ; A : in Z3_App ) return Z3_Ast ;
   pragma Import(C,Z3_App_To_Ast,"Z3_app_to_ast") ;

   -- Return the declaration of a constant or function application. 
   function Z3_Get_App_Decl( C : in Z3_Context ; A : in Z3_App ) return Z3_Ast ;
   pragma Import(C,Z3_Get_App_Decl,"Z3_get_app_decl") ;

   -- Return the number of argument of an application. If t is an constant, then the number of arguments is 0.  
   function Z3_Get_App_Num_Args( C : in Z3_Context ; A : in Z3_App ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_App_Num_Args,"Z3_get_app_num_args") ;

   -- Return the i-th argument of the given application.  
   function Z3_Get_App_Arg( C : in Z3_Context ; A : in Z3_App ; I : in Interfaces.C.Unsigned ) return Z3_Ast ;
   pragma Import(C,Z3_Get_App_Arg,"Z3_get_app_arg") ;

   -- compare terms.  
   function Z3_Is_Eq_Ast( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Is_Eq_Ast,"Z3_is_eq_ast") ;

   -- Return a unique identifier for t.  
   function Z3_Get_Ast_Id( C : in Z3_Context ; T : in Z3_Ast ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Ast_Id,"Z3_get_ast_id") ;

   -- Return a hash code for the given AST.  
   function Z3_Get_Ast_Hash( C : in Z3_Context ; A : in Z3_Ast ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Ast_Hash,"Z3_get_ast_hash") ;

   -- Return the sort of an AST node.  
   function Z3_Get_Sort( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Sort,"Z3_get_sort") ;

   -- Return true if the given expression t is well sorted.  
   function Z3_Is_Well_Sorted( C : in Z3_Context ; T : in Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Is_Well_Sorted,"Z3_is_well_sorted") ;

   -- Return Z3_L_TRUE if a is true, Z3_L_FALSE if it is false, and Z3_L_UNDEF otherwise.  
   function Z3_Get_Bool_Value( C : in Z3_Context ; T : in Z3_Ast ) return Z3_Lbool ;
   pragma Import(C,Z3_Get_Bool_Value,"Z3_get_bool_value") ;

   -- Return the kind of the given AST.  
   function Z3_Get_Ast_Kind( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Ast_Kind ;
   pragma Import(C,Z3_Get_Ast_Kind,"Z3_get_ast_kind") ;

   function Z3_Is_App( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Is_App,"Z3_is_app") ;
 
   function Z3_Is_Numeral_Ast( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Is_Numeral_Ast,"Z3_is_numeral_ast") ;
 
   -- Return true if the give AST is a real algebraic number.    
   function Z3_Is_Algebraic_Number( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Is_Algebraic_Number,"Z3_is_algebraic_number") ;

   -- Convert an ast into an APP_AST. This is just type casting.  
   function Z3_To_App( C : in Z3_Context ; A : in Z3_Ast ) return Z3_App ;
   pragma Import(C,Z3_To_App,"Z3_to_app") ;

   -- Convert an AST into a FUNC_DECL_AST. This is just type casting.  
   function Z3_To_Func_Decl( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Func_Decl ;
   pragma Import(C,Z3_To_Func_Decl,"Z3_to_func_decl") ;

   -- Return numeral value, as a string of a numeric constant term.  
   function Z3_Get_Numeral_String( C : in Z3_Context ; A : in Z3_Ast ) return Z3_String ;
   pragma Import(C,Z3_Get_Numeral_String,"Z3_get_numeral_string") ;

   -- Return numeral as a string in decimal notation. The result has at most precision decimal places.    
   function Z3_Get_Numeral_Decimal_String( C : in Z3_Context ; A : in Z3_Ast ; Precision : in Interfaces.C.Unsigned ) return Z3_String ;
   pragma Import(C,Z3_Get_Numeral_Decimal_String,"Z3_get_numeral_decimal_string") ;

   -- Return the numerator (as a numeral AST) of a numeral AST of sort Real. 
   function Z3_Get_Numerator( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Numerator,"Z3_get_numerator") ;

   -- Return the denominator (as a numeral AST) of a numeral AST of sort Real. 		   
   function Z3_Get_Denominator( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Denominator,"Z3_get_denominator") ;

   -- Return numeral value, as a pair of 64 bit numbers if the representation fits.  
   function Z3_Get_Numeral_Small( C : in Z3_Context ; A : in Z3_Ast ; Num, Den : out Int_64_Access ) return Z3_Bool ;
   pragma Import(C,Z3_Get_Numeral_Small,"Z3_get_numeral_small") ;

   -- Similar to Z3_get_numeral_string, but only succeeds if the value can fit in a machine int. Return Z3_TRUE if the call succeeded.  
   function Z3_Get_Numeral_Int( C : in Z3_Context ; A : in Z3_Ast ; I : out Int_Access ) return Z3_Bool ;
   pragma Import(C,Z3_Get_Numeral_Int,"Z3_get_numeral_int") ;

   -- Similar to Z3_get_numeral_string, but only succeeds if the value can fit in a machine unsigned int. Return Z3_TRUE if the call succeeded.  
   function Z3_Get_Numeral_Uint( C : in Z3_Context ; V : in Z3_Ast ; U : out Unsigned_Access ) return Z3_Bool ;
   pragma Import(C,Z3_Get_Numeral_Uint,"Z3_get_numeral_uint") ;

   -- Similar to Z3_get_numeral_string, but only succeeds if the value can fit in a machine unsigned __int64 int. Return Z3_TRUE if the call succeeded.  
   function Z3_Get_Numeral_Uint64( C : in Z3_Context ; V : in Z3_Ast ; U : out Uint_64_Access ) return Z3_Bool ;
   pragma Import(C,Z3_Get_Numeral_Uint64,"Z3_get_numeral_uint64") ;

   -- Similar to Z3_get_numeral_string, but only succeeds if the value can fit in a machine __int64 int. Return Z3_TRUE if the call succeeded.  
   function Z3_Get_Numeral_Int64( C : in Z3_Context ; V : in Z3_Ast ; I : out Int_64_Access ) return Z3_Bool ;
   pragma Import(C,Z3_Get_Numeral_Int64,"Z3_get_numeral_int64") ;
 
   -- Similar to Z3_get_numeral_string, but only succeeds if the value can fit as a rational number as machine __int64 int. Return Z3_TRUE if the call succeeded.    
   function Z3_Get_Numeral_Rational_Int64( C : in Z3_Context ; V : in Z3_Ast ; Num, Den : out Int_64_Access ) return Z3_Bool ;
   pragma Import(C,Z3_Get_Numeral_Rational_Int64,"Z3_get_numeral_rational_int64") ;

   -- Return a lower bound for the given real algebraic number. The interval isolating the number is smaller than 1/10^precision. The result is a numeral AST of sort Real.  
   function Z3_Get_Algebraic_Number_Lower( C : in Z3_Context ; A : in Z3_Ast ; Precision : in Interfaces.C.Unsigned ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Algebraic_Number_Lower,"Z3_get_algebraic_number_lower") ;

   -- Return a upper bound for the given real algebraic number. The interval isolating the number is smaller than 1/10^precision. The result is a numeral AST of sort Real.  
   function Z3_Get_Algebraic_Number_Upper( C : in Z3_Context ; A : in Z3_Ast ; Precision : in Interfaces.C.Unsigned ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Algebraic_Number_Upper,"Z3_get_algebraic_number_upper") ;

   -- Convert a Z3_pattern into Z3_ast. This is just type casting.
   function Z3_Pattern_To_Ast( C : in Z3_Context ; P : in Z3_Pattern ) return Z3_Ast ;
   pragma Import(C,Z3_Pattern_To_Ast,"Z3_pattern_to_ast") ;

   -- Return number of terms in pattern.  
   function Z3_Get_Pattern_Num_Terms( C : in Z3_Context ; P : in Z3_Pattern ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Pattern_Num_Terms,"Z3_get_pattern_num_terms") ;

   -- Return i'th ast in pattern. 
   function Z3_Get_Pattern( C : in Z3_Context ; P : in Z3_Pattern ; Idx : in Interfaces.C.Unsigned ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Pattern,"Z3_get_pattern") ;

   -- Return index of de-Brujin bound variable. 
   function Z3_Get_Index_Value( C : in Z3_Context ; A : in Z3_Ast ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Index_Value,"Z3_get_index_value") ;
   
   -- Determine if quantifier is universal.  
   function Z3_Get_Quantifier_Forall( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Get_Quantifier_Forall,"Z3_is_quantifier_forall") ;

   -- Obtain weight of quantifier.  
   function Z3_Get_Quantifier_Weight( C : in Z3_Context ; A : in Z3_Ast ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Quantifier_Weight,"Z3_get_quantifier_weight") ;

   -- Return number of patterns used in quantifier.  
   function Z3_Get_Quantifier_Num_Patterns( C : in Z3_Context ; A : in Z3_Ast ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Quantifier_Num_Patterns,"Z3_get_quantifier_num_patterns") ;

   -- Return i'th pattern.  
   function Z3_Get_Quantifier_Pattern_Ast( C : in Z3_Context ; A : in Z3_Ast ; I : in Interfaces.C.Unsigned ) return Z3_Pattern ;
   pragma Import(C,Z3_Get_Quantifier_Pattern_Ast,"Z3_get_quantifier_pattern_ast") ;

   -- Return number of no_patterns used in quantifier.  
   function Z3_Get_Quantifier_Num_No_Patterns( C : in Z3_Context ; A : in Z3_Ast ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Quantifier_Num_No_Patterns,"Z3_get_quantifier_num_no_patterns") ;

   -- Return i'th no_pattern.  
   function Z3_Get_Quantifier_No_Pattern_Ast( C : in Z3_Context ; A : in Z3_Ast ; I : in Interfaces.C.Unsigned ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Quantifier_No_Pattern_Ast,"Z3_get_quantifier_no_pattern_ast") ;

   -- Return number of bound variables of quantifier. 
   function Z3_Get_Quantifier_Num_Bound( C : in Z3_Context ; A : in Z3_Ast ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Quantifier_Num_Bound,"Z3_get_quantifier_num_bound") ;
   
   -- Return symbol of the i'th bound variable. 
   function Z3_Get_Quantifier_Bound_Name( C : in Z3_Context ; A : in Z3_Ast ; I : in Interfaces.C.Unsigned ) return Z3_Symbol ;
   pragma Import(C,Z3_Get_Quantifier_Bound_Name,"Z3_get_quantifier_bound_name") ;
 
   -- Return sort of the i'th bound variable. 
   function Z3_Get_Quantifier_Bound_Sort( C : in Z3_Context ; A : in Z3_Ast ; I : in Interfaces.C.Unsigned ) return Z3_Sort ;
   pragma Import(C,Z3_Get_Quantifier_Bound_Sort,"Z3_get_quantifier_bound_sort") ;
   
   -- Return body of quantifier. 
   function Z3_Get_Quantifier_Body( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Quantifier_Body,"Z3_get_quantifier_body") ;
 
   -- Interface to simplifier. 
   function Z3_Simplify( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Simplify,"Z3_simplify") ;
 
   -- Interface to simplifier. 
   function Z3_Simplify_Ex( C : in Z3_Context ; A : in Z3_Ast ; P : in Z3_Params ) return Z3_Ast ;
   pragma Import(C,Z3_Simplify_Ex,"Z3_simplify_ex") ;
 
   -- Return a string describing all available parameters. 
   function Z3_Simplify_Get_Help( C : in Z3_Context ) return Z3_String ;
   pragma Import(C,Z3_Simplify_Get_Help,"Z3_simplify_get_help") ;
 
   -- Return the parameter description set for the simplify procedure. 
   function Z3_Simplify_Get_Param_Descrs( C : in Z3_Context ) return Z3_Param_Descrs ;
   pragma Import(C,Z3_Simplify_Get_Param_Descrs,"Z3_simplify_get_param_descrs") ;
   
end Z3.Accessors;
   
   
   
   
   

