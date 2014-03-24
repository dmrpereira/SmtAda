with Ada.Text_Io ;

package Ast.Types is
   
   package Ada_Tio renames Ada.Text_Io ;
   
   type Type_Kind is (Kind_Int,Kind_Bool) ;
   
   type Ast_Type(Tk : Type_Kind) is new Ast_Abstract with null record ;
   
   type Ast_Type_Node is access all Ast_Type ;
   
   procedure Pprint_Ast_Type_Case( T : in Ast_Type ) ;
   
end Ast.Types ;
