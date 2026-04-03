(*
  Copyright (C) 1997-2026 Sam Lantinga <slouken@libsdl.org>

  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely.
*)
MODULE Test;

IMPORT SYSTEM;
IN Ext IMPORT SDL3;
IN Ext IMPORT SDL3TTF;

CONST
    FONT = '/usr/share/fonts/TTF/Inconsolata-Regular.ttf';
    CURSOR_BLINK_INTERVAL_MS = 500;

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
    edit.highlighting := FALSE;
    edit.highlight1 := -1;
    edit.highlight2 := -1;
    edit.composition_start := 0;
    edit.composition_length := 0;
    edit.composition_cursor := 0;
    edit.composition_cursor_length := 0;
    edit.selected_candidate_start := 0;
    edit.selected_candidate_length := 0;

    (* Wrap the editbox text within the editbox area *)
    IGNORE(SDL3TTF.SetTextWrapWidth(edit.text, INTEGER(SDL3.floorf(rect.w))));

    (* Show the whitespace when wrapping, so it can be edited *)
    IGNORE(SDL3TTF.SetTextWrapWhitespaceVisible(edit.text, TRUE));
    
    (* We support rendering the composition and candidates *)
    IGNORE(SDL3.SetHint(SDL3.HINT_IME_IMPLEMENTED_UI, "composition,candidates"));
    RETURN TRUE
END Create;

PROCEDURE UTF8ByteLength(text : SYSTEM.ADDRESS; num_codepoints : INTEGER): INTEGER;
VAR
    start : SYSTEM.ADDRESS;
    ch : SDL3.Uint32;
BEGIN
    start := text;
    LOOP
        IF num_codepoints <= 0 THEN EXIT END;
        ch := SDL3.StepUTF8(text, NIL);
        IF ch = 0 THEN EXIT END;
        DEC(num_codepoints)
    END;
    RETURN INTEGER(text - start)
END UTF8ByteLength;

PROCEDURE (VAR edit: EditBox) DrawText(text : SDL3TTF.PtrText; x : REAL32; y : REAL32);
BEGIN IGNORE(SDL3TTF.DrawRendererText(text, x, y));
END DrawText;

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

PROCEDURE (VAR edit: EditBox) DeleteHighlight(): BOOLEAN;
VAR
    marker, length : INTEGER;
BEGIN
    IF edit.text.text = NIL THEN
        RETURN FALSE
    END;
    
    IF edit.GetHighlightExtents(marker, length) THEN
        IGNORE(SDL3TTF.DeleteTextString(edit.text, marker, length));
        edit.SetCursorPosition(marker);
        edit.highlight1 := -1;
        edit.highlight2 := -1;
        RETURN TRUE;
    END;
    RETURN FALSE;
END DeleteHighlight;

PROCEDURE (VAR edit: EditBox) HandleComposition(event : SDL3.PtrTextEditingEvent);
VAR
    length : INTEGER;
BEGIN
    IGNORE(edit.DeleteHighlight());
    IF edit.composition_length > 0 THEN
        IGNORE(SDL3TTF.DeleteTextString(edit.text, edit.composition_start, edit.composition_length));
        edit.ResetComposition();
    END;
    length := INTEGER(SDL3.strlen(SYSTEM.VAL(SYSTEM.ADDRESS, event.text)));
    IF length > 0 THEN
        edit.composition_start := edit.cursor;
        edit.composition_length := length;
        IGNORE(SDL3TTF.InsertTextString(edit.text, edit.composition_start, event.text, edit.composition_length));
        IF (event.start > 0) OR (event.length > 0) THEN
            edit.composition_cursor := UTF8ByteLength(SYSTEM.VAL(SYSTEM.ADDRESS,edit.text.text) + edit.composition_start, event.start);
            edit.composition_cursor_length := UTF8ByteLength(SYSTEM.VAL(SYSTEM.ADDRESS,edit.text.text) +
                                                             edit.composition_start + edit.composition_cursor, event.length);
        ELSE
            edit.composition_cursor := length;
            edit.composition_cursor_length := 0;
        END;
    END;
