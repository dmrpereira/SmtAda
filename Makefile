SO := $(shell uname)

all:
	@echo "Compiling bindings..."
	gnatmake -Pprovers
	install_name_tool -change libz3.dylib /Users/dpereira/Provers/lib/libz3.dylib teste
clean:
	gnatclean -Pprovers
