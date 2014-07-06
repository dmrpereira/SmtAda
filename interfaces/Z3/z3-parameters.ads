with Interfaces.C, Interfaces.C.Strings;
with System;

package Z3.Parameters is
   
    -- Create a Z3 (empty) parameter set.
   function Z3_Mk_Params(C:in Z3_Context) return Z3_Params;
   pragma Import(C,Z3_Mk_Params,"Z3_mk_params");
   
   procedure Z3_Params_Inc_Ref(C:in Z3_Context;P:in Z3_Params);
   pragma Import(C,Z3_Params_Inc_Ref,"Z3_params_inc_ref");
   
   procedure Z3_Params_Dec_Ref(C:in Z3_Context;P:in Z3_Params);
   pragma Import(C,Z3_Params_Dec_Ref,"Z3_params_dec_ref");
   
   -- Add a Boolean parameter k with value v to the parameter set p
   procedure Z3_Params_Set_Bool(C:in Z3_Context;P:in Z3_Params;K:in Z3_Symbol;V:in Z3_Bool);
   pragma Import(C,Z3_Params_Set_Bool,"Z3_params_set_bool");
   
   -- Add a unsigned parameter k with value v to the parameter set p.
   procedure Z3_Params_Set_Uint(C:in Z3_Context;P:in Z3_Params;K:in Z3_Symbol;V:in Interfaces.C.Unsigned);
   pragma Import(C,Z3_Params_Set_Uint,"Z3_params_set_uint");
   
   -- Add a double parameter k with value v to the parameter set p.
   procedure Z3_Params_Set_Double(C:in Z3_Context;P:in Z3_Params;K:in Z3_Symbol;V:in Interfaces.C.Double);
   pragma Import(C,Z3_Params_Set_Double,"Z3_params_set_double");
   
   -- Add a symbol parameter k with value v to the parameter set p.
   procedure Z3_Params_Set_Symbol(C:in Z3_Context;P:in Z3_Params;K:in Z3_Symbol;V:in Z3_Symbol);
   pragma Import(C,Z3_Params_Set_Symbol,"Z3_params_set_symbol");
   
   -- Convert a parameter set into a string. This function is mainly used for printing the
   -- contents of a parameter set.
   function Z3_Params_To_String(C:in Z3_Context;P:in Z3_Params) return Z3_String;
   pragma Import(C,Z3_Params_To_String,"Z3_params_to_string");
   
   -- Validate the parameter set p against the parameter description set d.
   procedure Z3_Params_Validate(C:in Z3_Context;P:in Z3_Params;D:in Z3_Param_Descrs);
   pragma Import(C,Z3_Params_Validate,"Z3_params_validate");
   
   procedure Z3_Param_Descrs_Inc_Ref(C:in Z3_Context;P:in Z3_Param_Descrs);
   pragma Import(C,Z3_Param_Descrs_Inc_Ref,"Z3_params_descrs_inc_ref");
   
   procedure Z3_Param_Descrs_Dec_Ref(C:in Z3_Context;P:in Z3_Param_Descrs);
   pragma Import(C,Z3_Param_Descrs_Dec_Ref,"Z3_params_descrs_dec_ref");
   
   -- Return the kind associated with the given parameter name c n.
   function Z3_Param_Descrs_Get_Kind(C:in Z3_Context;P:in Z3_Param_Descrs;N:in Z3_Symbol) return Z3_Param_Kind;
   pragma Import(C,Z3_Param_Descrs_Get_Kind,"Z3_param_descrs_get_kind");
   
   -- Return the number of parameters in the given parameter description set.
   function Z3_Param_Descrs_Size(C:in Z3_Context;P:in Z3_Param_Descrs) return Interfaces.C.Unsigned;
   pragma Import(C,Z3_Param_Descrs_Size,"Z3_param_descrs_size");
   
   -- Return the number of parameters in the given parameter description set.
   function Z3_Param_Descrs_Get_Name(C:in Z3_Context;P:in Z3_Param_Descrs;I:in Interfaces.C.Unsigned) return Z3_Symbol;
   pragma Import(C,Z3_Param_Descrs_Get_Name,"Z3_param_descrs_get_name");
   
   -- Convert a parameter description set into a string. This function is mainly used for printing the
   -- contents of a parameter description set.
   function Z3_Param_Descrs_To_String(C:in Z3_Context;P:in Z3_Param_Descrs) return Z3_String;
   pragma Import(C,Z3_Param_Descrs_To_String,"Z3_param_descrs_to_string");
   
   
end Z3.Parameters;
