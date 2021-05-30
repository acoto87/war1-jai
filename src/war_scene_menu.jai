createSceneMainMenu :: () -> *WarMenuScene {
    scene := createScene(WarMenuScene);
    scene.enterSceneFn = enterSceneMainMenu;
    return scene;
}

enterSceneMainMenu :: () {
    createMainMenu();
    createSinglePlayerMenu();
    createLoadMenu();
    createCustomGameMenu();

    initCheatsPanel();
    registerBuiltInCheats();
    registerCheats();

    createUICursor("cursor", WarCursorType.Arrow, VEC2_ZERO);

    if (!isDemo()) {
        // createAudio(WAR_MUSIC_00, true);
    }
}

createMainMenu :: () {
    invalidRef := invalidResourceRef();
    mediumNormalRef := imageResourceRef(239);
    mediumPressedRef := imageResourceRef(240);

    uiEntity := createUIImage("imgMenuBackground", imageResourceRef(261), VEC2_ZERO);

    uiEntity = createUITextButton(
        "btnMenuSinglePlayer",
        1, 10, "Start a new game",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 85));
    setUIButtonClickHandler(uiEntity, handleMenuSinglePlayer);
    setUIButtonHotKey(uiEntity, Keys.S);
    setUITextHighlight(uiEntity, 0, 1);

    uiEntity = createUITextButton(
        "btnMenuLoad",
        1, 10, "Load existing game",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 105));
    setUIButtonHotKey(uiEntity, Keys.L);
    setUITextHighlight(uiEntity, 0, 1);

    uiEntity = createUITextButton(
        "btnMenuReplayIntro",
        1, 10, "Replay introduction",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 125));
    setUIButtonHotKey(uiEntity, Keys.R);
    setUITextHighlight(uiEntity, 0, 1);

    uiEntity = createUITextButton(
        "btnMenuQuit",
        1, 10, "Quit",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 165));
    setUIButtonClickHandler(uiEntity, handleMenuQuit);
    setUIButtonHotKey(uiEntity, Keys.Q);
    setUITextHighlight(uiEntity, 0, 1);
}

createSinglePlayerMenu :: () {
    invalidRef := invalidResourceRef();
    mediumNormalRef := imageResourceRef(239);
    mediumPressedRef := imageResourceRef(240);
    smallNormalRef := imageResourceRef(241);
    smallPressedRef := imageResourceRef(242);

    uiEntity := createUITextButton(
        "btnSinglePlayerOrc",
        1, 10, "Orc campaign",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 85));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleSinglePlayerOrc);
    setUIButtonHotKey(uiEntity, Keys.O);
    setUITextHighlight(uiEntity, 0, 1);

    uiEntity = createUITextButton(
        "btnSinglePlayerHuman",
        1, 10, "Human campaign",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 105));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleSinglePlayerHuman);
    setUIButtonHotKey(uiEntity, Keys.H);
    setUITextHighlight(uiEntity, 0, 1);

    uiEntity = createUITextButton(
        "btnCustomGame",
        1, 10, "Custom game",
        mediumNormalRef,
        mediumPressedRef,
        invalidRef,
        vec2(104, 125));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleCustomGame);
    setUIButtonHotKey(uiEntity, Keys.U);
    setUITextHighlight(uiEntity, 1, 1);

    uiEntity = createUITextButton(
        "btnSinglePlayerCancel",
        1, 10, "Cancel",
        smallNormalRef,
        smallPressedRef,
        invalidRef,
        vec2(133, 165));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleSinglePlayerCancel);
    setUIButtonHotKey(uiEntity, Keys.C);
    setUITextHighlight(uiEntity, 0, 1);
}

createLoadMenu :: () {
}

