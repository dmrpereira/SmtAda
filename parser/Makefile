all:
	ayacc parser.y 
	gnatchop -w parser.a
	aflex lexer.l
	gnatchop -w lexer.a
	gnatchop -w lexer_io.a
	gnatchop -w lexer_dfa.a
clean:
	rm -rf lexer_io.* lexer_dfa.* lexer.a lexer.ads lexer.adb yylex.adb parser_* parser.a yyparse.adb parser.ads parser.adb parser.verbose *.a *~ my_parser.*
