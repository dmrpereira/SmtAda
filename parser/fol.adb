with Text_IO ; use Text_IO ;
with Lexer_IO ; use Lexer_IO ;
with Lexer_Dfa ; use Lexer_Dfa ;
with Lexer ; 
with My_Parser ; use My_Parser ;
with Ada.Command_line; use Ada.Command_Line;

procedure Fol is
begin

   begin
      Put_Line("Opening " & Argument(1) & " and processing it") ;
      Lexer_IO.Open_Input (Argument(1));
      Yyparse ;
      Put_Line("Number of Lines total : " & Lexer.Get_Line_Num'Img ) ;
   exception
      when Text_IO.Name_Error =>
         Put_Line (Standard_Error, "Error: Cannot open " & Argument(1));
         return;
   end;


end Fol ;
