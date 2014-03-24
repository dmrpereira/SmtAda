with Ada.Strings.Unbounded ; use Ada.Strings.Unbounded ;

with Ast.Vars ; use Ast.Vars ;
with Ast.Expr ; use Ast.Expr ;

package Ast.Formulas is
   
   type Ast_Formula is abstract new Ast_Abstract with null record ; 
   
   type Ast_Formula_Const is new Ast_Formula with
     record
	Formula_Const : Boolean ;
     end record ;
   
   function Build_Ast_Formula_Const( B : in Boolean ) return Ast_Node ;

   
   type Ast_Formula_Var is new Ast_Formula with
     record 
	Formula_Var_Name : Unbounded_String ;
     end record ;
   
   function Build_Ast_Formula_Var( N : in String ) return Ast_Node ;
   
   
   type Ast_Formula_Neg is new Ast_Formula with
      record
	 Formula_Neg_Arg : Ast_Node ;
      end record ;
   
   function Build_Ast_Formula_Neg( F : in Ast_Node ) return Ast_Node ;
   
   --
   -- Binary formula constructor
   --
   type Formula_Kind is ( Formula_And,
			  Formula_Or,
			  Formula_Imp,
			  Formula_Equiv ) ;
   
   type Ast_Formula_Binary is new Ast_Formula with
      record
	 Formula_Binary_Kind  : Formula_Kind ;
	 Formula_Binary_Left  : Ast_Node ;
	 Formula_Binary_Right : Ast_Node ;
      end record ;
   
   function Build_Ast_Formula_Binary( K : in Formula_Kind ; L, R : in Ast_Node ) return Ast_Node ;
   
   -- 
   -- Quantified first order formulas
   --
   type Quantifier_Kind is ( Fol_Exists , Fol_Forall ) ; 
      
   type Ast_Formula_Quantified is new Ast_Formula with
      record
	 Quantified_Val : Quantifier_Kind ;
	 Quantified_Formula : Ast_Node ;
      end record ;
   
   type Expr_Rel_Kind is ( Expr_Rel_Eq,
			   Expr_Rel_Lt,
			   Expr_Rel_Le,
			   Expr_Rel_Gt, 
			   Expr_Rel_Ge ) ;
   
   --
   -- Logical comparisons between expressions
   --
   type Ast_Formula_Exprs is new Ast_Formula with
      record 
	 Formula_Expr_Op : Expr_Rel_Kind ;
	 Formula_Expr_Left : Ast_Node ;
	 Formula_Expr_Right : Ast_Node ;
      end record ;

   function Build_Ast_Formula_Exprs( K : in Expr_Rel_Kind ; L, R : in Ast_Node ) return Ast_Node ;

   --
   -- Sequence of formulas
   --
   type Ast_Formula_Seq ;
   
   type Ast_Formula_Seq_Access is access all Ast_Formula_Seq ;
   
   type Ast_Formula_Seq is new Ast_Formula with
      record
	 Ast_Formula_Node : Ast_Node ;
	 Ast_Formula_Next : Ast_Formula_Seq_Access ;
      end record ;
   
   function Build_Ast_Formula_Seq_Single( N : in Ast_Node ) return Ast_Node ;
   function Build_Ast_Formula_Seq_Add( N : in Ast_Node ; L : in Ast_Node ) return Ast_Node ;
   
end Ast.Formulas ;
