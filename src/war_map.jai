WarLevelResult :: enum {
    None;
    Win;
    Lose;
}

WarMapSpeed :: enum s32 {
    Slowest;
    Slow;
    Normal;
    Faster;
    Fastest;
}

WarMapSettings :: struct {
    gameSpeed: WarMapSpeed;
    musicVol: s32;
    sfxVol: s32;
    mouseScrollSpeed: WarMapSpeed;
    keyScrollSpeed: WarMapSpeed;
}

WarMapTilesetType :: enum {
    Forest;
    Swamp;
    Dungeon;
}

WarMap :: struct {
    using base: WarScene;
    base.type = WarSceneType.Map;

    playing: bool;   // Indicates if the map is being played
    custom: bool;    // Indicates if the map is a custom one (not a level)
    replay: bool;    // Indicates that if the map is a replay
    observer: bool;  // Indicates if there is an observer
                    // If the map is a replay, then there is an observer.
                    // If the map is not a replay, then there can be an observer for live matches.
    uiPlayer: s32;   // Index of the player that the UI is being rendering for, by default it's 0
                    // If the map is not a replay and there is no an observer, this uiPlayer index need to be always 0
                    // If the map is a replay and/or there is an observer, this uiPlayer index can be also -1,
                    // indicating that the observer is watching everything (aka FoW is disabled)

    result: WarLevelResult;

    levelInfoIndex: s32;
    objectivesTime: f32;

    // scroll
    isScrolling: bool;
    wasScrolling: bool;

    settings: WarMapSettings;
    settings2: WarMapSettings;

    // viewport in map coordinates,
    // this is the portion of the map that the player see
    viewport: Rect;

    // panels of the ui, in screen coordinates
    leftTopPanel: Rect;
    leftBottomPanel: Rect;
    topPanel: Rect;
    bottomPanel: Rect;
    rightPanel: Rect;
    mapPanel: Rect;
    minimapPanel: Rect;
    menuPanel: Rect;
    messagePanel: Rect;
    saveLoadPanel: Rect;

    sprite: WarSprite;
    minimapSprite: WarSprite;
    blackSprite: WarSprite;

    tilesetType: WarMapTilesetType;

    selectedEntities: List(WarEntityId);

    forest: *WarEntity;
    wall: *WarEntity;
    road: *WarEntity;
    ruin: *WarEntity;

    editingTrees: bool;
    editingWalls: bool;
    editingRoads: bool;
    editingRuins: bool;
    editingRainOfFire: bool;
    addingUnit: bool;
    addingUnitType: WarUnitType;

    renderDebugGrid: bool;
    renderDebugPassable: bool;
    renderDebugPaths: bool;

    hurryUp: bool;
    fowEnabled: bool;

    finder: WarPathFinder;
    // uiCommand: WarUICommand;
    // flashStatus: WarFlashStatus;
    // cheatStatus: WarCheatStatus;

    playersCount: s32;
    players: [MAX_PLAYERS_COUNT] WarPlayerInfo;
}