END HandleComposition;

PROCEDURE (VAR edit: EditBox) DrawComposition;
VAR
    substrings, ptr : SYSTEM.ADDRESS;
    substring : SDL3TTF.PtrSubString;
    rect : SDL3.FRect;
    font_height, i : INTEGER;
BEGIN
    (* Draw an underline under the composed text *)
    font_height := SDL3TTF.GetFontHeight(edit.font);
    substrings := SDL3TTF.GetTextSubStringsForRange(edit.text, edit.composition_start, edit.composition_length, NIL);
    IF substrings # 0 THEN
        i := 0;
        LOOP
            SYSTEM.GET(substrings + i * SIZE(SYSTEM.ADDRESS), ptr);
            IF ptr = 0 THEN EXIT END;
            substring := SYSTEM.VAL(SDL3TTF.PtrSubString, ptr);
            SDL3.RectToFRect(substring.rect, rect);
            rect.x := rect.x + edit.rect.x;
            rect.y := rect.y + (edit.rect.y + font_height);
            rect.h := 1.0;
            IGNORE(SDL3.RenderFillRect(edit.renderer, rect));
            INC(i);
        END;
        SDL3.free(substrings);
    END;
    
    (* Thicken the underline under the active clause in the composed text *)
    IF edit.composition_cursor_length > 0 THEN
        substrings := SDL3TTF.GetTextSubStringsForRange(edit.text, edit.composition_start + edit.composition_cursor, edit.composition_cursor_length, NIL);
        IF substrings # 0 THEN
            i := 0;
            LOOP
                SYSTEM.GET(substrings + i * SIZE(SYSTEM.ADDRESS), ptr);
                IF ptr = 0 THEN EXIT END;
                substring := SYSTEM.VAL(SDL3TTF.PtrSubString, ptr);
                SDL3.RectToFRect(substring.rect, rect);
                rect.x := rect.x + edit.rect.x;
                rect.y := rect.y + (edit.rect.y + font_height) - 1;
                rect.h := 1.0;
                IGNORE(SDL3.RenderFillRect(edit.renderer, rect));
                INC(i);
            END;
            SDL3.free(substrings);
        END;
    END;
END DrawComposition;

PROCEDURE (VAR edit: EditBox) DrawCompositionCursor();
VAR
    cursor : SDL3TTF.SubString;
    rect : SDL3.FRect;
BEGIN
    IF edit.composition_cursor_length = 0 THEN
        IF SDL3TTF.GetTextSubString(edit.text, edit.composition_start + edit.composition_cursor, cursor) THEN
            SDL3.RectToFRect(cursor.rect, rect);
            rect.x := rect.x + edit.rect.x;
            rect.y := rect.y + edit.rect.y;
            rect.w := 1.0;
            IGNORE(SDL3.SetRenderDrawColor(edit.renderer, 0, 0, 0, 0FFH));
            IGNORE(SDL3.RenderFillRect(edit.renderer, rect));
        END;
    END;   
END DrawCompositionCursor;

PROCEDURE (VAR edit: EditBox) ClearCandidates();
BEGIN
    IF edit.candidates # NIL THEN
        SDL3TTF.DestroyText(edit.candidates);
        edit.candidates := NIL;
    END;
    edit.selected_candidate_start := 0;
    edit.selected_candidate_length := 0;
END ClearCandidates;

PROCEDURE (VAR edit: EditBox) SaveCandidates(event : SDL3.PtrTextEditingCandidatesEvent);
VAR
    candidate_text : POINTER TO ARRAY OF CHAR;
    r, g, b, a: REAL32;
    length : LENGTH;
    i, j : INTEGER;
    ch : CHAR;
