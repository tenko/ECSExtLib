MODULE Sqlite IN Ext;

IMPORT SYSTEM;

CONST
    OPEN_READONLY* 	    = 00000001H;
    OPEN_READWRITE*	    = 00000002H;
    OPEN_CREATE* 		= 00000004H;
    OPEN_URI* 			= 00000040H;
    OPEN_MEMORY* 		= 00000080H;
    TINTEGER* 			= 1;
    TFLOAT*  			= 2;
    TTEXT*  			= 3;
    TBLOB*  			= 4;
    TNULL*  			= 5;
    ROW*                = 100;
    DONE*				= 101;

TYPE
    ADDRESS = SYSTEM.ADDRESS;
    Db* = RECORD-
        db : ADDRESS;
    END;

    Stmt* = RECORD-
        stmt : ADDRESS;
    END;
    
PROCEDURE ^ libversion_number ["sqlite3_libversion_number"] (): INTEGER;
PROCEDURE ^ errmsg ["sqlite3_errmsg"] (db : ADDRESS): ADDRESS;
PROCEDURE ^ open_v2 ["sqlite3_open_v2"] (filename: ADDRESS; db : ADDRESS; flags : INTEGER; zVfs : ADDRESS): INTEGER;
PROCEDURE ^ exec ["sqlite3_exec"] (db, sql, callback, arg, errmsg : ADDRESS): INTEGER;
PROCEDURE ^ close ["sqlite3_close"] (db : ADDRESS): INTEGER;
PROCEDURE ^ prepare ["sqlite3_prepare_v2"] (db, sql : ADDRESS; nbyte: INTEGER; stmtref, tail: ADDRESS): INTEGER;
PROCEDURE ^ bind_double ["sqlite3_bind_double"] (stmt : ADDRESS; col : INTEGER; value : REAL): INTEGER;
PROCEDURE ^ bind_int ["sqlite3_bind_int"] (stmt : ADDRESS; col : INTEGER; value : INTEGER): INTEGER;
PROCEDURE ^ bind_int64 ["sqlite3_bind_int64"] (stmt : ADDRESS; col : INTEGER; value : HUGEINT): INTEGER;
PROCEDURE ^ bind_text ["sqlite3_bind_text"] (stmt : ADDRESS; col : INTEGER; value : ADDRESS; nbyte : INTEGER; ptr : ADDRESS): INTEGER;
PROCEDURE ^ bind_null ["sqlite3_bind_null"] (stmt : ADDRESS; col : INTEGER): INTEGER;
PROCEDURE ^ step ["sqlite3_step"] (stmt : ADDRESS): INTEGER;
PROCEDURE ^ finalize ["sqlite3_finalize"] (stmt : ADDRESS): INTEGER;
PROCEDURE ^ reset ["sqlite3_reset"] (stmt : ADDRESS): INTEGER;
PROCEDURE ^ column_count ["sqlite3_column_count"] (stmt : ADDRESS): INTEGER;
PROCEDURE ^ data_count ["sqlite3_data_count"] (stmt : ADDRESS): INTEGER;
PROCEDURE ^ column_type ["sqlite3_column_type"] (stmt : ADDRESS; col : INTEGER): INTEGER;
PROCEDURE ^ column_double ["sqlite3_olumn_double"] (stmt : ADDRESS; col : INTEGER): REAL;
PROCEDURE ^ column_int ["sqlite3_column_int"] (stmt : ADDRESS; col : INTEGER): INTEGER;
PROCEDURE ^ column_int64 ["sqlite3_column_int64"] (stmt : ADDRESS; col : INTEGER): HUGEINT;
PROCEDURE ^ column_text ["sqlite3_column_text"] (stmt : ADDRESS; col : INTEGER): ADDRESS;
    
PROCEDURE Version*(): INTEGER;
BEGIN RETURN libversion_number() END Version;

(**
Open a connection to a new or existing `SQLite` database
with mode defined in `options`. If options is equal to 0
then mode defaults to OPEN_READWRITE + OPEN_CREATE.

Return `TRUE` on success.
*)
PROCEDURE (VAR this : Db) Open*(filename- : ARRAY OF CHAR; options : INTEGER): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    IF options = 0 THEN options := OPEN_READWRITE + OPEN_CREATE END;
    this.db := 0;
    IF filename[0] = 00X THEN
        ret := open_v2(0, SYSTEM.ADR(this.db), options, 0);
    ELSE
        ret := open_v2(SYSTEM.ADR(filename), SYSTEM.ADR(this.db), options, 0);
    END;
    RETURN ret = 0;
END Open;

(**
Return length of last error message.
Return 0 on failure.
*)
PROCEDURE (VAR this : Db) ErrorMessageLength*(): LENGTH;
VAR
    adr : ADDRESS;
    ch : CHAR;
    i : LENGTH;
BEGIN
    adr := errmsg(this.db);
    IF adr = 0 THEN RETURN 0 END;
    i := 0;
    LOOP
        SYSTEM.GET(adr, ch);
        IF ch = 00X THEN EXIT END;
        INC(i); INC(adr);
    END;
    RETURN i;
END ErrorMessageLength;

(**
Set `str` to last error message.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Db) ErrorMessage*(VAR str : ARRAY OF CHAR): BOOLEAN;
VAR
    adr : ADDRESS;
    ch : CHAR;
    i : LENGTH;
BEGIN
    adr := errmsg(this.db);
    IF adr = 0 THEN RETURN FALSE END;
    FOR i := 0 TO LEN(str) - 1 DO
        SYSTEM.GET(adr, ch);
        IF ch = 00X THEN
            str[i] := 00X;
            RETURN TRUE;
        END;
        str[i] := ch;
        INC(adr);
    END;
    RETURN FALSE;
