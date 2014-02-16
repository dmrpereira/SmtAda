with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3.Utils is
   
   function Z3_String_To_String( S : in Z3_String ) return String ;
   
   function String_To_Z3_String( S : in String ) return Z3_String ;
   
   
end Z3.Utils;
