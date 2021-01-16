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
    components: [WarComponentType.Count] s32;
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

    manager := ctx.scene.entityManager;

    entity := addNew(*manager.entities);
    entity.id = staticEntityId;
    entity.type = type;
    entity.enabled = true;

    for i : 0..cast(s32) WarComponentType.Count - 1 {
        entity.components[i] = -1;
    }

    set(*manager.entitiesById, entity.id, entity);

    found, entitiesOfType := ref(*manager.entitiesByType, type);
    if (found) {
        add(entitiesOfType, entity);
    }

    if (isUIEntity(entity)) {
        add(*manager.uiEntities, entity);
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
        init(*list, List(*WarEntity).{
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
        init(*list, List(*WarEntity).{
            equalsFn = equalsEntity
        });
        set(*manager.unitsByType, entry.value, list);
    }

    // initialize the entities by id map
    init(*manager.entitiesById, HashMap(WarEntityId, *WarEntity).{
        hashFn = hashEntityId
    });

    // initialize ui entities list
    init(*manager.uiEntities, List(*WarEntity).{
        equalsFn = equalsEntity
    });
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
        unit := getComponent(WarUnitComponent, ctx, entity, WarComponentType.Unit);
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
        unit := getComponent(WarUnitComponent, ctx, entity, WarComponentType.Unit);
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

#scope_file

staticEntityId: WarEntityId = 0;
