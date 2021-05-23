WAR_BUILDING_DAMAGE_1_RESOURCE :: 352;
WAR_BUILDING_DAMAGE_2_RESOURCE :: 353;
WAR_BUILDING_COLLAPSE_RESOURCE :: 356;
WAR_EXPLOSION_RESOURCE :: 354;
WAR_RAIN_OF_FIRE_EXPLOSION_RESOURCE :: 351;
WAR_SPELL_RESOURCE :: 355;
WAR_POISON_CLOUD_RESOURCE :: 350;

WarResourceType :: enum {
    Unkown;
    Image;
    Palette;
    Xmid;
    Cursor;
    UI;
    Text;
    LevelInfo;
    LevelVisual;
    LeveLPassable;
    Sprite;
    Wave;
    Voc;
    Tileset;
    Tiles;
}

WarResource :: struct {
    type: WarResourceType;
}

WarResourcePalette :: struct {
    using base: WarResource;
    colors: [PALETTE_LENGTH] u8;
}

WarResourceImage :: struct {
    using base: WarResource;
    width: u16;
    height: u16;
    pixels: *u8;
}

WarResourceSprite :: struct {
    using base: WarResource;
    framesCount: u16;
    frameWidth: u8;
    frameHeight: u8;
    frames: [MAX_SPRITE_FRAME_COUNT] SpriteFrame;
}

WarResourceLevelInfo :: struct {
    using base: WarResource;
    allowId: u32;
    allowedHumanUnits: bool;
    allowedOrcsUnits: bool;
    customMap: bool;
    allowedFeatures: [MAX_FEATURES_COUNT] u8;
    allowedUpgrades: [MAX_UPGRADES_COUNT][MAX_PLAYERS_COUNT] u8;
    startX: u16;
    startY: u16;
    nextLevelIndex: u16;
    visualIndex: u16;
    passableIndex: u16;
    paletteIndex: u16;
    tilesIndex: u16;
    tilesetIndex: u16;
    tilesetType: u16;
    lumber: [MAX_PLAYERS_COUNT] u32;
    gold: [MAX_PLAYERS_COUNT] u32;
    races: [MAX_PLAYERS_COUNT] WarRace;
    objectives: [MAX_OBJECTIVES_LENGTH] u8;

    startEntitiesCount: u32;
    startEntities: [MAX_ENTITIES_COUNT] WarLevelUnit;

    startRoadsCount: u32;
    startRoads: [MAX_CONSTRUCTS_COUNT] WarLevelConstruct;

    startWallsCount: u32;
    startWalls: [MAX_CONSTRUCTS_COUNT] WarLevelConstruct;

    startGoldminesCount: u32;
    startGoldmines: [MAX_CUSTOM_MAP_GOLDMINES_COUNT] WarLevelUnit;

    startConfigurationsCount: u32;
    startConfigurations: [MAX_CUSTOM_MAP_CONFIGURATIONS_COUNT] WarCustomMapConfiguration;
}

WarResourceLevelVisual :: struct {
    using base: WarResource;
    data: [MAP_TILES_WIDTH * MAP_TILES_HEIGHT] u16;
}

WarResourceLevelPassable :: struct {
    using base: WarResource;
    data: [MAP_TILES_WIDTH * MAP_TILES_HEIGHT] u16;
}

WarResourceTileset :: struct {
    using base: WarResource;
    tilesCount: u32;
    data: [TILESET_WIDTH * TILESET_HEIGHT * 4] u8;
}

WarResourceTiles :: struct {
    using base: WarResource;
    palette1, palette2: u16;
    data: *u8;
}

WarResourceText :: struct {
    using base: WarResource;
    length: u32;
    text: *u8;
}

WarResourceAudio :: struct {
    using base: WarResource;
    length: s32;
    data: *u8;
}

WarResourceCursor :: struct {
    using base: WarResource;
    hotx: u16;
    hoty: u16;
    width: u16;
    height: u16;
    pixels: *u8;
}

WarLevelUnit :: struct {
    x, y: u8;
    type: WarUnitType;
    player: u8;
    resourceKind: WarResourceKind;
    amount: u16;
}

WarConstructType :: enum {
    Unkown;
    Road;
    Wall;
}

WarLevelConstruct :: struct {
    type: WarConstructType;
    x1, y1: u8;
    x2, y2: u8;
    player: u8;
}

WarCustomMapConfiguration :: struct {
    startEntitiesCount: u32;
    startEntities: [MAX_CUSTOM_MAP_ENTITIES_COUNT] WarLevelUnit;
}

getOrCreateResource :: ($resourceType: Type, index: u32) -> *resourceType {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    assert(index >= 0 && index < cast(u32) MAX_RESOURCES_COUNT);
    if (ctx.resources[index] == null) {
        logInfo("Creating resource: %\n", index);
        ctx.resources[index] = alloc(resourceType);
    }
    return cast(*resourceType) ctx.resources[index];
}

