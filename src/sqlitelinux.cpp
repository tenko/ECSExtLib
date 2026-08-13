// SQLITE API wrapper for Linux
#include <def/linuxlib>
LIBRARY (sqlite, "libsqlite3.so")
#define SQLITEFUNCTION(name, parameters) FUNCTION (sqlite, name, parameters)
#include "sqlite.cpp"