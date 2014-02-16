with System;
with System.Address_Image;

with Interfaces.C;
with Interfaces.C.Strings;

with Ada.Text_Io; use Ada.Text_Io;

with GNAT.OS_Lib ;

with Z3;
with Z3.Accessors, Z3.Arith, Z3.Arrays_And_Sets, Z3.Bvectors, Z3.Configurations,
  Z3.Consts_And_Apps, Z3.Contexts, Z3.Deprecated, Z3.Logic_And_Equal, Z3.Logs_And_Strings,
  Z3.Models, Z3.Modifiers, Z3.Numerals, Z3.Parameters, Z3.Quants, Z3.Solvers, Z3.Symbols_And_Sorts, Z3.Utils ;

use Z3, Z3.Accessors, Z3.Arith, Z3.Arrays_And_Sets, Z3.Bvectors, Z3.Configurations,
  Z3.Consts_And_Apps, Z3.Contexts, Z3.Deprecated, Z3.Logic_And_Equal, Z3.Logs_And_Strings,
  Z3.Models, Z3.Modifiers, Z3.Numerals, Z3.Parameters, Z3.Quants, Z3.Solvers, Z3.Symbols_And_Sorts, Z3.Utils ;

package Z3.Example_C_Api is

   type Jmp_Buf is array(0..37) of Interfaces.C.Int ;
   pragma Convention(C,Jmp_Buf);

   procedure Longjump(B : in Jmp_Buf ; E : in Interfaces.C.Int );
   pragma Import(C,Longjump,"longjmp");

   G_Catch_Buffer : Jmp_Buf ;

   procedure Throw_Z3_Error( C : in Z3_context ; E : in  Z3_Error_Code ) ;

   procedure Exit_F( S : in String ) ;

   procedure Unreachable ;

   procedure Error_Handler( C : in Z3_Context ; E : in Z3_Error_Code ) ;

   function Mk_Context_Custom( Cfg : in Z3_Config ; Err : access procedure( Arg1 : in Z3_Context ; Arg2 : in Z3_Error_Code ) ) return Z3_Context ;

   function Mk_Context return Z3_Context ;

   function Mk_Var( Ctx : in Z3_Context ; Name : in String ; Ty : in Z3_Sort ) return Z3_Ast ;

   function Mk_Bool_Var( Ctx : in Z3_Context ; Name : in String ) return Z3_Ast ;

   function Mk_Int_Var( Ctx : in Z3_Context ; Name : in String ) return Z3_Ast ;

   function Mk_Int( Ctx : in Z3_Context ; V : Integer ) return Z3_Ast ;

   function Mk_Real_Var( Ctx : in Z3_Context ; Name : String ) return Z3_Ast ;

   function Mk_Unary_App( Ctx : in Z3_Context ; F : in Z3_Func_Decl ; X : in Z3_Ast ) return Z3_Ast ;

   function Mk_Binary_App( Ctx : in Z3_Context ; F : in Z3_Func_Decl ; X, Y : in Z3_Ast ) return Z3_Ast ;

   procedure Check( Ctx : in Z3_Context ; Expected_Result : in Z3_Lbool ) ;

   procedure Display_Version ;

   procedure Assert_Inj_Axiom( Ctx : in Z3_Context ; F : in Z3_Func_Decl ; I : in Interfaces.C.Unsigned ) ;



end Z3.Example_C_Api ;
