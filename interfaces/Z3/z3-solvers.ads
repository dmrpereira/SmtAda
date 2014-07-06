with Interfaces.C, Interfaces.C.Strings;
with System;

--with Bridge.Z3; use Bridge; use Bridge.Z3;

package Z3.Solvers is
   
   -------------
   -- Solvers --
   -------------
   
   -- Create a new (incremental) solver. This solver also uses a set of builtin tactics for handling
   -- the first check-sat command, and check-sat commands that take more than a given number of 
   -- milliseconds to be solved. 
   function Z3_Mk_Solver( C : in Z3_Context ) return Z3_Solver ;
   pragma Import(C,Z3_Mk_Solver,"Z3_mk_solver");
   
   -- Create a new (incremental) solver. 
   function Z3_Mk_Simple_Solver( C : in Z3_Context ) return Z3_Solver ;
   pragma Import(C,Z3_Mk_Simple_Solver,"Z3_mk_simple_solver");
   
   -- Create a new solver customized for the given logic. It behaves like Z3_mk_solver if the logic is
   -- unknown or unsupported. 
   function Z3_Mk_Solver_For_Logic( C : in Z3_Context ; Logic : in Z3_Symbol) return Z3_Solver ;
   pragma Import(C,Z3_Mk_Solver_For_Logic,"Z3_mk_solver_for_logic") ;

   -- Create a new solver that is implemented using the given tactic. The solver supports the commands
   -- Z3_solver_push and Z3_solver_pop, but it will always solve each Z3_solver_check from scratch. 
   function Z3_Mk_Solver_From_Tactic( C : in Z3_Context ; T : in Z3_Tactic ) return Z3_Solver ;
   pragma Import(C,Z3_Mk_Solver_From_Tactic,"Z3_mk_solver_from_tactic") ;
     
   -- Return a string describing all solver available parameters. 
   function Z3_Solver_Get_Help( C : in Z3_Context ; S : in Z3_Solver ) return Z3_String ;
   pragma Import(C,Z3_Solver_Get_Help,"Z3_solver_get_help") ;

   -- Return the parameter description set for the given solver object. 		   
   function Z3_Solver_Get_Param_Descrs( C : in Z3_Context ; S : in Z3_Solver ) return Z3_Param_Descrs ;
   pragma Import(C,Z3_Solver_Get_Param_Descrs,"Z3_solver_get_param_descrs");

   -- Set the given solver using the given parameters. 		   
   procedure Z3_Solver_Set_Params( C : in Z3_Context ; S : in Z3_Solver ; P : in Z3_Params ) ;
   pragma Import(C,Z3_Solver_Set_Params,"Z3_solver_set_params") ;

   -- Increment the reference counter of the given solver.
   procedure Z3_Solver_Inc_Ref( C : in Z3_Context ; S : in Z3_Solver ) ;
   pragma Import(C,Z3_Solver_Inc_Ref,"Z3_solver_inc_ref") ;
   	 
   -- Decrement the reference counter of the given solver. 		   
   procedure Z3_Solver_Dec_Ref( C : in Z3_Context ; S : in Z3_Solver ) ;
   pragma Import(C,Z3_Solver_Dec_Ref,"Z3_solver_dec_ref");

   -- Create a backtracking point. 		   
   procedure Z3_Solver_Push( C : in Z3_Context ; S : in Z3_Solver ) ;
   pragma Import(C,Z3_Solver_Push,"Z3_solver_push") ;

   -- Backtrack n backtracking points. 		   
   procedure Z3_Solver_Pop( C : in Z3_Context ; S : in Z3_Solver ; N : in Interfaces.C.Unsigned ) ;
   pragma Import(C,Z3_Solver_Pop,"Z3_solver_pop") ;
   
   -- Remove all assertions from the solver.    
   procedure Z3_Solver_Reset( C : in Z3_Context ; S : in Z3_Solver );
   pragma Import(C,Z3_Solver_Reset,"Z3_solver_reset") ;

   -- Return the number of backtracking points.  
   function Z3_Solver_Get_Num_Scopes( C : in Z3_Context ; S : in Z3_Solver ) return Interfaces.C.Unsigned ;
   pragma Import(C,Z3_Solver_Get_Num_Scopes,"Z3_solver_get_num_scopes") ;

   -- Assert a constraint into the solver. 
   procedure Z3_Solver_Assert( C : in Z3_Context ; S : in Z3_Solver ; A : in Z3_Ast );
   pragma Import(C,Z3_Solver_Assert,"Z3_solver_assert") ;

   -- Assert a constraint a into the solver, and track it (in the unsat) core using the Boolean constant p. 
   procedure Z3_Solver_Assert_And_Track( C : in Z3_Context ; S : in Z3_Solver ; A : in Z3_Ast ; P : in Z3_Ast );
   pragma Import(C,Z3_Solver_Assert_And_Track,"Z3_solver_assert_and_track") ;

   -- Return the set of asserted formulas as a goal object.  
   function Z3_Solver_Get_Assertions( C : in Z3_Context ; S : in Z3_Solver ) return Z3_Ast_Vector ;
   pragma Import(C,Z3_Solver_Get_Assertions,"Z3_solver_get_assertions") ;

   -- Check whether the assertions in a given solver are consistent or not.  
   function Z3_Solver_Check( C : in Z3_Context ; S : in Z3_Solver ) return Z3_Lbool ;
   pragma Import(C,Z3_Solver_Check,"Z3_solver_check") ;

   -- Check whether the assertions in the given solver and optional assumptions are consistent or not.  
   function Z3_Solver_Check_Assumptions( C : in Z3_Context ; 
					 S : in Z3_Solver ; 
					 Num_Assumptions : in Interfaces.C.Unsigned ;
					 Assumptions : in Z3_Ast_Array ) return Z3_Lbool ;
   pragma Import(C,Z3_Solver_Check_Assumptions,"Z3_solver_check_assumptions") ;

   
   -- Retrieve the model for the last Z3_solver_check or Z3_solver_check_assumptions. 
   function Z3_Solver_Get_Model( C : in Z3_Context ; S : in Z3_Solver ) return Z3_Model ;
   pragma Import(C,Z3_Solver_Get_Model,"Z3_solver_get_model") ;

   -- Retrieve the proof for the last Z3_solver_check or Z3_solver_check_assumptions.  
   function Z3_Solver_Get_Proof( C : in Z3_Context ; S : in Z3_Solver ) return Z3_Ast ;
   pragma Import(C,Z3_Solver_Get_Proof,"Z3_solver_get_proof") ;

   -- Retrieve the unsat core for the last Z3_solver_check_assumptions The unsat core is a subset 
   -- of the assumptions a.  
   function Z3_Solver_Get_Unsat_Core( C : in Z3_Context ; S : in Z3_Solver ) return Z3_Ast_Vector ;
   pragma Import(C,Z3_Solver_Get_Unsat_Core,"Z3_solver_get_unsat_core");

   -- Return a brief justification for an "unknown" result (i.e., Z3_L_UNDEF) for the commands 
   -- Z3_solver_check and Z3_solver_check_assumptions.  
   function Z3_Solver_Get_Reason_Unknown( C : in Z3_Context ; S : in Z3_Solver ) return Z3_String ;
   pragma Import(C,Z3_Solver_Get_Reason_Unknown,"Z3_solver_get_reason_unknown") ;

   -- Return statistics for the given solver.  
   function Z3_Solver_Get_Statistics( C : in Z3_Context ; S : in Z3_Solver ) return Z3_Stats ;
   pragma Import(C,Z3_Solver_Get_Statistics,"Z3_solver_get_statistics");

   -- Convert a solver into a string.  
   function Z3_Solver_To_String( C : in Z3_Context ; S : in Z3_Solver ) return Z3_String ;
   pragma Import(C,Z3_Solver_To_String,"Z3_solver_to_string");

   
   
end Z3.Solvers;
