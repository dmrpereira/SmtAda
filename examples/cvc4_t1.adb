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

with Cvc4, Cvc4_Defs ;
use Cvc4, Cvc4_Defs ;

with System ;

procedure Cvc4_T1 is
   Ctx : VC ;
   I : C_Type ;
   X, Y, Zero, X_Pos, Y_Pos, Two, Twox, Twox_Plus_Y, Three, Twox_Plus_Y_Geq_3, Formula : Expr ;
begin
   Ctx := Vc_CreateValidityChecker(Flags(System.Null_Address)) ;
   I  := Vc_IntType(Ctx);
end Cvc4_T1 ;
