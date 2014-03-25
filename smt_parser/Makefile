all:
	ayacc smt_parser.y 
	gnatchop -w smt_parser.a
	aflex -E smt_lex.l
	gnatchop -w smt_lex.a
	gnatchop -w smt_lex_io.a
	gnatchop -w smt_lex_dfa.a
	gnatmake smt_parser_interface.adb
clean:
	rm -rf *.a smt_lex_dfa.* smt_lex.ads smt_lex.adb smt_lex_io.* smt_lex_dfa.* \
	           smt_parser_goto.ads smt_parser_interface.* smt_parser_shift_reduce.ads \
	           smt_parser_tokens.ads  *~
