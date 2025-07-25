.SUFFIXES:
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

OB := ecsd
PRG = .exe
ECS := /c/EigenCompilerSuite/runtime

ifdef MSYSTEM
	PRG = .exe
	SYS = win
	ECS = /c/EigenCompilerSuite/
else
	PRG = 
	SYS = linux
	ECS = ~/.local/lib/ecs/
endif

.PHONY: all
all : extui.lib extsqlite.lib

build/%.obf: src/%.asm
	@echo compiling $< 
	@mkdir -p build
	@cd build && ecsd -c $(addprefix ../, $<)

build/%.obf: src/%.mod
	@echo compiling $< 
	@mkdir -p build
	@cd build && ecsd -c $(addprefix ../, $<)

build/ui$(SYS).obf: src/ui$(SYS).cpp
	@echo building $@:
	@mkdir -p build
	@cd build && cp ../src/$(SYS)lib.hpp .
	@cd build && cp ../src/ui.cpp .
	@cd build && cp ../src/ui$(SYS).cpp .
	@cd build && $(OB) -c $(notdir $<)

build/sqlite$(SYS).obf: src/sqlite$(SYS).cpp
	@echo building $@:
	@mkdir -p build
	@cd build && cp ../src/$(SYS)lib.hpp .
	@cd build && cp ../src/sqlite.cpp .
	@cd build && cp ../src/sqlite$(SYS).cpp .
	@cd build && $(OB) -c $(notdir $<)
	
build/Ext.UI.obf : src/Ext.UI.mod
build/ui$(SYS).obf :  src/$(SYS)lib.hpp src/ui$(SYS).cpp src/ui.cpp
build/uishim$(SYS).obf : src/uishim$(SYS).asm
build/Ext.Sqlite.obf : src/Ext.Sqlite.mod
build/sqlite$(SYS).obf :  src/$(SYS)lib.hpp src/sqlite$(SYS).cpp src/sqlite.cpp

extui.lib : build/Ext.UI.obf build/ui$(SYS).obf build/uishim$(SYS).obf
	@echo linking $@
	@-rm $@
	@touch $@
	@linklib $@ $^
	
testui$(PRG): misc/testui.mod extui.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/testui.mod .
	@cd build && $(OB) $(notdir $<) ../extui.lib
	@cp build/testui$(PRG) testui$(PRG)
	#@./testui$(PRG)

extsqlite.lib : build/Ext.Sqlite.obf build/sqlite$(SYS).obf
	@echo linking $@
	@-rm $@
	@touch $@
	@linklib $@ $^

testsqlite$(PRG): misc/testsqlite.mod extsqlite.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/testsqlite.mod .
	@cd build && $(OB) $(notdir $<) ../extsqlite.lib $(ECS)/runtime/std.lib
	@cp build/testsqlite$(PRG) testsqlite$(PRG)
	@./testsqlite$(PRG)
	
.PHONY: clean
clean:
	@echo Clean
	@-rm -rf build