BEGIN
    edit.ClearCandidates();
    (* Calculate the length of the candidates text *)
    length := 0;
    FOR i := 0 TO event.num_candidates - 1 DO
        IF event.horizontal THEN
            IF i > 0 THEN
                INC(length)
            END;
        END;
        INC(length, SDL3.strlen(event.candidates + i * SIZE(SYSTEM.ADDRESS)));
        IF ~event.horizontal THEN
            INC(length)
        END;
    END;
    IF length = 0 THEN
        RETURN
    END;
    INC(length); (* For null terminator *)
    
    NEW(candidate_text, length);
    IF candidate_text = NIL THEN
        RETURN
    END;
    
    j := 0;
    FOR i := 0 TO event.num_candidates - 1 DO
        IF event.horizontal THEN
            IF i > 0 THEN
                candidate_text[j] := ' ';
                INC(j);
            END;
        END;
        length := SDL3.strlen(event.candidates + i * SIZE(SYSTEM.ADDRESS));
        IF i = event.selected_candidate THEN
            edit.selected_candidate_start := j;
            edit.selected_candidate_length := INTEGER(length);
        END;
        
        IGNORE(SDL3.memcpy(SYSTEM.ADR(candidate_text[j]), event.candidates + i * SIZE(SYSTEM.ADDRESS), length));
        INC(j, INTEGER(length));
        
        IF ~event.horizontal THEN
            candidate_text[j] := 09X;
            INC(j);
        END;
    END;
    candidate_text[j] := 00X;
    
    edit.candidates := SDL3TTF.CreateText(SDL3TTF.GetTextEngine(edit.text), edit.font, candidate_text^, 0);
    DISPOSE(candidate_text);
    
    IF edit.candidates # NIL THEN
        IGNORE(SDL3TTF.GetTextColorFloat(edit.text, r, g, b, a));
        IGNORE(SDL3TTF.SetTextColorFloat(edit.candidates, r, g, b, a));
    ELSE
        edit.ClearCandidates()
    END;
END SaveCandidates;

PROCEDURE (VAR edit: EditBox) DrawCandidates;
VAR
    substrings, ptr : SYSTEM.ADDRESS;
    substring : SDL3TTF.PtrSubString;
    cursor : SDL3TTF.SubString;
    candidates_rect, rect : SDL3.FRect;
    safe_rect : SDL3.Rect;
    x, y : REAL32;
    offset, candidates_w, candidates_h: INTEGER;
    i, font_height : INTEGER;
BEGIN
    (* Position the candidate window *)
    offset := edit.composition_start;
    IF edit.composition_cursor_length > 0 THEN
        (* Place the candidates at the active clause *)
        INC(offset, edit.composition_cursor)
    END;
    IF ~SDL3TTF.GetTextSubString(edit.text, offset, cursor) THEN
        RETURN
    END;
    IGNORE(SDL3.GetRenderSafeArea(edit.renderer, safe_rect));
    IGNORE(SDL3TTF.GetTextSize(edit.candidates, candidates_w, candidates_h));
    candidates_rect.x := edit.rect.x + cursor.rect.x;
    candidates_rect.y := edit.rect.y + cursor.rect.y + cursor.rect.h + 2.0;
    candidates_rect.w := 1.0 + 2.0 + candidates_w + 2.0 + 1.0;
    candidates_rect.h := 1.0 + 2.0 + candidates_h + 2.0 + 1.0;
    IF (candidates_rect.x + candidates_rect.w) > safe_rect.w THEN
        candidates_rect.x := safe_rect.w - candidates_rect.w;
        IF candidates_rect.x < 0.0 THEN
            candidates_rect.x := 0.0
        END;
    END;
    
    (* Draw the candidate background *)
    IGNORE(SDL3.SetRenderDrawColor(edit.renderer, 0AAH, 0AAH, 0AAH, 0FFH));
    IGNORE(SDL3.RenderFillRect(edit.renderer, candidates_rect));
    IGNORE(SDL3.SetRenderDrawColor(edit.renderer, 0, 0, 0, 0FFH));
    IGNORE(SDL3.RenderRect(edit.renderer, candidates_rect));
    
    (* Draw the candidates *)
    x := candidates_rect.x + 3.0;
    y := candidates_rect.y + 3.0;
    edit.DrawText(edit.candidates, x, y);
    
    (* Underline the selected candidate *)
    IF edit.selected_candidate_length > 0 THEN
        font_height := SDL3TTF.GetFontHeight(edit.font);
        substrings := SDL3TTF.GetTextSubStringsForRange(edit.candidates, edit.selected_candidate_start, edit.selected_candidate_length, NIL);
        IF substrings # 0 THEN
            i := 0;
            LOOP
                SYSTEM.GET(substrings + i * SIZE(SYSTEM.ADDRESS), ptr);
                IF ptr = 0 THEN EXIT END;
                substring := SYSTEM.VAL(SDL3TTF.PtrSubString, ptr);
                SDL3.RectToFRect(substring.rect, rect);
                rect.x := rect.x + x;
                rect.y := rect.y + (y + font_height);
                rect.h := 1.0;
                IGNORE(SDL3.RenderFillRect(edit.renderer, rect));
                INC(i);
            END;
            SDL3.free(substrings);
        END;
    END;
