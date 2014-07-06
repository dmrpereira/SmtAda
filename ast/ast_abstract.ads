package Ast_Abstract is
   
   type Context is abstract tagged null record ;
   -- Abstracts : Z3_Context, Z3_Config, CVC_VC, Yices_Context, ...
   type Context_Access is access all Context'Class;
   
   type Expr is abstract tagged null record ;
   -- Abstracts : Z3_Ast, Yices_Expr, CVC_Expr, ...
   type Expr_Access is access all Expr'Class;
   
   type Sort is abstract tagged null record;
   -- Abstracts : CVC_Type, Z3_Sort, ...
   type Sort_Access is access all Sort'Class;
  
  
end Ast_Abstract;
