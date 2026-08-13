MODULE SDL3 IN Ext;

IMPORT SYSTEM;

TYPE PCHAR* = POINTER TO VAR- CHAR;
TYPE STRING* = POINTER TO ARRAY OF CHAR;

TYPE Sint32* = SIGNED32;
TYPE Sint64* = SIGNED64;
TYPE Uint8* = UNSIGNED8;
TYPE Uint16* = UNSIGNED16;
TYPE Uint32* = UNSIGNED32;
TYPE Uint64* = UNSIGNED64;

(* SDL_event.h *)
TYPE Event* = RECORD-
	type-: Uint32;
	padding: ARRAY 128 OF CHAR;
END;

TYPE KeyboardEvent* = RECORD-
	type-: Uint32;
	reserved: Uint32;
	timestamp-: Uint64;
	windowID-: Uint32;
	which-: Uint32;
	scancode-: INTEGER;
	key-: Uint32;
	mod-: Uint16;
	raw-: Uint16;
	down-: BOOLEAN;
	repeat-: BOOLEAN;
END;
TYPE PtrKeyboardEvent* = POINTER TO VAR KeyboardEvent;

TYPE MouseButtonEvent* = RECORD-
	type-: Uint32;
	reserved: Uint32;
	timestamp-: Uint64;
	windowID-: Uint32;
	which-: Uint32;
	button-: Uint8;
	down-: BOOLEAN;
	clicks-: Uint8;
	padding: Uint8;
	x- : REAL32;
	y- : REAL32;
END;
TYPE PtrMouseButtonEvent* = POINTER TO VAR MouseButtonEvent;

TYPE MouseMotionEvent* = RECORD-
	type-: Uint32;
	reserved: Uint32;
	timestamp-: Uint64;
	windowID-: Uint32;
	which-: Uint32;
	state-: Uint32;
	x- : REAL32;
	y- : REAL32;
	xrel- : REAL32;
	yrel- : REAL32;
END;
TYPE PtrMouseMotionEvent* = POINTER TO VAR MouseMotionEvent;

TYPE MouseWheelEvent* = RECORD-
	type-: Uint32;
	reserved: Uint32;
	timestamp-: Uint64;
	windowID-: Uint32;
	which-: Uint32;
	x- : REAL32;
	y- : REAL32;
	direction-: INTEGER;
	mouse_x- : REAL32;
	mouse_y- : REAL32;
	integer_x-: Sint32;
	integer_y-: Sint32;
END;
TYPE PtrMouseWheelEvent* = POINTER TO VAR MouseWheelEvent;

TYPE TextInputEvent* = RECORD-
	type-: Uint32;
	reserved: Uint32;
	timestamp-: Uint64;
	windowID-: Uint32;
	text-: POINTER TO VAR- CHAR;
END;
TYPE PtrTextInputEvent* = POINTER TO VAR TextInputEvent;

TYPE TextEditingEvent* = RECORD-
	type-: Uint32;
	reserved: Uint32;
	timestamp-: Uint64;
	windowID-: Uint32;
	text-: POINTER TO VAR- CHAR;
	start-: Sint32;
	length-: Sint32;
END;
TYPE PtrTextEditingEvent* = POINTER TO VAR TextEditingEvent;

TYPE TextEditingCandidatesEvent* = RECORD-
	type-: Uint32;
	reserved: Uint32;
	timestamp-: Uint64;
	windowID-: Uint32;
	candidates-: SYSTEM.ADDRESS;
	num_candidates-: Sint32;
	selected_candidate-: Sint32;
	horizontal-: BOOLEAN;
	padding1: Uint8;
	padding2: Uint8;
	padding3: Uint8;
END;
TYPE PtrTextEditingCandidatesEvent* = POINTER TO VAR TextEditingCandidatesEvent;

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
    
(* SDL_time.h *)
TYPE DateTime* = RECORD-
    year- : INTEGER;       
    month- : INTEGER;      
    day- : INTEGER;        
    hour- : INTEGER;       
    minute- : INTEGER;     
    second- : INTEGER;     
    nanosecond- : INTEGER; 
    day_of_week- : INTEGER;
    utc_offset- : INTEGER; 
END;

(* SDL_timer.h *)
TYPE TimerCallback* = PROCEDURE(timerID : Uint32; interval : Uint32): Uint32;

