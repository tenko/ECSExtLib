MODULE Test;

IN Ext IMPORT SDL3;
IN Ext IMPORT SDL3TTF;

CONST FONT = '/usr/share/fonts/TTF/Inconsolata-Regular.ttf';

PROCEDURE Example1();
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    texture : SDL3.PtrTexture;
    text : SDL3.PtrSurface;
    font : SDL3TTF.PtrFont;
    color : SDL3.Color;
    event : SDL3.Event;
    dst : SDL3.FRect;
    scale : REAL32;
    w, h : INTEGER;
    quit : BOOLEAN;
BEGIN
    color.r := SDL3.Uint8(255); color.g := SDL3.Uint8(255); color.b := SDL3.Uint8(255); color.a := SDL3.Uint8(SDL3.ALPHA_OPAQUE); 
    scale := 4.0;
    
    (* Create the window *)
    IF ~SDL3.CreateWindowAndRenderer("Hello World", 800, 600, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
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
    
    text := SDL3TTF.RenderText_Blended(font, "Hello World!", 0, color);
    IF text # NIL THEN
        texture := SDL3.CreateTextureFromSurface(renderer, text);
        SDL3.DestroySurface(text);
    END;
    
    IF texture = NIL THEN
        SDL3.LogStr("couldn't create text");
        SDL3.Log(SDL3.GetError());
        SDL3TTF.Quit();
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
        
        (* Center the text and scale it up *)
        IGNORE(SDL3.GetRenderOutputSize(renderer, w, h));
        IGNORE(SDL3.SetRenderScale(renderer, scale, scale));
        IGNORE(SDL3.GetTextureSize(texture, dst.w, dst.h));
        dst.x := ((w / scale) - dst.w) / 2.0;
        dst.y := ((h / scale) - dst.h) / 2.0;
        
        (* Draw the text *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 0, 0, SDL3.ALPHA_OPAQUE));
        IGNORE(SDL3.RenderClear(renderer));  
        IGNORE(SDL3.RenderTexture(renderer, texture, NIL, PTR(dst)));
        IGNORE(SDL3.RenderPresent(renderer));
    END;
    
    IF texture # NIL THEN SDL3.DestroyTexture(texture) END;
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3TTF.Quit();
    SDL3.Quit;
END Example1;

PROCEDURE Example2();
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    engine : SDL3TTF.PtrTextEngine;
    text : SDL3TTF.PtrText;
    font : SDL3TTF.PtrFont;
    event : SDL3.Event;
    x, y, scale : REAL32;
    w, h, text_w, text_h : INTEGER;
    quit : BOOLEAN;
BEGIN
    scale := 4.0;
    
    (* Create the window *)
    IF ~SDL3.CreateWindowAndRenderer("Hello World", 800, 600, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
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
    
    (* Create the text *)
    text := SDL3TTF.CreateText(engine, font, "Hello world!", 0);
    IF text = NIL THEN
        SDL3.LogStr("Couldn't create text");
        SDL3.Log(SDL3.GetError());
        SDL3TTF.Quit();
        SDL3.Quit;
        RETURN
    END;
    
    IGNORE(SDL3TTF.SetTextColor(text, 255, 255, 255, SDL3.ALPHA_OPAQUE));
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(PTR(event)) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        
        (* Center the text and scale it up *)
        IGNORE(SDL3.GetRenderOutputSize(renderer, w, h));
        IGNORE(SDL3.SetRenderScale(renderer, scale, scale));
        IGNORE(SDL3TTF.GetTextSize(text, text_w, text_h));
        x := ((w / scale) - text_w) / 2.0;
        y := ((h / scale) - text_h) / 2.0;
        
        (* Draw the text *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 0, 0, SDL3.ALPHA_OPAQUE));
        IGNORE(SDL3.RenderClear(renderer));  
        IGNORE(SDL3TTF.DrawRendererText(text, x, y));
        IGNORE(SDL3.RenderPresent(renderer));
    END;
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3TTF.Quit();
    SDL3.Quit;
END Example2;

BEGIN
    Example2; (* 1, 2 *)
END Test.
