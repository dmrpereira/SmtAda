with Interfaces.C, Interfaces.C.Strings;
with System;

package Z3.Bvectors is
   
   -----------------
   -- Bit-vectors --
   -----------------
   
   --  	Bitwise negation. 
   function Z3_Mk_Bvnot( C : in Z3_Context ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvnot,"Z3_mk_bvnot");

   -- 	Take conjunction of bits in vector, return vector of length 1.  
   function Z3_Mk_Bvredand( C : in Z3_Context ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvredand,"Z3_mk_bvredand");
   
   -- Take disjunction of bits in vector, return vector of length 1. 
   function Z3_Mk_Bvredor( C : in Z3_Context ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvredor,"Z3_mk_bvredor");

   -- Bitwise and. 
   function Z3_Mk_Bvand( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvand,"Z3_mk_bvand"); 
 
   -- Bitwise or. 
   function Z3_Mk_Bvor( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvor,"Z3_mk_bvor");
   
   -- Bitwise exclusive-or. 
   function Z3_Mk_Bvxor( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvxor,"Z3_mk_bvxor");

   -- Bitwise nand. 
   function Z3_Mk_Bvnand( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvnand,"Z3_mk_bvnand");

   -- Bitwise nor
   function Z3_Mk_Bvnor( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvnor,"Z3_mk_bvnor");

   -- Bitwise xnor. 
   function Z3_Mk_Bvxnor( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvxnor,"Z3_mk_bvxnor");
   
   -- Standard two's complement unary minus. 
   function Z3_Mk_Bvneg( C : in Z3_Context ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvneg,"Z3_mk_bvneg");
   
   -- Standard two's complement addition.    
   function Z3_Mk_Bvadd( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvadd,"Z3_mk_bvadd");

   -- Standard two's complement subtraction.    
   function Z3_Mk_Bvsub( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsub,"Z3_mk_bvsub");

   -- Standard two's complement multiplication. 
   function Z3_Mk_Bvmul( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvmul,"Z3_mk_bvmul");
      
   -- Unsigned division.    
   function Z3_Mk_Bvudiv( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvudiv,"Z3_mk_bvudiv");

   -- Two's complement signed division.       
   function Z3_Mk_Bvsdiv( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsdiv,"Z3_mk_bvsdiv");

   -- Unsigned remainder. 
   function Z3_Mk_Bvurem( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvurem,"Z3_mk_bvurem");

   -- Two's complement signed remainder (sign follows dividend).       
   function Z3_Mk_Bvsrem( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsrem,"Z3_mk_bvsrem");

   -- Two's complement signed remainder (sign follows divisor).    
   function Z3_Mk_Bvsmod( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsmod,"Z3_mk_bvsmod");

   -- Unsigned less than.       
   function Z3_Mk_Bvult( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvult,"Z3_mk_bvult");

   -- Two's complement signed less than. 
   function Z3_Mk_Bvslt( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvslt,"Z3_mk_bvslt");
      
   -- Unsigned less than or equal to.    
   function Z3_Mk_Bvule( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvule,"Z3_mk_bvule");

   -- Two's complement signed less than or equal to. 
   function Z3_Mk_Bvsle( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsle,"Z3_mk_bvsle");

   -- Unsigned greater than or equal to.       
   function Z3_Mk_Bvuge( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvuge,"Z3_mk_bvuge");

   -- Two's complement signed greater than or equal to.       
   function Z3_Mk_Bvsge( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsge,"Z3_mk_bvsge");

   -- Unsigned greater than. 
   function Z3_Mk_Bvugt( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvugt,"Z3_mk_bvugt");
      
   -- Two's complement signed greater than.    
   function Z3_Mk_Bvsgt( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsgt,"Z3_mk_bvsgt");
   
   -- Concatenate the given bit-vectors. 
   function Z3_Mk_Concat( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Concat,"Z3_mk_concat");
   
   -- Extract the bits high down to low from a bitvector of size m to yield a new bitvector of size n, where n = high - low + 1. 
   function Z3_Mk_Extract( C : in Z3_Context ; High, Low : in Interfaces.C.Unsigned ; T1 : Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Extract,"Z3_mk_extract");

   -- Sign-extend of the given bit-vector to the (signed) equivalent bitvector of size m+i, where m is the size of the given bit-vector. 
   function Z3_Mk_Sign_Ext( C : in Z3_Context ; I : in Interfaces.C.Unsigned ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Sign_Ext,"Z3_mk_sign_ext");
   
   -- Extend the given bit-vector with zeros to the (unsigned) equivalent bitvector of size m+i, where m is the size of the given bit-vector.    
   function Z3_Mk_Zero_Ext( C : in Z3_Context ; I : in Interfaces.C.Unsigned ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Zero_Ext,"Z3_mk_zero_ext");

   -- Repeat the given bit-vector up length i.       
   function Z3_Mk_Repeat( C : in Z3_Context ; I : in Interfaces.C.Unsigned ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Repeat,"Z3_mk_repeat");

   -- Shift left. 
   function Z3_Mk_Bvshl( C : in Z3_Context ; T1, T2 : Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvshl,"Z3_mk_bvshl");

   -- Logical shift right.  
   function Z3_Mk_Bvlshr(  C : in Z3_Context ; T1, T2 : Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvlshr,"Z3_mk_bvlshr");

   -- Arithmetic shift right.  
   function Z3_Mk_Bvashr(  C : in Z3_Context ; T1, T2 : Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvashr,"Z3_mk_bvashr");

   -- Rotate bits of t1 to the left i times. 	 
   function Z3_Mk_Rotate_Left( C : in Z3_Context ; I : in Interfaces.C.Unsigned ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Rotate_Left,"Z3_mk_rotate_left");

   -- Rotate bits of t1 to the right i times. 	    
   function Z3_Mk_Rotate_Right( C : in Z3_Context ; I : in Interfaces.C.Unsigned ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Rotate_Right,"Z3_mk_rotate_right");

   -- Rotate bits of t1 to the left t2 times. 	       
   function Z3_Mk_Ext_Rotate_Left( C : in Z3_Context ; T1, T2 : Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Ext_Rotate_Left,"Z3_mk_ext_rotate_left");

   -- Rotate bits of t1 to the right t2 times.  
   function Z3_Mk_Ext_Rotate_Right(  C : in Z3_Context ; T1, T2 : Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Ext_Rotate_Right,"Z3_mk_ext_rotate_right");

   -- Create an n bit bit-vector from the integer argument t1. 	       
   function Z3_Mk_Int2bv( C : in Z3_Context ; I : in Interfaces.C.Unsigned ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Int2bv,"Z3_mk_int2bv");
   
   -- Create an integer from the bit-vector argument t1. 
   -- If is_signed is false, then the bit-vector t1 is treated as unsigned. 
   -- So the result is non-negative and in the range [0..2^N-1], where N are the number of bits in t1.
   -- If is_signed is true, t1 is treated as a signed bit-vector. 
   function Z3_Mk_Bv2int( C : in Z3_Context ; T1 : in Z3_Ast ; Is_Signed : Z3_Bool ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bv2int,"Z3_mk_bv2int");
   
   -- Create a predicate that checks that the bit-wise addition of t1 and t2 does not overflow. 
   function Z3_Mk_Bvadd_No_Overflow( C : in Z3_Context ; T1, T2 : in Z3_Ast ; Is_Signed : in Z3_Bool ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvadd_No_Overflow,"Z3_mk_bvadd_no_overflow");

   -- Create a predicate that checks that the bit-wise signed addition of t1 and t2 does not underflow.  
   function Z3_Mk_Bvadd_No_Underflow( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvadd_No_Underflow,"Z3_mk_bvadd_no_underflow");

   -- Create a predicate that checks that the bit-wise signed subtraction of t1 and t2 does not overflow.  
   function Z3_Mk_Bvsub_No_Overflow( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsub_No_Overflow,"Z3_mk_bvsub_no_overflow");

   -- Create a predicate that checks that the bit-wise subtraction of t1 and t2 does not underflow. 
   function Z3_Mk_Bvsub_No_Underflow( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsub_No_Underflow,"Z3_mk_bvsub_no_underflow");
   
   -- Create a predicate that checks that the bit-wise signed division of t1 and t2 does not overflow. 
   function Z3_Mk_Bvsdiv_No_Overflow( C : in Z3_Context ; T1, T2 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvsdiv_No_Overflow,"Z3_mk_bvsdiv_no_overflow");
   
   -- Check that bit-wise negation does not overflow when t1 is interpreted as a signed bit-vector.    
   function Z3_Mk_Bvneg_No_Overflow( C : in Z3_Context ; T1 : in Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvneg_No_Overflow,"Z3_mk_bvneg_no_overflow");

   -- Create a predicate that checks that the bit-wise multiplication of t1 and t2 does not overflow.  
   function Z3_Mk_Bvmul_No_Overflow( C : in Z3_Context ; T1, T2 : in Z3_Ast ; Is_Signed : in Z3_Bool ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvmul_No_Overflow,"Z3_mk_bvmul_no_overflow");

   -- Create a predicate that checks that the bit-wise signed multiplication of t1 and t2 does not underflow.  
   function Z3_Mk_Bvmul_No_Underflow( C : in Z3_Context ; T1, T2 : Z3_Ast ) return Z3_Ast;
   pragma Import(C,Z3_Mk_Bvmul_No_Underflow,"Z3_mk_bvmul_no_underflow");
   
   
   
end Z3.Bvectors;

