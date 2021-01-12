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

// @Note: I can have this struct somewhere, and then each component pointer
// in each entity would point to the appropriate component in one of these
// arrays/lists. That way if we want to traverse all transforms or sprites for all entities,
// we can do directly with this components manager.
//
// Approach #1
// These arrays can be fixed in length, so we can have a maximum number of each components,
// but then these arrays would have different number of elements, particularly with the most
// used ones vs the others. Define different max sizes for each component type array could be
// possible but it may be weird and would put a cap number of components and be bad if I don't
// do enough analysis on those max sizes.
//
// Approach #2
// These arrays can be dynamic in length, that way the wasted space is less, but it introduces
// other problem, and that is when the dynamically array is resized, I need to keep the pointer
// or positions stable, otherwise it would break the entities pointing here.
//
// In the Entity struct instead of having the components array of pointers to these arrays,
// I can have integers that points to indices. Maybe this could be good enough if I implement
// an unordered list that is stable regarding the indices of each element. That's once an element
// is assigned an index, it won't move even with resizes, and then an empty list of positions is
// maintained to fill wholes in the array. If this is true, each component in the entities can point
// to the index of each component in one of these arrays and that index won't change until the entity
// is destroyed, and the position is free for another entity to occupy it.
//

StableList :: struct(TItem: Type) {
}

add :: inline (list: *$T/StableList, item: T.TItem) -> s64 {
    return -1;
}

removeAt :: inline (list: *$T/StableList, index: s64) {
}

