createSceneBlizzard :: () -> *WarBlizzardScene {
    scene := createScene(WarBlizzardScene);
    scene.enterSceneFn = enterSceneBlizzard;
    scene.updateSceneFn = updateSceneBlizzard;
    return scene;
}

enterSceneBlizzard :: () {
    ctx := cast(*WarContext) context.gameContext;

    assert(ctx != null);
    assert(ctx.scene != null);
    // assert(ctx.scene.type == WarSceneType.Blizzard);

    scene := cast(*WarBlizzardScene) ctx.scene;
    scene.time = 3.0;

    createUIImage("imgBackground", imageResourceRef(216), VEC2_ZERO);
    // createAudio(context, WAR_LOGO, true);
}

updateSceneBlizzard :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarBlizzardScene) ctx.scene;
    assert(scene != null);
    // assert(scene.type == WarSceneType.Blizzard);

    scene.time -= ctx.deltaTime;

    if (scene.time <= 0) {
        nextScene := createSceneMainMenu();
        setNextScene(nextScene, 0.3);
    }
}
