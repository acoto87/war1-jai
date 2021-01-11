//
// Resources
//

WarFontData :: struct {
    spriteWidth: s32;
    spriteHeight: s32;
    lineHeight: s32;
    advance: s32;
    data: [95] Rect;
}

WarResourceKind :: enum {
    None;
    Gold;
    Wood;
}

WarSpriteFrame :: struct {
    dx: u8;
    dy: u8;
    w: u8;
    h: u8;
    off: u32;
    data: *u8;
}

WarSprite :: struct {
    image: s32;
    frameWidth: s32;
    frameHeight: s32;
    framesCount: s32;
    frames: [MAX_SPRITE_FRAME_COUNT] WarSpriteFrame;
}

WarSpriteResourceRef :: struct {
    resourceIndex: s32;
    frameIndicesCount: s32;
    frameIndices: [MAX_SPRITE_FRAME_COUNT] s32;
}

WarAnimationStatus :: enum {
    NotStarted;
    Running;
    Finished;
}

WarSpriteAnimation :: struct {
    name: string;
    loop: bool;
    loopDelay: f32;

    offset: Vec2;
    scale: Vec2;

    frameDelay: f32;
    frames: List(s32);
    sprite: WarSprite;

    animTime: f32;
    loopTime: f32;
    status: WarAnimationStatus;
}



WarTilesetTile :: struct {
    WarTile :: struct {
        index: u16;
        flipX: bool;
        flipY: bool;
    }

    tiles: [4] WarTile;
}





WarCampaignMapType :: enum {
    Humans01 :: 117;
    Orcs01;
    Humans02;
    Orcs02;
    Humans03;
    Orcs03;
    Humans04;
    Orcs04;
    Humans05;
    Orcs05;
    Humans06;
    Orcs06;
    Humans07;
    Orcs07;
    Humans08;
    Orcs08;
    Humans09;
    Orcs09;
    Humans10;
    Orcs10;
    Humans11;
    Orcs11;
    Humans12;
    Orcs12;
    Custom;
}

WarLevelResult :: enum {
    None;
    Win;
    Lose;
}

WarFeatureType :: enum {
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

    // spells
    Healing;
    RaiseDead;
    FarSight;
    DarkVision;
    Invisibility;
    UnholyArmor;
    Scorpion;
    Spider;
    RainOfFire;
    PoisonCloud;
    WaterElemental;
    Daemon;

    // constructs
    Road;
    Wall;
}

WarUpgradeType :: enum {
    Arrows;
    Spears;
    Swords;
    Axes;
    Horses;
    Wolves;
    Scorpions;
    Spiders;
    RainOfFire;
    PoisonCloud;
    WaterElemental;
    Daemon;
    Healing;
    RaiseDead;
    FarSight;
    DarkVision;
    Invisibility;
    UnholyArmor;
    Shield;
}

WarSpellType :: enum {
    // spells
    Healing;
    FarSight;
    Invisibility;
    RainOfFire;
    PoisonCloud;
    RaiseDead;
    DarkVision;
    UnholyArmor;

    // summons
    Spider;
    Scorpion;
    Daemon;
    WaterElemental;
}