getPalette :: (palette1Index: u32, palette2Index: u32, paletteData: [] u8) {
    arrayClear(paletteData);

    if (palette1Index) {
        palette1 := getOrCreateResource(WarResourcePalette, palette1Index);
        arrayCopy(palette1.colors, paletteData);
    }

    // probably only the palettes 191, 194, 197 need this to use a second palette for the background
    // for now leave it whenever there is specified a second palette on the entry
    if (palette2Index) {
        palette2 := getOrCreateResource(WarResourcePalette, palette2Index);

        for i : range(s32, 0, 128) {
            if (paletteData[i * 3 + 0] == 252 &&
                paletteData[i * 3 + 1] == 0 &&
                paletteData[i * 3 + 2] == 252)
            {
                paletteData[i * 3 + 0] = palette2.colors[i * 3 + 0];
                paletteData[i * 3 + 0] = palette2.colors[i * 3 + 1];
                paletteData[i * 3 + 0] = palette2.colors[i * 3 + 2];
            }
        }

        for i : range(s32, 128, 256) {
            if (!(palette2.colors[i * 3 + 0] == 252 &&
                  palette2.colors[i * 3 + 1] == 0 &&
                  palette2.colors[i * 3 + 2] == 252))
            {
                paletteData[i * 3 + 0] = palette2.colors[i * 3 + 0];
                paletteData[i * 3 + 1] = palette2.colors[i * 3 + 1];
                paletteData[i * 3 + 2] = palette2.colors[i * 3 + 2];
            }
        }
    }
}

loadPaletteResource :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    if (rawResource.length < cast(u32) PALETTE_LENGTH) {
        rawResource.data = realloc(rawResource.data, PALETTE_LENGTH);
        memorySet(rawResource.data + rawResource.length, 0, cast(u32) PALETTE_LENGTH - rawResource.length);
    }

    resource := getOrCreateResource(WarResourcePalette, entry.index);
    resource.type = WarResourceType.Palette;

    for i : range(s32, 0, PALETTE_LENGTH) {
        resource.colors[i] = rawResource.data[i] * 4;
    }

    // this is a hack in palette #255 because the UI graphics of the unit info
    // is wrong when using the palette as it came from the file,
    // or at least I didn't knew how to decode it.
    if (entry.index == 255) {
        resource.colors[0] = 0;
        resource.colors[1] = 0;
        resource.colors[2] = 0;

        resource.colors[190 * 3 + 0] = 176;
        resource.colors[190 * 3 + 1] = 184;
        resource.colors[190 * 3 + 2] = 208;

        resource.colors[191 * 3 + 0] = 208;
        resource.colors[191 * 3 + 1] = 208;
        resource.colors[191 * 3 + 2] = 236;

        resource.colors[214 * 3 + 0] = 204;
        resource.colors[214 * 3 + 1] = 212;
        resource.colors[214 * 3 + 2] = 180;

        resource.colors[208 * 3 + 0] = 32;
        resource.colors[208 * 3 + 1] = 32;
        resource.colors[208 * 3 + 2] = 44;

        resource.colors[211 * 3 + 0] = 80;
        resource.colors[211 * 3 + 1] = 104;
        resource.colors[211 * 3 + 2] = 104;

        resource.colors[184 * 3 + 0] = 12;
        resource.colors[184 * 3 + 1] = 20;
        resource.colors[184 * 3 + 2] = 12;

        resource.colors[185 * 3 + 0] = 28;
        resource.colors[185 * 3 + 1] = 32;
        resource.colors[185 * 3 + 2] = 32;

        resource.colors[186 * 3 + 0] = 56;
        resource.colors[186 * 3 + 1] = 64;
        resource.colors[186 * 3 + 2] = 68;

        resource.colors[189 * 3 + 0] = 144;
        resource.colors[189 * 3 + 1] = 156;
        resource.colors[189 * 3 + 2] = 176;
    }
    // this palette has an ugly pink color (color #150)
    // that is showing in the unit portraits, so change it to dark gray
    else if (entry.index == 217) {
        resource.colors[96 * 3 + 0] = 108;
        resource.colors[96 * 3 + 1] = 72;
        resource.colors[96 * 3 + 2] = 40;

        resource.colors[150 * 3 + 0] = 46;
        resource.colors[150 * 3 + 1] = 54;
        resource.colors[150 * 3 + 2] = 54;

        resource.colors[158 * 3 + 0] = 40;
        resource.colors[158 * 3 + 1] = 64;
        resource.colors[158 * 3 + 2] = 112;

        resource.colors[215 * 3 + 0] = 32;
        resource.colors[215 * 3 + 1] = 20;
        resource.colors[215 * 3 + 2] = 24;
    }
}