END DrawCandidates;

PROCEDURE (VAR edit: EditBox) UpdateTextInputArea;
VAR
    rect : SDL3.Rect;
    window_edit_rect_min : SDL3.FPoint;
    window_edit_rect_max : SDL3.FPoint;
    window_cursor : SDL3.FPoint;
    cursor_offset : INTEGER;
BEGIN
    (* Convert the text input area and cursor into window coordinates *)
    IF ~SDL3.RenderCoordinatesToWindow(edit.renderer, edit.rect.x, edit.rect.y, window_edit_rect_min.x, window_edit_rect_min.y) OR
       ~SDL3.RenderCoordinatesToWindow(edit.renderer, edit.rect.x + edit.rect.w, edit.rect.y + edit.rect.h, window_edit_rect_max.x, window_edit_rect_max.y) OR
       ~SDL3.RenderCoordinatesToWindow(edit.renderer, edit.cursor_rect.x, edit.cursor_rect.y, window_cursor.x, window_cursor.y) THEN
        RETURN
    END;
    rect.x := INTEGER(SDL3.roundf(window_edit_rect_min.x));
    rect.y := INTEGER(SDL3.roundf(window_edit_rect_min.y));
    rect.w := INTEGER(SDL3.roundf(window_edit_rect_max.x - window_edit_rect_min.x));
    rect.h := INTEGER(SDL3.roundf(window_edit_rect_max.y - window_edit_rect_min.y));
    cursor_offset := INTEGER(SDL3.roundf(window_cursor.x - window_edit_rect_min.x));
    IGNORE(SDL3.SetTextInputArea(edit.window, rect, cursor_offset));
END UpdateTextInputArea;

PROCEDURE (VAR edit: EditBox) DrawCursor();
BEGIN
    IF edit.composition_length > 0 THEN
        edit.DrawCompositionCursor();
        RETURN
    END;
    IGNORE(SDL3.SetRenderDrawColor(edit.renderer, 0, 0, 0, 0FFH));
    IGNORE(SDL3.RenderFillRect(edit.renderer, edit.cursor_rect));
END DrawCursor;

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

PROCEDURE (VAR edit: EditBox) MoveCursorIndex(direction : INTEGER);
VAR
    substring : SDL3TTF.SubString;
BEGIN
    IF direction < 0 THEN
        IF SDL3TTF.GetTextSubString(edit.text, edit.cursor - 1, substring) THEN
            edit.SetCursorPosition(substring.offset)
        END;
    ELSE
        IF SDL3TTF.GetTextSubString(edit.text, edit.cursor, substring) &
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
        edit.SetCursorPosition(INTEGER(SDL3.strlen(SYSTEM.VAL(SYSTEM.ADDRESS, edit.text.text))))
    END
