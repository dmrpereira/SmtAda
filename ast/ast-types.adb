package body Ast.Types is
   
   procedure Pprint_Ast_Type_Case( T : in Ast_Type ) is
   begin
      case T.Tk is
	 when Kind_Int => Ada_Tio.Put("Integer") ;
	 when others => Ada_Tio.Put("Bool") ;
      end case ;
   end Pprint_Ast_Type_Case ;
   
end Ast.Types ;