loadImageResource :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    paletteData: [PALETTE_LENGTH] u8;
    getPalette(entry.param1, entry.param2, paletteData);

    width := memoryRead(u16, rawResource.data, 0);
    height := memoryRead(u16, rawResource.data, 2);

    pixels := alloc(u8, cast(s64) width * height * 4);
    for i : range(s32, 0, cast(s32) width * height) {
        colorIndex := cast(s32) memoryRead(u8, rawResource.data, 4 + i);

        pixels[i * 4 + 0] = paletteData[colorIndex * 3 + 0];
        pixels[i * 4 + 1] = paletteData[colorIndex * 3 + 1];
        pixels[i * 4 + 2] = paletteData[colorIndex * 3 + 2];

        // assuming that colorIndex == 0 is the transparent color
        if (pixels[i * 4 + 0] > 0 ||
            pixels[i * 4 + 1] > 0 ||
            pixels[i * 4 + 2] > 0 ||
            colorIndex != 0)
        {
            pixels[i * 4 + 3] = 255;
        }
    }

    resource := getOrCreateResource(WarResourceImage, entry.index);
    resource.type = WarResourceType.Image;
    resource.width = width;
    resource.height = height;
    resource.pixels = pixels;
}

loadSpriteResource :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    paletteData: [PALETTE_LENGTH] u8;
    getPalette(entry.param1, entry.param2, paletteData);

    framesCount := memoryRead(u16, rawResource.data, 0);
    frameWidth := memoryRead(u8, rawResource.data, 2);
    frameHeight := memoryRead(u8, rawResource.data, 3);

    resource := getOrCreateResource(WarResourceSprite, entry.index);
    for i : range(s32, 0, cast(s32) framesCount) {
        frame := *resource.frames[i];
        frame.dx = memoryRead(u8, rawResource.data, 4 + i * 8 + 0);
        frame.dy = memoryRead(u8, rawResource.data, 4 + i * 8 + 1);
        frame.w = memoryRead(u8, rawResource.data, 4 + i * 8 + 2);
        frame.h = memoryRead(u8, rawResource.data, 4 + i * 8 + 3);
        frame.off = memoryRead(u32, rawResource.data, 4 + i * 8 + 4);
        frame.data = alloc(u8, cast(s64) frameWidth * frameHeight * 4);

        // found in war1tool.c, don't know if is needed
        // if (off < 0) {  // High bit of width
        //     off &= 0x7FFFFFFF;
        //     w += 256;
        // }
    }

    for i : range(s32, 0, cast(s32) framesCount) {
        frame := *resource.frames[i];

        off := frame.off;
        for y : range(s32, frame.dy, frame.dy + frame.h) {
            for x : range(s32, frame.dx, frame.dx + frame.w) {
                pixel := cast(s32) (x + y * frameWidth) * 4;
                colorIndex := cast(s32) rawResource.data[off];

                frame.data[pixel + 0] = paletteData[colorIndex * 3 + 0];
                frame.data[pixel + 1] = paletteData[colorIndex * 3 + 1];
                frame.data[pixel + 2] = paletteData[colorIndex * 3 + 2];

                // assuming that colorIndex == 0 is the transparent color
                if (frame.data[pixel + 0] > 0 ||
                    frame.data[pixel + 1] > 0 ||
                    frame.data[pixel + 2] > 0 ||
                    colorIndex != 0)
                {
                    // Make shadow not so dark
                    //
                    // Altough it seem that the original game has (0, 0, 0) as
                    // the color for shadows
                    //
                    // if (colorIndex == 96)
                    //    frame.data[pixel + 3] = 150;

                    frame.data[pixel + 3] = 255;
                }

                off += 1;
            }
        }
    }

    resource.type = WarResourceType.Sprite;
    resource.framesCount = framesCount;
    resource.frameWidth = frameWidth;
    resource.frameHeight = frameHeight;
}

