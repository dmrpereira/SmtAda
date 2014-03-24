ID [a-zA-Z][_a-zA-Z0-9]*
NAT (0|([1-9][0-9]*))

%%
"variables" { UPD_POS ; return Variables_Kw ; }
"axioms"    { UPD_POS ; return Axioms_Kw ; }
"goals"      { UPD_POS ; return Goals_Kw ; }

"var"    { UPD_POS ; return Var_Kw ; }
"assume" { UPD_POS ; return Assume_Kw ; }
"sat"    { UPD_POS ; return Sat_Kw ; }

"int"  { UPD_POS ; return Int_Type_Kw ; }
"bool" { UPD_POS ; return Bool_Type_Kw ; }

"true"  { UPD_POS ; return True_Kw ; }
"false" { UPD_POS ; return False_Kw ; }

"forall" { UPD_POS ; return Forall_Kw ; }
"exists" { UPD_POS ; return Exists_Kw ; }

"mod" { UPD_POS ; return Mod_Sy ; }

{ID}  { UPD_POS ; return Id_Val ; }
{NAT} { UPD_POS ; return Nat_Val ; }

"{" { UPD_POS ; return LB ; } 
"}" { UPD_POS ; return RB ; } 
"(" { UPD_POS ; return LP ; }
")" { UPD_POS ; return RP ; }
":" { UPD_POS ; return Is_Type_Kw ; }
"," { UPD_POS ; return Comma_Sep_Kw ; }
";" { UPD_POS ; return End_Stmt_Kw ; }

"+" { UPD_POS ; return Plus_Sy ; }
"-" { UPD_POS ; return Sub_Sy ; }
"/" { UPD_POS ; return Div_Sy ; }


"="  { UPD_POS ; return Eq_Sy ; }
"<=" { UPD_POS ; return Le_Sy ; }
">=" { UPD_POS ; return Ge_Sy ; }
"<"  { UPD_POS ; return Lt_Sy ; }
">"  { UPD_POS ; return Gt_Sy ; }

"/\\" { UPD_POS ; return Land_Sy ; }
"\\/" { UPD_POS ; return Lor_Sy ; }
"=>"  { UPD_POS ; return Limp_Sy ; }
"<=>" { UPD_POS ; return Lequiv_Sy ; }
"~"   { UPD_POS ; return Lneg_Sy ; }

[ \t]+ { UPD_POS ; }
[\n]   { Line_Num := Line_Num + 1 ; Col_Num := 0 ; UPD_POS ; }

. { put_line(yytext) ; text_io.put_line("?? end of file?????"); }

%%

with Parser_Tokens ;
use Parser_Tokens ;

with Ada.Strings.Hash;
with Ada.Containers.Hashed_Maps;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package lexer is

--     function Equivalent_Key (Left, Right : Unbounded_String) return Boolean ;
--     function Hash_Func(Key : Unbounded_String) return Ada.Containers.Hash_Type ; 
 
--     package My_Hash is new Ada.Containers.Hashed_Maps(
--         Key_Type => Unbounded_String,
--         Element_Type => Unbounded_String,
--         Hash => Hash_Func,
--         Equivalent_Keys => Equivalent_Key ) ;
   
        Line_Num : Natural := 0 ;
        Col_Num : Natural  := 0 ;

	function Yylex return token;
        procedure UPD_POS( txt : String := Yytext) ;
        function Get_Line_Num return Natural ;


end lexer ;

package body lexer is

--    function Equivalent_Key (Left, Right : Unbounded_String) return Boolean is
--    begin
--       return To_String(Left) = To_String(Right);
--    end Equivalent_Key;
 
--   function Hash_Func(Key : Unbounded_String) return Ada.Containers.Hash_Type is
--   begin
--      return Ada.Strings.Hash(To_String(Key));
--   end Hash_Func;

    -- When a newline is read, Line_Num is increased and Col_Num is resetted to 0

    procedure UPD_POS( txt : String := Yytext) is
    begin
     Col_Num := Col_Num + txt'Length ;
    end UPD_POS ;

    function Get_Line_Num return Natural is
    begin
      return Line_Num ;
    end Get_Line_Num ;

##

end lexer ;
