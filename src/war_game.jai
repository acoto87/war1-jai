SECONDS_PER_FRAME :: 1.0 / 60;

initGame :: (ctx: *WarContext) -> bool {
    glfwWindowHint(GLFW_RESIZABLE, 0);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);
    // glfwWindowHint(GLFW_CLIENT_API, GLFW_OPENGL_ES_API);

    ctx.globalScale = 3;
    ctx.globalSpeed = 1;
    ctx.originalWindowWidth = 320;
    ctx.originalWindowHeight = 200;
    ctx.windowWidth = cast(s32) (ctx.originalWindowWidth * ctx.globalScale);
    ctx.windowHeight = cast(s32) (ctx.originalWindowHeight * ctx.globalScale);
    ctx.windowTitle = "War 1";
    ctx.window = glfwCreateWindow(ctx.windowWidth, ctx.windowHeight, toCString(ctx.windowTitle, tempAllocator), null, null);
    ctx.transitionDelay = 0;
    ctx.cheatsEnabled = true;

    // pthread_mutex_init(&ctx.__mutex, NULL);

    if (!ctx.window)
    {
        print("GLFW window could not be created!\n");
        glfwTerminate();
        return false;
    }

    glfwGetWindowSize(ctx.window, *ctx.windowWidth, *ctx.windowHeight);
    glfwGetFramebufferSize(ctx.window, *ctx.framebufferWidth, *ctx.framebufferHeight);
    ctx.devicePixelRatio = cast(f32) ctx.framebufferWidth / cast(f32) ctx.windowWidth;

    glfwMakeContextCurrent(ctx.window);

    glfwSetInputMode(ctx.window, GLFW_CURSOR, GLFW_CURSOR_HIDDEN);

    glLoad(glfwGetProcAddress);

    glCheckOpenGLVersion();

    // init graphics
    ctx.gfx = nvgCreateGL2(NVGcreateFlags.NVG_STENCIL_STROKES | .NVG_DEBUG);
    if (ctx.gfx == null) {
        print("Could not init nanovg.\n");
        glfwDestroyWindow(ctx.window);
        glfwTerminate();
        return false;
    }

    // init audio
    // if (!initAudio(context))
    // {
    //     logError("Could not initialize audio.\n");
    //     return false;
    // }

    // load fonts
    // context->fontSprites[0] = loadFontSprite(context, "./war1_font_1.png");
    // context->fontSprites[1] = loadFontSprite(context, "./war1_font_2.png");

    glViewport(0, 0, cast(u32) ctx.framebufferWidth, cast(u32) ctx.framebufferHeight);
    glClearColor(0, 0, 1, 1.0);

    // check if the DATA.WAR file exists
    // bool dataFileExists = access(DATAWAR_FILE_PATH, F_OK) == 0;
    // if (dataFileExists)
    // {
    //     // load DATA.WAR file
    //     if (!loadDataFile(context))
    //     {
    //         logError("Could not load DATA.WAR file\n");
    //         return false;
    //     }

    //     WarScene* scene = createScene(context, WAR_SCENE_BLIZZARD);
    //     setNextScene(context, scene, 0.0f);
    // }
    // else
    // {
    //     WarScene* scene = createScene(context, WAR_SCENE_DOWNLOAD);
    //     setNextScene(context, scene, 0.0f);
    // }

    ctx.time = cast(f32) glfwGetTime();
    return true;
}

