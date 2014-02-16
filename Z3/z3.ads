with Interfaces.C, Interfaces.C.Strings;
with Ada.Unchecked_Conversion;
with System;

package Z3 is

   pragma Preelaborate;

   --------------------------------------------------------------------------
   -- Main data structures provided by "z3_api.h". All are opaque pointers --
   --------------------------------------------------------------------------

   -- Configuration object used to initialize logical contexts.
   type Z3_Config is new System.Address;

   -- Manager of all other Z3 objects, global configuration options, etc.
   type Z3_Context is new System.Address;

   -- Lisp-like symbol used to name types, constants, and functions.
   -- A symbol can be created using string or integers.
   type Z3_Symbol is new System.Address;

   -- Abstract syntax tree node.
   -- That is, the data-structure used in Z3 to represent terms, formulas and types.
   type Z3_Ast is new System.Address;

   type Z3_Ast_Access is access all Z3_Ast ;

   subtype Z3_Ast_Opt is Z3_Ast;

   --  Kind of AST used to represent types.
   type Z3_Sort is new System.Address;

   subtype Z3_Sort_Opt is Z3_Sort;

   -- Kind of AST used to represent function symbols.
   type Z3_Func_Decl is new System.Address;

   -- Kind of AST used to represent function applications.
   type Z3_App is new System.Address;

   type Z3_App_Array is array(Integer range <>) of Z3_App ;
   pragma Convention(C,Z3_App_Array);

   -- Kind of AST used to represent pattern and multi-patterns used to guide quantifier
   -- instantiation.
   type Z3_Pattern is new System.Address;

   type Z3_Pattern_Array is array(Integer range <>) of Z3_Pattern;
   pragma Convention(C,Z3_Pattern_Array);

   -- Type constructor for a (recursive) datatype.
   type Z3_Constructor is new System.Address;

   type Z3_Constructor_List is new System.Address;

   -- Parameter set used to configure many components such as: simplifiers, tactics, solvers, etc.
   type Z3_Params is new System.Address;

   type Z3_Param_Descrs is new System.Address;

   -- Model for the constraints asserted into the logical context.
   type Z3_Model is new System.Address;

   -- Interpretation of a function in a model.
   type Z3_Func_Interp is new System.Address;

   -- Representation of the value of a [Z3_func_interp] at a particular point.
   type Z3_Func_Entry is new System.Address;

   -- Context for the recursive predicate solver.
   type Z3_Fixedpoint is new System.Address;

   -- Cector of [Z3_ast] objects.
   type Z3_Ast_Vector is new System.Address;

   -- Mapping from [Z3_ast] to [Z3_ast] objects.
   type Z3_Ast_Map is new System.Address;

   -- Set of formulas that can be solved and/or transformed using tactics and solvers.
   type Z3_Goal is new System.Address;

   -- Basic building block for creating custom solvers for specific problem domains.
   type Z3_Tactic is new System.Address;

   -- Function/predicate used to inspect a goal and collect information that may be used
   -- to decide which solver and/or preprocessing step will be used.
   type Z3_Probe is new System.Address;

   -- Collection of subgoals resulting from applying of a tactic to a goal.
   type Z3_Apply_Result is new System.Address;

   -- (incremental) solver, possibly specialized by a particular tactic or logic.
   type Z3_Solver is new System.Address;

   -- Statistical data for a solver.
   type Z3_Stats is new System.Address;


   ---------------------
   -- Booleans --
   ---------------------

   Z3_TRUE : constant Interfaces.C.Int := 1;
   Z3_FALSE : constant Interfaces.C.Int := 0;


   type Z3_Bool is new Interfaces.C.Int;

   subtype Z3_Bool_Opt is Z3_Bool;


   ---------------------------------
   -- Strings and string pointers --
   ---------------------------------
   type Z3_String is new Interfaces.C.Strings.Chars_Ptr;

   type Z3_String_Ptr is access all Z3_String;


   ---------------------
   -- Lifted Booleans --
   ---------------------
   type Z3_Lbool is
     ( Z3_L_False,
       Z3_L_Undef,
       Z3_L_True );

   for Z3_Lbool use
     ( Z3_L_False => -1,
       Z3_L_Undef => 0,
       Z3_L_True  => 1 );

   pragma Convention(C,Z3_lbool);

   ----------------
   -- Z3's kinds --
   ----------------

   -- The different kinds of symbol. In Z3, a symbol can be represented using
   -- integers and strings (See #Z3_get_symbol_kind).
   type Z3_Symbol_Kind is
     ( Z3_INT_SYMBOL,
       Z3_STRING_SYMBOL );

   pragma Convention (C, Z3_symbol_kind);


   -- The different kinds of parameters that can be associated with function symbols
   type Z3_Parameter_Kind is
     ( Z3_PARAMETER_INT, -- integer parameters
       Z3_PARAMETER_DOUBLE, -- float parameters
       Z3_PARAMETER_RATIONAL, -- parameters that are rational numbers
       Z3_PARAMETER_SYMBOL, -- parameters that are symbols
       Z3_PARAMETER_SORT, -- sort parameters
       Z3_PARAMETER_AST, -- expression parameters
       Z3_PARAMETER_FUNC_DECL); -- function declaration parameters

   pragma Convention (C, Z3_parameter_kind);


   -- The different kinds of Z3 types
   type Z3_Sort_Kind is
     ( Z3_UNINTERPRETED_SORT,
       Z3_BOOL_SORT,
       Z3_INT_SORT,
       Z3_REAL_SORT,
       Z3_BV_SORT,
       Z3_ARRAY_SORT,
       Z3_DATATYPE_SORT,
       Z3_RELATION_SORT,
       Z3_FINITE_DOMAIN_SORT,
       Z3_UNKNOWN_SORT );

   for Z3_Sort_Kind use
     ( Z3_UNINTERPRETED_SORT => 0,
       Z3_BOOL_SORT          => 1,
       Z3_INT_SORT           => 2,
       Z3_REAL_SORT          => 3,
       Z3_BV_SORT            => 4,
       Z3_ARRAY_SORT         => 5,
       Z3_DATATYPE_SORT      => 6,
       Z3_RELATION_SORT      => 7,
       Z3_FINITE_DOMAIN_SORT => 8,
       Z3_UNKNOWN_SORT       => 1000 );

   for Z3_Sort_Kind'Size use  Interfaces.C.Unsigned'Size;


   -- The different kinds of Z3 AST (abstract syntax trees).
   -- That is, terms, formulas and types.
   type Z3_Ast_Kind is
     ( Z3_NUMERAL_AST,
       Z3_APP_AST,
       Z3_VAR_AST,
       Z3_QUANTIFIER_AST,
       Z3_SORT_AST,
       Z3_FUNC_DECL_AST,
       Z3_UNKNOWN_AST );

   for Z3_Ast_Kind use
     ( Z3_NUMERAL_AST    => 0,
       Z3_APP_AST        => 1,
       Z3_VAR_AST        => 2,
       Z3_QUANTIFIER_AST => 3,
       Z3_SORT_AST       => 4,
       Z3_FUNC_DECL_AST  => 5,
       Z3_UNKNOWN_AST => 1000 );

   for Z3_Ast_Kind'Size use  Interfaces.C.Unsigned'Size;


   type Z3_Decl_Kind is
     ( Z3_OP_TRUE,
       Z3_OP_FALSE,
       Z3_OP_EQ,
       Z3_OP_DISTINCT,
       Z3_OP_ITE,
       Z3_OP_AND,
       Z3_OP_OR,
       Z3_OP_IFF,
       Z3_OP_XOR,
       Z3_OP_NOT,
       Z3_OP_IMPLIES,
       Z3_OP_OEQ,

       -- Arithmetic
       Z3_OP_ANUM,
       Z3_OP_AGNUM,
       Z3_OP_LE,
       Z3_OP_GE,
       Z3_OP_LT,
       Z3_OP_GT,
       Z3_OP_ADD,
       Z3_OP_SUB,
       Z3_OP_UMINUS,
       Z3_OP_MUL,
       Z3_OP_DIV,
       Z3_OP_IDIV,
       Z3_OP_REM,
       Z3_OP_MOD,
       Z3_OP_TO_REAL,
       Z3_OP_TO_INT,
       Z3_OP_IS_INT,
       Z3_OP_POWER,

       -- Arrays & Sets
       Z3_OP_STORE,
       Z3_OP_SELECT,
       Z3_OP_CONST_ARRAY,
       Z3_OP_ARRAY_MAP,
       Z3_OP_ARRAY_DEFAULT,
       Z3_OP_SET_UNION,
       Z3_OP_SET_INTERSECT,
       Z3_OP_SET_DIFFERENCE,
       Z3_OP_SET_COMPLEMENT,
       Z3_OP_SET_SUBSET,
       Z3_OP_AS_ARRAY,

       -- Bit-vectors
       Z3_OP_BNUM,
       Z3_OP_BIT1,
       Z3_OP_BIT0,
       Z3_OP_BNEG,
       Z3_OP_BADD,
       Z3_OP_BSUB,
       Z3_OP_BMUL,

       Z3_OP_BSDIV,
       Z3_OP_BUDIV,
       Z3_OP_BSREM,
       Z3_OP_BUREM,
       Z3_OP_BSMOD,

       -- special functions to record the division by 0 cases
       -- these are internal functions
       Z3_OP_BSDIV0,
       Z3_OP_BUDIV0,
       Z3_OP_BSREM0,
       Z3_OP_BUREM0,
       Z3_OP_BSMOD0,

       Z3_OP_ULEQ,
       Z3_OP_SLEQ,
       Z3_OP_UGEQ,
       Z3_OP_SGEQ,
       Z3_OP_ULT,
       Z3_OP_SLT,
       Z3_OP_UGT,
       Z3_OP_SGT,

       Z3_OP_BAND,
       Z3_OP_BOR,
       Z3_OP_BNOT,
       Z3_OP_BXOR,
       Z3_OP_BNAND,
       Z3_OP_BNOR,
       Z3_OP_BXNOR,

       Z3_OP_CONCAT,
       Z3_OP_SIGN_EXT,
       Z3_OP_ZERO_EXT,
       Z3_OP_EXTRACT,
       Z3_OP_REPEAT,

       Z3_OP_BREDOR,
       Z3_OP_BREDAND,
       Z3_OP_BCOMP,

       Z3_OP_BSHL,
       Z3_OP_BLSHR,
       Z3_OP_BASHR,
       Z3_OP_ROTATE_LEFT,
       Z3_OP_ROTATE_RIGHT,
       Z3_OP_EXT_ROTATE_LEFT,
       Z3_OP_EXT_ROTATE_RIGHT,

       Z3_OP_INT2BV,
       Z3_OP_BV2INT,
       Z3_OP_CARRY,
       Z3_OP_XOR3,

       -- Proofs
       Z3_OP_PR_UNDEF,
       Z3_OP_PR_TRUE,
       Z3_OP_PR_ASSERTED,
       Z3_OP_PR_GOAL,
       Z3_OP_PR_MODUS_PONENS,
       Z3_OP_PR_REFLEXIVITY,
       Z3_OP_PR_SYMMETRY,
       Z3_OP_PR_TRANSITIVITY,
       Z3_OP_PR_TRANSITIVITY_STAR,
       Z3_OP_PR_MONOTONICITY,
       Z3_OP_PR_QUANT_INTRO,
       Z3_OP_PR_DISTRIBUTIVITY,
       Z3_OP_PR_AND_ELIM,
       Z3_OP_PR_NOT_OR_ELIM,
       Z3_OP_PR_REWRITE,
       Z3_OP_PR_REWRITE_STAR,
       Z3_OP_PR_PULL_QUANT,
       Z3_OP_PR_PULL_QUANT_STAR,
       Z3_OP_PR_PUSH_QUANT,
       Z3_OP_PR_ELIM_UNUSED_VARS,
       Z3_OP_PR_DER,
       Z3_OP_PR_QUANT_INST,
       Z3_OP_PR_HYPOTHESIS,
       Z3_OP_PR_LEMMA,
       Z3_OP_PR_UNIT_RESOLUTION,
       Z3_OP_PR_IFF_TRUE,
       Z3_OP_PR_IFF_FALSE,
       Z3_OP_PR_COMMUTATIVITY,
       Z3_OP_PR_DEF_AXIOM,
       Z3_OP_PR_DEF_INTRO,
       Z3_OP_PR_APPLY_DEF,
       Z3_OP_PR_IFF_OEQ,
       Z3_OP_PR_NNF_POS,
       Z3_OP_PR_NNF_NEG,
       Z3_OP_PR_NNF_STAR,
       Z3_OP_PR_CNF_STAR,
       Z3_OP_PR_SKOLEMIZE,
       Z3_OP_PR_MODUS_PONENS_OEQ,
       Z3_OP_PR_TH_LEMMA,
       Z3_OP_PR_HYPER_RESOLVE,

       -- Sequences
       Z3_OP_RA_STORE,
       Z3_OP_RA_EMPTY,
       Z3_OP_RA_IS_EMPTY,
       Z3_OP_RA_JOIN,
       Z3_OP_RA_UNION,
       Z3_OP_RA_WIDEN,
       Z3_OP_RA_PROJECT,
       Z3_OP_RA_FILTER,
       Z3_OP_RA_NEGATION_FILTER,
       Z3_OP_RA_RENAME,
       Z3_OP_RA_COMPLEMENT,
       Z3_OP_RA_SELECT,
       Z3_OP_RA_CLONE,
       Z3_OP_FD_LT,

       -- Auxiliary
       Z3_OP_LABEL,
       Z3_OP_LABEL_LIT,

       -- Datatypes
       Z3_OP_DT_CONSTRUCTOR,
       Z3_OP_DT_RECOGNISER,
       Z3_OP_DT_ACCESSOR,

       Z3_OP_UNINTERPRETED);

   for Z3_Decl_Kind use
     ( Z3_OP_TRUE     => 16#100#,
       Z3_OP_FALSE    => 16#101#,
       Z3_OP_EQ       => 16#102#,
       Z3_OP_DISTINCT => 16#103#,
       Z3_OP_ITE      => 16#104#,
       Z3_OP_AND      => 16#105#,
       Z3_OP_OR       => 16#106#,
       Z3_OP_IFF      => 16#107#,
       Z3_OP_XOR      => 16#108#,
       Z3_OP_NOT      => 16#109#,
       Z3_OP_IMPLIES  => 16#110#,
       Z3_OP_OEQ      => 16#111#,

       -- Arithmetic
       Z3_OP_ANUM    => 16#200#,
       Z3_OP_AGNUM   => 16#201#,
       Z3_OP_LE      => 16#202#,
       Z3_OP_GE      => 16#203#,
       Z3_OP_LT      => 16#204#,
       Z3_OP_GT      => 16#205#,
       Z3_OP_ADD     => 16#206#,
       Z3_OP_SUB     => 16#207#,
       Z3_OP_UMINUS  => 16#208#,
       Z3_OP_MUL     => 16#209#,
       Z3_OP_DIV     => 16#210#,
       Z3_OP_IDIV    => 16#211#,
       Z3_OP_REM     => 16#212#,
       Z3_OP_MOD     => 16#213#,
       Z3_OP_TO_REAL => 16#214#,
       Z3_OP_TO_INT  => 16#215#,
       Z3_OP_IS_INT  => 16#216#,
       Z3_OP_POWER   => 16#217#,

       -- Arrays & Sets
       Z3_OP_STORE          => 16#300#,
       Z3_OP_SELECT         => 16#301#,
       Z3_OP_CONST_ARRAY    => 16#302#,
       Z3_OP_ARRAY_MAP      => 16#303#,
       Z3_OP_ARRAY_DEFAULT  => 16#304#,
       Z3_OP_SET_UNION      => 16#305#,
       Z3_OP_SET_INTERSECT  => 16#306#,
       Z3_OP_SET_DIFFERENCE => 16#307#,
       Z3_OP_SET_COMPLEMENT => 16#308#,
       Z3_OP_SET_SUBSET     => 16#309#,
       Z3_OP_AS_ARRAY       => 16#310#,

       -- Bit-vectors
       Z3_OP_BNUM => 16#400#,
       Z3_OP_BIT1 => 16#401#,
       Z3_OP_BIT0 => 16#402#,
       Z3_OP_BNEG => 16#403#,
       Z3_OP_BADD => 16#404#,
       Z3_OP_BSUB => 16#405#,
       Z3_OP_BMUL => 16#406#,

       Z3_OP_BSDIV => 16#407#,
       Z3_OP_BUDIV => 16#408#,
       Z3_OP_BSREM => 16#409#,
       Z3_OP_BUREM => 16#410#,
       Z3_OP_BSMOD => 16#411#,

       -- special functions to record the division by 0 cases
       -- these are internal functions
       Z3_OP_BSDIV0 => 16#412#,
       Z3_OP_BUDIV0 => 16#413#,
       Z3_OP_BSREM0 => 16#414#,
       Z3_OP_BUREM0 => 16#415#,
       Z3_OP_BSMOD0 => 16#416#,

       Z3_OP_ULEQ => 16#417#,
       Z3_OP_SLEQ => 16#418#,
       Z3_OP_UGEQ => 16#419#,
       Z3_OP_SGEQ => 16#420#,
       Z3_OP_ULT  => 16#421#,
       Z3_OP_SLT  => 16#422#,
       Z3_OP_UGT  => 16#423#,
       Z3_OP_SGT  => 16#424#,

       Z3_OP_BAND  => 16#425#,
       Z3_OP_BOR   => 16#426#,
       Z3_OP_BNOT  => 16#427#,
       Z3_OP_BXOR  => 16#428#,
       Z3_OP_BNAND => 16#429#,
       Z3_OP_BNOR  => 16#430#,
       Z3_OP_BXNOR => 16#431#,

       Z3_OP_CONCAT   => 16#432#,
       Z3_OP_SIGN_EXT => 16#433#,
       Z3_OP_ZERO_EXT => 16#434#,
       Z3_OP_EXTRACT  => 16#435#,
       Z3_OP_REPEAT   => 16#436#,

       Z3_OP_BREDOR  => 16#437#,
       Z3_OP_BREDAND => 16#438#,
       Z3_OP_BCOMP   => 16#439#,

       Z3_OP_BSHL              => 16#440#,
       Z3_OP_BLSHR             => 16#441#,
       Z3_OP_BASHR             => 16#442#,
       Z3_OP_ROTATE_LEFT       => 16#443#,
       Z3_OP_ROTATE_RIGHT      => 16#444#,
       Z3_OP_EXT_ROTATE_LEFT   => 16#445#,
       Z3_OP_EXT_ROTATE_RIGHT  => 16#446#,

       Z3_OP_INT2BV => 16#447#,
       Z3_OP_BV2INT => 16#448#,
       Z3_OP_CARRY  => 16#449#,
       Z3_OP_XOR3   => 16#450#,

       -- Proofs
       Z3_OP_PR_UNDEF             => 16#500#,
       Z3_OP_PR_TRUE              => 16#501#,
       Z3_OP_PR_ASSERTED          => 16#502#,
       Z3_OP_PR_GOAL              => 16#503#,
       Z3_OP_PR_MODUS_PONENS      => 16#504#,
       Z3_OP_PR_REFLEXIVITY       => 16#505#,
       Z3_OP_PR_SYMMETRY          => 16#506#,
       Z3_OP_PR_TRANSITIVITY      => 16#507#,
       Z3_OP_PR_TRANSITIVITY_STAR => 16#508#,
       Z3_OP_PR_MONOTONICITY      => 16#509#,
       Z3_OP_PR_QUANT_INTRO       => 16#510#,
       Z3_OP_PR_DISTRIBUTIVITY    => 16#511#,
       Z3_OP_PR_AND_ELIM          => 16#512#,
       Z3_OP_PR_NOT_OR_ELIM       => 16#513#,
       Z3_OP_PR_REWRITE           => 16#514#,
       Z3_OP_PR_REWRITE_STAR      => 16#515#,
       Z3_OP_PR_PULL_QUANT        => 16#516#,
       Z3_OP_PR_PULL_QUANT_STAR   => 16#517#,
       Z3_OP_PR_PUSH_QUANT        => 16#518#,
       Z3_OP_PR_ELIM_UNUSED_VARS  => 16#519#,
       Z3_OP_PR_DER               => 16#520#,
       Z3_OP_PR_QUANT_INST        => 16#521#,
       Z3_OP_PR_HYPOTHESIS        => 16#522#,
       Z3_OP_PR_LEMMA             => 16#523#,
       Z3_OP_PR_UNIT_RESOLUTION   => 16#524#,
       Z3_OP_PR_IFF_TRUE          => 16#525#,
       Z3_OP_PR_IFF_FALSE         => 16#526#,
       Z3_OP_PR_COMMUTATIVITY     => 16#527#,
       Z3_OP_PR_DEF_AXIOM         => 16#528#,
       Z3_OP_PR_DEF_INTRO         => 16#529#,
       Z3_OP_PR_APPLY_DEF         => 16#530#,
       Z3_OP_PR_IFF_OEQ           => 16#531#,
       Z3_OP_PR_NNF_POS           => 16#532#,
       Z3_OP_PR_NNF_NEG           => 16#533#,
       Z3_OP_PR_NNF_STAR          => 16#534#,
       Z3_OP_PR_CNF_STAR          => 16#535#,
       Z3_OP_PR_SKOLEMIZE         => 16#536#,
       Z3_OP_PR_MODUS_PONENS_OEQ  => 16#537#,
       Z3_OP_PR_TH_LEMMA          => 16#538#,
       Z3_OP_PR_HYPER_RESOLVE     => 16#539#,

       -- Sequences
       Z3_OP_RA_STORE            => 16#600#,
       Z3_OP_RA_EMPTY            => 16#601#,
       Z3_OP_RA_IS_EMPTY         => 16#602#,
       Z3_OP_RA_JOIN             => 16#603#,
       Z3_OP_RA_UNION            => 16#604#,
       Z3_OP_RA_WIDEN            => 16#605#,
       Z3_OP_RA_PROJECT          => 16#606#,
       Z3_OP_RA_FILTER           => 16#607#,
       Z3_OP_RA_NEGATION_FILTER  => 16#608#,
       Z3_OP_RA_RENAME           => 16#609#,
       Z3_OP_RA_COMPLEMENT       => 16#610#,
       Z3_OP_RA_SELECT           => 16#611#,
       Z3_OP_RA_CLONE            => 16#612#,
       Z3_OP_FD_LT               => 16#613#,

       -- Auxiliary
       Z3_OP_LABEL     => 16#700#,
       Z3_OP_LABEL_LIT => 16#701#,

       -- Datatypes
       Z3_OP_DT_CONSTRUCTOR => 16#800#,
       Z3_OP_DT_RECOGNISER  => 16#801#,
       Z3_OP_DT_ACCESSOR    => 16#802#,

       Z3_OP_UNINTERPRETED  => 16#803#);
   pragma Convention(C, Z3_decl_kind );


   -- The different kinds of parameters that can be associated with parameter sets.
   type Z3_param_kind is
     (Z3_PK_UINT,
      Z3_PK_BOOL,
      Z3_PK_DOUBLE,
      Z3_PK_SYMBOL,
      Z3_PK_STRING,
      Z3_PK_OTHER,
      Z3_PK_INVALID);
   pragma Convention (C, Z3_param_kind);


   -- The different kinds of search failure types.
   type Z3_search_failure is
     (Z3_NO_FAILURE,
      Z3_UNKNOWN,
      Z3_TIMEOUT,
      Z3_MEMOUT_WATERMARK,
      Z3_CANCELED,
      Z3_NUM_CONFLICTS,
      Z3_THEORY,
      Z3_QUANTIFIERS);
   pragma Convention (C, Z3_search_failure);


   -- Z3 pretty printing modes
   type Z3_ast_print_mode is
     (Z3_PRINT_SMTLIB_FULL,
      Z3_PRINT_LOW_LEVEL,
      Z3_PRINT_SMTLIB_COMPLIANT,
      Z3_PRINT_SMTLIB2_COMPLIANT);
   pragma Convention (C, Z3_ast_print_mode);


   -- Z3 error codes
   type Z3_error_code is
     (Z3_OK,
      Z3_SORT_ERROR,
      Z3_IOB,
      Z3_INVALID_ARG,
      Z3_PARSER_ERROR,
      Z3_NO_PARSER,
      Z3_INVALID_PATTERN,
      Z3_MEMOUT_FAIL,
      Z3_FILE_ACCESS_ERROR,
      Z3_INTERNAL_FATAL,
      Z3_INVALID_USAGE,
      Z3_DEC_REF_ERROR,
      Z3_EXCEPTION);
   for Z3_Error_Code'Size use Interfaces.C.Int'Size ;

   pragma Convention (C, Z3_error_code);


   --
   type Z3_goal_prec is
     (Z3_GOAL_PRECISE,
      Z3_GOAL_UNDER,
      Z3_GOAL_OVER,
      Z3_GOAL_UNDER_OVER);
   pragma Convention (C, Z3_goal_prec);

   -- procedure Z3_Error_Handler(C:in Z3_Context;E:in Z3_Error_Code);
   -- pragma Import(C,Z3_Error_Handler,"Z3_error_handler");

   type Z3_Symbol_Array is array(Integer range <>) of Z3_Symbol;
   pragma Convention(C,Z3_Symbol_Array);

   type Z3_Sort_Array is array(Integer range <>) of Z3_Sort;
   pragma Convention(C,Z3_Sort_Array);

   type Z3_Func_Decl_Array is array(Integer range <>) of Z3_Func_Decl;
   pragma Convention(C,Z3_Func_Decl_Array);

   type Z3_Func_Decl_Access is access all Z3_Func_Decl;

   type Z3_Constructor_Array is array(Integer range <>) of Z3_Constructor;
   pragma Convention(C,Z3_Constructor_Array);

   type Z3_Sort_Opt_Array is array(Integer range <>) of Z3_Sort_Opt;

   type Unsigned_Array is array(Integer range <>) of Interfaces.C.Unsigned;

   type Z3_Ast_Array is array(Integer range <>) of Z3_Ast;

   type Int_Access is access all Interfaces.C.Int ;

   type Unsigned_Access is access all Interfaces.C.Unsigned ;

   subtype Int_64 is Interfaces.C.Long ;

   type Int_64_Access is access all Int_64 ;

   subtype Uint_64 is Interfaces.C.Unsigned_Long ;

   type Uint_64_Access is access all Uint_64 ;

   ---------------------
   --  Error Handling --
   ---------------------

   -- Return the error code for the last API call.
   function Z3_Get_Error_Code( C : in Z3_Context ) return Z3_Error_Code;

   -- The type of error handlers for callback errors
   -- type Z3_Error_Handler is not null access procedure( C : in Z3_Context ; E : in Z3_Error_Code ) ;
   -- pragma Convention(C,Z3_Error_Handler);

   -- Register a Z3 error handler.
   procedure Z3_Set_Error_Handler( C : in Z3_Context ; H : access procedure( Arg1 : in Z3_Context ; Arg2 : in Z3_Error_Code ) ) ;

   -- Set an error.
   procedure Z3_Set_Error( C : in Z3_Context ; E : in Z3_Error_Code);

   -- Return a string describing the given error code.
   function Z3_Get_Error_Msg( Err : in Z3_Error_Code) return Z3_String;

   -- Return a string describing the given error code.
   procedure Z3_Get_Error_Msg_Ex( C : in Z3_Context ; Err : in Z3_Error_Code );

   --  Miscellaneous

   -- Return Z3 version number information.
   procedure Z3_Get_Version( Major, Minor, Build_Numer, Revision_Number : out Interfaces.C.Unsigned);

   -- Enable tracing messages tagged as tag when Z3 is compiled in debug mode. It is a NOOP otherwise.
   procedure Z3_Enable_Trace( Tag : in Z3_String );

   -- Disable tracing messages tagged as tag when Z3 is compiled in debug mode. It is a NOOP otherwise.
   procedure Z3_Disable_Trace( Tag : in Z3_String );

   -- Reset all allocated resources.
   procedure Z3_Reset_Memory;

   -----------
   -- Goals --
   -----------

   -- Create a goal (aka problem). A goal is essentially a set of formulas, that can be solved and/or transformed using tactics and solvers.
   function Z3_Mk_Goal( C : in Z3_Context ; Models : in Z3_Bool ; Unsar_Cores : in Z3_Bool ; Proofs : in Z3_Bool ) return Z3_Goal;

   -- Increment the reference counter of the given goal.
   procedure Z3_Goal_Inc_Ref( C : in Z3_Context ; G : in Z3_Goal );

   -- Decrement the reference counter of the given goal.
   procedure Z3_Goal_Dec_Ref( C : in Z3_Context ; G : in Z3_Goal );

   -- Return the "precision" of the given goal. Goals can be transformed using over and under approximations.
   -- A under approximation is applied when the objective is to find a model for a given goal. An over
   -- approximation is applied when the objective is to find a proof for a given goal.
   function Z3_Goal_Precision( C : in Z3_Context ; G : in Z3_Goal ) return Z3_Goal_Prec;

   -- Add a new formula a to the given goal.
   procedure Z3_Goal_Assert( C : in Z3_Context ; G : in Z3_Goal ; A : in Z3_Ast );

   -- Return true if the given goal contains the formula false.
   function Z3_Goal_Inconsistent( C : in Z3_Context ; G : in Z3_Goal ) return Z3_Bool;

   -- Return the depth of the given goal. It tracks how many transformations were applied to it.
   function Z3_Goal_Depth( C : in Z3_Context ; G : in Z3_Goal ) return Interfaces.C.Unsigned;

   -- Erase all formulas from the given goal.
   procedure Z3_Goal_Reset( C : in Z3_Context ; G : in Z3_Goal);

   -- Return the number of formulas in the given goal.
   function Z3_Goal_Size( C : in Z3_Context ; G : in Z3_Goal ) return Interfaces.C.Unsigned;

   -- Return a formula from the given goal.
   function Z3_Goal_Formula( C : in Z3_Context ; G : in Z3_Goal ; Idx : in Interfaces.C.Unsigned ) return Z3_Ast;

   -- Return the number of formulas, subformulas and terms in the given goal.
   function Z3_Goal_Num_Exprs( C : in Z3_Context ; G : in Z3_Goal ) return Interfaces.C.Unsigned;

   -- Return true if the goal is empty, and it is precise or the product of a under approximation.
   function Z3_Goal_Decided_Sat( C : in Z3_Context ; G : in Z3_Goal ) return Z3_Bool;

   -- Return true if the goal contains false, and it is precise or the product of an over approximation.
   function Z3_Goal_Decided_Unsat( C : in Z3_Context ; G : in Z3_Goal ) return Z3_Bool;

   -- Copy a goal g from the context source to a the context target.
   function Z3_Goal_Translate( C : in Z3_Context ; G : in Z3_Goal ) return Z3_Goal;

   -- Convert a goal into a string.
   function Z3_Goal_To_String( C : in Z3_Context ; G : in Z3_Goal ) return Z3_String;

private

   pragma Import(C,Z3_Get_Error_Code,"Z3_get_error_code");
   pragma Import(C,Z3_Set_Error_Handler,"Z3_set_error_handler");
   pragma Import(C,Z3_Set_Error,"Z3_set_error");
   pragma Import(C,Z3_Get_Error_Msg, "Z3_get_error_msg");
   pragma Import(C,Z3_Get_Error_Msg_Ex,"Z3_get_error_msg_ex");
   pragma Import(C,Z3_Get_Version,"Z3_get_version");
   pragma Import(C,Z3_Enable_Trace,"Z3_enable_trace");
   pragma Import(C,Z3_Disable_Trace,"Z3_disable_trace");
   pragma Import(C,Z3_Reset_Memory,"Z3_reset_memory");
   pragma Import(C,Z3_Mk_Goal,"Z3_mk_goal");
   pragma Import(C,Z3_Goal_Inc_Ref,"Z3_goal_inc_ref");
   pragma Import(C,Z3_Goal_Dec_Ref,"Z3_goal_dec_ref");
   pragma Import(C,Z3_Goal_Precision,"Z3_goal_precision");
   pragma Import(C,Z3_Goal_Assert,"Z3_goal_assert");
   pragma Import(C,Z3_Goal_Inconsistent,"Z3_goal_inconsistent");
   pragma Import(C,Z3_Goal_Depth,"Z3_goal_depth");
   pragma Import(C,Z3_Goal_Reset,"Z3_goal_reset");
   pragma Import(C,Z3_Goal_Size,"Z3_goal_size");
   pragma Import(C,Z3_Goal_Formula,"Z3_goal_formula");
   pragma Import(C,Z3_Goal_Num_Exprs,"Z3_goal_num_exprs");
   pragma Import(C,Z3_Goal_Decided_Sat,"Z3_goal_is_decided_sat");
   pragma Import(C,Z3_Goal_Decided_Unsat,"Z3_goal_is_decided_unsat");
   pragma Import(C,Z3_Goal_Translate,"Z3_goal_translate");
   pragma Import(C,Z3_Goal_To_String,"Z3_goal_to_string");

end Z3;

