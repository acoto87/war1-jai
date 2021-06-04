WarMapTilesetType :: enum {
    Forest;
    Swamp;
    Dungeon;
}

WarMap :: struct {
    using baseMap: Map;
    // base.type = WarSceneType.Map;

    levelInfoIndex: u32;

    // panels of the ui, in screen coordinates
    leftTopPanel: Rect;
    leftBottomPanel: Rect;
    topPanel: Rect;
    bottomPanel: Rect;
    rightPanel: Rect;
    mapPanel: Rect;
    minimapPanel: Rect;
    menuPanel: Rect;
    messagePanel: Rect;
    saveLoadPanel: Rect;

    tilesetType: WarMapTilesetType;
}

createMap :: (levelInfoIndex: u32) -> *WarMap {
    map := createScene(WarMap);
    map.tilesWidth = MAP_TILES_WIDTH;
    map.tilesHeight = MAP_TILES_HEIGHT;
    map.levelInfoIndex = levelInfoIndex;
    map.enterSceneFn = enterMap;
    map.leaveSceneFn = leaveMap;
    map.updateSceneFn = updateMap;
    map.renderSceneFn = renderMap;
    return map;
}

#scope_file

enterMap :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    map := cast(*WarMap) ctx.scene;
    assert(map != null);

    levelInfo := getOrCreateResource(WarResourceLevelInfo, map.levelInfoIndex);
    assert(levelInfo != null);

    levelPassable := getOrCreateResource(WarResourceLevelPassable, levelInfo.passableIndex);
    assert(levelPassable != null);

    map.playing = true;
    map.custom = levelInfo.customMap;
    map.replay = false;
    map.observer = false;
    map.uiPlayer = 0;
    map.tilesetType = cast(WarMapTilesetType) levelInfo.tilesetType;
    map.fowEnabled = true;
    map.result = LevelResult.None;
    map.objectivesTime = 1;
    map.playersCount = 2;

    map.settings.gameSpeed = MapSpeed.Normal;
    map.settings.mouseScrollSpeed = MapSpeed.Normal;
    map.settings.keyScrollSpeed = MapSpeed.Normal;

    map.leftTopPanel = rect(0, 0, 72, 72);
    map.leftBottomPanel = rect(0, 72, 72, 128);
    map.rightPanel = rect(312, 0, 8, 200);
    map.topPanel = rect(72, 0, 240, 12);
    map.bottomPanel = rect(72, 188, 240, 12);
    map.mapPanel = rect(72, 12, MAP_VIEWPORT_WIDTH, MAP_VIEWPORT_HEIGHT);
    map.minimapPanel = rect(3, 6, MINIMAP_WIDTH, MINIMAP_HEIGHT);
    map.menuPanel = rect(84, 32, 152, 136);
    map.messagePanel = rect(17, 76, 286, 48);
    map.saveLoadPanel = rect(48, 27, 223, 146);

    startX := levelInfo.startX * MEGA_TILE_WIDTH;
    startY := levelInfo.startY * MEGA_TILE_HEIGHT;
    map.viewport = rect(startX, startY, MAP_VIEWPORT_WIDTH, MAP_VIEWPORT_HEIGHT);

    // map.finder = initPathFinder(PathFindingType.Astar, MAP_TILES_WIDTH, MAP_TILES_HEIGHT, levelPassable.data);

    // create the black sprite
    // {
    //     data: [MEGA_TILE_WIDTH * MEGA_TILE_HEIGHT * 4] u8;
    //     for i : range(s32, 0, MEGA_TILE_WIDTH * MEGA_TILE_HEIGHT) {
    //         data[4 * i + 3] = 255;
    //     }

    //     map.blackSprite = createSprite(MEGA_TILE_WIDTH, MEGA_TILE_HEIGHT, data.data);
    // }

    // create the map sprite
    // {
    //     levelVisual := getOrCreateResource(WarResourceLevelVisual, levelInfo.visualIndex);
    //     assert(levelVisual != null);

    //     tileset := getOrCreateResource(WarResourceTileset, levelInfo.tilesetIndex);
    //     assert(tileset != null);

    //     // DEBUG:
    //     // print level visual data to console to see the sprites of the map
    //     //
    //     // for(s32 y = 0; y < MAP_TILES_HEIGHT; y++)
    //     // {
    //     //     for(s32 x = 0; x < MAP_TILES_WIDTH; x++)
    //     //     {
    //     //         // index of the tile in the tilesheet
    //     //         u16 tileIndex = levelVisual.levelVisual.data[y * MAP_TILES_WIDTH + x];
    //     //         printf("%d ", tileIndex);
    //     //     }

    //     //     printf("\n");
    //     // }

    //     map.sprite = createSprite(TILESET_WIDTH, TILESET_HEIGHT, tileset.data.data);

    //     // the minimap sprite will be a 2 frames sprite
    //     // the first one will be the frame that actually render
    //     // the second one will be the minimap for the terrain, created at startup time,
    //     // that way I only have to memcpy to the first frame and do the work only for the units
    //     // that way I also don't have to allocate memory for the minimap each frame
    //     minimapFrames: [2] SpriteFrame;

    //     for * frame : minimapFrames {
    //         frame.dx = 0;
    //         frame.dy = 0;
    //         frame.w = MINIMAP_WIDTH;
    //         frame.h = MINIMAP_HEIGHT;
    //         frame.off = 0;
    //         frame.data = alloc(u8, MINIMAP_WIDTH * MINIMAP_HEIGHT * 4);

    //         // make the frame black
    //         for k : range(s32, 0, MINIMAP_WIDTH * MINIMAP_HEIGHT) {
    //             frame.data[k * 4 + 3] = 255;
    //         }
    //     }

    //     for y : range(s32, 0, MAP_TILES_HEIGHT) {
    //         for x : range(s32, 0, MAP_TILES_WIDTH) {
    //             color := getMapTileAverage(levelVisual, tileset, x, y);
    //             index := y * MAP_TILES_WIDTH + x;
    //             minimapFrames[1].data[index * 4 + 0] = color.r;
    //             minimapFrames[1].data[index * 4 + 1] = color.g;
    //             minimapFrames[1].data[index * 4 + 2] = color.b;
    //             minimapFrames[1].data[index * 4 + 3] = color.a;
    //         }
    //     }

    //     map.minimapSprite = createSpriteFromFrames(MINIMAP_WIDTH, MINIMAP_HEIGHT, minimapFrames);
    // }

    // create the forest entities
    // {
    //     bool processed[MAP_TILES_WIDTH * MAP_TILES_HEIGHT];
    //     for(s32 i = 0; i < MAP_TILES_WIDTH * MAP_TILES_HEIGHT; i++)
    //         processed[i] = false;

    //     u16* passableData = levelPassable.data;
    //     for(s32 i = 0; i < MAP_TILES_WIDTH * MAP_TILES_HEIGHT; i++)
    //     {
    //         if (!processed[i] && passableData[i] == 128)
    //         {
    //             s32 x = i % MAP_TILES_WIDTH;
    //             s32 y = i / MAP_TILES_WIDTH;

    //             WarTreeList trees;
    //             WarTreeListInit(&trees, WarTreeListDefaultOptions);
    //             WarTreeListAdd(&trees, createTree(x, y, TREE_MAX_WOOD));
    //             processed[i] = true;

    //             for(s32 j = 0; j < trees.count; j++)
    //             {
    //                 WarTree tree = trees.items[j];
    //                 for(s32 d = 0; d < dirC; d++)
    //                 {
    //                     s32 xx = tree.tilex + dirX[d];
    //                     s32 yy = tree.tiley + dirY[d];
    //                     if (isInside(map.finder, xx, yy))
    //                     {
    //                         s32 k = yy * MAP_TILES_WIDTH + xx;
    //                         if (!processed[k] && passableData[k] == 128)
    //                         {
    //                             // mark it processed right away, to not process it later
    //                             processed[k] = true;

    //                             WarTree newTree = createTree(xx, yy, TREE_MAX_WOOD);
    //                             WarTreeListAdd(&trees, newTree);
    //                         }
    //                     }
    //                 }
    //             }

    //             WarEntity* forest = createEntity(WAR_ENTITY_TYPE_FOREST, true);
    //             addSpriteComponent(forest, map.sprite);
    //             addForestComponent(forest, trees);

    //             for (s32 i = 0; i < trees.count; i++)
    //             {
    //                 WarTree* tree = &trees.items[i];
    //                 setStaticEntity(map.finder, tree.tilex, tree.tiley, 1, 1, forest.id);
    //             }

    //             determineTreeTiles(forest);
    //         }
    //     }

    //     map.forest = createForest(context);;
    // }

    // create the starting roads
    // {
    //     WarEntity* road = createRoad(context);

    //     for(s32 i = 0; i < levelInfo.startRoadsCount; i++)
    //     {
    //         WarLevelConstruct *construct = &levelInfo.startRoads[i];
    //         if (construct.type == WAR_CONSTRUCT_ROAD)
    //         {
    //             addRoadPiecesFromConstruct(road, construct);
    //         }
    //     }

    //     determineRoadTypes(road);

    //     map.road = road;
    // }

    // create the starting walls
    // {
    //     WarEntity* wall = createWall(context);

    //     for(s32 i = 0; i < levelInfo.startWallsCount; i++)
    //     {
    //         WarLevelConstruct *construct = &levelInfo.startWalls[i];
    //         if (construct.type == WAR_CONSTRUCT_WALL)
    //         {
    //             addWallPiecesFromConstruct(wall, construct);
    //         }
    //     }

    //     determineWallTypes(wall);

    //     for(s32 i = 0; i < wall.wall.pieces.count; i++)
    //     {
    //         WarWallPiece* piece = &wall.wall.pieces.items[i];
    //         piece.hp = WAR_WALL_MAX_HP;
    //         piece.maxhp = WAR_WALL_MAX_HP;
    //     }

    //     addStateMachineComponent(wall);

    //     sendToIdleState(wall, false);

    //     map.wall = wall;
    // }

    // create ruins
    // {
    //     map.ruin = createRuins(context);
    // }

    // create players info
    {
        for * player, i : map.players {
            player.index = cast(u8) i;
            player.race = cast(Race) levelInfo.races[i];
            player.resources[WarResourceKind.Gold] = cast(s32) levelInfo.gold[i];
            player.resources[WarResourceKind.Wood] = cast(s32) levelInfo.lumber[i];
            player.godMode = false;

            // for (s32 j = 0; j < MAX_FEATURES_COUNT; j++)
            // {
            //     player.features[j] = levelInfo.allowedFeatures[j];
            // }

            // for (s32 j = 0; j < MAX_UPGRADES_COUNT; j++)
            // {
            //     player.upgrades[j].allowed = levelInfo.allowedUpgrades[j][i];
            //     player.upgrades[j].level = 0;
            // }

            // memset(player.squads, 0, sizeof(player.squads));

            // WarCommandListInit(&player.commands, WarCommandListDefaultOptions);

            // for (s32 j = 0; j < MAP_TILES_WIDTH * MAP_TILES_HEIGHT; j++)
            // {
            //     WarMapTile* tile = &player.tiles[j];
            //     tile.state = MAP_TILE_STATE_UNKOWN;
            //     tile.type = WAR_FOG_PIECE_NONE;
            //     tile.boundary = WAR_FOG_BOUNDARY_NONE;
            // }
        }
    }

    // create the starting entities
    // {
    //     for i : range(s32, 0, levelInfo.startEntitiesCount) {
    //         startUnit := levelInfo.startEntities[i];
    //         createUnit(startUnit.type, startUnit.x, startUnit.y, startUnit.player,
    //                    startUnit.resourceKind, startUnit.amount, true);
    //     }
    // }

    // init AI
    // initAIPlayers(context);

    // add cheats
    registerBuiltInCheats();
    registerCheats();

    // add ui entities
    createMapUI();
    // createMenu(context);
    // createOptionsMenu(context);
    // createObjectivesMenu(context);
    // createRestartMenu(context);
    // createGameOverMenu(context);
    // createQuitMenu(context);
    // createDemoEndMenu(context);
    // createUICursor("cursor", WAR_CURSOR_ARROW, VEC2_ZERO);

    // if (!isDemo(context))
    //     createAudio(WAR_MUSIC_00, true);
}

