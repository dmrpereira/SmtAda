--
-- Keywords
--
%token Variables_Kw
%token Axioms_Kw
%token Goal_Kw

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

{
  type yystype_enum is (None,Var_Node,Axiom_Node,Goal_Node)	;

  type yystype(Kind : yystype_enum := None) is null record ;
}

%%

-----------------
-- Entry point --
-----------------
program : var_section axioms ;

---------------------------------------
-- Grammar for variable declarations --
---------------------------------------
var_section : Variables_Kw LB var_decl_list RB { put_line("Processing Variables...") ; } ; 

var_decl_list : var_decl_list_aux
	|
	;

var_decl_list_aux : var_decl 
	| var_decl_list_aux var_decl 
	;

var_decl : Var_Kw Id_Val Is_Type_Kw type_case End_Stmt_Kw
	{ 
	  put_line("var_decl") ; 
	};

-----------------------------------------
-- Grammar of (currently simple) types --
-----------------------------------------
type_case : Int_Type_Kw 
	| Bool_Type_Kw ;

------------------------------------
-- Grammar for axiom declarations --
------------------------------------
axioms : axioms_decl
	|
	;

axioms_decl : Axioms_Kw LB axioms_decl_list RB 
	{ put_line("Processing axioms...") ; };

axioms_decl_list : axioms_decl_list_aux
	|
	;

axioms_decl_list_aux : axiom_decl 
	| axioms_decl_list_aux axiom_decl ;

axiom_decl : Assume_Kw formula End_Stmt_Kw { put_line("axiom_decl") ; };

-------------------------
-- Grammar of formulae --
-------------------------
formula : term_formula
| LNeg_Sy formula %prec Dummy
| quantified formula %prec Dummy
| formula and_or term_formula
; 

term_formula : factor_formula
| term_formula imp_eq factor_formula
;

factor_formula : True_Kw
| False_Kw
| expr_rel 
| LP formula RP
;

quantified : quant_sy Id_Val Is_Type_Kw type_case Comma_Sep_Kw { put_line(yytext) ; }
;

quant_sy : Forall_Kw
| Exists_Kw 
;

imp_eq : Limp_Sy | Lequiv_Sy ;

and_or : Land_Sy | Lor_Sy ;

logic_const : True_Kw | False_Kw ;

expr_rel : expr lexpr expr ;

lexpr : Eq_Sy | Le_Sy | Ge_Sy | Lt_Sy | Gt_Sy ;

----------------------------
-- Grammar of expressions --
----------------------------
expr : term_expr 
	| expr add_sub term_expr 
	; 

term_expr : factor_expr 
	| term_expr mul_div_mod factor_expr
	;

factor_expr : Id_Val
| expr_val 
| Sub_Sy factor_expr %prec Dummy 
| LP expr RP
;

add_sub : Plus_Sy
	| Sub_Sy 
	;

mul_div_mod : Mul_Sy
	| Div_Sy
	| Mod_Sy
	;

expr_val : Nat_Val 
	;



%%
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
