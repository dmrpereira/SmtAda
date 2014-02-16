with Yices ; use Yices ;

procedure Yices_Teste is
   
   Ctx : Yices_Context ;
   E1, E2, Eq1 : Yices_Expr ;
   
begin
   
   Ctx := Yices_Mk_Context ;
   E1 := Yices_Mk_Fresh_Bool_Var(Ctx) ;
   E2 := Yices_Mk_Fresh_Bool_Var(Ctx) ;
   Eq1 := Yices_Mk_Eq(Ctx,E1,E2) ;
   Yices_Assert(Ctx,Eq1) ;
   Yices_Dump_Context(Ctx) ;
      
end Yices_Teste ;