leaveMap :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    map := cast(*WarMap) ctx.scene;
    assert(map != null);

    freeSprite(map.sprite);
    freeSprite(map.minimapSprite);
    freeSprite(map.blackSprite);

    uninit(*map.selectedEntities);

    freePathFinder(map.finder);
    freeScene(map);
}

renderMap :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    nvgSave(ctx.gfx);

    // render map
    // renderMapPanel();

    // render ui
    renderMapUI();

    nvgRestore(ctx.gfx);
}

// renderMapPanel :: () {
//     ctx := cast(*WarContext) context.gameContext;
//     assert(ctx != null);

//     map := cast(*WarMap) ctx.scene;
//     assert(map != null);

//     nvgSave(ctx.gfx);

//     nvgTranslate(ctx.gfx, map.mapPanel.x, map.mapPanel.y);
//     nvgTranslate(ctx.gfx, -map.viewport.x, -map.viewport.y);

//     renderTerrain();
//     // renderEntitiesOfType(WAR_ENTITY_TYPE_RUIN);
//     // renderEntitiesOfType(WAR_ENTITY_TYPE_ROAD);
//     // renderEntitiesOfType(WAR_ENTITY_TYPE_WALL);
//     // renderEntitiesOfType(WAR_ENTITY_TYPE_FOREST);

