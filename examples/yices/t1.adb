with Bridge.Yices ;
with Yices; use Yices ;
use Bridge, Bridge.Yices ;



procedure Test_Yices is
   B : Value := null ;
   I : Value := null ;
   T : Value := null ;
   C : Context := null ;
begin
   C := Mk_Context ;
   B := Mk_Bool_Var(C,"cool") ;
   I := Mk_Int_Var(C,120) ;
   T := Mk_Bool_Const(C,True) ;
   Print_Value(B);
   Print_Value(I);
   Print_Value(T);
end Test_Yices ;