loadLevelInfo :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    tilesetType := entry.param1;
    isCustomMap := cast(bool) entry.param2;

    allowId := memoryRead(u32, rawResource.data, 0);

    resource := getOrCreateResource(WarResourceLevelInfo, entry.index);
    resource.type = WarResourceType.LevelInfo;
    resource.allowId = allowId;
    resource.allowedHumanUnits = true;
    resource.allowedOrcsUnits = true;
    resource.tilesetType = tilesetType;
    resource.customMap = isCustomMap;

    arrayClear(resource.allowedFeatures);
    for f : range(s32, 0, MAX_FEATURES_COUNT) {
        // the feature is allowed if the corresponding bit is set
        if (allowId & (1 << f)) {
            resource.allowedFeatures[f] = 1;
        }
    }

    // 0x0004 - 0x0008: 5xByte: Upgrade: Ranged Weapons, arrows / spears.
    // 0x0009 - 0x000D: 5xByte: Upgrade: Melee Weapons, swords / axes.
    // 0x000E - 0x0012: 5xByte: Upgrade: Rider speed, horses / wolves.
    // 0x0013 - 0x0017: 5xByte: Spell: summon scorpions / summon spiders.
    // 0x0018 - 0x001C: 5xByte: Spell: rain of fire / cloud of poison.
    // 0x001D - 0x0021: 5xByte: Spell: summon water elemental / summon daemon.
    // 0x0022 - 0x0026: 5xByte: Spell: healing / raise dead.
    // 0x0027 - 0x002B: 5xByte: Spell: far seeing / dark vision.
    // 0x002C - 0x0030: 5xByte: Spell: invisibility / unholy armor.
    // 0x0031 - 0x0035: 5xByte: Upgrade: Shields.
    for upgrade : range(s32, 0, MAX_UPGRADES_COUNT) {
        allowedUpgrade := true;

        if (upgrade >= 3 && upgrade <= 8) {
            // if it's a spell upgrade check the allowed features, because spells may not be allowed.
            // offset of spells in allowed features is 15
            // usefully, they are not in the same order in the allowid as they
            // are in the list of researched stuff, that's the (upgrade + 3) % 6 are for.
            allowed := resource.allowedFeatures[15 + (upgrade + 3) % 6];
            allowedUpgrade = (allowed > 0);
        }

        if (allowedUpgrade) {
            for player : range(s32, 0, MAX_PLAYERS_COUNT) {
                value := memoryRead(u8, rawResource.data, 4 + upgrade * 5 + player);
                resource.allowedUpgrades[upgrade][player] = value;
            }
        }
    }

    // 0x005C - 0x0069: 5xDWord: Lumber for each player.
    for i : range(s32, 0, MAX_PLAYERS_COUNT) {
        resource.lumber[i] = memoryRead(u32, rawResource.data, 0x5C + i * 4);
    }

	// 0x0070 - 0x0083: 5xDWord: Gold for each player.
    for i : range(s32, 0, MAX_PLAYERS_COUNT) {
        resource.gold[i] = memoryRead(u32, rawResource.data, 0x70 + i * 4);
    }

    // 0xCC, 0xCE => Starting position of unit (divide by 2) (ushort)
    resource.startX = memoryRead(u16, rawResource.data, 0xCC) / 2;
    resource.startY = memoryRead(u16, rawResource.data, 0xCE) / 2;

    // 0x84 - 0x88: players info
    race := memoryRead(u32, rawResource.data, 0x84);
    resource.races[0] = ifx (race >= (1 << 16)) then WarRace.Humans else WarRace.Orcs;

    for i : range(s32, 1, MAX_PLAYERS_COUNT - 1) {
        resource.races[i] = ifx (resource.races[0] == WarRace.Humans) then WarRace.Orcs else WarRace.Humans;
    }

    // 0x94: objectives
    objectivesOffset := cast(u32) memoryRead(u16, rawResource.data, 0x94);
    if (objectivesOffset) {
        strcpy(resource.objectives.data, rawResource.data + objectivesOffset);
    }

    // next level resource index: *0xCA - 2
    nextLevelIndex := memoryRead(u16, rawResource.data, 0xCA);
    if (nextLevelIndex != 0 && nextLevelIndex != 0xFFFF) {
        resource.nextLevelIndex = nextLevelIndex - 2;
    }

    // visual resource index: *0xD0 - 2
    visualIndex := memoryRead(u16, rawResource.data, 0xD0);
    if (visualIndex != 0 && visualIndex != 0xFFFF) {
        resource.visualIndex = visualIndex - 2;
    }

    // passable resource index: *0xD2 - 2
    passableIndex := memoryRead(u16, rawResource.data, 0xD2);
    if (passableIndex != 0 && passableIndex != 0xFFFF) {
        resource.passableIndex = passableIndex - 2;
    }

    // tileset resource index: *0xD4 - 2
    tilesetIndex := memoryRead(u16, rawResource.data, 0xD4);
    if (tilesetIndex != 0 && tilesetIndex != 0xFFFF) {
        resource.tilesetIndex = tilesetIndex - 2;
    }

    // tiles resource index: *0xD6 - 2
    tilesIndex := memoryRead(u16, rawResource.data, 0xD6);
    if (tilesIndex != 0 && tilesIndex != 0xFFFF) {
        resource.tilesIndex = tilesIndex - 2;
    }

    // palette resource index: *0xD8 - 2
    paletteIndex := memoryRead(u16, rawResource.data, 0xD8);
    if (paletteIndex != 0 && paletteIndex != 0xFFFF) {
        resource.paletteIndex = paletteIndex - 2;
    }

    // dynamic data: 0xE3
    offset: u32 = 0xE3;
    while (memoryRead(u32, rawResource.data, offset) != 0xFFFFFFFF) {
        offset += 1;
    }

    // skip marker 0xFFFF
    offset += 4;

    // offset of the units and construction information
    offset = cast(u32) memoryRead(u16, rawResource.data, offset);

    if (isCustomMap) {
        // It seems that the structure of custom map is different of the structure for the levels.
        // It has the the placeholders for the possible configurations of starting positions.
        // Warcraft 1 only supports one vs one custom maps, and every custom map I got has four
        // starting positions, so there are 6 possible configurations.
        //
        // offset of gold mines
        // FF FF
        // offset of player 1 in first configuration
        // offset of player 2 in first configuration
        // FF FF
        // offset of player 1 in second configuration
        // offset of player 2 in second configuration
        // FF FF
        // ... the above repeats 4 more times for a total of 6 configurations
        //
        // the goldmines data is in the form of a collection of entities without
        // the gold amount data that ends with a 0xFFFF marker.
        // the players configuration data is just the collection of starting entities
        // followed by a marker 0xFFFF and then the collection of roads for that player.
        // The starting entities are usually (at least in the DATA file I have) just
        // a placeholder town hall and a placeholder farm that, I'm guessing at the
        // start of the map it gets replaced by the actual race townhall and farm
        //
        goldminesOffset := cast(u32) memoryRead(u16, rawResource.data, offset);
        loadCustomStartGoldmines(resource, *rawResource, goldminesOffset);
        offset += 2;

        // skip marker 0xFFFF
        offset += 2;

        while (offset < goldminesOffset) {
            configuration := *resource.startConfigurations[resource.startConfigurationsCount];
            configuration.startEntitiesCount = 0;

            offset0 := cast(u32) memoryRead(u16, rawResource.data, offset);
            offset0 = loadCustomStartEntities(resource, *rawResource, offset0, configuration, 0);
            offset0 = loadStartRoads(resource, *rawResource, offset0 + 2);
            offset += 2;

            offset1 := cast(u32) memoryRead(u16, rawResource.data, offset);
            offset1 = loadCustomStartEntities(resource, *rawResource, offset1, configuration, 1);
            offset1 = loadStartRoads(resource, *rawResource, offset1 + 2);
            offset += 2;

            // skip marker 0xFFFF
            offset += 2;

            resource.startConfigurationsCount += 1;
        }
    } else {
        // starting units
        offset = loadStartEntities(resource, *rawResource, offset);

        // skip marker 0xFFFF
        offset += 2;

        // roads
        offset = loadStartRoads(resource, *rawResource, offset);

        // skip marker 0xFFFF
        offset += 2;

        // walls
        offset = loadStartWalls(resource, *rawResource, offset);

        // skip marker 0xFFFF
        offset += 2;
    }
}

