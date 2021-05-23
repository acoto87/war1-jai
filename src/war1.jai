#import "glfw";
#import "GL";
#import "stb_image";
#import "stb_image_write";
#import "nanovg";
#import "collections";
#import "utils";
#import "rts2d"(
    MaxPlayersCount = 5,
    MaxPlayerResourcesCount = 3,
);

#load "war_constants.jai";
#load "war_types.jai";
#load "war_database.jai";
#load "war_file.jai";
#load "war_resources.jai";
#load "war_font.jai";
#load "war_sprites.jai";
#load "war_animations.jai";
#load "war_audio.jai";
#load "war_components.jai";
// #load "war_entities.jai";
// #load "war_units.jai";
#load "war_scenes.jai";
#load "war_ui.jai";
// #load "war_player.jai";
#load "war_campaigns.jai";
#load "war_map.jai";
#load "war_game.jai";

EXIT_SUCCESS :: 0;
EXIT_FAILURE :: -1;

#add_context gameContext: *WarContext;

main :: () {
    loggerData := LoggerData.{
        severity = LogSeverity.Debug
    };
    initLogger(*loggerData);

    ctx: WarContext;
    context.gameContext = *ctx;

    if (!initWarGame()) {
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

        inputGame();
        updateGame();
        renderGame();
        presentGame();

        resetTemporaryStorage();
    }

    uninitGame();

    exit(EXIT_SUCCESS);
}

#scope_file

Compiler :: #import "Compiler";
setTypeInfoFlags :: Compiler.compiler_set_type_info_flags;

#run setTypeInfoFlags(GL_Procedures, .PROCEDURES_ARE_VOID_POINTERS);
#run setTypeInfoFlags(GL_Procedures, .NO_SIZE_COMPLAINT);
