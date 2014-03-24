package Ast.Expr.Num is

   type Ast_Num is new Ast_Expr with
      record
         Ast_Num_Sign : Boolean := False ;
         Ast_Num_Val  : Natural := 0 ;
      end record ;

   function Mk_Ast_Num(S : in String) return Ast_Expr_Node ;

end Ast.Expr.Num ;
