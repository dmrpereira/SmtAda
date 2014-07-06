with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3.Logs_And_Strings is
   
   --------------------------
   --  Interaction logging --
   --------------------------
   
   -- Log interaction to a file.    
   function Z3_Open_Log( Filename : in Z3_String ) return Z3_Bool ;
   pragma Import(C,Z3_Open_Log,"Z3_open_log") ;

   -- Append user-defined string to interaction log.  
   procedure Z3_Append_Log( S : in Z3_String );
   pragma Import(C,Z3_Append_Log,"Z3_append_log") ;

   -- Close interaction log.  
   procedure Z3_Close_Log;
   pragma Import(C,Z3_Close_Log,"Z3_close_log") ;

   -- Enable/disable printing warning messages to the console.    
   procedure Z3_Toggle_Warning_Messages( Enabled : in Z3_Bool );
   pragma Import(C,Z3_Toggle_Warning_Messages,"Z3_toggle_warning_messages") ;
  
   -----------------------
   -- String conversion --
   -----------------------
   
   -- Select mode for the format used for pretty-printing AST nodes. 
   procedure Z3_Set_Ast_Print_Node(C:in Z3_Context;Mode:in Z3_Ast_Print_Mode);
   pragma Import(C,Z3_Set_Ast_Print_Node,"Z3_set_ast_print_mode");
 	
   -- Convert the given AST node into a string. 
   function Z3_Ast_To_String(C:in Z3_Context;A:in Z3_Ast) return Z3_String;
   pragma Import(C,Z3_Ast_To_String,"Z3_ast_to_string");
 
   function Z3_Pattern_To_String(C:in Z3_Context;P:in Z3_Pattern) return Z3_String;
   pragma Import(C,Z3_Pattern_To_String,"Z3_pattern_to_string");
   
   function Z3_Sort_To_String(C:in Z3_Context;S:in Z3_Sort) return Z3_String;
   pragma Import(C,Z3_Sort_To_String,"Z3_sort_to_string");
   
   function Z3_Func_Decl_To_String(C:in Z3_Context;D:in Z3_Func_Decl) return Z3_String;
   pragma Import(C,Z3_Func_Decl_To_String,"Z3_func_decl_to_string");
   
   -- Convert the given model into a string. 
   function Z3_Model_To_String(C:in Z3_Context;M:in Z3_Model) return Z3_String;
   pragma Import(C,Z3_Model_To_String,"Z3_model_to_string");
   
   -- Convert the given benchmark into SMT-LIB formatted string. 
   function Z3_Benchmark_To_Smtlib_String( C : in Z3_Context;
					   Name : in Z3_String;
					   Logic : in Z3_String;
					   Status : in Z3_String;
					   Attributes : in Z3_String;
					   Num_Assumptions : in Interfaces.C.Unsigned;
					   Assumptions : in Z3_Ast_Array;
					   Formula : in Z3_Ast) return Z3_String;
   pragma Import(C,Z3_Benchmark_To_Smtlib_String,"Z3_benchmark_to_smtlib_string"); 
   
   
end Z3.Logs_And_Strings ;
