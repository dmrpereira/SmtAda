------------------------------------
-- Arithmetic: Integers and Reals --
------------------------------------

with Interfaces.C, Interfaces.C.Strings;
with System;


package Z3.Arith is
   
   -- Create an AST node representing args[0] + ... + args[num_args-1].
   -- The array args must have num_args elements. 
   -- All arguments must have int or real sort. 
   function Z3_Mk_Add(C:in Z3_Context;Num_Args:in Interfaces.C.Unsigned;Args:in Z3_Ast_Array) return Z3_Ast;
   pragma Import(C,Z3_Mk_Add,"Z3_mk_add");
   
   -- Create an AST node representing args[0] * ... * args[num_args-1].
   -- The array args must have num_args elements.
   -- All arguments must have int or real sort. 
   function Z3_Mk_Mul(C:in Z3_Context;Num_Args:in Interfaces.C.Unsigned;Args:in Z3_Ast_Array) return Z3_Ast;
   pragma Import(C,Z3_Mk_Mul,"Z3_mk_mul");

   -- Create an AST node representing args[0] - ... - args[num_args - 1].
   -- The array args must have num_args elements.
   -- All arguments must have int or real sort. 
   function Z3_Mk_Sub(C:in Z3_Context;Num_Args:in Interfaces.C.Unsigned;Args:in Z3_Ast_Array) return Z3_Ast;
   pragma Import(C,Z3_Mk_Sub,"Z3_mk_sub");

   -- Create an AST node representing -arg.The arguments must have int or real type. 
   function Z3_Mk_Unary_Minus(C:in Z3_Context;Arg:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Unary_Minus,"Z3_mk_unary_minus");

   -- Create an AST node representing arg1 div arg2.
   -- The arguments must either both have int type or both have real type.
   -- If the arguments have int type, then the result type is an int type, otherwise the the result type is real. 
   function Z3_Mk_Div(C:in Z3_Context ; Arg1, Arg2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Div,"Z3_mk_div");

   --  	Create an AST node representing arg1 mod arg2.The arguments must have int type. 
   function Z3_Mk_Mod(C:in Z3_Context ; Arg1, Arg2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Mod,"Z3_mk_mod");

   --  	Create an AST node representing arg1 rem arg2.The arguments must have int type. 
   function Z3_Mk_Rem(C:in Z3_Context ; Arg1, Arg2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Rem,"Z3_mk_rem");
   
   --  	Create an AST node representing arg1^arg2. 
   function Z3_Mk_Power(C:in Z3_Context ; Arg1, Arg2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Power,"Z3_mk_power");

   -- 	Create less than. 
   function Z3_Mk_Lt(C:in Z3_Context ; T1, T2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Lt,"Z3_mk_lt");

   -- 	Create less than or equal to. 
   function Z3_Mk_Le(C:in Z3_Context;T1, T2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Le,"Z3_mk_le");

   -- 	Create greater than. 
   function Z3_Mk_Gt(C:in Z3_Context;T1,T2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Gt,"Z3_mk_gt");

   --	Create greater than or equal to. 
   function Z3_Mk_Ge(C:in Z3_Context;T1,T2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Ge,"Z3_mk_ge");
   
   --  	Coerce an integer to a real. 
   function Z3_Mk_Int2real(C:in Z3_Context;T1:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Int2real,"Z3_mk_int2real");

   -- Coerce a real to an integer.  
   function Z3_Mk_Real2int(C:in Z3_Context;T1:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Real2int,"Z3_mk_real2int");

   -- Check if a real number is an integer.  
   function Z3_Mk_Is_Int(C:in Z3_Context;T1:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Is_Int,"Z3_mk_is_int");
   
   
end Z3.Arith ;
