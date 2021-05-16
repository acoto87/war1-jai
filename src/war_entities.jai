
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

#scope_file
