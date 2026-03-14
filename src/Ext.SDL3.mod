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

(* SDL_pixels.h *)
TYPE Color* = RECORD-
    r* : Uint8;
    g* : Uint8;
    b* : Uint8;
    a* : Uint8;
END;

TYPE FColor* = RECORD-
    r* : REAL32;
    g* : REAL32;
    b* : REAL32;
    a* : REAL32;
END;

TYPE Palette* = RECORD-
    ncolors : INTEGER;
    colors : POINTER TO VAR Color;
    version- : Uint32;
    refcount- : INTEGER;
END;
TYPE PtrPalette* = POINTER TO VAR Palette;
    
TYPE PixelFormatDetails* = RECORD-
    format : INTEGER;
    bits_per_pixel : Uint8;
    bytes_per_pixel : Uint8;
    padding : ARRAY 2 OF Uint8;
    Gmask : Uint32;
    Bmask: Uint32;
    Amask: Uint32;
    Rbits: Uint8;
    Gbits: Uint8;
    Bbits: Uint8;
    Abits: Uint8;
    Rshift: Uint8;
    Gshift: Uint8;
    Bshift: Uint8;
    Ashift: Uint8;
END;
TYPE PtrPixelFormatDetails* = POINTER TO VAR PixelFormatDetails;
    
(* SDL_rect.h *)
TYPE FPoint* = RECORD-
    x* : REAL32;
    y* : REAL32;
END;

TYPE Rect* = RECORD-
    x* : INTEGER;
    y* : INTEGER;
    w* : INTEGER;
    h* : INTEGER;
END;
TYPE PtrRect* = POINTER TO VAR Rect;
    
TYPE FRect* = RECORD-
    x* : REAL32;
    y* : REAL32;
    w* : REAL32;
    h* : REAL32;
END;
TYPE PtrFRect* = POINTER TO VAR FRect;

TYPE Vertex* = RECORD-
    position* : FPoint;
    color* : FColor;
    tex_coord* : FPoint;
END;
TYPE PtrVertex* = POINTER TO VAR Vertex;
    
(* SDL_render.h *)
TYPE Renderer* = RECORD- END;
TYPE PtrRenderer* = POINTER TO VAR Renderer;
TYPE Window* = RECORD- END;
TYPE PtrWindow* = POINTER TO VAR Window;
TYPE Texture* = RECORD-
    format- : INTEGER;
    w- : INTEGER;
    h- : INTEGER;
    refcount- : INTEGER;
END;
TYPE PtrTexture* = POINTER TO VAR Texture;


(* SDL_surface.h *)
TYPE Surface* = RECORD-
    flags- : Uint32;
    format- : INTEGER;
    w- : INTEGER;
    h- : INTEGER;
    pitch- : INTEGER;
    pixels- : SYSTEM.ADDRESS;
    refcount- : INTEGER;
    reserved- : SYSTEM.ADDRESS;
