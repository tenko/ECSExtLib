MODULE SDL3 IN Ext;

IMPORT SYSTEM;

TYPE Sint32* = SIGNED32;
TYPE Uint8* = UNSIGNED8;
TYPE Uint16* = UNSIGNED16;
TYPE Uint32* = UNSIGNED32;
TYPE Uint64* = UNSIGNED64;

(* SDL_event.h *)
TYPE Event* = RECORD-
	type*: Uint32;
	padding*: ARRAY 128 OF CHAR;
END;

(* SDL_rect.h *)
TYPE FPoint* = RECORD-
    x* : REAL32;
    y* : REAL32;
END;

TYPE FRect* = RECORD-
    x* : REAL32;
    y* : REAL32;
    w* : REAL32;
    h* : REAL32;
END;

(* SDL_render.h *)
TYPE Renderer* = RECORD- END;
TYPE PtrRenderer* = POINTER TO VAR Renderer;
TYPE Window* = RECORD- END;
TYPE PtrWindow* = POINTER TO VAR Window;

(* SDL_init.h *)
CONST INIT_AUDIO*       = 00000010H;
CONST INIT_VIDEO*       = 00000020H;
CONST INIT_JOYSTICK*    = 00000200H;
CONST INIT_HAPTIC*      = 00001000H;
CONST INIT_GAMEPAD*     = 00002000H;
CONST INIT_EVENTS*      = 00004000H;
CONST INIT_SENSOR*      = 00008000H;
CONST INIT_CAMERA*      = 00010000H;
CONST APP_CONTINUE*     = 0;
CONST APP_SUCCESS*      = 1;
CONST APP_FAILURE*      = 2;
CONST PROP_APP_METADATA_NAME_STRING*        = "SDL.app.metadata.name";
CONST PROP_APP_METADATA_VERSION_STRING*     = "SDL.app.metadata.version";
CONST PROP_APP_METADATA_IDENTIFIER_STRING*  = "SDL.app.metadata.identifier";
CONST PROP_APP_METADATA_CREATOR_STRING*     = "SDL.app.metadata.creator";
CONST PROP_APP_METADATA_COPYRIGHT_STRING*   = "SDL.app.metadata.copyright";
CONST PROP_APP_METADATA_URL_STRING*         = "SDL.app.metadata.url";
CONST PROP_APP_METADATA_TYPE_STRING*        = "SDL.app.metadata.type";

(* SDL_event.h *)
CONST EVENT_QUIT*   = 100H;

(* SDL_log.h *)
CONST LOG_CATEGORY_APPLICATION* = 0;
CONST LOG_CATEGORY_ERROR*       = 1;
CONST LOG_CATEGORY_ASSERT*      = 2;
CONST LOG_CATEGORY_SYSTEM*      = 3;
CONST LOG_CATEGORY_AUDIO*       = 4;
CONST LOG_CATEGORY_VIDEO*       = 5;
CONST LOG_CATEGORY_RENDER*      = 6;
CONST LOG_CATEGORY_INPUT*       = 7;
CONST LOG_CATEGORY_TEST*        = 8;
CONST LOG_CATEGORY_GPU*         = 9;
CONST LOG_CATEGORY_CUSTOM*      = 19;
CONST LOG_PRIORITY_INVALID*     = 0;
CONST LOG_PRIORITY_TRACE*       = 1;
CONST LOG_PRIORITY_VERBOSE*     = 2;
CONST LOG_PRIORITY_DEBUG*       = 3;
CONST LOG_PRIORITY_INFO*        = 4;
CONST LOG_PRIORITY_WARN*        = 5;
CONST LOG_PRIORITY_ERROR*       = 6;
CONST LOG_PRIORITY_CRITICAL*    = 7;
CONST LOG_PRIORITY_COUNT*       = 8;

(* SDL_pixels.h *)
CONST ALPHA_OPAQUE*             = 255;
CONST ALPHA_OPAQUE_FLOAT*       = 1.0;
CONST ALPHA_TRANSPARENT*        = 0;
CONST ALPHA_TRANSPARENT_FLOAT*  = 0.0;

(* SDL_render.h *)
CONST LOGICAL_PRESENTATION_DISABLED*        = 0;
CONST LOGICAL_PRESENTATION_STRETCH*         = 1;
CONST LOGICAL_PRESENTATION_LETTERBOX*       = 2;
CONST LOGICAL_PRESENTATION_OVERSCAN*        = 3;
CONST LOGICAL_PRESENTATION_INTEGER_SCALE*   = 4;

