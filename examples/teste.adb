with Interfaces.C;
with Interfaces.C.Strings;
with System; 
with System.Address_Image;
with Ada.Text_Io; use Ada.Text_Io;

with GNAT.OS_Lib ; 

with Z3.Example_C_Api ; use Z3, Z3.Example_C_Api;

with Yices; use Yices ;

with CVC3_Kinds, CVC3_Defs, CVC3 ; 
with CVC4_Defs, CVC4 ; 

procedure Teste is
   X : Interfaces.C.Strings.Chars_Ptr ;
   Y_Ctx : Yices_Context ;
   Cvc_Checker : Cvc3_Defs.Cvc_VC ;
   Cvc_Int : Cvc3_Defs.Cvc_Ctype ;
   E1, E2 : Cvc3_Defs.Cvc_Expr ;
   Zero, P1, P2  : Cvc3_Defs.Cvc_Expr ;
   
   procedure Cvc4_Test is
      C : CVC4_Defs.Vc; 
      I : CVC4_Defs.c_Type ;
      X, Y, Z, Xpos, Ypos, Two, Twox, Twoxpy, Three, Threepygeq3, twoxpygeq3 : CVC4_Defs.Expr ;
      Formula : CVC4_Defs.Expr ;
   begin
      Put("-----------------"); New_Line ;
      Put("-- CVC4 tryout --"); New_Line ;
      Put("-----------------"); New_Line ;
      C := Cvc4.Vc_CreateValidityChecker(Cvc4_Defs.Flags(System.Null_Address)) ;
      I := Cvc4.Vc_IntType(C) ;
      X := Cvc4.Vc_VarExpr(C,Interfaces.C.Strings.New_String("x"),I);
      Y := Cvc4.Vc_VarExpr(C,Interfaces.C.Strings.New_String("y"),I);
      Z := Cvc4.Vc_RatExpr(C,0,1);
      Xpos := Cvc4.Vc_GtExpr(C,X,Z);
      Ypos := Cvc4.Vc_GtExpr(C,Y,Z);
      Two := Cvc4.Vc_RatExpr(C, 2, 1);
      Twox := Cvc4.Vc_MultExpr(C,Two,X);
      Twoxpy := Cvc4.vc_plusExpr(C,Twox,Y);
      Three := Cvc4.Vc_RatExpr(C, 3, 1);
      twoxpygeq3 := Cvc4.Vc_GeExpr(C,twoxpy,three);
      formula := Cvc4.Vc_ImpliesExpr(C,Cvc4.Vc_AndExpr(C,xpos,ypos),twoxpygeq3);
      Put("Checking validity of formula ");
      Cvc4.Vc_PrintExpr(C,Formula);
      New_Line;
      Put("CVC4 should return 1 (meaning VALID).");
      New_Line;
      Put("Result from CVC4 is: ") ;
      Put(Cvc4.Vc_Query(C,Formula)'Img);
      New_Line;
      Put("------------------------"); New_Line ;
      Put("-- End of CVC4 tryout --"); New_Line ;
      Put("------------------------"); New_Line ;
   end Cvc4_Test ;
   
   procedure Cvc3_Test is
      C : CVC3_Defs.Cvc_Vc; 
      I : CVC3_Defs.Cvc_cType ;
      X, Y, Z, Xpos, Ypos, Two, Twox, Twoxpy, Three, Threepygeq3, twoxpygeq3 : CVC3_Defs.Cvc_Expr ;
      Formula : CVC3_Defs.Cvc_Expr ;
   begin
      Put("-----------------"); New_Line ;
      Put("-- CVC3 tryout --"); New_Line ;
      Put("-----------------"); New_Line ;
      C := Cvc3.Vc_CreateValidityChecker(Cvc3_Defs.Cvc_Flags(System.Null_Address)) ;
      I := Cvc3.Vc_IntType(C) ;
      X := Cvc3.Vc_VarExpr(C,Interfaces.C.Strings.New_String("x"),I);
      Y := Cvc3.Vc_VarExpr(C,Interfaces.C.Strings.New_String("y"),I);
      Z := Cvc3.Vc_RatExpr(C,0,1);
      Xpos := Cvc3.Vc_GtExpr(C,X,Z);
      Ypos := Cvc3.Vc_GtExpr(C,Y,Z);
      Two := Cvc3.Vc_RatExpr(C, 2, 1);
      Twox := Cvc3.Vc_MultExpr(C,Two,X);
      Twoxpy := Cvc3.vc_plusExpr(C,Twox,Y);
      Three := Cvc3.Vc_RatExpr(C, 3, 1);
      twoxpygeq3 := Cvc3.Vc_GeExpr(C,twoxpy,three);
      formula := Cvc3.Vc_ImpliesExpr(C,Cvc3.Vc_AndExpr(C,xpos,ypos),twoxpygeq3);
      Put("Checking validity of formula ");
      Cvc3.Vc_PrintExpr(C,Formula);
      New_Line;
      Put("CVC3 should return 1 (meaning VALID).");
      New_Line;
      Put("Result from CVC3 is: ") ;
      Put(Cvc3.Vc_Query(C,Formula)'Img);
      New_Line;
      Put("------------------------"); New_Line ;
      Put("-- End of CVC3 tryout --"); New_Line ;
      Put("------------------------"); New_Line ;
   end Cvc3_Test ;
   
   procedure Yices_Test is
   begin
      null;
   end Yices_Test ;
      
   
   
begin
   -- cvc4 tryout
   Cvc4_Test ;
   -- cvc3 tryout
   Cvc3_Test ;
   
   -- Yices tryout
   X := Yices_Version ;
   Put(Interfaces.C.Strings.Value(X));
   New_Line ;
   Put("Now building an Yices context ...") ;
   New_Line ;
   Y_Ctx := Yices_Mk_Context ;
   Put("Now deleting it ...") ;
   New_Line ;
   Yices_Del_Context(Y_Ctx) ;
   -- Z3 tryout
   Display_Version;
end Teste;
		   
-- Interfaces.C.Strings.Value(Interfaces.C.Strings.Chars_Ptr(Z3_Get_Error_Msg(Z3_SORT_ERROR))));
