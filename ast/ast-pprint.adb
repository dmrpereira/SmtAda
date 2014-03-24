package body Ast.Pprint is
   
   procedure Pprint_Ast( T : in Ast_Node )  is null ;
   procedure Pprint_Ast_Var( T : in Ast_Node ) is null with
     Pre => (T.all'Tag = Ast_Var'Tag);
   procedure Pprint_Ast_Expr( T : in Ast_Node ) is null with
     Pre => (T.all'Tag = Ast_Expr'Tag);
   procedure Pprint_Ast_Formula( T : in Ast_Node ) is null with
     Pre => (T.all'Tag = Ast_Formula'Tag);
   procedure Pprint_Ast_Seq( T : in Ast_Node ) is null with
     Pre => (T.all'Tag = Ast_Seq'Tag) ;
   
   
   
   
end Ast.Pprint ;
