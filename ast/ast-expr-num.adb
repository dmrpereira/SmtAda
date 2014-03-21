package body Ast.Expr.Num is 
   
   function Mk_Ast_Num(S : in String) return Ast_Expr is
   begin
      return (new Ast_Num'(Ast_Num_Val => Integer'Value(S))) ;
   end Mk_Ast_Num ;
    
end Ast.Expr.Num ;
