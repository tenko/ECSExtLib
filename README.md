# ECSExtLib

The **[ECS](https://ecs.openbrace.org/)** extension library wraps the following libraries:
 
 * Bindings for the [SQLite](https://www.sqlite.org/) embedded database library.
 * Bindings for the [SDL3](https://wiki.libsdl.org/SDL3/FrontPage) cross platform game/application library.
 * Bindings for the [SDL3_ttf](https://wiki.libsdl.org/SDL3_ttf/FrontPage) cross platform font library.
 
OS support is covered for the **Windows** and **Linux** platforms.
For now only `X86_64` variants are supported.

The bindings expect the `.dll/.so` file to be present on the system.

Example of use is found in the `misc` folder.

## Building & Running tests

Build instructions here are for a current **ArchLinux** version, but should
be possible to adapt to other **Linux** distributions.

Windows **MSYS2** (CLANG64) also can follow these instructions and
is known to work well, but is much slower than on **Linux**.

```shell
# Build and install patched version of ECS
pacman -S base-devel gcc wget # Windows : run from MSYS2 shell
wget https://software.openbrace.org/attachments/download/418/ecs-2026.08.10.tar.gz
wget https://software.openbrace.org/attachments/download/420/install.patch
wget https://software.openbrace.org/attachments/download/421/msys.patch
wget https://software.openbrace.org/attachments/download/424/trace.patch
tar -xavf ecs-2026.08.10.tar.gz
cd ecs
patch -p0 < ../install.patch
patch -p0 < ../msys.patch
patch -p0 < ../trace.patch
make all # adjust -j argument to your CPU core count for faster compilation
make prefix=~/.local install
make clean
# add to PATH variable (adapt to your shell and setup)
echo 'export PATH=~/.local/bin/:~/.local/lib/ecs/tools/:$PATH' >> ~/.bashrc
echo 'export ECSBASE=~/.local/lib/ecs/' >> ~/.bashrc
cd ..
# Optional install also ECSStdLib to run testsqlite
# Build and test ECSExtLib
pacman -S sdl3 sdl3_ttf sqlite3
git clone https://github.com/tenko/ECSExtLib.git
cd ECSExtLib
make # build extsdl3.lib, extsdl3ttf.lib and extsqlite.lib
make PREFIX=~/.local install # install to ~/.local/lib
make testsqlite # run sqlite test (use testsqlite.exe on Windows)
make testsdl3 # run sdl3 test (use testsdl3.exe on Windows)
make testsdl3ttf # run sdl3ttf test (use testsdl3ttf.exe on Windows)
make editbox # run editbox test (use editbox.exe on Windows)
```

## TODO

This is an initial version which will be expanded as functionality needed.

# License
The files src/linuxlib.hpp & src/winlib.hpp are covered
by the ECS Runtime Support Exception.

Otherwise files are covered by the MIT license,
Copyright (c) 2025,  Runar Tenfjord
