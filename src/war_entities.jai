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
    entitiesById: HashMap(WarEntityId, WarEntity);
    entitiesByType: HashMap(WarEntityType, List(WarEntityId));
    unitsByType: HashMap(WarUnitType, List(WarEntityId));
    uiEntities: List(WarEntityId);
}

operator == :: (e1: WarEntity, e2: WarEntity) -> bool {
    return e1.id == e2.id;
}

equalsEntity :: inline (e1: WarEntity, e2: WarEntity) -> bool {
    return e1.id == e2.id;
}

equalsEntity :: inline (e1: *WarEntity, e2: *WarEntity) -> bool {
    return e1.id == e2.id;
}

hashEntityType :: inline (type: WarEntityType) -> s64 {
    return cast(s64) type;
}

hashUnitType :: inline (type: WarUnitType) -> s64 {
    return cast(s64) type;
}

hashEntityId :: inline (id: WarEntityId) -> s64 {
    return cast(s64) id;
}

initEntityManager :: (manager: *WarEntityManager) {
    // initialize the entities by id map
    init(*manager.entitiesById, HashMapOptions(WarEntityId, WarEntity).{
        hashFn = hashEntityId
    });

    // initialize entity by type map
    init(*manager.entitiesByType, HashMapOptions(WarEntityType, List(WarEntityId)).{
        hashFn = hashEntityType
    });

    for entry : iterate(WarEntityType) {
        set(*manager.entitiesByType, entry.value, createList(WarEntityId));
    }

    // initialize unit by type map
    init(*manager.unitsByType, HashMapOptions(WarUnitType, List(WarEntityId)).{
        hashFn = hashUnitType
    });

    for entry : iterate(WarUnitType) {
        set(*manager.unitsByType, entry.value, createList(WarEntityId));
    }

    // initialize ui entities list
    init(*manager.uiEntities);
}

freeEntityManager :: (manager: *WarEntityManager) {
    uninit(*manager.entitiesById);
    uninit(*manager.entitiesByType);
    uninit(*manager.unitsByType);
    uninit(*manager.uiEntities);
}

createEntity :: (ctx: *WarContext, type: WarEntityType) -> *WarEntity {
    assert(ctx != null);
    assert(ctx.scene != null);

    staticEntityId += 1;

    entityManager := *ctx.scene.entityManager;

    entity: WarEntity;
    entity.id = staticEntityId;
    entity.type = type;
    entity.enabled = true;

    for i : range(s32, 0, #run getCount(WarComponentType)) {
        entity.components[i] = -1;
    }

    set(*entityManager.entitiesById, entity.id, entity);

    found, entitiesOfType := ref(*entityManager.entitiesByType, type);
    if (found) {
        add(entitiesOfType, entity.id);
    }

    if (isUIEntity(*entity)) {
        add(*entityManager.uiEntities, entity.id);
    }

    _, result := ref(*entityManager.entitiesById, entity.id);
    return result;
}

removeEntityById :: (ctx: *WarContext, id: WarEntityId) {
    assert(ctx != null);
    assert(ctx.scene != null);

    entityManager := *ctx.scene.entityManager;

    logDebug("trying to remove entity with id: %\n", id);

    entity := findEntity(ctx, id);
    if (entity != null) {
        // pthread_mutex_lock(&context.__mutex);

        if (isUIEntity(entity)) {
            removeItem(*entityManager.uiEntities, entity.id);
        } else if (isUnit(entity)) {
            unit := getComponent(ctx, entity, WarUnitComponent);
            found, entities := ref(*entityManager.unitsByType, unit.unitType);
            if (found) {
                removeItem(entities, entity.id);
            }
        }

        found, entities := ref(*entityManager.entitiesByType, entity.type);
        if (found) {
            removeItem(entities, entity.id);
        }

        for entry : iterate(WarComponentType) {
            removeComponent(ctx, entity, entry.value);
        }

        removeKey(*entityManager.entitiesById, entity.id);

        // pthread_mutex_unlock(&context.__mutex);

        logDebug("removed entity with id: %\n", id);
    }
}