END MoveCursorEnd;

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
        length := SDL3.strlen(SYSTEM.VAL(SYSTEM.ADDRESS, edit.text.text)) - edit.cursor;
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
    edit.highlight2 := INTEGER(SDL3.strlen(SYSTEM.VAL(SYSTEM.ADDRESS, edit.text.text)));
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

PROCEDURE (VAR edit: EditBox) InsertPStr(text: POINTER TO VAR- CHAR);
VAR
    length : LENGTH;
BEGIN
    IF text = NIL THEN
        RETURN
    END;
    IGNORE(edit.DeleteHighlight());
    IF edit.composition_length > 0 THEN
        IGNORE(SDL3TTF.DeleteTextString(edit.text, edit.composition_start, edit.composition_length));
        edit.composition_length := 0;
    END;
    length := SDL3.strlen(SYSTEM.VAL(SYSTEM.ADDRESS,text));
    IGNORE(SDL3TTF.InsertTextString(edit.text, edit.cursor, text, length));
    edit.SetCursorPosition(INTEGER(edit.cursor + length));
END InsertPStr;

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
    length := SDL3.strlen(SYSTEM.ADR(text[0]));
    IGNORE(SDL3TTF.InsertTextString(edit.text, edit.cursor, PTR(text[0]), length));
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

PROCEDURE (VAR edit: EditBox) SetFocus(focus : BOOLEAN);
BEGIN
    IF edit.has_focus = focus THEN
        RETURN
    END;
    
    edit.has_focus := focus;
    
    IF edit.has_focus THEN
        IGNORE(SDL3.StartTextInput(edit.window));
    ELSE
        IGNORE(SDL3.StopTextInput(edit.window));
    END;
END SetFocus;

PROCEDURE (VAR edit: EditBox) Destroy();
BEGIN
    edit.ClearCandidates();
    SDL3TTF.DestroyText(edit.text)
END Destroy;

PROCEDURE (VAR edit: EditBox) Draw();
VAR
    substrings, ptr : SYSTEM.ADDRESS;
    substring : SDL3TTF.PtrSubString;
    cursor : SDL3TTF.SubString;     
    rect, cursor_rect : SDL3.FRect;
    now : SDL3.Uint64;
    x, y : REAL32;
    i, marker, length : INTEGER;
BEGIN
    x := edit.rect.x;
    y := edit.rect.y;
    
    (* Draw any highlight *)
    IF edit.GetHighlightExtents(marker, length) THEN
        substrings := SDL3TTF.GetTextSubStringsForRange(edit.text, marker, length, NIL);
        IF substrings # 0 THEN
            i := 0;
            IGNORE(SDL3.SetRenderDrawColor(edit.renderer, 0EEH, 0EEH, 000H, 0FFH));
            LOOP
                SYSTEM.GET(substrings + i * SIZE(SYSTEM.ADDRESS), ptr);
                IF ptr = 0 THEN EXIT END;
                substring := SYSTEM.VAL(SDL3TTF.PtrSubString, ptr);
                SDL3.RectToFRect(substring.rect, rect);
                rect.x := rect.x + x;
                rect.y := rect.y + y;
                IGNORE(SDL3.RenderFillRect(edit.renderer, rect));
                INC(i);
            END;
            SDL3.free(substrings);
        END;
    END;
    
    edit.DrawText(edit.text, x, y);
    
    IF edit.has_focus THEN
        (* Draw the cursor *)
        now := SDL3.GetTicks();
        IF (now - edit.last_cursor_change) >= CURSOR_BLINK_INTERVAL_MS THEN
            edit.cursor_visible := ~edit.cursor_visible;
            edit.last_cursor_change := now;
        END;
        
        (* Calculate the cursor rect, used for positioning candidates *)
        IF SDL3TTF.GetTextSubString(edit.text, edit.cursor, cursor) THEN
            SDL3.RectToFRect(cursor.rect, cursor_rect);
            cursor_rect.x := cursor_rect.x + edit.rect.x;
            cursor_rect.y := cursor_rect.y + edit.rect.y;
            cursor_rect.w := 1.0;
            edit.cursor_rect := cursor_rect;
            edit.UpdateTextInputArea()
        END;
        
        IF edit.composition_length > 0 THEN
            edit.DrawComposition()
        END;

        IF edit.candidates # NIL THEN
            edit.DrawCandidates()
        END;

        IF edit.cursor_visible THEN
            edit.DrawCursor()
        END;
    END;

