WarSceneType :: enum {
    Download;
    Blizzard;
    MainMenu;
    Briefing;

    Count;
}

WarScene :: struct {
    type: WarSceneType;
    // entityManager: WarEntityManager;
    componentsManager: WarComponentsManager;

    // cheatStatus: WarCheatStatus;
}

// union
// {
//     struct
//     {
//         WarSceneDownloadState status;
//     } download;

//     struct
//     {
//         f32 time;
//     } blizzard;

//     struct
//     {
//         WarRace yourRace;
//         WarRace enemyRace;
//         s32 customMap;
//     } menu;

//     struct
//     {
//         f32 time;
//         WarRace race;
//         WarCampaignMapType mapType;
//     } briefing;
// };