inputGame :: (ctx: *WarContext) {
    // mouse position
    xpos, ypos: f64;
    glfwGetCursorPos(ctx.window, *xpos, *ypos);

    ctx.input.pos = vec2(cast(f32) floor(xpos), cast(f32) floor(ypos)) / ctx.globalScale;

    // mouse buttons
    setInputButton(ctx, WarMouseButtons.MOUSE_LEFT, glfwGetMouseButton(ctx.window, GLFW_MOUSE_BUTTON_LEFT) == GLFW_PRESS);
    setInputButton(ctx, WarMouseButtons.MOUSE_RIGHT, glfwGetMouseButton(ctx.window, GLFW_MOUSE_BUTTON_RIGHT) == GLFW_PRESS);

    // keyboard keys
    setInputKey(ctx, WarKeys.KEY_SPACE, glfwGetKey(ctx.window, GLFW_KEY_SPACE) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_APOSTROPHE, glfwGetKey(ctx.window, GLFW_KEY_APOSTROPHE) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_COMMA, glfwGetKey(ctx.window, GLFW_KEY_COMMA) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_MINUS, glfwGetKey(ctx.window, GLFW_KEY_MINUS) == GLFW_PRESS ||
                                        glfwGetKey(ctx.window, GLFW_KEY_KP_SUBTRACT) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_PERIOD, glfwGetKey(ctx.window, GLFW_KEY_PERIOD) == GLFW_PRESS ||
                                         glfwGetKey(ctx.window, GLFW_KEY_KP_DECIMAL) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_SLASH, glfwGetKey(ctx.window, GLFW_KEY_SLASH) == GLFW_PRESS ||
                                        glfwGetKey(ctx.window, GLFW_KEY_KP_DIVIDE) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_0, glfwGetKey(ctx.window, GLFW_KEY_0) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_0) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_1, glfwGetKey(ctx.window, GLFW_KEY_1) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_1) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_2, glfwGetKey(ctx.window, GLFW_KEY_2) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_2) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_3, glfwGetKey(ctx.window, GLFW_KEY_3) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_3) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_4, glfwGetKey(ctx.window, GLFW_KEY_4) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_4) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_5, glfwGetKey(ctx.window, GLFW_KEY_5) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_5) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_6, glfwGetKey(ctx.window, GLFW_KEY_6) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_6) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_7, glfwGetKey(ctx.window, GLFW_KEY_7) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_7) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_8, glfwGetKey(ctx.window, GLFW_KEY_8) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_8) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_9, glfwGetKey(ctx.window, GLFW_KEY_9) == GLFW_PRESS ||
                                    glfwGetKey(ctx.window, GLFW_KEY_KP_9) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_SEMICOLON, glfwGetKey(ctx.window, GLFW_KEY_SEMICOLON) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_EQUAL, glfwGetKey(ctx.window, GLFW_KEY_EQUAL) == GLFW_PRESS ||
                                        glfwGetKey(ctx.window, GLFW_KEY_KP_EQUAL) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_A, glfwGetKey(ctx.window, GLFW_KEY_A) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_B, glfwGetKey(ctx.window, GLFW_KEY_B) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_C, glfwGetKey(ctx.window, GLFW_KEY_C) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_D, glfwGetKey(ctx.window, GLFW_KEY_D) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_E, glfwGetKey(ctx.window, GLFW_KEY_E) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F, glfwGetKey(ctx.window, GLFW_KEY_F) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_G, glfwGetKey(ctx.window, GLFW_KEY_G) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_H, glfwGetKey(ctx.window, GLFW_KEY_H) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_I, glfwGetKey(ctx.window, GLFW_KEY_I) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_J, glfwGetKey(ctx.window, GLFW_KEY_J) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_K, glfwGetKey(ctx.window, GLFW_KEY_K) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_L, glfwGetKey(ctx.window, GLFW_KEY_L) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_M, glfwGetKey(ctx.window, GLFW_KEY_M) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_N, glfwGetKey(ctx.window, GLFW_KEY_N) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_O, glfwGetKey(ctx.window, GLFW_KEY_O) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_P, glfwGetKey(ctx.window, GLFW_KEY_P) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_Q, glfwGetKey(ctx.window, GLFW_KEY_Q) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_R, glfwGetKey(ctx.window, GLFW_KEY_R) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_S, glfwGetKey(ctx.window, GLFW_KEY_S) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_T, glfwGetKey(ctx.window, GLFW_KEY_T) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_U, glfwGetKey(ctx.window, GLFW_KEY_U) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_V, glfwGetKey(ctx.window, GLFW_KEY_V) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_W, glfwGetKey(ctx.window, GLFW_KEY_W) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_X, glfwGetKey(ctx.window, GLFW_KEY_X) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_Y, glfwGetKey(ctx.window, GLFW_KEY_Y) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_Z, glfwGetKey(ctx.window, GLFW_KEY_Z) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_LEFT_BRACKET, glfwGetKey(ctx.window, GLFW_KEY_LEFT_BRACKET) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_BACKSLASH, glfwGetKey(ctx.window, GLFW_KEY_BACKSLASH) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_RIGHT_BRACKET, glfwGetKey(ctx.window, GLFW_KEY_RIGHT_BRACKET) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_GRAVE_ACCENT, glfwGetKey(ctx.window, GLFW_KEY_GRAVE_ACCENT) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_ESC, glfwGetKey(ctx.window, GLFW_KEY_ESCAPE) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_ENTER, glfwGetKey(ctx.window, GLFW_KEY_ENTER) == GLFW_PRESS ||
                                        glfwGetKey(ctx.window, GLFW_KEY_KP_ENTER) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_TAB, glfwGetKey(ctx.window, GLFW_KEY_TAB) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_BACKSPACE, glfwGetKey(ctx.window, GLFW_KEY_BACKSPACE) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_INSERT, glfwGetKey(ctx.window, GLFW_KEY_INSERT) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_DELETE, glfwGetKey(ctx.window, GLFW_KEY_DELETE) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_RIGHT, glfwGetKey(ctx.window, GLFW_KEY_RIGHT) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_LEFT, glfwGetKey(ctx.window, GLFW_KEY_LEFT) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_DOWN, glfwGetKey(ctx.window, GLFW_KEY_DOWN) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_UP, glfwGetKey(ctx.window, GLFW_KEY_UP) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_PAGE_UP, glfwGetKey(ctx.window, GLFW_KEY_PAGE_UP) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_PAGE_DOWN, glfwGetKey(ctx.window, GLFW_KEY_PAGE_DOWN) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_HOME, glfwGetKey(ctx.window, GLFW_KEY_HOME) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_END, glfwGetKey(ctx.window, GLFW_KEY_END) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_F1, glfwGetKey(ctx.window, GLFW_KEY_F1) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F2, glfwGetKey(ctx.window, GLFW_KEY_F2) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F3, glfwGetKey(ctx.window, GLFW_KEY_F3) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F4, glfwGetKey(ctx.window, GLFW_KEY_F4) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F5, glfwGetKey(ctx.window, GLFW_KEY_F5) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F6, glfwGetKey(ctx.window, GLFW_KEY_F6) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F7, glfwGetKey(ctx.window, GLFW_KEY_F7) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F8, glfwGetKey(ctx.window, GLFW_KEY_F8) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F9, glfwGetKey(ctx.window, GLFW_KEY_F9) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F10, glfwGetKey(ctx.window, GLFW_KEY_F10) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F11, glfwGetKey(ctx.window, GLFW_KEY_F11) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_F12, glfwGetKey(ctx.window, GLFW_KEY_F12) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_ASTERISK, glfwGetKey(ctx.window, GLFW_KEY_KP_MULTIPLY) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_PLUS, glfwGetKey(ctx.window, GLFW_KEY_KP_ADD) == GLFW_PRESS);

    setInputKey(ctx, WarKeys.KEY_SHIFT, glfwGetKey(ctx.window, GLFW_KEY_LEFT_SHIFT) == GLFW_PRESS ||
                                        glfwGetKey(ctx.window, GLFW_KEY_RIGHT_SHIFT) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_CTRL, glfwGetKey(ctx.window, GLFW_KEY_LEFT_CONTROL) == GLFW_PRESS ||
                                       glfwGetKey(ctx.window, GLFW_KEY_RIGHT_CONTROL) == GLFW_PRESS);
    setInputKey(ctx, WarKeys.KEY_ALT, glfwGetKey(ctx.window, GLFW_KEY_LEFT_ALT) == GLFW_PRESS ||
                                      glfwGetKey(ctx.window, GLFW_KEY_RIGHT_ALT) == GLFW_PRESS);
}

