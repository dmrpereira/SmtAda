SO := $(shell uname)

all:
	@echo "Compiling bindings..."
	gnatmake -Pprovers
	install_name_tool -change libz3.dylib /Users/dpereira/Provers/lib/libz3.dylib z3_t1
	install_name_tool -change libz3.dylib /Users/dpereira/Provers/lib/libz3.dylib z3_t2
clean:
	gnatclean -Pprovers
