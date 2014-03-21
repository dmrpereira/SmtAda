package body Ast.Vars is 
   
   function Mk_Ast_Var(N : in Unbounded_String ; T : in Type_Case) return Ast_Node is
   begin
      return (new Ast_Var'(Ast_Var_Name => N , Ast_Var_Type => T));
   end Mk_Ast_Var ;
   
   
end Ast.Vars ;