loadLevelVisual :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    resource := getOrCreateResource(WarResourceLevelVisual, entry.index);
    resource.type = WarResourceType.LevelVisual;
    for i : range(s32, 0, MAP_TILES_WIDTH * MAP_TILES_HEIGHT) {
        resource.data[i] = memoryRead(u16, rawResource.data, i * 2);
    }
}

loadLevelPassable :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    resource := getOrCreateResource(WarResourceLevelPassable, entry.index);
    resource.type = WarResourceType.LeveLPassable;
    for i : range(s32, 0, MAP_TILES_WIDTH * MAP_TILES_HEIGHT) {
        // 128 -> wood, 64 -> water, 16 -> bridge, 0 -> empty
        resource.data[i] = memoryRead(u16, rawResource.data, i * 2);
    }
}

loadTileset :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    tiles := getOrCreateResource(WarResourceTiles, entry.param1);

    data := alloc(u8, TILESET_WIDTH * TILESET_HEIGHT);
    tilesCount := cast(s32) rawResource.length / 8;
    for i : range(s32, 0, tilesCount) {
        for my : range(s32, 0, 2) {
            for mx : range(s32, 0, 2) {
                offset := memoryRead(u16, rawResource.data, i * 8 + (my * 2 + mx) * 2);
                flipX := (offset & 0x02) != 0;
                flipY := (offset & 0x01) != 0;
                offset = cast(u16) ((offset & 0xFFFC) << 1);

                flip :: s32.[7, 6, 5, 4, 3, 2, 1, 0, 8];

                ix: s32 = mx + (i % TILESET_TILES_PER_ROW) * 2;
                iy: s32 = my + (i / TILESET_TILES_PER_ROW) * 2;

                for y : range(s32, 0, 8) {
                    for x : range(s32, 0, 8) {
                        fy: s32 = ifx flipY then flip[y] else y;
                        fx: s32 = ifx flipX then flip[x] else x;
                        srcValueIndex: s32 = offset + fy * 8 + fx;
                        destValueIndex: s32 = (y + iy * 8) * TILESET_WIDTH + ix * 8 + x;
                        data[destValueIndex] = tiles.data[srcValueIndex];
                    }
                }
            }
        }
    }

    paletteData: [PALETTE_LENGTH] u8;
    getPalette(tiles.palette1, tiles.palette2, paletteData);

    resource := getOrCreateResource(WarResourceTileset, entry.index);
    resource.type = WarResourceType.Tileset;
    resource.tilesCount = rawResource.length / 8;

    for i : range(s32, 0, TILESET_WIDTH * TILESET_HEIGHT) {
        resource.data[i * 4 + 0] = paletteData[data[i] * 3 + 0];
        resource.data[i * 4 + 1] = paletteData[data[i] * 3 + 1];
        resource.data[i * 4 + 2] = paletteData[data[i] * 3 + 2];
        resource.data[i * 4 + 3] = cast(u8) (ifx data[i] > 0 then 255 else 0);
    }

    free(data);

    // #if __DEBUG__ {
    //     fp := tprint("output_%d.png", entry.index);
    //     stbi_write_png(toCString(fp, tempAllocator), TILESET_WIDTH, TILESET_HEIGHT, 4, resource.data, TILESET_WIDTH * 4);
    // }
}