END Draw;

PROCEDURE (VAR edit: EditBox) HandleMouseDown(x, y : REAL32): BOOLEAN;
VAR
    substring : SDL3TTF.SubString;
    pt : SDL3.FPoint;
    textX, textY : INTEGER;
BEGIN
    pt.x := x; pt.y := y;
    IF ~SDL3.PointInRectFloat(pt, edit.rect) THEN
        IF edit.has_focus THEN
            edit.SetFocus(FALSE);
            RETURN TRUE
        END;
        RETURN FALSE
    END;
    
    IF ~edit.has_focus THEN
        edit.SetFocus(TRUE)
    END;
    
    (* Set the cursor position *)
    textX := INTEGER(SDL3.roundf(x - edit.rect.x));
    textY := INTEGER(SDL3.roundf(y - edit.rect.y));
    IF ~SDL3TTF.GetTextSubStringForPoint(edit.text, textX, textY, substring) THEN
        SDL3.LogStr("Couldn't get cursor location");
        SDL3.Log(SDL3.GetError());
        RETURN FALSE
    END;
    
    edit.SetCursorPosition(edit.GetCursorTextIndex(textX, substring));
    edit.highlighting := TRUE;
    edit.highlight1 := edit.cursor;
    edit.highlight2 := -1;
    RETURN  TRUE
END HandleMouseDown;

PROCEDURE (VAR edit: EditBox) HandleMouseMotion(x, y : REAL32): BOOLEAN;
VAR
    substring : SDL3TTF.SubString;
    textX, textY : INTEGER;
BEGIN
    IF ~edit.highlighting THEN
        RETURN FALSE
    END;
    (* Set the highlight position *)
    textX := INTEGER(SDL3.roundf(x - edit.rect.x));
    textY := INTEGER(SDL3.roundf(y - edit.rect.y));
    IF ~SDL3TTF.GetTextSubStringForPoint(edit.text, textX, textY, substring) THEN
        SDL3.LogStr("Couldn't get cursor location");
        SDL3.Log(SDL3.GetError());
        RETURN FALSE
    END;
    
    edit.SetCursorPosition(edit.GetCursorTextIndex(textX, substring));
    edit.highlight2 := edit.cursor;
    RETURN TRUE
END HandleMouseMotion;

PROCEDURE (VAR edit: EditBox) HandleMouseUp(x, y : REAL32): BOOLEAN;
BEGIN
    IF ~edit.highlighting THEN
        RETURN FALSE
    END;
    
    edit.highlighting := FALSE;
    RETURN  TRUE
END HandleMouseUp;

PROCEDURE (VAR edit: EditBox) HandleEvent(VAR event : SDL3.Event):BOOLEAN;
VAR
    buttonEvent : SDL3.PtrMouseButtonEvent;
    motionEvent : SDL3.PtrMouseMotionEvent;
    keyEvent : SDL3.PtrKeyboardEvent;
    inputEvent : SDL3.PtrTextInputEvent;
    editEvent : SDL3.PtrTextEditingEvent;
    candEvent : SDL3.PtrTextEditingCandidatesEvent;
    str : ARRAY 2 OF CHAR;
