// SDL3 API wrapper for Linux
#include <def/linuxlib>
LIBRARY (sdl3, "libSDL3.so")
#define SDL3FUNCTION(name, parameters) FUNCTION (sdl3, name, parameters)
// #define SDL3FUNCTIONVAR(name, variant) FUNCTIONVAR (sdl3, name, variant)
// #define SDL3FUNCTIONRAW(name, parameters) FUNCTIONRAW (sdl3, name)
#include "sdl3.cpp"