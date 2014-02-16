with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3.Numerals is
   
   --------------
   -- Numerals --
   --------------
   
   -- Create a numeral of a given sort.    
   function Z3_Mk_Numeral( C : in Z3_Context ; Numeral : in Z3_String ; Ty : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Numeral,"Z3_mk_numeral") ;

   -- Create a real from a fraction. 
   function Z3_Mk_Real( C : in Z3_Context ; Num, Den : in Interfaces.C.Int ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Real,"Z3_mk_real") ;
 
   -- Create a numeral of an int, bit-vector, or finite-domain sort.    
   function Z3_Mk_Int( C : in Z3_Context ; V : in Interfaces.C.Int ; Ty : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Int,"Z3_mk_int") ;

   -- Create a numeral of a int, bit-vector, or finite-domain sort.  
   function Z3_Mk_Unsigned_Int( C : in Z3_Context ; V : in Interfaces.C.Unsigned ; Ty : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Unsigned_Int,"Z3_mk_unsigned_int") ;

   -- Create a numeral of a int, bit-vector, or finite-domain sort.  
   function Z3_Mk_Int64( C : in Z3_Context ; V : in Interfaces.C.Long ; Ty : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Int64,"Z3_mk_int64") ;

   -- Create a numeral of a int, bit-vector, or finite-domain sort.  
   function Z3_Mk_Unsigned_Int64( C : in Z3_Context ; V : in Interfaces.C.Unsigned_Long ; Ty : in Z3_Sort ) return Z3_Ast ;
   pragma Import(C,Z3_Mk_Unsigned_Int64,"Z3_mk_unsigned_int64") ;
     
end Z3.Numerals ;
 



   
   
   
