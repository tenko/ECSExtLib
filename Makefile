.SUFFIXES:
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

OB := ecsd
PRG = .exe
ECS := /c/EigenCompilerSuite/runtime

ifdef MSYSTEM
	PRG = .exe
	SYS = win
	ECS = /c/EigenCompilerSuite/
	RTS = $(ECS)runtime/win64api.obf
else
	PRG = 
	SYS = linux
	ECS = ~/.local/lib/ecs/
	RST = 
endif

.PHONY: all
all : extui.lib extsqlite.lib extsdl3.lib

build/%.obf: src/%.asm
	@echo compiling $< 
	@mkdir -p build
	@cd build && ecsd -c $(addprefix ../, $<)

build/%.obf: src/%.mod
	@echo compiling $< 
	@mkdir -p build
	@cd build && ecsd -c $(addprefix ../, $<)

build/sqlite$(SYS).obf: src/sqlite$(SYS).cpp
	@echo building $@:
	@mkdir -p build
	@cd build && cp ../src/$(SYS)lib.hpp .
	@cd build && cp ../src/sqlite.cpp .
	@cd build && cp ../src/sqlite$(SYS).cpp .
	@cd build && $(OB) -c $(notdir $<)

build/sdl3$(SYS).obf: src/sdl3$(SYS).cpp
	@echo building $@:
	@mkdir -p build
	@cd build && cp ../src/$(SYS)lib.hpp .
	@cd build && cp ../src/sdl3.cpp .
	@cd build && cp ../src/sdl3$(SYS).cpp .
	@cd build && $(OB) -c $(notdir $<)

build/Ext.Sqlite.obf : src/Ext.Sqlite.mod
build/sqlite$(SYS).obf :  src/$(SYS)lib.hpp src/sqlite$(SYS).cpp src/sqlite.cpp

build/Ext.SDL3.obf : src/Ext.SDL3.mod
build/sdl3$(SYS).obf :  src/$(SYS)lib.hpp src/sdl3$(SYS).cpp src/sdl3.cpp

extsqlite.lib : build/Ext.Sqlite.obf build/sqlite$(SYS).obf
	@echo linking $@
	@-rm $@
	@touch $@
	@linklib $@ $^

testsqlite$(PRG): misc/testsqlite.mod extsqlite.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/testsqlite.mod .
	@cd build && $(OB) $(notdir $<) ../extsqlite.lib $(ECS)/runtime/std.lib $(RTS)
	@cp build/testsqlite$(PRG) testsqlite$(PRG)
	@./testsqlite$(PRG)

extsdl3.lib : build/Ext.SDL3.obf build/sdl3$(SYS).obf
	@echo linking $@
	@-rm $@
	@touch $@
	@linklib $@ $^

testsdl3$(PRG): misc/testsdl3.mod extsdl3.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/testsdl3.mod .
	@cd build && $(OB) $(notdir $<) ../extsdl3.lib $(ECS)/runtime/std.lib $(RTS)
	@cp build/testsdl3$(PRG) testsdl3$(PRG)
	@./testsdl3$(PRG)
	
.PHONY: clean
clean:
	@echo Clean
	@-rm -rf build
