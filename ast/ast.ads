package Ast is
   
   type Ast_Abstract is abstract tagged null record ;
   
   type Ast_Node is access all Ast_Abstract'Class ;
   
            
end Ast ;
