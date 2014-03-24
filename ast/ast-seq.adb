package body Ast.Seq is
   
   function Build_Singleton( N : in Ast_Node ) return Ast_Node is
   begin
      return (new Ast_Sequence'( Seq_Val => N , Seq_Next => null )) ;
   end Build_Singleton ;
   
   function Add_To_Seq( N : in Ast_Node ; S : in Ast_Seq ) return Ast_Node is
   begin
      return (new Ast_Sequence'( Seq_Val => N , Seq_Next => S)) ;
   end Add_To_Seq ;
   
   
   
end Ast.Seq ;
