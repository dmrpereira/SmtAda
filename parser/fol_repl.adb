with Fol ;
with Text_IO ; use Text_IO ;
with Lexer_IO ; use Lexer_IO ;
with Lexer_Dfa ; use Lexer_Dfa ;
with My_Parser ; use My_Parser ;
with Ada.Command_line; use Ada.Command_Line;


--use My_Parser ;


procedure Fol_Repl is
begin
   
   begin
      Put_Line("Opening " & Argument(1) & " and processing it") ;
      Lexer_IO.Open_Input (Argument(1));
      Yyparse ;
   exception
      when Text_IO.Name_Error =>
	 Put_Line (Standard_Error, "Error: Cannot open " & Argument(1));
	 return;
   end;
   
   
end Fol_Repl ;