(* SDL_event.h *)
CONST EVENT_FIRST*   = 0H;
CONST EVENT_QUIT*   = 100H;
CONST EVENT_TERMINATING* = 101H;
CONST EVENT_LOW_MEMORY* = 102H;
CONST EVENT_WILL_ENTER_BACKGROUND* = 103H;
CONST EVENT_DID_ENTER_BACKGROUND* = 104H;
CONST EVENT_WILL_ENTER_FOREGROUND* = 105H;
CONST EVENT_DID_ENTER_FOREGROUND* = 106H;
CONST EVENT_LOCALE_CHANGED* = 107H;
CONST EVENT_SYSTEM_THEME_CHANGED* = 108H;
CONST EVENT_DISPLAY_ORIENTATION* = 0151H;   
CONST EVENT_DISPLAY_ADDED* = 0152H;                 
CONST EVENT_DISPLAY_REMOVED* = 0153H;                
CONST EVENT_DISPLAY_MOVED* = 0154H;                 
CONST EVENT_DISPLAY_DESKTOP_MODE_CHANGED* = 0155H;  
CONST EVENT_DISPLAY_CURRENT_MODE_CHANGED* = 0156H;  
CONST EVENT_DISPLAY_CONTENT_SCALE_CHANGED* = 0157H; 
CONST EVENT_DISPLAY_USABLE_BOUNDS_CHANGED* = 0158H; 
CONST EVENT_DISPLAY_FIRST* = EVENT_DISPLAY_ORIENTATION;
CONST EVENT_DISPLAY_LAST* = EVENT_DISPLAY_USABLE_BOUNDS_CHANGED;
CONST EVENT_WINDOW_SHOWN* = 0202H;     
CONST EVENT_WINDOW_HIDDEN* = 0203H;           
CONST EVENT_WINDOW_EXPOSED* = 0204H;           
CONST EVENT_WINDOW_MOVED* = 0205H;             
CONST EVENT_WINDOW_RESIZED* = 0206H;          
CONST EVENT_WINDOW_PIXEL_SIZE_CHANGED* = 0207H;
CONST EVENT_WINDOW_METAL_VIEW_RESIZED* = 0208H;
CONST EVENT_WINDOW_MINIMIZED* = 0209H;        
CONST EVENT_WINDOW_MAXIMIZED* = 020AH;        
CONST EVENT_WINDOW_RESTORED* = 020BH;        
CONST EVENT_WINDOW_MOUSE_ENTER* = 020CH;     
CONST EVENT_WINDOW_MOUSE_LEAVE* = 020DH;       
CONST EVENT_WINDOW_FOCUS_GAINED* = 020EH;      
CONST EVENT_WINDOW_FOCUS_LOST* = 020FH;        
CONST EVENT_WINDOW_CLOSE_REQUESTED* = 0210H;  
CONST EVENT_WINDOW_HIT_TEST* = 0211H;         
CONST EVENT_WINDOW_ICCPROF_CHANGED* = 0212H;  
CONST EVENT_WINDOW_DISPLAY_CHANGED* = 0213H;  
CONST EVENT_WINDOW_DISPLAY_SCALE_CHANGED* = 0214H;
CONST EVENT_WINDOW_SAFE_AREA_CHANGED* = 0215H; 
CONST EVENT_WINDOW_OCCLUDED* = 0216H;       
CONST EVENT_WINDOW_ENTER_FULLSCREEN* = 0217H; 
CONST EVENT_WINDOW_LEAVE_FULLSCREEN* = 0218H;  
CONST EVENT_WINDOW_DESTROYED* = 0219H;      
CONST EVENT_WINDOW_HDR_STATE_CHANGED* = 021AH; 
CONST EVENT_WINDOW_FIRST* = EVENT_WINDOW_SHOWN;
CONST EVENT_WINDOW_LAST* = EVENT_WINDOW_HDR_STATE_CHANGED;
CONST EVENT_KEY_DOWN* = 0300H; 
CONST EVENT_KEY_UP* = 0301H;                 
CONST EVENT_TEXT_EDITING* = 0302H;           
CONST EVENT_TEXT_INPUT* = 0303H;             
CONST EVENT_KEYMAP_CHANGED* = 0304H;         
CONST EVENT_KEYBOARD_ADDED* = 0305H;         
CONST EVENT_KEYBOARD_REMOVED* = 0306H;        
CONST EVENT_TEXT_EDITING_CANDIDATES* = 0307H; 
CONST EVENT_SCREEN_KEYBOARD_SHOWN* = 0308H;   
CONST EVENT_SCREEN_KEYBOARD_HIDDEN* = 0309H; 
CONST EVENT_MOUSE_MOTION* = 0400H;
CONST EVENT_MOUSE_BUTTON_DOWN* = 0401H;       
CONST EVENT_MOUSE_BUTTON_UP* = 0402H;        
CONST EVENT_MOUSE_WHEEL* = 0403H;             
CONST EVENT_MOUSE_ADDED* = 0404H;             
CONST EVENT_MOUSE_REMOVED* = 0405H;          
CONST EVENT_JOYSTICK_AXIS_MOTION* = 0600H;
CONST EVENT_JOYSTICK_BALL_MOTION* = 0601H;          
CONST EVENT_JOYSTICK_HAT_MOTION* = 0602H;           
CONST EVENT_JOYSTICK_BUTTON_DOWN* = 0603H;         
CONST EVENT_JOYSTICK_BUTTON_UP* = 0604H;           
CONST EVENT_JOYSTICK_ADDED* = 0605H;                
CONST EVENT_JOYSTICK_REMOVED* = 0606H;             
CONST EVENT_JOYSTICK_BATTERY_UPDATED* = 0607H;     
CONST EVENT_JOYSTICK_UPDATE_COMPLETE* = 0608H;      
CONST EVENT_GAMEPAD_AXIS_MOTION* = 0650H; 
CONST EVENT_GAMEPAD_BUTTON_DOWN* = 0651H;          
CONST EVENT_GAMEPAD_BUTTON_UP* = 0652H;           
CONST EVENT_GAMEPAD_ADDED* = 0653H;               
CONST EVENT_GAMEPAD_REMOVED* = 0654H;              
CONST EVENT_GAMEPAD_REMAPPED* = 0655H;            
CONST EVENT_GAMEPAD_TOUCHPAD_DOWN* = 0656H;       
CONST EVENT_GAMEPAD_TOUCHPAD_MOTION* = 0657H;     
CONST EVENT_GAMEPAD_TOUCHPAD_UP* = 0658H;         
CONST EVENT_GAMEPAD_SENSOR_UPDATE* = 0659H;        
CONST EVENT_GAMEPAD_UPDATE_COMPLETE* = 065AH;      
CONST EVENT_GAMEPAD_STEAM_HANDLE_UPDATED* = 065BH; 
CONST EVENT_FINGER_DOWN* = 0701H;
CONST EVENT_FINGER_UP* = 0702H;
CONST EVENT_FINGER_MOTION* = 0703H;
CONST EVENT_FINGER_CANCELED* = 0704H;
CONST EVENT_PINCH_BEGIN* = 0710H;   
CONST EVENT_PINCH_UPDATE* = 0711H;                 
CONST EVENT_PINCH_END* = 0712H;                    
CONST EVENT_CLIPBOARD_UPDATE* = 0900H; 
CONST EVENT_DROP_FILE* = 01000H;
CONST EVENT_DROP_TEXT* = 01001H;               
CONST EVENT_DROP_BEGIN* = 01002H;              
CONST EVENT_DROP_COMPLETE* = 01003H;            
CONST EVENT_DROP_POSITION* = 01004H;            
CONST EVENT_AUDIO_DEVICE_ADDED* = 01100H;
CONST EVENT_AUDIO_DEVICE_REMOVED* = 01101H;      
CONST EVENT_AUDIO_DEVICE_FORMAT_CHANGED* = 01102H;
CONST EVENT_SENSOR_UPDATE* = 01200H;    
CONST EVENT_PEN_PROXIMITY_IN* = 01300H;
CONST EVENT_PEN_PROXIMITY_OUT* = 01301H;          
CONST EVENT_PEN_DOWN* = 01302H;                 
CONST EVENT_PEN_UP* = 01303H;                     
CONST EVENT_PEN_BUTTON_DOWN* = 01304H;            
CONST EVENT_PEN_BUTTON_UP* = 01305H;              
CONST EVENT_PEN_MOTION* = 01306H;                
CONST EVENT_PEN_AXIS* = 01307H;                  
CONST EVENT_CAMERA_DEVICE_ADDED* = 01400H; 
CONST EVENT_CAMERA_DEVICE_REMOVED* = 01401H;        
CONST EVENT_CAMERA_DEVICE_APPROVED* = 01402H;       
CONST EVENT_CAMERA_DEVICE_DENIED* = 01403H;          
CONST EVENT_RENDER_TARGETS_RESET* = 02000H;
CONST EVENT_RENDER_DEVICE_RESET* = 02001H;
CONST EVENT_RENDER_DEVICE_LOST* = 02002H; 
CONST EVENT_PRIVATE0* = 04000H;
CONST EVENT_PRIVATE1* = 04001H;
CONST EVENT_PRIVATE2* = 04002H;
CONST EVENT_PRIVATE3* = 04003H;
CONST EVENT_POLL_SENTINEL* = 07F00H; 
CONST EVENT_USER*    = 08000H;
CONST EVENT_LAST*    = 0FFFFH;
CONST EVENT_ENUM_PADDING* = 07FFFFFFFH;

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

