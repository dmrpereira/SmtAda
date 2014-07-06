with Interfaces.C, Interfaces.C.Strings;
with System;

package Z3.Symbols_And_Sorts is
   
      -- Create a Z3 symbol using an integer
   function Z3_Mk_Int_Symbol(C:in Z3_Context;I:in Interfaces.C.Int) return Z3_Symbol;
   pragma Import(C,Z3_Mk_Int_Symbol,"Z3_mk_int_symbol");
   
   -- Create a Z3 symbol using a C string.
   function Z3_Mk_String_Symbol(C:in Z3_Context;S:in Z3_String) return Z3_Symbol;
   pragma Import(C,Z3_Mk_String_Symbol,"Z3_mk_string_symbol");
   
   -- Create a free (uninterpreted) type using the given name (symbol).
   function Z3_Mk_Uninterpreted_Sort(C:in Z3_Context;S:in Z3_Symbol) return Z3_Sort;
   pragma Import(C,Z3_Mk_Uninterpreted_Sort,"Z3_mk_uninterpreted_sort");
   
   -- Create the Boolean type.
   function Z3_Mk_Bool_Sort(C:in Z3_Context) return Z3_Sort;
   pragma Import(C,Z3_Mk_Bool_Sort,"Z3_mk_bool_sort");
   
   -- Create the integer type.
   function Z3_Mk_Int_Sort(C:in Z3_Context) return Z3_Sort;
   pragma Import(C,Z3_Mk_Int_Sort,"Z3_mk_int_sort");
   
   -- Create the real type.
   function Z3_Mk_Real_Sort(C:in Z3_Context) return Z3_Sort;
   pragma Import(C,Z3_Mk_Real_Sort,"Z3_mk_real_sort");
   
   -- Create a bit-vector type of the given size.
   function Z3_Mk_Bv_Sort(C:in Z3_Context;Sz:in Interfaces.C.Unsigned) return Z3_Sort;
   pragma Import(C,Z3_Mk_Bv_Sort,"Z3_mk_bv_sort");
   
   -- Create a named finite domain sort.
   function Z3_Mk_Finite_Domain_Sort(C:in Z3_Context;Name:in Z3_Symbol;Size:in Interfaces.C.Unsigned_Long) return Z3_Sort;
   pragma Import(C,Z3_Mk_Finite_Domain_Sort,"Z3_mk_finite_domain_sort");

   -- Create an array type.
   function Z3_Mk_Array_Sort(C:in Z3_Context;Domain:in Z3_Sort;Rg:in Z3_Sort) return Z3_Sort;
   pragma Import(C,Z3_Mk_Array_Sort,"Z3_mk_array_sort");
   
   -- Create a tuple type.
   function Z3_Mk_Tuple_Sort(C:in Z3_Context;
			     Mk_Tuple_Name:in Z3_Symbol;
			     Num_Fields:in Interfaces.C.Unsigned;
			     Field_Names:in Z3_Symbol_Array;
			     Field_Sorts:in Z3_Sort_Array;
			     Mk_Tuple_Decl:in Z3_Func_Decl_Access;
			     Proj_Decl:in Z3_Func_Decl_Array) return Z3_Sort;
   pragma Import(C,Z3_Mk_Tuple_Sort,"Z3_mk_tuple_sort");
   
   -- Create a enumeration sort.
   function Z3_Mk_Enumeration_Sort(C:in Z3_Context;
				   Name:in Z3_Symbol;
				   N:in Interfaces.C.Unsigned;
				   Enum_Names:in Z3_Symbol_Array;
				   Enum_Consts:in Z3_Func_Decl_Array;
				   Enum_Testers:in Z3_Func_Decl_Array) return Z3_Sort;
   pragma Import(C,Z3_Mk_Enumeration_Sort,"Z3_mk_enumeration_sort");
   
   -- Create a list sort
   function Z3_Mk_List_Sort(C:in Z3_Context;
			    Name:in Z3_Symbol;
			    Elem_Sort:in Z3_Sort;
			    Nil_Decl:out Z3_Func_Decl_Access;
			    Is_Nil_Decl:out Z3_Func_Decl_Access;
			    Cons_Decl:out Z3_Func_Decl_Access;
			    Is_Cons_decl:out Z3_Func_Decl_Access;
			    Head_decl:out Z3_Func_Decl_Access;
			    Tail_decl:out Z3_Func_Decl_Access) return Z3_Sort;
   pragma Import(C,Z3_Mk_List_Sort,"Z3_mk_list_sort");
    
   -- Create a constructor.
   function Z3_Mk_Constructor(C:in Z3_Context;
			      Name:in Z3_Symbol;
			      Recognizer:in Z3_Symbol;
			      Num_Fields:in Interfaces.C.Unsigned;
			      Field_Names:in Z3_Symbol_Array;
			      Sorts:in Z3_Sort_Opt_Array;
			      Sort_Refs:in Unsigned_Array) return Z3_Constructor;
   pragma Import(C,Z3_Mk_Constructor,"Z3_mk_constructor");
   
   --  Reclaim memory allocated to constructor.
   procedure Z3_Del_Constructor(C:in Z3_Context;Constr:in Z3_Constructor);
   pragma Import(C,Z3_Del_Constructor,"Z3_del_constructor");
   
      
   --  Create datatype, such as lists, trees, records, enumerations or unions of records. 
   --  The datatype may be recursive. Return the datatype sort.
   function Z3_Mk_Datatype(C:in Z3_Context;
			   Name:in Z3_Symbol;
			   Num_Constructor:in Interfaces.C.Unsigned;
			   Construtors:in out Z3_Constructor_Array) return Z3_Sort;
   pragma Import(C,Z3_Mk_Datatype,"Z3_mk_datatype");
   
   --  Create list of constructors.
   function Z3_Mk_Constructor_List( C:in Z3_Context;
				    Num_Constructors: in Interfaces.C.Unsigned;
				    Constructors: in out Z3_Constructor_Array) return Z3_Constructor_List;
   pragma Import(C,Z3_Mk_Constructor_List,"Z3_mk_constructor_list");
   
   
   --  Reclaim memory allocated for constructor list.
   procedure Z3_Del_Constructor_List(C:in Z3_Context;Clist:in Z3_Constructor_List);
   pragma Import(C,Z3_Del_Constructor_List,"Z3_del_constructor_list");
   
   --  Create mutually recursive datatypes.
   procedure Z3_Mk_Datatypes( C:in Z3_Context;
			      Num_Sorts: in Interfaces.C.Unsigned;
			      Sort_Names: in Z3_Symbol_Array;
			      Sorts: out Z3_Sort_Array;
			      Constructor_List: in out Z3_Constructor_List);
   pragma Import(C,Z3_Mk_Datatypes,"Z3_mk_datatypes");
   
   -- Query constructor for declared functions.
   procedure Z3_Query_Constructor(C:in Z3_Context;
				  Constr:in Z3_Constructor;
				  Num_Fields:in Interfaces.C.Unsigned;
				  Constructor:out Z3_Func_Decl_Access;
				  Tester:out Z3_Func_Decl_Access;
				  Accessors:out Z3_Func_Decl_Array);
   pragma Import(C,Z3_Query_Constructor,"Z3_query_constructor");
   
   
end Z3.Symbols_And_Sorts;
