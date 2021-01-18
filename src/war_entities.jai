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

WarEntity :: struct {
    id: WarEntityId;
    type: WarEntityType;
    enabled: bool;
    components: [#run getCount(WarComponentType)] s32;
}

WarEntityManager :: struct {
    entities: List(WarEntity);
    entitiesByType: HashMap(WarEntityType, List(*WarEntity));
    unitsByType: HashMap(WarUnitType, List(*WarEntity));
    entitiesById: HashMap(WarEntityId, *WarEntity);
    uiEntities: List(*WarEntity);
}

equalsEntity :: (e1: WarEntity, e2: WarEntity) -> bool {
    return e1.type == e2.type;
}

equalsEntity :: (e1: *WarEntity, e2: *WarEntity) -> bool {
    return e1.type == e2.type;
}

hashEntityType :: (type: WarEntityType) -> s64 {
    return cast(s64) type;
}

hashUnitType :: (type: WarUnitType) -> s64 {
    return cast(s64) type;
}

hashEntityId :: (id: WarEntityId) -> s64 {
    return cast(s64) id;
}

createEntity :: (ctx: *WarContext, type: WarEntityType) -> *WarEntity {
    assert(ctx != null);
    assert(ctx.scene != null);

    staticEntityId += 1;

    entityManager := *ctx.scene.entityManager;

    entity := addNew(*entityManager.entities);
    entity.id = staticEntityId;
    entity.type = type;
    entity.enabled = true;

    for i : 0..getCount(WarComponentType)-1 {
        entity.components[i] = -1;
    }

    set(*entityManager.entitiesById, entity.id, entity);

    found, entitiesOfType := ref(*entityManager.entitiesByType, type);
    if (found) {
        add(entitiesOfType, entity);
    }

    if (isUIEntity(entity)) {
        add(*entityManager.uiEntities, entity);
    }

    return entity;
}

isUIEntity :: (entity: *WarEntity) -> bool {
    if entity.type == {
        case WarEntityType.Image; #through;
        case WarEntityType.Text; #through;
        case WarEntityType.Rect; #through;
        case WarEntityType.Button; #through;
        case WarEntityType.Cursor; #through;
        case WarEntityType.Minimap;
            return true;

        case;
            return false;
    }
}

initEntityManager :: (manager: *WarEntityManager) {
    // initialize entities list
    init(*manager.entities, ListOptions(WarEntity).{
        equalsFn = equalsEntity
    });

    // initialize entity by type map
    init(*manager.entitiesByType, HashMapOptions(WarEntityType, List(*WarEntity)).{
        hashFn = hashEntityType
    });

    for entry : iterate(WarEntityType) {
        list: List(*WarEntity);
        init(*list, ListOptions(*WarEntity).{
            equalsFn = equalsEntity
        });
        set(*manager.entitiesByType, entry.value, list);
    }

    // initialize unit by type map
    init(*manager.unitsByType, HashMapOptions(WarUnitType, List(*WarEntity)).{
        hashFn = hashUnitType
    });

    for entry : iterate(WarUnitType) {
        list: List(*WarEntity);
        init(*list, ListOptions(*WarEntity).{
            equalsFn = equalsEntity
        });
        set(*manager.unitsByType, entry.value, list);
    }

    // initialize the entities by id map
    init(*manager.entitiesById, HashMapOptions(WarEntityId, *WarEntity).{
        hashFn = hashEntityId
    });

    // initialize ui entities list
    init(*manager.uiEntities, ListOptions(*WarEntity).{
        equalsFn = equalsEntity
    });
}

freeEntityManager :: (entityManager: *WarEntityManager) {
    uninit(*entityManager.entities);
    uninit(*entityManager.entitiesByType);
    uninit(*entityManager.unitsByType);
    uninit(*entityManager.entitiesById);
    uninit(*entityManager.uiEntities);
}

getEntities :: (ctx: *WarContext) -> *List(WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    entityManager := *ctx.scene.entityManager;
    return *entityManager.entities;
}

getEntitiesOfType :: (ctx: *WarContext, type: WarEntityType) -> *List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    entityManager := *ctx.scene.entityManager;
    found, entities := ref(*entityManager.entitiesByType, type);
    return entities;
}

