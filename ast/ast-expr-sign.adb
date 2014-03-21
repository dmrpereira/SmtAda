package body Ast.Expr.Sign is
   
   function Mk_Signed_Expr(E : in Ast_Expr) return Ast_Expr is
   begin
      return (new Ast_Signed'(Signed_Value => True , Signed_Expr => E)) ;
   end Mk_Signed_Expr ;
   
end Ast.Expr.Sign ;