createCustomGameMenu :: () {
    invalidRef := invalidResourceRef();
    smallNormalRef := imageResourceRef(241);
    smallPressedRef := imageResourceRef(242);
    leftArrowNormalRef := imageResourceRef(244);
    leftArrowPressedRef := imageResourceRef(245);
    rightArrowNormalRef := imageResourceRef(246);
    rightArrowPressedRef := imageResourceRef(247);

    uiEntity := createUIText(
        "txtYourRaceLabel",
        1, 10, "Your race:",
        vec2(40, 105));
    setUIEntityStatus(uiEntity, false);
    setUITextBoundings(uiEntity, vec2(100, 12));
    setUITextHorizontalAlign(uiEntity, TextAlignment.Right);
    setUITextVerticalAlign(uiEntity, TextAlignment.Middle);

    uiEntity = createUIText(
        "txtEnemyRaceLabel",
        1, 10, "Enemy race:",
        vec2(40, 125));
    setUIEntityStatus(uiEntity, false);
    setUITextBoundings(uiEntity, vec2(100, 12));
    setUITextHorizontalAlign(uiEntity, TextAlignment.Right);
    setUITextVerticalAlign(uiEntity, TextAlignment.Middle);

    uiEntity = createUIText(
        "txtMapLabel",
        1, 10, "Map:",
        vec2(40, 145));
    setUIEntityStatus(uiEntity, false);
    setUITextBoundings(uiEntity, vec2(100, 12));
    setUITextHorizontalAlign(uiEntity, TextAlignment.Right);
    setUITextVerticalAlign(uiEntity, TextAlignment.Middle);

    uiEntity = createUIText(
        "txtYourRace",
        1, 10, "Human",
        vec2(180, 105));
    setUIEntityStatus(uiEntity, false);
    setUITextBoundings(uiEntity, vec2(50, 12));
    setUITextHorizontalAlign(uiEntity, TextAlignment.Center);
    setUITextVerticalAlign(uiEntity, TextAlignment.Middle);

    uiEntity = createUIText(
        "txtEnemyRace",
        1, 10, "Orc",
        vec2(180, 125));
    setUIEntityStatus(uiEntity, false);
    setUITextBoundings(uiEntity, vec2(50, 12));
    setUITextHorizontalAlign(uiEntity, TextAlignment.Center);
    setUITextVerticalAlign(uiEntity, TextAlignment.Middle);

    uiEntity = createUIText(
        "txtMap",
        1, 10, "147",
        vec2(180, 145));
    setUIEntityStatus(uiEntity, false);
    setUITextBoundings(uiEntity, vec2(50, 12));
    setUITextHorizontalAlign(uiEntity, TextAlignment.Center);
    setUITextVerticalAlign(uiEntity, TextAlignment.Middle);

    uiEntity = createUIImageButton(
        "btnYourRaceLeft",
        leftArrowNormalRef,
        leftArrowPressedRef,
        invalidRef,
        vec2(160, 103));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleYourRaceLeft);

    uiEntity = createUIImageButton(
        "btnYourRaceRight",
        rightArrowNormalRef,
        rightArrowPressedRef,
        invalidRef,
        vec2(235, 103));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleYourRaceRight);

    uiEntity = createUIImageButton(
        "btnEnemyRaceLeft",
        leftArrowNormalRef,
        leftArrowPressedRef,
        invalidRef,
        vec2(160, 123));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleEnemyRaceLeft);

    uiEntity = createUIImageButton(
        "btnEnemyRaceRight",
        rightArrowNormalRef,
        rightArrowPressedRef,
        invalidRef,
        vec2(235, 123));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleEnemyRaceRight);

    uiEntity = createUIImageButton(
        "btnMapLeft",
        leftArrowNormalRef,
        leftArrowPressedRef,
        invalidRef,
        vec2(160, 143));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleMapLeft);

    uiEntity = createUIImageButton(
        "btnMapRight",
        rightArrowNormalRef,
        rightArrowPressedRef,
        invalidRef,
        vec2(235, 143));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleMapRight);

    uiEntity = createUITextButton(
        "btnCustomGameOk",
        1, 10, "Ok",
        smallNormalRef,
        smallPressedRef,
        invalidRef,
        vec2(100, 165));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleCustomGameOk);
    setUIButtonHotKey(uiEntity, Keys.O);
    setUITextHighlight(uiEntity, 0, 1);

    uiEntity = createUITextButton(
        "btnCustomGameCancel",
        1, 10, "Cancel",
        smallNormalRef,
        smallPressedRef,
        invalidRef,
        vec2(180, 165));
    setUIEntityStatus(uiEntity, false);
    setUIButtonClickHandler(uiEntity, handleMenuSinglePlayer);
    setUIButtonHotKey(uiEntity, Keys.C);
    setUITextHighlight(uiEntity, 0, 1);
}

showOrHideMainMenu :: (status: bool) {
    setUIEntityStatusByName("btnMenuSinglePlayer", status);
    setUIEntityStatusByName("btnMenuLoad", status);
    setUIEntityStatusByName("btnMenuReplayIntro", status);
    setUIEntityStatusByName("btnMenuQuit", status);
}

showOrHideSinglePlayer :: (status: bool) {
    setUIEntityStatusByName("btnSinglePlayerOrc", status);
    setUIEntityStatusByName("btnSinglePlayerHuman", status);
    setUIEntityStatusByName("btnCustomGame", status);
    setUIEntityStatusByName("btnSinglePlayerCancel", status);
}

