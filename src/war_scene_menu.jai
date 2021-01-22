enterSceneMainMenu :: (ctx: *WarContext) {
    createMainMenu(ctx);
    createSinglePlayerMenu(ctx);
    createLoadMenu(ctx);
    createCustomGameMenu(ctx);
    // createCheatsPanel(ctx);

    createUICursor(ctx, "cursor", WarCursorType.Arrow, VEC2_ZERO);

    // if (!isDemo(ctx)) {
    //     createAudio(ctx, WAR_MUSIC_00, true);
    // }
}

createMainMenu :: (ctx: *WarContext) {
    invalidRef := invalidResourceRef();
    mediumNormalRef := imageResourceRef(239);
    mediumPressedRef := imageResourceRef(240);

    uiEntity := createUIImage(ctx, "imgMenuBackground", imageResourceRef(261), VEC2_ZERO);

    uiEntity = createUITextButton(
        ctx, "btnMenuSinglePlayer",
        1, 10, "Start a new game",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 85));
    setUIButtonClickHandler(ctx, uiEntity, handleMenuSinglePlayer);
    setUIButtonHotKey(ctx, uiEntity, WarKeys.S);
    setUITextHighlight(ctx, uiEntity, 0, 1);

    uiEntity = createUITextButton(
        ctx, "btnMenuLoad",
        1, 10, "Load existing game",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 105));
    setUIButtonHotKey(ctx, uiEntity, WarKeys.L);
    setUITextHighlight(ctx, uiEntity, 0, 1);

    uiEntity = createUITextButton(
        ctx, "btnMenuReplayIntro",
        1, 10, "Replay introduction",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 125));
    setUIButtonHotKey(ctx, uiEntity, WarKeys.R);
    setUITextHighlight(ctx, uiEntity, 0, 1);

    uiEntity = createUITextButton(
        ctx, "btnMenuQuit",
        1, 10, "Quit",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 165));
    setUIButtonClickHandler(ctx, uiEntity, handleMenuQuit);
    setUIButtonHotKey(ctx, uiEntity, WarKeys.Q);
    setUITextHighlight(ctx, uiEntity, 0, 1);
}

createSinglePlayerMenu :: (ctx: *WarContext) {
    invalidRef := invalidResourceRef();
    mediumNormalRef := imageResourceRef(239);
    mediumPressedRef := imageResourceRef(240);
    smallNormalRef := imageResourceRef(241);
    smallPressedRef := imageResourceRef(242);

    uiEntity := createUITextButton(
        ctx, "btnSinglePlayerOrc",
        1, 10, "Orc campaign",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 85));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleSinglePlayerOrc);
    setUIButtonHotKey(ctx, uiEntity, WarKeys.O);
    setUITextHighlight(ctx, uiEntity, 0, 1);

    uiEntity = createUITextButton(
        ctx, "btnSinglePlayerHuman",
        1, 10, "Human campaign",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 105));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleSinglePlayerHuman);
    setUIButtonHotKey(ctx, uiEntity, WarKeys.H);
    setUITextHighlight(ctx, uiEntity, 0, 1);

    uiEntity = createUITextButton(
        ctx, "btnCustomGame",
        1, 10, "Custom game",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 125));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleCustomGame);
    setUIButtonHotKey(ctx, uiEntity, WarKeys.U);
    setUITextHighlight(ctx, uiEntity, 1, 1);

    uiEntity = createUITextButton(
        ctx, "btnSinglePlayerCancel",
        1, 10, "Cancel",
        smallNormalRef,
        smallPressedRef,
        invalidRef,
        vec2(133, 165));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleSinglePlayerCancel);
    setUIButtonHotKey(ctx, uiEntity, WarKeys.C);
    setUITextHighlight(ctx, uiEntity, 0, 1);
}

createLoadMenu :: (ctx: *WarContext) {
}

