MODULE Test;

IN Ext IMPORT SDL3;

(* https://examples.libsdl.org/SDL3/renderer/01-clear/ *)
PROCEDURE Example1();
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    
    event : SDL3.Event;
    now : REAL32;
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
        now := REAL32(SDL3.GetTicks()) / 1000.0; (* convert from milliseconds to seconds. *)
        (* choose the color for the frame we will draw. The sine wave trick makes it fade between colors smoothly. *)
        red := 0.5 + 0.5 * SDL3.sinf(now);
        green := 0.5 + 0.5 * SDL3.sinf(now + SDL3.PI_F * 2.0 / 3.0);
        blue := 0.5 + 0.5 * SDL3.sinf(now + SDL3.PI_F * 4.0 / 3.0);
        IGNORE(SDL3.SetRenderDrawColorFloat(renderer, red, green, blue, SDL3.ALPHA_OPAQUE_FLOAT)); (* new color, full alpha. *)
        
        (* clear the window to the draw color. *)
        IGNORE(SDL3.RenderClear(renderer));

        (* put the newly-cleared rendering on the screen. *)
        IGNORE(SDL3.RenderPresent(renderer));
    END;
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
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
        IGNORE(SDL3.RenderPoints(renderer, points, LEN(points)));
        
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
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3.Quit;
END Example2;

(* https://examples.libsdl.org/SDL3/renderer/03-lines/ *)
PROCEDURE Example3();
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    line_points : ARRAY 9 OF SDL3.FPoint;
    event : SDL3.Event;
    i : LENGTH;
    size, x, y, r : REAL32;
    quit : BOOLEAN;
BEGIN
    IGNORE(SDL3.SetAppMetadata("Example Renderer Lines", "1.0", "com.example.renderer-lines"));
    IF ~SDL3.Init(SDL3.INIT_VIDEO) THEN
        SDL3.LogStr("Couldn't initialize SDL:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IF ~SDL3.CreateWindowAndRenderer("examples/renderer/lines", 640, 480, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
        SDL3.LogStr("Couldn't create window/renderer:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IGNORE(SDL3.SetRenderLogicalPresentation(renderer,640, 480, SDL3.LOGICAL_PRESENTATION_LETTERBOX));
    
    (* Lines (line segments, really) are drawn in terms of points: a set of
       X and Y coordinates, one set for each end of the line.
       (0, 0) is the top left of the window, and larger numbers go down
       and to the right. This isn't how geometry works, but this is pretty
       standard in 2D graphics. *)
    
    line_points[0].x := 100; line_points[0].y := 354;
    line_points[1].x := 220; line_points[1].y := 230;
    line_points[2].x := 140; line_points[2].y := 230;
    line_points[3].x := 320; line_points[3].y := 100;
    line_points[4].x := 500; line_points[4].y := 230;
    line_points[5].x := 420; line_points[5].y := 230;
    line_points[6].x := 540; line_points[6].y := 354;
    line_points[7].x := 400; line_points[7].y := 354;
    line_points[8].x := 100; line_points[8].y := 354;
    
    size := 30.0;
    x := 320.0;
    y := 95.0 - (size / 2.0);
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(PTR(event)) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        (* as you can see from this, rendering draws over whatever was drawn before it. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 100, 100, 100, SDL3.ALPHA_OPAQUE));  (* grey, full alpha *)
        IGNORE(SDL3.RenderClear(renderer));  (* start with a blank canvas. *)
        
        (* You can draw lines, one at a time, like these brown ones... *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 127, 49, 32, SDL3.ALPHA_OPAQUE));
        IGNORE(SDL3.RenderLine(renderer, 240, 450, 400, 450));
        IGNORE(SDL3.RenderLine(renderer, 240, 356, 400, 356));
        IGNORE(SDL3.RenderLine(renderer, 240, 356, 240, 450));
        IGNORE(SDL3.RenderLine(renderer, 400, 356, 400, 450));
        
        (* You can also draw a series of connected lines in a single batch... *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 255, 0, SDL3.ALPHA_OPAQUE));
        IGNORE(SDL3.RenderLines(renderer, line_points, LEN(line_points)));
        
        (* here's a bunch of lines drawn out from a center point in a circle. *)
        (* we randomize the color of each line, so it functions as animation. *)
        FOR i := 0 TO 359 DO
            r := REAL32(i) * (SDL3.PI_F / 180.0);
            IGNORE(SDL3.SetRenderDrawColor(renderer, SDL3.rand(256), SDL3.rand(256), SDL3.rand(256), SDL3.ALPHA_OPAQUE));
            IGNORE(SDL3.RenderLine(renderer, x, y, x + SDL3.cosf(r) * size, y + SDL3.sinf(r) * size));
        END;
        
        (* put it all on the screen! *)
        IGNORE(SDL3.RenderPresent(renderer));
    END;
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3.Quit;
END Example3;

(* https://examples.libsdl.org/SDL3/renderer/04-points/ *)
PROCEDURE Example4();
CONST
    WINDOW_WIDTH = 640;
    WINDOW_HEIGHT = 480;
    NUM_POINTS = 500;
    MIN_PIXELS_PER_SECOND = 30;
    MAX_PIXELS_PER_SECOND = 60;
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    points : ARRAY NUM_POINTS OF SDL3.FPoint;
    point_speeds : ARRAY NUM_POINTS OF REAL32;
    now, last_time : SDL3.Uint64;
    elapsed, distance : REAL32;
    event : SDL3.Event;
    i : LENGTH;
    quit : BOOLEAN;
BEGIN
    IGNORE(SDL3.SetAppMetadata("Example Renderer Points", "1.0", "com.example.renderer-points"));
    IF ~SDL3.Init(SDL3.INIT_VIDEO) THEN
        SDL3.LogStr("Couldn't initialize SDL:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IF ~SDL3.CreateWindowAndRenderer("examples/renderer/points", WINDOW_WIDTH, WINDOW_HEIGHT, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
        SDL3.LogStr("Couldn't create window/renderer:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IGNORE(SDL3.SetRenderLogicalPresentation(renderer, WINDOW_WIDTH, WINDOW_HEIGHT, SDL3.LOGICAL_PRESENTATION_LETTERBOX));
    
    (* set up the data for a bunch of points. *)
    FOR i := 0 TO LEN(points) - 1 DO
        points[i].x := SDL3.randf() * WINDOW_WIDTH;
        points[i].y := SDL3.randf() * WINDOW_HEIGHT;
        point_speeds[i] := MIN_PIXELS_PER_SECOND + (SDL3.randf() * (MAX_PIXELS_PER_SECOND - MIN_PIXELS_PER_SECOND));
    END;
        
    last_time := SDL3.GetTicks();
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(PTR(event)) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        
        now := SDL3.GetTicks();
        elapsed := REAL32(now - last_time) / 1000.0;  (* seconds since last iteration *)
        
        (* let's move all our points a little for a new frame. *)
        FOR i := 0 TO LEN(points) - 1 DO
            distance := elapsed * point_speeds[i];
            points[i].x := points[i].x + distance;
            points[i].y := points[i].y + distance;
            IF (points[i].x >= WINDOW_WIDTH) OR (points[i].y >= WINDOW_HEIGHT) THEN
                (* off the screen; restart it elsewhere! *)
                IF SDL3.rand(2) > 0 THEN
                    points[i].x := SDL3.randf() * WINDOW_WIDTH;
                    points[i].y := 0.0;
                ELSE
                    points[i].x := 0.0;
                    points[i].y := SDL3.randf() * WINDOW_HEIGHT;
                END;
                point_speeds[i] := MIN_PIXELS_PER_SECOND + (SDL3.randf() * (MAX_PIXELS_PER_SECOND - MIN_PIXELS_PER_SECOND));      
            END;
        END;
    
        last_time := now;
        
        (* as you can see from this, rendering draws over whatever was drawn before it. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 0, 0, SDL3.ALPHA_OPAQUE));  (* black, full alpha *)
        IGNORE(SDL3.RenderClear(renderer));  (* start with a blank canvas. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 255, 255, 255, SDL3.ALPHA_OPAQUE));  (* white, full alpha *)
        IGNORE(SDL3.RenderPoints(renderer, points, LEN(points))); (* draw all the points! *)
        
        (* You can also draw single points with SDL_RenderPoint(), but it's
           cheaper (sometimes significantly so) to do them all at once. *)
       
        IGNORE(SDL3.RenderPresent(renderer));  (* put it all on the screen! *)
    END;
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3.Quit;
END Example4;

(* https://examples.libsdl.org/SDL3/renderer/05-rectangles/ *)
PROCEDURE Example5();
CONST
    WINDOW_WIDTH = 640;
    WINDOW_HEIGHT = 480;
    NUM_POINTS = 500;
    MIN_PIXELS_PER_SECOND = 30;
    MAX_PIXELS_PER_SECOND = 60;
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    rects : ARRAY 16 OF SDL3.FRect;
    now : SDL3.Uint64;
    direction, scale, size, w, h : REAL32;
    event : SDL3.Event;
    i : LENGTH;
    quit : BOOLEAN;
BEGIN
    IGNORE(SDL3.SetAppMetadata("Example Renderer Rectangles", "1.0", "com.example.renderer-rectangles"));
    IF ~SDL3.Init(SDL3.INIT_VIDEO) THEN
        SDL3.LogStr("Couldn't initialize SDL:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IF ~SDL3.CreateWindowAndRenderer("examples/renderer/rectangles", WINDOW_WIDTH, WINDOW_HEIGHT, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
        SDL3.LogStr("Couldn't create window/renderer:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IGNORE(SDL3.SetRenderLogicalPresentation(renderer, WINDOW_WIDTH, WINDOW_HEIGHT, SDL3.LOGICAL_PRESENTATION_LETTERBOX));
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(PTR(event)) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        
        now := SDL3.GetTicks();
        
        (* we'll have the rectangles grow and shrink over a few seconds. *)
        IF now MOD 2000 >= 1000 THEN direction := 1.0
        ELSE direction := -1.0 END;
        scale := (REAL32((now MOD 1000) - 500) / 500.0) * direction;
        
        (* as you can see from this, rendering draws over whatever was drawn before it. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 0, 0, SDL3.ALPHA_OPAQUE));  (* black, full alpha *)
        IGNORE(SDL3.RenderClear(renderer));  (* start with a blank canvas. *)
        
        (* Rectangles are comprised of set of X and Y coordinates, plus width and
           height. (0, 0) is the top left of the window, and larger numbers go
           down and to the right. This isn't how geometry works, but this is
           pretty standard in 2D graphics. *)

        (* Let's draw a single rectangle (square, really). *)
        rects[0].x := 100; rects[0].y := 100;
        rects[0].w := 100 + (100 * scale);
        rects[0].h := 100 + (100 * scale);
        IGNORE(SDL3.SetRenderDrawColor(renderer, 255, 0, 0, SDL3.ALPHA_OPAQUE));  (* red, full alpha *)
        IGNORE(SDL3.RenderRect(renderer, rects[0]));
        
        (* Now let's draw several rectangles with one function call. *)
        FOR i := 0 TO 2 DO
            size := (i + 1) * 50.0;
            rects[i].w := size + (size * scale);
            rects[i].h := size + (size * scale);
            rects[i].x := (WINDOW_WIDTH - rects[i].w) / 2; (* center it. *)
            rects[i].y := (WINDOW_HEIGHT - rects[i].h) / 2;  (* center it. *)
        END;
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 255, 0, SDL3.ALPHA_OPAQUE));  (* green, full alpha *)
        IGNORE(SDL3.RenderRects(renderer, rects, 3));  (* draw three rectangles at once *)
        
        (* those were rectangle _outlines_, really. You can also draw _filled_ rectangles! *)
        rects[0].x := 400;
        rects[0].y := 50;
        rects[0].w := 100 + (100 * scale);
        rects[0].h := 50 + (50 * scale);
        IGNORE(SDL3.SetRenderDrawColor(renderer, 0, 0, 255, SDL3.ALPHA_OPAQUE));  (* blue, full alpha *)
        IGNORE(SDL3.RenderFillRect(renderer, rects[0]));
        
        (* ...and also fill a bunch of rectangles at once... *)
        FOR i := 0 TO LEN(rects) - 1 DO
            w :=  WINDOW_WIDTH / LEN(rects);
            h := i * 8.0;
            rects[i].x := i * w;
            rects[i].y := WINDOW_HEIGHT - h;
            rects[i].w := w;
            rects[i].h := h;
        END;
        IGNORE(SDL3.SetRenderDrawColor(renderer, 255, 255, 255, SDL3.ALPHA_OPAQUE));  (* white, full alpha *)
        IGNORE(SDL3.RenderFillRects(renderer, rects, LEN(rects)));  

        IGNORE(SDL3.RenderPresent(renderer));  (* put it all on the screen! *)
    END;
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3.Quit;
END Example5;

(* https://examples.libsdl.org/SDL3/renderer/06-textures/ *)
PROCEDURE Example6();
CONST
    WINDOW_WIDTH = 640;
    WINDOW_HEIGHT = 480;
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    texture : SDL3.PtrTexture;
    surface : SDL3.PtrSurface;
    dst_rect : SDL3.FRect;
    now : SDL3.Uint64;
    direction, scale: REAL32;
    texture_width : INTEGER;
    texture_height : INTEGER;
    event : SDL3.Event;
    quit : BOOLEAN;
BEGIN
    IGNORE(SDL3.SetAppMetadata("Example Renderer Textures", "1.0", "com.example.renderer-textures"));
    IF ~SDL3.Init(SDL3.INIT_VIDEO) THEN
        SDL3.LogStr("Couldn't initialize SDL:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IF ~SDL3.CreateWindowAndRenderer("examples/renderer/textures", WINDOW_WIDTH, WINDOW_HEIGHT, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
        SDL3.LogStr("Couldn't create window/renderer:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IGNORE(SDL3.SetRenderLogicalPresentation(renderer, WINDOW_WIDTH, WINDOW_HEIGHT, SDL3.LOGICAL_PRESENTATION_LETTERBOX));
    
    texture_width := 0;
    texture_height := 0;
    
    (* Textures are pixel data that we upload to the video hardware for fast drawing. Lots of 2D
       engines refer to these as "sprites." We'll do a static texture (upload once, draw many
       times) with data from a png file. *)

    (* SDL_Surface is pixel data the CPU can access. SDL_Texture is pixel data the GPU can access.
       Load a .png into a surface, move it to a texture from there. *)
    surface := SDL3.LoadPNG("misc/sample.png");
    IF surface = NIL THEN
        SDL3.LogStr("Couldn't load png");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    
    texture_width := surface.w;
    texture_height := surface.h;
    
    texture := SDL3.CreateTextureFromSurface(renderer, surface);
    IF texture = NIL THEN
        SDL3.LogStr("ouldn't create static texture");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    
    SDL3.DestroySurface(surface); (* done with this, the texture has a copy of the pixels now. *)
    
    quit := FALSE;
    WHILE ~quit DO
        WHILE SDL3.PollEvent(PTR(event)) DO
            IF event.type = SDL3.EVENT_QUIT THEN
                quit := TRUE
            END;
        END;
        now := SDL3.GetTicks();
        
        (* we'll have some textures move around over a few seconds. *)
        IF now MOD 2000 >= 1000 THEN direction := 1.0
        ELSE direction := -1.0 END;
        scale := (REAL32((now MOD 1000) - 500) / 500.0) * direction;

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

(* https://examples.libsdl.org/SDL3/renderer/07-streaming-textures/ *)
PROCEDURE Example7();
CONST
    WINDOW_WIDTH = 640;
    WINDOW_HEIGHT = 480;
    TEXTURE_SIZE = 150;
VAR
    window : SDL3.PtrWindow;
    renderer : SDL3.PtrRenderer;
    texture : SDL3.PtrTexture;
    surface : SDL3.PtrSurface;
    dst_rect : SDL3.FRect;
    r : SDL3.Rect;
    now : SDL3.Uint64;
    direction, scale: REAL32;
    event : SDL3.Event;
    quit : BOOLEAN;
BEGIN
    IGNORE(SDL3.SetAppMetadata("Example Renderer Streaming Textures", "1.0", "com.example.renderer-streaming-textures"));
    IF ~SDL3.Init(SDL3.INIT_VIDEO) THEN
        SDL3.LogStr("Couldn't initialize SDL:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IF ~SDL3.CreateWindowAndRenderer("examples/renderer/streaming-textures", WINDOW_WIDTH, WINDOW_HEIGHT, SDL3.WINDOW_RESIZABLE, window, renderer) THEN
        SDL3.LogStr("Couldn't create window/renderer:");
        SDL3.Log(SDL3.GetError());
        SDL3.Quit;
        RETURN
    END;
    IGNORE(SDL3.SetRenderLogicalPresentation(renderer, WINDOW_WIDTH, WINDOW_HEIGHT, SDL3.LOGICAL_PRESENTATION_LETTERBOX));
    
    texture := SDL3.CreateTexture(renderer, SDL3.PIXELFORMAT_RGBA8888, SDL3.TEXTUREACCESS_STREAMING, TEXTURE_SIZE, TEXTURE_SIZE);
    IF texture = NIL THEN
        SDL3.LogStr("Couldn't create streaming texture");
        SDL3.Log(SDL3.GetError());
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
        surface := NIL;
        
        (* we'll have some textures move around over a few seconds. *)
        IF now MOD 2000 >= 1000 THEN direction := 1.0
        ELSE direction := -1.0 END;
        scale := (REAL32((now MOD 1000) - 500) / 500.0) * direction;
        
        (* To update a streaming texture, you need to lock it first. This gets you access to the pixels.
           Note that this is considered a _write-only_ operation: the buffer you get from locking
           might not actually have the existing contents of the texture, and you have to write to every
           locked pixel! *)

        (* You can use SDL_LockTexture() to get an array of raw pixels, but we're going to use
           SDL_LockTextureToSurface() here, because it wraps that array in a temporary SDL_Surface,
           letting us use the surface drawing functions instead of lighting up individual pixels. *)
        
        IF SDL3.LockTextureToSurface(texture, NIL, surface) THEN
            IGNORE(SDL3.FillSurfaceRect(surface, NIL, SDL3.MapRGB(SDL3.GetPixelFormatDetails(surface.format), NIL, 0, 0, 0)));  (* make the whole surface black *)
            r.w := TEXTURE_SIZE;
            r.h := TEXTURE_SIZE DIV 10;
            r.x := 0;
            r.y := INTEGER(((TEXTURE_SIZE - r.h)) * ((scale + 1.0) / 2.0));
            IGNORE(SDL3.FillSurfaceRect(surface, PTR(r), SDL3.MapRGB(SDL3.GetPixelFormatDetails(surface.format), NIL, 0, 255, 0)));  (* make a strip of the surface green *)
            SDL3.UnlockTexture(texture);  (* upload the changes (and frees the temporary surface)! *)
        END;
    
        (* as you can see from this, rendering draws over whatever was drawn before it. *)
        IGNORE(SDL3.SetRenderDrawColor(renderer, 60, 60, 60, SDL3.ALPHA_OPAQUE));  (* grey, full alpha *)
        IGNORE(SDL3.RenderClear(renderer));  (* start with a blank canvas. *)
        
        (* Just draw the static texture a few times. You can think of it like a
           stamp, there isn't a limit to the number of times you can draw with it. *)

        (* Center this one. It'll draw the latest version of the texture we drew while it was locked. *)
        dst_rect.x := ((WINDOW_WIDTH - TEXTURE_SIZE)) / 2.0;
        dst_rect.y := ((WINDOW_HEIGHT - TEXTURE_SIZE)) / 2.0;
        dst_rect.w := TEXTURE_SIZE;
        dst_rect.h := TEXTURE_SIZE;
        IGNORE(SDL3.RenderTexture(renderer, texture, NIL, PTR(dst_rect)));
    
        IGNORE(SDL3.RenderPresent(renderer));  (* put it all on the screen! *)
    END;
    
    IF texture # NIL THEN SDL3.DestroyTexture(texture) END;
    IF renderer # NIL THEN SDL3.DestroyRenderer(renderer) END;
    IF window # NIL THEN SDL3.DestroyWindow(window) END;
    SDL3.Quit;
END Example7;

BEGIN
    Example2;
END Test.