getUnitsOfType :: (ctx: *WarContext, type: WarUnitType) -> *List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    entityManager := *ctx.scene.entityManager;
    found, entities := ref(*entityManager.unitsByType, type);
    return entities;
}

getUnitsOfPlayer :: (ctx: *WarContext, player: u8) -> List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    unitsOfPlayer: List(*WarEntity);
    init(*unitsOfPlayer, ListOptions(*WarEntity).{
        equalsFn = equalsEntity
    });

    entities := getEntitiesOfType(ctx, WarEntityType.Unit);
    for entity : entities {
        unit := getComponent(ctx, entity, WarUnitComponent);
        if (unit.player == player) {
            add(*unitsOfPlayer, entity);
        }
    }

    return unitsOfPlayer;
}

getUnitsOfTypeOfPlayer :: (ctx: *WarContext, type: WarUnitType, player: u8) -> List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    unitsOfPlayer: List(*WarEntity);
    init(*unitsOfPlayer, ListOptions(*WarEntity).{
        equalsFn = equalsEntity
    });

    entities := getUnitsOfType(ctx, type);
    for entity : entities {
        unit := getComponent(ctx, entity, WarUnitComponent);
        if (unit.player == player) {
            add(*unitsOfPlayer, entity);
        }
    }

    return unitsOfPlayer;
}

getUIEntities :: (ctx: *WarContext) -> List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    entityManager := *ctx.scene.entityManager;
    return entityManager.uiEntities;
}

renderEntity :: (ctx: *WarContext, entity: *WarEntity) {
    assert(ctx != null);
    assert(entity != null);

    gfx := ctx.gfx;

    if (entity.id > 0 && entity.enabled) {
        renderFn := renderFns[cast(s32) entity.type];
        if (!renderFn) {
            logError("Entity of type % can't be render. renderFn = NULL\n", entity.type);
            return;
        }

        nvgSave(gfx);
        renderFn(ctx, entity);
        nvgRestore(gfx);
    }
}

#scope_file

staticEntityId: WarEntityId = 0;

WarRenderFunc :: #type (ctx: *WarContext, entity: *WarEntity);

renderFns : [] WarRenderFunc = .[
    null,        // NONE
    renderImage, // IMAGE
    null,        // UNIT
    null,        // ROAD
    null,        // WALL
    null,        // RUIN
    null,        // FOREST
    null,        // TEXT
    null,        // RECT
    null,        // BUTTON
    renderImage, // CURSOR
    null,        // AUDIO
    null,        // PROJECTILE
    null,        // RAIN_OF_FIRE
    null,        // POISON_CLOUD
    null,        // SIGHT
    null,        // MINIMAP
    null,        // ANIMATION
];

renderImage :: (ctx: *WarContext, entity: *WarEntity) {
    gfx := ctx.gfx;

    transform := getComponent(ctx, entity, WarTransformComponent);
    ui := getComponent(ctx, entity, WarUIComponent);
    sprite := getComponent(ctx, entity, WarSpriteComponent);

    if (ui.enabled && sprite.enabled && sprite.frameIndex >= 0) {
        nvgSave(gfx);

        if (sprite.sprite.framesCount > 1) {
            frame := getSpriteFrame(ctx, sprite.sprite, sprite.frameIndex);
            updateSpriteImage(ctx, sprite.sprite, frame.data);

            nvgTranslate(gfx, cast(f32) -frame.dx, cast(f32) -frame.dy);
        }

        nvgTranslate(gfx, transform.position.x, transform.position.y);
        renderSprite(ctx, sprite.sprite, VEC2_ZERO, VEC2_ONE);
        nvgRestore(gfx);
    }
}