loadTiles :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    paletteData: [PALETTE_LENGTH] u8;
    getPalette(entry.param1, entry.param2, paletteData);

    resource := getOrCreateResource(WarResourceTiles, entry.index);
    resource.type = WarResourceType.Tiles;
    resource.palette1 = entry.param1;
    resource.palette2 = entry.param2;
    resource.data = alloc(u8, rawResource.length);
    memoryCopy(resource.data, rawResource.data, rawResource.length);
}

loadText :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    resource := getOrCreateResource(WarResourceText, entry.index);
    resource.type = WarResourceType.Text;
    resource.length = rawResource.length;
    resource.text = alloc(u8, resource.length);
    memoryCopy(resource.text, rawResource.data, resource.length);
}

// loadXmi :: (entry: *DatabaseEntry) {
//    ctx := cast(*WarContext) context.gameContext;
//    assert(ctx != null);

//     rawResource := ctx.warFile.resources[entry.index];
//     if (rawResource.placeholder) {
//         logInfo("Placeholder resource found at: %d\n", entry.index);
//         return;
//     }

//     xmiData := rawResource.data;
//     xmiLength := rawResource.length;

//     midLength: u32;
//     midData := transcodeXmiToMid(xmiData, xmiLength, *midLength);
//     if (midData == null) {
//         logError("Can't convert XMI file of resource %d\n", entry.index);
//         return;
//     }

//     resource := getOrCreateResource(WarResourceAudio, entry.index);
//     resource.type = WarResourceType.Xmid;
//     resource.data = midData;
//     resource.length = cast(s32) midLength;
// }

// loadWave :: (entry: *DatabaseEntry) {
//     ctx := cast(*WarContext) context.gameContext;
//     assert(ctx != null);

//     rawResource := ctx.warFile.resources[entry.index];
//     if (rawResource.placeholder) {
//         logInfo("Placeholder resource found at: %d\n", entry.index);
//         return;
//     }

//     bufInput: MemoryBuffer;
//     mbInitFromMemory(*bufInput, rawResource.data, rawResource.length);

//     // skip "RIFF"
//     check(#code mbSkip(*bufInput, 4));
//     // skip file length, always 36 + dataLength
//     check(#code mbSkip(*bufInput, size_of(s32)));
//     // skip "WAVE"
//     check(#code mbSkip(*bufInput, 4));
//     // skip "fmt "
//     check(#code mbSkip(*bufInput, 4));
//     // skip fmt length, always 10
//     check(#code mbSkip(*bufInput, size_of(s32)));
//     // skip uncompressed, always 1
//     check(#code mbSkip(*bufInput, size_of(s16)));
//     // skip channel count, always 1
//     check(#code mbSkip(*bufInput, size_of(s16)));
//     // skip sample rate, always 11025
//     check(#code mbSkip(*bufInput, size_of(s32)));
//     // skip byte rate, always 11025
//     check(#code mbSkip(*bufInput, size_of(s32)));
//     // skip block align, always 1
//     check(#code mbSkip(*bufInput, size_of(s16)));
//     // skip bits per sample, always 8
//     check(#code mbSkip(*bufInput, size_of(s16)));
//     // skip "data"
//     check(#code mbSkip(*bufInput, 4));

//     dataLength: s32;
//     check(#code mbReadInt32LE(*bufInput, *dataLength));
//     assert(dataLength > 0);

//     data := alloc(u8, dataLength);
//     defer free(data);

//     check(#code mbReadBytes(*bufInput, data, dataLength));

//     // this data is at 11025khz, and for playing it back I needed at 44100khz
//     // so I need to upsampling it here by a factor of 4
//     newData := changeSampleRate(data, dataLength, 4);
//     newDataLength: s32 = dataLength * 4;

