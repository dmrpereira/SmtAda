with Ada.Strings.Unbounded ; use Ada.Strings.Unbounded ;

with Ast.Expr, Ast.Formulas ;

package Ast.Pprint is
   
   procedure Pprint_Ast( T : in Ast_Node ) ;
   
private
   
   procedure Pprint_Ast_Var( T : in Ast_Node ) ;
   procedure Pprint_Ast_Expr( T : in Ast_Node ) ;
   procedure Pprint_Ast_Formula( T : in Ast_Node ) ;
   procedure Pprint_Ast_Seq( T : in Ast_Node ) ;
   
   
   
end Ast.Pprint ;
