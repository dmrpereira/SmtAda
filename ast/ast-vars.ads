with Ada.Strings.Unbounded ; use Ada.Strings.Unbounded ;

with Ast.Types ; use Ast.Types ;

package Ast.Vars is
   
   type Ast_Var is new Ast_Abstract with
      record
	 Ast_Var_Name : Unbounded_String ;
	 Ast_Var_Type : Ast_Type_Node ;
      end record ;
   
   function Mk_Ast_Var(N : in String ; T : in String) return Ast_Node ;
   
end Ast.Vars ;
