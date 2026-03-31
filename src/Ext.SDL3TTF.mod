MODULE SDL3TTF IN Ext;

IMPORT SYSTEM;
IN Ext IMPORT SDL3;

TYPE Font* = RECORD- END;
TYPE PtrFont* = POINTER TO VAR Font;

TYPE TextEngine* = RECORD- END;
TYPE PtrTextEngine* = POINTER TO VAR TextEngine;

TYPE Text* = RECORD-
    text-: POINTER TO VAR- CHAR;
    num_lines-: INTEGER;
    refcount-: INTEGER;
    internal-: SYSTEM.ADDRESS;
END;
TYPE PtrText* = POINTER TO VAR Text;

TYPE SubString* = RECORD-
    flags-: SDL3.Uint32;
    offset-: INTEGER;
    length-: INTEGER;
    line_index-: INTEGER;
    cluster_index-: INTEGER;
    rect-: SDL3.Rect;
END;
TYPE PtrSubString* = POINTER TO VAR SubString;

CONST STYLE_NORMAL*        = 0;
CONST STYLE_BOLD*          = 1;
CONST STYLE_ITALIC*        = 2;
CONST STYLE_UNDERLINE*     = 4;
CONST STYLE_STRIKETHROUGH* = 8;

CONST HINTING_INVALID*          = -1;
CONST HINTING_NORMAL*           = 0;       
CONST HINTING_LIGHT*            = 1;
CONST HINTING_MONO*             = 2;
CONST HINTING_NONE*             = 3;         
CONST HINTING_LIGHT_SUBPIXEL*   = 4;

CONST FONT_WEIGHT_THIN*         = 100;
CONST FONT_WEIGHT_EXTRA_LIGHT*  = 200;
CONST FONT_WEIGHT_LIGHT*        = 300;
CONST FONT_WEIGHT_NORMAL*       = 400;
CONST FONT_WEIGHT_MEDIUM*       = 500;
CONST FONT_WEIGHT_SEMI_BOLD*    = 600;
CONST FONT_WEIGHT_BOLD*         = 700;
CONST FONT_WEIGHT_EXTRA_BOLD*   = 800;
CONST FONT_WEIGHT_BLACK*        = 900;
CONST FONT_WEIGHT_EXTRA_BLACK*  = 950;

CONST HORIZONTAL_ALIGN_INVALID* = -1;
CONST HORIZONTAL_ALIGN_LEFT*    = 0;
CONST HORIZONTAL_ALIGN_CENTER*  = 1;
CONST HORIZONTAL_ALIGN_RIGHT*   = 2;

CONST DIRECTION_INVALID*    = 0;
CONST DIRECTION_LTR*        = 4;        
CONST DIRECTION_RTL*        = 5;           
CONST DIRECTION_TTB*        = 6; 
CONST DIRECTION_BTT*        = 7;

CONST SUBSTRING_DIRECTION_MASK*    = 000000FFH;
CONST SUBSTRING_TEXT_START*        = 00000100H;
CONST SUBSTRING_LINE_START*        = 00000200H;
CONST SUBSTRING_LINE_END*          = 00000400H;
CONST SUBSTRING_TEXT_END*          = 00000800H;

CONST IMAGE_INVALID*    = 0;
CONST IMAGE_ALPHA*      = 1;
CONST IMAGE_COLOR*      = 2;
CONST IMAGE_SDF*        = 3;  
    

PROCEDURE ^ Init* ["TTF_Init"] (): BOOLEAN;
PROCEDURE ^ Quit* ["TTF_Quit"] ();

PROCEDURE ^ TTFOpenFont ["TTF_OpenFont"] (file: POINTER TO VAR- CHAR; ptsize : REAL32): POINTER TO VAR Font;
PROCEDURE OpenFont*(file-: ARRAY OF CHAR; ptsize : REAL32): POINTER TO VAR Font;
BEGIN RETURN TTFOpenFont(PTR(file[0]), ptsize)
END OpenFont;
PROCEDURE ^ CloseFont* ["TTF_CloseFont"] (font: POINTER TO VAR Font);
PROCEDURE ^ GetFontHeight* ["TTF_GetFontHeight"] (font: POINTER TO VAR Font): INTEGER;

PROCEDURE ^ CreateRendererTextEngine* ["TTF_CreateRendererTextEngine"] (renderer : POINTER TO VAR SDL3.Renderer): POINTER TO VAR TextEngine;
PROCEDURE ^ DestroyRendererTextEngine* ["TTF_DestroyRendererTextEngine"] (engine : POINTER TO VAR TextEngine);

PROCEDURE ^ TTFCreateText ["TTF_CreateText"] (engine : POINTER TO VAR TextEngine; font: POINTER TO VAR Font; text: POINTER TO VAR- CHAR; length : LENGTH) : POINTER TO VAR Text;
PROCEDURE CreateText*(engine : POINTER TO VAR TextEngine; font: POINTER TO VAR Font; text-: ARRAY OF CHAR; length : LENGTH): POINTER TO VAR Text;
BEGIN
    IF text = "" THEN
        RETURN TTFCreateText(engine, font, NIL, length)
    ELSE
        RETURN TTFCreateText(engine, font, PTR(text[0]), length)
    END;
