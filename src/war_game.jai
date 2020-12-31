SECONDS_PER_FRAME :: 1.0 / 60;

initGame :: (ctx: *WarContext) -> bool {
    glfwWindowHint(GLFW_RESIZABLE, 0);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 0);
    glfwWindowHint(GLFW_CLIENT_API, GLFW_OPENGL_ES_API);

    ctx.globalScale = 3;
    ctx.globalSpeed = 1;
    ctx.originalWindowWidth = 320;
    ctx.originalWindowHeight = 200;
    ctx.windowWidth = cast(s32) (ctx.originalWindowWidth * ctx.globalScale);
    ctx.windowHeight = cast(s32) (ctx.originalWindowHeight * ctx.globalScale);
    ctx.windowTitle = "War 1";
    ctx.window = glfwCreateWindow(ctx.windowWidth, ctx.windowHeight, ctx.windowTitle, null, null);
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
    ctx.gfx = nvgCreateGLES2(NVGcreateFlags.NVG_STENCIL_STROKES | .NVG_DEBUG);
    if (ctx.gfx == null) {
        print("Could not init nanovg.\n");
        glfwDestroyWindow(ctx.window);
        glfwTerminate();
		return false;
	}

    using glGetProcedures();

    glViewport(0, 0, cast(u32) ctx.framebufferWidth, cast(u32) ctx.framebufferHeight);
    glClearColor(0, 0, 1, 1.0);

    ctx.time = cast(f32) glfwGetTime();
    return true;
}

renderGame :: (ctx: *WarContext) {
    using glGetProcedures();

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