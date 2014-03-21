GNATMAKE=gnatmake
GPR=gprbuild
GPRC=gprclean


all:
	@mkdir -p obj
	@mkdir -p bin
	$(MAKE) -C parser
	$(GPR) parser/parser.gpr

clean:
	$(MAKE) clean -C parser
	$(GPRC) parser/parser.gpr
	@rm -rf obj
	@rm -rf bin

#SO := $(shell uname)

#all:
#	@echo "Compiling bindings..."
#	gnatmake -Pprovers
#	install_name_tool -change libz3.dylib /Users/dpereira/Provers/lib/libz3.dylib z3_t1
#	install_name_tool -change libz3.dylib /Users/dpereira/Provers/lib/libz3.dylib z3_arrays_t1
#	install_name_tool -change libz3.dylib /Users/dpereira/Provers/lib/libz3.dylib z3_arrays_t2
#clean:
#	gnatclean -Pprovers
