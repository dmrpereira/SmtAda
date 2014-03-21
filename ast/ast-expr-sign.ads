package Ast.Expr.Sign is
   
   type Ast_Signed is new Abs_Expr with
      record
	 Signed_Value : Boolean := False ;
	 Signed_Expr : Ast_Expr := null ;
      end record ;
   
   
   function Mk_Signed_Expr(E : in Ast_Expr) return Ast_Expr ;
   
   
end Ast.Expr.Sign ;
