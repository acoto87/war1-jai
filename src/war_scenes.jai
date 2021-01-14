WarSceneType :: enum {
    Download;
    Blizzard;
    MainMenu;
    Briefing;
    Map;

    Count;
}

WarScene :: struct {
    type: WarSceneType;
    // entityManager: WarEntityManager;
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

    status: WarSceneDownloadState;
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
