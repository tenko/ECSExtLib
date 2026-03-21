MODULE SDL3 IN Ext;

IMPORT SYSTEM;

TYPE PCHAR* = POINTER TO VAR- CHAR;
TYPE Sint32* = SIGNED32;
TYPE Sint64* = SIGNED64;
TYPE Uint8* = UNSIGNED8;
TYPE Uint16* = UNSIGNED16;
TYPE Uint32* = UNSIGNED32;
TYPE Uint64* = UNSIGNED64;

(* SDL_event.h *)
TYPE Event* = RECORD-
	type*: Uint32;
	padding*: ARRAY 128 OF CHAR;
END;

(* SDL_filesystem.h *)
TYPE PathInfo* = RECORD-
	type : INTEGER;
	size : Uint64;
	create_time : Sint64;
	modify_time : Sint64;
	access_time : Sint64;
END;

(* SDL_iostream.h *)
TYPE IOStream* = RECORD- END;
TYPE PtrIOStream* = POINTER TO VAR IOStream;

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

(* SDL_process.h *)
TYPE Process* = RECORD-
END;
TYPE PtrProcess* = POINTER TO VAR Process;

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

(* SDL_filesystem.h *)
CONST FOLDER_HOME*       	= 0;
CONST FOLDER_DESKTOP*    	= 1;
CONST FOLDER_DOCUMENTS*  	= 2;
CONST FOLDER_DOWNLOADS*  	= 3;
CONST FOLDER_MUSIC*      	= 4;
CONST FOLDER_PICTURES*   	= 5;
CONST FOLDER_PUBLICSHARE*	= 6;
CONST FOLDER_SAVEDGAMES* 	= 7;
CONST FOLDER_SCREENSHOTS*	= 8;
CONST FOLDER_TEMPLATES*		= 9;  
CONST FOLDER_VIDEOS*		= 10;
CONST FOLDER_COUNT*			= 11;

CONST PATHTYPE_NONE*    	= 0;  
CONST PATHTYPE_FILE*      	= 1;
CONST PATHTYPE_DIRECTORY* 	= 2;
CONST PATHTYPE_OTHER*		= 3;
    
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

(* SDL_iostream.h *)
CONST IO_STATUS_READY*     = 0;
CONST IO_STATUS_ERROR*     = 1;
CONST IO_STATUS_EOF*       = 2;
CONST IO_STATUS_NOT_READY* = 3;
CONST IO_STATUS_READONLY*  = 4;
CONST IO_STATUS_WRITEONLY* = 5;
CONST IO_SEEK_SET* = 0;
CONST IO_SEEK_CUR* = 1;
CONST IO_SEEK_END* = 2;

(* SDL_messagebox.h *)
CONST MESSAGEBOX_ERROR*                    = 00000010H;
CONST MESSAGEBOX_WARNING*                  = 00000020H;
CONST MESSAGEBOX_INFORMATION*              = 00000040H;
CONST MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT*    = 00000080H;
CONST MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT*    = 00000100H;

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