END;
TYPE PtrSurface* = POINTER TO VAR Surface;
    
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
CONST PIXELFORMAT_UNKNOWN*          = 0;
CONST PIXELFORMAT_INDEX1LSB*        = 11100100H;
CONST PIXELFORMAT_INDEX1MSB*        = 11200100H;
CONST PIXELFORMAT_INDEX2LSB*        = 1C100200H;
CONST PIXELFORMAT_INDEX2MSB*        = 1C200200H;
CONST PIXELFORMAT_INDEX4LSB*        = 12100400H;
CONST PIXELFORMAT_INDEX4MSB*        = 12200400H;
CONST PIXELFORMAT_INDEX8*           = 13000801H;
CONST PIXELFORMAT_RGB332*           = 14110801H;
CONST PIXELFORMAT_XRGB4444*         = 15120C02H;
CONST PIXELFORMAT_XBGR4444*         = 15520C02H;
CONST PIXELFORMAT_XRGB1555*         = 15130F02H;
CONST PIXELFORMAT_XBGR1555*         = 15530F02H;
CONST PIXELFORMAT_ARGB4444*         = 15321002H;
CONST PIXELFORMAT_RGBA4444*         = 15421002H;
CONST PIXELFORMAT_ABGR4444*         = 15721002H;
CONST PIXELFORMAT_BGRA4444*         = 15821002H;
CONST PIXELFORMAT_ARGB1555*         = 15331002H;
CONST PIXELFORMAT_RGBA5551*         = 15441002H;
CONST PIXELFORMAT_ABGR1555*         = 15731002H;
CONST PIXELFORMAT_BGRA5551*         = 15841002H;
CONST PIXELFORMAT_RGB565*           = 15151002H;
CONST PIXELFORMAT_BGR565*           = 15551002H;
CONST PIXELFORMAT_RGB24*            = 17101803H;
CONST PIXELFORMAT_BGR24*            = 17401803H;
CONST PIXELFORMAT_XRGB8888*         = 16161804H;
CONST PIXELFORMAT_RGBX8888*         = 16261804H;
CONST PIXELFORMAT_XBGR8888*         = 16561804H;
CONST PIXELFORMAT_BGRX8888*         = 16661804H;
CONST PIXELFORMAT_ARGB8888*         = 16362004H;
CONST PIXELFORMAT_RGBA8888*         = 16462004H;
CONST PIXELFORMAT_ABGR8888*         = 16762004H;
CONST PIXELFORMAT_BGRA8888*         = 16862004H;
CONST PIXELFORMAT_XRGB2101010*      = 16172004H;
CONST PIXELFORMAT_XBGR2101010*      = 16572004H;
CONST PIXELFORMAT_ARGB2101010*      = 16372004H;
CONST PIXELFORMAT_ABGR2101010*      = 16772004H;
CONST PIXELFORMAT_RGB48*            = 18103006H;
CONST PIXELFORMAT_BGR48*            = 18403006H;
CONST PIXELFORMAT_RGBA64*           = 18204008H;
CONST PIXELFORMAT_ARGB64*           = 18304008H;
CONST PIXELFORMAT_BGRA64*           = 18504008H;
CONST PIXELFORMAT_ABGR64*           = 18604008H;
CONST PIXELFORMAT_RGB48_FLOAT*      = 1A103006H;
CONST PIXELFORMAT_BGR48_FLOAT*      = 1A403006H;
CONST PIXELFORMAT_RGBA64_FLOAT*     = 1A204008H;
CONST PIXELFORMAT_ARGB64_FLOAT*     = 1A304008H;
CONST PIXELFORMAT_BGRA64_FLOAT*     = 1A504008H;
CONST PIXELFORMAT_ABGR64_FLOAT*     = 1A604008H;
CONST PIXELFORMAT_RGB96_FLOAT*      = 1B10600CH;
CONST PIXELFORMAT_BGR96_FLOAT*      = 1B40600CH;
CONST PIXELFORMAT_RGBA128_FLOAT*    = 1B208010H;
CONST PIXELFORMAT_ARGB128_FLOAT*    = 1B308010H;
CONST PIXELFORMAT_BGRA128_FLOAT*    = 1B508010H;
CONST PIXELFORMAT_ABGR128_FLOAT*    = 1B608010H;
CONST PIXELFORMAT_YV12*             = 32315659H;
CONST PIXELFORMAT_IYUV*             = 56555949H;
CONST PIXELFORMAT_YUY2*             = 32595559H;
CONST PIXELFORMAT_UYVY*             = 59565955H;
CONST PIXELFORMAT_YVYU*             = 55595659H;
CONST PIXELFORMAT_NV12*             = 3231564EH;
CONST PIXELFORMAT_NV21*             = 3132564EH;
CONST PIXELFORMAT_P010*             = 30313050H;
CONST PIXELFORMAT_EXTERNAL_OES*     = 2053454FH;
CONST PIXELFORMAT_MJPG*             = 47504A4DH;

