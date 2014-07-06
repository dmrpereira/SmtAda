with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3.Modifiers is

   ----------------
   --  Modifiers --
   ----------------
   
   -- Update the arguments of term a using the arguments args. The number of arguments num_args should coincide with
   -- the number of arguments to a. If a is a quantifier, then num_args has to be 1
   function Z3_Update_Term( C : in Z3_Context ; A : in Z3_Ast ; Num_Args : in Interfaces.C.Unsigned ; Args : in Z3_Ast_Array ) return Z3_Ast ;
   pragma Import(C,Z3_Update_Term,"Z3_update_term") ;
   
   -- Substitute every occurrence of from[i] in a with to[i], for i smaller than num_exprs. The result is the new AST.
   -- The arrays from and to must have size num_exprs. For every i smaller than num_exprs, we must have that sort of 
   -- from[i] must be equal to sort of to[i]. 
   function Z3_Substitute( C : in Z3_Context ; A : in Z3_Ast ; Num_Exprs : in Interfaces.C.Unsigned ; From, To : in Z3_Ast_Array ) return Z3_Ast ;
   pragma Import(C,Z3_Substitute,"Z3_substitute") ;
   
   -- Substitute the free variables in a with the expressions in to. For every i smaller than num_exprs, the variable 
   -- with de-Bruijn index i is replaced with term to[i]. 
   function Z3_Substitute_Vars( C : in Z3_Context ; A : in Z3_Ast ; Num_Exprs : in Interfaces.C.Unsigned ; To : in Z3_Ast_Array ) return Z3_Ast ;
   pragma Import(C,Z3_Substitute_Vars,"Z3_substitute_vars") ;
   
   -- Translate/Copy the AST a from context source to context target. AST a must have been created using context source.    
   function Z3_Translate( Source : in Z3_Context ; A : in Z3_Ast ; Target : in Z3_Context ) return Z3_Ast ;
   pragma Import(C,Z3_Translate,"Z3_translate") ;
   
end Z3.Modifiers ;