//     resource := getOrCreateResource(WarResourceAudio, entry.index);
//     resource.type = WarResourceType.Wave;
//     resource.data = newData;
//     resource.length = newDataLength;
// }

// loadVoc :: (entry: *DatabaseEntry) {
//     ctx := cast(*WarContext) context.gameContext;
//     assert(ctx != null);
//     rawResource := ctx.warFile.resources[entry.index];
//     if (rawResource.placeholder) {
//         logInfo("Placeholder resource found at: %d\n", entry.index);
//         return;
//     }

//     bufInput: MemoryBuffer;
//     mbInitFromMemory(*bufInput, rawResource.data, rawResource.length);

//     vocHeader: [19] u8;
//     check(#code mbReadBytes(*bufInput, vocHeader.data, vocHeader.count));
//     if (strncmp(vocHeader.data, "Creative Voice File", vocHeader.count) != 0) {
//         logError("Failed to load VOC resource: %\n", entry.index);
//         return;
//     }

//     // skip 0x1A
//     check(#code mbSkip(*bufInput, 1));

//     // skip offset to data, always 26
//     check(#code mbSkip(*bufInput, 2));

//     // skip version, always 266
//     check(#code mbSkip(*bufInput, 2));
//     // skip 2's comp of version, always 4393
//     check(#code mbSkip(*bufInput, 2));

//     type: u8;
//     check(#code mbRead(*bufInput, *type));
//     assert(type == 1);

//     dataLength: s32;
//     check(#code mbReadInt24LE(*bufInput, *dataLength));
//     assert(dataLength > 0);

//     // the length of the data is this value - 2
//     // for the next two skipped bytes
//     dataLength -= 2;

//     // skip sample rate and compression type
//     check(#code mbSkip(*bufInput, 2));

//     data := alloc(u8, dataLength);
//     defer free(data);

//     check(#code mbReadBytes(*bufInput, data, dataLength));

//     // this data is at 11025khz, and for playing it back I needed at 44100khz
//     // so I need to upsampling it here by a factor of 4
//     newData := changeSampleRate(data, dataLength, 4);
//     newDataLength: s32 = dataLength * 4;

//     resource := getOrCreateResource(WarResourceAudio, entry.index);
//     resource.type = WarResourceType.Voc;
//     resource.data = newData;
//     resource.length = newDataLength;
// }

loadCursor :: (entry: *DatabaseEntry) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    rawResource := ctx.warFile.resources[entry.index];
    if (rawResource.placeholder) {
        logInfo("Placeholder resource found at: %d\n", entry.index);
        return;
    }

    paletteData: [PALETTE_LENGTH] u8;
    getPalette(entry.param1, entry.param2, paletteData);

    hotx := memoryRead(u16, rawResource.data, 0);
    hoty := memoryRead(u16, rawResource.data, 2);
    width := memoryRead(u16, rawResource.data, 4);
    height := memoryRead(u16, rawResource.data, 6);

    pixels := alloc(u8, width * height * 4);
    for i : range(s32, 0, cast(s32) width * height) {
        colorIndex := cast(u32) memoryRead(u8, rawResource.data, 8 + i);

        pixels[i * 4 + 0] = paletteData[colorIndex * 3 + 0];
        pixels[i * 4 + 1] = paletteData[colorIndex * 3 + 1];
        pixels[i * 4 + 2] = paletteData[colorIndex * 3 + 2];

        // assuming that colorIndex == 0 is the transparent color
        if (pixels[i * 4 + 0] > 0 ||
            pixels[i * 4 + 1] > 0 ||
            pixels[i * 4 + 2] > 0 ||
            colorIndex != 0)
        {
            pixels[i * 4 + 3] = 255;
        }
    }

    resource := getOrCreateResource(WarResourceCursor, entry.index);
    resource.type = WarResourceType.Cursor;
    resource.hotx = hotx;
    resource.hoty = hoty;
    resource.width = width;
    resource.height = height;
    resource.pixels = pixels;
}

loadResource :: (entry: *DatabaseEntry) {
    if entry.type == {
        case DatabaseEntryType.Palette;         loadPaletteResource(entry);
        case DatabaseEntryType.Image;           loadImageResource(entry);
        case DatabaseEntryType.Sprite;          loadSpriteResource(entry);
        case DatabaseEntryType.LevelInfo;       loadLevelInfo(entry);
        case DatabaseEntryType.LevelVisual;     loadLevelVisual(entry);
        case DatabaseEntryType.LeveLPassable;   loadLevelPassable(entry);
        case DatabaseEntryType.Tileset;         loadTileset(entry);
        case DatabaseEntryType.Tiles;           loadTiles(entry);
        case DatabaseEntryType.Text;            loadText(entry);
        // case DatabaseEntryType.Xmid;            loadXmi(entry);
        // case DatabaseEntryType.Wave;            loadWave(entry);
        // case DatabaseEntryType.Voc;             loadVoc(entry);
        case DatabaseEntryType.Cursor;          loadCursor(entry);
        case; logInfo("DB entries of type % aren't handled yet.\n", entry.type);
    }
}