WarUICommandType :: enum {
    None; // 0

    // unit commands
    Move; // 1
    Stop;
    Gather;
    Deliver;
    Repair;
    Attack;

    // train commands
    TrainFootman; // 7
    TrainGrunt;
    TrainPeasant;
    TrainPeon;
    TrainCatapultHumans;
    TrainCatapultOrcs;
    TrainKnight;
    TrainRaider;
    TrainArcher;
    TrainSpearman;
    TrainConjurer;
    TrainWarlock;
    TrainCleric;
    TrainNecrolyte;

    // spell commands
    SpellHealing; // 21
    SpellFarSight;
    SpellInvisiblity;
    SpellRainOfFire;
    SpellPoisonCloud;
    SpellRaiseDead;
    SpellDarkVision;
    SpellUnholyArmor;

    // summons
    SummonSpider; // 29
    SummonScorpion;
    SummonDaemon;
    SummonWaterElemental;

    // build commands
    BuildBasic; // 33
    BuildAdvanced;
    BuildFarmHumans;
    BuildFarmOrcs;
    BuildBarracksHumans;
    BuildBarracksOrcs;
    BuildChurch;
    BuildTemple;
    BuildTowerHumans;
    BuildTowerOrcs;
    BuildTownhallHumans;
    BuildTownhallOrcs;
    BuildLumbermillHumans;
    BuildLumbermillOrcs;
    BuildStable;
    BuildKennel;
    BuildBlacksmithHumans;
    BuildBlacksmithOrcs;
    BuildRoad;
    BuildWall;

    // upgrades
    UpgradeSwords; // 53
    UpgradeAxes;
    UpgradeShieldHumans;
    UpgradeShieldOrcs;
    UpgradeArrows;
    UpgradeSpears;
    UpgradeHorses;
    UpgradeWolves;
    UpgradeScorpions;
    UpgradeSpiders;
    UpgradeRainOfFire;
    UpgradePoisonCloud;
    UpgradeWaterElemental;
    UpgradeDaemin;
    UpgradeHealing;
    UpgradeRaiseDead;
    UpgradeFarSight;
    UpgradeDarkVision;
    UpgradeInvisibility;
    UpgradeUnholyArmor;

    // cancel
    Cancel; // 73
}

WarUICommand :: struct {
    type: WarUICommandType;
}

WarUICommandTrain :: struct {
    using base: WarUICommand;
    unitType: WarUnitType;
}

WarUICommandUpgrade :: struct {
    using base: WarUICommand;
    upgradeToBuild: WarUpgradeType;
}

WarUICommandBuild :: struct {
    using base: WarUICommand;
    unitType: WarUnitType;
}

//
// Entities
//
WarRace :: enum {
    Neutral;
    Humans;
    Orcs;
}

WarUnitDirection :: enum {
    North;
    NorthEast;
    East;
    SouthEast;
    South;
    SouthWest;
    West;
    NorthWest;
}

