with Interfaces.C; use Interfaces.C;
with System;

package Cvc4_Defs is 

   type VC is new System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface_defs.h:41

   type Context is new System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface_defs.h:42

   type ExprManager is new System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface_defs.h:43

   type Flags is new System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface_defs.h:44

   type Expr is new System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface_defs.h:46

   type Op is new System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface_defs.h:47

   type c_Type is new System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface_defs.h:48

   type Proof is new System.Address;  -- /opt/local/include/cvc4/bindings/compat/c/c_interface_defs.h:49

end Cvc4_Defs ;
