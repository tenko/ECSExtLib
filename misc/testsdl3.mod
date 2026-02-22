MODULE Test;

IN Ext IMPORT SDL3;

(* https://examples.libsdl.org/SDL3/renderer/01-clear/ *)
PROCEDURE Example1();
VAR
    window : POINTER TO VAR SDL3.Window;
    renderer : POINTER TO VAR SDL3.Renderer;
    event : SDL3.Event;
    now : REAL64;
    red, green, blue : REAL32;
    quit : BOOLEAN;
BEGIN
    IGNORE(SDL3.SetAppMetadata("Example Renderer Clear", "1.0", "com.example.renderer-clear"));
    IF ~SDL3.Init(SDL3.INIT_VIDEO) THEN
        SDL3.LogStr("Couldn't initialize SDL:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    window := SDL3.CreateWindow("examples/renderer/clear", 640, 480, SDL3.WINDOW_RESIZABLE);
    renderer := SDL3.CreateRenderer(window, "");
    IF (window = NIL) OR (renderer = NIL) THEN
        SDL3.LogStr("Couldn't create window/renderer:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IGNORE(SDL3.SetRenderLogicalPresentation(renderer,640, 480, SDL3.LOGICAL_PRESENTATION_LETTERBOX));
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(PTR(event)) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        now := REAL64(SDL3.GetTicks()) / 1000.0; (* convert from milliseconds to seconds. *)
        (* choose the color for the frame we will draw. The sine wave trick makes it fade between colors smoothly. *)
        red := REAL32(0.5 + 0.5 * SDL3.sin(now));
        green := REAL32(0.5 + 0.5 * SDL3.sin(now + SDL3.PI_D * 2 / 3));
        blue := REAL32(0.5 + 0.5 * SDL3.sin(now + SDL3.PI_D * 4 / 3));
        IGNORE(SDL3.SetRenderDrawColorFloat(renderer, red, green, blue, 1.0)); (* new color, full alpha. *)
        
        (* clear the window to the draw color. *)
        IGNORE(SDL3.RenderClear(renderer));

        (* put the newly-cleared rendering on the screen. *)
        IGNORE(SDL3.RenderPresent(renderer));
    END;
    SDL3.Quit;
END Example1;

BEGIN
    Example1();
END Test.