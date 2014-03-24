--
-- Keywords
--
%token Variables_Kw
%token Axioms_Kw
%token Goals_Kw

%token Var_Kw
%token Assume_Kw
%token Sat_Kw

--
-- Identifiers
--
%token Id_Val
%token Nat_Val 
%token True_Kw
%token False_Kw

--
-- Types
--
%token Int_Type_Kw Bool_Type_Kw 

--
-- Auxiliary characters
--
%token LB RB LP RP
%token Is_Type_Kw Comma_Sep_Kw End_Stmt_Kw
%token Plus_Sy Sub_Sy Mul_Sy Div_Sy Mod_Sy
%token Eq_Sy Le_Sy Ge_Sy Lt_Sy Gt_Sy 

%token Land_Sy Lor_Sy Limp_Sy Lequiv_Sy Lneg_Sy
%token Forall_Kw Exists_Kw

%token Dummy

%left Plus_Sy
%left Sub_Sy
%left Mul_Sy
%nonassoc Mod_Sy
%left Land_Sy Lor_Sy Limp_Sy
%nonassoc Lequiv_Sy
%right Dummy 


----------------------------------------
-- Program entry point in the grammar --
----------------------------------------
%start program

%with Ada.Strings.Unbounded ;
%use  Ada.Strings.Unbounded ;

%with Ast ; 
%with Ast.Types ;
%with Ast.Vars ;
%with Ast.Seq ;
%with Ast.Expr ;
%with Ast.Formulas ;
%use Ast ; 
%use Ast.Types ;
%use Ast.Vars ;
%use Ast.Seq ;
%use Ast.Expr ;
%use Ast.Formulas ;
{

--  type yystype_enum is (T_Node,Var_Node,Type_Node) ;
 subtype yystype is Ast_Node ; -- (Kind : yystype_enum := T_Node) is 

 type Context is
  record
    Vars_Context : Ast_Node ;
    Assumptions_Context : Ast_Node ;
    Goals_Context : Ast_Node ;
  end record ;
   
 Current_Context : Context ;

}

%%

-----------------
-- Entry point --
-----------------
program : var_section axioms goals { Current_Context := ($1,$2,$3) ; } ;

---------------------------------------
-- Grammar for variable declarations --
---------------------------------------
var_section : Variables_Kw LB var_decl_list RB { $$ := $3 ; } ; 

var_decl_list : var_decl_list_aux { $$ := $1 ; }
| { $$ := null ; }
;

var_decl_list_aux : var_decl { $$ := Build_Singleton($1) ; }
| var_decl_list_aux var_decl { $$ := Add_To_Seq($2,Ast_Seq($1)) ; } 
;

var_decl : Var_Kw id Is_Type_Kw type_case End_Stmt_Kw
{ 
  put_line("var_declaration " & To_String(Ast_Var($2.all).Ast_Var_Name) ) ;
 $$ := new Ast_Var'( Ast_Var_Name => Ast_Var($2.all).Ast_Var_Name , 
                     Ast_Var_Type => Ast_Type_Node($4) ) ;
}
;

id : Id_Val 
{ 
 $$ := new Ast_Var'( Ast_Var_Name => To_Unbounded_String(yytext), Ast_Var_Type => null ) ; 
}
;

-----------------------------------------
-- Grammar of (currently simple) types --
-----------------------------------------
type_case : Int_Type_Kw  
{ 
 $$ := new Ast_Type'( Tk => Kind_Int ) ; 
}
| Bool_Type_Kw 
{ 
 $$ := new Ast_Type'( Tk => Kind_Bool ) ; 
}
;

------------------------------------
-- Grammar for axiom declarations --
------------------------------------
axioms : axioms_decl { $$ := $1 ; }
| { $$ := null ; }
;

axioms_decl : Axioms_Kw LB axioms_decl_list RB { $$ := $1 ; } ;

axioms_decl_list : axioms_decl_list_aux { $$ := $1 ; }
| { $$ := null ; }
;

axioms_decl_list_aux : axiom_decl { $$ := Build_Ast_Formula_Seq_Single($1) ; }
| axioms_decl_list_aux axiom_decl { $$ := Build_Ast_Formula_Seq_Add($1,$2) ; }
;

axiom_decl : Assume_Kw formula End_Stmt_Kw { $$ := $2 ; };

------------------------------------
-- Grammar for axiom goals --
------------------------------------
goals : goals_decl { $$ := $1 ; }
| { $$ := null ; }
;

goals_decl : Goals_Kw LB goals_decl_list RB { $$ := $1 ; } ;

