// SQLITE API wrapper for Windows
#include <def/winlib>
LIBRARY (sqlite, "sqlite3.dll")
#define SQLITEFUNCTION(name, parameters) FUNCTION (sqlite, name, parameters)
#include "sqlite.cpp"