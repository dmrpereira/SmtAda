-- Predefined Symbols
%token SYM_BOOL               
%token SYM_CONTINUED_EXECUTION 
%token SYM_ERROR               
%token SYM_FALSE               
%token SYM_IMMEDIATE_EXIT      
%token SYM_INCOMPLETE          
%token SYM_LOGIC               
%token SYM_MEMOUT              
%token SYM_SAT                 
%token SYM_SUCCESS             
%token SYM_THEORY              
%token SYM_TRUE                
%token SYM_UNKNOWN             
%token SYM_UNSAT               
%token SYM_UNSUPPORTED         

-- Predefined Keywords
%token KEYWORD_ALL_STATISTICS 
%token KEYWORD_AUTHORS
%token KEYWORD_AXIOMS
%token KEYWORD_CHAINABLE
%token KEYWORD_DEFINITION
%token KEYWORD_DIAGNOSTIC_OUTPUT_CHANNEL
%token KEYWORD_ERROR_BEHAVIOR
%token KEYWORD_EXPAND_DEFINITIONS
%token KEYWORD_EXTENSIONS
%token KEYWORD_FUNS
%token KEYWORD_FUNS_DESCRIPTION
%token KEYWORD_INTERACTIVE_MODE
%token KEYWORD_LANGUAGE
%token KEYWORD_LEFT_ASSOC
%token KEYWORD_NAME
%token KEYWORD_NAMED
%token KEYWORD_NOTES
%token KEYWORD_PRINT_SUCCESS
%token KEYWORD_PRODUCE_ASSIGNMENTS
%token KEYWORD_PRODUCE_MODELS
%token KEYWORD_PRODUCE_PROOFS
%token KEYWORD_PRODUCE_UNSAT_CORES
%token KEYWORD_RANDOM_SEED
%token KEYWORD_REASON_UNKNOWN
%token KEYWORD_REGULAR_OUTPUT_CHANNEL
%token KEYWORD_RIGHT_ASSOC
%token KEYWORD_SORTS
%token KEYWORD_SORTS_DESCRIPTION
%token KEYWORD_STATUS
%token KEYWORD_THEORIES
%token KEYWORD_VALUES
%token KEYWORD_VERBOSITY
%token KEYWORD_VERSION

-- Predifined General Token
%token TOKEN_BANG       
%token TOKEN_UNDERSCORE 
%token TOKEN_AS         
%token TOKEN_DECIMAL    
%token TOKEN_EXISTS     
%token TOKEN_FORALL     
%token TOKEN_LET        
%token TOKEN_NUMERAL    
%token TOKEN_PAR        
%token TOKEN_STRING     

-- Predefined Command Token
%token TOKEN_CMD_ASSERT          
%token TOKEN_CMD_CHECK_SAT       
%token TOKEN_CMD_DECLARE_SORT    
%token TOKEN_CMD_DECLARE_FUN     
%token TOKEN_CMD_DEFINE_SORT     
%token TOKEN_CMD_DEFINE_FUN      
%token TOKEN_CMD_EXIT            
%token TOKEN_CMD_GET_ASSERTIONS  
%token TOKEN_CMD_GET_ASSIGNMENT  
%token TOKEN_CMD_GET_INFO        
%token TOKEN_CMD_GET_OPTION      
%token TOKEN_CMD_GET_PROOF       
%token TOKEN_CMD_GET_UNSAT_CORE  
%token TOKEN_CMD_GET_VALUE       
%token TOKEN_CMD_POP             
%token TOKEN_CMD_PUSH            
%token TOKEN_CMD_SET_LOGIC       
%token TOKEN_CMD_SET_INFO        
%token TOKEN_CMD_SET_OPTION 

%token LP
%token RP

%token DEC_TOK
%token INT_TOK 
%token NUMERAL
%token HEX_TOK
%token BINARY_TOK
%token WS
%token SIMPLE_SYM
%token QUOTED_SYM
%token KEYWORD_TOKEN 
%token STRING_TOK   


%start script

{
  subtype yystype is Natural ;
  
}

%%

numeral_seq : NUMERAL
| numeral_seq NUMERAL
;

