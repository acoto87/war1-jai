//
// Resources
//
WarResourceKind :: enum {
    None;
    Gold;
    Wood;
}





// WarTilesetTile :: struct {
//     WarTile :: struct {
//         index: u16;
//         flipX: bool;
//         flipY: bool;
//     }

//     tiles: [4] WarTile;
// }







// WarFeatureType :: enum {
//     // units
//     Footman;
//     Grunt;
//     Peasant;
//     Peon;
//     CatapultHumans;
//     CatapultOrcs;
//     Knight;
//     Raider;
//     Archer;
//     Spearman;
//     Conjurer;
//     Warlock;
//     Cleric;
//     Necrolyte;
//     FarmHumans;
//     FarmOrcs;
//     BarracksHumans;
//     BarracksOrcs;
//     Church;
//     Temple;
//     TowerHumans;
//     TowerOrcs;
//     TownhallHumans;
//     TownhallOrcs;
//     LumbermillHumans;
//     LumbermillOrcs;
//     Stable;
//     Kennel;
//     BlacksmithHumans;
//     BlacksmithOrcs;

//     // spells
//     Healing;
//     RaiseDead;
//     FarSight;
//     DarkVision;
//     Invisibility;
//     UnholyArmor;
//     Scorpion;
//     Spider;
//     RainOfFire;
//     PoisonCloud;
//     WaterElemental;
//     Daemon;

//     // constructs
//     Road;
//     Wall;
// }

// WarUpgradeType :: enum {
//     Arrows;
//     Spears;
//     Swords;
//     Axes;
//     Horses;
//     Wolves;
//     Scorpions;
//     Spiders;
//     RainOfFire;
//     PoisonCloud;
//     WaterElemental;
//     Daemon;
//     Healing;
//     RaiseDead;
//     FarSight;
//     DarkVision;
//     Invisibility;
//     UnholyArmor;
//     Shield;
// }

// WarSpellType :: enum {
//     // spells
//     Healing;
//     FarSight;
//     Invisibility;
//     RainOfFire;
//     PoisonCloud;
//     RaiseDead;
//     DarkVision;
//     UnholyArmor;

//     // summons
//     Spider;
//     Scorpion;
//     Daemon;
//     WaterElemental;
// }

// WarUICommandType :: enum {
//     None; // 0

//     // unit commands
//     Move; // 1
//     Stop;
//     Gather;
//     Deliver;
//     Repair;
//     Attack;

//     // train commands
//     TrainFootman; // 7
//     TrainGrunt;
//     TrainPeasant;
//     TrainPeon;
//     TrainCatapultHumans;
//     TrainCatapultOrcs;
//     TrainKnight;
//     TrainRaider;
//     TrainArcher;
//     TrainSpearman;
//     TrainConjurer;
//     TrainWarlock;
//     TrainCleric;
//     TrainNecrolyte;

//     // spell commands
//     SpellHealing; // 21
//     SpellFarSight;
//     SpellInvisiblity;
//     SpellRainOfFire;
//     SpellPoisonCloud;
//     SpellRaiseDead;
//     SpellDarkVision;
//     SpellUnholyArmor;

//     // summons
//     SummonSpider; // 29
//     SummonScorpion;
//     SummonDaemon;
//     SummonWaterElemental;

//     // build commands
//     BuildBasic; // 33
//     BuildAdvanced;
//     BuildFarmHumans;
//     BuildFarmOrcs;
//     BuildBarracksHumans;
//     BuildBarracksOrcs;
//     BuildChurch;
//     BuildTemple;
//     BuildTowerHumans;
//     BuildTowerOrcs;
//     BuildTownhallHumans;
//     BuildTownhallOrcs;
//     BuildLumbermillHumans;
//     BuildLumbermillOrcs;
//     BuildStable;
//     BuildKennel;
//     BuildBlacksmithHumans;
//     BuildBlacksmithOrcs;
//     BuildRoad;
//     BuildWall;

//     // upgrades
//     UpgradeSwords; // 53
//     UpgradeAxes;
//     UpgradeShieldHumans;
//     UpgradeShieldOrcs;
//     UpgradeArrows;
//     UpgradeSpears;
//     UpgradeHorses;
//     UpgradeWolves;
//     UpgradeScorpions;
//     UpgradeSpiders;
//     UpgradeRainOfFire;
//     UpgradePoisonCloud;
//     UpgradeWaterElemental;
//     UpgradeDaemin;
//     UpgradeHealing;
//     UpgradeRaiseDead;
//     UpgradeFarSight;
//     UpgradeDarkVision;
//     UpgradeInvisibility;
//     UpgradeUnholyArmor;

