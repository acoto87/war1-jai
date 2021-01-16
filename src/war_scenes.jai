WarSceneType :: enum {
    Download;
    Blizzard;
    MainMenu;
    Briefing;
    Map;

    Count;
}

WarScene :: struct {
    type: WarSceneType;
    entityManager: WarEntityManager;
    componentsManager: WarComponentsManager;

    // cheatStatus: WarCheatStatus;
}

WarSceneDownloadState :: enum {
    Download;
    Confirm;
    Downloading;
    Downloaded;
    FileLoaded;
    Failed;
}

WarDownloadScene :: struct {
    using base: WarScene;
    base.type = WarSceneType.Download;

    status: WarSceneDownloadState;
}

WarBlizzardScene :: struct {
    using base: WarScene;
    base.type = WarSceneType.Blizzard;

    time: f32;
}

WarMenuScene :: struct {
    using base: WarScene;
    base.type = WarSceneType.MainMenu;

    yourRace: WarRace;
    enemyRace: WarRace;
    customMap: s32;
}

WarBriefingScene :: struct {
    using base: WarScene;
    base.type = WarSceneType.Briefing;

    time: f32;
    race: WarRace;
    mapType: WarCampaignMapType;
}

createScene :: (ctx: *WarContext, type: WarSceneType) -> *WarScene {
    return null;
}

freeScene :: (ctx: *WarContext, scene: *WarScene) {

}

setNextScene :: (ctx: *WarContext, scene: *WarScene, transitionDelay: f32) {
    ctx.nextScene = scene;
    ctx.transitionDelay = transitionDelay;
}

enterScene :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);

    if ctx.scene.type == {
        // case WarSceneType.Download; enterSceneDownload();
        case WarSceneType.Blizzard; enterSceneBlizzard(ctx);
        // case WarSceneType.MainMenu; enterSceneMainMenu();
        // case WarSceneType.Briefing; enterSceneBriefing();
        // case WarSceneType.Map;      enterSceneMap();
        case; {
            logError("Unkown scene type: %\n", ctx.scene.type);
        }
    }
}

updateScene :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);

    if ctx.scene.type == {
        // case WarSceneType.Download; updateSceneDownload();
        case WarSceneType.Blizzard; updateSceneBlizzard(ctx);
        // case WarSceneType.MainMenu; updateSceneMainMenu();
        // case WarSceneType.Briefing; updateSceneBriefing();
        // case WarSceneType.Map;      updateSceneMap();
        case; {
            logError("Unkown scene type: %\n", ctx.scene.type);

            // updateCheatsPanel(context);
            // updateUIButtons(context, !cheatsEnabledAndVisible(scene));
            // updateUICursor(context);
            // updateAnimations(context);
        }
    }
}

leaveScene :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);

    if ctx.scene.type == {
        // case WarSceneType.Download; leaveSceneDownload();
        // case WarSceneType.Blizzard; leaveSceneBlizzard(ctx);
        // case WarSceneType.MainMenu; leaveSceneMainMenu();
        // case WarSceneType.Briefing; leaveSceneBriefing();
        // case WarSceneType.Map;      leaveSceneMap();
        case; {
            logError("Unkown scene type: %\n", ctx.scene.type);

            freeScene(ctx, ctx.scene);
            ctx.scene = null;
        }
    }
}

renderScene :: (ctx: *WarContext) {
    gfx := ctx.gfx;

    nvgSave(gfx);
    nvgScale(gfx, ctx.globalScale, ctx.globalScale);

    uiEntities := getUIEntities(ctx);
    for entity : uiEntities {
        // renderEntity(ctx, entity);
    }

    nvgRestore(gfx);
}

#scope_file

#load "war_scene_blizzard.jai";
