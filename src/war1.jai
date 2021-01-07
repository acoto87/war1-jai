#import "glfw";
#import "GL";
#import "nanovg";
#import "collections";
#import "utils";

#load "war_math.jai";
#load "war_types.jai";
#load "war_game.jai";

EXIT_SUCCESS :: 0;
EXIT_FAILURE :: -1;

errorCallback :: (error: s32, description: *u8) #c_call {
    newContext: Context;
    push_context newContext {
        print("Error: %\n", toString(description));
    }
}

main :: () {
    randomSeed(cast(s32) time(null));

    glfwSetErrorCallback(errorCallback);

    if (!glfwInit()) {
        exit(EXIT_FAILURE);
    }

    ctx: WarContext;
    if (!initGame(*ctx)) {
        exit(EXIT_FAILURE);
    }

    glfwSetWindowUserPointer(ctx.window, *ctx);
    // glfwSetCharCallback(context.window, inputCharCallback);

    while (!glfwWindowShouldClose(ctx.window)) {
        ctx.windowTitle = sprint(
            "War 1: % at % fps (%)",
            formatFloat(ctx.time, trailing_width=2, zero_removal=FormatFloat.Zero_Removal.NO),
            ctx.fps,
            formatFloat(ctx.deltaTime, trailing_width=2, zero_removal=FormatFloat.Zero_Removal.NO)
        );
        glfwSetWindowTitle(ctx.window, toCString(ctx.windowTitle, tempAllocator));

        inputGame(*ctx);
        // updateGame(*ctx);
        renderGame(*ctx);
        presentGame(*ctx);

        resetTemporaryStorage();
    }

    nvgDeleteGL2(ctx.gfx);
    glfwDestroyWindow(ctx.window);
    glfwTerminate();

    exit(EXIT_SUCCESS);
}

#scope_file

Basic :: #import "Basic";
resetTemporaryStorage :: Basic.reset_temporary_storage;
tprint :: Basic.tprint;