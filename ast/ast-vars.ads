with Ada.Strings.Unbounded ; use Ada.Strings.Unbounded ;

package Ast.Vars is
   
   type Type_Case is (Type_Nat,Type_Bool) ;
   
   type Ast_Var is new Abs_Ast with
      record
	 Ast_Var_Name : Unbounded_String ;
	 Ast_Var_Type : Type_Case ;
      end record ;
   
   function Mk_Ast_Var(N : in Unbounded_String ; T : in Type_Case) return Ast_Node ;
   
end Ast.Vars ;