getEntitiesOfType :: (ctx: *WarContext, type: WarEntityType) -> List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    entitiesOfType := createList(*WarEntity);

    entityManager := *ctx.scene.entityManager;
    found, entities := ref(*entityManager.entitiesByType, type);
    if (found) {
        for id : entities {
            found, entity := ref(*entityManager.entitiesById, id);
            assert(found && entity != null);

            add(*entitiesOfType, entity);
        }
    }

    return entitiesOfType;
}

getUnitsOfType :: (ctx: *WarContext, type: WarUnitType) -> List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    unitsOfType := createList(*WarEntity);

    entityManager := *ctx.scene.entityManager;
    found, entities := ref(*entityManager.unitsByType, type);
    if (found) {
        for id : entities {
            found, entity := ref(*entityManager.entitiesById, id);
            assert(found && entity != null);

            add(*unitsOfType, entity);
        }
    }

    return unitsOfType;
}

getUnitsOfPlayer :: (ctx: *WarContext, player: u8) -> List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    unitsOfPlayer := createList(*WarEntity);

    entityManager := *ctx.scene.entityManager;
    found, entities := ref(*entityManager.entitiesByType, WarEntityType.Unit);
    if (found) {
        for id : entities {
            found, entity := ref(*entityManager.entitiesById, id);
            assert(found && entity != null);

            unit := getComponent(ctx, entity, WarUnitComponent);
            assert(unit != null);

            if (unit.player == player) {
                add(*unitsOfPlayer, entity);
            }
        }
    }

    return unitsOfPlayer;
}

getUnitsOfTypeOfPlayer :: (ctx: *WarContext, type: WarUnitType, player: u8) -> List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    unitsOfPlayer := createList(*WarEntity);

    entityManager := *ctx.scene.entityManager;
    found, entities := ref(*entityManager.unitsByType, type);
    if (found) {
        for id : entities {
            found, entity := ref(*entityManager.entitiesById, id);
            assert(found && entity != null);

            unit := getComponent(ctx, entity, WarUnitComponent);
            assert(unit != null);

            if (unit.player == player) {
                add(*unitsOfPlayer, entity);
            }
        }
    }

    return unitsOfPlayer;
}

getUIEntities :: (ctx: *WarContext) -> List(*WarEntity) {
    assert(ctx != null);
    assert(ctx.scene != null);

    uiEntities := createList(*WarEntity);

    entityManager := *ctx.scene.entityManager;
    for id : entityManager.uiEntities {
        found, entity := ref(*entityManager.entitiesById, id);
        assert(found && entity != null);

        if (isUIEntity(entity)) {
            add(*uiEntities, entity);
        }
    }

    return uiEntities;
}

findEntity :: (ctx: *WarContext, id: WarEntityId) -> *WarEntity {
    assert(ctx != null);
    assert(ctx.scene != null);

    entityManager := *ctx.scene.entityManager;
    found, entity := ref(*entityManager.entitiesById, id);
    return ifx found then entity else null;
}

findEntityAt :: (ctx: *WarContext, targetTile: Vec2) -> *WarEntity {
    assert(ctx != null);
    assert(ctx.scene != null);
    assert(ctx.scene.type == WarSceneType.Map);

    map := cast(*WarMap) ctx.scene;

    entityId := getTileEntityId(map.finder, cast(s32) targetTile.x, cast(s32) targetTile.y);
    return findEntity(ctx, entityId);
}

// findClosestUnitOfType :: (ctx: *WarContext, entity: *WarEntity, type: WarUnitType, isAccessible: bool) -> *WarEntity {
//     WarEntity* result = NULL;
//     f32 minDst = INT32_MAX;

//     WarEntityList* units = getEntitiesOfType(context, WAR_ENTITY_TYPE_UNIT);
//     assert(units);

//     for (s32 i = 0; i < units->count; i++)
//     {
//         WarEntity* target = units->items[i];
//         if (isUnitOfType(target, type))
//         {
//             if (!isAccessible || isUnitAccessible(context, entity, target))
//             {
//                 s32 dst = unitDistanceInTilesToUnit(entity, target);
//                 if (dst < minDst)
//                 {
//                     result = target;
//                     minDst = dst;
//                 }
//             }

