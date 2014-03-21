package Ast.Expr is
   
   type Abs_Expr is abstract new Abs_Ast with null record ;
   
   type Ast_Expr is access all Abs_Expr'Class ;
   
end Ast.Expr ;
