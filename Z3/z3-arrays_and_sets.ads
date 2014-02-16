with Interfaces.C, Interfaces.C.Strings;
with System;

package Z3.Arrays_And_Sets is
   
   ------------
   -- Arrays --
   ------------
   
   -- Array read. The argument a is the array and i is the index of the array that gets read. 
   function Z3_Mk_Select( C : in Z3_Context ; A, I : in Z3_Ast ) return Z3_Ast; 
   pragma Import(C,Z3_Mk_Select,"Z3_mk_select");
 
   -- Array update. 
   function Z3_Mk_Store( C : in Z3_Context ; A, I, V : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Store,"Z3_mk_store");

   -- Create the constant array. 
   function Z3_Mk_Const_Array(C: in Z3_Context ; Domain : in Z3_Sort ; V : in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Const_Array,"Z3_mk_const_array");

   -- Map f on the the argument arrays.  
   function Z3_Mk_Map(C : in Z3_Context ; F : in Z3_Func_Decl ; N : access constant Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Map,"Z3_mk_map");

   -- Access the array default value. Produces the default range value,
   -- for arrays that can be represented as finite maps with a default range value. 
   function Z3_Mk_Array_Default( C : in Z3_Context ; A : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Array_Default,"Z3_mk_array_default");
   
   -----------
   --  Sets --
   -----------
   
   -- Create Set type.    
   function Z3_Mk_Set_Sort( C : in Z3_Context ; Ty : in Z3_Sort ) return Z3_Sort;
   pragma Import(C,Z3_Mk_Set_Sort,"Z3_mk_set_sort") ;

   -- Create the empty set.  
   function Z3_Mk_Empty_Set( C : in Z3_Context ; Domain : in Z3_Sort ) return Z3_Ast ; 
   pragma Import(C,Z3_Mk_Empty_Set,"Z3_mk_empty_set") ;

   -- Create the full set.  
   function Z3_Mk_Full_Set( C : in Z3_Context ; Domain : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Full_Set,"Z3_mk_full_set") ;

   -- Add an element to a set.  
   function Z3_Mk_Set_Add( C : in Z3_Context ; Set : in Z3_Ast ; Elem : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Set_Add,"Z3_mk_set_add") ;

   -- Remove an element to a set. 
   function Z3_Mk_Set_Del( C : in Z3_Context ; Set : in Z3_Ast ; Elem : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Set_Del,"Z3_mk_set_del") ;
 
   -- Take the union of a list of sets.    
   function Z3_Mk_Set_Union( C : in Z3_Context ; Num_Args : in Interfaces.C.Unsigned ; Args : in Z3_Ast_Array ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Set_Union,"Z3_mk_set_union") ;

   -- Take the intersection of a list of sets. 
   function Z3_Mk_Set_Intersect( C : in Z3_Context ; Num_Args : in Interfaces.C.Unsigned ; Args : in Z3_Ast_Array ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Set_Intersect,"Z3_mk_set_intersect") ;

   -- Take the set difference between two sets.  
   function Z3_Mk_Set_Difference( C : in Z3_Context ; Arg1, Arg2 : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Set_Difference,"Z3_mk_set_difference") ;

   -- Take the complement of a set.  
   function Z3_Mk_Set_Complement( C : in Z3_Context ; Arg : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Set_Complement,"Z3_mk_set_complement") ;

   -- Check for set membership.  
   function Z3_Mk_Set_Member( C : in Z3_Context ; Elem, Set : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Set_Member,"Z3_mk_set_member") ;

   -- Check for subsetness of sets.  
   function Z3_Mk_Set_Subset( C : in Z3_Context ; Arg1, Arg2 : in Z3_Ast ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Set_Subset,"Z3_mk_set_subset");

end Z3.Arrays_And_Sets;
