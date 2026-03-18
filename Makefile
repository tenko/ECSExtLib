.SUFFIXES:
MAKEFLAGS += --no-builtin-rules --no-builtin-variables

ifdef MSYSTEM
	PRG = .exe
	SYS = win
	DESTDIR = /c/EigenCompilerSuite/
	ECS = /c/EigenCompilerSuite/runtime
	RTS = $(ECS)/win64api.obf
else
	PRG = 
	SYS = linux
	DESTDIR = ~/.local/lib/ecs/
	ECS = ~/.local/lib/ecs/runtime
	RTS = 
endif

.PHONY: all
all : extsqlite.lib extsdl3.lib

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
	@cd build && ecsd -c $(notdir $<)

build/sdl3$(SYS).obf: src/sdl3$(SYS).cpp
	@echo building $@:
	@mkdir -p build
	@cd build && cp ../src/$(SYS)lib.hpp .
	@cd build && cp ../src/sdl3.cpp .
	@cd build && cp ../src/sdl3$(SYS).cpp .
	@cd build && ecsd -c $(notdir $<)

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
	@cd build && ecsd $(notdir $<) ../extsqlite.lib $(ECS)/std.lib $(RTS)
	@cp build/testsqlite$(PRG) testsqlite$(PRG)
	@./testsqlite$(PRG)

extsdl3.lib : build/Ext.SDL3.obf build/sdl3$(SYS).obf build/sdlwrap$(SYS).obf
	@echo linking $@
	@-rm $@
	@touch $@
	@linklib $@ $^

testsdl3$(PRG): misc/testsdl3.mod extsdl3.lib
	@echo building $@
	@mkdir -p build
	@cd build && cp -f ../misc/testsdl3.mod .
	@cd build && ecsd $(notdir $<) ../extsdl3.lib $(ECS)/std.lib $(RTS)
	@cp build/testsdl3$(PRG) testsdl3$(PRG)
	@./testsdl3$(PRG)

.PHONY: install
install: extsqlite.lib extsdl3.lib
	@echo Install
	@cp -f extsqlite.lib $(DESTDIR)runtime/
	@cp -f extsdl3.lib $(DESTDIR)runtime/
	@cp -f build/ext.*.sym $(DESTDIR)libraries/oberon/
	
.PHONY: clean
clean:
	@echo Clean
	@-rm -rf build
	@-rm testsqlite$(PRG) testsdl3$(PRG)