goals_decl_list : goals_decl_list_aux { $$ := $1 ; }
| { $$ := null ; }
;

goals_decl_list_aux : goal_decl { $$ := Build_Ast_Formula_Seq_Single($1) ; }
| goals_decl_list_aux goal_decl { $$ := Build_Ast_Formula_Seq_Add($1,$2) ; }
;

goal_decl : Sat_Kw formula End_Stmt_Kw { $$ := $2 ; };

-------------------------
-- Grammar of formulae --
-------------------------
formula : term_formula
| LNeg_Sy formula %prec Dummy { $$ := Build_Ast_Formula_Neg($1) ; }
| Forall_Kw Id_Val Is_Type_Kw type_case Comma_Sep_Kw formula %prec Dummy
| Exists_Kw Id_Val Is_Type_Kw type_case Comma_Sep_Kw formula %prec Dummy
| formula Land_Sy term_formula { $$ := Build_Ast_Formula_Binary(Formula_And,$1,$2) ; }
| formula Lor_Sy term_formula { $$ := Build_Ast_Formula_Binary(Formula_Or,$1,$2) ; }
; 

term_formula : factor_formula { $$ := Build_Ast_Formula_seq_Single($1) ; }
| term_formula Limp_Sy factor_formula { $$ := Build_Ast_Formula_Binary(Formula_Imp,$1,$2) ; }
| term_formula Lequiv_Sy factor_formula { $$ := Build_Ast_Formula_Binary(Formula_Equiv,$1,$2) ; }
;

factor_formula : True_Kw { $$ := Build_Ast_Formula_Const(True) ; }
| False_Kw { $$ := Build_Ast_Formula_Const(False) ; }
| Id_Val { $$ := Build_Ast_Formula_Var(yytext) ; }
| expr_rel { $$ := $1 ; }
| LP formula RP { $$ := $1 ; }
;

expr_rel : expr Eq_Sy expr { $$ := Build_Ast_Formula_Exprs(Expr_Rel_Eq,$1,$2) ; } 
| expr Le_Sy expr { $$ := Build_Ast_Formula_Exprs(Expr_Rel_Le,$1,$2) ; }
| expr Ge_Sy expr { $$ := Build_Ast_Formula_Exprs(Expr_Rel_Ge,$1,$2) ; }
| expr Lt_Sy expr { $$ := Build_Ast_Formula_Exprs(Expr_Rel_Lt,$1,$2) ; }
| expr Gt_Sy expr { $$ := Build_Ast_Formula_Exprs(Expr_Rel_Gt,$1,$2) ; }
;

----------------------------
-- Grammar of expressions --
----------------------------
expr : term_expr { $$ := $1 ; }
| expr Plus_Sy term_expr { $$ := Build_Ast_Expr_Binary(Bin_Plus,$1,$2) ; }
| expr Sub_Sy term_expr {  $$ := Build_Ast_Expr_Binary(Bin_Sub,$1,$2) ; }
; 

term_expr : factor_expr { $$ := $1 ; }
| term_expr Mul_Sy factor_expr { $$ := Build_Ast_Expr_Binary(Bin_Mult,$1,$2) ; }
| term_expr Div_Sy factor_expr { $$ := Build_Ast_Expr_Binary(Bin_Div,$1,$2) ; }
| term_expr Mod_Sy factor_expr { $$ := Build_Ast_Expr_Binary(Bin_Mod,$1,$2) ; }
;

factor_expr : id { $$ := $1 ; }
| expr_val { $$ := $1 ; }
| Sub_Sy factor_expr %prec Dummy { $$ := Build_Ast_Expr_Unary($1) ; }
| LP expr RP { $$ := $1 ; } 
;

expr_val : Nat_Val { $$ := Build_Ast_Expr_Num(yytext) ; } ; 

%%

with Ada.Strings.Unbounded ; use Ada.Strings.Unbounded ;

with Ast.Vars, Ast.Types, Ast.Expr, Ast.Seq, Ast.Formulas ; 
use Ast, Ast.Vars, Ast.Types, Ast.Expr, Ast.Seq, Ast.Formulas ;

with Text_IO ; use Text_IO ;
with Lexer_IO ; use Lexer_IO ;
with Lexer_Dfa ; use Lexer_Dfa ;
with Lexer ; use Lexer ;
with Parser_Tokens, Parser_Shift_Reduce, Parser_Goto ;


package My_Parser is
	procedure YYParse;
end My_Parser ;

package body My_Parser is

	procedure YYError(text : in String) is
	begin
	   put_line(text) ;
	end YYError ;

##

end My_Parser ;