BEGIN
    IGNORE(SDL3.ConvertEventToRenderCoordinates(edit.renderer, PTR(event)));
    CASE event.type OF
          SDL3.EVENT_MOUSE_BUTTON_DOWN:
            buttonEvent := SDL3.EventAsMouseButtonEvent(event);
            RETURN edit.HandleMouseDown(buttonEvent.x, buttonEvent.y)
        | SDL3.EVENT_MOUSE_MOTION:
            motionEvent := SDL3.EventAsMouseMotionEvent(event);
            RETURN edit.HandleMouseMotion(motionEvent.x, motionEvent.y)
        | SDL3.EVENT_MOUSE_BUTTON_UP:
            buttonEvent := SDL3.EventAsMouseButtonEvent(event);
            RETURN edit.HandleMouseUp(buttonEvent.x, buttonEvent.y)
        | SDL3.EVENT_KEY_DOWN:
            IF ~edit.has_focus THEN RETURN FALSE END;
            keyEvent := SDL3.EventAsKeyboardEvent(event);
            CASE keyEvent.key OF
                  SDL3.K_A:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.SelectAll()
                    END;
                | SDL3.K_C:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.Copy()
                    END;
                | SDL3.K_V:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.Paste()
                    END;
                | SDL3.K_X:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.Cut()
                    END;
                | SDL3.K_LEFT:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.MoveCursorBeginningOfLine()
                    ELSE
                        edit.MoveCursorLeft()
                    END;
                | SDL3.K_RIGHT:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.MoveCursorEndOfLine()
                    ELSE
                        edit.MoveCursorRight()
                    END;
                | SDL3.K_UP:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.MoveCursorBeginning()
                    ELSE
                        edit.MoveCursorUp()
                    END;
                | SDL3.K_DOWN:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.MoveCursorEnd()
                    ELSE
                        edit.MoveCursorDown()
                    END;
                | SDL3.K_HOME:
                    edit.MoveCursorBeginning();
                | SDL3.K_END:
                    edit.MoveCursorEnd();
                | SDL3.K_BACKSPACE:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.BackspaceToBeginning()
                    ELSE
                        edit.Backspace()
                    END;
                | SDL3.K_DELETE:
                    IF SET16(keyEvent.mod) * SET16(SDL3.KMOD_CTRL) # {} THEN
                        edit.DeleteToEnd()
                    ELSE
                        edit.Delete()
                    END;
                | SDL3.K_RETURN:
                    str[0] := 0AX;
                    str[1] := 00X;
                    edit.Insert(str);
                | SDL3.K_ESCAPE:
                    edit.SetFocus(FALSE);
            ELSE
                ;
            END;
            RETURN TRUE
        | SDL3.EVENT_TEXT_INPUT:
            inputEvent := SDL3.EventAsTextInputEvent(event);
            edit.InsertPStr(inputEvent.text);
            RETURN TRUE;
        | SDL3.EVENT_TEXT_EDITING:
            (* TODO : Does not work *)
            (*
            editEvent := SDL3.EventAsTextEditingEvent(event);
            edit.HandleComposition(editEvent);
            *)
            ;
        | SDL3.EVENT_TEXT_EDITING_CANDIDATES:
            candEvent := SDL3.EventAsTextEditingCandidatesEvent(event);
            edit.ClearCandidates();
            edit.SaveCandidates(candEvent);
    ELSE ;
    END;
    RETURN FALSE
END HandleEvent;

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
    
    IGNORE(SDL3TTF.SetTextColor(edit.text, 0, 0, 0, 255));
    edit.Insert("The quick brown fox jumped over the lazy dog");
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(event) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            ELSE
                IGNORE(edit.HandleEvent(event));
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
    edit.Destroy();
    IF font # NIL THEN SDL3TTF.CloseFont(font) END;
    IF engine # NIL THEN SDL3TTF.DestroyRendererTextEngine(engine) END;   
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3TTF.Quit();
    SDL3.Quit;
END Main;

BEGIN
    Main;
END Test.