ref :: inline (list: *$T/StableList, index: s64) -> *T.TItem {
    return null;
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

getComponent :: inline (ctx: *WarContext, entity: *WarEntity, type: WarComponentType) -> *WarComponent {
    assert(ctx != null);
    assert(entity != null);

    manager := ctx.scene.componentsManager;
    index := entity.components[type];
    if type == {
        case WarComponentType.Transform;    return ref(*manager.transforms, index);
        case WarComponentType.Sprite;       return ref(*manager.sprites, index);
        case WarComponentType.Unit;         return ref(*manager.units, index);
        case WarComponentType.Animations;   return ref(*manager.animationss, index);
        case WarComponentType.Road;         return ref(*manager.roads, index);
        case WarComponentType.Wall;         return ref(*manager.walls, index);
        case WarComponentType.Ruin;         return ref(*manager.ruins, index);
        case WarComponentType.Forest;       return ref(*manager.forests, index);
        case WarComponentType.Projectile;   return ref(*manager.projectiles, index);
        case WarComponentType.PoisonCloud;  return ref(*manager.poisonClouds, index);
        case WarComponentType.Sight;        return ref(*manager.sights, index);
        case WarComponentType.StateMachine; return ref(*manager.stateMachines, index);
        case WarComponentType.UI;           return ref(*manager.uis, index);
        case WarComponentType.Text;         return ref(*manager.texts, index);
        case WarComponentType.Rect;         return ref(*manager.rects, index);
        case WarComponentType.Button;       return ref(*manager.buttons, index);
        case WarComponentType.Cursor;       return ref(*manager.cursors, index);
        case WarComponentType.Audio;        return ref(*manager.audios, index);
    }
    return ref(*manager.transforms, index);
}

getTransformComponent :: #bake_arguments getComponent(type = WarComponentType.Transform);
getSpriteComponent :: #bake_arguments getComponent(type = WarComponentType.Sprite);
getUnitComponent :: #bake_arguments getComponent(type = WarComponentType.Unit);
getAnimationsComponent :: #bake_arguments getComponent(type = WarComponentType.Animations);
getRoadComponent :: #bake_arguments getComponent(type = WarComponentType.Road);
getWallComponent :: #bake_arguments getComponent(type = WarComponentType.Wall);
getRuinComponent :: #bake_arguments getComponent(type = WarComponentType.Ruin);
getForestComponent :: #bake_arguments getComponent(type = WarComponentType.Forest);
getStateMachineComponent :: #bake_arguments getComponent(type = WarComponentType.StateMachine);
getUIComponent :: #bake_arguments getComponent(type = WarComponentType.UI);
getTextComponent :: #bake_arguments getComponent(type = WarComponentType.Text);
getRectComponent :: #bake_arguments getComponent(type = WarComponentType.Rect);
getButtonComponent :: #bake_arguments getComponent(type = WarComponentType.Button);
getCursorComponent :: #bake_arguments getComponent(type = WarComponentType.Cursor);
getAudioComponent :: #bake_arguments getComponent(type = WarComponentType.Audio);

hasComponent :: inline (ctx: *WarContext, entity: *WarEntity, type: WarComponentType) -> bool {
    assert(entity != null);
    return entity.components[type] >= 0;
}

hasTransformComponent :: #bake_arguments hasComponent(type = WarComponentType.Transform);
hasSpriteComponent :: #bake_arguments hasComponent(type = WarComponentType.Sprite);
hasUnitComponent :: #bake_arguments hasComponent(type = WarComponentType.Unit);
hasAnimationsComponent :: #bake_arguments hasComponent(type = WarComponentType.Animations);
hasRoadComponent :: #bake_arguments hasComponent(type = WarComponentType.Road);
hasWallComponent :: #bake_arguments hasComponent(type = WarComponentType.Wall);
hasRuinComponent :: #bake_arguments hasComponent(type = WarComponentType.Ruin);
hasForestComponent :: #bake_arguments hasComponent(type = WarComponentType.Forest);
hasStateMachineComponent :: #bake_arguments hasComponent(type = WarComponentType.StateMachine);
hasUIComponent :: #bake_arguments hasComponent(type = WarComponentType.UI);
hasTextComponent :: #bake_arguments hasComponent(type = WarComponentType.Text);
hasRectComponent :: #bake_arguments hasComponent(type = WarComponentType.Rect);
hasButtonComponent :: #bake_arguments hasComponent(type = WarComponentType.Button);
hasCursorComponent :: #bake_arguments hasComponent(type = WarComponentType.Cursor);
hasAudioComponent :: #bake_arguments hasComponent(type = WarComponentType.Audio);

addComponent :: (ctx: *WarContext, entity: *WarEntity, component: *$T/WarComponent) {
    assert(entity != null);
    assert(component != null);

    component.entityId = entity.id;

    manager := ctx.scene.componentsManager;
    if component.type == {
        case WarComponentType.Transform;     entity.components[component.type] = add(*manager.transforms, component);
        case WarComponentType.Sprite;        entity.components[component.type] = add(*manager.sprites, component);
        case WarComponentType.Unit;          entity.components[component.type] = add(*manager.units, component);
        case WarComponentType.Animations;    entity.components[component.type] = add(*manager.animationss, component);
        case WarComponentType.Road;          entity.components[component.type] = add(*manager.roads, component);
        case WarComponentType.Wall;          entity.components[component.type] = add(*manager.walls, component);
        case WarComponentType.Ruin;          entity.components[component.type] = add(*manager.ruins, component);
        case WarComponentType.Forest;        entity.components[component.type] = add(*manager.forests, component);
        case WarComponentType.Projectile;    entity.components[component.type] = add(*manager.projectiles, component);
        case WarComponentType.PoisonCloud;   entity.components[component.type] = add(*manager.poisonClouds, component);
        case WarComponentType.Sight;         entity.components[component.type] = add(*manager.sights, component);
        case WarComponentType.StateMachine;  entity.components[component.type] = add(*manager.stateMachines, component);
        case WarComponentType.UI;            entity.components[component.type] = add(*manager.uis, component);
        case WarComponentType.Text;          entity.components[component.type] = add(*manager.texts, component);
        case WarComponentType.Rect;          entity.components[component.type] = add(*manager.rects, component);
        case WarComponentType.Button;        entity.components[component.type] = add(*manager.buttons, component);
        case WarComponentType.Cursor;        entity.components[component.type] = add(*manager.cursors, component);
        case WarComponentType.Audio;         entity.components[component.type] = add(*manager.audios, component);
    }
}

removeComponent :: (ctx: *WarContext, entity: *WarEntity, type: WarComponentType) {
    assert(entity != null);

    manager := ctx.scene.componentsManager;
    index := entity.components[type];
    if (index < 0) {
        return;
    }

    if type == {
        case WarComponentType.Transform; {
            removeAt(*manager.transforms, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Sprite; {
            removeAt(*manager.sprites, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Unit; {
            removeAt(*manager.units, index);
            entity.components[type] =-1;
        }
        case WarComponentType.Animations; {
            removeAt(*manager.animationss, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Road; {
            removeAt(*manager.roads, index);
            entity.components[type] =-1;
        }
        case WarComponentType.Wall; {
            removeAt(*manager.walls, index);
            entity.components[type] =-1;
        }
        case WarComponentType.Ruin; {
            removeAt(*manager.ruins, index);
            entity.components[type] =-1;
        }
        case WarComponentType.Forest; {
            removeAt(*manager.forests, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Projectile; {
            removeAt(*manager.projectiles, index);
            entity.components[type] = -1;
        }
        case WarComponentType.PoisonCloud; {
            removeAt(*manager.poisonClouds, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Sight; {
            removeAt(*manager.sights, index);
            entity.components[type] =-1;
        }
        case WarComponentType.StateMachine; {
            removeAt(*manager.stateMachines, index);
            entity.components[type] = -1;
        }
        case WarComponentType.UI; {
            removeAt(*manager.uis, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Text; {
            removeAt(*manager.texts, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Rect; {
            removeAt(*manager.rects, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Button; {
            removeAt(*manager.buttons, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Cursor; {
            removeAt(*manager.cursors, index);
            entity.components[type] = -1;
        }
        case WarComponentType.Audio; {
            removeAt(*manager.audios, index);
            entity.components[type] = -1;
        }
    }
}

removeTransformComponent :: #bake_arguments removeComponent(type = WarComponentType.Transform);
removeSpriteComponent :: #bake_arguments removeComponent(type = WarComponentType.Sprite);
removeUnitComponent :: #bake_arguments removeComponent(type = WarComponentType.Unit);
removeAnimationsComponent :: #bake_arguments removeComponent(type = WarComponentType.Animations);
removeRoadComponent :: #bake_arguments removeComponent(type = WarComponentType.Road);
removeWallComponent :: #bake_arguments removeComponent(type = WarComponentType.Wall);
removeRuinComponent :: #bake_arguments removeComponent(type = WarComponentType.Ruin);
removeForestComponent :: #bake_arguments removeComponent(type = WarComponentType.Forest);
removeStateMachineComponent :: #bake_arguments removeComponent(type = WarComponentType.StateMachine);
removeUIComponent :: #bake_arguments removeComponent(type = WarComponentType.UI);
removeTextComponent :: #bake_arguments removeComponent(type = WarComponentType.Text);
removeRectComponent :: #bake_arguments removeComponent(type = WarComponentType.Rect);
removeButtonComponent :: #bake_arguments removeComponent(type = WarComponentType.Button);
removeCursorComponent :: #bake_arguments removeComponent(type = WarComponentType.Cursor);
removeAudioComponent :: #bake_arguments removeComponent(type = WarComponentType.Audio);
