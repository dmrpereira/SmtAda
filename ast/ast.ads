package Ast is
   
   type Abs_Ast is abstract tagged null record ;
   
   type Ast_Node is access all Abs_Ast'Class ;
   
   
      
end Ast ;
