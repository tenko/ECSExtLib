MODULE Test;

IMPORT SYSTEM;
IN Ext IMPORT SDL3;
IN Ext IMPORT SDL3TTF;

CONST FONT = '/usr/share/fonts/TTF/Inconsolata-Regular.ttf';

TYPE
    EditBox = RECORD
        window : SDL3.PtrWindow;
        renderer : SDL3.PtrRenderer;
        font : SDL3TTF.PtrFont;
        text : SDL3TTF.PtrText;
        rect : SDL3.FRect;
        has_focus : BOOLEAN;
        (* Cursor support *)
        cursor : INTEGER;
        cursor_length : INTEGER;
        cursor_visible : BOOLEAN;
        last_cursor_change : SDL3.Uint64;
        cursor_rect : SDL3.FRect;
        (* Highlight support *)
        highlighting : BOOLEAN;
        highlight1 : INTEGER;
        highlight2 : INTEGER;
        (* IME composition *)
        composition_start : INTEGER;
        composition_length : INTEGER;
        composition_cursor : INTEGER;
        composition_cursor_length : INTEGER;
        (* IME candidates *)
        candidates : SDL3TTF.PtrText;
        selected_candidate_start : INTEGER;
        selected_candidate_length : INTEGER;
    END;

PROCEDURE Create(VAR edit : EditBox; window : SDL3.PtrWindow; renderer : SDL3.PtrRenderer; engine : SDL3TTF.PtrTextEngine; font : SDL3TTF.PtrFont; rect- : SDL3.FRect): BOOLEAN;
BEGIN
    edit.window := window;
    edit.renderer := renderer;
    edit.font := font;
    edit.text := SDL3TTF.CreateText(engine, font, "", 0);
    IF edit.text = NIL THEN RETURN FALSE END;
    edit.rect := rect;
    edit.has_focus := FALSE;
    edit.highlight1 := -1;
    edit.highlight2 := -1;
    
    (* Wrap the editbox text within the editbox area *)
    IGNORE(SDL3TTF.SetTextWrapWidth(edit.text, INTEGER(SDL3.floorf(rect.w))));

    (* Show the whitespace when wrapping, so it can be edited *)
    IGNORE(SDL3TTF.SetTextWrapWhitespaceVisible(edit.text, TRUE));
    
    (* We support rendering the composition and candidates *)
    IGNORE(SDL3.SetHint(SDL3.HINT_IME_IMPLEMENTED_UI, "composition,candidates"));
    RETURN TRUE
END Create;

PROCEDURE (VAR edit: EditBox) Destroy();
BEGIN SDL3TTF.DestroyText(edit.text)
END Destroy;

PROCEDURE UTF8ByteLength(text : POINTER TO VAR CHAR; num_codepoints : INTEGER): INTEGER;
VAR
    start : POINTER TO VAR CHAR;
    ch : SDL3.Uint32;
BEGIN
    start := text;
    LOOP
        IF num_codepoints <= 0 THEN EXIT END;
        ch := SDL3.StepUTF8(SYSTEM.ADR(text), NIL);
        IF ch = 0 THEN EXIT END;
        DEC(num_codepoints)
    END;
    RETURN INTEGER(SYSTEM.VAL(SYSTEM.ADDRESS, text) - SYSTEM.VAL(SYSTEM.ADDRESS, start))
END UTF8ByteLength;

PROCEDURE (VAR edit: EditBox) ResetComposition();
BEGIN
    edit.composition_start := 0;
    edit.composition_length := 0;
    edit.composition_cursor := 0;
    edit.composition_cursor_length := 0;
END ResetComposition;

PROCEDURE (VAR edit: EditBox) CancelComposition();
BEGIN
    edit.ResetComposition();
    IGNORE(SDL3.ClearComposition(edit.window));
END CancelComposition;

PROCEDURE (VAR edit: EditBox) GetCursorTextIndex(x : INTEGER; substring- : SDL3TTF.SubString): INTEGER;
VAR
    round_down : BOOLEAN;
BEGIN
    IF SET32(substring.flags) * SET32(SDL3TTF.SUBSTRING_LINE_END + SDL3TTF.SUBSTRING_TEXT_END) # {} THEN
        RETURN substring.offset
    END;
    round_down := x < (substring.rect.x + substring.rect.w DIV 2);
    IF round_down THEN
        (* Start the cursor before the selected text *)
        RETURN substring.offset
    ELSE
        (* Place the cursor after the selected text *)
        RETURN substring.offset + substring.length
    END;
END GetCursorTextIndex;