(* SDL_render.h *)
CONST LOGICAL_PRESENTATION_DISABLED*        = 0;
CONST LOGICAL_PRESENTATION_STRETCH*         = 1;
CONST LOGICAL_PRESENTATION_LETTERBOX*       = 2;
CONST LOGICAL_PRESENTATION_OVERSCAN*        = 3;
CONST LOGICAL_PRESENTATION_INTEGER_SCALE*   = 4;
CONST TEXTUREACCESS_STATIC*     = 0;
CONST TEXTUREACCESS_STREAMING*  = 1;
CONST TEXTUREACCESS_TARGET*     = 2;
CONST DEBUG_TEXT_FONT_CHARACTER_SIZE* = 8;

(* SDL_stdinc.h *)
CONST PI_D* = 3.141592653589793238462643383279502884;
CONST PI_F* = REAL32(3.141592653589793238462643383279502884);

(* SDL_surface.h *)
CONST FLIP_NONE* = 0;
CONST FLIP_HORIZONTAL* = 1;
CONST FLIP_VERTICAL* = 2;
CONST FLIP_HORIZONTAL_AND_VERTICAL* = 3;

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

(* SDL_pixels.h *)
PROCEDURE ^ GetPixelFormatDetails* ["SDL_GetPixelFormatDetails"] (format: INTEGER): PtrPixelFormatDetails;
PROCEDURE ^ SDLMapRGB* ["SDL_MapRGB"] (format: PtrPixelFormatDetails; palette: PtrPalette; r : Uint8; g: Uint8; b: Uint8): Uint32;
(** Create a 2D rendering context for a window. *)
PROCEDURE MapRGB*(format: PtrPixelFormatDetails; palette: PtrPalette; r, g, b : INTEGER): Uint32;
BEGIN RETURN SDLMapRGB(format, palette, Uint8(r), Uint8(g), Uint8(b))
END MapRGB;

(* SDL_render.h *)
PROCEDURE ^ DestroyRenderer* ["SDL_DestroyRenderer"] (renderer : POINTER TO VAR Renderer);

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

PROCEDURE ^ CreateTexture* ["SDL_CreateTexture"] (renderer : POINTER TO VAR Renderer; format : INTEGER; access : INTEGER; w, h : INTEGER): POINTER TO VAR Texture;
PROCEDURE ^ CreateTextureFromSurface* ["SDL_CreateTextureFromSurface"] (renderer : POINTER TO VAR Renderer; surface : POINTER TO VAR Surface): POINTER TO VAR Texture;

PROCEDURE ^ SDLLockTextureToSurface ["SDL_LockTextureToSurface"] (texture : POINTER TO VAR Texture; rect : POINTER TO VAR FRect; surface : SYSTEM.ADDRESS): BOOLEAN;
(** Lock a portion of the texture for write-only pixel access, and expose it as a SDL surface. *)
PROCEDURE LockTextureToSurface*(texture : POINTER TO VAR Texture; rect : POINTER TO VAR FRect; VAR surface : PtrSurface): BOOLEAN;
BEGIN RETURN SDLLockTextureToSurface(texture, rect, SYSTEM.ADR(surface))
END LockTextureToSurface;