symbol : SIMPLE_SYM
| QUOTED_SYM
| SYM_BOOL
| SYM_CONTINUED_EXECUTION
| SYM_ERROR
| SYM_FALSE
| SYM_IMMEDIATE_EXIT
| SYM_INCOMPLETE
| SYM_LOGIC
| SYM_MEMOUT
| SYM_SAT
| SYM_SUCCESS
| SYM_THEORY
| SYM_TRUE
| SYM_UNKNOWN
| SYM_UNSAT
| SYM_UNSUPPORTED
;

symbol_opt :
| symbol ;

symbol_seq : symbol
| symbol_seq symbol
;

symbol_star : 
| symbol_star symbol
;

keyword : KEYWORD_TOKEN
| KEYWORD_ALL_STATISTICS
| KEYWORD_AUTHORS
| KEYWORD_AXIOMS
| KEYWORD_CHAINABLE
| KEYWORD_DEFINITION
| KEYWORD_DIAGNOSTIC_OUTPUT_CHANNEL
| KEYWORD_ERROR_BEHAVIOR
| KEYWORD_EXPAND_DEFINITIONS
| KEYWORD_EXTENSIONS
| KEYWORD_FUNS
| KEYWORD_FUNS_DESCRIPTION
| KEYWORD_INTERACTIVE_MODE
| KEYWORD_LANGUAGE
| KEYWORD_LEFT_ASSOC
| KEYWORD_NAME
| KEYWORD_NAMED
| KEYWORD_NOTES
| KEYWORD_PRINT_SUCCESS
| KEYWORD_PRODUCE_ASSIGNMENTS
| KEYWORD_PRODUCE_MODELS
| KEYWORD_PRODUCE_PROOFS
| KEYWORD_PRODUCE_UNSAT_CORES
| KEYWORD_RANDOM_SEED
| KEYWORD_REASON_UNKNOWN
| KEYWORD_REGULAR_OUTPUT_CHANNEL
| KEYWORD_RIGHT_ASSOC
| KEYWORD_SORTS
| KEYWORD_SORTS_DESCRIPTION
| KEYWORD_STATUS
| KEYWORD_THEORIES
| KEYWORD_VALUES
| KEYWORD_VERBOSITY
| KEYWORD_VERSION
;

spec_constant : NUMERAL 
| DEC_TOK 
| HEX_TOK 
| BINARY_TOK 
| STRING_TOK
;

s_expr : spec_constant 
| symbol 
| keyword 
| LP s_expr_seq RP
;

s_expr_seq : 
| s_expr_seq s_expr
;

identifier : symbol 
| LP TOKEN_UNDERSCORE symbol numeral_seq RP
;

sort : identifier 
| LP identifier sort_seq RP
;

sort_seq : sort
| sort_seq sort 
;

sort_star : 
| sort_star sort 
;

--attribute_value : symbol 
--| spec_constant 
--| LP s_expr_seq RP
--;

attribute : keyword
| keyword SIMPLE_SYM
| keyword INT_TOK
| keyword DEC_TOK
| keyword HEX_TOK
| keyword BINARY_TOK
| keyword STRING_TOK
| keyword LP term_seq RP
;

attribute_seq : attribute
| attribute_seq attribute ;


qual_identifier : identifier 
| LP TOKEN_AS identifier sort RP
;

var_binding : LP symbol term RP
;

var_binding_seq : var_binding
| var_binding_seq var_binding
;

sorted_var  : LP symbol sort RP
;

sorted_var_star :
| sorted_var_star sorted_var
;

term : spec_constant
| qual_identifier
| LP TOKEN_BANG term attribute_seq RP 
| LP TOKEN_LET LP var_binding_seq RP term RP
| LP quantifiers LP sorted_var_seq RP term RP
| LP qual_identifier term_seq RP
;

