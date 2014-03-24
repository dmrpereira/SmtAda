package body Ast.Expr.Num is

   function Mk_Ast_Num(S : in String) return Ast_Expr_Node is
      I : Integer ;
   begin
      I := Integer'Value(S) ;

      if I < 0 then
         return (new Ast_Num'(Ast_Num_Sign => True,
                              Ast_Num_Val  => Natural(-1*I))) ;
      else
         return (new Ast_Num'(Ast_Num_Sign => False,
                              Ast_Num_Val  => Natural(I))) ;
      end if ;
   end Mk_Ast_Num ;

end Ast.Expr.Num ;
