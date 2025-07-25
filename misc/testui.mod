MODULE Test;

IN Ext IMPORT UI;

PROCEDURE OnClick();
BEGIN TRACE("Button clicked!");
END OnClick;

PROCEDURE OnClosing(): INTEGER;
BEGIN
    UI.Quit();
    RETURN 0
END OnClosing;

PROCEDURE Test();
VAR
    a : UI.App; w : UI.Window;
    b : UI.Button;
BEGIN
    UI.InitApp(a);
    UI.InitWindow(w, "Hello World!", 300, 30, FALSE);
    UI.InitButton(b, "ClickMe!");
    b.OnClicked(OnClick);
    w.OnClosing(OnClosing);
    w.SetChild(b);
    w.Show();
    a.Main();
    a.Destroy();
END Test;

BEGIN
    Test();
END Test.