(* SDL_hints.h *)
CONST HINT_IME_IMPLEMENTED_UI*    = "SDL_IME_IMPLEMENTED_UI";
    
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

(* SDL3/SDL_keycode.h *)
CONST K_EXTENDED_MASK*          = 020000000H;
CONST K_SCANCODE_MASK*          = 040000000H;
CONST K_UNKNOWN*                = 000000000H;
CONST K_RETURN*                 = 00000000DH;
CONST K_ESCAPE*                 = 00000001BH;
CONST K_BACKSPACE*              = 000000008H;
CONST K_TAB*                    = 000000009H;
CONST K_SPACE*                  = 000000020H;
CONST K_EXCLAIM *               = 000000021H;
CONST K_DBLAPOSTROPHE*          = 000000022H;
CONST K_HASH*                   = 000000023H;
CONST K_DOLLAR*                 = 000000024H;
CONST K_PERCENT*                = 000000025H;
CONST K_AMPERSAND*              = 000000026H;
CONST K_APOSTROPHE*             = 000000027H;
CONST K_LEFTPAREN*              = 000000028H;
CONST K_RIGHTPAREN*             = 000000029H;
CONST K_ASTERISK*               = 00000002AH;
CONST K_PLUS*                   = 00000002BH;
CONST K_COMMA*                  = 00000002CH;
CONST K_MINUS*                  = 00000002DH;
CONST K_PERIOD*                 = 00000002EH;
CONST K_SLASH*                  = 00000002FH;
CONST K_0*                      = 000000030H;
CONST K_1*                      = 000000031H;
CONST K_2*                      = 000000032H;
CONST K_3*                      = 000000033H;
CONST K_4*                      = 000000034H;
CONST K_5*                      = 000000035H;
CONST K_6*                      = 000000036H;
CONST K_7*                      = 000000037H;
CONST K_8*                      = 000000038H;
CONST K_9*                      = 000000039H;
CONST K_COLON*                  = 00000003AH;
CONST K_SEMICOLON*              = 00000003BH;
CONST K_LESS*                   = 00000003CH;
CONST K_EQUALS*                 = 00000003DH;
CONST K_GREATER*                = 00000003EH;
CONST K_QUESTION*               = 00000003FH;
CONST K_AT*                     = 000000040H;
CONST K_LEFTBRACKET*            = 00000005BH;
CONST K_BACKSLASH*              = 00000005CH;
CONST K_RIGHTBRACKET*           = 00000005DH;
CONST K_CARET*                  = 00000005EH;
CONST K_UNDERSCORE*             = 00000005FH;
CONST K_GRAVE*                  = 000000060H;
CONST K_A*                      = 000000061H;
CONST K_B*                      = 000000062H;
CONST K_C*                      = 000000063H;
CONST K_D*                      = 000000064H;
CONST K_E*                      = 000000065H;
CONST K_F*                      = 000000066H;
CONST K_G*                      = 000000067H;
CONST K_H*                      = 000000068H;
CONST K_I*                      = 000000069H;
CONST K_J*                      = 00000006AH;
CONST K_K*                      = 00000006BH;
CONST K_L*                      = 00000006CH;
CONST K_M*                      = 00000006DH;
CONST K_N*                      = 00000006EH;
CONST K_O*                      = 00000006FH;
CONST K_P*                      = 000000070H;
CONST K_Q*                      = 000000071H;
CONST K_R*                      = 000000072H;
CONST K_S*                      = 000000073H;
CONST K_T*                      = 000000074H;
CONST K_U*                      = 000000075H;
CONST K_V*                      = 000000076H;
CONST K_W*                      = 000000077H;
CONST K_X*                      = 000000078H;
CONST K_Y*                      = 000000079H;
CONST K_Z*                      = 00000007AH;
CONST K_LEFTBRACE*              = 00000007BH;
CONST K_PIPE*                   = 00000007CH;
CONST K_RIGHTBRACE*             = 00000007DH;
CONST K_TILDE*                  = 00000007EH;
CONST K_DELETE*                 = 00000007FH;
CONST K_PLUSMINUS*              = 0000000B1H;
CONST K_CAPSLOCK*               = 040000039H;
CONST K_F1*                     = 04000003AH;
CONST K_F2*                     = 04000003BH;
CONST K_F3*                     = 04000003CH;
CONST K_F4*                     = 04000003DH;
CONST K_F5*                     = 04000003EH;
CONST K_F6*                     = 04000003FH;
CONST K_F7*                     = 040000040H;
CONST K_F8*                     = 040000041H;
CONST K_F9*                     = 040000042H;
CONST K_F10*                    = 040000043H;
CONST K_F11*                    = 040000044H;
CONST K_F12*                    = 040000045H;
CONST K_PRINTSCREEN*            = 040000046H;
CONST K_SCROLLLOCK*             = 040000047H;
CONST K_PAUSE*                  = 040000048H;
CONST K_INSERT*                 = 040000049H;
CONST K_HOME*                   = 04000004AH;
CONST K_PAGEUP*                 = 04000004BH;
CONST K_END*                    = 04000004DH;
CONST K_PAGEDOWN*               = 04000004EH;
CONST K_RIGHT*                  = 04000004FH;
CONST K_LEFT*                   = 040000050H;
CONST K_DOWN*                   = 040000051H;
CONST K_UP*                     = 040000052H;
CONST K_NUMLOCKCLEAR*           = 040000053H;
CONST K_KP_DIVIDE*              = 040000054H;
CONST K_KP_MULTIPLY*            = 040000055H;
CONST K_KP_MINUS*               = 040000056H;
CONST K_KP_PLUS*                = 040000057H;
CONST K_KP_ENTER*               = 040000058H;
CONST K_KP_1*                   = 040000059H;
CONST K_KP_2*                   = 04000005AH;
CONST K_KP_3*                   = 04000005BH;
CONST K_KP_4*                   = 04000005CH;
CONST K_KP_5*                   = 04000005DH;
CONST K_KP_6*                   = 04000005EH;
CONST K_KP_7*                   = 04000005FH;
CONST K_KP_8*                   = 040000060H;
CONST K_KP_9*                   = 040000061H;
CONST K_KP_0*                   = 040000062H;
CONST K_KP_PERIOD*              = 040000063H;
CONST K_APPLICATION*            = 040000065H;
CONST K_POWER*                  = 040000066H;
CONST K_KP_EQUALS*              = 040000067H;
CONST K_F13*                    = 040000068H;
CONST K_F14*                    = 040000069H;
CONST K_F15*                    = 04000006AH;
CONST K_F16*                    = 04000006BH;
CONST K_F17*                    = 04000006CH;
CONST K_F18*                    = 04000006DH;
CONST K_F19*                    = 04000006EH;
CONST K_F20*                    = 04000006FH;
CONST K_F21*                    = 040000070H;
CONST K_F22*                    = 040000071H;
CONST K_F23*                    = 040000072H;
CONST K_F24*                    = 040000073H;
CONST K_EXECUTE*                = 040000074H;
CONST K_HELP*                   = 040000075H;
CONST K_MENU*                   = 040000076H;
CONST K_SELECT*                 = 040000077H;
CONST K_STOP*                   = 040000078H;
CONST K_AGAIN*                  = 040000079H;
CONST K_UNDO*                   = 04000007AH;
CONST K_CUT*                    = 04000007BH;
CONST K_COPY*                   = 04000007CH;
CONST K_PASTE*                  = 04000007DH;
CONST K_FIND*                   = 04000007EH;
CONST K_MUTE*                   = 04000007FH;
CONST K_VOLUMEUP*               = 040000080H;
CONST K_VOLUMEDOWN*             = 040000081H;
CONST K_KP_COMMA*               = 040000085H;
CONST K_KP_EQUALSAS400*         = 040000086H;
CONST K_ALTERASE*               = 040000099H;
CONST K_SYSREQ*                 = 04000009AH;
CONST K_CANCEL*                 = 04000009BH;
CONST K_CLEAR*                  = 04000009CH;
CONST K_PRIOR*                  = 04000009DH;
CONST K_RETURN2*                = 04000009EH;
CONST K_SEPARATOR*              = 04000009FH;
CONST K_OUT*                    = 0400000A0H;
CONST K_OPER*                   = 0400000A1H;
CONST K_CLEARAGAIN*             = 0400000A2H;
CONST K_CRSEL*                  = 0400000A3H;
CONST K_EXSEL*                  = 0400000A4H;
CONST K_KP_00*                  = 0400000B0H;
CONST K_KP_000*                 = 0400000B1H;
CONST K_THOUSANDSSEPARATOR*     = 0400000B2H;
CONST K_DECIMALSEPARATOR*       = 0400000B3H;
CONST K_CURRENCYUNIT*           = 0400000B4H;
CONST K_CURRENCYSUBUNIT*        = 0400000B5H;
CONST K_KP_LEFTPAREN*           = 0400000B6H;
CONST K_KP_RIGHTPAREN*          = 0400000B7H;
CONST K_KP_LEFTBRACE*           = 0400000B8H;
CONST K_KP_RIGHTBRACE*          = 0400000B9H;
CONST K_KP_TAB*                 = 0400000BAH;
CONST K_KP_BACKSPACE*           = 0400000BBH;
CONST K_KP_A*                   = 0400000BCH;
CONST K_KP_B*                   = 0400000BDH;
CONST K_KP_C*                   = 0400000BEH;
CONST K_KP_D*                   = 0400000BFH;
CONST K_KP_E*                   = 0400000C0H;
CONST K_KP_F*                   = 0400000C1H;
CONST K_KP_XOR*                 = 0400000C2H;
CONST K_KP_POWER*               = 0400000C3H;
CONST K_KP_PERCENT*             = 0400000C4H;
CONST K_KP_LESS*                = 0400000C5H;
CONST K_KP_GREATER*             = 0400000C6H;
CONST K_KP_AMPERSAND*           = 0400000C7H;
CONST K_KP_DBLAMPERSAND*        = 0400000C8H;
CONST K_KP_VERTICALBAR*         = 0400000C9H;
CONST K_KP_DBLVERTICALBAR*      = 0400000CAH;
CONST K_KP_COLON*               = 0400000CBH;
CONST K_KP_HASH*                = 0400000CCH;
CONST K_KP_SPACE*               = 0400000CDH;
CONST K_KP_AT*                  = 0400000CEH;
CONST K_KP_EXCLAM*              = 0400000CFH;
CONST K_KP_MEMSTORE*            = 0400000D0H;
CONST K_KP_MEMRECALL*           = 0400000D1H;
CONST K_KP_MEMCLEAR*            = 0400000D2H;
CONST K_KP_MEMADD*              = 0400000D3H;
CONST K_KP_MEMSUBTRACT*         = 0400000D4H;
CONST K_KP_MEMMULTIPLY*         = 0400000D5H;
CONST K_KP_MEMDIVIDE*           = 0400000D6H;
CONST K_KP_PLUSMINUS*           = 0400000D7H;
CONST K_KP_CLEAR*               = 0400000D8H;
CONST K_KP_CLEARENTRY*          = 0400000D9H;
CONST K_KP_BINARY*              = 0400000DAH;
CONST K_KP_OCTAL*               = 0400000DBH;
CONST K_KP_DECIMAL*             = 0400000DCH;
CONST K_KP_HEXADECIMAL*         = 0400000DDH;
CONST K_LCTRL*                  = 0400000E0H;
CONST K_LSHIFT*                 = 0400000E1H;
CONST K_LALT*                   = 0400000E2H;
CONST K_LGUI*                   = 0400000E3H;
CONST K_RCTRL*                  = 0400000E4H;
CONST K_RSHIFT*                 = 0400000E5H;
CONST K_RALT*                   = 0400000E6H;
CONST K_RGUI*                   = 0400000E7H;
CONST K_MODE*                   = 040000101H;
CONST K_SLEEP*                  = 040000102H;
CONST K_WAKE*                   = 040000103H;
CONST K_CHANNEL_INCREMENT*      = 040000104H;
CONST K_CHANNEL_DECREMENT*      = 040000105H;
CONST K_MEDIA_PLAY*             = 040000106H;
CONST K_MEDIA_PAUSE*            = 040000107H;
CONST K_MEDIA_RECORD*           = 040000108H;
CONST K_MEDIA_FAST_FORWARD*     = 040000109H;
CONST K_MEDIA_REWIND*           = 04000010AH;
CONST K_MEDIA_NEXT_TRACK*       = 04000010BH;
CONST K_MEDIA_PREVIOUS_TRACK*   = 04000010CH;
CONST K_MEDIA_STOP*             = 04000010DH;
CONST K_MEDIA_EJECT*            = 04000010EH;
CONST K_MEDIA_PLAY_PAUSE*       = 04000010FH;
CONST K_MEDIA_SELECT*           = 040000110H;
CONST K_AC_NEW*                 = 040000111H;
CONST K_AC_OPEN*                = 040000112H;
CONST K_AC_CLOSE*               = 040000113H;
CONST K_AC_EXIT*                = 040000114H;
CONST K_AC_SAVE*                = 040000115H;
CONST K_AC_PRINT*               = 040000116H;
CONST K_AC_PROPERTIES*          = 040000117H;
CONST K_AC_SEARCH*              = 040000118H;
CONST K_AC_HOME*                = 040000119H;
CONST K_AC_BACK*                = 04000011AH;
CONST K_AC_FORWARD*             = 04000011BH;
CONST K_AC_STOP*                = 04000011CH;
CONST K_AC_REFRESH*             = 04000011DH;
CONST K_AC_BOOKMARKS*           = 04000011EH;
CONST K_SOFTLEFT*               = 04000011FH;
CONST K_SOFTRIGHT*              = 040000120H;
CONST K_CALL*                   = 040000121H;
CONST K_ENDCALL*                = 040000122H;
CONST K_LEFT_TAB*               = 020000001H;
CONST K_LEVEL5_SHIFT*           = 020000002H;
CONST K_MULTI_KEY_COMPOSE*      = 020000003H;
CONST K_LMETA*                  = 020000004H;
CONST K_RMETA*                  = 020000005H;
CONST K_LHYPER*                 = 020000006H;
CONST K_RHYPER*                 = 020000007H;

