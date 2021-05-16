


isRetail :: inline () -> bool {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    return ctx.warFile.type == WarFileType.Retail;
}

isDemo :: inline () -> bool {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    return ctx.warFile.type == WarFileType.Demo;
}

initWarGame :: () -> bool {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!initGame("War 1", vec2i(320, 200), 3, 1)) {
        logError("Couldn't init the game context\n");
        return false;
    }

    // load fonts
    fontsData[0].sprite = loadSprite("./war1_font_1.png");
    ctx.fonts[0] = fontsData[0];

    fontsData[1].sprite = loadSprite("./war1_font_2.png");
    ctx.fonts[1] = fontsData[1];

    // check if the DATA.WAR file exists
    dataFileExists := access(DATAWAR_FILE_PATH, 4) == 0;
    if (dataFileExists) {
        // load DATA.WAR file
        if (!loadDataFile()) {
            logError("Could not load DATA.WAR file\n");
            return false;
        }

        scene := createSceneBlizzard();
        setNextScene(scene, 0.0);
    }
    // else
    // {
    //     WarScene* scene = createScene(WAR_SCENE_DOWNLOAD);
    //     setNextScene(scene, 0.0f);
    // }

    return true;
}

loadDataFile :: () -> bool {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    ctx.warFile = loadWarFile(DATAWAR_FILE_PATH);
    if (ctx.warFile == null) {
        return false;
    }

    for * entry : assets {
        loadResource(entry);
    }

    return true;
}

#scope_file

