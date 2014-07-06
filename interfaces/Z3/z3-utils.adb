package body Z3.Utils is
   
   function Z3_String_To_String( S : in Z3_String ) return String is
   begin
      return Interfaces.C.Strings.Value(Interfaces.C.Strings.Chars_Ptr( S ));
   end Z3_String_To_String ;
					
   function String_To_Z3_String( S : in String ) return Z3_String is
   begin
      return Z3_String( Interfaces.C.Strings.New_String(S) );
   end String_To_Z3_String ;
   
end Z3.Utils ;