PROCEDURE (VAR edit: EditBox) SetCursorPosition(position : INTEGER);
BEGIN
    IF edit.composition_length > 0 THEN
        (* Don't let the cursor be moved into the composition *)
        IF (position >= edit.composition_start) & (position <= (edit.composition_start + edit.composition_length)) THEN
            RETURN
        END;
        edit.CancelComposition();
    END;
    edit.cursor := position;
END SetCursorPosition;

PROCEDURE (VAR edit: EditBox) MoveCursorIndex(direction : INTEGER);
VAR
    substring : SDL3TTF.SubString;
BEGIN
    IF direction < 0 THEN
        IF SDL3TTF.GetTextSubString(edit.text, edit.cursor - 1, substring) THEN
            edit.SetCursorPosition(substring.offset)
        END;
    ELSE
        IF SDL3TTF.GetTextSubString(edit.text, edit.cursor - 1, substring) &
           SDL3TTF.GetTextSubString(edit.text, substring.offset + SEL(substring.length > 1, substring.length, 1), substring) THEN
            edit.SetCursorPosition(substring.offset)
        END;
    END;
END MoveCursorIndex;

PROCEDURE (VAR edit: EditBox) MoveCursorLeft;
BEGIN edit.MoveCursorIndex(-1);
END MoveCursorLeft;

PROCEDURE (VAR edit: EditBox) MoveCursorRight;
BEGIN edit.MoveCursorIndex(1);
END MoveCursorRight;

PROCEDURE (VAR edit: EditBox) MoveCursorUp;
VAR
    substring : SDL3TTF.SubString;
    fontHeight, x, y : INTEGER;
BEGIN
    IF SDL3TTF.GetTextSubString(edit.text, edit.cursor, substring) THEN
        fontHeight := SDL3TTF.GetFontHeight(edit.font);
        x := substring.rect.x;
        y := substring.rect.y - fontHeight DIV 2;
        IF SDL3TTF.GetTextSubStringForPoint(edit.text, x, y, substring) THEN
            edit.SetCursorPosition(edit.GetCursorTextIndex(x, substring))
        END;
    END;
END MoveCursorUp;

PROCEDURE (VAR edit: EditBox) MoveCursorDown;
VAR
    substring : SDL3TTF.SubString;
    fontHeight, x, y : INTEGER;
BEGIN
    IF SDL3TTF.GetTextSubString(edit.text, edit.cursor, substring) THEN
        fontHeight := SDL3TTF.GetFontHeight(edit.font);
        x := substring.rect.x;
        y := substring.rect.y + substring.rect.h + fontHeight DIV 2;
        IF SDL3TTF.GetTextSubStringForPoint(edit.text, x, y, substring) THEN
            edit.SetCursorPosition(edit.GetCursorTextIndex(x, substring))
        END;
    END;
END MoveCursorDown;

PROCEDURE (VAR edit: EditBox) MoveCursorBeginningOfLine;
VAR
    substring : SDL3TTF.SubString;
BEGIN
    IF SDL3TTF.GetTextSubString(edit.text, edit.cursor, substring) THEN
        IF SDL3TTF.GetTextSubStringForLine(edit.text, substring.line_index, substring) THEN
            edit.SetCursorPosition(substring.offset)
        END;
    END;
END MoveCursorBeginningOfLine;

PROCEDURE (VAR edit: EditBox) MoveCursorEndOfLine;
VAR
    substring : SDL3TTF.SubString;
BEGIN
    IF SDL3TTF.GetTextSubString(edit.text, edit.cursor, substring) THEN
        IF SDL3TTF.GetTextSubStringForLine(edit.text, substring.line_index, substring) THEN
            edit.SetCursorPosition(substring.offset + substring.length)
        END;
    END;
END MoveCursorEndOfLine;

PROCEDURE (VAR edit: EditBox) MoveCursorBeginning;
BEGIN
    (* Move to the beginning of the text *)
    edit.SetCursorPosition(0)
END MoveCursorBeginning;

PROCEDURE (VAR edit: EditBox) MoveCursorEnd;
BEGIN
    (* Move to the end of the text *)
    IF edit.text.text # NIL THEN
        edit.SetCursorPosition(INTEGER(SDL3.strlen(edit.text.text)))
    END
END MoveCursorEnd;

PROCEDURE (VAR edit: EditBox) GetHighlightExtents(VAR marker, length : INTEGER): BOOLEAN;
VAR
    marker1, marker2 : INTEGER;
BEGIN
    IF (edit.highlight1 >= 0) & (edit.highlight2 >= 0) THEN
        marker1 := SEL(edit.highlight1 < edit.highlight2, edit.highlight1, edit.highlight2);
        marker2 := SEL(edit.highlight1 > edit.highlight2, edit.highlight1, edit.highlight2);
        IF marker2 > marker1 THEN
            marker := marker1;
            length := marker2 - marker1;
            RETURN TRUE
        END;
    END;
    RETURN FALSE;
END GetHighlightExtents;

PROCEDURE (VAR edit: EditBox) DeleteHighlight(): BOOLEAN;
VAR
    marker, length : INTEGER;
BEGIN
    IF edit.GetHighlightExtents(marker, length) THEN
        IGNORE(SDL3TTF.DeleteTextString(edit.text, marker, length));
        edit.SetCursorPosition(marker);
        edit.highlight1 := -1;
        edit.highlight2 := -1;
        RETURN TRUE;
    END;
    RETURN FALSE;
END DeleteHighlight;

PROCEDURE (VAR edit: EditBox) Backspace;
VAR
    start, next : SYSTEM.ADDRESS;
    length : INTEGER;
BEGIN
    IF edit.text.text = NIL THEN
        RETURN
    END;
    IF edit.DeleteHighlight() THEN
        RETURN
    END;
    IF edit.cursor > 0 THEN
        start := SYSTEM.VAL(SYSTEM.ADDRESS, edit.text.text) + edit.cursor;
        next := start;
        IGNORE(SDL3.StepBackUTF8(edit.text.text, SYSTEM.ADR(next)));
        length := INTEGER(start - next);
        IGNORE(SDL3TTF.DeleteTextString(edit.text, edit.cursor - length, length));
        edit.cursor := edit.cursor - length;
    END;
END Backspace;

PROCEDURE (VAR edit: EditBox) BackspaceToBeginning;
BEGIN
    (* Delete to the beginning of the string *)
    IGNORE(SDL3TTF.DeleteTextString(edit.text, 0, edit.cursor));
    edit.SetCursorPosition(0)
END BackspaceToBeginning;

PROCEDURE (VAR edit: EditBox) DeleteToEnd;
BEGIN
    (* Delete to the end of the string *)
    IGNORE(SDL3TTF.DeleteTextString(edit.text, edit.cursor, -1));
END DeleteToEnd;

PROCEDURE (VAR edit: EditBox) Delete;
VAR
    start, next : SYSTEM.ADDRESS;
    length : LENGTH;
BEGIN
    IF edit.text.text = NIL THEN
        RETURN
    END;
    IF edit.DeleteHighlight() THEN
        RETURN
    END;
    IF edit.cursor > 0 THEN
        start := SYSTEM.VAL(SYSTEM.ADDRESS, edit.text.text) + edit.cursor;
        next := start;
        length := SDL3.strlen(edit.text.text) - edit.cursor;
        IGNORE(SDL3.StepUTF8(SYSTEM.ADR(next), PTR(length)));
        length := LENGTH(start - next);
        IGNORE(SDL3TTF.DeleteTextString(edit.text, edit.cursor, INTEGER(length)));
    END;
END Delete;

PROCEDURE (VAR edit: EditBox) SelectAll;
BEGIN
    IF edit.text.text = NIL THEN
        RETURN
    END;
    edit.highlight1 := 0;
    edit.highlight2 := INTEGER(SDL3.strlen(edit.text.text));
END SelectAll;

PROCEDURE (VAR edit: EditBox) Copy;
VAR
    temp : POINTER TO ARRAY OF CHAR;
    marker, length : INTEGER;
BEGIN
    IF edit.text.text = NIL THEN
        RETURN
    END;
    IF edit.GetHighlightExtents(marker, length) THEN
        NEW(temp, length + 1);
        IF temp # NIL THEN
            IGNORE(SDL3.memcpy(SYSTEM.ADR(temp^[0]), SYSTEM.VAL(SYSTEM.ADDRESS, edit.text.text) + marker, length));
            temp[length] := 00X;
            IGNORE(SDL3.SetClipboardText(PTR(temp[0])));
            DISPOSE(temp);
        END;
    ELSE
        IGNORE(SDL3.SetClipboardText(edit.text.text));
    END;
END Copy;

PROCEDURE (VAR edit: EditBox) Cut;
VAR
    temp : POINTER TO ARRAY OF CHAR;
    marker, length : INTEGER;
BEGIN
    IF edit.text.text = NIL THEN
        RETURN
    END;
    (* Copy to clipboard and delete text *)
    IF edit.GetHighlightExtents(marker, length) THEN
        NEW(temp, length + 1);
        IF temp # NIL THEN
            IGNORE(SDL3.memcpy(SYSTEM.ADR(temp^[0]), SYSTEM.VAL(SYSTEM.ADDRESS, edit.text.text) + marker, length));
            temp[length] := 00X;
            IGNORE(SDL3.SetClipboardText(PTR(temp[0])));
            DISPOSE(temp);
        END;
        IGNORE(SDL3TTF.DeleteTextString(edit.text, marker, length));
        edit.SetCursorPosition(marker);
        edit.highlight1 := -1;
        edit.highlight2 := -1;
    ELSE
        IGNORE(SDL3.SetClipboardText(edit.text.text));
        IGNORE(SDL3TTF.DeleteTextString(edit.text, 0, -1));
    END;
END Cut;

PROCEDURE (VAR edit: EditBox) Insert(text-: ARRAY OF CHAR);
VAR
    length : LENGTH;
BEGIN
    IF text = "" THEN
        RETURN
    END;
    IGNORE(edit.DeleteHighlight());
    IF edit.composition_length > 0 THEN
        IGNORE(SDL3TTF.DeleteTextString(edit.text, edit.composition_start, edit.composition_length));
        edit.composition_length := 0;
    END;
    length := SDL3.strlen(PTR(text[0]));
    IGNORE(SDL3TTF.InsertTextString(edit.text, edit.cursor, text, length));
    edit.SetCursorPosition(INTEGER(edit.cursor + length));
END Insert;

PROCEDURE (VAR edit: EditBox) Paste;
VAR
    text : SDL3.STRING;
BEGIN
    IGNORE(SDL3.GetClipboardText(text));
    IF text # NIL THEN
        edit.Insert(text^);
        DISPOSE(text);
    END;
END Paste;

PROCEDURE (VAR edit: EditBox) DrawText(text : SDL3TTF.PtrText; x : REAL32; y : REAL32);
BEGIN IGNORE(SDL3TTF.DrawRendererText(text, x, y));
END DrawText;

PROCEDURE (VAR edit: EditBox) Draw();
VAR
    x, y : REAL32;
BEGIN
    x := edit.rect.x;
    y := edit.rect.y;
    edit.DrawText(edit.text, x, y);
END Draw;

PROCEDURE Main();
CONST
    WIDTH = 800;
    HEIGHT = 600;
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    engine : SDL3TTF.PtrTextEngine;
    font : SDL3TTF.PtrFont;
    edit : EditBox;
    rect, focusRect : SDL3.FRect;
    event : SDL3.Event;
    quit : BOOLEAN;
BEGIN
    (* Create the window *)
    IF ~SDL3.CreateWindowAndRenderer("Hello World", WIDTH, HEIGHT, 0, window, renderer) THEN
        SDL3.LogStr("Couldn't create window/renderer:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    
    IF ~SDL3TTF.Init() THEN
        SDL3.LogStr("Couldn't initialize SDL_ttf");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    
    (* Open the font *)
    font := SDL3TTF.OpenFont(FONT, 18.0);
    IF font = NIL THEN
        SDL3.LogStr("Couldn't open font");
        SDL3.Log(SDL3.GetError());
        SDL3TTF.Quit();
        SDL3.Quit;
        RETURN
    END;
    
    (* Create the text engine *)
    engine := SDL3TTF.CreateRendererTextEngine(renderer);
    IF engine = NIL THEN
        SDL3.LogStr("Couldn't create text engine");
        SDL3.Log(SDL3.GetError());
        SDL3TTF.Quit();
        SDL3.Quit;
        RETURN
    END;
    
    rect.x := 10; rect.y := 10;
    rect.w := WIDTH - 20; rect.h := HEIGHT - 20;
    IF ~Create(edit, window, renderer, engine, font, rect) THEN
        SDL3.LogStr("Couldn't create edit");
        SDL3.Log(SDL3.GetError());
        SDL3TTF.Quit();
        SDL3.Quit;
        RETURN
    END;
    
    edit.Insert("The quick brown fox jumped over the lazy dog");
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(event) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        IGNORE(SDL3.SetRenderDrawColor(renderer, 255, 255, 255, SDL3.ALPHA_OPAQUE));
        IGNORE(SDL3.RenderClear(renderer));  
        
        (* Clear the text rect to light gray *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0CCH, 0CCH, 0CCH, 0FFH));
        IGNORE(SDL3.RenderFillRect(renderer, rect));
        
        IF edit.has_focus THEN
            focusRect := rect;
            focusRect.x := focusRect.x - 1;
            focusRect.y := focusRect.y - 1;
            focusRect.w := focusRect.w + 2;
            focusRect.h := focusRect.h + 2;
            IGNORE(SDL3.SetRenderDrawColor(renderer, 00H, 00H, 00H, 0FFH));
            IGNORE(SDL3.RenderRect(renderer, focusRect));
        END;
        edit.Draw();
        IGNORE(SDL3.RenderPresent(renderer));
    END;
    
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3TTF.Quit();
    SDL3.Quit;
END Main;

BEGIN
    Main;
END Test.
