with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3.Quants is
   
   ------------------
   --  Quantifiers --
   ------------------
   
   
   -- Create a pattern for quantifier instantiation.    
   function Z3_Mk_Pattern( C : in Z3_Context ; Num_Patterns : in Interfaces.C.Unsigned ; Terms : in Z3_Ast_Array ) return Z3_Pattern ;
   pragma Import(C,Z3_Mk_Pattern,"Z3_mk_pattern") ;

   -- Create a bound variable.  
   function Z3_Mk_Bound( C : in Z3_Context ; Index : in Interfaces.C.Unsigned ; Ty : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Bound,"Z3_mk_bound") ;

   -- Create a forall formula. It takes an expression body that contains bound variables of the same sorts as the sorts listed in the
   -- array sorts. The bound variables are de-Bruijn indices created using Z3_mk_bound. The array decl_names contains the names that
   -- the quantified formula uses for the bound variables. Z3 applies the convention that the last element in the decl_names and sorts 
   -- array refers to the variable with index 0, the second to last element of decl_names and sorts refers to the variable with index 1, etc.  
   function Z3_Mk_Forall( C : in Z3_Context ; 
			  Weight, Num_patterns : in Interfaces.C.Unsigned ;
			  Patterns : in Z3_Pattern_Array ;
			  Num_Decls : in Interfaces.C.Unsigned ;
			  Sorts : in Z3_Sort_Array ;
			  Decl_Names : in Z3_Symbol_Array ;
			  B : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Forall,"Z3_mk_forall") ;

   
   -- Create an exists formula. Similar to Z3_mk_forall.    
   function Z3_Mk_Exists( C : in Z3_Context ;
			  Weight, Num_Patterns : in Interfaces.C.Unsigned ;
			  Patterns : in Z3_Pattern_Array ;
			  Num_Decls : in Interfaces.C.Unsigned ;
			  Sorts : in Z3_Sort_Array ;
			  Decl_Names : in Z3_Symbol_Array ;
			  B : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Exists,"Z3_mk_exists") ;

 
   -- Create a quantifier - universal or existential, with pattern hints. See the documentation 
   -- for Z3_mk_forall for an explanation of the parameters.    
   function Z3_Mk_Quantifier( C : in Z3_Context ;
			      Is_Forall : in Z3_Bool ;
			      Weight, Num_Patterns : in Interfaces.C.Unsigned ;
			      Patterns : in Z3_Pattern_Array ;
			      Num_Decls : in Interfaces.C.Unsigned ;
			      Sorts : in Z3_Sort_Array ;
			      Decl_Names : in Z3_Symbol_Array ;
			      B : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Quantifier,"Z3_mk_quantifier") ;

   
   -- Create a quantifier - universal or existential, with pattern hints, no patterns, and attributes.    
   function Z3_Mk_Quantifier_Ex( C : in Z3_Context ;
				 Is_Forall : in Z3_Bool ;
				 Weight : in Interfaces.C.Unsigned ;
				 Quantifier_Id : in Z3_Symbol ;
				 Skolem_Id : in Z3_Symbol ;
				 Num_Patterns : in Interfaces.C.Unsigned ;
				 Patterns : in Z3_Pattern_Array ;
				 Num_No_Patterns : in Interfaces.C.Unsigned ;
				 No_Patterns : in Z3_Ast_Array ;
				 Num_Decls : in Interfaces.C.Unsigned ;
				 Sorts : in Z3_Sort_Array ;
				 Decl_Names : in Z3_Symbol_Array ;
				 B : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Quantifier_Ex,"Z3_mk_quantifier_ex") ;

   -- Create a universal quantifier using a list of constants that will form the set of bound variables.  
   function Z3_Mk_Forall_Const( C : in Z3_Context ;
				Weight, Num_Bound : in Interfaces.C.Unsigned ;
				Bound : in Z3_App_Array ;
				Num_Patterns : in Interfaces.C.Unsigned ;
				Patterns : in Z3_Pattern_Array ;
				B : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Forall_Const,"Z3_mk_forall_const") ;

   -- Similar to Z3_mk_forall_const.  
   function Z3_Mk_Exists_Const( C : in Z3_Context ;
				Weight, Num_Bound : in Interfaces.C.Unsigned ;
				Bound : in Z3_App_Array ;
				Num_Patterns : in Interfaces.C.Unsigned ;
				Patterns : in Z3_Pattern_Array ;
				B : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Exists_Const,"Z3_mk_exists_const") ;

   -- Create a universal or existential quantifier using a list of constants that will form the set of bound variables. 
   function Z3_Mk_Quantifier_Const( C : in Z3_Context ;
				    Is_Forall : in Z3_Bool ;
				    Weight, Num_Bound : in Interfaces.C.Unsigned ;
				    Bound : in Z3_App_Array ;
				    Num_Patterns : in Interfaces.C.Unsigned ;
				    Patterns : in Z3_Pattern_Array ;
				    B : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Quantifier_Const,"Z3_mk_quantifier_const") ;

   -- Create a universal or existential quantifier using a list of constants that will form the set of bound variables.  
   function Z3_Mk_Quantifier_Const_Ex( C : in Z3_Context ;
				       Is_Forall : in Z3_Bool ;
				       Weight : in Interfaces.C.Unsigned ;
				       Quantifier_Id : in Z3_Symbol ;
				       Skolem_Id : in Z3_Symbol ;
				       Num_Patterns : in Interfaces.C.Unsigned ;
				       Patterns : in Z3_Pattern_Array ;
				       Num_No_Patterns : in Interfaces.C.Unsigned ;
				       No_Patterns : in Z3_Ast_Array ;
				       Num_Decls : in Interfaces.C.Unsigned ;
				       Sorts : in Z3_Sort_Array ;
				       Decl_Names : in Z3_Symbol_Array ;
				       B : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Quantifier_Const_Ex,"Z3_mk_quantifier_const_ex") ;

 
   
   
end Z3.Quants ;