CONST KMOD_NONE*   = 0000H;
CONST KMOD_LSHIFT* = 0001H;
CONST KMOD_RSHIFT* = 0002H;
CONST KMOD_LEVEL5* = 0004H;
CONST KMOD_LCTRL*  = 0040H;
CONST KMOD_RCTRL*  = 0080H;
CONST KMOD_LALT*   = 0100H;
CONST KMOD_RALT*   = 0200H;
CONST KMOD_LGUI*   = 0400H;
CONST KMOD_RGUI*   = 0800H;
CONST KMOD_NUM*    = 1000H;
CONST KMOD_CAPS*   = 2000H;
CONST KMOD_MODE*   = 4000H;
CONST KMOD_SCROLL* = 8000H;
CONST KMOD_CTRL*   = KMOD_LCTRL + KMOD_RCTRL;
CONST KMOD_SHIFT*  = KMOD_LSHIFT + KMOD_RSHIFT;
CONST KMOD_ALT*    = KMOD_LALT + KMOD_RALT;   
CONST KMOD_GUI*    = KMOD_LGUI + KMOD_RGUI;   

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

(* SDL_properties.h *)
CONST PROPERTY_TYPE_INVALID*    = 0;
CONST PROPERTY_TYPE_POINTER*    = 1;
CONST PROPERTY_TYPE_STRING*     = 2;
CONST PROPERTY_TYPE_NUMBER*     = 3;
CONST PROPERTY_TYPE_FLOAT*      = 4;
CONST PROPERTY_TYPE_BOOLEAN*    = 5;
 
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

