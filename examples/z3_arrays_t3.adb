with Z3;
with Z3.Accessors, Z3.Arith, Z3.Arrays_And_Sets, Z3.Bvectors, Z3.Configurations,
  Z3.Consts_And_Apps, Z3.Contexts, Z3.Deprecated, Z3.Logic_And_Equal, Z3.Logs_And_Strings,
  Z3.Models, Z3.Modifiers, Z3.Numerals, Z3.Parameters, Z3.Quants, Z3.Solvers, Z3.Symbols_And_Sorts, Z3.Utils ;

use Z3, Z3.Accessors, Z3.Arith, Z3.Arrays_And_Sets, Z3.Bvectors, Z3.Configurations,
  Z3.Consts_And_Apps, Z3.Contexts, Z3.Deprecated, Z3.Logic_And_Equal, Z3.Logs_And_Strings,
  Z3.Models, Z3.Modifiers, Z3.Numerals, Z3.Parameters, Z3.Quants, Z3.Solvers, Z3.Symbols_And_Sorts, Z3.Utils ;

procedure Z3_Arrays_T2 is
   
   function Mk_Z3_String(S:in String) return Z3_String is
   begin
      return Z3_String(Interfaces.C.Strings.New_String(S));
   end Mk_Z3_String;
   -- Build the logical context
   Cfg : Z3_Config := Z3_Mk_Config ;
   Ctx : Z3_Context := Z3_Mk_Context(Cfg) ;
   -- Building some sorts that we will need
   Int_Sort : Z3_Sort := Z3_Mk_Int_Sort(Ctx);
   Array_Sort : Z3_Sort := Z3_Mk_Array_Sort(Ctx,Int_Sort,Int_Sort);
   
   All1 : Z3_Ast ;
   A, I : Z3_Ast ;
      
begin
   
   All1 := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("all1")),Array_Sort);
   A := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("a")),Int_Sort);
   I := Z3_Mk_Const(Ctx,Z3_Mk_String_Symbol(Ctx,Mk_Z3_String("i")),Int_Sort);   
   
   Z3_Assert_Cnstr(Ctx,A,Z3_Mk_Eq(Ctx,Z3_Mk_Select(Ctx,All1,I)));
   
end Z3_Arrays_T3 ;
