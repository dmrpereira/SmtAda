package body Ast.Expr is
   
   function Build_Ast_Expr_Num( S : in String ) return Ast_Node  is
   begin
      return (new Ast_Expr_Num'(Ast_Num_Val => Integer'Value(S))) ;
   end Build_Ast_Expr_Num ;
   
   function Build_Ast_Expr_Var( S : in String ) return Ast_Node is
   begin
      return (new Ast_Expr_Var'(Expr_Var_Name => To_Unbounded_String(S))) ;
   end Build_Ast_Expr_Var ;
   
   function Build_Ast_Expr_Unary( N : in Ast_Node ) return Ast_Node is
   begin
      return (new Ast_Expr_Unary'(Unary_Expr => N)) ;
   end Build_Ast_Expr_Unary ;
   
   function Build_Ast_Expr_Binary( O : Bin_Opp ; L, R : Ast_Node ) return Ast_Node is
   begin
      return (new Ast_Expr_Binary'(Binary_Expr_Op => O, 
				   Binary_Expr_Left => L, 
				   Binary_Expr_Right => R)) ;
   end Build_Ast_Expr_Binary ;
   
end Ast.Expr ;