(* SDL_stdinc.h *)
CONST PI_D* = 3.141592653589793238462643383279502884;
CONST PI_F* = REAL32(3.141592653589793238462643383279502884);
    
(* SDL_video.h *)
CONST WINDOW_FULLSCREEN*            = Uint64(0000000000000001H); 
CONST WINDOW_OPENGL*                = Uint64(0000000000000002H);
CONST WINDOW_OCCLUDED*              = Uint64(0000000000000004H);
CONST WINDOW_HIDDEN*                = Uint64(0000000000000008H);
CONST WINDOW_BORDERLESS*            = Uint64(0000000000000010H);
CONST WINDOW_RESIZABLE*             = Uint64(0000000000000020H);
CONST WINDOW_MINIMIZED*             = Uint64(0000000000000040H);
CONST WINDOW_MAXIMIZED*             = Uint64(0000000000000080H);
CONST WINDOW_MOUSE_GRABBED*         = Uint64(0000000000000100H);
CONST WINDOW_INPUT_FOCUS*           = Uint64(0000000000000200H);
CONST WINDOW_MOUSE_FOCUS*           = Uint64(0000000000000400H);
CONST WINDOW_EXTERNAL*              = Uint64(0000000000000800H);
CONST WINDOW_MODAL*                 = Uint64(0000000000001000H);
CONST WINDOW_HIGH_PIXEL_DENSITY*    = Uint64(0000000000002000H);
CONST WINDOW_MOUSE_CAPTURE*         = Uint64(0000000000004000H);
CONST WINDOW_MOUSE_RELATIVE_MODE*   = Uint64(0000000000008000H);
CONST WINDOW_ALWAYS_ON_TOP*         = Uint64(0000000000010000H);
CONST WINDOW_UTILITY*               = Uint64(0000000000020000H);
CONST WINDOW_TOOLTIP*               = Uint64(0000000000040000H);
CONST WINDOW_POPUP_MENU*            = Uint64(0000000000080000H);
CONST WINDOW_KEYBOARD_GRABBED*      = Uint64(0000000000100000H);
CONST WINDOW_FILL_DOCUMENT*         = Uint64(0000000000200000H);
CONST WINDOW_VULKAN*                = Uint64(0000000010000000H);
CONST WINDOW_METAL*                 = Uint64(0000000020000000H);
CONST WINDOW_TRANSPARENT*           = Uint64(0000000040000000H);
CONST WINDOW_NOT_FOCUSABLE*         = Uint64(0000000080000000H);
    
