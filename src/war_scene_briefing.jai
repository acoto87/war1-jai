createSceneBriefing :: () -> *WarBriefingScene {
    scene := createScene(WarBriefingScene);
    scene.enterSceneFn = enterSceneBriefing;
    scene.updateSceneFn = updateSceneBriefing;
    return scene;
}

enterSceneBriefing :: () {
    ctx := cast(*WarContext) context.gameContext;

    assert(ctx != null);
    assert(ctx.scene != null);
    // assert(ctx.scene.type == WarSceneType.Briefing);

    scene := cast(*WarBriefingScene) ctx.scene;

    if scene.race == {
        case WarRace.Humans; {
            enterSceneBriefingHumans();
        }
        case WarRace.Orcs; {
            enterSceneBriefingOrcs();
        }
        case; {
            logError("Not allowed briefing scenes for race: %\n", scene.race);
        }
    }
}

updateSceneBriefing :: () {
    ctx := cast(*WarContext) context.gameContext;

    assert(ctx != null);
    assert(ctx.scene != null);
    // assert(ctx.scene.type == WarSceneType.Briefing);

    scene := cast(*WarBriefingScene) ctx.scene;
    scene.time -= ctx.deltaTime;

    txtBriefing := findUIEntity("txtBriefing");
    if (txtBriefing != null) {
        transform := getComponent(txtBriefing, TransformComponent);
        assert(transform != null);

        position := transform.position;
        position.y -= 10 * ctx.deltaTime;
        transform.position = position;
    }

    updateAnimations();

    if (scene.time <= 0 ||
        wasButtonPressed(MouseButtons.Left) ||
        wasKeyPressed(Keys.Enter) ||
        wasKeyPressed(Keys.Space))
    {
        nextScene := createScene(WarMenuScene);
        setNextScene(nextScene, 0.3);

        // WarMap* map = createMap(scene.mapType);
        // setNextMap(map, 1.0f);
    }
}

#scope_file

enterSceneBriefingHumans :: () {
    ctx := cast(*WarContext) context.gameContext;
    scene := cast(*WarBriefingScene) ctx.scene;

    data := getCampaignData(scene.mapType);

    scene.time = data.briefingDuration;

    createUIImage("imgBackground", imageResourceRef(421), VEC2_ZERO);

    animEntity := createEntity(EntityType.Animation);
    addTransformComponent(animEntity, VEC2_ZERO);
    addAnimationsComponent(animEntity);

    anim1 := createAnimationFromResourceIndex("anim1", imageResourceRef(428), 0.2, true);
    anim1.offset = vec2(83, 37);
    anim1.loopDelay = 2.0;
    addAnimationFramesRange(anim1, 0, 4);
    addAnimationFramesRange(anim1, 4, 0);
    addAnimation(animEntity, anim1);

    anim2 := createAnimationFromResourceIndex("anim2", imageResourceRef(429), 0.2, true);
    anim2.offset = vec2(207, 29);
    anim1.loopDelay = 2.0;
    addAnimationFramesRange(anim2, 0, 20);
    addAnimation(animEntity, anim2);

    anim3 := createAnimationFromResourceIndex("anim3", imageResourceRef(430), 0.1, true);
    anim3.offset = vec2(21, 17);
    addAnimationFramesRange(anim3, 0, 20);
    addAnimation(animEntity, anim3);

    anim4 := createAnimationFromResourceIndex("anim4", imageResourceRef(431), 0.1, true);
    anim4.offset = vec2(275, 21);
    addAnimationFramesRange(anim4, 0, 20);
    addAnimation(animEntity, anim4);

    briefingText := createUIText("txtBriefing", 1, 10, data.briefingText, vec2(20, 160));
    setUITextColor(briefingText, rgbColor(255, 215, 138));
    setUITextMultiline(briefingText, true);
    setUITextBoundings(briefingText, vec2(ctx.originalWindowSize.x - 40, 200));
    setUITextHorizontalAlign(briefingText, TextAlignment.Left);
    setUITextVerticalAlign(briefingText, TextAlignment.Top);
    setUITextLineAlign(briefingText, TextAlignment.Left);
    setUITextWrapping(briefingText, TextWrapping.Char);
    setUITextLineHeight(briefingText, 150);

    if (!isDemo()) {
        // createAudio(context, data.briefingAudioId, false);
    }
}

enterSceneBriefingOrcs :: () {
    ctx := cast(*WarContext) context.gameContext;
    scene := cast(*WarBriefingScene) ctx.scene;

    data := getCampaignData(scene.mapType);

    scene.time = data.briefingDuration;

    createUIImage("imgBackground", imageResourceRef(422), VEC2_ZERO);

    animEntity := createEntity(EntityType.Animation);
    addTransformComponent(animEntity, VEC2_ZERO);
    addAnimationsComponent(animEntity);

    anim1 := createAnimationFromResourceIndex("anim1", imageResourceRef(426), 0.2, true);
    anim1.offset = vec2(18, 67);
    anim1.loopDelay = 2.0;
    addAnimationFramesRange(anim1, 0, 4);
    addAnimationFramesRange(anim1, 4, 0);
    addAnimation(animEntity, anim1);

    anim2 := createAnimationFromResourceIndex("anim2", imageResourceRef(427), 0.2, true);
    anim2.offset = vec2(202, 52);
    anim1.loopDelay = 2.0;
    addAnimationFramesRange(anim2, 0, 4);
    addAnimationFramesRange(anim2, 4, 0);
    addAnimation(animEntity, anim2);

    if (!isDemo()) {
        anim3 := createAnimationFromResourceIndex("anim3", imageResourceRef(425), 0.1, true);
        anim3.offset = vec2(140, 66);
        addAnimationFramesRange(anim3, 0, 30);
        addAnimation(animEntity, anim3);
    }

    briefingText := createUIText("txtBriefing", 1, 10, data.briefingText, vec2(20, 160));
    setUITextColor(briefingText, rgbColor(255, 215, 138));
    setUITextMultiline(briefingText, true);
    setUITextBoundings(briefingText, vec2(ctx.originalWindowSize.x - 40, 200));
    setUITextHorizontalAlign(briefingText, TextAlignment.Left);
    setUITextVerticalAlign(briefingText, TextAlignment.Top);
    setUITextLineAlign(briefingText, TextAlignment.Left);
    setUITextWrapping(briefingText, TextWrapping.Char);
    setUITextLineHeight(briefingText, 150);

    if (!isDemo()) {
        // createAudio(data.briefingAudioId, false);
    }
}