//     // cancel
//     Cancel; // 73
// }

// WarUICommand :: struct {
//     type: WarUICommandType;
// }

// WarUICommandTrain :: struct {
//     using base: WarUICommand;
//     unitType: WarUnitType;
// }

// WarUICommandUpgrade :: struct {
//     using base: WarUICommand;
//     upgradeToBuild: WarUpgradeType;
// }

// WarUICommandBuild :: struct {
//     using base: WarUICommand;
//     unitType: WarUnitType;
// }

//
// Entities
WarRace :: enum u16 {
    Neutral;
    Humans;
    Orcs;
}

WarUnitType :: enum u16 {
    // units
    Footman;
    Grunt;
    Peasant;
    Peon;
    CatapultHumans;
    CatapultOrcs;
    Knight;
    Raider;
    Archer;
    Spearman;
    Conjurer;
    Warlock;
    Cleric;
    Necrolyte;
    Medivh;
    Lothar;
    Wounded;
    Grizelda;
    Garona;
    Ogre;
    Spider;
    Slime;
    FireElemental;
    Scorpion;
    Brigand;
    TheDead;
    Skeleton;
    Daemon;
    WaterElemental;
    DragonCyclopsGiant;
    Unit26;
    Unit30;

    // buildings
    FarmHumans;
    FarmOrcs;
    BarracksHumans;
    BarracksOrcs;
    Church;
    Temple;
    TowerHumans;
    TowerOrcs;
    TownhallHumans;
    TownhallOrcs;
    LumbermillHumans;
    LumbermillOrcs;
    Stable;
    Kennel;
    BlacksmithHumans;
    BlacksmithOrcs;
    Stormwind;
    Blackrock;

    // neutral
    Goldmine;

	Unit51;

    // others
    HumanCorpse;
    OrcCorpse;
}



// WarRoadPieceType :: enum {
//     Left;
//     Top;
//     Right;
//     Bottom;
//     BottomLeft;
//     Vertical;
//     BottomRight;
//     TLeft;
//     TBottom;
//     TRight;
//     Cross;
//     TopLeft;
//     Horizontal;
//     TTop;
//     TopRight;
// }

// WarRoadPiece :: struct {
//     type: WarRoadPieceType;
//     tilex, tiley: s32;
//     player: u8;
// }

// WarWallPieceType :: enum {
//     Left;
//     Top;
//     Right;
//     Bottom;
//     BottomLeft;
//     Vertical;
//     BottomRight;
//     TLeft;
//     TBottom;
//     TRight;
//     Cross;
//     TopLeft;
//     Horizontal;
//     TTop;
//     TopRight;
// }

// WarWallPiece :: struct {
//     type: WarWallPieceType;
//     hp, maxhp: s32;
//     tilex, tiley: s32;
//     player: u8;
// }

// WarRuinPieceType :: enum {
//     None;
//     TopLeft;
//     Top;
//     TopRight;
//     Left;
//     Center;
//     Right;
//     BottomLeft;
//     Bottom;
//     BottomRight;
//     TopLeftInside;
//     TopRightInside;
//     BottomLeftInside;
//     BottomRightInside;
//     Diag1;
//     Diag2;
// }

// WarRuinPiece :: struct {
//     type: WarRuinPieceType;
//     tilex, tiley: s32;
// }

// WarTreeTileType :: enum {
//     None;
//     TopLeft;
//     Top;
//     TopRight;
//     Left;
//     Center;
//     Right;
//     BottomLeft;
//     Bottom;
//     BottomRight;
//     TopLeftInside;
//     TopRightInside;
//     BottomLeftInside;
//     BottomRightInside;
//     TopEnd;
//     BottomEnd;
//     Vertical;
//     Diag1;
//     Diag2;
//     Chopped;
// }

// WarTree :: struct {
//     type: WarTreeTileType;
//     tilex, tiley: s32;
//     amount: s32;
// }

// WarUnitAnimStepType :: enum {
//     None;
//     Frame;
//     Wait;
//     Move;
//     Attack;
//     SoundSword;
//     SoundFist;
//     SoundFireball;
//     SoundChopping;
//     SoundCatapult;
//     SoundArrow;
//     SoundLightning;
// }

