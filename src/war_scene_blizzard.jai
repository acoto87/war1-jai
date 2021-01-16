enterSceneBlizzard :: (ctx: *WarContext) {
    scene := cast(*WarBlizzardScene) ctx.scene;
    scene.time = 3.0;

    createUIImage(context, "imgBackground", imageResourceRef(216), VEC2_ZERO);
    // createAudio(context, WAR_LOGO, true);
}

updateSceneBlizzard :: (ctx: *WarContext) {
    scene := cast(*WarBlizzardScene) ctx.scene;

    scene.time -= ctx.deltaTime;

    if (scene.time <= 0)
    {
        // WarScene* scene = createScene(context, WAR_SCENE_MAIN_MENU);
        // setNextScene(context, scene, 0.3f);
    }
}