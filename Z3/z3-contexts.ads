with Interfaces.C, Interfaces.C.Strings;
with System;

package Z3.Contexts is
   
    -- Create context
   function Z3_Mk_Context(C:in Z3_Config) return Z3_Context;
   pragma Import(C,Z3_Mk_Context,"Z3_mk_context");
   
   function Z3_Mk_Context_Rc(C:in Z3_Config) return Z3_Context;
   pragma Import(C,Z3_Mk_Context_Rc,"Z3_mk_context_rc");
   
   -- Delete the given logical context.
   procedure Z3_Del_Context(C:in Z3_Context);
   Pragma Import(C,Z3_Del_Context,"Z3_del_context");
   
   -- Increment the reference counter of the given AST.
   procedure Z3_Inc_Ref(C:in Z3_Context;A:in Z3_Ast);
   pragma Import(C,Z3_Inc_Ref,"Z3_inc_ref");
   
   -- Decrement the reference counter of the given AST.
   procedure Z3_Dec_Ref(C:in Z3_Context;A:in Z3_Ast);
   pragma Import(C,Z3_Dec_Ref,"Z3_dec_ref");
   
   -- Update a mutable configuration parameter.
   procedure Z3_Update_Param_Value(C:in Z3_Context;Param_Id:in Z3_String;Param_Value:in Z3_String);
   pragma Import(C,Z3_Update_Param_Value,"Z3_update_param_value");
   
   -- Get a configuration parameter.
   function Z3_Get_Param_Value(C:in Z3_Context;Param_Id:in Z3_String;Param_Value:out Z3_String_Ptr) return Z3_Bool_Opt;
   pragma Import(C,Z3_Get_Param_Value,"Z3_get_param_value");
   
   -- Interrupt the execution of a Z3 procedure.
   procedure Z3_Interrupt(C:in Z3_Context);
   pragma Import(C,Z3_Interrupt,"Z3_interrupt");
   
end Z3.Contexts;