(* SDL_init.h *)
PROCEDURE ^ Init* ["SDL_Init"] (flags: Uint32): BOOLEAN;
PROCEDURE ^ InitSubSystem* ["SDL_InitSubSystem"] (flags: Uint32): BOOLEAN;
PROCEDURE ^ QuitSubSystem* ["SDL_QuitSubSystem"] (flags: Uint32);
PROCEDURE ^ WasInit* ["SDL_WasInit"] (flags: Uint32): Uint32;
PROCEDURE ^ Quit* ["SDL_Quit"];
PROCEDURE ^ SDLSetAppMetadata ["SDL_SetAppMetadata"] (appname, appversion, appidentifier: POINTER TO VAR- CHAR): BOOLEAN;
PROCEDURE SetAppMetadata*(appname-, appversion-, appidentifier-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLSetAppMetadata(PTR(appname[0]), PTR(appversion[0]), PTR(appidentifier[0]))
END SetAppMetadata;

(* SDL_error.h *)
PROCEDURE ^ GetError* ["SDL_GetError"] (): POINTER TO VAR- CHAR;

(** Return length of last error message. *)
PROCEDURE GetErrorLength*(): LENGTH;
VAR
    msg : POINTER TO VAR- CHAR;
    adr : SYSTEM.ADDRESS;
    ch : CHAR;
    i : LENGTH;
BEGIN
    msg := GetError();
    adr := SYSTEM.VAL(SYSTEM.ADDRESS, msg);
    IF adr = 0 THEN RETURN 0 END;
    i := 0;
    LOOP
        SYSTEM.GET(adr, ch);
        IF ch = 00X THEN EXIT END;
        INC(i); INC(adr);
    END;
    RETURN i;
END GetErrorLength;

(** Set `str` to last error message. *)
PROCEDURE GetErrorStr*(VAR str : ARRAY OF CHAR);
VAR
    msg : POINTER TO VAR- CHAR;
    adr : SYSTEM.ADDRESS;
    ch : CHAR;
    i : LENGTH;
BEGIN
    msg := GetError();
    adr := SYSTEM.VAL(SYSTEM.ADDRESS, msg);
    IF adr = 0 THEN
        str[0] := 00X;
    END;
    FOR i := 0 TO LEN(str) - 1 DO
        SYSTEM.GET(adr, ch);
        IF ch = 00X THEN
            str[i] := 00X;
            RETURN;
        END;
        str[i] := ch;
        INC(adr);
    END;
END GetErrorStr;

(* SDL_events.h *)
PROCEDURE ^ PollEvent* ["SDL_PollEvent"] (event : POINTER TO VAR Event): BOOLEAN;

(* SDL_log.h *)
PROCEDURE ^ SDLLog ["SDL_Log"] (fmt: POINTER TO VAR- CHAR; ap : SYSTEM.ADDRESS);
(** Log a message with SDL3.LOG_CATEGORY_APPLICATION and SDL3.LOG_PRIORITY_INFO. *)
PROCEDURE Log*(msg-: POINTER TO VAR- CHAR);
BEGIN SDLLog(msg, 0)
END Log;
(** Log a message with SDL3.LOG_CATEGORY_APPLICATION and SDL3.LOG_PRIORITY_INFO. *)
PROCEDURE LogStr*(msg-: ARRAY OF CHAR);
BEGIN SDLLog(PTR(msg[0]), 0)
END LogStr;

(* SDL_render.h *)
PROCEDURE ^ SDLCreateWindowAndRenderer ["SDL_CreateWindowAndRenderer"] (title: POINTER TO VAR- CHAR; width, height: INTEGER; flags: Uint64; window : SYSTEM.ADDRESS; renderer : SYSTEM.ADDRESS): BOOLEAN;
    
(** Create a window and default renderer. *)
PROCEDURE CreateWindowAndRenderer*(title-: ARRAY OF CHAR; width, height: INTEGER; flags: Uint64; VAR window : PtrWindow; VAR renderer : PtrRenderer): BOOLEAN;
BEGIN RETURN SDLCreateWindowAndRenderer(PTR(title[0]), width, height, flags, SYSTEM.ADR(window), SYSTEM.ADR(renderer))
END CreateWindowAndRenderer;

PROCEDURE ^ SDLCreateRenderer ["SDL_CreateRenderer"] (window : POINTER TO VAR Window; name: POINTER TO VAR- CHAR): POINTER TO VAR Renderer;

(** Create a 2D rendering context for a window. *)
PROCEDURE CreateRenderer*(window : POINTER TO VAR Window; name-: ARRAY OF CHAR): POINTER TO VAR Renderer;
BEGIN
    IF name = "" THEN
        RETURN SDLCreateRenderer(window, NIL)
    ELSE
        RETURN SDLCreateRenderer(window, PTR(name[0]))
    END;
END CreateRenderer;

PROCEDURE ^ SetRenderLogicalPresentation* ["SDL_SetRenderLogicalPresentation"] (renderer : POINTER TO VAR Renderer; w, h : INTEGER; mode: INTEGER): BOOLEAN;
PROCEDURE ^ SDLSetRenderDrawColor* ["SDL_SetRenderDrawColor"] (renderer : POINTER TO VAR Renderer; r, g, b, a: Uint8): BOOLEAN;
(* Set the color used for drawing operations. *)
PROCEDURE SetRenderDrawColor*(renderer : POINTER TO VAR Renderer; r, g, b, a: INTEGER): BOOLEAN;
BEGIN RETURN SDLSetRenderDrawColor(renderer, Uint8(r), Uint8(g), Uint8(b), Uint8(a))
END SetRenderDrawColor;
PROCEDURE ^ SetRenderDrawColorFloat* ["SDL_SetRenderDrawColorFloat"] (renderer : POINTER TO VAR Renderer; r, g, b, a: REAL32): BOOLEAN;
PROCEDURE ^ RenderClear* ["SDL_RenderClear"] (renderer : POINTER TO VAR Renderer): BOOLEAN;
PROCEDURE ^ SDLRenderFillRect* ["SDL_RenderFillRect"] (renderer : POINTER TO VAR Renderer; rect : SYSTEM.ADDRESS): BOOLEAN;
(** Fill a rectangle on the current rendering target with the drawing color at subpixel precision. *)
PROCEDURE RenderFillRect*(renderer : POINTER TO VAR Renderer; rect- : FRect): BOOLEAN;
BEGIN RETURN SDLRenderFillRect(renderer, SYSTEM.ADR(rect))
END RenderFillRect;
PROCEDURE ^ SDLRenderLines* ["SDL_RenderLines"] (renderer : POINTER TO VAR Renderer; points : SYSTEM.ADDRESS; count : INTEGER): BOOLEAN;
(* Draw a series of connected lines on the current rendering target at subpixel precision. *)
PROCEDURE RenderLines*(renderer : POINTER TO VAR Renderer; points- : ARRAY OF FPoint): BOOLEAN;
BEGIN RETURN SDLRenderLines(renderer, SYSTEM.ADR(points[0]), SYSTEM.VAL(INTEGER, LEN(points)))
END RenderLines;
PROCEDURE ^ SDLRenderLine* ["SDL_RenderLine"] (renderer : POINTER TO VAR Renderer; x1, y1, x2, y2 : REAL32): BOOLEAN;
(* Draw a line on the current rendering target at subpixel precision. *)
PROCEDURE RenderLine*(renderer : POINTER TO VAR Renderer; x1, y1, x2, y2 : REAL32): BOOLEAN;
VAR points : ARRAY 2 OF FPoint;
BEGIN
    (* Note : Workaround. Probably bug in argument calling with floats *)
    points[0].x := x1; points[0].y := y1;
    points[1].x := x2; points[1].y := y2;
    RETURN SDLRenderLines(renderer, SYSTEM.ADR(points[0]), 2)
END RenderLine;
PROCEDURE ^ SDLRenderPoints* ["SDL_RenderPoints"] (renderer : POINTER TO VAR Renderer; points : SYSTEM.ADDRESS; count : INTEGER): BOOLEAN;
(** Draw multiple points on the current rendering target at subpixel precision. *)
PROCEDURE RenderPoints*(renderer : POINTER TO VAR Renderer; points- : ARRAY OF FPoint): BOOLEAN;
BEGIN RETURN SDLRenderPoints(renderer, SYSTEM.ADR(points[0]), SYSTEM.VAL(INTEGER, LEN(points)))
END RenderPoints;
PROCEDURE ^ SDLRenderRect* ["SDL_RenderRect"] (renderer : POINTER TO VAR Renderer; rect : SYSTEM.ADDRESS): BOOLEAN;
(** Draw a rectangle on the current rendering target at subpixel precision. *)
PROCEDURE RenderRect*(renderer : POINTER TO VAR Renderer; rect- : FRect): BOOLEAN;
BEGIN RETURN SDLRenderRect(renderer, SYSTEM.ADR(rect))
END RenderRect;
PROCEDURE ^ RenderPresent* ["SDL_RenderPresent"] (renderer : POINTER TO VAR Renderer): BOOLEAN;

(* SDL_stdinc.h *)
PROCEDURE ^ cos* ["SDL_cos"] (x : REAL64): REAL64;
PROCEDURE ^ cosf* ["SDL_cosf"] (x : REAL32): REAL32;
PROCEDURE ^ sin* ["SDL_sin"] (x : REAL64): REAL64;
PROCEDURE ^ sinf* ["SDL_sinf"] (x : REAL32): REAL32;
PROCEDURE ^ srand* ["SDL_srand"] (seed : Uint64);
PROCEDURE ^ rand* ["SDL_rand"] (n : Sint32): Sint32;
PROCEDURE ^ randf* ["SDL_randf"] (): REAL32;

(* SDL_timer.h *)
PROCEDURE ^ GetTicks* ["SDL_GetTicks"] (): Uint64;
PROCEDURE ^ Delay* ["SDL_Delay"] (ms : Uint32);

(* SDL_video.h *)
PROCEDURE ^ SDLCreateWindow ["SDL_CreateWindow"] (title: POINTER TO VAR- CHAR; width, height: INTEGER; flags: Uint64): POINTER TO VAR Window;
(** Create a window with the specified dimensions and flags.  *)
PROCEDURE CreateWindow*(title-: ARRAY OF CHAR; width, height: INTEGER; flags: Uint64): POINTER TO VAR Window;
BEGIN RETURN SDLCreateWindow(PTR(title[0]), width, height, flags)
END CreateWindow;

END SDL3.