with Interfaces.C, Interfaces.C.Strings;
with System;

package Z3.Consts_And_Apps is
   
   --------------------------------
   -- Constants and applications --
   --------------------------------
   
   -- Declare a constant or function.
   function Z3_Mk_Func_Decl(C:in Z3_Context;
			    S:in Z3_Symbol;
			    Domain_Size:in Interfaces.C.Int;
			    Domain:in Z3_Sort_Array;
			    R:in Z3_Sort) return Z3_Func_Decl;
   pragma Import(C,Z3_Mk_Func_Decl,"Z3_mk_func_decl");
   
   
   -- Create a constant or function application.
   function Z3_Mk_App(C:in Z3_Context;
		      D:in Z3_Func_Decl;
		      Num_Args:in Interfaces.C.Unsigned;
		      Args:in Z3_Ast_Array) return Z3_Ast;
   pragma Import(C,Z3_Mk_App,"Z3_mk_app");
   
   -- Declare and create a constant.
   function Z3_Mk_Const(C:in Z3_Context;S:in Z3_Symbol;Ty:in Z3_Sort) return Z3_Ast;
   pragma Import(C,Z3_Mk_Const,"Z3_mk_const");
   
   -- Declare a fresh constant or function.
   function Z3_Mk_Fresh_Func_Decl(C:in Z3_Context; 
				  Prefix:in Z3_String;
				  Domain_Size:in Interfaces.C.Int;
				  Domain:in Z3_Sort_Array;
				  R:in Z3_Sort) return Z3_Func_Decl;
   pragma Import(C,Z3_Mk_Fresh_Func_Decl,"Z3_mk_fresh_func_decl");
   
   -- Declare and create a fresh constant.
   function Z3_Mk_Fresh_Const(C:in Z3_Context;Prefix:in Z3_String;Ty:in Z3_Sort) return Z3_Ast;
   pragma Import(C,Z3_Mk_Fresh_Const,"Z3_mk_fresh_const");
   
   
   
end Z3.Consts_And_Apps ;
