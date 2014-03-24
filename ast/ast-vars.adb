package body Ast.Vars is 
   
   function Mk_Ast_Var(N : in String ; T : in String) return Ast_Node is
      My_T : Ast_Type_Node ;
      My_N : Unbounded_String := To_Unbounded_String(N) ;
   begin
      if T = "integer" then 
	 My_T := new Ast_Type'( Tk => Kind_Int) ;
      elsif T = "bool" then 
	 My_T := new Ast_Type'( Tk => Kind_Bool ) ;
      else
	 My_T := null ;
      end if ;
      return (new Ast_Var'(Ast_Var_Name => My_N , Ast_Var_Type => My_T));
   end Mk_Ast_Var ;
   
   procedure Pprint_Ast_Var_Case( V : in Ast_Var ) is
   begin
      Ada_Tio.Put("Var_Decl(" & To_String(V.Ast_Var_Name) & ":") ;
      Pprint_Ast_Type_Case(V.Ast_Var_Type.all) ;
      Ada_Tio.Put(")") ;
      Ada_Tio.New_Line ;
   end Pprint_Ast_Var_Case ;
   
   
end Ast.Vars ;
