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

with Interfaces.C ;
with Interfaces.C.Strings ;

with Ada.Text_Io ; use Ada.Text_Io ;

procedure Yices_T3 is
   Ctx : Yices_Context ;
   Ty : Yices_Type ;
   
   Domain : Yices_Type_Array(Integer range 0..1) ;
   
   Fdecl, Xdecl, Ydecl : Yices_Var_Decl ;
   
   Fty : Yices_Type ;
   
   F, X, Y : Yices_Expr ;
   
   Args : Yices_Expr_Array(Integer range 0..1) ;
   
   Fx, Fy, Eq, Diseq : Yices_Expr ;
   
begin
   
   Ctx := Yices_Mk_Context ;
   
   Ty := Yices_Mk_Type(Ctx,Interfaces.C.Strings.New_String("any")) ;
   Domain(0) := Ty ;
   
   Fty := Yices_Mk_Function_Type(Ctx,Domain,1,Ty) ;

   
   Fdecl := Yices_Mk_Var_Decl(Ctx,Interfaces.C.Strings.New_String("f"),Fty);
   Xdecl := Yices_Mk_Var_Decl(Ctx,Interfaces.C.Strings.New_String("x"),Ty);
   Ydecl := Yices_Mk_Var_Decl(Ctx,Interfaces.C.Strings.New_String("y"),Ty);
   
   --Yices_Dump_Context(Ctx) ;
   
   F := Yices_Mk_Var_From_Decl(Ctx,Fdecl) ;
   X := Yices_Mk_Var_From_Decl(Ctx,Xdecl) ;
   Y := Yices_Mk_Var_From_Decl(Ctx,Ydecl) ;
   
   ---Yices_Dump_Context(Ctx) ;
   
   Args(0) := X ;
   Fx := Yices_Mk_App(Ctx,F,Args,1) ;
   Yices_Pp_Expr(Fx); New_Line ;
   Args(0) := Y ;
   Fy := Yices_Mk_App(Ctx,F,Args,1) ;
   Yices_Pp_Expr(Fy); New_Line ;
   Eq := Yices_Mk_Eq(Ctx,X,Y);
   Yices_Pp_Expr(Eq); New_Line ;
   Diseq := Yices_Mk_Diseq(Ctx,Fx,Fy) ;
   Yices_Pp_Expr(Diseq); New_Line ;
   Yices_Assert(Ctx,Eq);
   Yices_Assert(Ctx,Diseq);
   --Put(Integer(Yices_Inconsistent(Ctx))'Img) ; New_Line ;
   if Integer(Yices_Inconsistent(Ctx)) = 0 then
      Put("unsat") ; New_Line ;
   end if ;
   Yices_Del_Context(Ctx);
      
end Yices_T3 ;
