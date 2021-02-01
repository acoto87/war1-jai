enterSceneBriefing :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);
    assert(ctx.scene.type == WarSceneType.Briefing);

    scene := cast(*WarBriefingScene) ctx.scene;

    if scene.race == {
        case WarRace.Humans; {
            enterSceneBriefingHumans(ctx);
        }
        case WarRace.Orcs; {
            enterSceneBriefingOrcs(ctx);
        }
        case; {
            logError("Not allowed briefing scenes for race: %\n", scene.race);
        }
    }
}

updateSceneBriefing :: (ctx: *WarContext) {
    assert(ctx != null);
    assert(ctx.scene != null);
    assert(ctx.scene.type == WarSceneType.Briefing);

    input := *ctx.input;

    scene := cast(*WarBriefingScene) ctx.scene;
    scene.time -= ctx.deltaTime;

    txtBriefing := findUIEntity(ctx, "txtBriefing");
    if (txtBriefing != null) {
        transform := getComponent(ctx, txtBriefing, WarTransformComponent);
        assert(transform != null);

        position := transform.position;
        position.y -= 10 * ctx.deltaTime;
        transform.position = position;
    }

    updateAnimations(ctx);

    if (scene.time <= 0 ||
        wasButtonPressed(input, WarMouseButtons.Left) ||
        wasKeyPressed(input, WarKeys.Enter) ||
        wasKeyPressed(input, WarKeys.Space))
    {
        nextScene := createScene(ctx, WarSceneType.MainMenu);
        setNextScene(ctx, nextScene, 0.3);

        // WarMap* map = createMap(ctx, scene.mapType);
        // setNextMap(ctx, map, 1.0f);
    }
}

#scope_file

enterSceneBriefingHumans :: (ctx: *WarContext) {
    scene := cast(*WarBriefingScene) ctx.scene;

    data := getCampaignData(scene.mapType);

    scene.time = data.briefingDuration;

    createUIImage(ctx, "imgBackground", imageResourceRef(421), VEC2_ZERO);

    animEntity := createEntity(ctx, WarEntityType.Animation);
    addTransformComponent(ctx, animEntity, VEC2_ZERO);
    addAnimationsComponent(ctx, animEntity);

    anim1 := createAnimationFromResourceIndex(ctx, "anim1", imageResourceRef(428), 0.2, true);
    anim1.offset = vec2(83, 37);
    anim1.loopDelay = 2.0;
    addAnimationFramesRange(anim1, 0, 4);
    addAnimationFramesRange(anim1, 4, 0);
    addAnimation(ctx, animEntity, anim1);

    anim2 := createAnimationFromResourceIndex(ctx, "anim2", imageResourceRef(429), 0.2, true);
    anim2.offset = vec2(207, 29);
    anim1.loopDelay = 2.0;
    addAnimationFramesRange(anim2, 0, 20);
    addAnimation(ctx, animEntity, anim2);

    anim3 := createAnimationFromResourceIndex(ctx, "anim3", imageResourceRef(430), 0.1, true);
    anim3.offset = vec2(21, 17);
    addAnimationFramesRange(anim3, 0, 20);
    addAnimation(ctx, animEntity, anim3);

    anim4 := createAnimationFromResourceIndex(ctx, "anim4", imageResourceRef(431), 0.1, true);
    anim4.offset = vec2(275, 21);
    addAnimationFramesRange(anim4, 0, 20);
    addAnimation(ctx, animEntity, anim4);

    briefingText := createUIText(ctx, "txtBriefing", 1, 10, data.briefingText, vec2(20, 160));
    setUITextColor(ctx, briefingText, rgbColor(255, 215, 138));
    setUITextMultiline(ctx, briefingText, true);
    setUITextBoundings(ctx, briefingText, vec2(ctx.originalWindowWidth - 40, 200));
    setUITextHorizontalAlign(ctx, briefingText, WarTextAlignment.Left);
    setUITextVerticalAlign(ctx, briefingText, WarTextAlignment.Top);
    setUITextLineAlign(ctx, briefingText, WarTextAlignment.Left);
    setUITextWrapping(ctx, briefingText, WarTextWrapping.Char);
    setUITextLineHeight(ctx, briefingText, 150);

    if (!isDemo(ctx)) {
        // createAudio(context, data.briefingAudioId, false);
    }
}

enterSceneBriefingOrcs :: (ctx: *WarContext) {
    scene := cast(*WarBriefingScene) ctx.scene;

    data := getCampaignData(scene.mapType);

    scene.time = data.briefingDuration;

    createUIImage(ctx, "imgBackground", imageResourceRef(422), VEC2_ZERO);

    animEntity := createEntity(ctx, WarEntityType.Animation);
    addTransformComponent(ctx, animEntity, VEC2_ZERO);
    addAnimationsComponent(ctx, animEntity);

    anim1 := createAnimationFromResourceIndex(ctx, "anim1", imageResourceRef(426), 0.2, true);
    anim1.offset = vec2(18, 67);
    anim1.loopDelay = 2.0;
    addAnimationFramesRange(anim1, 0, 4);
    addAnimationFramesRange(anim1, 4, 0);
    addAnimation(ctx, animEntity, anim1);

    anim2 := createAnimationFromResourceIndex(ctx, "anim2", imageResourceRef(427), 0.2, true);
    anim2.offset = vec2(202, 52);
    anim1.loopDelay = 2.0;
    addAnimationFramesRange(anim2, 0, 4);
    addAnimationFramesRange(anim2, 4, 0);
    addAnimation(ctx, animEntity, anim2);

    if (!isDemo(ctx)) {
        anim3 := createAnimationFromResourceIndex(ctx, "anim3", imageResourceRef(425), 0.1, true);
        anim3.offset = vec2(140, 66);
        addAnimationFramesRange(anim3, 0, 30);
        addAnimation(ctx, animEntity, anim3);
    }

    briefingText := createUIText(ctx, "txtBriefing", 1, 10, data.briefingText, vec2(20, 160));
    setUITextColor(ctx, briefingText, rgbColor(255, 215, 138));
    setUITextMultiline(ctx, briefingText, true);
    setUITextBoundings(ctx, briefingText, vec2(ctx.originalWindowWidth - 40, 200));
    setUITextHorizontalAlign(ctx, briefingText, WarTextAlignment.Left);
    setUITextVerticalAlign(ctx, briefingText, WarTextAlignment.Top);
    setUITextLineAlign(ctx, briefingText, WarTextAlignment.Left);
    setUITextWrapping(ctx, briefingText, WarTextWrapping.Char);
    setUITextLineHeight(ctx, briefingText, 150);

    if (!isDemo(ctx)) {
        // createAudio(ctx, data.briefingAudioId, false);
    }
}