with Ada.Strings.Unbounded ; use Ada.Strings.Unbounded ;

package Ast.Expr is
   
   type Ast_Expr is abstract new Ast_Abstract with null record ;
   
   type Ast_Expr_Node is access all Ast_Expr'Class ;
   
   type Ast_Expr_Var is new Ast_Expr with
     record 
	Expr_Var_Name : Unbounded_String ;
     end record ;
      
   type Ast_Expr_Num is new Ast_Expr with
      record
         Ast_Num_Val : Integer ;
      end record ;
   
   type Ast_Expr_Unary is new Ast_Expr with
      record
	 Unary_Expr : Ast_Node ;
      end record ;
   
   type Bin_Opp is ( Bin_Plus , Bin_Sub , Bin_Mult , Bin_Div , Bin_Mod ) ;
   
   type Ast_Expr_Binary is new Ast_Expr with
      record
	 Binary_Expr_Op : Bin_Opp ;
	 Binary_Expr_Left, Binary_Expr_Right : Ast_Node ;
      end record ;
	 
   function Build_Ast_Expr_Var( S : in String ) return Ast_Node ;
   function Build_Ast_Expr_Num( S : in String ) return Ast_Node ;
   function Build_Ast_Expr_Unary( N : in Ast_Node ) return Ast_Node ;
   function Build_Ast_Expr_Binary( O : Bin_Opp ; L, R : Ast_Node ) return Ast_Node ;
   
end Ast.Expr ;

