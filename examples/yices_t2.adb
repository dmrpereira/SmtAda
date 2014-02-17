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

with Yices; use Yices ;

with Ada.Text_Io ; use Ada.Text_Io ;
--with Ada.Text_Io.Enumeration_Io ;

procedure Yices_T2 is
   
   Ctx : Yices_Context ;
   E1, E2, Eq1 : Yices_Expr ;
   B : Lbool ;
   
   package Lbool_Io is new Ada.Text_Io.Enumeration_Io( Enum => Lbool ) ;
   
begin
   
   Ctx := Yices_Mk_Context ;
   E1 := Yices_Mk_Fresh_Bool_Var(Ctx) ;
   E2 := Yices_Mk_Fresh_Bool_Var(Ctx) ;
   Eq1 := Yices_Mk_Eq(Ctx,E1,E2) ;
   Yices_Assert(Ctx,Eq1) ;
   Yices_Dump_Context(Ctx) ;
   
   B := Yices_Check(Ctx) ;
   
   case B is
      when L_True =>
   	Put("satisfiable") ; New_Line ;
   	declare
   	   M : Yices_Model ;
	   V : Yices_Var_Decl ;
   	begin
   	   M := Yices_Get_Model(Ctx);
   	   Put("e1 = ") ;
	   V := Yices_Get_Var_Decl(E1) ; 
	   Lbool_Io.Put(Yices_Get_Value(M,V)); 
	   New_Line ;
	   Put("e2 = ") ;
	   V := Yices_Get_Var_Decl(E2) ; 
	   Lbool_Io.Put(Yices_Get_Value(M,V)); 
	   New_Line ;
	   Yices_Display_Model(M);
	end ;
      when L_False =>
	 Put("unsatisfiable") ; New_Line ;
      when L_Undef =>
	 Put("unknown") ; New_Line ;
   end case ;
   
   Yices_Del_Context(Ctx); 
      
end Yices_T2 ;