renderGame :: (ctx: *WarContext) {
    gfx := ctx.gfx;

    framebufferWidth := ctx.framebufferWidth;
    framebufferHeight := ctx.framebufferHeight;

    windowWidth := ctx.windowWidth;
    windowHeight := ctx.windowHeight;

    devicePixelRatio := ctx.devicePixelRatio;

    glViewport(0, 0, cast(u32) ctx.framebufferWidth, cast(u32) ctx.framebufferHeight);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);

    // don't render anything if it's transitioning
    if (ctx.transitionDelay > 0)
    {
        return;
    }

    nvgBeginFrame(gfx, cast(f32) windowWidth, cast(f32) windowHeight, devicePixelRatio);

    nvgBeginPath(gfx);
    nvgRect(gfx, 10, 10, 100, 100);
    nvgFillColor(gfx, nvgRGBAf(1, 0, 0, 1));
    nvgFill(gfx);

    nvgEndFrame(gfx);
}

presentGame :: (ctx: *WarContext)
{
    glfwSwapBuffers(ctx.window);
    glfwPollEvents();

    currentTime := cast(f32) glfwGetTime();
    ctx.deltaTime = (currentTime - ctx.time);

    // This code is good in theory, but the sleep resolution on different OSes
    // varies, so Sleep in Windows may take a longer time than specified.
    //
    // On Linux I should do a do {..} while (); using the nanosleep function
    // and check for interrutions that wake up the thread before.
    //
    // msleep((s32)((SECONDS_PER_FRAME - context.deltaTime) * 1000));
    // currentTime = (f32)glfwGetTime();
    // context.deltaTime = (currentTime - context.time);

    // This was the previous code that wait until the end of the frame
    // but this burn too much CPU, so it's better the alternative of
    // sleep the process and save CPU usage and battery.
    //
    // Going back to this code for now, until we get a consistent game loop with sleep.
    while (ctx.deltaTime <= SECONDS_PER_FRAME)
    {
        currentTime = cast(f32) glfwGetTime();
        ctx.deltaTime = (currentTime - ctx.time);
    }

    ctx.time = currentTime;
    ctx.fps = cast(u32) (1.0 / ctx.deltaTime);
}

#scope_file

setInputButton :: (ctx: *WarContext, button: WarMouseButtons, pressed: bool) {
    input := *ctx.input;

    input.buttons[button].wasPressed = input.buttons[button].pressed && !pressed;
    input.buttons[button].pressed = pressed;
}

setInputKey :: (ctx: *WarContext, key: WarKeys, pressed: bool) {
    input := *ctx.input;

    input.keys[key].wasPressed = input.keys[key].pressed && !pressed;
    input.keys[key].pressed = pressed;
}