MODULE Test;

IN Ext IMPORT SDL3TTF;

PROCEDURE Example();
CONST
    WINDOW_WIDTH = 640;
    WINDOW_HEIGHT = 480;
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    texture : SDL3.PtrTexture;
    text : SDL3.PtrSurface;
    font : SDL3TTF.PtrFont;
    event : SDL3.Event;
    quit : BOOLEAN;
BEGIN
    (* Create the window *)
    IF ~SDL3.CreateWindowAndRenderer("Hello World", 800, 600, SDL3.WINDOW_FULLSCREEN, window, renderer) THEN
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
    font := SDL3TTF.OpenFont('/usr/share/fonts/TTF/DejaVuSansMono.ttf', 18.0);
    IF font = NIL THEN
        SDL3.LogStr("Couldn't open font");
        SDL3.Log(SDL3.GetError());
        SDL3TTF.Quit()
        SDL3.Quit;
        RETURN
    END;
    
    text := SDL3TTF.RenderText_Blended(font, "Hello World!", 0, color)
    IF text # NIL THEN
        texture = SDL3.CreateTextureFromSurface(renderer, text);
        SDL3.DestroySurface(text);
    END;
    
    IF texture = NIL THEN
        SDL3.LogStr("couldn't create text");
        SDL3.Log(SDL3.GetError());
        SDL3TTF.Quit()
        SDL3.Quit;
        RETURN
    END;
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(PTR(event)) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        now := SDL3.GetTicks();
        
        (* as you can see from this, rendering draws over whatever was drawn before it. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 0, 0, SDL3.ALPHA_OPAQUE));  (* black, full alpha *)
        IGNORE(SDL3.RenderClear(renderer));  (* start with a blank canvas. *)
        
        (* Just draw the static texture a few times. You can think of it like a
           stamp, there isn't a limit to the number of times you can draw with it. *)

        (* top left *)
        dst_rect.x := 100.0 * scale;
        dst_rect.y := 0.0;
        dst_rect.w := texture_width;
        dst_rect.h := texture_height;
        IGNORE(SDL3.RenderTexture(renderer, texture, NIL, PTR(dst_rect)));
        
        (* center this one. *)
        dst_rect.x := (WINDOW_WIDTH - texture_width) / 2.0;
        dst_rect.y := (WINDOW_HEIGHT - texture_height) / 2.0;
        dst_rect.w := texture_width;
        dst_rect.h := texture_height;
        IGNORE(SDL3.RenderTexture(renderer, texture, NIL, PTR(dst_rect)));

        (* bottom right. *)
        dst_rect.x := (WINDOW_WIDTH - texture_width) - (100.0 * scale);
        dst_rect.y := WINDOW_HEIGHT - texture_height;
        dst_rect.w := texture_width;
        dst_rect.h := texture_height;
        IGNORE(SDL3.RenderTexture(renderer, texture, NIL, PTR(dst_rect)));
    
        IGNORE(SDL3.RenderPresent(renderer));  (* put it all on the screen! *)
    END;
    
    IF texture # NIL THEN SDL3.DestroyTexture(texture) END;
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3.Quit;
END Example6;

PROCEDURE Test();
VAR
    font : POINTER TO VAR SDL3TTF.Font;
BEGIN
    TRACE(SDL3TTF.Init());
    font := SDL3TTF.OpenFont('/usr/share/fonts/TTF/DejaVuSansMono.ttf', 12.0);
    TRACE(font);
    IF font # NIL THEN SDL3TTF.CloseFont(font) END;
    SDL3TTF.Quit()
END Test;

BEGIN
    Test;
END Test.