(* SDL_time.h *)
CONST DATE_FORMAT_YYYYMMDD* = 0;
CONST DATE_FORMAT_DDMMYYYY* = 1;
CONST DATE_FORMAT_MMDDYYYY* = 2;
CONST TIME_FORMAT_24HR* = 0;
CONST TIME_FORMAT_12HR* = 1;

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

(* SDL_timer.h *)
VAR ^ TimerCallbackWrapper ["_system_callback_iii"]: SYSTEM.BYTE;
    
(* SDL_stdinc.h *)
PROCEDURE ^ malloc* ["SDL_malloc"] (size : LENGTH): SYSTEM.ADDRESS;
PROCEDURE ^ free* ["SDL_free"] (mem : SYSTEM.ADDRESS);
PROCEDURE ^ memcpy* ["SDL_memcpy"] (dst : SYSTEM.ADDRESS; src : SYSTEM.ADDRESS; len : Uint64): SYSTEM.ADDRESS;
PROCEDURE ^ memset* ["SDL_memset"] (dst : SYSTEM.ADDRESS; c : INTEGER;  len : Uint64): SYSTEM.ADDRESS;
PROCEDURE ^ strlen* ["SDL_strlen"] (str : SYSTEM.ADDRESS): LENGTH;

(*  SDL_clipboard.h *)
PROCEDURE ^ SDLGetClipboardText ["SDL_GetClipboardText"] (): PCHAR;
PROCEDURE GetClipboardText*(VAR text : STRING): BOOLEAN;
VAR
    x : PCHAR;
    len : LENGTH;
BEGIN
    x := SDLGetClipboardText();
    len := 0;
    IF x # NIL THEN len := strlen(SYSTEM.VAL(SYSTEM.ADDRESS, x)) END;
    IF (x = NIL) OR (len = 0) THEN RETURN FALSE END;
    IF text = NIL THEN 
        NEW(text, len + 1)
    ELSIF LEN(text^) < (len + 1) THEN
        DISPOSE(text);
        NEW(text, len + 1)
    END;
    IGNORE(memcpy(SYSTEM.ADR(text^[0]), SYSTEM.VAL(SYSTEM.ADDRESS, x), len + 1));
    free(SYSTEM.VAL(SYSTEM.ADDRESS, x));
    RETURN TRUE
END GetClipboardText;

PROCEDURE ^ HasClipboardText* ["SDL_HasClipboardText"] (): BOOLEAN;
PROCEDURE ^ SetClipboardText* ["SDL_SetClipboardText"] (text: PCHAR): BOOLEAN;