//         }
//     }

//     return result;
// }

// WarEntity* findClosestForest(ctx: *WarContext, WarEntity* entity)
// {
//     WarEntity* result = NULL;
//     f32 minDst = INT32_MAX;

//     vec2 entityPosition = vec2MapToTileCoordinates(entity->transform.position);

//     WarEntityList* forests = getEntitiesOfType(context, WAR_ENTITY_TYPE_FOREST);
//     assert(forests);

//     for (s32 i = 0; i < forests->count; i++)
//     {
//         WarEntity* forest = forests->items[i];
//         if (forest)
//         {
//             // FACTOR: find the closets tree on the forest to the entity
//             for (s32 j = 0; j < forest->forest.trees.count; j++)
//             {
//                 WarTree* tree = &forest->forest.trees.items[j];
//                 if (tree)
//                 {
//                     vec2 treePosition = vec2i(tree->tilex, tree->tiley);
//                     s32 dst = vec2DistanceInTiles(entityPosition, treePosition);
//                     if (dst < minDst)
//                     {
//                         result = forest;
//                         minDst = dst;
//                     }
//                 }
//             }
//         }
//     }

//     return result;
// }

findUIEntity :: (ctx: *WarContext, name: string) -> *WarEntity {
    assert(ctx != null);
    assert(ctx.scene != null);

    entityManager := *ctx.scene.entityManager;
    for id : entityManager.uiEntities {
        found, entity := ref(*entityManager.entitiesById, id);
        assert(found && entity != null);

        ui := getComponent(ctx, entity, WarUIComponent);
        assert(ui != null);

        if (ui.name == name) {
            return entity;
        }
    }

    return null;
}

// WarEntity* findEntityUnderCursor(ctx: *WarContext, bool includeTrees, bool includeWalls)
// {
//     WarInput* input = &context->input;
//     WarMap* map = context->map;

//     WarPlayerInfo* uiPlayer = getMapUIPlayer(map);

//     vec2 targetPoint = vec2ScreenToMapCoordinates(context, input->pos);
//     vec2 targetTile = vec2MapToTileCoordinates(targetPoint);

//     WarEntity* entityUnderCursor = NULL;

//     WarEntityList* units = getEntitiesOfType(context, WAR_ENTITY_TYPE_UNIT);
//     for(s32 i = 0; i < units->count; i++)
//     {
//         WarEntity* entity = units->items[i];
//         if (entity)
//         {
//             WarUnitComponent* unit = &entity->unit;
//             if (unit->enabled)
//             {
//                 // don't change the cursor for dead units or corpses
//                 if (isDeadUnit(entity) || isCorpseUnit(entity))
//                 {
//                     continue;
//                 }

//                 // don't change the cursor for collased buildings
//                 if (isCollapsedUnit(entity))
//                 {
//                     continue;
//                 }

//                 // don't change the cursor for non-visible units
//                 if (!isUnitPartiallyVisible(map, uiPlayer, entity))
//                 {
//                     continue;
//                 }
//             }

//             rect unitRect = getUnitRect(entity);
//             if (rectContainsf(unitRect, targetPoint.x, targetPoint.y))
//             {
//                 entityUnderCursor = entity;
//                 break;
//             }
//         }
//     }

//     if (includeTrees && !entityUnderCursor)
//     {
//         WarEntityList* forests = getEntitiesOfType(context, WAR_ENTITY_TYPE_FOREST);
//         for (s32 i = 0; i < forests->count; i++)
//         {
//             WarEntity* forest = forests->items[i];
//             if (forest)
//             {
//                 WarTreeList* trees = &forest->forest.trees;
//                 for (s32 k = 0; k < trees->count; k++)
//                 {
//                     WarTree tree = trees->items[k];
//                     if (tree.tilex == (s32)targetTile.x &&
//                         tree.tiley == (s32)targetTile.y)
//                     {
//                         if (tree.type != WAR_TREE_NONE &&
//                             tree.type != WAR_TREE_CHOPPED)
//                         {
//                             entityUnderCursor = forest;
//                         }

