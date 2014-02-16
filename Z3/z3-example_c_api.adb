
package body Z3.Example_C_Api is

   -- exit gracefully in case of error.
   procedure Exit_F( S : in String ) is
   begin
      Put(S);
      New_Line;
      GNAT.OS_Lib.OS_Exit(1);
   end Exit_F;

   -- exit if unreachable code was reached.
   procedure Unreachable is
   begin
      Exit_F("unreachable code was reached");
   end Unreachable ;

   -- Simpler error handler.
   procedure Error_Handler( C : Z3_Context ; E : Z3_Error_Code ) is
   begin
      Ada.Text_Io.Put("Error code: " & E'Img) ;
      Exit_F("incorrect use of Z3");
   end Error_Handler;

   procedure Throw_Z3_Error( C : in Z3_Context ; E : in  Z3_Error_Code )  is
      function Rep is new Ada.Unchecked_Conversion(Z3_Error_Code, Interfaces.C.Int);
   begin
      Longjump(G_Catch_Buffer, Rep(E));
   end Throw_Z3_Error ;

   -- Create a logical context.
   -- Enable model construction. Other configuration parameters can be passed in the cfg variable.
   -- Also enable tracing to stderr and register custom error handler.
   -- CANNOT DEFINE ACCESS PROCEDURE TYPE AS I WISHED! MUST FULLY UNDERSTAND WHY :-S
   function Mk_Context_Custom( Cfg : in Z3_Config ; Err : access procedure( Arg1 : in Z3_Context ; Arg2 : in Z3_Error_Code ) ) return Z3_Context is
      Ctx : Z3_Context ;
      Param_Id : Z3_String := Z3_String(Interfaces.C.Strings.New_String("MODEL")) ;
      Param_Value : Z3_String := Z3_String(Interfaces.C.Strings.New_String("true")) ;
   begin
      Z3_Set_Param_Value(Cfg,Param_Id,Param_Value);
      Ctx := Z3_Mk_Context(Cfg);
      Z3_Set_Error_Handler( Ctx , Err ) ;
      return Ctx;
   end Mk_Context_Custom ;

   -- Create a logical context.
   -- Enable model construction only.
   -- Also enable tracing to stderr and register standard error handler.
   function Mk_Context return Z3_Context is
      Cfg : Z3_Config ;
      Ctx : Z3_Context ;
   begin
      Cfg := Z3_Mk_Config;
      Ctx := Mk_Context_Custom(Cfg,Error_Handler'Access);
      Z3_Del_Config(Cfg);
      return Ctx ;
   end Mk_Context ;

   -- Create a logical context.
   -- Enable fine-grained proof construction.
   -- Enable model construction.
   --
   -- Also enable tracing to stderr and register standard error handler.
   function Mk_Proof_Context return Z3_Context is
      Cfg : Z3_Config := Z3_Mk_Config ;
      Ctx : Z3_Context ;
      Param_Id : Z3_String := Z3_String(Interfaces.C.Strings.New_String("PROOF_MODE")) ;
      Param_Value : Z3_String := Z3_String(Interfaces.C.Strings.New_String("2")) ;
   begin
      Z3_Set_Param_Value(Cfg,Param_Id,Param_Value);
      Ctx := Mk_Context_Custom(Cfg,Throw_Z3_Error'Access); -- still to figure out how to bind l
      Z3_Del_Config(Cfg);
      return Ctx ;
   end Mk_Proof_Context ;

   -- Create a variable using the given name and type.
   function Mk_Var( Ctx : in Z3_Context ; Name : in String ; Ty : in Z3_Sort ) return Z3_Ast is
      S : Z3_Symbol := Z3_Mk_String_Symbol( Ctx , Z3_String(Interfaces.C.Strings.New_String(Name)) );
   begin
      return Z3_Mk_Const( Ctx , S , Ty ) ;
   end Mk_Var ;

   -- Create a boolean variable using the given name.
   function Mk_Bool_Var( Ctx : in Z3_Context ; Name : in String ) return Z3_Ast is
      Ty : Z3_Sort := Z3_Mk_Bool_Sort( Ctx ) ;
   begin
      return Mk_Var( Ctx , Name , Ty );
   end Mk_Bool_Var ;

   -- Create an integer variable using the given name.
   function Mk_Int_Var( Ctx : in Z3_Context ; Name : in String ) return Z3_Ast is
      Ty : Z3_Sort := Z3_Mk_Int_Sort( Ctx );
   begin
      return Mk_Var( Ctx , Name , Ty );
   end Mk_Int_Var ;

   -- Create a Z3 integer node using a C int.
   function Mk_Int( Ctx : in Z3_Context ; V : Integer ) return Z3_Ast is
      Ty : Z3_Sort := Z3_Mk_Int_Sort( Ctx ) ;
   begin
      return Z3_Mk_Int( Ctx , Interfaces.C.Int(V) , Ty ) ;
   end Mk_Int ;

   -- Create a real variable using the given name.
   function Mk_Real_Var( Ctx : in Z3_Context ; Name : String ) return Z3_Ast is
      Ty : Z3_Sort := Z3_Mk_Real_Sort( Ctx ) ;
   begin
      return Mk_Var( Ctx , Name , Ty );
   end Mk_Real_Var ;

   -- Create the unary function application: <tt>(f x)</tt>.
   function Mk_Unary_App( Ctx : in Z3_Context ; F : in Z3_Func_Decl ; X : in Z3_Ast ) return Z3_Ast is
      Args : Z3_Ast_Array := ( 0 => X ) ;
   begin
      return Z3_Mk_App( Ctx , F , 1 , Args ) ;
   end Mk_Unary_App ;

   -- Create the binary function application: <tt>(f x y)</tt>.
   function Mk_Binary_App( Ctx : in Z3_Context ; F : in Z3_Func_Decl ; X, Y : in Z3_Ast ) return Z3_Ast is
      Args : Z3_Ast_Array := ( 0 => X , 1 => Y ) ;
   begin
      return Z3_Mk_App( Ctx , F , 2 , Args ) ;
   end Mk_Binary_App ;

   -- Check whether the logical context is satisfiable, and compare the result with the expected result.
   -- If the context is satisfiable, then display the model.
   procedure Check( Ctx : in Z3_Context ; Expected_Result : in Z3_Lbool ) is
      M : Z3_Model := Z3_Model(System.Null_Address) ;
      Result : Z3_Lbool := Z3_Check_And_Get_Model( Ctx , M ) ;
   begin
      case Result is
	 when Z3_L_False =>
	    Put("unsat");
	    New_Line;
	 when Z3_L_Undef =>
	    Put("unknown");
	    New_Line;
	 when Z3_L_True =>
	    Put("sat");
	    New_Line;
	    Put(Z3_String_To_String(Z3_Model_To_String(Ctx,M)));
	    New_Line;
      end case;

      if M /= Z3_Model(System.Null_Address) then
	 Z3_Del_Model(Ctx,M);
      end if;

      if Result /= Expected_Result then
	 Exit_F("unexpected result");
      end if;

   end Check ;

   -- Prove that the constraints already asserted into the logical
   -- context implies the given formula.  The result of the proof is
   -- displayed.
   --
   -- Z3 is a satisfiability checker. So, one can prove [f] by showing
   -- that [ not f ] is unsatisfiable.

   -- The context [ctx] is not modified by this function.
   procedure Prove( Ctx : in Z3_Context ; F : in Z3_Ast ; Is_Valid : Z3_Bool ) is
      M : Z3_Model := Z3_Model(System.Null_Address) ;
      Not_F : Z3_Ast ;
   begin
      Z3_Push(Ctx) ;

      Not_F := Z3_Mk_Not(Ctx,F);
      Z3_Assert_Cnstr(Ctx,Not_F);

      case Z3_Check_And_Get_Model(Ctx,M) is
	 when Z3_L_False =>
	    Put("valid");
	    New_Line;
	    if Is_Valid = 0 then
	       Exit_F("unexpected result");
	    end if;
	 when Z3_L_Undef =>
	    Put("unknown");
	    New_Line ;
	    if M /= Z3_Model(System.Null_Address) then
	       Put("potential counterexample: ");
	       Put(Z3_String_To_String(Z3_Model_To_String(Ctx,M)));
	       New_Line;
	    end if;
	 when Z3_L_True =>
	    Put("invalid");
	    New_Line;
	    if M /= Z3_Model(System.Null_Address) then
	       Put("counterexample: ");
	       Put(Z3_String_To_String(Z3_Model_To_String(Ctx,M)));
	       New_Line;
	    end if;
	    if Is_Valid = 1 then
	       Exit_F("unexpected result");
	       New_Line;
	    end if;
	    null;
      end case;

      if M /= Z3_Model(System.Null_Address) then
	 Z3_Del_Model(Ctx,M);
      end if;

      Z3_Pop(Ctx,1);

   end Prove;

   -- Assert the axiom: function f is injective in the i-th argument.
   --
   -- The following axiom is asserted into the logical context:
   -- \code
   -- forall (x_0, ..., x_n) finv(f(x_0, ..., x_i, ..., x_{n-1})) = x_i
   -- \endcode
   -- Where, finv is a fresh function declaration.
   procedure Assert_Inj_Axiom( Ctx : in Z3_Context ; F : in Z3_Func_Decl ; I : in Interfaces.C.Unsigned ) is
      Sz : Interfaces.C.Unsigned := Z3_Get_Domain_Size(Ctx,F) ;
      Finv_Domain : Z3_Sort_Array(0..1) ;
      Finv_Range : Z3_Sort; --_Array(0..100) ;
      Finv : Z3_Func_Decl ;
      Types : access Z3_Sort_Array := null ;
      Names : access Z3_Symbol_Array := null ;
      Xs : access Z3_Ast_Array := null ;
      X_I, Fxs, Finv_Fxs, Eq : Z3_Ast ;
      --P : Z3_Pattern;
      --Q : Z3_Ast ;
   begin

      if Integer(I) >= Integer(Sz) then
	 Exit_F("failed to create inj axiom");
      end if;

      Finv_Domain(0) := Z3_Get_Range(Ctx,F);
      Finv_Range := Z3_Get_Domain(Ctx,F,I);
      Finv := Z3_Mk_Fresh_Func_Decl(Ctx,String_To_Z3_String("inv"),1,Finv_Domain,Finv_Range);

      -- allocate temporary arrays
      Types := new Z3_Sort_Array( 0 .. Integer(Sz) ) ;
      Names := new Z3_Symbol_Array( 0 .. Integer(Sz) ) ;
      Xs := new Z3_Ast_Array( 0 .. Integer(Sz) ) ;

      -- fill types, names and xs
      for J in Integer range 0 .. Integer(Sz) loop
	 Types(J) := Z3_Get_Domain(Ctx,F,Interfaces.C.Unsigned(J)) ;
	 Names(J) := Z3_Mk_Int_Symbol(Ctx,Interfaces.C.Int(J)) ;
	 Xs(J) := Z3_Mk_Bound(Ctx,Interfaces.C.Unsigned(J),Types(J)) ;
      end loop ;

      X_I := Xs(Integer(I)) ;

      -- create f(x_0, ..., x_i, ..., x_{n-1})
      Fxs := Z3_Mk_App(Ctx,F,Sz,Xs.all) ;

      -- create f_inv(f(x_0, ..., x_i, ..., x_{n-1}))
      Finv_Fxs := Mk_Unary_App(Ctx,Finv,Fxs);

      -- create finv(f(x_0, ..., x_i, ..., x_{n-1})) = x_i
      Eq := Z3_Mk_Eq(Ctx,Finv_Fxs,X_I) ;

      -- P := Z3_Mk_Pattern(Ctx,1,Fxs) ;

   end Assert_Inj_Axiom ;


   --     /* fill types, names and xs */
   --     for (j = 0; j < sz; j++) { types[j] = Z3_get_domain(ctx, f, j); };
   --     for (j = 0; j < sz; j++) { names[j] = Z3_mk_int_symbol(ctx, j); };
   --     for (j = 0; j < sz; j++) { xs[j]    = Z3_mk_bound(ctx, j, types[j]); };

   --     x_i = xs[i];

   --     /* create f(x_0, ..., x_i, ..., x_{n-1}) */
   --     fxs         = Z3_mk_app(ctx, f, sz, xs);

   --     /* create f_inv(f(x_0, ..., x_i, ..., x_{n-1})) */
   --     finv_fxs    = mk_unary_app(ctx, finv, fxs);

   --     /* create finv(f(x_0, ..., x_i, ..., x_{n-1})) = x_i */
   --     eq          = Z3_mk_eq(ctx, finv_fxs, x_i);

   --     /* use f(x_0, ..., x_i, ..., x_{n-1}) as the pattern for the quantifier */
   --     p           = Z3_mk_pattern(ctx, 1, &fxs);
   --     printf("pattern: %s\n", Z3_pattern_to_string(ctx, p));
   --     printf("\n");

   --     /* create & assert quantifier */
   --     q           = Z3_mk_forall(ctx,
   --                                  0, /* using default weight */
   --                                  1, /* number of patterns */
   --                                  &p, /* address of the "array" of patterns */
   --                                  sz, /* number of quantified variables */
   --                                  types,
   --                                  names,
   --                                  eq);
   --     printf("assert axiom:\n%s\n", Z3_ast_to_string(ctx, q));
   --     Z3_assert_cnstr(ctx, q);

   --     /* free temporary arrays */
   --     free(types);
   --     free(names);
   --     free(xs);
   --  }


   procedure Display_Version is
      Major, Minor, Build, Revision : Interfaces.C.Unsigned ;
   begin
      Z3_Get_Version(Major,Minor,Build,Revision);
      Put("Z3 Version: ");
      Put(Major'Img); Put(".") ;
      Put(Minor'Img); Put(".") ;
      Put(Build'Img); Put(".") ;
      Put(Revision'Img) ;
      New_Line;
   end Display_Version;


end Z3.Example_C_Api ;