createCustomGameMenu :: (ctx: *WarContext) {
    invalidRef := invalidResourceRef();
    smallNormalRef := imageResourceRef(241);
    smallPressedRef := imageResourceRef(242);
    leftArrowNormalRef := imageResourceRef(244);
    leftArrowPressedRef := imageResourceRef(245);
    rightArrowNormalRef := imageResourceRef(246);
    rightArrowPressedRef := imageResourceRef(247);

    uiEntity := createUIText(
        ctx, "txtYourRaceLabel",
        1, 10, "Your race:",
        vec2(40, 105));
    setUIEntityStatus(ctx, uiEntity, false);
    setUITextBoundings(ctx, uiEntity, vec2(100, 12));
    setUITextHorizontalAlign(ctx, uiEntity, WarTextAlignment.Right);
    setUITextVerticalAlign(ctx, uiEntity, WarTextAlignment.Middle);

    uiEntity = createUIText(
        ctx, "txtEnemyRaceLabel",
        1, 10, "Enemy race:",
        vec2(40, 125));
    setUIEntityStatus(ctx, uiEntity, false);
    setUITextBoundings(ctx, uiEntity, vec2(100, 12));
    setUITextHorizontalAlign(ctx, uiEntity, WarTextAlignment.Right);
    setUITextVerticalAlign(ctx, uiEntity, WarTextAlignment.Middle);

    uiEntity = createUIText(
        ctx, "txtMapLabel",
        1, 10, "Map:",
        vec2(40, 145));
    setUIEntityStatus(ctx, uiEntity, false);
    setUITextBoundings(ctx, uiEntity, vec2(100, 12));
    setUITextHorizontalAlign(ctx, uiEntity, WarTextAlignment.Right);
    setUITextVerticalAlign(ctx, uiEntity, WarTextAlignment.Middle);

    uiEntity = createUIText(
        ctx, "txtYourRace",
        1, 10, "Human",
        vec2(180, 105));
    setUIEntityStatus(ctx, uiEntity, false);
    setUITextBoundings(ctx, uiEntity, vec2(50, 12));
    setUITextHorizontalAlign(ctx, uiEntity, WarTextAlignment.Center);
    setUITextVerticalAlign(ctx, uiEntity, WarTextAlignment.Middle);

    uiEntity = createUIText(
        ctx, "txtEnemyRace",
        1, 10, "Orc",
        vec2(180, 125));
    setUIEntityStatus(ctx, uiEntity, false);
    setUITextBoundings(ctx, uiEntity, vec2(50, 12));
    setUITextHorizontalAlign(ctx, uiEntity, WarTextAlignment.Center);
    setUITextVerticalAlign(ctx, uiEntity, WarTextAlignment.Middle);

    uiEntity = createUIText(
        ctx, "txtMap",
        1, 10, "147",
        vec2(180, 145));
    setUIEntityStatus(ctx, uiEntity, false);
    setUITextBoundings(ctx, uiEntity, vec2(50, 12));
    setUITextHorizontalAlign(ctx, uiEntity, WarTextAlignment.Center);
    setUITextVerticalAlign(ctx, uiEntity, WarTextAlignment.Middle);

    uiEntity = createUIImageButton(
        ctx, "btnYourRaceLeft",
        leftArrowNormalRef,
        leftArrowPressedRef,
        invalidRef,
        vec2(160, 103));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleYourRaceLeft);

    uiEntity = createUIImageButton(
        ctx, "btnYourRaceRight",
        rightArrowNormalRef,
        rightArrowPressedRef,
        invalidRef,
        vec2(235, 103));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleYourRaceRight);

    uiEntity = createUIImageButton(
        ctx, "btnEnemyRaceLeft",
        leftArrowNormalRef,
        leftArrowPressedRef,
        invalidRef,
        vec2(160, 123));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleEnemyRaceLeft);

    uiEntity = createUIImageButton(
        ctx, "btnEnemyRaceRight",
        rightArrowNormalRef,
        rightArrowPressedRef,
        invalidRef,
        vec2(235, 123));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleEnemyRaceRight);

    uiEntity = createUIImageButton(
        ctx, "btnMapLeft",
        leftArrowNormalRef,
        leftArrowPressedRef,
        invalidRef,
        vec2(160, 143));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleMapLeft);

    uiEntity = createUIImageButton(
        ctx, "btnMapRight",
        rightArrowNormalRef,
        rightArrowPressedRef,
        invalidRef,
        vec2(235, 143));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleMapRight);

    uiEntity = createUITextButton(
        ctx, "btnCustomGameOk",
        1, 10, "Ok",
        smallNormalRef,
        smallPressedRef,
        invalidRef,
        vec2(100, 165));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleCustomGameOk);
    setUIButtonHotKey(ctx, uiEntity, WarKeys.O);
    setUITextHighlight(ctx, uiEntity, 0, 1);

    uiEntity = createUITextButton(
        ctx, "btnCustomGameCancel",
        1, 10, "Cancel",
        smallNormalRef,
        smallPressedRef,
        invalidRef,
        vec2(180, 165));
    setUIEntityStatus(ctx, uiEntity, false);
    setUIButtonClickHandler(ctx, uiEntity, handleMenuSinglePlayer);
    setUIButtonHotKey(ctx, uiEntity, WarKeys.C);
    setUITextHighlight(ctx, uiEntity, 0, 1);
}

