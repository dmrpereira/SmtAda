with Interfaces.C, Interfaces.C.Strings;
with System;

package Z3.Configurations is
   
   --------------------
   -- Configurations --
   --------------------
   
   -- Create a configuration. --
   function Z3_Mk_Config return Z3_Config;
   pragma Import(C,Z3_Mk_Config,"Z3_mk_config");
   
   -- Delete the given configuration object.
   procedure Z3_Del_Config(C:in Z3_Config);
   pragma Import(C,Z3_Del_Config,"Z3_del_config");
   
   -- Set a configuration parameter
   procedure Z3_Set_Param_Value(C:in Z3_Config;Param_Id:in Z3_String;Param_Value:in Z3_String);
   pragma Import(C,Z3_Set_Param_Value,"Z3_set_param_value");
   
   
end Z3.Configurations;
