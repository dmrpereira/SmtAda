package Ast.Expr.Num is
   
   type Ast_Num is new Abs_Expr with
      record
	 Ast_Num_Val : Integer := 0;
      end record ;
   
   function Mk_Ast_Num(S : in String) return Ast_Expr ;
   
end Ast.Expr.Num ;