showOrHideMainMenu :: (ctx: *WarContext, status: bool) {
    setUIEntityStatusByName(ctx, "btnMenuSinglePlayer", status);
    setUIEntityStatusByName(ctx, "btnMenuLoad", status);
    setUIEntityStatusByName(ctx, "btnMenuReplayIntro", status);
    setUIEntityStatusByName(ctx, "btnMenuQuit", status);
}

showOrHideSinglePlayer :: (ctx: *WarContext, status: bool) {
    setUIEntityStatusByName(ctx, "btnSinglePlayerOrc", status);
    setUIEntityStatusByName(ctx, "btnSinglePlayerHuman", status);
    setUIEntityStatusByName(ctx, "btnCustomGame", status);
    setUIEntityStatusByName(ctx, "btnSinglePlayerCancel", status);
}

showOrHideCustomGame :: (ctx: *WarContext, status: bool) {
    scene := cast(*WarMenuScene) ctx.scene;

    setUIEntityStatusByName(ctx, "txtYourRaceLabel", status);
    setUIEntityStatusByName(ctx, "txtEnemyRaceLabel", status);
    setUIEntityStatusByName(ctx, "txtMapLabel", status);
    setUIEntityStatusByName(ctx, "txtYourRace", status);
    setUIEntityStatusByName(ctx, "txtEnemyRace", status);
    setUIEntityStatusByName(ctx, "txtMap", status);
    setUIEntityStatusByName(ctx, "btnYourRaceLeft", status);
    setUIEntityStatusByName(ctx, "btnYourRaceRight", status);
    setUIEntityStatusByName(ctx, "btnEnemyRaceLeft", status);
    setUIEntityStatusByName(ctx, "btnEnemyRaceRight", status);
    setUIEntityStatusByName(ctx, "btnMapLeft", status);
    setUIEntityStatusByName(ctx, "btnMapRight", status);
    setUIEntityStatusByName(ctx, "btnCustomGameOk", status);
    setUIEntityStatusByName(ctx, "btnCustomGameCancel", status);

    if (status) {
        scene.yourRace = WarRace.Humans;
        scene.enemyRace = WarRace.Orcs;
        scene.customMap = 147;

        setUIRaceValueByName(ctx, "txtYourRace", scene.yourRace);
        setUIRaceValueByName(ctx, "txtEnemyRace", scene.enemyRace);
        setCustomMapValueByName(ctx, "txtMap", scene.customMap);
    }
}

// menu button handlers
handleMenuSinglePlayer :: (ctx: *WarContext, entity: *WarEntity) {
    showOrHideMainMenu(ctx, false);
    showOrHideSinglePlayer(ctx, true);
    showOrHideCustomGame(ctx, false);
}

handleMenuQuit :: (ctx: *WarContext, entity: *WarEntity) {
    glfwSetWindowShouldClose(ctx.window, 1);
}

handleSinglePlayerOrc :: (ctx: *WarContext, entity: *WarEntity) {
    // scene := createScene(ctx, WarBriefingScene);
    // scene.race = WarRace.Orcs;
    // scene.mapType = WarCampaignMapType.Orcs01;
    // setNextScene(ctx, scene, 1.0);
}

handleSinglePlayerHuman :: (ctx: *WarContext, entity: *WarEntity) {
    // scene := createScene(ctx, WarBriefingScene);
    // scene.race = WarRace.Humans;
    // scene.mapType = WarCampaignMapType.Humans01;
    // setNextScene(ctx, scene, 1.0);
}

handleCustomGame :: (ctx: *WarContext, entity: *WarEntity) {
    showOrHideMainMenu(ctx, false);
    showOrHideSinglePlayer(ctx, false);
    showOrHideCustomGame(ctx, true);
}

handleSinglePlayerCancel :: (ctx: *WarContext, entity: *WarEntity) {
    showOrHideMainMenu(ctx, true);
    showOrHideSinglePlayer(ctx, false);
    showOrHideCustomGame(ctx, false);
}

handleYourRaceLeft :: (ctx: *WarContext, entity: *WarEntity) {
    scene := cast(*WarMenuScene) ctx.scene;

    if (scene.yourRace > WarRace.Neutral) {
        scene.yourRace = cast(WarRace) (cast(s32) scene.yourRace - 1);
        setUIRaceValueByName(ctx, "txtYourRace", scene.yourRace);
    }
}

handleYourRaceRight :: (ctx: *WarContext, entity: *WarEntity) {
    scene := cast(*WarMenuScene) ctx.scene;

    if (scene.yourRace < WarRace.Orcs) {
        scene.yourRace = cast(WarRace) (cast(s32) scene.yourRace + 1);
        setUIRaceValueByName(ctx, "txtYourRace", scene.yourRace);
    }
}

