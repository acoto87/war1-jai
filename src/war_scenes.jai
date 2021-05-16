WarSceneType :: enum {
    Download;
    Blizzard;
    MainMenu;
    Briefing;
    Map;
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
    using base: Scene;
    // base.type = WarSceneType.Download;

    downloadState: WarSceneDownloadState;
}

WarBlizzardScene :: struct {
    using base: Scene;
    // base.type = WarSceneType.Blizzard;

    time: f32;
}

WarMenuScene :: struct {
    using base: Scene;
    // base.type = WarSceneType.MainMenu;

    yourRace: WarRace;
    enemyRace: WarRace;
    customMap: s32;
}

WarBriefingScene :: struct {
    using base: Scene;
    // base.type = WarSceneType.Briefing;

    time: f32;
    race: WarRace;
    mapType: WarCampaignMapType;
}

#scope_file

#load "war_scene_blizzard.jai";
#load "war_scene_menu.jai";
#load "war_scene_briefing.jai";
