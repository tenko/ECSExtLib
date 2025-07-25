MODULE Test;

IN Std IMPORT Const, OSStream;
IN Ext IMPORT Sqlite;

PROCEDURE Test*();
CONST
    sql = "
        DROP TABLE IF EXISTS Cars;
        CREATE TABLE Cars(Id INT, Name TEXT, Price INT);
        INSERT INTO Cars VALUES(1, 'Audi', 52642);
        INSERT INTO Cars VALUES(2, 'Mercedes', 57127);
        INSERT INTO Cars VALUES(3, 'Skoda', 9000);
        INSERT INTO Cars VALUES(4, 'Volvo', 29000);
        INSERT INTO Cars VALUES(5, 'Bentley', 350000);
        INSERT INTO Cars VALUES(6, 'Citroen', 21000);
        INSERT INTO Cars VALUES(7, 'Hummer', 41400);
        INSERT INTO Cars VALUES(8, 'Volkswagen', 21600);
    ";
VAR
    db : Sqlite.Db;
    stmt : Sqlite.Stmt;
    s : ARRAY 64 OF CHAR;
    
    PROCEDURE Error();
    VAR msg : ARRAY 256 OF CHAR;
    BEGIN
        IF db.ErrorMessage(msg) THEN
            OSStream.StdErr.WriteString(msg); OSStream.StdErr.WriteNL;
        ELSE
            OSStream.StdErr.WriteString("unknown error"); OSStream.StdErr.WriteNL;
        END;
        IGNORE(stmt.Finalize());
        db.Close();
    END Error;
BEGIN
    IF ~db.Open("", 0) THEN TRACE("Failed to open database"); RETURN END;
    IF ~db.Execute(sql) THEN Error(); RETURN END;
    IF ~db.Prepare(stmt, "SELECT * from Cars WHERE Price > ?;") THEN Error(); RETURN END;
    IF ~stmt.BindInteger(1, 9000) THEN Error(); RETURN END;
    OSStream.StdOut.WriteString("ID      Name    Price   "); OSStream.StdOut.WriteNL;
    OSStream.StdOut.WriteString("------------------------"); OSStream.StdOut.WriteNL;
    WHILE stmt.Step() # Sqlite.DONE DO
        OSStream.StdOut.FormatInteger(stmt.ColumnInt(0), 2, {});
        IGNORE(stmt.ColumnText(s, 1));
        OSStream.StdOut.FormatString(s, 12, 0, Const.Right);
        OSStream.StdOut.FormatInteger(stmt.ColumnInt(2), 8, {});
        OSStream.StdOut.WriteNL;
    END;
    db.Close();
END Test;
    
BEGIN
    Test();
END Test.