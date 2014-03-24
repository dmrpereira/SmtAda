package Ast is
   
   type Ast_Abstract is abstract tagged null record ;
   
   type Ast_Node is access all Ast_Abstract'Class ;
   
   type Ast_Sequence ;
   
   type Ast_Seq is access all Ast_Sequence ;
   
   type Ast_Sequence is new Ast_Abstract with
      record
	 Seq_Val : Ast_Node ;
	 Seq_Next : Ast_Seq ;
      end record ;
   
   function Build_Singleton( N : in Ast_Node ) return Ast_Node ;
   function Add_To_Seq( N : in Ast_Node ; S : in Ast_Seq ) return Ast_Node ;
            
end Ast ;

--  %token PREDICATE FUNCTION CONSTANT VARIABLE
--  %token IMPLIES AND OR IFF THERE_EXISTS FORALL
--  %left '='
--  %left VARIABLE
--  %left IMPLIES
--  %left IFF
--  %left AND
--  %left OR
--  %left NOT
--  %%

--  sentence
--          : atomic_sentence
--          | sentence IMPLIES sentence
--          | sentence IFF sentence
--          | sentence AND sentence
--          | sentence OR sentence
--          | quantifier VARIABLE sentence
--          | '~' sentence %prec NOT
--          | '(' sentence ')'
--          ;
--  atomic_sentence
--          : PREDICATE '(' term_list ')'
--          | term '=' term
--          ;
--  term
--          : FUNCTION '(' term_list ')'
--          | CONSTANT
--          | VARIABLE
--          ;
--  term_list
--          : term_list term
--          | term
--          ;
--  quantifier
--          : THERE_EXISTS
--          | FORALL
--      ;
    