handleEnemyRaceLeft :: (ctx: *WarContext, entity: *WarEntity) {
    scene := cast(*WarMenuScene) ctx.scene;

    if (scene.enemyRace > WarRace.Neutral) {
        scene.enemyRace = cast(WarRace) (cast(s32) scene.enemyRace - 1);
        setUIRaceValueByName(ctx, "txtEnemyRace", scene.enemyRace);
    }
}

handleEnemyRaceRight :: (ctx: *WarContext, entity: *WarEntity) {
    scene := cast(*WarMenuScene) ctx.scene;

    if (scene.enemyRace < WarRace.Orcs) {
        scene.enemyRace = cast(WarRace) (cast(s32) scene.enemyRace + 1);
        setUIRaceValueByName(ctx, "txtEnemyRace", scene.enemyRace);
    }
}

handleMapLeft :: (ctx: *WarContext, entity: *WarEntity) {
    scene := cast(*WarMenuScene) ctx.scene;

    if (scene.customMap > 147) {
        scene.customMap -= 1;
        setCustomMapValueByName(ctx, "txtMap", scene.customMap);
    }
}

handleMapRight :: (ctx: *WarContext, entity: *WarEntity) {
    scene := cast(*WarMenuScene) ctx.scene;

    if (scene.customMap < 188) {
        scene.customMap += 1;
        setCustomMapValueByName(ctx, "txtMap", scene.customMap);
    }
}

handleCustomGameOk :: (ctx: *WarContext, entity: *WarEntity) {
    scene := cast(*WarMenuScene) ctx.scene;

    // map := createCustomMap(ctx, scene.customMap, scene.yourRace, scene.enemyRace);
    // setNextMap(ctx, map, 1.0);
}

#scope_file

setUIRaceValueByName :: (ctx: *WarContext, name: string, value: WarRace) {
    getCustomGameRaceStr :: (race: WarRace) -> string {
        if race ==  {
            case WarRace.Neutral; return "Random";
            case WarRace.Humans; return "Human";
            case WarRace.Orcs; return "Orc";

            case; {
                logError("Wrong value for a race: %\n", race);
                return "<error>";
            }
        }
    }

    entity := findUIEntity(ctx, name);
    if (entity != null) {
        raceStr := getCustomGameRaceStr(value);
        setUIText(ctx, entity, raceStr);
        setUITextHighlight(ctx,entity, NO_HIGHLIGHT, 0);
    }
}

setCustomMapValueByName :: (ctx: *WarContext, name: string, value: s32) {
    getCustomMapStr :: (value: s32) -> string {
        if value == {
            case 147; return "Forest 1";
            case 148; return "Forest 2";
            case 149; return "Forest 3";
            case 150; return "Forest 4";
            case 151; return "Forest 5";
            case 152; return "Forest 6";
            case 153; return "Forest 7";
            case 154; return "Swamp 6";
            case 155; return "Swamp 7";
            case 156; return "Swamp 1";
            case 157; return "Swamp 2";
            case 158; return "Swamp 3";
            case 159; return "Swamp 4";
            case 160; return "Swamp 5";
            case 161; return "Dungeon 1";
            case 162; return "Dungeon 2";
            case 163; return "Dungeon 3";
            case 164; return "Dungeon 4";
            case 165; return "Dungeon 5";
            case 166; return "Dungeon 6";
            case 167; return "Dungeon 7";

            case 168; return "Forest 1.1";
            case 169; return "Forest 2.1";
            case 170; return "Forest 3.1";
            case 171; return "Forest 4.1";
            case 172; return "Forest 5.1";
            case 173; return "Forest 6.1";
            case 174; return "Forest 7.1";
            case 175; return "Swamp 6.1";
            case 176; return "Swamp 7.1";
            case 177; return "Swamp 1.1";
            case 178; return "Swamp 2.1";
            case 179; return "Swamp 3.1";
            case 180; return "Swamp 4.1";
            case 181; return "Swamp 5.1";
            case 182; return "Dungeon 1.1";
            case 183; return "Dungeon 2.1";
            case 184; return "Dungeon 3.1";
            case 185; return "Dungeon 4.1";
            case 186; return "Dungeon 5.1";
            case 187; return "Dungeon 6.1";
            case 188; return "Dungeon 7.1";

            case; {
                logError("Wrong value for a custom map: %\n", value);
                return "<error>";
            }
        }
    }

    entity := findUIEntity(ctx, name);
    if (entity != null) {
        customMapStr := getCustomMapStr(value);
        setUIText(ctx, entity, customMapStr);
        setUITextHighlight(ctx, entity, NO_HIGHLIGHT, 0);
    }
}