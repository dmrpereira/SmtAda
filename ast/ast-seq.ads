package Ast.Seq is
   
   type Ast_Sequence ;
   
   type Ast_Seq is access all Ast_Sequence ;
   
   type Ast_Sequence is new Ast_Abstract with
      record
	 Seq_Val : Ast_Node ;
	 Seq_Next : Ast_Seq ;
      end record ;
   
   function Build_Singleton( N : in Ast_Node ) return Ast_Node ;
   function Add_To_Seq( N : in Ast_Node ; S : in Ast_Seq ) return Ast_Node ;
   
   
   
end Ast.Seq ;