(* SDL_filesystem.h *)
PROCEDURE ^ SDLCopyFile ["SDL_CopyFile"] (oldpath: PCHAR; newpath : PCHAR): BOOLEAN;
PROCEDURE CopyFile*(oldpath-: ARRAY OF CHAR; newpath-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLCopyFile(PTR(oldpath[0]), PTR(newpath[0]))
END CopyFile;

PROCEDURE ^ SDLCreateDirectory ["SDL_CreateDirectory"] (path: PCHAR): BOOLEAN;
PROCEDURE CreateDirectory*(path-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLCreateDirectory(PTR(path[0]))
END CreateDirectory;

PROCEDURE ^ SDLGetBasePath ["SDL_GetBasePath"] (): PCHAR;
PROCEDURE GetBasePath*(VAR path : STRING): BOOLEAN;
VAR
    x : PCHAR;
    len : LENGTH;
BEGIN
    x := SDLGetBasePath();
    len := 0;
    IF x # NIL THEN len := strlen(SYSTEM.VAL(SYSTEM.ADDRESS, x)) END;
    IF (x = NIL) OR (len = 0) THEN RETURN FALSE END;
    IF path = NIL THEN 
        NEW(path, len + 1)
    ELSIF LEN(path^) < (len + 1) THEN
        DISPOSE(path);
        NEW(path, len + 1)
    END;
    IGNORE(memcpy(SYSTEM.ADR(path^[0]), SYSTEM.VAL(SYSTEM.ADDRESS, x), len + 1));
    RETURN TRUE
END GetBasePath;


PROCEDURE ^ SDLGetCurrentDirectory ["SDL_GetCurrentDirectory"] (): PCHAR;
PROCEDURE GetCurrentDirectory*(VAR path : STRING): BOOLEAN;
VAR
    x : PCHAR;
    len : LENGTH;
BEGIN
    x := SDLGetCurrentDirectory();
    len := 0;
    IF x # NIL THEN len := strlen(SYSTEM.VAL(SYSTEM.ADDRESS, x)) END;
    IF (x = NIL) OR (len = 0) THEN RETURN FALSE END;
    IF path = NIL THEN 
        NEW(path, len + 1)
    ELSIF LEN(path^) < (len + 1) THEN
        DISPOSE(path);
        NEW(path, len + 1)
    END;
    IGNORE(memcpy(SYSTEM.ADR(path^[0]), SYSTEM.VAL(SYSTEM.ADDRESS, x), len + 1));
    RETURN TRUE
END GetCurrentDirectory;

PROCEDURE ^ SDLGetPathInfo ["SDL_GetPathInfo"] (path: PCHAR; info : POINTER TO VAR- PathInfo): BOOLEAN;
PROCEDURE GetPathInfo*(path-: ARRAY OF CHAR; VAR info : PathInfo): BOOLEAN;
BEGIN RETURN SDLGetPathInfo(PTR(path[0]), PTR(info))
END GetPathInfo;

PROCEDURE ^ SDLGetPrefPath ["SDL_GetPrefPath"] (org: PCHAR; app : PCHAR): PCHAR;
PROCEDURE GetPrefPath*(VAR path : STRING; org-: ARRAY OF CHAR; app-: ARRAY OF CHAR): BOOLEAN;
VAR
    x : PCHAR;
    len : LENGTH;
BEGIN
    x := SDLGetPrefPath(PTR(org[0]), PTR(app[0]));
    len := 0;
    IF x # NIL THEN len := strlen(SYSTEM.VAL(SYSTEM.ADDRESS, x)) END;
    IF (x = NIL) OR (len = 0) THEN RETURN FALSE END;
    IF path = NIL THEN 
        NEW(path, len + 1)
    ELSIF LEN(path^) < (len + 1) THEN
        DISPOSE(path);
        NEW(path, len + 1)
    END;
    IGNORE(memcpy(SYSTEM.ADR(path^[0]), SYSTEM.VAL(SYSTEM.ADDRESS, x), len + 1));
    RETURN TRUE
END GetPrefPath;


PROCEDURE ^ SDLGetUserFolder ["SDL_GetUserFolder"] (folder : INTEGER): PCHAR;
PROCEDURE GetUserFolder*(VAR path : STRING; folder : INTEGER): BOOLEAN;
VAR
    x : PCHAR;
    len : LENGTH;
BEGIN
    x := SDLGetUserFolder(folder);
    len := 0;
    IF x # NIL THEN len := strlen(SYSTEM.VAL(SYSTEM.ADDRESS, x)) END;
    IF (x = NIL) OR (len = 0) THEN RETURN FALSE END;
    IF path = NIL THEN 
        NEW(path, len + 1)
    ELSIF LEN(path^) < (len + 1) THEN
        DISPOSE(path);
        NEW(path, len + 1)
    END;
    IGNORE(memcpy(SYSTEM.ADR(path^[0]), SYSTEM.VAL(SYSTEM.ADDRESS, x), len + 1));
    RETURN TRUE
END GetUserFolder;

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
PROCEDURE ^ SDLPollEvent* ["SDL_PollEvent"] (event : POINTER TO VAR Event): BOOLEAN;
PROCEDURE PollEvent* (VAR event : Event): BOOLEAN;
BEGIN RETURN SDLPollEvent(PTR(event));
END PollEvent;

PROCEDURE EventAsKeyboardEvent* (event- : Event): PtrKeyboardEvent;
BEGIN RETURN SYSTEM.VAL(PtrKeyboardEvent, PTR(event));
END EventAsKeyboardEvent;

PROCEDURE EventAsMouseButtonEvent* (event- : Event): PtrMouseButtonEvent;
BEGIN RETURN SYSTEM.VAL(PtrMouseButtonEvent, PTR(event));
END EventAsMouseButtonEvent;

PROCEDURE EventAsMouseMotionEvent* (event- : Event): PtrMouseMotionEvent;
BEGIN RETURN SYSTEM.VAL(PtrMouseMotionEvent, PTR(event));
END EventAsMouseMotionEvent;

PROCEDURE EventAsMouseWheelEvent* (event- : Event): PtrMouseWheelEvent;
BEGIN RETURN SYSTEM.VAL(PtrMouseWheelEvent, PTR(event));
END EventAsMouseWheelEvent;

PROCEDURE EventAsTextInputEvent* (event- : Event): PtrTextInputEvent;
BEGIN RETURN SYSTEM.VAL(PtrTextInputEvent, PTR(event));
END EventAsTextInputEvent;

PROCEDURE EventAsTextEditingEvent* (event- : Event): PtrTextEditingEvent;
BEGIN RETURN SYSTEM.VAL(PtrTextEditingEvent, PTR(event));
END EventAsTextEditingEvent;

PROCEDURE EventAsTextEditingCandidatesEvent* (event- : Event): PtrTextEditingCandidatesEvent;
BEGIN RETURN SYSTEM.VAL(PtrTextEditingCandidatesEvent, PTR(event));
END EventAsTextEditingCandidatesEvent;

(* SDL_hints.h *)
PROCEDURE ^ SDLSetHint ["SDL_SetHint"] (name: POINTER TO VAR- CHAR; value: POINTER TO VAR- CHAR): BOOLEAN;
PROCEDURE SetHint *(name-: ARRAY OF CHAR; value-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLSetHint (PTR(name[0]), PTR(value[0]))
END SetHint ;

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
	size := strlen(SYSTEM.ADR(buffer[0]));
	IF size <= 0 THEN RETURN 0 END;
	RETURN SDLWriteIO(context, SYSTEM.ADR(buffer[0]), size)
END WriteStr;

(* SDL_keyboard.h *)
PROCEDURE ^ StartTextInput* ["SDL_StartTextInput"] (window : POINTER TO VAR Window): BOOLEAN;
PROCEDURE ^ StopTextInput* ["SDL_StopTextInput"] (window : POINTER TO VAR Window): BOOLEAN;
PROCEDURE ^ ClearComposition* ["SDL_ClearComposition"] (window : POINTER TO VAR Window): BOOLEAN;

PROCEDURE ^ SDLSetTextInputArea ["SDL_SetTextInputArea"] (window : POINTER TO VAR Window; rect : POINTER TO VAR- Rect; cursor: INTEGER): BOOLEAN;
PROCEDURE SetTextInputArea*(window : POINTER TO VAR Window; rect- : Rect; cursor: INTEGER): BOOLEAN;
BEGIN RETURN SDLSetTextInputArea(window, PTR(rect), cursor)
END SetTextInputArea;

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
	IF strlen(SYSTEM.ADR(args[0])) > 0 THEN
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

(* DL_properties.h *)
PROCEDURE ^ CreateProperties* ["SDL_CreateProperties"] (): Uint32;
PROCEDURE ^ DestroyProperties* ["SDL_DestroyProperties"] (props : Uint32);

PROCEDURE ^ SDLGetBooleanProperty ["SDL_GetBooleanProperty"] (props : Uint32; name: POINTER TO VAR- CHAR; default_value: BOOLEAN): BOOLEAN;
PROCEDURE GetBooleanProperty*(props : Uint32; name-: ARRAY OF CHAR; default_value: BOOLEAN): BOOLEAN;
BEGIN RETURN SDLGetBooleanProperty(props, PTR(name[0]), default_value)
END GetBooleanProperty;

PROCEDURE ^ SDLGetFloatProperty ["SDL_GetFloatProperty"] (props : Uint32; name: POINTER TO VAR- CHAR; default_value: REAL32): REAL32;
PROCEDURE GetFloatProperty*(props : Uint32; name-: ARRAY OF CHAR; default_value: REAL32): REAL32;
BEGIN RETURN SDLGetFloatProperty(props, PTR(name[0]), default_value)
END GetFloatProperty;

PROCEDURE ^ GetGlobalProperties* ["SDL_GetGlobalProperties"] (): Uint32;

PROCEDURE ^ SDLGetNumberProperty ["SDL_GetNumberProperty"] (props : Uint32; name: POINTER TO VAR- CHAR; default_value: Sint64): Sint64;
PROCEDURE GetNumberProperty*(props : Uint32; name-: ARRAY OF CHAR; default_value: Sint64): Sint64;
BEGIN RETURN SDLGetNumberProperty(props, PTR(name[0]), default_value)
END GetNumberProperty;

PROCEDURE ^ SDLGetPropertyType ["SDL_GetPropertyType"] (props : Uint32; name: POINTER TO VAR- CHAR): INTEGER;
PROCEDURE GetPropertyType*(props : Uint32; name-: ARRAY OF CHAR): INTEGER;
BEGIN RETURN SDLGetPropertyType(props, PTR(name[0]))
END GetPropertyType;

PROCEDURE ^ SDLHasProperty ["SDL_HasProperty"] (props : Uint32; name: POINTER TO VAR- CHAR): BOOLEAN;
PROCEDURE HasProperty*(props : Uint32; name-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLHasProperty(props, PTR(name[0]))
END HasProperty;

PROCEDURE ^ SDLSetBooleanProperty ["SDL_SetBooleanProperty"] (props : Uint32; name: POINTER TO VAR- CHAR; value: BOOLEAN): BOOLEAN;
PROCEDURE SetBooleanProperty*(props : Uint32; name-: ARRAY OF CHAR; value: BOOLEAN): BOOLEAN;
BEGIN RETURN SDLSetBooleanProperty(props, PTR(name[0]), value)
END SetBooleanProperty;

PROCEDURE ^ SDLSetFloatProperty ["SDL_SetFloatProperty"] (props : Uint32; name: POINTER TO VAR- CHAR; value: REAL32): BOOLEAN;
PROCEDURE SetFloatProperty*(props : Uint32; name-: ARRAY OF CHAR; value: REAL32): BOOLEAN;
BEGIN RETURN SDLSetFloatProperty(props, PTR(name[0]), value)
END SetFloatProperty;

PROCEDURE ^ SDLSetNumberProperty ["SDL_SetNumberProperty"] (props : Uint32; name: POINTER TO VAR- CHAR; value: Sint64): BOOLEAN;
PROCEDURE SetNumberProperty*(props : Uint32; name-: ARRAY OF CHAR; value: Sint64): BOOLEAN;
BEGIN RETURN SDLSetNumberProperty(props, PTR(name[0]), value)
END SetNumberProperty;

PROCEDURE ^ SDLSetStringProperty ["SDL_SetStringProperty"] (props : Uint32; name: POINTER TO VAR- CHAR; value: POINTER TO VAR- CHAR): BOOLEAN;
PROCEDURE SetStringProperty*(props : Uint32; name-: ARRAY OF CHAR; value-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLSetStringProperty(props, PTR(name[0]), PTR(value[0]))
END SetStringProperty;

(* SDL_rect.h *)
PROCEDURE RectToFRect* (rect- : Rect; VAR frect : FRect);
BEGIN
    frect.x := rect.x;
    frect.y := rect.y;
    frect.w := rect.w;
    frect.h := rect.h;
END RectToFRect;

PROCEDURE PointInRectFloat* (p- : FPoint; r- : FRect): BOOLEAN;
BEGIN
    IF ((p.x >= r.x) & (p.x <= (r.x + r.w))) &
       (p.y >= r.y) & (p.y <= (r.y + r.h)) THEN
       RETURN TRUE
    END;
    RETURN FALSE
END PointInRectFloat;

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

PROCEDURE ^ SDLGetTextureSize ["SDL_GetTextureSize"] (texture : POINTER TO VAR Texture; w, h: POINTER TO VAR REAL32): BOOLEAN;
PROCEDURE GetTextureSize*(texture : POINTER TO VAR Texture; VAR w, h: REAL32): BOOLEAN;
BEGIN RETURN SDLGetTextureSize(texture, PTR(w), PTR(h))
END GetTextureSize;

(*
PROCEDURE ^ SetTextureColorModFloat* ["SDL_SetTextureColorModFloat_wrap"] (texture : POINTER TO VAR Texture; r : REAL32; g : REAL32; b : REAL32): BOOLEAN;
*)
PROCEDURE ^ UnlockTexture* ["SDL_UnlockTexture"] (texture : POINTER TO VAR Texture);
PROCEDURE ^ DestroyTexture* ["SDL_DestroyTexture"] (texture : POINTER TO VAR Texture);
PROCEDURE ^ SetRenderLogicalPresentation* ["SDL_SetRenderLogicalPresentation"] (renderer : POINTER TO VAR Renderer; w, h : INTEGER; mode: INTEGER): BOOLEAN;
PROCEDURE ^ ConvertEventToRenderCoordinates* ["SDL_ConvertEventToRenderCoordinates"] (renderer : POINTER TO VAR Renderer;  event: POINTER TO VAR Event): BOOLEAN;

(*
PROCEDURE ^ SDLRenderCoordinatesToWindow ["SDL_RenderCoordinatesToWindow_wrap"] (renderer : POINTER TO VAR Renderer; x : REAL32; y : REAL32; window_x : POINTER TO VAR REAL32; window_y : POINTER TO VAR REAL32): BOOLEAN;
PROCEDURE RenderCoordinatesToWindow*(renderer : POINTER TO VAR Renderer; x : REAL32; y : REAL32; VAR window_x : REAL32; VAR window_y : REAL32): BOOLEAN;
BEGIN RETURN SDLRenderCoordinatesToWindow(renderer, x, y, PTR(window_x), PTR(window_y))
END RenderCoordinatesToWindow;
*)

PROCEDURE ^ SDLGetRenderOutputSize ["SDL_GetRenderOutputSize"] (renderer : POINTER TO VAR Renderer; w, h: POINTER TO VAR INTEGER): BOOLEAN;
PROCEDURE GetRenderOutputSize*(renderer : POINTER TO VAR Renderer; VAR w, h: INTEGER): BOOLEAN;
BEGIN RETURN SDLGetRenderOutputSize(renderer, PTR(w), PTR(h))
END GetRenderOutputSize;

PROCEDURE ^ SDLGetRenderSafeArea ["SDL_GetRenderSafeArea"] (renderer : POINTER TO VAR Renderer; rect: POINTER TO VAR Rect): BOOLEAN;
PROCEDURE GetRenderSafeArea*(renderer : POINTER TO VAR Renderer; VAR rect : Rect): BOOLEAN;
BEGIN RETURN SDLGetRenderSafeArea(renderer, PTR(rect))
END GetRenderSafeArea;

PROCEDURE ^ SetRenderViewport* ["SDL_SetRenderViewport"] (renderer : POINTER TO VAR Renderer; rect : POINTER TO VAR Rect): BOOLEAN;
PROCEDURE ^ SetRenderClipRect* ["SDL_SetRenderClipRect"] (renderer : POINTER TO VAR Renderer; rect : POINTER TO VAR Rect): BOOLEAN;
(*
PROCEDURE ^ SetRenderScale* ["SDL_SetRenderScale"] (renderer : POINTER TO VAR Renderer; scaleX: REAL32; scaleY: REAL32): BOOLEAN;
*)
PROCEDURE ^ SDLSetRenderDrawColor* ["SDL_SetRenderDrawColor"] (renderer : POINTER TO VAR Renderer; r, g, b, a: Uint8): BOOLEAN;
(* Set the color used for drawing operations. *)
PROCEDURE SetRenderDrawColor*(renderer : POINTER TO VAR Renderer; r, g, b, a: INTEGER): BOOLEAN;
BEGIN RETURN SDLSetRenderDrawColor(renderer, Uint8(r), Uint8(g), Uint8(b), Uint8(a))
END SetRenderDrawColor;
(*
PROCEDURE ^ SetRenderDrawColorFloat* ["SDL_SetRenderDrawColorFloat_wrap"] (renderer : POINTER TO VAR Renderer; r, g, b, a: REAL32): BOOLEAN;
*)
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
(*
PROCEDURE ^ RenderLine* ["SDL_RenderLine_wrap"] (renderer : POINTER TO VAR Renderer; x1, y1, x2, y2 : REAL32): BOOLEAN;
PROCEDURE ^ RenderPoint* ["SDL_RenderPoint"] (renderer : POINTER TO VAR Renderer; x, y: REAL32): BOOLEAN;
*)
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
(*
PROCEDURE ^ RenderTextureRotated* ["SDL_RenderTextureRotated_wrap"] (renderer : POINTER TO VAR Renderer; texture : POINTER TO VAR Texture; srcrect : POINTER TO VAR FRect;
                                                                     dstrect : POINTER TO VAR FRect; angle : REAL64; center : POINTER TO VAR FPoint; flip : INTEGER): BOOLEAN;
*)
PROCEDURE ^ RenderGeometry* ["SDL_RenderGeometry"] (renderer : POINTER TO VAR Renderer; texture : POINTER TO VAR Texture; vertices : POINTER TO VAR Vertex;
                                                    num_vertices : INTEGER; indices: POINTER TO VAR INTEGER; num_indices: INTEGER): BOOLEAN;

(*
PROCEDURE ^ SDLRenderDebugText ["SDL_RenderDebugText_wrap"] (renderer : POINTER TO VAR Renderer; x: REAL32; y: REAL32; str: POINTER TO VAR- CHAR): BOOLEAN;
PROCEDURE RenderDebugText*(renderer : POINTER TO VAR Renderer; x: REAL32; y: REAL32; str-: ARRAY OF CHAR): BOOLEAN;
BEGIN RETURN SDLRenderDebugText(renderer, x, y, PTR(str[0]))
END RenderDebugText;
*)

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
PROCEDURE ^ StepUTF8* ["SDL_StepUTF8"] (pstr : SYSTEM.ADDRESS; pslen : POINTER TO VAR LENGTH): Uint32;
PROCEDURE ^ StepBackUTF8* ["SDL_StepBackUTF8"] (start : POINTER TO VAR- CHAR; pstr : SYSTEM.ADDRESS): Uint32;

PROCEDURE ^ srand* ["SDL_srand"] (seed : Uint64);
PROCEDURE ^ rand* ["SDL_rand"] (n : Sint32): Sint32;
PROCEDURE ^ randf* ["SDL_randf"] (): REAL32;
(*
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
*)

(* SDL_time.h *)
PROCEDURE ^ SDLDateTimeToTime ["SDL_DateTimeToTime"] (dt : SYSTEM.ADDRESS; ticks : POINTER TO VAR Uint64): BOOLEAN;
PROCEDURE DateTimeToTime*(dt- : DateTime; VAR ticks: Uint64): BOOLEAN;
BEGIN RETURN SDLDateTimeToTime(SYSTEM.ADR(dt), PTR(ticks))
END DateTimeToTime;

PROCEDURE ^ SDLGetCurrentTime ["SDL_GetCurrentTime"] (ticks : POINTER TO VAR Uint64): BOOLEAN;
PROCEDURE GetCurrentTime*(VAR ticks: Uint64): BOOLEAN;
BEGIN RETURN SDLGetCurrentTime(PTR(ticks))
END GetCurrentTime;

PROCEDURE ^ SDLGetDateTimeLocalePreferences ["SDL_GetDateTimeLocalePreferences"] (dateFormat, timeFormat : POINTER TO VAR INTEGER): BOOLEAN;
PROCEDURE GetDateTimeLocalePreferences*(VAR dateFormat, timeFormat: INTEGER): BOOLEAN;
BEGIN RETURN SDLGetDateTimeLocalePreferences(PTR(dateFormat), PTR(timeFormat))
END GetDateTimeLocalePreferences;

PROCEDURE ^ GetDayOfWeek* ["SDL_GetDayOfWeek"] (year: INTEGER; month: INTEGER; day: INTEGER): INTEGER;
PROCEDURE ^ GetDayOfYear* ["SDL_GetDayOfYear"] (year: INTEGER; month: INTEGER; day: INTEGER): INTEGER;
PROCEDURE ^ GetDaysInMonth* ["SDL_GetDaysInMonth"] (year: INTEGER; month: INTEGER): INTEGER;

PROCEDURE ^ SDLTimeToDateTime ["SDL_TimeToDateTime"] (ticks: Uint64; dt: SYSTEM.ADDRESS; localTime : BOOLEAN): BOOLEAN;
PROCEDURE TimeToDateTime*(ticks: Uint64; VAR dt : DateTime; localTime : BOOLEAN ): BOOLEAN;
BEGIN RETURN SDLTimeToDateTime(ticks, SYSTEM.ADR(dt), localTime)
END TimeToDateTime;

(* SDL_timer.h *) 
PROCEDURE ^ SDLAddTimer ["SDL_AddTimer"] (interval : Uint32; callback : SYSTEM.ADDRESS; userdata : TimerCallback): Uint32;
PROCEDURE AddTimer*(interval : Uint32; callback : TimerCallback): Uint32;
BEGIN RETURN SDLAddTimer(interval, SYSTEM.ADR(TimerCallbackWrapper), callback)
END AddTimer;
PROCEDURE ^ RemoveTimer* ["SDL_RemoveTimer"] (timerID : Uint32): BOOLEAN;
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