--term:
--LPAREN_TOK identifier terms RPAREN_TOK
--| LPAREN_TOK LET_TOK LPAREN_TOK bindings RPAREN_TOK term RPAREN_TOK
--| LPAREN_TOK quantifier LPAREN_TOK sorted_vars RPAREN_TOK term RPAREN_TOK
--| LPAREN_TOK EXCLAMATION_TOK term attributes RPAREN_TOK
--| identifier
--| DECIMAL_TOK
--| INTEGER_TOK
--| HEX_TOK
--| BINARY_TOK
--;

quantifiers : TOKEN_FORALL
| TOKEN_EXISTS
;


attribute_seq_pos : attribute 
| attribute_seq_pos attribute
;

sorted_var_seq : sorted_var
| sorted_var_seq sorted_var
;

term_seq : term
| term_seq term 
;

sort_symbol_decl : LP identifier NUMERAL attribute_seq RP 
;

sort_symbol_decl_seq : sort_symbol_decl
| sort_symbol_decl_seq sort_symbol_decl
;

meta_spec_constant : TOKEN_NUMERAL 
| TOKEN_DECIMAL 
| TOKEN_STRING
;


fun_symbol_decl : LP spec_constant sort attribute_seq RP
| LP meta_spec_constant sort attribute_seq RP
| LP identifier sort_seq attribute_seq RP
;

par_fun_symbol_decl : 
fun_symbol_decl
| LP TOKEN_PAR LP symbol_seq RP LP identifier sort_seq attribute_seq RP RP
;

par_fun_symbol_decl_seq : par_fun_symbol_decl
| par_fun_symbol_decl_seq par_fun_symbol_decl
;

theory_decl : LP SYM_THEORY symbol_opt theory_attribute_seq RP;

theory_attribute
    : KEYWORD_SORTS LP sort_symbol_decl_seq RP
    | KEYWORD_FUNS LP par_fun_symbol_decl_seq RP
    | KEYWORD_SORTS_DESCRIPTION STRING_TOK
    | KEYWORD_FUNS_DESCRIPTION STRING_TOK
    | KEYWORD_DEFINITION STRING_TOK
    | KEYWORD_VALUES STRING_TOK
    | KEYWORD_NOTES STRING_TOK
    | attribute
    ;

theory_attribute_seq : theory_attribute
| theory_attribute_seq theory_attribute
;

logic_attribute : KEYWORD_THEORIES LP symbol_seq RP
| KEYWORD_LANGUAGE STRING_TOK
| KEYWORD_EXTENSIONS STRING_TOK
| KEYWORD_VALUES STRING_TOK
| KEYWORD_NOTES STRING_TOK
| attribute
;

logic_attribute_seq : logic_attribute 
| logic_attribute_seq logic_attribute 
;

logic   : LP SYM_LOGIC symbol logic_attribute_seq RP;

b_value : SYM_TRUE 
| SYM_FALSE
;

option :  attribute
| KEYWORD_PRINT_SUCCESS b_value
| KEYWORD_EXPAND_DEFINITIONS b_value
| KEYWORD_INTERACTIVE_MODE b_value
| KEYWORD_PRODUCE_PROOFS b_value
| KEYWORD_PRODUCE_UNSAT_CORES b_value
| KEYWORD_PRODUCE_MODELS b_value
| KEYWORD_PRODUCE_ASSIGNMENTS b_value
| KEYWORD_REGULAR_OUTPUT_CHANNEL STRING_TOK
| KEYWORD_DIAGNOSTIC_OUTPUT_CHANNEL STRING_TOK
| KEYWORD_RANDOM_SEED NUMERAL
| KEYWORD_VERBOSITY NUMERAL
;

info_flag :  keyword
| KEYWORD_ERROR_BEHAVIOR
| KEYWORD_NAME
| KEYWORD_AUTHORS
| KEYWORD_VERSION
| KEYWORD_STATUS
| KEYWORD_REASON_UNKNOWN
| KEYWORD_ALL_STATISTICS
;