PROCEDURE ^ SetTextureColorModFloat* ["SDL_SetTextureColorModFloat_wrap"] (texture : POINTER TO VAR Texture; r : REAL32; g : REAL32; b : REAL32): BOOLEAN;
PROCEDURE ^ UnlockTexture* ["SDL_UnlockTexture"] (texture : POINTER TO VAR Texture);
PROCEDURE ^ DestroyTexture* ["SDL_DestroyTexture"] (texture : POINTER TO VAR Texture);
PROCEDURE ^ SetRenderLogicalPresentation* ["SDL_SetRenderLogicalPresentation"] (renderer : POINTER TO VAR Renderer; w, h : INTEGER; mode: INTEGER): BOOLEAN;
PROCEDURE ^ SetRenderViewport* ["SDL_SetRenderViewport"] (renderer : POINTER TO VAR Renderer; rect : POINTER TO VAR Rect): BOOLEAN;
PROCEDURE ^ SetRenderClipRect* ["SDL_SetRenderClipRect"] (renderer : POINTER TO VAR Renderer; rect : POINTER TO VAR Rect): BOOLEAN;
PROCEDURE ^ SetRenderScale* ["SDL_SetRenderScale_wrap"] (renderer : POINTER TO VAR Renderer; scaleX: REAL32; scaleY: REAL32): BOOLEAN;
PROCEDURE ^ SDLSetRenderDrawColor* ["SDL_SetRenderDrawColor"] (renderer : POINTER TO VAR Renderer; r, g, b, a: Uint8): BOOLEAN;
(* Set the color used for drawing operations. *)
PROCEDURE SetRenderDrawColor*(renderer : POINTER TO VAR Renderer; r, g, b, a: INTEGER): BOOLEAN;
BEGIN RETURN SDLSetRenderDrawColor(renderer, Uint8(r), Uint8(g), Uint8(b), Uint8(a))
END SetRenderDrawColor;
PROCEDURE ^ SetRenderDrawColorFloat* ["SDL_SetRenderDrawColorFloat_wrap"] (renderer : POINTER TO VAR Renderer; r, g, b, a: REAL32): BOOLEAN;
PROCEDURE ^ RenderClear* ["SDL_RenderClear"] (renderer : POINTER TO VAR Renderer): BOOLEAN;
PROCEDURE ^ SDLRenderFillRect* ["SDL_RenderFillRect"] (renderer : POINTER TO VAR Renderer; rect : SYSTEM.ADDRESS): BOOLEAN;
(** Fill a rectangle on the current rendering target with the drawing color at subpixel precision. *)
PROCEDURE RenderFillRect*(renderer : POINTER TO VAR Renderer; rect- : FRect): BOOLEAN;
BEGIN RETURN SDLRenderFillRect(renderer, SYSTEM.ADR(rect))
END RenderFillRect;
PROCEDURE ^ SDLRenderLines* ["SDL_RenderLines"] (renderer : POINTER TO VAR Renderer; points : SYSTEM.ADDRESS; count : INTEGER): BOOLEAN;
(* Draw a series of connected lines on the current rendering target at subpixel precision. *)
PROCEDURE RenderLines*(renderer : POINTER TO VAR Renderer; points- : ARRAY OF FPoint; count : LENGTH): BOOLEAN;
BEGIN RETURN SDLRenderLines(renderer, SYSTEM.ADR(points[0]), SYSTEM.VAL(INTEGER, count))
END RenderLines;
PROCEDURE ^ RenderLine* ["SDL_RenderLine_wrap"] (renderer : POINTER TO VAR Renderer; x1, y1, x2, y2 : REAL32): BOOLEAN;
PROCEDURE ^ RenderPoint* ["SDL_RenderPoint_wrap"] (renderer : POINTER TO VAR Renderer; x, y: REAL32): BOOLEAN;
PROCEDURE ^ SDLRenderPoints* ["SDL_RenderPoints"] (renderer : POINTER TO VAR Renderer; points : SYSTEM.ADDRESS; count : INTEGER): BOOLEAN;
(** Draw multiple points on the current rendering target at subpixel precision. *)
PROCEDURE RenderPoints*(renderer : POINTER TO VAR Renderer; points- : ARRAY OF FPoint; count : LENGTH): BOOLEAN;
BEGIN RETURN SDLRenderPoints(renderer, SYSTEM.ADR(points[0]), SYSTEM.VAL(INTEGER, count))
END RenderPoints;
PROCEDURE ^ SDLRenderRect* ["SDL_RenderRect"] (renderer : POINTER TO VAR Renderer; rect : SYSTEM.ADDRESS): BOOLEAN;
(** Draw a rectangle on the current rendering target at subpixel precision. *)
PROCEDURE RenderRect*(renderer : POINTER TO VAR Renderer; rect- : FRect): BOOLEAN;
BEGIN RETURN SDLRenderRect(renderer, SYSTEM.ADR(rect))
END RenderRect;
PROCEDURE ^ SDLRenderRects* ["SDL_RenderRects"] (renderer : POINTER TO VAR Renderer; rects : SYSTEM.ADDRESS; count : INTEGER): BOOLEAN;
(** Draw some number of rectangles on the current rendering target at subpixel precision. *)
PROCEDURE RenderRects*(renderer : POINTER TO VAR Renderer; rects- : ARRAY OF FRect; count : LENGTH): BOOLEAN;
BEGIN RETURN SDLRenderRects(renderer, SYSTEM.ADR(rects[0]), SYSTEM.VAL(INTEGER, count))
END RenderRects;
PROCEDURE ^ SDLRenderFillRects* ["SDL_RenderFillRects"] (renderer : POINTER TO VAR Renderer; rects : SYSTEM.ADDRESS; count : INTEGER): BOOLEAN;
(** Fill some number of rectangles on the current rendering target with the drawing color at subpixel precision. *)
PROCEDURE RenderFillRects*(renderer : POINTER TO VAR Renderer; rects- : ARRAY OF FRect; count : LENGTH): BOOLEAN;
BEGIN RETURN SDLRenderFillRects(renderer, SYSTEM.ADR(rects[0]), SYSTEM.VAL(INTEGER, count))
END RenderFillRects;

