with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3.Deprecated is
   
   ------------------
   --   Statistics --
   ------------------
   
   -- Convert a statistics into a string. 
   function Z3_Stats_To_String( C : in Z3_Context ; S : in Z3_Stats ) return Z3_String ;
   pragma Import(C,Z3_Stats_To_String,"Z3_stats_to_string") ;
   
   -- Increment the reference counter of the given statistics object.    
   procedure Z3_Stats_Inc_Ref( C : in Z3_Context ; S : in Z3_Stats );
   pragma Import(C,Z3_Stats_Inc_Ref,"Z3_stats_inc_ref") ;

   -- Decrement the reference counter of the given statistics object. 
   procedure Z3_Stats_Dec_Ref( C : in Z3_Context ; S : in Z3_Stats );
   pragma Import(C,Z3_Stats_Dec_Ref,"Z3_stats_dec_ref") ;
   
   -- turn the number of statistical data in s. 
   function Z3_Stats_Size( C : in Z3_Context ; S : in Z3_Stats ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Stats_Size,"Z3_stats_size") ;
 
   -- Return the key (a string) for a particular statistical data. 
   function Z3_Stats_Get_Key( C : in Z3_Context ; S : in Z3_Stats ; Idx : in Interfaces.C.Unsigned ) return Z3_String ;
   pragma Import(C,Z3_Stats_Get_Key,"Z3_stats_get_key") ;
   
   -- Return Z3_TRUE if the given statistical data is a unsigned integer. 
   function Z3_Stats_Is_Uint( C : in Z3_Context ; S : in Z3_Stats ; Idx : Interfaces.C.Unsigned ) return Z3_Bool ;
   pragma Import(C,Z3_Stats_Is_Uint,"Z3_stats_is_uint") ;
 
   -- Return Z3_TRUE if the given statistical data is a double. 
   function Z3_Stats_Is_Double( C : in Z3_Context ; S : in Z3_Stats ; Idx : Interfaces.C.Unsigned ) return Z3_Bool ;
   pragma Import(C,Z3_Stats_Is_Double,"Z3_stats_is_double") ;
   
   -- Return the unsigned value of the given statistical data. 
   function Z3_Stats_Get_Uint_Value( C : in Z3_Context ; S : in Z3_Stats ; Idx : Interfaces.C.Unsigned ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Stats_Get_Uint_Value,"Z3_stats_get_uint_value") ;
   
   -- Return the double value of the given statistical data. 
   function Z3_Stats_Get_Double_Value( C : in Z3_Context ; S : in Z3_Stats ; Idx : Interfaces.C.Unsigned ) return Interfaces.C.Double ;
   pragma Import(C,Z3_Stats_Get_Double_Value,"Z3_stats_get_double_value") ;
   
   -----------------------------------------
   --  Deprecated Injective functions API --
   -----------------------------------------   
   
   -- Create injective function declaration. 
   function Z3_Mk_Injective_Functions( C : in Z3_Context ; 
				       S : in Z3_Symbol ; 
				       Domain_Size : Interfaces.C.Unsigned ;
				       Domain : in Z3_Sort_Array ;
				       R : in Z3_Sort ) return Z3_Func_Decl ;
   pragma Import(C,Z3_Mk_Injective_Functions,"Z3_mk_injective_function") ;
 
   ---------------------------------
   --  Deprecated Constraints API --
   ---------------------------------
   
   -- Set the SMTLIB logic to be used in the given logical context. It is incorrect to invoke this 
   -- function after invoking Z3_check, Z3_check_and_get_model, Z3_check_assumptions and Z3_push. 
   -- Ret  urn Z3_TRUE if the logic was changed successfully, and Z3_FALSE otherwise. 
   function Z3_Set_Logic( C : in Z3_Context ; Logic : in Z3_String ) return Z3_Bool ;
   pragma Import(C,Z3_Set_Logic,"Z3_set_logic") ;

   -- Create a backtracking point. 
   procedure Z3_Push( C : in Z3_Context ) ;
   pragma Import(C,Z3_Push,"Z3_push") ;
   
   -- Backtrack. 
   procedure Z3_Pop( C : in Z3_Context ; Num_Scopes : in Interfaces.C.Unsigned );
   pragma Import(C,Z3_Pop,"Z3_pop") ;
   
   -- Retrieve the current scope leve
   function Z3_Get_Num_Scopes( C : in Z3_Context ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Num_Scopes,"Z3_get_num_scopes") ;
   
   -- Persist AST through num_scopes pops. This function is only relevant if c was created using
   -- Z3_mk_context. If c was created using Z3_mk_context_rc, this function is a NOOP. 
   procedure Z3_Persist_Ast( C : in Z3_Context ; A : in Z3_Ast ; Num_Scopes : in Interfaces.C.Unsigned );
   pragma Import(C,Z3_Persist_Ast,"Z3_persist_ast") ;
   
   -- Assert a constraint into the logical context. 
   procedure Z3_Assert_Cnstr( C : in Z3_Context ; A : in Z3_Ast );
   pragma Import(C,Z3_Assert_Cnstr,"Z3_assert_cnstr") ;
   
   -- Check whether the given logical context is consistent or not. 
   function Z3_Check_And_Get_Model( C : in Z3_Context ; M : out Z3_Model ) return Z3_Lbool ;
   pragma Import(C,Z3_Check_And_Get_Model,"Z3_check_and_get_model") ;
   
   -- Check whether the given logical context is consistent or not. 
   function Z3_Check( C : in Z3_Context ) return Z3_Lbool ;
   pragma Import(C,Z3_Check,"Z3_check") ;
 
   -- Check whether the given logical context and optional assumptions is consistent or not. 
   -- Z3 Retrieve congruence class representatives for terms. 
   function Z3_Get_Implied_Equalities( C : in Z3_Context ; 
				       Num_Terms : in Interfaces.C.Unsigned ;
				       Terms : in Z3_Ast_Array ;
				       Class_Ids : out Unsigned_Array ) return Z3_Lbool ;
   pragma Import(C,Z3_Get_Implied_Equalities,"Z3_get_implied_equalities") ;

   -- Delete a model object. 
   procedure Z3_Del_Model( C : in Z3_Context ; M : in Z3_Model ) ;
   pragma Import(C,Z3_Del_Model,"Z3_del_model") ;
   
   ------------------------------------
   --  Deprecated Search control API --
   ------------------------------------
   
   -- Cancel an ongoing check. 
   procedure Z3_Soft_Check_Cancel( C : in Z3_Context ) ;
   pragma Import(C,Z3_Soft_Check_Cancel,"Z3_soft_check_cancel") ;
 
   -- Retrieve reason for search failure. 
   function Z3_Get_Search_Failure( C : in Z3_Context ) return Z3_Search_Failure ;
   pragma Import(C,Z3_Get_Search_Failure,"Z3_get_search_failure") ;
   
   ----------------------------
   --  Deprecated Labels API --
   ----------------------------
   
   -- Create a labeled formula. 
   --  function Z3_Mk_Label( C : in Z3_Context ; S : in Z3_Symbol ; Is_Pos : in Z3_Bool ; F : in Z3_Ast ) return Z3_Ast ;
   --  pragma Import(C,Z3_Mk_Label,"Z3_mk_label") ;
 
   --  -- Retrieve the set of labels that were relevant in the context of the current satisfied context. 
   --  function Z3_Get_Relevant_Labels( C : in Z3_Context ) return Z3_Literals ;
   --  pragma Import(C,Z3_Get_Relevant_Labels,"Z3_get_relevant_labels") ;
   
   --  -- Retrieve the set of literals that satisfy the current context. 
   --  function Z3_Get_Relevant_Literals( C : in Z3_Context ) return Z3_Literals ;
   --  pragma Import(C,Z3_Get_Relevant_Literals,"Z3_get_relevant_literals") ;
   --  --  Z3_literals Z3_API 	Z3_get_relevant_literals (__in Z3_context c)
   
   --  -- Retrieve the set of literals that whose assignment were guess, but not propagated during the search. 
   --  function Z3_Get_Guessed_Literals( C : in Z3_Context ) return Z3_Literals ;
   --  pragma Import(C,Z3_Get_Relevant_Labels,"Z3_get_guessed_literals") ;
   
   --  -- Delete a labels context. 
   --  procedure Z3_Del_Literals( C : in Z3_Context ; Lbls : in Z3_Literals );
   --  pragma Import(C,Z3_Del_Literals,"Z3_del_literals") ;
   
   --  -- Retrieve the number of label symbols that were returned.
   --  function Z3_Get_Num_literals( C : in Z3_Context ; Lbls : in Z3_Literals ) return Interfaces.C.Unsigned ;
   --  pragma Import(C,Z3_Get_Num_Literals,"Z3_get_num_literals") ;
   
   --  -- Retrieve label symbol at idx. 
   --  function Z3_Get_Label_Symbol( C : in Z3_Context ; Lbls : in Z3_Literals ; Idx : in Interfaces.C.Unsigned ) return Z3_Symbol ;
   --  pragma Import(C,Z3_Get_Label_Symbol,"Z3_get_label_symbol") ;
   
   --  -- Retrieve literal expression at idx. 
   --  function Z3_Get_Literal( C : in Z3_Context ; Lbls : in Z3_Literals ; Idx : in Interfaces.C.Unsigned ) return Z3_Ast ;
   --  pragma Import(C,Z3_Get_Literal,"Z3_get_literal") ;
   
   --  -- Disable label. 
   --  procedure Z3_Disable_Literal( C : in Z3_Context ; Lbls : in Z3_Literals ; Idx : in Interfaces.C.Unsigned );
   --  pragma Import(C,Z3_Disable_Literal,"Z3_disable_literal") ;
   
   --  -- Block subsequent checks using the remaining enabled labels. 
   --  procedure Z3_Block_Literals( C : in Z3_Context ; Lbls : in Z3_Literals ) ;
   --  pragma Import(C,Z3_Block_Literals,"Z3_block_literals") ;
   
   ---------------------------
   --  Deprecated Model API --
   ---------------------------
   
   -- Return the number of constants assigned by the given model. 
   function Z3_Get_Model_Num_Constants( C : in Z3_Context ; M : in Z3_Model ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Model_Num_Constants,"Z3_get_model_num_constants") ;
   
   -- Return the i-th constant in the given model. 
   function Z3_Get_Model_Constant( C : in Z3_Context ; M : in Z3_Model ; I : in Interfaces.C.Unsigned ) return Z3_Func_Decl ;
   pragma Import(C,Z3_Get_Model_Constant,"Z3_get_model_constant") ;
   
   -- Return the number of function interpretations in the given model. 
   function Z3_Get_Model_Num_Funcs( C : in Z3_Context ; M : in Z3_Model ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Model_Num_Funcs,"Z3_get_model_num_funcs") ;
   
   -- Return the declaration of the i-th function in the given model. 
   function Z3_Get_Model_Func_Decl( C : in Z3_Context ; M : in Z3_Model ; I : in Interfaces.C.Unsigned ) return Z3_Func_Decl ;
   pragma Import(C,Z3_Get_Model_Func_Decl,"Z3_get_model_func_decl") ;
   
   -- Return the value of the given constant or function in the given model. 
   function Z3_Eval_Func_Decl( C : in Z3_Context ; M : in Z3_Model ; Decl : in Z3_Func_Decl ; V : out Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Eval_Func_Decl,"Z3_eval_func_decl") ;
 
   -- Determine whether the term encodes an array value. A term encodes an array value if it is a nested
   -- sequence of applications of store on top of a constant array. The indices to the stores have to be
   -- values (for example, integer constants) so that equality between the indices can be evaluated. 
   -- Array values are useful for representing interpretations for arrays. 
   function Z3_Is_Array_Value( C : in Z3_Context ; M : in Z3_Model ; V : in Z3_Ast ; Num_Entries : out Interfaces.C.Unsigned ) return Z3_Bool ;
   pragma Import(C,Z3_Is_Array_Value,"Z3_is_array_value") ;
 
   -- An array values is represented as a dictionary plus a default (else) value. This function returns the array graph. 
   -- Return the 'else' value of the i-th function interpretation in the given model.    
   function Z3_Get_Model_Func_Else( C : in Z3_Context ; M : in Z3_Model ; I : in Interfaces.C.Unsigned ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Model_Func_Else,"Z3_get_model_func_else") ;

   -- Return the number of entries of the i-th function interpretation in the given model. 
   function Z3_Get_Model_Func_Num_Entries( C : in Z3_Context ; M : in Z3_Model ; I : in Interfaces.C.Unsigned ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Model_Func_Num_Entries,"Z3_get_model_func_num_entries") ;
   
   -- Return the number of arguments of the j-th entry of the i-th function interpretation in the given model. 
   function Z3_Get_Model_Func_Entry_Num_Args( C : in Z3_Context ; M : in Z3_Model ; I, J : in Interfaces.C.Unsigned ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Get_Model_Func_Entry_Num_Args,"Z3_get_model_func_entry_num_args") ;
   
   -- Return the k-th argument of the j-th entry of the i-th function interpretation in the given model. 
   function Z3_Get_Model_Func_Entry_Arg( C : in Z3_Context ; M : in Z3_Model ;  I, J : in Interfaces.C.Unsigned ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Model_Func_Entry_Arg,"Z3_get_model_func_entry_arg") ;
   
   -- Return the return value of the j-th entry of the i-th function interpretation in the given model. 
   function Z3_Get_Model_Func_Entry_Value( C : in Z3_Context ; M : in Z3_Model ; I, J : in Interfaces.C.Unsigned ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Model_Func_Entry_Value,"Z3_get_model_func_entry_value") ;
   
   -- Evaluate the AST node t in the given model. Return Z3_TRUE if succeeded, and store the result in v.
   -- The evaluation may fail for the following reasons: 
   function Z3_Eval( C : in Z3_Context ; M : in Z3_Model ; T : in Z3_Ast ; V : out Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Eval,"Z3_eval") ;
   
   -- Evaluate declaration given values. 
   function Z3_Eval_Decl( C : in Z3_Context ;
			  M : in Z3_Model ;
			  D : in Z3_Func_Decl ;
			  Num_Args : in Interfaces.C.Unsigned ;
			  Args : in Z3_Ast_Array ;
			  V : out Z3_Ast ) return Z3_Bool ;
   pragma Import(C,Z3_Eval_Decl,"Z3_eval_decl") ;
   
   ---------------------------------------
   --  Deprecated String conversion API --
   ---------------------------------------
   
   -- Convert the given logical context into a string. 
   function Z3_Context_To_String( C : in Z3_Context ) return Z3_String ;
   pragma Import(C,Z3_Context_To_String,"Z3_context_to_string") ;
   
   -- Return runtime statistics as a string. 
   function Z3_Statistics_To_String( C : in Z3_Context ) return Z3_String ;
   pragma Import(C,Z3_Statistics_To_String,"Z3_statistics_to_string") ;
   
   -- Extract satisfying assignment from context as a conjunction. 
   function Z3_Get_Context_Assignment( C : in Z3_Context ) return Z3_Ast ;
   pragma Import(C,Z3_Get_Context_Assignment,"Z3_get_context_assignment") ;
   
end Z3.Deprecated ;
