WarComponentType :: enum {
    Transform;
    Sprite;
    Unit;
    Animations;
    Road;
    Wall;
    Ruin;
    Forest;
    Projectile;
    PoisonCloud;
    Sight;
    StateMachine;
    UI;
    Text;
    Rect;
    Button;
    Cursor;
    Audio;

    Count;
}

WarComponent :: struct {
    enabled: bool;
    type: WarComponentType;
    index: s32;
    entityId: WarEntityId;
}

WarTransformComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Transform;

    position: Vec2;
    rotation: Vec2;
    scale: Vec2;
}

WarSpriteComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Sprite;

    resourceIndex: s32;
    frameIndex: s32;
    sprite: WarSprite;
}

WarUnitComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Unit;

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
    base.type = WarComponentType.Animations;

    animations: List(WarSpriteAnimation);
}

WarRoadComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Road;

    pieces: List(WarRoadPiece);
}

WarWallComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Wall;

    pieces: List(WarWallPiece);
}

WarRuinComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Ruin;

    pieces: List(WarRuinPiece);
}

WarForestComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Forest;

    trees: List(WarTree);
}

WarStateMachineComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.StateMachine;

    currentState: *WarState;
    nextState: *WarState;
    leaveState: bool;
    enterState: bool;
}

WarUIComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.UI;

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
    base.type = WarComponentType.Text;

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
    base.type = WarComponentType.Rect;

    size: Vec2;
    color: WarColor;
}

WarClickHandler :: #type (ctx: *WarContext, entity: *WarEntity);

WarButtonComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Button;

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

WarAudioType :: enum {
    WAR_AUDIO_MIDI;
    WAR_AUDIO_WAVE;
}

WarAudioComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Audio;

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
    base.type = WarComponentType.Cursor;

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
    base.type = WarComponentType.Projectile;

    projectileType: WarProjectileType;
    sourceEntityId: WarEntityId;
    targetEntityId: WarEntityId;
    origin: Vec2;
    target: Vec2;
    speed: s32;
}

WarPoisonCloudComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.PoisonCloud;

    position: Vec2;
    time: f32;          // time in seconds left of the spell
    damageTime: f32;    // time in seconds left to inflict damage
    animName: [30] u8;
}

WarSightComponent :: struct {
    using base: WarComponent;
    base.type = WarComponentType.Sight;

    position: Vec2;
    time: f32;          // time in seconds left of the spell
}

WarComponentsManager :: struct {
    transforms: StableList(WarTransformComponent);
    sprites: StableList(WarSpriteComponent);
    units: StableList(WarUnitComponent);
    animationss: StableList(WarAnimationsComponent);
    roads: StableList(WarRoadComponent);
    walls: StableList(WarWallComponent);
    ruins: StableList(WarRuinComponent);
    forests: StableList(WarForestComponent);
    projectiles: StableList(WarProjectileComponent);
    poisonClouds: StableList(WarPoisonCloudComponent);
    sights: StableList(WarSightComponent);
    stateMachines: StableList(WarStateMachineComponent);
    uis: StableList(WarUIComponent);
    texts: StableList(WarTextComponent);
    rects: StableList(WarRectComponent);
    buttons: StableList(WarButtonComponent);
    cursors: StableList(WarCursorComponent);
    audios: StableList(WarAudioComponent);
}

getComponent :: (ctx: *WarContext, entity: *WarEntity, $type: WarComponentType) -> *WarComponent {
    assert(ctx != null);
    assert(ctx.scene != null);
    assert(entity != null);

    manager := ctx.scene.componentsManager;
    index := entity.components[type];
    #if (type == WarComponentType.Transform)         return ref(*manager.transforms, index);
    else if (type ==  WarComponentType.Sprite)       return ref(*manager.sprites, index);
    else if (type ==  WarComponentType.Unit)         return ref(*manager.units, index);
    else if (type ==  WarComponentType.Animations)   return ref(*manager.animationss, index);
    else if (type ==  WarComponentType.Road)         return ref(*manager.roads, index);
    else if (type ==  WarComponentType.Wall)         return ref(*manager.walls, index);
    else if (type ==  WarComponentType.Ruin)         return ref(*manager.ruins, index);
    else if (type ==  WarComponentType.Forest)       return ref(*manager.forests, index);
    else if (type ==  WarComponentType.Projectile)   return ref(*manager.projectiles, index);
    else if (type ==  WarComponentType.PoisonCloud)  return ref(*manager.poisonClouds, index);
    else if (type ==  WarComponentType.Sight)        return ref(*manager.sights, index);
    else if (type ==  WarComponentType.StateMachine) return ref(*manager.stateMachines, index);
    else if (type ==  WarComponentType.UI)           return ref(*manager.uis, index);
    else if (type ==  WarComponentType.Text)         return ref(*manager.texts, index);
    else if (type ==  WarComponentType.Rect)         return ref(*manager.rects, index);
    else if (type ==  WarComponentType.Button)       return ref(*manager.buttons, index);
    else if (type ==  WarComponentType.Cursor)       return ref(*manager.cursors, index);
    else if (type ==  WarComponentType.Audio)        return ref(*manager.audios, index);
    else {
        logError("Unkown component of type: %\n", type);
        return null;
    }
}