//     // if (map.renderDebugPaths) {
//     //     renderUnitPaths();
//     // }

//     // if (map.renderDebugPassable) {
//     //     renderPassableInfo();
//     // }

//     // if (map.renderDebugGrid) {
//     //     renderMapGrid();
//     // }

//     // renderEntitiesOfType(WAR_ENTITY_TYPE_UNIT);
//     // renderUnitSelection();
//     // renderEntitiesOfType(WAR_ENTITY_TYPE_PROJECTILE);
//     // renderEntitiesOfType(WAR_ENTITY_TYPE_POISON_CLOUD);
//     // renderEntitiesOfType(WAR_ENTITY_TYPE_ANIMATION);
//     // renderFoW();

//     nvgRestore(ctx.gfx);
// }

// renderTerrain :: () {
//     ctx := cast(*WarContext) context.gameContext;
//     assert(ctx != null);

//     map := cast(*WarMap) ctx.scene;
//     assert(map != null);

//     uiPlayer := getMapUIPlayer(map);

//     levelInfo := getOrCreateResource(WarResourceLevelInfo, map.levelInfoIndex);
//     assert(levelInfo != null);

//     levelVisual := getOrCreateResource(WarResourceLevelVisual, levelInfo.visualIndex);
//     assert(levelVisual != null);

