------------------------------------------------------------------------------
--                                                                          --
--                                 SMT-Ada                                  --
--                                                                          --
-- Smt-Ada is free  software;  you can redistribute  it and/or  modify it   --
-- under terms of the  GNU General Public License as published  by the Free --
-- Software  Foundation;  either version 3,  or (at your option)  any later --
-- version.  gnat2why is distributed  in the hope that  it will be  useful, --
-- but WITHOUT ANY WARRANTY; without even the implied warranty of  MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public --
-- License for  more details.  You should have  received  a copy of the GNU --
-- General  Public License  distributed with  gnat2why;  see file COPYING3. --
-- If not,  go to  http://www.gnu.org/licenses  for a complete  copy of the --
-- license.                                                                 --
--                                                                          --
------------------------------------------------------------------------------

-- Simple example to prove the following formula with CVC3 :
--
-- (((x > 0) AND (y > 0)) => (((2 * x) + y) >= 3))

with System ;
with Interfaces.C ;
with Interfaces.C.Strings ;

with Ada.Text_Io ; use Ada.Text_Io ;

with Cvc3, Cvc3_Defs ;
use Cvc3, Cvc3_Defs ;

procedure Cvc3_T1 is
   Ctx : CVC_VC ;
   I : CVC_CType ;
   X, Y, Zero, X_Pos, Y_Pos : CVC_Expr ;
   Two, Twox, Twox_Plus_Y : CVC_Expr ; 
   Three, Twox_Plus_Y_Geq_3, Formula : CVC_Expr ;
begin
   
   -- Start CVC3's validity checker, and set [Ctx] as an identifier to it
   Ctx := Vc_CreateValidityChecker(CVC_Flags(System.Null_Address)) ;
   
   -- Creates the integer type (an identifier to it)
   I  := Vc_IntType(Ctx) ;
   
   -- Create two new integer variables [X] and [Y], and create
   -- also the zero constant
   X := Vc_VarExpr(Ctx,Interfaces.C.Strings.New_String("x"),I) ;
   Y := Vc_VarExpr(Ctx,Interfaces.C.Strings.New_String("y"),I) ;
   Zero := Vc_RatExpr(Ctx,0,1) ;
   
   -- Generate positivity constraint to both [X] and [Y]
   X_Pos := Vc_GtExpr(Ctx,X,Zero) ;
   Y_Pos := Vc_GtExpr(Ctx,Y,Zero) ;
   
   -- Creates the integer constant 2, defines two new
   -- expressions involving multiplication and addition to
   -- [X] and [Y]
   Two := Vc_RatExpr(Ctx,2,1) ;
   Twox := Vc_MultExpr(Ctx,Two,X) ;
   Twox_Plus_Y := Vc_PlusExpr(Ctx,Twox,Y) ;
   
   Three := Vc_RatExpr(Ctx,3,1) ;
   Twox_Plus_Y_Geq_3 := Vc_GeExpr(Ctx,Twox_Plus_Y,Three) ;
   
   Formula := Vc_ImpliesExpr(Ctx,vc_andExpr(Ctx,X_Pos,Y_Pos),Twox_Plus_Y_Geq_3) ;
   
   Put("Checking validity of formula ") ;
   Vc_PrintExpr(Ctx,Formula) ;
   Put("with CVC3.") ; New_Line ; 
   Put("CVC3 should return 1 (meaning VALID).") ; New_Line ;
   Put("Result from CVC3 is: ") ;
   Put(Integer(Vc_Query(Ctx,Formula))'Img); New_Line ;
   
end Cvc3_T1 ;