// WarUnitAnimStep :: struct {
//     type: WarUnitAnimStepType;
//     param: s32;
// }

// WarUnitAnimType :: enum {
//     None :: -1;
//     Idle;
//     Walk;
//     Attack;
//     Death;
//     Harvest;
//     Repair;
//     Build;
// }

// WarUnitAnimStatus :: enum {
//     NotStarted;
//     Running;
//     Finished;
// }

// WarUnitAnim :: struct {
//     type: WarUnitAnimType;
//     status: WarUnitAnimStatus;
//     unbreakable: bool;
//     directional: bool;
//     loop: bool;
//     scale: f32;
//     waitCount: f32;
//     stepIndex: s32;
//     steps: List(WarUnitAnimStep);
//     lastActionStep: WarUnitAnimStepType;
//     lastSoundStep: WarUnitAnimStepType;
// }



// WarStateType :: enum {
//     Idle;
//     Move;
//     Patrol;
//     Follow;
//     Attack;
//     Gold;
//     Mining;
//     Wood;
//     Chopping;
//     Deliver;
//     Death;
//     Collapse;
//     Train;
//     Upgrade;
//     Build;
//     Repair;
//     Repairing;
//     Cast;
//     Wait;
// }

// WarState :: struct {
//     type: WarStateType;
//     entityId: WarEntityId;
//     nextState: *WarState;

//     nextUpdateTime: f32;
//     delay: f32;
// }

// WarStateIdle :: struct {
//     using base: WarState;
//     lookAround: bool;
// }

// WarStateMove :: struct {
//     using base: WarState;

//     positionIndex: s32;
//     positions: List(Vec2);

//     pathNodeIndex: s32;
//     path: WarMapPath;

//     waitCount: s32;
//     checkForAttacks: bool;
// }

// WarStatePatrol :: struct {
//     using base: WarState;

//     positionIndex: s32;
//     positions: List(Vec2);
//     dir: s32;
// }

// WarStateFollow :: struct {
//     using base: WarState;

//     // the follow state can follow an entity or a point
//     targetEntityId: s32;
//     targetTile: Vec2;

//     // the range distance (in tiles) in which the follower stops
//     distance: s32;
// }

// WarStateWait :: struct {
//     using base: WarState;
//     waitTime: f32;
// }

// WarStateAttack :: struct {
//     using base: WarState;

//     targetEntityId: s32;
//     targetTile: Vec2;
// }

// WarStateGold :: struct {
//     using base: WarState;
//     goldmineId: s32;
// }

// WarStateMine :: struct {
//     using base: WarState;

//     goldmineId: s32;
//     miningTime: f32;
// }

// WarStateWood :: struct {
//     using base: WarState;

//     forestId: s32;
//     position: Vec2;
// }

// WarStateChop :: struct {
//     using base: WarState;

//     forestId: s32;
//     position: Vec2;
// }

// WarStateDeliver :: struct {
//     using base: WarState;

//     townHallId: s32;
//     insideBuilding: bool;
// }

// WarStateTrain :: struct {
//     using base: WarState;

//     unitToBuild: WarUnitType;
//     buildTime: f32; // how much time has passed since start building (in seconds)
//     totalBuildTime: f32; // total time to build (in seconds)
//     cancelled: bool;
// }

// WarStateUpgrade :: struct {
//     using base: WarState;

//     upgradeToBuild: WarUpgradeType;
//     buildTime: f32; // how much time has passed since start building (in seconds)
//     totalBuildTime: f32; // total time to build (in seconds)
//     cancelled: bool;
// }

// WarStateBuild :: struct {
//     using base: WarState;

//     workerId: WarEntityId; // the worker that is building the building
//     buildTime: f32; // how much time has passed since start building (in seconds)
//     totalBuildTime: f32; // total time to build (in seconds)
//     cancelled: bool;
// }

// WarStateRepair :: struct {
//     using base: WarState;
//     buildingId: WarEntityId;
// }

// WarStateRepairing :: struct {
//     using base: WarState;

//     buildingId: WarEntityId;
//     insideBuilding: bool;
// }

// WarStateCast :: struct {
//     using base: WarState;

//     spellType: WarSpellType;
//     targetEntityId: WarEntityId;
//     targetTile: Vec2;
// }

WarContext :: struct {
    using base: GameContext;

    warFile: *WarFile;
    resources: [MAX_RESOURCES_COUNT] *WarResource;
}
