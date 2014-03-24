package Ast.Types is
   
   type Type_Kind is (Kind_Int,Kind_Bool) ;
   
   type Ast_Type(Tk : Type_Kind) is new Ast_Abstract with null record ;
   
   type Ast_Type_Node is access all Ast_Type ;
   
end Ast.Types ;