//                         break;
//                     }
//                 }
//             }

//             if (entityUnderCursor)
//             {
//                 break;
//             }
//         }
//     }

//     // if there is no unit under the cursor, check the walls
//     if (includeWalls && !entityUnderCursor)
//     {
//         WarEntityList* walls = getEntitiesOfType(context, WAR_ENTITY_TYPE_WALL);
//         for (s32 i = 0; i < walls->count; i++)
//         {
//             WarEntity* wall = walls->items[i];
//             if (wall)
//             {
//                 WarWallPieceList* pieces = &wall->wall.pieces;
//                 for (s32 k = 0; k < pieces->count; k++)
//                 {
//                     WarWallPiece piece = pieces->items[k];
//                     if (piece.tilex == (s32)targetTile.x &&
//                         piece.tiley == (s32)targetTile.y)
//                     {
//                         if (piece.hp > 0)
//                         {
//                             entityUnderCursor = wall;
//                         }

//                         break;
//                     }
//                 }
//             }

//             if (entityUnderCursor)
//             {
//                 break;
//             }
//         }
//     }

//     return entityUnderCursor;
// }

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

renderEntity :: (ctx: *WarContext, entity: *WarEntity) {
    assert(ctx != null);
    assert(entity != null);

    gfx := ctx.gfx;

    if (entity.id > 0 && entity.enabled) {
        renderFn := renderFns[cast(s32) entity.type];
        if (renderFn == null) {
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
    null,           // NONE
    renderImage,    // IMAGE
    null,           // UNIT
    null,           // ROAD
    null,           // WALL
    null,           // RUIN
    null,           // FOREST
    renderText,     // TEXT
    renderRect,     // RECT
    renderButton,   // BUTTON
    renderImage,    // CURSOR
    null,           // AUDIO
    null,           // PROJECTILE
    null,           // RAIN_OF_FIRE
    null,           // POISON_CLOUD
    null,           // SIGHT
    null,           // MINIMAP
    null,           // ANIMATION
];

renderImage :: (ctx: *WarContext, entity: *WarEntity) {
    gfx := ctx.gfx;

    transform := getComponent(ctx, entity, WarTransformComponent);
    assert(transform != null);

    ui := getComponent(ctx, entity, WarUIComponent);
    assert(ui != null);

    sprite := getComponent(ctx, entity, WarSpriteComponent);
    assert(sprite != null);

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

renderText :: (ctx: *WarContext, entity: *WarEntity) {
    gfx := ctx.gfx;

    transform := getComponent(ctx, entity, WarTransformComponent);
    assert(transform != null);

    ui := getComponent(ctx, entity, WarUIComponent);
    assert(ui != null);

    text := getComponent(ctx, entity, WarTextComponent);
    assert(text != null);

    if (ui.enabled && text.enabled && text.text) {
        nvgSave(gfx);
        nvgTranslate(gfx, transform.position.x, transform.position.y);
        nvgScale(gfx, transform.scale.x, transform.scale.y);

        params: NVGfontParams;
        params.fontIndex = text.fontIndex;
        params.fontSize = text.fontSize;
        params.lineHeight = text.lineHeight;
        params.fontColor = colorToNVGcolor(text.fontColor);
        params.highlightColor = colorToNVGcolor(text.highlightColor);
        params.highlightIndex = text.highlightIndex;
        params.highlightCount = text.highlightCount;
        params.boundings = text.boundings;
        params.horizontalAlign = textAlignToNVGalign(text.horizontalAlign);
        params.verticalAlign = textAlignToNVGalign(text.verticalAlign);
        params.lineAlign = textAlignToNVGalign(text.lineAlign);
        params.wrapping = textWrappingToNVGwrap(text.wrapping);
        params.trimming = textTrimmingToNVGtrim(text.trimming);
        params.fontSprite = ctx.fontSprites[text.fontIndex];
        params.fontData = fontsData[text.fontIndex];

        if (text.multiline) {
            nvgMultiSpriteText(gfx, toCString(text.text, tempAllocator), 0, 0, params);
        } else {
            nvgSingleSpriteText(gfx, toCString(text.text, tempAllocator), 0, 0, params);
        }

        nvgRestore(gfx);
    }
}

renderRect :: (ctx: *WarContext, entity: *WarEntity) {
    gfx := ctx.gfx;

    transform := getComponent(ctx, entity, WarTransformComponent);
    assert(transform != null);

    ui := getComponent(ctx, entity, WarUIComponent);
    assert(ui != null);

    rectComponent := getComponent(ctx, entity, WarRectComponent);
    assert(rectComponent != null);

    if (ui.enabled && rectComponent.enabled) {
        nvgSave(gfx);
        nvgTranslate(gfx, transform.position.x, transform.position.y);
        nvgScale(gfx, transform.scale.x, transform.scale.y);

        color := nvgRGBA(rectComponent.color.r, rectComponent.color.g, rectComponent.color.b, rectComponent.color.a);
        nvgFillRect(gfx, rect(0.0, 0.0, rectComponent.size.x, rectComponent.size.y), color);

        nvgRestore(gfx);
    }
}

renderButton :: (ctx: *WarContext, entity: *WarEntity) {
    gfx := ctx.gfx;

    transform := getComponent(ctx, entity, WarTransformComponent);
    assert(transform != null);

    ui := getComponent(ctx, entity, WarUIComponent);
    assert(ui != null);

    button := getComponent(ctx, entity, WarButtonComponent);
    assert(button != null);

    text := getComponent(ctx, entity, WarTextComponent);
    sprite := getComponent(ctx, entity, WarSpriteComponent);

    if (ui.enabled && button.enabled) {
        nvgSave(gfx);
        nvgTranslate(gfx, transform.position.x, transform.position.y);
        nvgScale(gfx, transform.scale.x, transform.scale.y);

        // render background
        {
            backgroundSprite := ifx button.active then button.pressedSprite else button.normalSprite;
            renderSprite(ctx, backgroundSprite, VEC2_ZERO, VEC2_ONE);
        }

        // render foreground
        {
            if (sprite != null && sprite.enabled) {
                backgroundSize := vec2(button.normalSprite.frameWidth, button.normalSprite.frameHeight);
                foregroundSize := vec2(sprite.sprite.frameWidth, sprite.sprite.frameHeight);
                offset := (backgroundSize - foregroundSize) / 2;

                if (button.active) {
                    offset = offset + vec2(0, 1);
                }

                nvgTranslate(gfx, offset.x, offset.y);

                frame := getSpriteFrame(ctx, sprite.sprite, sprite.frameIndex);
                updateSpriteImage(ctx, sprite.sprite, frame.data);
                renderSprite(ctx, sprite.sprite, VEC2_ZERO, VEC2_ONE);
            }
        }

        // render text
        {
            if (text != null && text.enabled) {
                params: NVGfontParams;
                params.fontIndex = text.fontIndex;
                params.fontSize = text.fontSize;
                params.fontColor = colorToNVGcolor(text.fontColor);
                params.highlightColor = colorToNVGcolor(text.highlightColor);
                params.highlightIndex = ifx button.hot then ALL_HIGHLIGHT else text.highlightIndex;
                params.highlightCount = text.highlightCount;
                params.boundings = text.boundings;
                params.horizontalAlign = textAlignToNVGalign(text.horizontalAlign);
                params.verticalAlign = textAlignToNVGalign(text.verticalAlign);
                params.lineAlign = textAlignToNVGalign(text.lineAlign);
                params.wrapping = textWrappingToNVGwrap(text.wrapping);
                params.fontSprite = ctx.fontSprites[text.fontIndex];
                params.fontData = fontsData[text.fontIndex];

                nvgSingleSpriteText(gfx, toCString(text.text, tempAllocator), 0, 0, params);
            }
        }

        nvgRestore(gfx);
    }
}