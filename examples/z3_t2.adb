with Interfaces.C, Interfaces.C.Strings ;

with Ada.Text_Io; use Ada.Text_Io ;

with Z3;
with Z3.Accessors, Z3.Arith, Z3.Arrays_And_Sets, Z3.Bvectors, Z3.Configurations,
  Z3.Consts_And_Apps, Z3.Contexts, Z3.Deprecated, Z3.Logic_And_Equal, Z3.Logs_And_Strings,
  Z3.Models, Z3.Modifiers, Z3.Numerals, Z3.Parameters, Z3.Quants, Z3.Solvers, Z3.Symbols_And_Sorts, Z3.Utils ;

use Z3, Z3.Accessors, Z3.Arith, Z3.Arrays_And_Sets, Z3.Bvectors, Z3.Configurations,
  Z3.Consts_And_Apps, Z3.Contexts, Z3.Deprecated, Z3.Logic_And_Equal, Z3.Logs_And_Strings,
  Z3.Models, Z3.Modifiers, Z3.Numerals, Z3.Parameters, Z3.Quants, Z3.Solvers, Z3.Symbols_And_Sorts, Z3.Utils ;

procedure Z3_T2 is
   
   function Mk_Z3_String(S:in String) return Z3_String is
   begin
      return Z3_String(Interfaces.C.Strings.New_String(S));
   end Mk_Z3_String;
			 
   Cfg : Z3_Config := Z3_Mk_Config ;
   Ctx : Z3_Context := Z3_Mk_Context(Cfg) ;
   Int_Sort : Z3_Sort := Z3_Mk_Int_Sort(Ctx);
   Array_Sort : Z3_Sort := Z3_Mk_Array_Sort(Ctx,Int_Sort,Int_Sort);
   
   X, Y, Z : Z3_Ast ;
   A1, A2, A3 : Z3_Ast ;
begin
   
   X := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("x")),Int_Sort);
   Y := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("y")),Int_Sort);
   Z := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("z")),Int_Sort);
   
   A1 := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("a1")),Array_Sort);
   A2 := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("a2")),Array_Sort);
   A3 := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("a3")),Array_Sort);
   
   Z3_Assert_Cnstr(Ctx,Z3_Mk_Eq(Ctx,Z3_Mk_Select(Ctx,A1,X),X));
   Z3_Assert_Cnstr(Ctx,Z3_Mk_Eq(Ctx,Z3_Mk_Store(Ctx,A1,X,Y),A1));
   Z3_Assert_Cnstr(Ctx,Z3_Mk_Not(Ctx,Z3_Mk_Eq(Ctx,X,Y)));
   
   case Z3_Check(Ctx) is
      when Z3_L_False =>
	 Put("Unsat") ;
      when Z3_L_True =>
	 Put("Sat");
      when others =>
	 Put("Unknown");
   end case;
   
   New_Line ;
   
end Z3_T2 ;
