WarSceneType :: enum {
    Download;
    Blizzard;
    MainMenu;
    Briefing;
    Map;
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

    downloadState: WarSceneDownloadState;
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

createScene :: (ctx: *WarContext, $type: WarSceneType) -> *WarScene {
    assert(ctx != null);

    scene: *WarScene = null;

    #if (type == WarSceneType.Download) {
        scene = alloc(WarDownloadScene);
    }
    else if (type == WarSceneType.Blizzard) {
        scene = alloc(WarBlizzardScene);
    }
    else if (type == WarSceneType.MainMenu) {
        scene = alloc(WarMenuScene);
    }
    else if (type == WarSceneType.Briefing) {
        scene = alloc(WarBriefingScene);
    }
    else if (type == WarSceneType.Map) {
        scene = alloc(WarMap);
    }

    if (scene != null) {
        initEntityManager(*scene.entityManager);
        initComponentsManager(*scene.componentsManager);
    }

    return scene;
}

createScene :: (ctx: *WarContext, $type: Type) -> *type {
    assert(ctx != null);

    #if (type == WarDownloadScene)      return cast(*type) createScene(ctx, WarSceneType.Download);
    else if (type == WarMenuScene)      return cast(*type) createScene(ctx, WarSceneType.MainMenu);
    else if (type == WarBriefingScene)  return cast(*type) createScene(ctx, WarSceneType.Briefing);
    else if (type == WarMap)            return cast(*type) createScene(ctx, WarSceneType.Map);
    else {
        logError("Unkown scene type: %\n", type);
        return null;
    }
}

freeScene :: (ctx: *WarContext, scene: *WarScene) {
    assert(ctx != null);
    assert(scene != null);

    freeEntityManager(*scene.entityManager);
    freeComponentsManager(*scene.componentsManager);
}

setNextScene :: (ctx: *WarContext, scene: *WarScene, transitionDelay: f32) {
    ctx.nextScene = scene;
    ctx.transitionDelay = transitionDelay;
}

enterScene :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);

    enterSceneFn := sceneDescriptors[cast(s32) ctx.scene.type].enterSceneFn;
    if (enterSceneFn != null) {
        enterSceneFn(ctx);
    }
}

updateScene :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);

    updateSceneFn := sceneDescriptors[cast(s32) ctx.scene.type].updateSceneFn;
    if (updateSceneFn != null) {
        updateSceneFn(ctx);
    } else {
        // updateCheatsPanel(ctx);
        updateUIButtons(ctx, true); // !cheatsEnabledAndVisible(scene));
        updateUICursor(ctx);
        updateAnimations(ctx);
    }
}

leaveScene :: (ctx: *WarContext) {
    assert(ctx != null);

    if (ctx.scene == null) {
        return;
    }

    leaveSceneFn := sceneDescriptors[cast(s32) ctx.scene.type].leaveSceneFn;
    if (leaveSceneFn != null) {
        leaveSceneFn(ctx);
    } else {
        freeScene(ctx, ctx.scene);
        ctx.scene = null;
    }
}

renderScene :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.gfx != null);
    assert(ctx.scene != null);

    gfx := ctx.gfx;

    nvgSave(gfx);
    nvgScale(gfx, ctx.globalScale, ctx.globalScale);

    entityManager := *ctx.scene.entityManager;
    for * entry : entityManager.entitiesById {
        entity := entry.value;
        assert(entity != null);

        renderEntity(ctx, entity);
    }

    nvgRestore(gfx);
}

#scope_file

#load "war_scene_blizzard.jai";
#load "war_scene_menu.jai";
#load "war_scene_briefing.jai";

WarSceneFn :: #type (ctx: *WarContext);

WarSceneDescriptor :: struct {
    type: WarSceneType;
    enterSceneFn: WarSceneFn;
    leaveSceneFn: WarSceneFn;
    updateSceneFn: WarSceneFn;
    renderSceneFn: WarSceneFn;
}

sceneDescriptors : [] WarSceneDescriptor = .[
    .{ WarSceneType.Download, null,               null, null,                null },
    .{ WarSceneType.Blizzard, enterSceneBlizzard, null, updateSceneBlizzard, null },
    .{ WarSceneType.MainMenu, enterSceneMainMenu, null, null,                null },
    .{ WarSceneType.Briefing, enterSceneBriefing, null, updateSceneBriefing, null },
    .{ WarSceneType.Map,      null,               null, null,                null }
];
