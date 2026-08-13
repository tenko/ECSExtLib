// SDL3TTF API wrapper for Linux
#include <def/linuxlib>
LIBRARY (sdl3ttf, "libSDL3_ttf.so")
#define SDL3FUNCTION(name, parameters) FUNCTION (sdl3ttf, name, parameters)
// #define SDL3FUNCTIONVAR(name, variant) FUNCTIONVAR (sdl3ttf, name, variant)
// #define SDL3FUNCTIONRAW(name, parameters) FUNCTIONRAW (sdl3ttf, name)
#include "sdl3ttf.cpp"