WarUnitType :: enum {
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

WarEntityId :: u16;

WarEntityType :: enum {
    None;
    Image;
    Unit;
    Road;
    Wall;
    Ruin;
    Forest;
    Text;
    Rect;
    Button;
    Cursor;
    Audio;
    Projectile;
    RainOfFire;
    PoisonCloud;
    Sight;
    Minimap;
    Animation;
}

WarRoadPieceType :: enum {
    Left;
    Top;
    Right;
    Bottom;
    BottomLeft;
    Vertical;
    BottomRight;
    TLeft;
    TBottom;
    TRight;
    Cross;
    TopLeft;
    Horizontal;
    TTop;
    TopRight;
}

WarRoadPiece :: struct {
    type: WarRoadPieceType;
    tilex, tiley: s32;
    player: u8;
}

WarWallPieceType :: enum {
    Left;
    Top;
    Right;
    Bottom;
    BottomLeft;
    Vertical;
    BottomRight;
    TLeft;
    TBottom;
    TRight;
    Cross;
    TopLeft;
    Horizontal;
    TTop;
    TopRight;
}

WarWallPiece :: struct {
    type: WarWallPieceType;
    hp, maxhp: s32;
    tilex, tiley: s32;
    player: u8;
}

WarRuinPieceType :: enum {
    None;
    TopLeft;
    Top;
    TopRight;
    Left;
    Center;
    Right;
    BottomLeft;
    Bottom;
    BottomRight;
    TopLeftInside;
    TopRightInside;
    BottomLeftInside;
    BottomRightInside;
    Diag1;
    Diag2;
}

WarRuinPiece :: struct {
    type: WarRuinPieceType;
    tilex, tiley: s32;
}

WarTreeTileType :: enum {
    None;
    TopLeft;
    Top;
    TopRight;
    Left;
    Center;
    Right;
    BottomLeft;
    Bottom;
    BottomRight;
    TopLeftInside;
    TopRightInside;
    BottomLeftInside;
    BottomRightInside;
    TopEnd;
    BottomEnd;
    Vertical;
    Diag1;
    Diag2;
    Chopped;
}

WarTree :: struct {
    type: WarTreeTileType;
    tilex, tiley: s32;
    amount: s32;
}

WarUnitAnimStepType :: enum {
    None;
    Frame;
    Wait;
    Move;
    Attack;
    SoundSword;
    SoundFist;
    SoundFireball;
    SoundChopping;
    SoundCatapult;
    SoundArrow;
    SoundLightning;
}

WarUnitAnimStep :: struct {
    type: WarUnitAnimStepType;
    param: s32;
}

WarUnitAnimType :: enum {
    None :: -1;
    Idle;
    Walk;
    Attack;
    Death;
    Harvest;
    Repair;
    Build;
}

WarUnitAnimStatus :: enum {
    NotStarted;
    Running;
    Finished;
}

WarUnitAnim :: struct {
    type: WarUnitAnimType;
    status: WarUnitAnimStatus;
    unbreakable: bool;
    directional: bool;
    loop: bool;
    scale: f32;
    waitCount: f32;
    stepIndex: s32;
    steps: List(WarUnitAnimStep);
    lastActionStep: WarUnitAnimStepType;
    lastSoundStep: WarUnitAnimStepType;
}

WarComponentType :: enum {
    Transform;
    Sprite;
    Unit;
    Animations;
    Road;
    Wall;
    Ruin;
    Forest;
    StateMachine;
    UI;
    Text;
    Rect;
    Button;
}

WarStateType :: enum {
    Idle;
    Move;
    Patrol;
    Follow;
    Attack;
    Gold;
    Mining;
    Wood;
    Chopping;
    Deliver;
    Death;
    Collapse;
    Train;
    Upgrade;
    Build;
    Repair;
    Repairing;
    Cast;
    Wait;
}

WarState :: struct {
    type: WarStateType;
    entityId: WarEntityId;
    nextState: *WarState;

    nextUpdateTime: f32;
    delay: f32;
}

WarStateIdle :: struct {
    using base: WarState;
    lookAround: bool;
}

WarStateMove :: struct {
    using base: WarState;

    positionIndex: s32;
    positions: List(Vec2);

    pathNodeIndex: s32;
    path: WarMapPath;

    waitCount: s32;
    checkForAttacks: bool;
}

WarStatePatrol :: struct {
    using base: WarState;

    positionIndex: s32;
    positions: List(Vec2);
    dir: s32;
}

WarStateFollow :: struct {
    using base: WarState;

    // the follow state can follow an entity or a point
    targetEntityId: s32;
    targetTile: Vec2;

    // the range distance (in tiles) in which the follower stops
    distance: s32;
}

WarStateWait :: struct {
    using base: WarState;
    waitTime: f32;
}

WarStateAttack :: struct {
    using base: WarState;

    targetEntityId: s32;
    targetTile: Vec2;
}

WarStateGold :: struct {
    using base: WarState;
    goldmineId: s32;
}

WarStateMine :: struct {
    using base: WarState;

    goldmineId: s32;
    miningTime: f32;
}

WarStateWood :: struct {
    using base: WarState;

    forestId: s32;
    position: Vec2;
}

WarStateChop :: struct {
    using base: WarState;

    forestId: s32;
    position: Vec2;
}

WarStateDeliver :: struct {
    using base: WarState;

    townHallId: s32;
    insideBuilding: bool;
}

WarStateTrain :: struct {
    using base: WarState;

    unitToBuild: WarUnitType;
    buildTime: f32; // how much time has passed since start building (in seconds)
    totalBuildTime: f32; // total time to build (in seconds)
    cancelled: bool;
}

WarStateUpgrade :: struct {
    using base: WarState;

    upgradeToBuild: WarUpgradeType;
    buildTime: f32; // how much time has passed since start building (in seconds)
    totalBuildTime: f32; // total time to build (in seconds)
    cancelled: bool;
}

WarStateBuild :: struct {
    using base: WarState;

    workerId: WarEntityId; // the worker that is building the building
    buildTime: f32; // how much time has passed since start building (in seconds)
    totalBuildTime: f32; // total time to build (in seconds)
    cancelled: bool;
}

WarStateRepair :: struct {
    using base: WarState;
    buildingId: WarEntityId;
}

WarStateRepairing :: struct {
    using base: WarState;

    buildingId: WarEntityId;
    insideBuilding: bool;
}

WarStateCast :: struct {
    using base: WarState;

    spellType: WarSpellType;
    targetEntityId: WarEntityId;
    targetTile: Vec2;
}

WarComponent :: struct {
    enabled: bool;
    type: WarComponentType;
}

WarTransformComponent :: struct {
    using base: WarComponent;

    position: Vec2;
    rotation: Vec2;
    scale: Vec2;
}

WarSpriteComponent :: struct {
    using base: WarComponent;

    resourceIndex: s32;
    frameIndex: s32;
    sprite: WarSprite;
}

WarUnitComponent :: struct {
    using base: WarComponent;

    unitType: WarUnitType;
    direction: WarUnitDirection;

    // position in tiles
    tilex, tiley: s32;
    // size in tiles
    sizex, sizey: s32;

    // index of the player this unit belongs to
    player: u8;

    // the units that can carry resources are
    // peasants, peons, goldmines and trees
    resourceKind: WarResourceKind;
    amount: s32;

    // indicate if the unit is building something
    building: bool;
    buildPercent: f32;

    // hit points, magic and armor
    hp, maxhp: s32;
    mana, maxMana: s32;
    armor: s32;
    range: s32;
    minDamage: s32;
    rndDamage: s32;
    decay: s32;
    invisible: bool;
    invulnerable: bool;
    hasBeenSeen: bool;

    // index of the array of speeds of the unit
    speed: s32;

    // the current and action list for the unit
    actionIndex: s32;
    actions: List(WarUnitAnim);

    // time remainder (in seconds) until mana is affected
    manaTime: f32;
    // time remainder (in seconds) until the unit invisiblity ceases
    invisibilityTime: f32;
    // time remainder (in seconds) until the unit invulnerability ceases
    invulnerabilityTime: f32;
}

WarAnimationsComponent :: struct {
    using base: WarComponent;
    animations: List(WarSpriteAnimation);
}

WarRoadComponent :: struct {
    using base: WarComponent;
    pieces: List(WarRoadPiece);
}

WarWallComponent :: struct {
    using base: WarComponent;
    pieces: List(WarWallPiece);
}

WarRuinComponent :: struct {
    using base: WarComponent;
    pieces: List(WarRuinPiece);
}

WarForestComponent :: struct {
    using base: WarComponent;
    trees: List(WarTree);
}

WarStateMachineComponent :: struct {
    using base: WarComponent;

    currentState: *WarState;
    nextState: *WarState;
    leaveState: bool;
    enterState: bool;
}

WarUIComponent :: struct {
    using base: WarComponent;
    name: string;
}

WarTextAlignment :: enum {
    Left;
    Center;
    Right;
    Top;
    Middle;
    Bottom;
}

WarTextWrapping :: enum {
    None;
    Char;
}

WarTextTrimming :: enum {
    None;
    Spaces;
    All;
}

WarTextComponent :: struct {
    using base: WarComponent;

    text: string;
    fontIndex: s32;
    fontSize: f32;
    lineHeight: f32;
    fontColor: WarColor;
    highlightColor: WarColor;
    highlightIndex: s32;
    highlightCount: s32;
    boundings: Vec2;
    horizontalAlign: WarTextAlignment;
    verticalAlign: WarTextAlignment;
    lineAlign: WarTextAlignment;
    wrapping: WarTextWrapping;
    trimming: WarTextTrimming;
    multiline: bool;
}

WarRectComponent :: struct {
    using base: WarComponent;

    size: Vec2;
    color: WarColor;
}

WarClickHandler :: #type (ctx: *WarContext, entity: *WarEntity);

WarButtonComponent :: struct {
    using base: WarComponent;

    interactive: bool;
    hot: bool;
    active: bool;
    hotKey: WarKeys;
    highlightIndex: s32;
    highlightCount: s32;
    tooltip: [100] u8;
    gold: s32;
    wood: s32;
    normalSprite: WarSprite;
    pressedSprite: WarSprite;
    clickHandler: WarClickHandler;
}

WarAudioId :: enum {
    Music00                 :: 0;
    Music01                 :: 1;
    Music02                 :: 2;
    Music03                 :: 3;
    Music04                 :: 4;
    Music05                 :: 5;
    Music06                 :: 6;
    Music07                 :: 7;
    Music08                 :: 8;
    Music09                 :: 9;
    Music10                 :: 10;
    Music11                 :: 11;
    Music12                 :: 12;
    Music13                 :: 13;
    Music14                 :: 14;
    Music15                 :: 15;
    Music16                 :: 16;
    Music17                 :: 17;
    Music18                 :: 18;
    Music19                 :: 19;
    Music20                 :: 20;
    Music21                 :: 21;
    Music22                 :: 22;
    Music23                 :: 23;
    Music24                 :: 24;
    Music25                 :: 25;
    Music26                 :: 26;
    Music27                 :: 27;
    Music28                 :: 28;
    Music29                 :: 29;
    Music30                 :: 30;
    Music31                 :: 31;
    Music32                 :: 32;
    Music33                 :: 33;
    Music34                 :: 34;
    Music35                 :: 35;
    Music36                 :: 36;
    Music37                 :: 37;
    Music38                 :: 38;
    Music39                 :: 39;
    Music40                 :: 40;
    Music41                 :: 41;
    Music42                 :: 42;
    Music43                 :: 43;
    Music44                 :: 44;
    Logo                    :: 472;
    IntroDoor               :: 473;
    Building                :: 474;
    Explosion               :: 475;
    CatapultRockFired       :: 476;
    TreeChopping1           :: 477;
    TreeChopping2           :: 478;
    TreeChopping3           :: 479;
    TreeChopping4           :: 480;
    BuildingCollapse1       :: 481;
    BuildingCollapse2       :: 482;
    BuildingCollapse3       :: 483;
    UIChime                 :: 484;
    UIClick                 :: 485;
    UICancel                :: 486;
    SwordAttack1            :: 487;
    SwordAttack2            :: 488;
    SwordAttack3            :: 489;
    FistAttack              :: 490;
    CatapultFireExplosion   :: 491;
    Fireball                :: 492;
    ArrowSpear              :: 493;
    ArrowSpearHit           :: 494;
    OrcHelp1                :: 495; // "The humans draw near"
    OrcHelp2                :: 496; // "The pale dogs approach"
    HumanHelp1              :: 497; // "The Orcs are approaching"
    HumanHelp2              :: 498; // "There are enemies nearby"
    OrcDead                 :: 499;
    HumanDead               :: 500;
    OrcWorkComplete         :: 501; // "Work completed"
    HumanWorkComplete       :: 502; // "Work completed"
    OrcHelp3                :: 503; // "We are being attacked"
    OrcHelp4                :: 504; // "They're destroying our city"
    HumanHelp3              :: 505; // "We are under attack"
    HumanHelp4              :: 506; // "The town is under attack"
    OrcReady                :: 507; // "Your command, master"
    HumanReady              :: 508; // "Your command"
    OrcAcknowledgement1     :: 509;
    OrcAcknowledgement2     :: 510;
    OrcAcknowledgement3     :: 511;
    OrcAcknowledgement4     :: 512;
    HumanAcknowledgement1   :: 513; // "Yes"
    HumanAcknowledgement2   :: 514; // "Yes, mylord"
    OrcSelected1            :: 515;
    OrcSelected2            :: 516;
    OrcSelected3            :: 517;
    OrcSelected4            :: 518;
    OrcSelected5            :: 519;
    HumanSelected1          :: 520; // "Yes?"
    HumanSelected2          :: 521; // "Your will, sire?"
    HumanSelected3          :: 522; // "Mylord?"
    HumanSelected4          :: 523; // "My liege?"
    HumanSelected5          :: 524; // "Your bidding?"
    OrcAnnoyed1             :: 525;
    OrcAnnoyed2             :: 526;
    OrcAnnoyed3             :: 527; // "Stop poking me"
    HumanAnnoyed1           :: 528; // "What?!"
    HumanAnnoyed2           :: 529; // "What do you want?!"
    HumanAnnoyed3           :: 530; // "Why do you keep touching me?!"
    DeadSpiderScorpion      :: 531;
    NormalSpell             :: 532;
    BuildRoad               :: 533;
    OrcTemple               :: 534;
    HumanChurch             :: 535;
    OrcKennel               :: 536;
    HumanStable             :: 537;
    Blacksmith              :: 538;
    FireCrackling           :: 539;
    Cannon1                 :: 540;
    Cannon2                 :: 541;
    CampaignsHumanEnding1   :: 542;
    CampaignsHumanEnding2   :: 543;
    CampaignsOrcEnding1     :: 544;
    CampaignsOrcEnding2     :: 545;
    Intro1                  :: 546; // "In the age of chaos..."
    Intro2                  :: 547; // "The kingdom of Azeroth was..."
    Intro3                  :: 548; // "No one knew where these..."
    Intro4                  :: 549; // "With an ingenious..."
    Intro5                  :: 550; // "Welcome to the World of Warcraft"
    CampaignsHumanIntro01   :: 551;
    CampaignsHumanIntro02   :: 552;
    CampaignsHumanIntro03   :: 553;
    CampaignsHumanIntro04   :: 554;
    CampaignsHumanIntro05   :: 555;
    CampaignsHumanIntro06   :: 556;
    CampaignsHumanIntro07   :: 557;
    CampaignsHumanIntro08   :: 558;
    CampaignsHumanIntro09   :: 559;
    CampaignsHumanIntro10   :: 560;
    CampaignsHumanIntro11   :: 561;
    CampaignsHumanIntro12   :: 562;
    CampaignsOrcIntro01     :: 563;
    CampaignsOrcIntro02     :: 564;
    CampaignsOrcIntro03     :: 565;
    CampaignsOrcIntro04     :: 566;
    CampaignsOrcIntro05     :: 567;
    CampaignsOrcIntro06     :: 568;
    CampaignsOrcIntro07     :: 569;
    CampaignsOrcIntro08     :: 570;
    CampaignsOrcIntro09     :: 571;
    CampaignsOrcIntro10     :: 572;
    CampaignsOrcIntro11     :: 573;
    CampaignsOrcIntro12     :: 574;
    HumanDefeat             :: 575; // "Your failure in battle"
    OrcDefeat               :: 576; // "You pitiful"
    OrcVictory1             :: 577; // "The feel of bones"
    OrcVictory2             :: 578; // "If only the worthless"
    OrcVictory3             :: 579; // "Gaze upon the destruction"
    HumanVictory1           :: 580; // "The forces of darkness"
    HumanVictory2           :: 581; // "Even these children"
    HumanVictory3           :: 582; // "Cheers of victory"
}

WarAudioType :: enum {
    WAR_AUDIO_MIDI;
    WAR_AUDIO_WAVE;
}

WarAudioComponent :: struct {
    using base: WarComponent;

    audioType: WarAudioType;
    resourceIndex: s32;
    loop: bool;
    playbackTime: f32;
    sampleIndex: s32;
    // firstMessage: *tml_message;
    // currentMessage: *tml_message;
}

WarCursorType :: enum {
    Arrow            :: 263;
    Invalid          :: 264;
    YellowCrosshair  :: 265;
    RedCrosshair     :: 266;
    YellowCrosshair2 :: 267;
    MagnifyingGlass  :: 268;
    GreenCrosshair   :: 269;
    Watch            :: 270;
    ArrowUp          :: 271;
    ArrowUpRight     :: 272;
    ArrowRight       :: 273;
    ArrowBottomRight :: 274;
    ArrowBottom      :: 275;
    ArrowBottomLeft  :: 276;
    ArrowLeft        :: 277;
    ArrowUpLeft      :: 278;
}

WarCursorComponent :: struct {
    using base: WarComponent;

    cursorType: WarCursorType;
    hot: Vec2;
}

WarProjectileType :: enum {
    Arrow;
    Catapult;
    Fireball;
    Fireball2;
    WaterElemental;
    RainOfFire;
}

WarProjectileComponent :: struct {
    using base: WarComponent;

    projectileType: WarProjectileType;
    sourceEntityId: WarEntityId;
    targetEntityId: WarEntityId;
    origin: Vec2;
    target: Vec2;
    speed: s32;
}

WarPoisonCloudComponent :: struct {
    using base: WarComponent;

    position: Vec2;
    time: f32;          // time in seconds left of the spell
    damageTime: f32;    // time in seconds left to inflict damage
    animName: [30] u8;
}

WarSightComponent :: struct {
    using base: WarComponent;

    position: Vec2;
    time: f32;          // time in seconds left of the spell
}

WarEntity :: struct {
    id: WarEntityId;
    type: WarEntityType;
    enabled: bool;
    components: HashMap(WarComponentType, WarComponent);
}

//
// Map
//

WarMapTilesetType :: enum {
    Forest;
    Swamp;
    Dungeon;
}

//
// Input
//
WarMouseButtons :: enum {
    None;
    Left;
    Right;

    Count;
}

WarKeys :: enum {
    None;

    Space;
    Apostrophe;
    Asterisk;
    Plus;
    Comma;
    Minus;
    Period;
    Slash;

    D0;
    D1;
    D2;
    D3;
    D4;
    D5;
    D6;
    D7;
    D8;
    D9;

    Semicolon;
    Equal;

    A;
    B;
    C;
    D;
    E;
    F;
    G;
    H;
    I;
    J;
    K;
    L;
    M;
    N;
    O;
    P;
    Q;
    R;
    S;
    T;
    U;
    V;
    W;
    X;
    Y;
    Z;

    LeftBracket;
    Backslash;
    RightBracket;
    GraveAccent;

    Esc;
    Enter;
    Tab;
    Backspace;
    Insert;
    Delete;

    Right;
    Left;
    Down;
    Up;

    PageUp;
    PageDown;
    Home;
    End;

    F1;
    F2;
    F3;
    F4;
    F5;
    F6;
    F7;
    F8;
    F9;
    F10;
    F11;
    F12;

    Shift;
    Ctrl;
    Alt;

    Count;
}

WarKeyButtonState :: struct {
    // indicates if the key is pressed in the current frame
    pressed: bool;

    // indicate if the key was pressed in the previous frame
    wasPressed: bool;
}

WarInput :: struct {
    // current mouse position
    pos: Vec2;

    // state of the mouse buttons
    buttons: [WarMouseButtons.Count] WarKeyButtonState;

    // state of the keys
    keys: [WarKeys.Count] WarKeyButtonState;

    // drag
    isDragging: bool;
    wasDragging: bool;
    dragPos: Vec2;
    dragRect: Rect;
}

WarContext :: struct {
    time: f32;
    deltaTime: f32;
    fps: u32;

    paused: bool;

    globalScale: f32;
    globalSpeed: f32;

    originalWindowWidth: s32;
    originalWindowHeight: s32;
    windowWidth: s32;
    windowHeight: s32;
    framebufferWidth: s32;
    framebufferHeight: s32;
    devicePixelRatio: f32;
    windowTitle: string;
    window: *GLFWwindow;

    warFile: *WarFile;
    resources: [MAX_RESOURCES_COUNT] *WarResource;
    fontSprites: [2] WarSprite;

    gfx: *NVGcontext;

    // ma_device sfx;
    // tsf* soundFont;
    // // this is shortcut to disable all audios in the map
    // // to avoid crashes when freeing the map and the audio thread
    // // trying to reproduce audios
    audioEnabled: bool;
    musicEnabled: bool;
    soundEnabled: bool;
    musicVolume: f32;
    soundVolume: f32;

    cheatsEnabled: bool;

    // // this is a mutex used to make the deletion of the entities thread-safe
    // // since the audio thread will delete audio entities, that could lead
    // // to inconsistent states in the internal lists when the game try to also
    // // delete other entities.
    // pthread_mutex_t __mutex;

    input: WarInput;

    transitionDelay: f32;
    // scene: *WarScene;
    // nextScene: *WarScene;
    // map: *WarMap;
    // nextMap: *WarMap;
}
