with Interfaces.C, Interfaces.C.Strings;
with System;

package Z3.Logic_And_Equal is
   
   -- Create an AST node representing \c true.
   function Z3_Mk_True(C:in Z3_Context) return Z3_Ast;
   pragma Import(C,Z3_Mk_True,"Z3_mk_true");
   
   -- Create an AST node representing \c false.
   function Z3_Mk_False(C:in Z3_Context) return Z3_Ast;
   pragma Import(C,Z3_Mk_False,"Z3_mk_false");
   
   -- Create an AST node representing <tt>l = r</tt>.
   function Z3_Mk_Eq(C:in Z3_Context;L:in Z3_Ast;R:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Eq,"Z3_mk_eq");
   
   -- Create an AST node represeting a distinct construct. It is used for declaring
   -- the arguments t_i pairwise distinct.
   function Z3_Mk_Distinct(C:in Z3_Context;Num_Args:in Interfaces.C.Unsigned;Args:in Z3_Ast_Array) return Z3_Ast;
   pragma Import(C,Z3_Mk_Distinct,"Z3_mk_distinct");
      
   -- Create an AST node representing not(a). 
   function Z3_Mk_Not(C:in Z3_Context;A:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Not,"Z3_mk_not");

   --  	Create an AST node representing an if-then-else: ite(t1, t2, t3). 
   function Z3_Mk_Ite(C:in Z3_Context;T1, T2, T3:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Ite,"Z3_mk_ite");
  
   -- Create an AST node representing t1 iff t2. 
   function Z3_Mk_Iff(C:in Z3_Context;T1, T2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Iff,"Z3_mk_iff");
   
   -- Create an AST node representing t1 implies t2. 
   function Z3_Mk_Implies(C:in Z3_Context;T1, T2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Implies,"Z3_mk_implies");
 
   --  	Create an AST node representing t1 xor t2. 
   function Z3_Mk_Xor(C:in Z3_Context;T1, T2:in Z3_Ast) return Z3_Ast;
   pragma Import(C,Z3_Mk_Xor,"Z3_mk_xor");

   -- Create an AST node representing args[0] and ... and args[num_args-1].
   -- The array args must have num_args elements. 
   -- All arguments must have Boolean sort. 
   function Z3_Mk_And(C:in Z3_Context;Num_Args:in Interfaces.C.Unsigned;Args:in Z3_Ast_Array) return Z3_Ast;
   pragma Import(C,Z3_Mk_And,"Z3_mk_and");
   
   -- Create an AST node representing args[0] or ... or args[num_args-1].
   -- The array args must have num_args elements.
   -- All arguments must have Boolean sort. 
   function Z3_Mk_Or(C:in Z3_Context;Num_Args:in Interfaces.C.Unsigned;Args:in Z3_Ast_Array) return Z3_Ast;
   pragma Import(C,Z3_Mk_Or,"Z3_mk_or");
   
   
end Z3.Logic_And_Equal ;
