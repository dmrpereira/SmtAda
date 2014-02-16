with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3.Models is 
   
   -------------
   --  Models --
   -------------
   
   -- Increment the reference counter of the given model. 
   procedure Z3_Model_Inc_Ref( C : in Z3_Context ; M : in Z3_Model ) ;
   
   -- Decrement the reference counter of the given model. 
   procedure Z3_Model_Dec_Ref( C : in Z3_Context ; M : in Z3_Model ) ;
   
   -- Evaluate the AST node t in the given model. Return Z3_TRUE if succeeded, and store the result in v.If model_completion
   -- is Z3_TRUE, then Z3 will assign an interpretation for any consta     nt or function that does not have an interpretation
   -- in m. These constants and functions were essentially don't cares. 
   function Z3_Model_Eval( C : in Z3_Context ; M : in Z3_Model ; T : in Z3_Ast ; Model_Completion : in Z3_Bool ; V : out Z3_Ast_Access ) return Z3_Bool ;

   -- Return the interpretation (i.e., assignment) of constant a in the model m. Return NULL, if the model does not assign an
   -- interpretation for a. That should be interpreted as: the value of a does not matter.    
   function Z3_Model_Get_Const_Interp( C : in Z3_Context ; M : in Z3_Model ; A : in Z3_Func_Decl ) return Z3_Ast ;

   -- Return the interpretation of the function f in the model m. Return NULL, if the model does not assign an interpretation 
   -- for f. That should be interpreted as: the f does not matter.    
   function Z3_Model_Get_Func_Interp( C : in Z3_Context ; M : in Z3_Model ; F : in Z3_Func_Decl ) return Z3_Func_Interp ;
   
   -- Return the number of constants assigned by the given model.    
   function Z3_Model_Get_Num_Consts( C : in Z3_Context ; M : in Z3_Model ) return Interfaces.C.Unsigned ;
   
   -- Return the i-th constant in the given model. 
   function Z3_Model_Get_Const_Decl( C : in Z3_Context ; M : in Z3_Model ; I : in Interfaces.C.Unsigned ) return Z3_Func_Decl ;
   
   -- Return the number of function interpretations in the given model.
   function Z3_Model_Get_Num_Funcs( C : in Z3_Context ; M : in Z3_Model ) return Interfaces.C.Unsigned ;

   -- Return the declaration of the i-th function in the given model.
   function Z3_Model_Get_Func_Decl( C : in Z3_Context ; M : in Z3_Model ; I : in Interfaces.C.Unsigned ) return Z3_Func_Decl ;

   -- Return the number of uninterpreted sorts that m assigs an interpretation to.  
   function Z3_Model_Get_Num_Sorts( C : in Z3_Context ; M : in Z3_Model ) return Interfaces.C.Unsigned ;

   -- Return a uninterpreted sort that m assigns an interpretation.  
   function Z3_Model_Get_Sort( C : in Z3_Context ; M : in Z3_Model ; I : in Interfaces.C.Unsigned  ) return Z3_Sort ;

   -- Return the finite set of distinct values that represent the interpretation for sort s.
   function Z3_Model_Get_Sort_Universe( C : in Z3_Context ; M : in Z3_Model ; S : in Z3_Sort ) return Z3_Ast_Vector ;

   -- The (_ as-array f) AST node is a construct for assigning interpretations for arrays in Z3. It is the array such
   -- that forall indices i we have that (select (_ as-array f) i) is equal to (f i). This procedure returns Z3_TRUE 
   -- if the a is an as-array AST node.  
   function Z3_Is_As_Array( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Bool ;

   -- Return the function declaration f associated with a (_ as_array f) node.  
   function Z3_Get_As_Array_Func_Decl( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Func_Decl ;

   -- Increment the reference counter of the given Z3_func_interp object.  
   procedure Z3_Func_Interp_Inc_Ref( C : in Z3_Context ; F : in Z3_Func_Interp );

   -- Decrement the reference counter of the given Z3_func_interp object.  
   procedure Z3_Func_Interp_Dec_Ref( C : in Z3_Context ; F : in Z3_Func_Interp );

   -- Return the number of entries in the given function interpretation.
   function Z3_Func_Interp_Get_Num_Entries( C : in Z3_Context ; F : in Z3_Func_Interp ) return Interfaces.C.Unsigned ;

   -- Return a "point" of the given function intepretation. It represents the value of f in a particular point.  
   function Z3_Func_Interp_Get_Entry( C : in Z3_Context ; F : in Z3_Func_Interp ; I : in Interfaces.C.Unsigned ) return Z3_Func_Entry ;

   -- Return the 'else' value of the given function interpretation.  
   function Z3_Func_Interp_Get_Else( C : in Z3_Context ; F : in Z3_Func_Interp ) return Z3_Ast ;

   -- Return the arity (number of arguments) of the given function interpretation.  
   function Z3_Func_Interp_Get_Arity( C : in Z3_Context ; F : in Z3_Func_Interp ) return Interfaces.C.Unsigned ;

   -- Increment the reference counter of the given Z3_func_entry object. 
   procedure Z3_Func_Entry_Inc_Ref( C : in Z3_Context ; E : in Z3_Func_Entry ) ;

   -- Decrement the reference counter of the given Z3_func_entry object.  
   procedure Z3_Func_Entry_Dec_Ref( C : in Z3_Context ; E : in Z3_Func_Entry ) ;

   -- Return the value of this point.  
   function Z3_Func_Entry_Get_Value( C : in Z3_Context ; E : in Z3_Func_Entry ) return Z3_Ast ;

   -- Return the number of arguments in a Z3_func_entry object.  
   function Z3_Func_Entry_Get_Num_Args( C : in Z3_Context ; E : in Z3_Func_Entry ) return Interfaces.C.Unsigned ;

   -- Return an argument of a Z3_func_entry object.    
   function Z3_Func_Entry_Get_Arg( C : in Z3_Context ; E : in Z3_Func_Entry ; I : in Interfaces.C.Unsigned ) return Z3_Ast ;
   

private


   pragma Import(C,Z3_Model_Inc_Ref,"Z3_model_inc_ref") ;

   pragma Import(C,Z3_Model_Dec_Ref,"Z3_model_dec_ref") ;

   pragma Import(C,Z3_Model_Eval,"Z3_model_eval") ;

   pragma Import(C,Z3_Model_Get_Const_Interp,"Z3_model_get_const_interp") ;

   pragma Import(C,Z3_Model_Get_Func_Interp,"Z3_model_get_func_interp") ;

   pragma Import(C,Z3_Model_Get_Num_Consts,"Z3_model_get_num_consts") ;

   pragma Import(C,Z3_Model_Get_Const_Decl,"Z3_model_get_const_decl") ;

   pragma Import(C,Z3_Model_Get_Num_Funcs,"Z3_model_get_num_funcs") ;

   pragma Import(C,Z3_Model_Get_Func_Decl,"Z3_model_get_func_decl") ;

   pragma Import(C,Z3_Model_Get_Num_Sorts,"Z3_model_get_num_sorts") ;

   pragma Import(C,Z3_Model_Get_Sort,"Z3_model_get_sort") ;

   pragma Import(C,Z3_Model_Get_Sort_Universe,"Z3_model_get_sort_universe") ;

   pragma Import(C,Z3_Is_As_Array,"Z3_is_as_array") ;

   pragma Import(C,Z3_Get_As_Array_Func_Decl,"Z3_get_as_array_func_decl") ;

   pragma Import(C,Z3_Func_Interp_Inc_Ref,"Z3_func_interp_inc_ref") ;

   pragma Import(C,Z3_Func_Interp_Dec_Ref,"Z3_func_interp_dec_ref") ;

   pragma Import(C,Z3_Func_Interp_Get_Num_Entries,"Z3_func_interp_get_num_entries") ;

   pragma Import(C,Z3_Func_Interp_Get_Entry,"Z3_func_interp_get_entry") ;

   pragma Import(C,Z3_Func_Interp_Get_Else,"Z3_func_interp_get_else") ;

   pragma Import(C,Z3_Func_Interp_Get_Arity,"Z3_func_interp_get_arity") ;

   pragma Import(C,Z3_Func_Entry_Inc_Ref,"Z3_func_entry_inc_ref") ;

   pragma Import(C,Z3_Func_Entry_Dec_Ref,"Z3_func_entry_dec_ref") ;

   pragma Import(C,Z3_Func_Entry_Get_Value,"Z3_func_entry_get_value") ;

   pragma Import(C,Z3_Func_Entry_Get_Num_Args,"Z3_func_entry_get_num_args") ;

   pragma Import(C,Z3_Func_Entry_Get_Arg,"Z3_func_entry_get_arg") ;

end Z3.Models ;