//     batch := nvgBeginImageBatch(ctx.gfx, map.sprite.image, MAP_TILES_WIDTH * MAP_TILES_HEIGHT);

//     for y : range(s32, 0, MAP_TILES_HEIGHT) {
//         for x : range(s32, 0, MAP_TILES_WIDTH) {
//             if (!map.fowEnabled) {
//                 // index of the tile in the tilesheet
//                 tileIndex := levelVisual.data[y * MAP_TILES_WIDTH + x];

//                 // coordinates in pixels of the terrain tile
//                 tilePixelX := (tileIndex % TILESET_TILES_PER_ROW) * MEGA_TILE_WIDTH;
//                 tilePixelY := (tileIndex / TILESET_TILES_PER_ROW) * MEGA_TILE_HEIGHT;

//                 nvgSave(ctx.gfx);
//                 nvgTranslate(ctx.gfx, cast(f32) x * MEGA_TILE_WIDTH, cast(f32) y * MEGA_TILE_HEIGHT);

//                 rs := rect(tilePixelX, tilePixelY, MEGA_TILE_WIDTH, MEGA_TILE_HEIGHT);
//                 rd := rect(0, 0, MEGA_TILE_WIDTH, MEGA_TILE_HEIGHT);
//                 nvgRenderBatchImage(ctx.gfx, batch, rs, rd, VEC2_ONE);

