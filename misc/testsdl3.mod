MODULE Test;

IN Ext IMPORT SDL3;

(* https://examples.libsdl.org/SDL3/renderer/01-clear/ *)
PROCEDURE Example1();
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    
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
    IF ~SDL3.CreateWindowAndRenderer("examples/renderer/clear", 640, 480, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
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
        green := REAL32(0.5 + 0.5 * SDL3.sin(now + SDL3.PI_D * 2.0 / 3.0));
        blue := REAL32(0.5 + 0.5 * SDL3.sin(now + SDL3.PI_D * 4.0 / 3.0));
        IGNORE(SDL3.SetRenderDrawColorFloat(renderer, red, green, blue, SDL3.ALPHA_OPAQUE_FLOAT)); (* new color, full alpha. *)
        
        (* clear the window to the draw color. *)
        IGNORE(SDL3.RenderClear(renderer));

        (* put the newly-cleared rendering on the screen. *)
        IGNORE(SDL3.RenderPresent(renderer));
    END;
    SDL3.Quit;
END Example1;

(* https://examples.libsdl.org/SDL3/renderer/02-primitives/ *)
PROCEDURE Example2();
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    points : ARRAY 500 OF SDL3.FPoint;
    rect : SDL3.FRect;
    event : SDL3.Event;
    i : LENGTH;
    quit : BOOLEAN;
BEGIN
    IGNORE(SDL3.SetAppMetadata("Example Renderer Primitives", "1.0", "com.example.renderer-primitives"));
    IF ~SDL3.Init(SDL3.INIT_VIDEO) THEN
        SDL3.LogStr("Couldn't initialize SDL:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IF ~SDL3.CreateWindowAndRenderer("examples/renderer/primitives", 640, 480, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
        SDL3.LogStr("Couldn't create window/renderer:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IGNORE(SDL3.SetRenderLogicalPresentation(renderer,640, 480, SDL3.LOGICAL_PRESENTATION_LETTERBOX));
    
    (* set up some random points *)
    FOR i := 0 TO LEN(points) - 1 DO
        points[i].x := (SDL3.randf() * 440.0) + 100.0;
        points[i].y := (SDL3.randf() * 280.0) + 100.0;
    END;
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(PTR(event)) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        
        (* as you can see from this, rendering draws over whatever was drawn before it. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 33, 33, 33, SDL3.ALPHA_OPAQUE));  (* dark gray, full alpha *)
        IGNORE(SDL3.RenderClear(renderer));  (* start with a blank canvas. *)
        
        (* draw a filled rectangle in the middle of the canvas. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 0, 255, SDL3.ALPHA_OPAQUE));  (* blue, full alpha *)
        rect.x := 100;
        rect.y := 100;
        rect.w := 440;
        rect.h := 280;
        IGNORE(SDL3.RenderFillRect(renderer, rect));
        
        (* draw some points across the canvas. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 255, 0, 0, SDL3.ALPHA_OPAQUE));  (* red, full alpha *)
        IGNORE(SDL3.RenderPoints(renderer, points));
        
        (* draw a unfilled rectangle in-set a little bit. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 255, 0, SDL3.ALPHA_OPAQUE));  (* green, full alpha *)
        rect.x := rect.x + 30;
        rect.y := rect.y + 30;
        rect.w := rect.w - 60;
        rect.h := rect.h - 60;
        IGNORE(SDL3.RenderRect(renderer, rect));
        
        (* draw two lines in an X across the whole canvas. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 255, 255, 0, SDL3.ALPHA_OPAQUE));  (* yellow, full alpha *)
        IGNORE(SDL3.RenderLine(renderer, 0, 0, 640, 480));
        IGNORE(SDL3.RenderLine(renderer, 0, 480, 640, 0));
        
        IGNORE(SDL3.RenderPresent(renderer));  (* put it all on the screen! *)
    END;
    SDL3.Quit;
END Example2;

BEGIN
    Example2;
END Test.