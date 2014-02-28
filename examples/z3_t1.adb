--with System, System.Address_Image ;

with Interfaces.C, Interfaces.C.Strings ;

with Ada.Text_Io; use Ada.Text_Io ;

with Z3;
with Z3.Accessors, Z3.Arith, Z3.Arrays_And_Sets, Z3.Bvectors, Z3.Configurations,
  Z3.Consts_And_Apps, Z3.Contexts, Z3.Deprecated, Z3.Logic_And_Equal, Z3.Logs_And_Strings,
  Z3.Models, Z3.Modifiers, Z3.Numerals, Z3.Parameters, Z3.Quants, Z3.Solvers, Z3.Symbols_And_Sorts, Z3.Utils ;

use Z3, Z3.Accessors, Z3.Arith, Z3.Arrays_And_Sets, Z3.Bvectors, Z3.Configurations,
  Z3.Consts_And_Apps, Z3.Contexts, Z3.Deprecated, Z3.Logic_And_Equal, Z3.Logs_And_Strings,
  Z3.Models, Z3.Modifiers, Z3.Numerals, Z3.Parameters, Z3.Quants, Z3.Solvers, Z3.Symbols_And_Sorts, Z3.Utils ;

procedure Z3_T1 is
   Cfg : Z3_Config ;
   C   : Z3_Context ;
   Bsort : Z3_Sort ;
   Va, Vb, Vc : Z3_Symbol ;
   Val_A, Val_B, Val_C : Z3_Ast ;
   Form_Arg_1,Form_Arg_2,Form_Arg_3 : Z3_Ast ;
   Conj_1_2 : Z3_Ast_Array(0..2) ;
   Final : Z3_Ast ;
begin
   Cfg := Z3_Mk_Config ;
   C := Z3_Mk_Context(Cfg) ;
   
   Bsort := Z3_Mk_Bool_Sort(C);
   Va := Z3_Mk_String_Symbol(C,Z3_String(Interfaces.C.Strings.New_String("p")));
   Vb := Z3_Mk_String_Symbol(C,Z3_String(Interfaces.C.Strings.New_String("q")));
   Vc := Z3_Mk_String_Symbol(C,Z3_String(Interfaces.C.Strings.New_String("r")));
   
   Val_A := Z3_Mk_Const(C,Va,Bsort);
   Val_B := Z3_Mk_Const(C,Vb,Bsort);
   Val_C := Z3_Mk_Const(C,Vc,Bsort);
   
   Form_Arg_1 := Z3_Mk_Implies(C,Val_A,Val_B) ;
   Form_Arg_2 := Z3_Mk_Implies(C,Val_B,Val_C) ;
   Form_Arg_3 := Z3_Mk_Implies(C,Val_A,Val_C) ;   
   
   Conj_1_2(0) := Form_Arg_1 ;
   Conj_1_2(1) := Form_Arg_2 ;
   
   Final := Z3_Mk_Not(C,Z3_Mk_Implies(C,Z3_Mk_And(C,2,Conj_1_2),Form_Arg_3));
   
   Z3_Assert_Cnstr(C,Final);
   
   case Z3_Check(C) is
      when Z3_L_False =>
	 Put("Unsat") ;
      when Z3_L_True =>
	 Put("Sat");
      when others =>
	 Put("Unknown");
   end case;
   
   New_Line ;
   
end Z3_T1 ;