//                 nvgRestore(ctx.gfx);
//             } else {
//                 assert(uiPlayer != null);

//                 tile := getMapTileState(map, uiPlayer, x, y);
//                 if (tile.state == MapTileState.Visible ||
//                     tile.state == MapTileState.Fog)
//                 {
//                     // index of the tile in the tilesheet
//                     tileIndex := levelVisual.data[y * MAP_TILES_WIDTH + x];

//                     // coordinates in pixels of the terrain tile
//                     tilePixelX := (tileIndex % TILESET_TILES_PER_ROW) * MEGA_TILE_WIDTH;
//                     tilePixelY := (tileIndex / TILESET_TILES_PER_ROW) * MEGA_TILE_HEIGHT;

//                     nvgSave(ctx.gfx);
//                     nvgTranslate(ctx.gfx, cast(f32) x * MEGA_TILE_WIDTH, cast(f32) y * MEGA_TILE_HEIGHT);

//                     rs := rect(tilePixelX, tilePixelY, MEGA_TILE_WIDTH, MEGA_TILE_HEIGHT);
//                     rd := rect(0, 0, MEGA_TILE_WIDTH, MEGA_TILE_HEIGHT);
//                     nvgRenderBatchImage(ctx.gfx, batch, rs, rd, VEC2_ONE);

//                     nvgRestore(ctx.gfx);
//                 }
//             }
//         }
//     }

//     nvgEndImageBatch(ctx.gfx, batch);
// }

// getMapTileAverage :: (levelVisual : *WarResourceLevelVisual, tileset: *WarResourceTileset, x: s32, y: s32) -> Color {
//     index := y * MAP_TILES_WIDTH + x;
//     tileIndex := levelVisual.data[index];

//     tilePixelX := (tileIndex % TILESET_TILES_PER_ROW) * MEGA_TILE_WIDTH;
//     tilePixelY := (tileIndex / TILESET_TILES_PER_ROW) * MEGA_TILE_HEIGHT;

//     r, g, b: s32;

//     for ty : range(s32, 0, MEGA_TILE_HEIGHT) {
//         for tx : range(s32, 0, MEGA_TILE_WIDTH) {
//             pixel := (tilePixelY + ty) * TILESET_WIDTH + (tilePixelX + tx);
//             r += tileset.data[pixel * 4 + 0];
//             g += tileset.data[pixel * 4 + 1];
//             b += tileset.data[pixel * 4 + 2];
//         }
//     }

//     r /= 256;
//     g /= 256;
//     b /= 256;

//     return rgba(cast(u8) r, cast(u8) g, cast(u8) b, 255);
// }

// getMapUIPlayer :: (map: *WarMap) -> *PlayerInfo {
//     if (map.observer) {
//         if (map.uiPlayer < 0) {
//             // NOTE: If the uiPlayer is -1 it means there is no specific ui player,
//             // then FoW need to be disabled
//             assert(!map.fowEnabled);
//             return null;
//         }

//         return *map.players[map.uiPlayer];
//     }

//     // NOTE: If there is no observer, then there must be always an ui player (the human player)
//     assert(map.uiPlayer == 0);
//     return *map.players[map.uiPlayer];
// }