PROCEDURE ^ RenderTexture* ["SDL_RenderTexture"] (renderer : POINTER TO VAR Renderer; texture : POINTER TO VAR Texture; srcrect : POINTER TO VAR FRect;
                                                  dstrect : POINTER TO VAR FRect): BOOLEAN;
PROCEDURE ^ RenderTextureRotated* ["SDL_RenderTextureRotated_wrap"] (renderer : POINTER TO VAR Renderer; texture : POINTER TO VAR Texture; srcrect : POINTER TO VAR FRect;
                                                                     dstrect : POINTER TO VAR FRect; angle : REAL64; center : POINTER TO VAR FPoint; flip : INTEGER): BOOLEAN;

PROCEDURE ^ RenderGeometry* ["SDL_RenderGeometry"] (renderer : POINTER TO VAR Renderer; texture : POINTER TO VAR Texture; vertices : POINTER TO VAR Vertex;
                                                    num_vertices : INTEGER; indices: POINTER TO VAR INTEGER; num_indices: INTEGER): BOOLEAN;

PROCEDURE ^ SDLRenderDebugText ["SDL_RenderDebugText_wrap"] (renderer : POINTER TO VAR Renderer; x: REAL32; y: REAL32; str: POINTER TO VAR- CHAR): BOOLEAN;
PROCEDURE RenderDebugText*(renderer : POINTER TO VAR Renderer; x: REAL32; y: REAL32; str-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLRenderDebugText(renderer, x, y, PTR(str[0]))
END RenderDebugText;
    
PROCEDURE ^ RenderPresent* ["SDL_RenderPresent"] (renderer : POINTER TO VAR Renderer): BOOLEAN;

(* SDL_surface.h *)
PROCEDURE ^ DestroySurface* ["SDL_DestroySurface"] (surface : POINTER TO VAR Surface);
PROCEDURE ^ SDLLoadPNG ["SDL_LoadPNG"] (file: POINTER TO VAR- CHAR): POINTER TO VAR Surface;
(** Load a PNG image from a file. *)
PROCEDURE LoadPNG*(file-: ARRAY OF CHAR): POINTER TO VAR Surface;
BEGIN RETURN SDLLoadPNG(PTR(file[0]))
END LoadPNG;

PROCEDURE ^ FillSurfaceRect* ["SDL_FillSurfaceRect"] (dst : POINTER TO VAR Surface; rect : POINTER TO VAR Rect; color: Uint32): BOOLEAN;

(* SDL_stdinc.h *)
PROCEDURE ^ memset* ["SDL_memset"] (dst : SYSTEM.ADDRESS; c : INTEGER;  len : Uint64): SYSTEM.ADDRESS;
PROCEDURE ^ srand* ["SDL_srand"] (seed : Uint64);
PROCEDURE ^ rand* ["SDL_rand"] (n : Sint32): Sint32;
PROCEDURE ^ randf* ["SDL_randf"] (): REAL32;
PROCEDURE ^ acos* ["SDL_acos_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ acosf* ["SDL_acosf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ asin* ["SDL_asin_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ asinf* ["SDL_asinf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ atan* ["SDL_atan_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ atanf* ["SDL_atanf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ atan2* ["SDL_atan2_wrap"] (x : REAL64; y: REAL64): REAL64;
PROCEDURE ^ atan2f* ["SDL_atan2f_wrap"] (x : REAL32; y: REAL32): REAL32;
PROCEDURE ^ ceil* ["SDL_ceil_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ ceilf* ["SDL_ceilf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ copysign* ["SDL_copysign_wrap"] (x : REAL64; y: REAL64): REAL64;
PROCEDURE ^ copysignf* ["SDL_copysignf_wrap"] (x : REAL32; y: REAL32): REAL32;
PROCEDURE ^ cos* ["SDL_cos_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ cosf* ["SDL_cosf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ exp* ["SDL_exp_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ expf* ["SDL_expf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ cosf* ["SDL_cosf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ fabs* ["SDL_fabs_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ fabsf* ["SDL_fabsf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ floor* ["SDL_floor_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ floorf* ["SDL_floorf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ trunc* ["SDL_trunc_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ truncf* ["SDL_truncf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ fmod* ["SDL_fmod_wrap"] (x : REAL64; y: REAL64): REAL64;
PROCEDURE ^ fmodf* ["SDL_fmodf_wrap"] (x : REAL32; y: REAL32): REAL32;
PROCEDURE ^ isinf* ["SDL_isinf_wrap"] (x : REAL64): INTEGER;
PROCEDURE ^ isinff* ["SDL_isinff_wrap"] (x : REAL32): INTEGER;
PROCEDURE ^ isnan* ["SDL_isnan_wrap"] (x : REAL64): INTEGER;
PROCEDURE ^ isnanf* ["SDL_isnanf_wrap"] (x : REAL32): INTEGER;
PROCEDURE ^ log* ["SDL_log_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ logf* ["SDL_logf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ log10* ["SDL_log10_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ log10f* ["SDL_log10f_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ pow* ["SDL_pow_wrap"] (x : REAL64; y: REAL64): REAL64;
PROCEDURE ^ powf* ["SDL_powf_wrap"] (x : REAL32; y: REAL32): REAL32;
PROCEDURE ^ round* ["SDL_round_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ roundf* ["SDL_roundf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ sin* ["SDL_sin_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ sinf* ["SDL_sinf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ sqrt* ["SDL_sqrt_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ sqrtf* ["SDL_sqrtf_wrap"] (x : REAL32): REAL32;
PROCEDURE ^ tan* ["SDL_tan_wrap"] (x : REAL64): REAL64;
PROCEDURE ^ tanf* ["SDL_tanf_wrap"] (x : REAL32): REAL32;

(* SDL_timer.h *)
PROCEDURE ^ GetTicks* ["SDL_GetTicks"] (): Uint64;
PROCEDURE ^ Delay* ["SDL_Delay"] (ms : Uint32);

(* SDL_video.h *)
PROCEDURE ^ DestroyWindow* ["SDL_DestroyWindow"] (window: POINTER TO VAR Window);

PROCEDURE ^ SDLCreateWindow ["SDL_CreateWindow"] (title: POINTER TO VAR- CHAR; width, height: INTEGER; flags: Uint64): POINTER TO VAR Window;
(** Create a window with the specified dimensions and flags.  *)
PROCEDURE CreateWindow*(title-: ARRAY OF CHAR; width, height: INTEGER; flags: Uint64): POINTER TO VAR Window;
BEGIN RETURN SDLCreateWindow(PTR(title[0]), width, height, flags)
END CreateWindow;

END SDL3.