getComponent :: inline ($componentType: Type, ctx: *WarContext, entity: *WarEntity, $type: WarComponentType) -> *componentType {
    return cast(*componentType) getComponent(ctx, entity, type);
}

hasComponent :: inline (ctx: *WarContext, entity: *WarEntity, type: WarComponentType) -> bool {
    assert(entity != null);
    return entity.components[type] >= 0;
}

createComponent :: (ctx: *WarContext, $type: WarComponentType) -> *WarComponent {
    assert(ctx != null);
    assert(ctx.scene != null);

    index: s64 = -1;
    component: *WarComponent = null;

    manager := ctx.scene.componentsManager;
    #if (type == WarComponentType.Transform) {
        index, component = addNew(*manager.transforms);
    } else if (type == WarComponentType.Sprite) {
        index, component = addNew(*manager.sprites);
    } else if (type == WarComponentType.Unit) {
        index, component = addNew(*manager.units);
    } else if (type == WarComponentType.Animations) {
        index, component = addNew(*manager.animationss);
    } else if (type == WarComponentType.Road) {
        index, component = addNew(*manager.roads);
    } else if (type == WarComponentType.Wall) {
        index, component = addNew(*manager.walls);
    } else if (type == WarComponentType.Ruin) {
        index, component = addNew(*manager.ruins);
    } else if (type == WarComponentType.Forest) {
        index, component = addNew(*manager.forests);
    } else if (type == WarComponentType.Projectile) {
        index, component = addNew(*manager.projectiles);
    } else if (type == WarComponentType.PoisonCloud) {
        index, component = addNew(*manager.poisonClouds);
    } else if (type == WarComponentType.Sight) {
        index, component = addNew(*manager.sights);
    } else if (type == WarComponentType.StateMachine) {
        index, component = addNew(*manager.stateMachines);
    } else if (type == WarComponentType.UI) {
        index, component = addNew(*manager.uis);
    } else if (type == WarComponentType.Text) {
        index, component = addNew(*manager.texts);
    } else if (type == WarComponentType.Rect) {
        index, component = addNew(*manager.rects);
    } else if (type == WarComponentType.Button) {
        index, component = addNew(*manager.buttons);
    } else if (type == WarComponentType.Cursor) {
        index, component = addNew(*manager.cursors);
    } else if (type == WarComponentType.Audio) {
        index, component = addNew(*manager.audios);
    } else {
        logError("Unkown component type: %\n", type);
    }

    if (component != null) {
        component.enabled = true;
        component.type = type;
        component.index = cast(s32) index;
    }

    return component;
}

addComponent :: (ctx: *WarContext, entity: *WarEntity, component: *WarComponent) {
    assert(ctx != null);
    assert(ctx.scene != null);
    assert(entity != null);

    component.entityId = entity.id;
    entity.components[component.type] = component.index;
}

removeComponent :: (ctx: *WarContext, entity: *WarEntity, $type: WarComponentType) {
    assert(ctx != null);
    assert(ctx.scene != null);
    assert(entity != null);

    manager := ctx.scene.componentsManager;
    index := entity.components[type];
    if (index < 0) {
        return;
    }

    #if (type == WarComponentType.Transform)        removeAt(*manager.transforms, index);
    else if (type == WarComponentType.Sprite)       removeAt(*manager.sprites, index);
    else if (type == WarComponentType.Unit)         removeAt(*manager.units, index);
    else if (type == WarComponentType.Animations)   removeAt(*manager.animationss, index);
    else if (type == WarComponentType.Road)         removeAt(*manager.roads, index);
    else if (type == WarComponentType.Wall)         removeAt(*manager.walls, index);
    else if (type == WarComponentType.Ruin)         removeAt(*manager.ruins, index);
    else if (type == WarComponentType.Forest)       removeAt(*manager.forests, index);
    else if (type == WarComponentType.Projectile)   removeAt(*manager.projectiles, index);
    else if (type == WarComponentType.PoisonCloud)  removeAt(*manager.poisonClouds, index);
    else if (type == WarComponentType.Sight)        removeAt(*manager.sights, index);
    else if (type == WarComponentType.StateMachine) removeAt(*manager.stateMachines, index);
    else if (type == WarComponentType.UI)           removeAt(*manager.uis, index);
    else if (type == WarComponentType.Text)         removeAt(*manager.texts, index);
    else if (type == WarComponentType.Rect)         removeAt(*manager.rects, index);
    else if (type == WarComponentType.Button)       removeAt(*manager.buttons, index);
    else if (type == WarComponentType.Cursor)       removeAt(*manager.cursors, index);
    else if (type == WarComponentType.Audio)        removeAt(*manager.audios, index);

    entity.components[type] = -1;
}