showOrHideCustomGame :: (status: bool) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarMenuScene) ctx.scene;
    assert(scene != null);

    setUIEntityStatusByName("txtYourRaceLabel", status);
    setUIEntityStatusByName("txtEnemyRaceLabel", status);
    setUIEntityStatusByName("txtMapLabel", status);
    setUIEntityStatusByName("txtYourRace", status);
    setUIEntityStatusByName("txtEnemyRace", status);
    setUIEntityStatusByName("txtMap", status);
    setUIEntityStatusByName("btnYourRaceLeft", status);
    setUIEntityStatusByName("btnYourRaceRight", status);
    setUIEntityStatusByName("btnEnemyRaceLeft", status);
    setUIEntityStatusByName("btnEnemyRaceRight", status);
    setUIEntityStatusByName("btnMapLeft", status);
    setUIEntityStatusByName("btnMapRight", status);
    setUIEntityStatusByName("btnCustomGameOk", status);
    setUIEntityStatusByName("btnCustomGameCancel", status);

    if (status) {
        scene.yourRace = WarRace.Humans;
        scene.enemyRace = WarRace.Orcs;
        scene.customMap = 147;

        setUIRaceValueByName("txtYourRace", scene.yourRace);
        setUIRaceValueByName("txtEnemyRace", scene.enemyRace);
        setCustomMapValueByName("txtMap", scene.customMap);
    }
}

// menu button handlers
handleMenuSinglePlayer :: (entity: *Entity) {
    showOrHideMainMenu(false);
    showOrHideSinglePlayer(true);
    showOrHideCustomGame(false);
}

handleMenuQuit :: (entity: *Entity) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    glfwSetWindowShouldClose(ctx.window, 1);
}

handleSinglePlayerOrc :: (entity: *Entity) {
    scene := createSceneBriefing(WarRace.Orcs, WarCampaignMapType.Orcs01);
    setNextScene(scene, 1.0);
}

handleSinglePlayerHuman :: (entity: *Entity) {
    scene := createSceneBriefing(WarRace.Humans, WarCampaignMapType.Humans01);
    setNextScene(scene, 1.0);
}

handleCustomGame :: (entity: *Entity) {
    showOrHideMainMenu(false);
    showOrHideSinglePlayer(false);
    showOrHideCustomGame(true);
}

handleSinglePlayerCancel :: (entity: *Entity) {
    showOrHideMainMenu(true);
    showOrHideSinglePlayer(false);
    showOrHideCustomGame(false);
}

handleYourRaceLeft :: (entity: *Entity) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarMenuScene) ctx.scene;
    assert(scene != null);

    if (scene.yourRace > WarRace.Neutral) {
        scene.yourRace = cast(WarRace) (cast(s32) scene.yourRace - 1);
        setUIRaceValueByName("txtYourRace", scene.yourRace);
    }
}

handleYourRaceRight :: (entity: *Entity) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarMenuScene) ctx.scene;
    assert(scene != null);

    if (scene.yourRace < WarRace.Orcs) {
        scene.yourRace = cast(WarRace) (cast(s32) scene.yourRace + 1);
        setUIRaceValueByName("txtYourRace", scene.yourRace);
    }
}

handleEnemyRaceLeft :: (entity: *Entity) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarMenuScene) ctx.scene;
    assert(scene != null);

    if (scene.enemyRace > WarRace.Neutral) {
        scene.enemyRace = cast(WarRace) (cast(s32) scene.enemyRace - 1);
        setUIRaceValueByName("txtEnemyRace", scene.enemyRace);
    }
}

handleEnemyRaceRight :: (entity: *Entity) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarMenuScene) ctx.scene;
    assert(scene != null);

    if (scene.enemyRace < WarRace.Orcs) {
        scene.enemyRace = cast(WarRace) (cast(s32) scene.enemyRace + 1);
        setUIRaceValueByName("txtEnemyRace", scene.enemyRace);
    }
}

handleMapLeft :: (entity: *Entity) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarMenuScene) ctx.scene;
    assert(scene != null);

    if (scene.customMap > 147) {
        scene.customMap -= 1;
        setCustomMapValueByName("txtMap", scene.customMap);
    }
}

handleMapRight :: (entity: *Entity) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarMenuScene) ctx.scene;
    assert(scene != null);

    if (scene.customMap < 188) {
        scene.customMap += 1;
        setCustomMapValueByName("txtMap", scene.customMap);
    }
}

handleCustomGameOk :: (entity: *Entity) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    scene := cast(*WarMenuScene) ctx.scene;
    assert(scene != null);

    // map := createCustomMap(scene.customMap, scene.yourRace, scene.enemyRace);
    // setNextMap(map, 1.0);
}

#scope_file

setUIRaceValueByName :: (name: string, value: WarRace) {
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

    entity := findUIEntity(name);
    if (entity != null) {
        raceStr := getCustomGameRaceStr(value);
        setUIText(entity, raceStr);
        setUITextHighlight(entity, NO_HIGHLIGHT, 0);
    }
}

setCustomMapValueByName :: (name: string, value: s32) {
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

    entity := findUIEntity(name);
    if (entity != null) {
        customMapStr := getCustomMapStr(value);
        setUIText(entity, customMapStr);
        setUITextHighlight(entity, NO_HIGHLIGHT, 0);
    }
}