command : LP TOKEN_CMD_SET_LOGIC symbol RP
| LP TOKEN_CMD_SET_INFO attribute RP
| LP TOKEN_CMD_DECLARE_SORT symbol NUMERAL RP
| LP TOKEN_CMD_DECLARE_FUN symbol LP sort_star RP sort RP
| LP TOKEN_CMD_ASSERT term RP
| LP TOKEN_CMD_CHECK_SAT RP
| LP TOKEN_CMD_PUSH NUMERAL RP
| LP TOKEN_CMD_POP NUMERAL RP
| LP TOKEN_CMD_GET_PROOF RP
| LP TOKEN_CMD_GET_ASSIGNMENT RP
| LP TOKEN_CMD_GET_VALUE LP term_seq RP RP
| LP TOKEN_CMD_EXIT RP 
;

command_seq : command
| command_seq command
;

script : command_seq ;

gen_response : SYM_UNSUPPORTED 
| SYM_SUCCESS 
| LP SYM_ERROR STRING_TOK RP
;

error_behavior : SYM_IMMEDIATE_EXIT 
| SYM_CONTINUED_EXECUTION
;

reason_unknown : SYM_MEMOUT 
| SYM_INCOMPLETE
;

status : SYM_SAT 
| SYM_UNSAT 
| SYM_UNKNOWN
;

info_response : KEYWORD_ERROR_BEHAVIOR error_behavior
| KEYWORD_NAME STRING_TOK
| KEYWORD_AUTHORS STRING_TOK
| KEYWORD_VERSION STRING_TOK
| KEYWORD_REASON_UNKNOWN reason_unknown
| attribute
;

info_response_seq : info_response
| info_response_seq info_response
;

get_info_response : LP info_response_seq RP ;

check_sat_response : status;

get_assertions_response : LP term_seq RP;

proof : s_expr ;

get_proof_response : proof ;

get_unsat_core_response : LP symbol_seq RP ;

valuation_pair : LP term term RP;

valuation_pair_seq : valuation_pair
| valuation_pair_seq valuation_pair
;

get_value_response : LP valuation_pair_seq RP;

t_valuation_pair        : LP symbol b_value RP;

t_valuation_pair_star : t_valuation_pair_star t_valuation_pair 
|
;

get_assignment_response : LP t_valuation_pair_star RP;

get_option_response     : attribute ;




%%

with Text_Io ; use Text_Io ; 

with Smt_Lex, Smt_Lex_Io, Smt_Lex_Dfa ;
with Smt_Parser_Goto, Smt_Parser_Shift_Reduce, Smt_Parser_Tokens ;

use Smt_Lex, Smt_Lex_Io, Smt_Lex_Dfa ;
use Smt_Parser_Goto, Smt_Parser_Shift_Reduce, Smt_Parser_Tokens ;

package Smt_Parser_Interface is
  procedure Yyparse ;
end Smt_Parser_Interface ;


package body Smt_Parser_Interface is

  procedure YYError(text : in String) is
  begin
    put_line(text) ;
  end YYError ;

##
end Smt_Parser_Interface ;  


--| LP TOKEN_CMD_SET_OPTION option RP
--| LP TOKEN_CMD_DEFINE_SORT symbol LP symbol_star RP sort RP
--| LP TOKEN_CMD_DEFINE_FUN symbol LP sorted_var_star RP sort term  RP
--| LP TOKEN_CMD_GET_ASSERTIONS RP
--| LP TOKEN_CMD_GET_UNSAT_CORE RP
--| LP TOKEN_CMD_GET_OPTION keyword RP
-- | LP TOKEN_CMD_GET_INFO info_flag RP
--| LP TOKEN_CMD_EXIT RP
--;

--command_aux:  SET_LOGIC_TOK SYM_TOK
--| SET_INFO_TOK KEYWORD_TOK sexpr
--| DECLARE_SORT_TOK SYM_TOK INTEGER_TOK
--| DECLARE_FUN_TOK SYM_TOK LPAREN_TOK sort_symbols RPAREN_TOK sort_symbol
--| ASSERT_TOK term
--| CHECKSAT_TOK
--| PUSH_TOK INTEGER_TOK
--| POP_TOK INTEGER_TOK
--| GET_PROOF_TOK
--| GET_ASSIGNMENT_TOK
--| GET_VALUE_TOK LPAREN_TOK terms RPAREN_TOK
--| GET_MODEL_TOK
--| EXIT_TOK
--;
