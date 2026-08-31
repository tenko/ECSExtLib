.SUFFIXES:
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

# Installation prefix
PREFIX = /usr/local

ifdef MSYSTEM
	PRG = .exe
	EXEC = winpty
	SYS = win
	RTS = -r win64api.obf
else
	PRG =
	EXEC = 
	SYS = linux
	RTS = 
endif

.PHONY: all
all : extsqlite.lib extsdl3.lib extsdl3ttf.lib

build/%.obf: src/%.asm
	@echo Compiling $<
	@mkdir -p $(@D)
	@cd $(@D) && ecsd -c ../$<
	
build/%.obf: src/%.cpp
	@echo Compiling $<
	@mkdir -p $(@D)
	@cd $(@D) && ecsd -c ../$<
	
build/%.obf: src/%.mod
	@echo Compiling $<
	@mkdir -p $(@D)
	@cd $(@D) && ecsd -c ../$<

build/sqlite$(SYS).obf: src/sqlite$(SYS).cpp
	@echo building $@:
	@mkdir -p build
	@cd build && ecsd -c $(addprefix ../, $<)

build/sdl3$(SYS).obf: src/sdl3$(SYS).cpp
	@echo building $@:
	@mkdir -p build
	@cd build && ecsd -c $(addprefix ../, $<)

build/sdl3ttf$(SYS).obf: src/sdl3ttf$(SYS).cpp
	@echo building $@:
	@mkdir -p build
	@cd build && ecsd -c $(addprefix ../, $<)
	
build/Ext.Sqlite.obf : src/Ext.Sqlite.mod
build/sqlite$(SYS).obf :  src/$(SYS)lib.hpp src/sqlite$(SYS).cpp src/sqlite.cpp

build/Ext.SDL3.obf : src/Ext.SDL3.mod
build/sdl3$(SYS).obf :  src/$(SYS)lib.hpp src/sdl3$(SYS).cpp src/sdl3.cpp

build/Ext.SDL3TTF.obf : src/Ext.SDL3TTF.mod
build/sdl3ttf$(SYS).obf :  src/$(SYS)lib.hpp src/sdl3ttf$(SYS).cpp src/sdl3ttf.cpp

extsqlite.lib : build/Ext.Sqlite.obf build/sqlite$(SYS).obf
	@echo linking $@
	@-rm $@
	@touch $@
	@linklib $^ $@

testsqlite$(PRG): misc/testsqlite.mod extsqlite.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/testsqlite.mod .
	@cd build && ecsd -r std.lib $(RTS) ../extsqlite.lib testsqlite.mod
	@cp build/testsqlite$(PRG) testsqlite$(PRG)
	@./testsqlite$(PRG)

extsdl3.lib : build/Ext.SDL3.obf build/sdl3$(SYS).obf build/sdlwrap$(SYS).obf build/wrap$(SYS).obf
	@echo linking $@
	@-rm $@
	@touch $@
	@linklib $^ $@

testsdl3$(PRG): misc/testsdl3.mod extsdl3.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/testsdl3.mod .
	@cd build && ecsd -r std.lib $(RTS) ../extsdl3.lib testsdl3.mod
	@cp build/testsdl3$(PRG) testsdl3$(PRG)
	@$(EXEC) ./testsdl3$(PRG)

extsdl3ttf.lib : build/Ext.SDL3TTF.obf build/sdl3ttf$(SYS).obf build/sdlttfwrap$(SYS).obf build/wrap$(SYS).obf
	@echo linking $@
	@-rm $@
	@touch $@
	@linklib $^ $@

testsdl3ttf$(PRG): misc/testsdl3ttf.mod extsdl3ttf.lib extsdl3.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/testsdl3ttf.mod .
	@cd build && ecsd -r std.lib $(RTS) ../extsdl3ttf.lib ../extsdl3.lib testsdl3ttf.mod
	@cp build/testsdl3ttf$(PRG) testsdl3ttf$(PRG)
	@$(EXEC) ./testsdl3ttf$(PRG)

editbox$(PRG): misc/editbox.mod extsdl3ttf.lib extsdl3.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/editbox.mod .
	@cd build && ecsd -r std.lib $(RTS) ../extsdl3ttf.lib ../extsdl3.lib editbox.mod
	@cp build/editbox$(PRG) editbox$(PRG)
	@$(EXEC) ./editbox$(PRG)
		
.PHONY: install
install: extsqlite.lib extsdl3.lib extsdl3ttf.lib
	@echo Install
	@cp -f extsqlite.lib $(PREFIX)/lib/ecs/runtime/
	@cp -f extsdl3.lib $(PREFIX)/lib/ecs/runtime/
	@cp -f extsdl3ttf.lib $(PREFIX)/lib/ecs/runtime/
	@cp -f build/ext.*.sym $(PREFIX)/lib/ecs/libraries/oberon/
	
.PHONY: clean
clean:
	@echo Clean
	@-rm -rf build
	@-rm testsqlite$(PRG) testsdl3$(PRG) testsdl3ttf$(PRG) editbox$(PRG)