package body Ast.Formulas is
   
   function Build_Ast_Formula_Var( N : in String ) return Ast_Node is
   begin
      return (new Ast_Formula_Var'(Formula_Var_Name => To_Unbounded_String(N))) ;
   end Build_Ast_Formula_Var ;
   
   
   function Build_Ast_Formula_Const( B : in Boolean ) return Ast_Node is
   begin
      return (new Ast_Formula_Const'( Formula_Const => B )) ;
   end Build_Ast_Formula_Const ;
   
   
   function Build_Ast_Formula_Neg( F : in Ast_Node ) return Ast_Node is
   begin
      return (new Ast_Formula_Neg'( Formula_Neg_Arg => F )) ;
   end Build_Ast_Formula_Neg ;
   
   
   function Build_Ast_Formula_Binary( K : in Formula_Kind ; L, R : in Ast_Node ) return Ast_Node is
   begin
      return (new Ast_Formula_Binary'( Formula_Binary_Kind => K, 
				       Formula_Binary_Left => L,
				       Formula_Binary_Right => R )) ;
   end Build_Ast_Formula_Binary ;
   
   
   function Build_Ast_Formula_Exprs( K : in Expr_Rel_Kind ; L, R : in Ast_Node ) return Ast_Node is
   begin
      return (new Ast_Formula_Exprs'( Formula_Expr_Op => K ,
				      Formula_Expr_Left => L,
				      Formula_Expr_Right => R )) ;
   end Build_Ast_Formula_Exprs ;
   
   
   function Build_Ast_Formula_Seq_Single( N : in Ast_Node ) return Ast_Node is
   begin
      return (new Ast_Formula_Seq'( Ast_Formula_Node => N , Ast_Formula_Next => null )) ;
   end Build_Ast_Formula_Seq_Single ;
   
   function Build_Ast_Formula_Seq_Add( N : in Ast_Node ; L : in Ast_Node ) return Ast_Node is
   begin
      return (new Ast_Formula_Seq'( Ast_Formula_Node => N ,
				    Ast_Formula_Next => Ast_Formula_Seq_Access(L))) ;
   end Build_Ast_Formula_Seq_Add ;
   
   
end Ast.Formulas ;
