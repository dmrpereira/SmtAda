all:
	ayacc parser.y 
	gnatchop parser.a
	aflex lexer.l
	gnatchop lexer.a
	gnatchop lexer_io.a
	gnatchop lexer_dfa.a
	gnatmake fol_repl.adb
clean:
	gnatclean fol_repl
	rm -rf lexer_io.* lexer_dfa.* lexer.a lexer.ads lexer.adb yylex.adb parser_* parser.a yyparse.adb parser.ads parser.adb parser.verbose *.a *~ my_parser.*