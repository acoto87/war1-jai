#import "glfw";
#import "GL";
#import "nanovg";
#import "collections";
#import "utils";

#load "war_constants.jai";
#load "war_color.jai";
#load "war_math.jai";
#load "war_types.jai";
#load "war_database.jai";
#load "war_file.jai";
#load "war_resources.jai";
#load "war_render.jai";
#load "war_sprites.jai";
#load "war_audio.jai";
#load "war_pathfinding.jai";
#load "war_components.jai";
#load "war_entities.jai";
#load "war_scenes.jai";
#load "war_ui.jai";
#load "war_player.jai";
#load "war_map.jai";
#load "war_game.jai";

EXIT_SUCCESS :: 0;
EXIT_FAILURE :: -1;

errorCallback :: (error: s32, description: *u8) #c_call {
    newContext: Context;
    push_context newContext {
        logError("Error: %\n", toString(description));
    }
}

main :: () {
    initLog(LogSeverity.Debug);

    glfwSetErrorCallback(errorCallback);

    if (!glfwInit()) {
        logError("Error initializing GLFW!\n");
        exit(EXIT_FAILURE);
    }

    ctx: WarContext;
    if (!initGame(*ctx)) {
        logError("Can't initialize the game!\n");
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
        updateGame(*ctx);
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