#scope_file

loadStartEntities :: (resource: *WarResourceLevelInfo, rawResource: *WarRawResource, offset: u32) -> u32 {
    resource.startEntitiesCount = 0;

    while (offset < rawResource.length) {
        val := memoryRead(u16, rawResource.data, offset);
        if (val == 0xFFFF) {
            break;
        }

        startEntity := *resource.startEntities[resource.startEntitiesCount];
        startEntity.x = memoryRead(u8, rawResource.data, offset + 0) / 2;
        startEntity.y = memoryRead(u8, rawResource.data, offset + 1) / 2;
        startEntity.type = cast(WarUnitType) memoryRead(u8, rawResource.data, offset + 2);
        startEntity.player = memoryRead(u8, rawResource.data, offset + 3);

        offset += 4;

        if (startEntity.type == WarUnitType.Goldmine) {
            startEntity.resourceKind = WarResourceKind.Gold;
            startEntity.amount = memoryRead(u16, rawResource.data, offset);
            offset += 2;
        }

        resource.startEntitiesCount += 1;
    }

    return offset;
}

loadStartRoads :: (resource: *WarResourceLevelInfo, rawResource: *WarRawResource, offset: u32) -> u32 {
    resource.startRoadsCount = 0;

    while (offset < rawResource.length) {
        val := memoryRead(u16, rawResource.data, offset);
        if (val == 0xFFFF) {
            break;
        }

        construct := *resource.startRoads[resource.startRoadsCount];
        construct.type = WarConstructType.Road;
        construct.x1 = memoryRead(u8, rawResource.data, offset + 0) / 2;
        construct.y1 = memoryRead(u8, rawResource.data, offset + 1) / 2;
        construct.x2 = memoryRead(u8, rawResource.data, offset + 2) / 2;
        construct.y2 = memoryRead(u8, rawResource.data, offset + 3) / 2;
        construct.player = memoryRead(u8, rawResource.data, offset + 4);

        offset += 5;

        resource.startRoadsCount += 1;
    }

    return offset;
}

loadStartWalls :: (resource: *WarResourceLevelInfo, rawResource: *WarRawResource, offset: u32) -> u32 {
    resource.startWallsCount = 0;

    while (offset < rawResource.length) {
        val := memoryRead(u16, rawResource.data, offset);
        if (val == 0xFFFF) {
            break;
        }

        construct := *resource.startWalls[resource.startWallsCount];
        construct.type = WarConstructType.Wall;
        construct.x1 = memoryRead(u8, rawResource.data, offset + 0) / 2;
        construct.y1 = memoryRead(u8, rawResource.data, offset + 1) / 2;
        construct.x2 = memoryRead(u8, rawResource.data, offset + 2) / 2;
        construct.y2 = memoryRead(u8, rawResource.data, offset + 3) / 2;
        construct.player = memoryRead(u8, rawResource.data, offset + 4);

        offset += 5;

        resource.startWallsCount += 1;
    }

    return offset;
}

loadCustomStartGoldmines :: (resource: *WarResourceLevelInfo, rawResource: *WarRawResource, offset: u32) -> u32 {
    resource.startGoldminesCount = 0;

    while (offset < rawResource.length) {
        val := memoryRead(u16, rawResource.data, offset);
        if (val == 0xFFFF) {
            break;
        }

        startGoldmine := *resource.startGoldmines[resource.startGoldminesCount];
        startGoldmine.x = memoryRead(u8, rawResource.data, offset + 0) / 2;
        startGoldmine.y = memoryRead(u8, rawResource.data, offset + 1) / 2;
        startGoldmine.type = WarUnitType.Goldmine;
        startGoldmine.player = 4;

        offset += 4;

        resource.startGoldminesCount += 1;
    }

    return offset;
}

loadCustomStartEntities :: (resource: *WarResourceLevelInfo, rawResource: *WarRawResource, offset: u32, configuration: *WarCustomMapConfiguration, player: u8) -> u32 {
    while (offset < rawResource.length) {
        val := memoryRead(u16, rawResource.data, offset);
        if (val == 0xFFFF) {
            break;
        }

        startEntity := *configuration.startEntities[configuration.startEntitiesCount];
        startEntity.x = memoryRead(u8, rawResource.data, offset + 0) / 2;
        startEntity.y = memoryRead(u8, rawResource.data, offset + 1) / 2;
        startEntity.type = cast(WarUnitType) memoryRead(u8, rawResource.data, offset + 2);
        startEntity.player = player;

        offset += 4;

        configuration.startEntitiesCount += 1;
    }

    return offset;
}

check :: (code: Code) #expand {
    result := #insert code;
    assert(result);
}