END CreateText;

PROCEDURE ^ DestroyText* ["TTF_DestroyText"] (text : POINTER TO VAR Text);

PROCEDURE ^ TTFSetTextColor ["TTF_SetTextColor"] (text : POINTER TO VAR Text; r, g, b, a : SDL3.Uint8) : BOOLEAN;
PROCEDURE SetTextColor*(text : POINTER TO VAR Text; r, g, b, a: INTEGER): BOOLEAN;
BEGIN RETURN TTFSetTextColor(text, SDL3.Uint8(r), SDL3.Uint8(g), SDL3.Uint8(b), SDL3.Uint8(a))
END SetTextColor;

PROCEDURE ^ TTFGetTextSize ["TTF_GetTextSize"] (text : POINTER TO VAR Text; w, h: POINTER TO VAR INTEGER): BOOLEAN;
PROCEDURE GetTextSize*(text : POINTER TO VAR Text; VAR w, h: INTEGER): BOOLEAN;
BEGIN RETURN TTFGetTextSize(text, PTR(w), PTR(h))
END GetTextSize;

PROCEDURE ^ SetTextWrapWhitespaceVisible* ["TTF_SetTextWrapWhitespaceVisible"] (text : POINTER TO VAR Text; visible: BOOLEAN): BOOLEAN;
PROCEDURE ^ SetTextWrapWidth* ["TTF_SetTextWrapWidth"] (text : POINTER TO VAR Text; wrap_width: INTEGER): BOOLEAN;

PROCEDURE ^ DeleteTextString* ["TTF_DeleteTextString"] (text : POINTER TO VAR Text; offset: INTEGER; length: INTEGER) : BOOLEAN;

PROCEDURE ^ TTFInsertTextString ["TTF_InsertTextString"] (text : POINTER TO VAR Text; offset: INTEGER; string: POINTER TO VAR- CHAR; length: LENGTH) : BOOLEAN;
PROCEDURE InsertTextString*(text : POINTER TO VAR Text; offset: INTEGER; string-: ARRAY OF CHAR; length: LENGTH): BOOLEAN;
BEGIN RETURN TTFInsertTextString(text, offset, PTR(string[0]), length)
END InsertTextString;

PROCEDURE ^ TTFGetTextSubString ["TTF_GetTextSubString"] (text : POINTER TO VAR Text; offset: INTEGER; substring: POINTER TO VAR- SubString) : BOOLEAN;
PROCEDURE GetTextSubString*(text : POINTER TO VAR Text; offset: INTEGER; VAR substring-: SubString): BOOLEAN;
BEGIN RETURN TTFGetTextSubString(text, offset, PTR(substring))
END GetTextSubString;

PROCEDURE ^ TTFGetTextSubStringForLine ["TTF_GetTextSubStringForLine"] (text : POINTER TO VAR Text; line: INTEGER; substring: POINTER TO VAR- SubString) : BOOLEAN;
PROCEDURE GetTextSubStringForLine*(text : POINTER TO VAR Text; line: INTEGER; VAR substring-: SubString): BOOLEAN;
BEGIN RETURN TTFGetTextSubStringForLine(text, line, PTR(substring))
END GetTextSubStringForLine;

PROCEDURE ^ TTFGetTextSubStringForPoint ["TTF_GetTextSubStringForPoint"] (text : POINTER TO VAR Text; x: INTEGER; y: INTEGER; substring: POINTER TO VAR- SubString) : BOOLEAN;
PROCEDURE GetTextSubStringForPoint*(text : POINTER TO VAR Text; x: INTEGER; y: INTEGER; VAR substring-: SubString): BOOLEAN;
BEGIN RETURN TTFGetTextSubStringForPoint(text, x, y, PTR(substring))
END GetTextSubStringForPoint;

PROCEDURE ^ TTFGetTextSubStringsForRange ["TTF_GetTextSubStringsForRange"] (text : POINTER TO VAR Text; offset: INTEGER; length: INTEGER; count: POINTER TO VAR INTEGER): SYSTEM.ADDRESS;
PROCEDURE GetTextSubStringsForRange*(text : POINTER TO VAR Text; offset: INTEGER; length: INTEGER; VAR count: INTEGER): SYSTEM.ADDRESS;
BEGIN RETURN TTFGetTextSubStringsForRange(text, offset, length, PTR(count))
END GetTextSubStringsForRange;

PROCEDURE ^ DrawRendererText* ["TTF_DrawRendererText"] (text : POINTER TO VAR Text; x, y : REAL32) : BOOLEAN;

PROCEDURE ^ TTFRenderText_Blended ["TTF_RenderText_Blended"] (font: POINTER TO VAR Font; text: POINTER TO VAR- CHAR; length : LENGTH; color : POINTER TO VAR- SDL3.Color) : POINTER TO VAR SDL3.Surface;
PROCEDURE RenderText_Blended*(font: POINTER TO VAR Font; text-: ARRAY OF CHAR; length : LENGTH; color-: SDL3.Color): POINTER TO VAR SDL3.Surface;
BEGIN RETURN TTFRenderText_Blended(font, PTR(text[0]), length, PTR(color))
END RenderText_Blended;

END SDL3TTF.