(* SDL_scancode.h*)
CONST SCANCODE_UNKNOWN* = 0;
CONST SCANCODE_A* = 4;
CONST SCANCODE_B* = 5;
CONST SCANCODE_C* = 6;
CONST SCANCODE_D* = 7;
CONST SCANCODE_E* = 8;
CONST SCANCODE_F* = 9;
CONST SCANCODE_G* = 10;
CONST SCANCODE_H* = 11;
CONST SCANCODE_I* = 12;
CONST SCANCODE_J* = 13;
CONST SCANCODE_K* = 14;
CONST SCANCODE_L* = 15;
CONST SCANCODE_M* = 16;
CONST SCANCODE_N* = 17;
CONST SCANCODE_O* = 18;
CONST SCANCODE_P* = 19;
CONST SCANCODE_Q* = 20;
CONST SCANCODE_R* = 21;
CONST SCANCODE_S* = 22;
CONST SCANCODE_T* = 23;
CONST SCANCODE_U* = 24;
CONST SCANCODE_V* = 25;
CONST SCANCODE_W* = 26;
CONST SCANCODE_X* = 27;
CONST SCANCODE_Y* = 28;
CONST SCANCODE_Z* = 29;
CONST SCANCODE_1* = 30;
CONST SCANCODE_2* = 31;
CONST SCANCODE_3* = 32;
CONST SCANCODE_4* = 33;
CONST SCANCODE_5* = 34;
CONST SCANCODE_6* = 35;
CONST SCANCODE_7* = 36;
CONST SCANCODE_8* = 37;
CONST SCANCODE_9* = 38;
CONST SCANCODE_0* = 39;
CONST SCANCODE_RETURN* = 40;
CONST SCANCODE_ESCAPE* = 41;
CONST SCANCODE_BACKSPACE* = 42;
CONST SCANCODE_TAB* = 43;
CONST SCANCODE_SPACE* = 44;
CONST SCANCODE_MINUS* = 45;
CONST SCANCODE_EQUALS* = 46;
CONST SCANCODE_LEFTBRACKET* = 47;
CONST SCANCODE_RIGHTBRACKET* = 48;
CONST SCANCODE_BACKSLASH* = 49;
CONST SCANCODE_NONUSHASH* = 50;
CONST SCANCODE_SEMICOLON* = 51;
CONST SCANCODE_APOSTROPHE* = 52;
CONST SCANCODE_GRAVE* = 53;
CONST SCANCODE_COMMA* = 54;
CONST SCANCODE_PERIOD* = 55;
CONST SCANCODE_SLASH* = 56;
CONST SCANCODE_CAPSLOCK* = 57;
CONST SCANCODE_F1* = 58;
CONST SCANCODE_F2* = 59;
CONST SCANCODE_F3* = 60;
CONST SCANCODE_F4* = 61;
CONST SCANCODE_F5* = 62;
CONST SCANCODE_F6* = 63;
CONST SCANCODE_F7* = 64;
CONST SCANCODE_F8* = 65;
CONST SCANCODE_F9* = 66;
CONST SCANCODE_F10* = 67;
CONST SCANCODE_F11* = 68;
CONST SCANCODE_F12* = 69;
CONST SCANCODE_PRINTSCREEN* = 70;
CONST SCANCODE_SCROLLLOCK* = 71;
CONST SCANCODE_PAUSE* = 72;
CONST SCANCODE_INSERT* = 73;
CONST SCANCODE_HOME* = 74;
CONST SCANCODE_PAGEUP* = 75;
CONST SCANCODE_DELETE* = 76;
CONST SCANCODE_END* = 77;
CONST SCANCODE_PAGEDOWN* = 78;
CONST SCANCODE_RIGHT* = 79;
CONST SCANCODE_LEFT* = 80;
CONST SCANCODE_DOWN* = 81;
CONST SCANCODE_UP* = 82;
CONST SCANCODE_NUMLOCKCLEAR* = 83;
CONST SCANCODE_KP_DIVIDE* = 84;
CONST SCANCODE_KP_MULTIPLY* = 85;
CONST SCANCODE_KP_MINUS* = 86;
CONST SCANCODE_KP_PLUS* = 87;
CONST SCANCODE_KP_ENTER* = 88;
CONST SCANCODE_KP_1* = 89;
CONST SCANCODE_KP_2* = 90;
CONST SCANCODE_KP_3* = 91;
CONST SCANCODE_KP_4* = 92;
CONST SCANCODE_KP_5* = 93;
CONST SCANCODE_KP_6* = 94;
CONST SCANCODE_KP_7* = 95;
CONST SCANCODE_KP_8* = 96;
CONST SCANCODE_KP_9* = 97;
CONST SCANCODE_KP_0* = 98;
CONST SCANCODE_KP_PERIOD* = 99;
CONST SCANCODE_NONUSBACKSLASH* = 100;
CONST SCANCODE_APPLICATION* = 101;
CONST SCANCODE_POWER* = 102;
CONST SCANCODE_KP_EQUALS* = 103;
CONST SCANCODE_F13* = 104;
CONST SCANCODE_F14* = 105;
CONST SCANCODE_F15* = 106;
CONST SCANCODE_F16* = 107;
CONST SCANCODE_F17* = 108;
CONST SCANCODE_F18* = 109;
CONST SCANCODE_F19* = 110;
CONST SCANCODE_F20* = 111;
CONST SCANCODE_F21* = 112;
CONST SCANCODE_F22* = 113;
CONST SCANCODE_F23* = 114;
CONST SCANCODE_F24* = 115;
CONST SCANCODE_EXECUTE* = 116;
CONST SCANCODE_HELP* = 117;
CONST SCANCODE_MENU* = 118;
CONST SCANCODE_SELECT* = 119;
CONST SCANCODE_STOP* = 120;
CONST SCANCODE_AGAIN* = 121;
CONST SCANCODE_UNDO* = 122;
CONST SCANCODE_CUT* = 123;
CONST SCANCODE_COPY* = 124;
CONST SCANCODE_PASTE* = 125;
CONST SCANCODE_FIND* = 126;
CONST SCANCODE_MUTE* = 127;
CONST SCANCODE_VOLUMEUP* = 128;
CONST SCANCODE_VOLUMEDOWN* = 129;
CONST SCANCODE_KP_COMMA* = 133;
CONST SCANCODE_KP_EQUALSAS400* = 134;
CONST SCANCODE_INTERNATIONAL1* = 135;
CONST SCANCODE_INTERNATIONAL2* = 136;
CONST SCANCODE_INTERNATIONAL3* = 137;
CONST SCANCODE_INTERNATIONAL4* = 138;
CONST SCANCODE_INTERNATIONAL5* = 139;
CONST SCANCODE_INTERNATIONAL6* = 140;
CONST SCANCODE_INTERNATIONAL7* = 141;
CONST SCANCODE_INTERNATIONAL8* = 142;
CONST SCANCODE_INTERNATIONAL9* = 143;
CONST SCANCODE_LANG1* = 144;
CONST SCANCODE_LANG2* = 145;
CONST SCANCODE_LANG3* = 146;
CONST SCANCODE_LANG4* = 147;
CONST SCANCODE_LANG5* = 148;
CONST SCANCODE_LANG6* = 149;
CONST SCANCODE_LANG7* = 150;
CONST SCANCODE_LANG8* = 151;
CONST SCANCODE_LANG9* = 152;
CONST SCANCODE_ALTERASE* = 153;
CONST SCANCODE_SYSREQ* = 154;
CONST SCANCODE_CANCEL* = 155;
CONST SCANCODE_CLEAR* = 156;
CONST SCANCODE_PRIOR* = 157;
CONST SCANCODE_RETURN2* = 158;
CONST SCANCODE_SEPARATOR* = 159;
CONST SCANCODE_OUT* = 160;
CONST SCANCODE_OPER* = 161;
CONST SCANCODE_CLEARAGAIN* = 162;
CONST SCANCODE_CRSEL* = 163;
CONST SCANCODE_EXSEL* = 164;
CONST SCANCODE_KP_00* = 176;
CONST SCANCODE_KP_000* = 177;
CONST SCANCODE_THOUSANDSSEPARATOR* = 178;
CONST SCANCODE_DECIMALSEPARATOR* = 179;
CONST SCANCODE_CURRENCYUNIT* = 180;
CONST SCANCODE_CURRENCYSUBUNIT* = 181;
CONST SCANCODE_KP_LEFTPAREN* = 182;
CONST SCANCODE_KP_RIGHTPAREN* = 183;
CONST SCANCODE_KP_LEFTBRACE* = 184;
CONST SCANCODE_KP_RIGHTBRACE* = 185;
CONST SCANCODE_KP_TAB* = 186;
CONST SCANCODE_KP_BACKSPACE* = 187;
CONST SCANCODE_KP_A* = 188;
CONST SCANCODE_KP_B* = 189;
CONST SCANCODE_KP_C* = 190;
CONST SCANCODE_KP_D* = 191;
CONST SCANCODE_KP_E* = 192;
CONST SCANCODE_KP_F* = 193;
CONST SCANCODE_KP_XOR* = 194;
CONST SCANCODE_KP_POWER* = 195;
CONST SCANCODE_KP_PERCENT* = 196;
CONST SCANCODE_KP_LESS* = 197;
CONST SCANCODE_KP_GREATER* = 198;
CONST SCANCODE_KP_AMPERSAND* = 199;
CONST SCANCODE_KP_DBLAMPERSAND* = 200;
CONST SCANCODE_KP_VERTICALBAR* = 201;
CONST SCANCODE_KP_DBLVERTICALBAR* = 202;
CONST SCANCODE_KP_COLON* = 203;
CONST SCANCODE_KP_HASH* = 204;
CONST SCANCODE_KP_SPACE* = 205;
CONST SCANCODE_KP_AT* = 206;
CONST SCANCODE_KP_EXCLAM* = 207;
CONST SCANCODE_KP_MEMSTORE* = 208;
CONST SCANCODE_KP_MEMRECALL* = 209;
CONST SCANCODE_KP_MEMCLEAR* = 210;
CONST SCANCODE_KP_MEMADD* = 211;
CONST SCANCODE_KP_MEMSUBTRACT* = 212;
CONST SCANCODE_KP_MEMMULTIPLY* = 213;
CONST SCANCODE_KP_MEMDIVIDE* = 214;
CONST SCANCODE_KP_PLUSMINUS* = 215;
CONST SCANCODE_KP_CLEAR* = 216;
CONST SCANCODE_KP_CLEARENTRY* = 217;
CONST SCANCODE_KP_BINARY* = 218;
CONST SCANCODE_KP_OCTAL* = 219;
CONST SCANCODE_KP_DECIMAL* = 220;
CONST SCANCODE_KP_HEXADECIMAL* = 221;
CONST SCANCODE_LCTRL* = 224;
CONST SCANCODE_LSHIFT* = 225;
CONST SCANCODE_LALT* = 226;
CONST SCANCODE_LGUI* = 227;
CONST SCANCODE_RCTRL* = 228;
CONST SCANCODE_RSHIFT* = 229;
CONST SCANCODE_RALT* = 230;
CONST SCANCODE_RGUI* = 231;
CONST SCANCODE_MODE* = 257;
CONST SCANCODE_SLEEP* = 258;
CONST SCANCODE_WAKE* = 259;
CONST SCANCODE_CHANNEL_INCREMENT* = 260;
CONST SCANCODE_CHANNEL_DECREMENT* = 261;
CONST SCANCODE_MEDIA_PLAY* = 262;
CONST SCANCODE_MEDIA_PAUSE* = 263;
CONST SCANCODE_MEDIA_RECORD* = 264;
CONST SCANCODE_MEDIA_FAST_FORWARD* = 265;
CONST SCANCODE_MEDIA_REWIND* = 266;
CONST SCANCODE_MEDIA_NEXT_TRACK* = 267;
CONST SCANCODE_MEDIA_PREVIOUS_TRACK* = 268;
CONST SCANCODE_MEDIA_STOP* = 269;
CONST SCANCODE_MEDIA_EJECT* = 270;
CONST SCANCODE_MEDIA_PLAY_PAUSE* = 271;
CONST SCANCODE_MEDIA_SELECT* = 272;
CONST SCANCODE_AC_NEW* = 273;
CONST SCANCODE_AC_OPEN* = 274;
CONST SCANCODE_AC_CLOSE* = 275;
CONST SCANCODE_AC_EXIT* = 276;
CONST SCANCODE_AC_SAVE* = 277;
CONST SCANCODE_AC_PRINT* = 278;
CONST SCANCODE_AC_PROPERTIES* = 279;
CONST SCANCODE_AC_SEARCH* = 280;
CONST SCANCODE_AC_HOME* = 281;
CONST SCANCODE_AC_BACK* = 282;
CONST SCANCODE_AC_FORWARD* = 283;
CONST SCANCODE_AC_STOP* = 284;
CONST SCANCODE_AC_REFRESH* = 285;
CONST SCANCODE_AC_BOOKMARKS* = 286;
CONST SCANCODE_SOFTLEFT* = 287;
CONST SCANCODE_SOFTRIGHT* = 288;
CONST SCANCODE_CALL* = 289;
CONST SCANCODE_ENDCALL* = 290;
CONST SCANCODE_RESERVED* = 400;
CONST SCANCODE_COUNT* = 512;

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