END ErrorMessage;

(**
Execute sql statment or script.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Db) Execute*(sql- : ARRAY OF CHAR): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := exec(this.db, SYSTEM.ADR(sql), 0, 0, 0);
    RETURN ret = 0;
END Execute;

(** Close database *)
PROCEDURE (VAR this : Db) Close*();
BEGIN IGNORE(close(SYSTEM.ADR(this.db)));
END Close;

(**
Prepare sql statment.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Db) Prepare*(VAR stmt: Stmt; sql- : ARRAY OF CHAR): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := prepare(this.db, SYSTEM.ADR(sql), -1, SYSTEM.ADR(stmt.stmt), 0);
    RETURN ret = 0;
END Prepare;

(**
Bind `REAL` value to column col.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Stmt) BindReal*(col : INTEGER; value : REAL): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := bind_double(this.stmt, col, value);
    RETURN ret = 0;
END BindReal;

(**
Bind `INTEGER` value to column col.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Stmt) BindInteger*(col : INTEGER; value : INTEGER): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := bind_int(this.stmt, col, value);
    RETURN ret = 0;
END BindInteger;

(**
Bind `HUGEINT` value to column col.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Stmt) BindHugeInt*(col : INTEGER; value : HUGEINT): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := bind_int64(this.stmt, col, value);
    RETURN ret = 0;
END BindHugeInt;

(**
Bind `ARRAY OF CHAR` value to column col.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Stmt) BindText*(col : INTEGER; value- : ARRAY OF CHAR): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := bind_text(this.stmt, col, SYSTEM.ADR(value), -1, 0);
    RETURN ret = 0;
END BindText;

(**
Bind `NULL` value to column col.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Stmt) BindNull*(col : INTEGER): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := bind_null(this.stmt, col);
    RETURN ret = 0;
END BindNull;

(**
Evaluate the prepared statement and return status.
 
 * `DONE` if finished.
 * `ROW` if further rows exists.

Any other value indicate an error.
*)
PROCEDURE (VAR this : Stmt) Step*(): INTEGER;
BEGIN RETURN step(this.stmt);
END Step;

(** Finalize prepared statment and release resources. *)
PROCEDURE (VAR this : Stmt) Finalize*(): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := finalize(this.stmt);
    RETURN ret = 0;
END Finalize;

(** Reset prepared statment for further processing.*)
PROCEDURE (VAR this : Stmt) Reset*(): BOOLEAN;
VAR ret : INTEGER;
BEGIN
    ret := reset(this.stmt);
    RETURN ret = 0;
END Reset;

(** Result set column count *)
PROCEDURE (VAR this : Stmt) ColumnCount*(): INTEGER;
BEGIN RETURN column_count(this.stmt);
END ColumnCount;

(** Result set row count *)
PROCEDURE (VAR this : Stmt) DataCount*(): INTEGER;
BEGIN RETURN data_count(this.stmt);
END DataCount;

(**
Column data type:

 * `TINTEGER`
 * `TFLOAT`
 * `TTEXT`
 * `TBLOB`
 * `TNULL`
*)
PROCEDURE (VAR this : Stmt) ColumnType*(col : INTEGER): INTEGER;
BEGIN RETURN column_type(this.stmt, col);
END ColumnType;

(**
Return `INTEGER` in column col.

This function will try to cast the type and is
possible undefined if this fails.
*)
PROCEDURE (VAR this : Stmt) ColumnInt*(col : INTEGER): INTEGER;
BEGIN RETURN column_int(this.stmt, col);
END ColumnInt;

(**
Return `HUGEINT` in column col.

This function will try to cast the type and is
possible undefined if this fails.
*)
PROCEDURE (VAR this : Stmt) ColumnHugeInt*(col : LONGINT): HUGEINT;
BEGIN RETURN column_int64(this.stmt, col);
END ColumnHugeInt;

(**
Return `REAL` in column col.

This function will try to cast the type and is
possible undefined if this fails.
*)
PROCEDURE (VAR this : Stmt) ColumnReal*(col : INTEGER): REAL;
BEGIN RETURN column_double(this.stmt, col);
END ColumnReal;

(**
Return length of `TEXT` column.
Return 0 on failure.
*)
PROCEDURE (VAR this : Stmt) ColumnTextLength*(col : INTEGER): LENGTH;
VAR
    adr : ADDRESS;
    ch : CHAR;
    i : LENGTH;
BEGIN
    adr := column_text(this.stmt, col);
    IF adr = 0 THEN RETURN 0 END;
    i := 0;
    LOOP
        SYSTEM.GET(adr, ch);
        IF ch = 00X THEN EXIT END;
        INC(i); INC(adr);
    END;
    RETURN i;
END ColumnTextLength;

(**
Set `str` to `TEXT` in column col.
Return `TRUE` on success.
*)
PROCEDURE (VAR this : Stmt) ColumnText*(VAR str : ARRAY OF CHAR; col : INTEGER): BOOLEAN;
VAR
    adr : ADDRESS;
    ch : CHAR;
    i : LENGTH;
BEGIN
    adr := column_text(this.stmt, col);
    IF adr = 0 THEN RETURN FALSE END;
    FOR i := 0 TO LEN(str) - 1 DO
        SYSTEM.GET(adr, ch);
        IF ch = 00X THEN
            str[i] := 00X;
            RETURN TRUE;
        END;
        str[i] := ch;
        INC(adr);
    END;
    RETURN FALSE;
END ColumnText;

END Sqlite.