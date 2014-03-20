ID [a-zA-Z][_a-zA-Z0-9]*
NAT (0|([1-9][0-9]*))

%%
"variables" { return Variables_Kw ; }
"axioms"    { return Axioms_Kw ; }
"goal"      { return Goal_Kw ; }

"var"    { return Var_Kw ; }
"assume" { return Assume_Kw ; }
"sat"    { return Sat_Kw ; }

"int"  { return Int_Type_Kw ; }
"bool" { return Bool_Type_Kw ; }

"true"  { return True_Kw ; }
"false" { return False_Kw ; }

"forall" { return Forall_Kw ; }
"exists" { return Exists_Kw ; }

"mod" { return Mod_Sy ; }

{ID}  { return Id_Val ; }
{NAT} { return Nat_Val ; }

"{" { return LB ; } 
"}" { return RB ; } 
"(" { return LP ; }
")" { return RP ; }
":" { return Is_Type_Kw ; }
"," { return Comma_Sep_Kw ; }
";" { return End_Stmt_Kw ; }

"+" { return Plus_Sy ; }
"-" { return Sub_Sy ; }
"/" { return Div_Sy ; }


"=" { return Eq_Sy ; }
"<=" { return Le_Sy ; }
">=" { return Ge_Sy ; }
"<"  { return Lt_Sy ; }
">"  { return Gt_Sy ; }

"/\\" { return Land_Sy ; }
"\\/" { return Lor_Sy ; }
"=>" { return Limp_Sy ; }
"<=>" { return Lequiv_Sy ; }
"~" { return Lneg_Sy ; }



[ \n\t]+ { null ; }

. { put_line(yytext) ; text_io.put_line("?? end of file?????"); }

%%

with Parser_Tokens ;
use Parser_Tokens ;

package lexer is

	function Yylex return token;

end lexer ;

package body lexer is

##

end lexer ;
