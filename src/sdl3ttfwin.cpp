// SDL3TTF API wrapper for Windows
#include <def/winlib>
LIBRARY (sdl3ttf, "SDL3_ttf.dll")
#define SDL3FUNCTION(name, parameters) FUNCTION (sdl3ttf, name, parameters)
#include "winlib.hpp"
#define SDL3FUNCTIONVAR(name, variant) FUNCTIONVAR (sdl3, name, variant)
#define SDL3FUNCTIONRAW(name, parameters) FUNCTIONRAW (sdl3, name)
#include "sdl3ttf.cpp"