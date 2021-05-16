WarAIInitFunc :: #type (aiPlayer: *WarPlayerInfo);
WarAINextCommandFunc :: #type (aiPlayer: *WarPlayerInfo);

WarPlayerInfo :: struct {
    index: u8;
    race: WarRace;
    gold: s32;
    wood: s32;
    godMode: bool;
    features: [MAX_FEATURES_COUNT] bool;
    // upgrades: [MAX_UPGRADES_COUNT] WarUpgrade;
    // squads: [MAX_SQUAD_COUNT] WarSquad;
    // commands: List(WarCommand);
    // tiles: [MAP_TILES_WIDTH * MAP_TILES_HEIGHT] WarMapTile;
    ai: *WarAI;
}

WarAI :: struct {
    name: string;

    sleeping: bool;
    sleepTime: f32;

    initFunc: WarAIInitFunc;
    getCommandFunc: WarAINextCommandFunc;

    // commands: Queue(WarCommand);
    // systems: WarAISystemsMap;

    customData: *void;
}