(* SDL_stdinc.h *)
PROCEDURE ^ memset* ["SDL_memset"] (dst : SYSTEM.ADDRESS; c : INTEGER;  len : Uint64): SYSTEM.ADDRESS;
PROCEDURE ^ strlen* ["SDL_strlen"] (str : POINTER TO VAR- CHAR): LENGTH;

(* SDL_filesystem.h *)
PROCEDURE ^ SDLCopyFile ["SDL_CopyFile"] (oldpath: PCHAR; newpath : PCHAR): BOOLEAN;
PROCEDURE CopyFile*(oldpath-: ARRAY OF CHAR; newpath-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLCopyFile(PTR(oldpath[0]), PTR(newpath[0]))
END CopyFile;

PROCEDURE ^ SDLCreateDirectory ["SDL_CreateDirectory"] (path: PCHAR): BOOLEAN;
PROCEDURE CreateDirectory*(path-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLCreateDirectory(PTR(path[0]))
END CreateDirectory;

PROCEDURE ^ GetBasePath* ["SDL_GetBasePath"] (): PCHAR;
PROCEDURE ^ GetCurrentDirectory* ["SDL_GetCurrentDirectory"] (): PCHAR;

PROCEDURE ^ SDLGetPathInfo ["SDL_GetPathInfo"] (path: PCHAR; info : POINTER TO VAR- PathInfo): BOOLEAN;
PROCEDURE GetPathInfo*(path-: ARRAY OF CHAR; VAR info : PathInfo): BOOLEAN;
BEGIN RETURN SDLGetPathInfo(PTR(path[0]), PTR(info))
END GetPathInfo;

PROCEDURE ^ GetPrefPath* ["SDL_GetPrefPath"] (org: PCHAR; app : PCHAR): PCHAR;
PROCEDURE ^ GetUserFolder* ["SDL_GetUserFolder"] (folder : INTEGER): PCHAR;

PROCEDURE ^ SDLRemovePath ["SDL_RemovePath"] (path: PCHAR): BOOLEAN;
PROCEDURE RemovePath*(path-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLRemovePath(PTR(path[0]))
END RemovePath;

PROCEDURE ^ SDLRenamePath ["SDL_RenamePath"] (oldpath: PCHAR; newpath : PCHAR): BOOLEAN;
PROCEDURE RenamePath*(oldpath-: ARRAY OF CHAR; newpath-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLRenamePath(PTR(oldpath[0]), PTR(newpath[0]))
END RenamePath;

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

(* SDL_iostream.h *)
PROCEDURE ^ CloseIO* ["SDL_CloseIO"] (context : POINTER TO VAR IOStream): BOOLEAN;
PROCEDURE ^ FlushIO* ["SDL_FlushIO"] (context : POINTER TO VAR IOStream): BOOLEAN;
PROCEDURE ^ GetIOSize* ["SDL_GetIOSize"] (context : POINTER TO VAR IOStream): LENGTH;
PROCEDURE ^ GetIOStatus* ["SDL_GetIOStatus"] (context : POINTER TO VAR IOStream): INTEGER;
PROCEDURE ^ SDLIOFromFile ["SDL_IOFromFile"] (file, mode : POINTER TO VAR- CHAR): PtrIOStream;
(** Use this function to create a new SDL_IOStream structure for reading from and/or writing to a named file.*)
PROCEDURE IOFromFile*(file-, mode-: ARRAY OF CHAR): PtrIOStream;
BEGIN RETURN SDLIOFromFile(PTR(file[0]), PTR(mode[0]))
END IOFromFile;
PROCEDURE ^ SDLReadIO ["SDL_ReadIO"] (context : POINTER TO VAR IOStream; ptr : SYSTEM.ADDRESS; size : LENGTH): LENGTH;
(** Read from a data source. *)
PROCEDURE ReadIO*(context : POINTER TO VAR IOStream; buffer : ARRAY OF SYSTEM.BYTE): LENGTH;
BEGIN RETURN SDLReadIO(context, SYSTEM.ADR(buffer[0]), LEN(buffer))
END ReadIO;

PROCEDURE ReadStr*(context : POINTER TO VAR IOStream; VAR buffer : ARRAY OF CHAR): LENGTH;
BEGIN RETURN SDLReadIO(context, SYSTEM.ADR(buffer[0]), LEN(buffer))
END ReadStr;

PROCEDURE ^ SeekIO* ["SDL_SeekIO"] (context : POINTER TO VAR IOStream; offset : LENGTH; whence : INTEGER): LENGTH;
PROCEDURE ^ TellIO* ["SDL_TellIO"] (context : POINTER TO VAR IOStream): LENGTH;

PROCEDURE ^ SDLWriteIO ["SDL_WriteIO"] (context : POINTER TO VAR IOStream; ptr : SYSTEM.ADDRESS; size : LENGTH): LENGTH;
(** Write to an SDL3.IOStream data stream. *)
PROCEDURE WriteIO*(context : POINTER TO VAR IOStream; buffer : ARRAY OF SYSTEM.BYTE; size : LENGTH): LENGTH;
BEGIN
	IF size < 0 THEN size := LEN(buffer) END;
	RETURN SDLWriteIO(context, SYSTEM.ADR(buffer[0]), size)
END WriteIO;

PROCEDURE WriteStr*(context : POINTER TO VAR IOStream; buffer- : ARRAY OF CHAR): LENGTH;
VAR size : LENGTH;
BEGIN
	size := strlen(PTR(buffer[0]));
	IF size <= 0 THEN RETURN 0 END;
	RETURN SDLWriteIO(context, SYSTEM.ADR(buffer[0]), size)
END WriteStr;

(* SDL_messagebox.h *)
PROCEDURE ^ SDLShowSimpleMessageBox ["SDL_ShowSimpleMessageBox"] (flags : Uint32; title, message: POINTER TO VAR- CHAR; window : POINTER TO VAR Window): BOOLEAN;
(** Open a URL/URI in the browser or other appropriate external application. *)
PROCEDURE ShowSimpleMessageBox*(flags : Uint32; title-, message-: ARRAY OF CHAR; window : POINTER TO VAR Window): BOOLEAN;
BEGIN RETURN SDLShowSimpleMessageBox(flags, PTR(title[0]), PTR(message[0]), window)
END ShowSimpleMessageBox;

(* SDL_misc.h *)
PROCEDURE ^ SDLOpenURL ["SDL_OpenURL"] (url: POINTER TO VAR- CHAR): BOOLEAN;
(** Open a URL/URI in the browser or other appropriate external application. *)
PROCEDURE OpenURL*(url-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLOpenURL(PTR(url[0]))
END OpenURL;

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

(* SDL_process.h *)
PROCEDURE ^ SDLCreateProcess ["SDL_CreateProcess"] (args : SYSTEM.ADDRESS; pipe_stdio : BOOLEAN): POINTER TO VAR Process;
(** Create a new process. *)
PROCEDURE CreateProcessEx*(path-: ARRAY OF CHAR; args-: ARRAY OF CHAR; pipe_stdio : BOOLEAN): POINTER TO VAR Process;
TYPE
	Args = RECORD-
		path : POINTER TO VAR- CHAR;
		args : POINTER TO VAR- CHAR;
		sentinel : POINTER TO VAR- CHAR;
	END;
VAR
	rec : Args;
BEGIN
	rec.path := PTR(path[0]);
	rec.args := NIL;
	IF strlen(PTR(args[0])) > 0 THEN
		rec.args := PTR(args[0])
	END;
	rec.sentinel := NIL;
	RETURN SDLCreateProcess(SYSTEM.ADR(rec), pipe_stdio)
END CreateProcessEx;

(** Create a new process. *)
PROCEDURE CreateProcess*(args- : ARRAY OF PCHAR ; pipe_stdio : BOOLEAN): POINTER TO VAR Process;
BEGIN
	RETURN SDLCreateProcess(SYSTEM.ADR(args), pipe_stdio)
END CreateProcess;

PROCEDURE ^ DestroyProcess* ["SDL_DestroyProcess"] (process : POINTER TO VAR Process);
PROCEDURE ^ GetProcessInput* ["SDL_GetProcessInput"] (process : POINTER TO VAR Process): PtrIOStream;
PROCEDURE ^ GetProcessOutput* ["SDL_GetProcessOutput"] (process : POINTER TO VAR Process): PtrIOStream;
PROCEDURE ^ KillProcess* ["SDL_KillProcess"] (process : POINTER TO VAR Process): BOOLEAN;
PROCEDURE ^ WaitProcess* ["SDL_WaitProcess"] (process : POINTER TO VAR Process; block : BOOLEAN; exitcode : POINTER TO VAR INTEGER): BOOLEAN;

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
PROCEDURE ^ SetRenderScale* ["SDL_SetRenderScale"] (renderer : POINTER TO VAR Renderer; scaleX: REAL32; scaleY: REAL32): BOOLEAN;
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
PROCEDURE ^ RenderPoint* ["SDL_RenderPoint"] (renderer : POINTER TO VAR Renderer; x, y: REAL32): BOOLEAN;
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
PROCEDURE ^ srand* ["SDL_srand"] (seed : Uint64);
PROCEDURE ^ rand* ["SDL_rand"] (n : Sint32): Sint32;
PROCEDURE ^ randf* ["SDL_randf"] (): REAL32;
PROCEDURE ^ acos* ["SDL_acos"] (x : REAL64): REAL64;
PROCEDURE ^ acosf* ["SDL_acosf"] (x : REAL32): REAL32;
PROCEDURE ^ asin* ["SDL_asin"] (x : REAL64): REAL64;
PROCEDURE ^ asinf* ["SDL_asinf"] (x : REAL32): REAL32;
PROCEDURE ^ atan* ["SDL_atan"] (x : REAL64): REAL64;
PROCEDURE ^ atanf* ["SDL_atanf"] (x : REAL32): REAL32;
PROCEDURE ^ atan2* ["SDL_atan2"] (x : REAL64; y: REAL64): REAL64;
PROCEDURE ^ atan2f* ["SDL_atan2f"] (x : REAL32; y: REAL32): REAL32;
PROCEDURE ^ ceil* ["SDL_ceil"] (x : REAL64): REAL64;
PROCEDURE ^ ceilf* ["SDL_ceilf"] (x : REAL32): REAL32;
PROCEDURE ^ copysign* ["SDL_copysign"] (x : REAL64; y: REAL64): REAL64;
PROCEDURE ^ copysignf* ["SDL_copysignf"] (x : REAL32; y: REAL32): REAL32;
PROCEDURE ^ cos* ["SDL_cos"] (x : REAL64): REAL64;
PROCEDURE ^ cosf* ["SDL_cosf"] (x : REAL32): REAL32;
PROCEDURE ^ exp* ["SDL_exp"] (x : REAL64): REAL64;
PROCEDURE ^ expf* ["SDL_expf"] (x : REAL32): REAL32;
PROCEDURE ^ fabs* ["SDL_fabs"] (x : REAL64): REAL64;
PROCEDURE ^ fabsf* ["SDL_fabsf"] (x : REAL32): REAL32;
PROCEDURE ^ floor* ["SDL_floor"] (x : REAL64): REAL64;
PROCEDURE ^ floorf* ["SDL_floorf"] (x : REAL32): REAL32;
PROCEDURE ^ trunc* ["SDL_trunc"] (x : REAL64): REAL64;
PROCEDURE ^ truncf* ["SDL_truncf"] (x : REAL32): REAL32;
PROCEDURE ^ fmod* ["SDL_fmod"] (x : REAL64; y: REAL64): REAL64;
PROCEDURE ^ fmodf* ["SDL_fmodf"] (x : REAL32; y: REAL32): REAL32;
PROCEDURE ^ isinf* ["SDL_isinf"] (x : REAL64): INTEGER;
PROCEDURE ^ isinff* ["SDL_isinff"] (x : REAL32): INTEGER;
PROCEDURE ^ isnan* ["SDL_isnan"] (x : REAL64): INTEGER;
PROCEDURE ^ isnanf* ["SDL_isnanf"] (x : REAL32): INTEGER;
PROCEDURE ^ log* ["SDL_log"] (x : REAL64): REAL64;
PROCEDURE ^ logf* ["SDL_logf"] (x : REAL32): REAL32;
PROCEDURE ^ log10* ["SDL_log10"] (x : REAL64): REAL64;
PROCEDURE ^ log10f* ["SDL_log10f"] (x : REAL32): REAL32;
PROCEDURE ^ pow* ["SDL_pow"] (x : REAL64; y: REAL64): REAL64;
PROCEDURE ^ powf* ["SDL_powf"] (x : REAL32; y: REAL32): REAL32;
PROCEDURE ^ round* ["SDL_round"] (x : REAL64): REAL64;
PROCEDURE ^ roundf* ["SDL_roundf"] (x : REAL32): REAL32;
PROCEDURE ^ sin* ["SDL_sin"] (x : REAL64): REAL64;
PROCEDURE ^ sinf* ["SDL_sinf"] (x : REAL32): REAL32;
PROCEDURE ^ sqrt* ["SDL_sqrt"] (x : REAL64): REAL64;
PROCEDURE ^ sqrtf* ["SDL_sqrtf"] (x : REAL32): REAL32;
PROCEDURE ^ tan* ["SDL_tan"] (x : REAL64): REAL64;
PROCEDURE ^ tanf* ["SDL_tanf"] (x : REAL32): REAL32;

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