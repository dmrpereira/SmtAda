DIGIT [0-9]
HEXDIGIT ({DIGIT}|[a-fA-F])
ALPHA [a-zA-Z]
ESCAPE '\\'('\\'|'"')
SYM_CHAR [+-/*=%?!\.$_~&^<>@]
NUMERAL ('0'|([1-9][0-9]*))
LPAR "("
RPAR ")"

%%

"Bool"                { return SYM_BOOL ; }
"continued-execution" { return SYM_CONTINUED_EXECUTION ; }
"error"               { return SYM_ERROR ; }
"false"               { return SYM_FALSE ; }
"immediate-exit"      { return SYM_IMMEDIATE_EXIT ; }
"incomplete"          { return SYM_INCOMPLETE ; }
"logic"               { return SYM_LOGIC ; }
"memout"              { return SYM_MEMOUT ; }
"sat"                 { return SYM_SAT ; }
"success"             { return SYM_SUCCESS ; }
"theory"              { return SYM_THEORY ; }
"true"                { return SYM_TRUE ; }
"unknown"             { return SYM_UNKNOWN ; }
"unsat"               { return SYM_UNSAT ; }
"unsupported"         { return SYM_UNSUPPORTED ; }

-- Predefined Keywords
":all-statistics"            { return KEYWORD_ALL_STATISTICS ; }
":authors"                   { return KEYWORD_AUTHORS ; }
":axioms"                    { return KEYWORD_AXIOMS ; }
":chainable"                 { return KEYWORD_CHAINABLE ; }
":definition"                { return KEYWORD_DEFINITION ; }
":diagnostic-output-channel" { return KEYWORD_DIAGNOSTIC_OUTPUT_CHANNEL ; }
":error-behavior"            { return KEYWORD_ERROR_BEHAVIOR ; }
":expand-definitions"        { return KEYWORD_EXPAND_DEFINITIONS ; }
":extensions"                { return KEYWORD_EXTENSIONS ; }
":funs"                      { return KEYWORD_FUNS ; }
":funs-description"          { return KEYWORD_FUNS_DESCRIPTION ; }
":interactive-mode"          { return KEYWORD_INTERACTIVE_MODE ; }
":language"                  { return KEYWORD_LANGUAGE ; }
":left-assoc"                { return KEYWORD_LEFT_ASSOC ; }
":name"                      { return KEYWORD_NAME ; }
":named"                     { return KEYWORD_NAMED ; }
":notes"                     { return KEYWORD_NOTES ; }
":print-success"             { return KEYWORD_PRINT_SUCCESS ; }
":produce-assignments"       { return KEYWORD_PRODUCE_ASSIGNMENTS ; }
":produce-models"            { return KEYWORD_PRODUCE_MODELS ; }
":produce-proofs"            { return KEYWORD_PRODUCE_PROOFS ; }
":produce-unsat-cores"       { return KEYWORD_PRODUCE_UNSAT_CORES ; }
":random-seed"               { return KEYWORD_RANDOM_SEED ; }
":reason-unknown"            { return KEYWORD_REASON_UNKNOWN ; }
":regular-output-channel"    { return KEYWORD_REGULAR_OUTPUT_CHANNEL ; }
":right-assoc"               { return KEYWORD_RIGHT_ASSOC ; }
":sorts"                     { return KEYWORD_SORTS ; }
":sorts-description"         { return KEYWORD_SORTS_DESCRIPTION ; }
":status"                    { return KEYWORD_STATUS ; }
":theories"                  { return KEYWORD_THEORIES ; }
":values"                    { return KEYWORD_VALUES ; }
":verbosity"                 { return KEYWORD_VERBOSITY ; }
":version"                   { return KEYWORD_VERSION ; }

-- Predifined General Token
"!"       { return TOKEN_BANG ; }
"_"       { return TOKEN_UNDERSCORE ; }
"as"      { return TOKEN_AS ; }
"DECIMAL" { return TOKEN_DECIMAL ; }
"exists"  { return TOKEN_EXISTS ; }
"forall"  { return TOKEN_FORALL ; }
"let"     { return TOKEN_LET ; }
"NUMERAL" { return TOKEN_NUMERAL ; }
"par"     { return TOKEN_PAR ; }
"STRING"  { return TOKEN_STRING ; }

-- Predefined Command Token
"assert"         { return TOKEN_CMD_ASSERT ; }
"check-sat"      { return TOKEN_CMD_CHECK_SAT ; }
"declare-sort"   { return TOKEN_CMD_DECLARE_SORT ; }
"declare-fun"    { return TOKEN_CMD_DECLARE_FUN ; }
"define-sort"    { return TOKEN_CMD_DEFINE_SORT ; }
"define-fun"     { return TOKEN_CMD_DEFINE_FUN ; }
"exit"           { return TOKEN_CMD_EXIT ; }
"get-assertions" { return TOKEN_CMD_GET_ASSERTIONS ; }
"get-assignment" { return TOKEN_CMD_GET_ASSIGNMENT ; }
"get-info"       { return TOKEN_CMD_GET_INFO ; }
"get-option"     { return TOKEN_CMD_GET_OPTION ; }
"get-proof"      { return TOKEN_CMD_GET_PROOF ; }
"get-unsat-core" { return TOKEN_CMD_GET_UNSAT_CORE ; }
"get-value"      { return TOKEN_CMD_GET_VALUE ; }
"pop"            { return TOKEN_CMD_POP ; }
"push"           { return TOKEN_CMD_PUSH ; }
"set-logic"      { return TOKEN_CMD_SET_LOGIC ; }
"set-info"       { return TOKEN_CMD_SET_INFO ; }
"set-option"     { return TOKEN_CMD_SET_OPTION ; }

{LPAR} { return LP ; }
{RPAR} { return RP ; }

{DIGIT}\.[0]*{DIGIT} { return DEC_TOK ; }
{DIGIT}+ { return INT_TOK ; }

"#x"{HEXDIGIT}+                                   { return HEX_TOK ; }

"#b"[01]+                                         { return BINARY_TOK ; }

"\""(ESCAPE|[^\\\"]*)"\""                         { return STRING_TOK ; }

[\t\r\n\f ]+                                      { return WS ; }

({ALPHA}|{SYM_CHAR})({DIGIT}|{ALPHA}|{SYM_CHAR})* { return SIMPLE_SYM ; }

"|"[^|\\]*"|"                                     { return QUOTED_SYM ; }

";"[^\n\r]*                                       { null ; }

({ALPHA}|{DIGIT}|{SYM_CHAR})+                     { return KEYWORD_TOKEN ; }

%%

--  Added to the with list of SPEC
with Smt_Parser_Tokens ; use  Smt_Parser_Tokens;

package smt_lex is

  procedure ECHO_L; --local version_of define_string.
	
  function yylex return token;

end smt_lex ;

package body smt_lex is

  procedure ECHO_L is
  begin
    text_io.put(Yytext);
  end ECHO_L;

##

end smt_lex ;   

