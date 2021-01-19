enterSceneBlizzard :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);
    assert(ctx.scene.type == WarSceneType.Blizzard);

    scene := cast(*WarBlizzardScene) ctx.scene;
    scene.time = 3.0;

    createUIImage(ctx, "imgBackground", imageResourceRef(216), VEC2_ZERO);
    // createAudio(context, WAR_LOGO, true);
}

updateSceneBlizzard :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);
    assert(ctx.scene.type == WarSceneType.Blizzard);

    scene := cast(*WarBlizzardScene) ctx.scene;
    scene.time -= ctx.deltaTime;

    if (scene.time <= 0) {
        nextScene := createScene(ctx, WarSceneType.MainMenu);
        setNextScene(ctx, nextScene, 0.3);
    }
}
