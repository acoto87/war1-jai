createMapUI :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    map := cast(*WarMap) ctx.scene;
    assert(map != null);

    player := *map.players[0];

    leftTopPanel := getTopLeft(map.leftTopPanel);
    leftBottomPanel := getTopLeft(map.leftBottomPanel);
    topPanel := getTopLeft(map.topPanel);
    rightPanel := getTopLeft(map.rightPanel);
    bottomPanel := getTopLeft(map.bottomPanel);
    minimapPanel := getTopLeft(map.minimapPanel);

    invalidRef := invalidResourceRef();
    normalRef := imageResourceRef(364);
    pressedRef := imageResourceRef(365);
    portraitsRef := imageResourceRef(361);

    uiEntity: *Entity;

    // panels
    createUIImage("panelLeftTop", imageResourceRefFromPlayer(player, 224, 225), leftTopPanel);
    createUIImage("panelLeftBottom", imageResourceRefFromPlayer(player, 226, 227), leftBottomPanel);
    createUIImage("panelTop", imageResourceRefFromPlayer(player, 218, 219), topPanel);
    createUIImage("panelRight", imageResourceRefFromPlayer(player, 220, 221), rightPanel);
    createUIImage("panelBottom", imageResourceRefFromPlayer(player, 222, 223), bottomPanel);

    // minimap
    createUIMinimap("minimap", minimapPanel);

    // top panel images
    createUIImage("imgGold", imageResourceRef(406), topPanel + vec2(201, 1));
    createUIImage("imgLumber", imageResourceRef(407), topPanel + vec2(102, 0));

    // top panel texts
    createUIText("txtGold", 0, 6, "", topPanel + vec2(135, 2));
    createUIText("txtWood", 0, 6, "", topPanel + vec2(24, 2));

    // status text
    createUIText("txtStatus", 0, 6, "", bottomPanel + vec2(2, 5));
    createUIImage("imgStatusWood", imageResourceRef(407), bottomPanel + vec2(163, 3));
    createUIImage("imgStatusGold", imageResourceRef(406), bottomPanel + vec2(200, 5));
    createUIText("txtStatusWood", 0, 6, "", bottomPanel + vec2(179, 5));
    createUIText("txtStatusGold", 0, 6, "", bottomPanel + vec2(218, 5));

    // cheats panel
    cheatsPanelOptions: CheatPanelOptions;
    cheatsPanelOptions.panelRect = map.bottomPanel;
    cheatsPanelOptions.textUIOffset = vec2(2, 5);
    cheatsPanelOptions.cursorUIOffset = vec2(2, 4);
    cheatsPanelOptions.prefix = "MSG: ";
    cheatsPanelOptions.textUIMaxLength = 20;
    initCheatsPanel(cheatsPanelOptions);

    // flash status
    flashTextOptions: FlashTextOptions;
    flashTextOptions.textUIPosition = bottomPanel + vec2(2, 5);
    initFlashText(flashTextOptions);

    // selected unit(s) info
    createUIImage("imgUnitInfo", imageResourceRefFromPlayer(player, 360, 359), leftBottomPanel + vec2(2, 0));
    createUIImage("imgUnitPortrait0", portraitsRef, leftBottomPanel + vec2(6, 4));
    createUIImage("imgUnitPortrait1", portraitsRef, leftBottomPanel + vec2(4, 1));
    createUIImage("imgUnitPortrait2", portraitsRef, leftBottomPanel + vec2(38, 1));
    createUIImage("imgUnitPortrait3", portraitsRef, leftBottomPanel + vec2(4, 23));
    createUIImage("imgUnitPortrait4", portraitsRef, leftBottomPanel + vec2(38, 23));
    createUIImage("imgUnitInfoLife", imageResourceRefFromPlayer(player, 360, 359), leftBottomPanel + vec2(3, 16));
    createUIText("txtUnitName", 0, 6, "", leftBottomPanel + vec2(6, 26));
    createUIRect("rectLifeBar0", leftBottomPanel + vec2(37, 20), vec2(27, 3), COLOR_GREEN);
    createUIRect("rectLifeBar1", leftBottomPanel + vec2(4, 17), vec2(27, 3), COLOR_GREEN);
    createUIRect("rectLifeBar2", leftBottomPanel + vec2(38, 17), vec2(27, 3), COLOR_GREEN);
    createUIRect("rectLifeBar3", leftBottomPanel + vec2(4, 39), vec2(27, 3), COLOR_GREEN);
    createUIRect("rectLifeBar4", leftBottomPanel + vec2(38, 39), vec2(27, 3), COLOR_GREEN);
    createUIRect("rectMagicBar", leftBottomPanel + vec2(37, 9), vec2(27, 3), COLOR_GREEN);
    createUIRect("rectPercentBar", leftBottomPanel + vec2(4, 37), vec2(62, 5), COLOR_GREEN);
    createUIImage("rectPercentText", imageResourceRef(410), leftBottomPanel + vec2(15, 37));

    // texts in the command area
    createUIText("txtCommand0", 0, 6, "", leftBottomPanel + vec2(3, 46));
    createUIText("txtCommand1", 0, 6, "", leftBottomPanel + vec2(3, 56));
    createUIText("txtCommand2", 0, 6, "", leftBottomPanel + vec2(7, 64));
    createUIText("txtCommand3", 0, 6, "", leftBottomPanel + vec2(11, 54));

    // command buttons
    createUIImageButton(
        "btnCommand0",
        normalRef, pressedRef, portraitsRef,
        leftBottomPanel + vec2(2, 44));

    createUIImageButton(
        "btnCommand1",
        normalRef, pressedRef, portraitsRef,
        leftBottomPanel + vec2(36, 44));

    createUIImageButton(
        "btnCommand2",
        normalRef, pressedRef, portraitsRef,
        leftBottomPanel + vec2(2, 67));

    createUIImageButton(
        "btnCommand3",
        normalRef, pressedRef, portraitsRef,
        leftBottomPanel + vec2(36, 67));

    createUIImageButton(
        "btnCommand4",
        normalRef, pressedRef, portraitsRef,
        leftBottomPanel + vec2(2, 90));

    createUIImageButton(
        "btnCommand5",
        normalRef, pressedRef, portraitsRef,
        leftBottomPanel + vec2(36, 90));

    uiEntity = createUIImageButton(
        "btnMenu",
        imageResourceRef(362),
        imageResourceRef(363),
        invalidRef,
        leftBottomPanel + vec2(3, 116));
    setUITooltip(uiEntity, 6, 3, "MENU (F10)");
    // setUIButtonClickHandler(uiEntity, handleMenu);
    setUIButtonHotKey(uiEntity, Keys.F10);
}

renderMapUI :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    nvgSave(ctx.gfx);

    // renderSelectionRect();
    // renderUICommand();
    renderUIEntities();

    nvgRestore(ctx.gfx);
}

#scope_file

createUIMinimap :: (name: string, position: Vec2) -> *Entity {
    entity := createEntity(EntityType.Minimap);
    addTransformComponent(entity, position);
    addUIComponent(entity, name);
    return entity;
}

// void updateSelectedUnitsInfo(WarContext* context)
// {
//     WarMap* map = context->map;

//     // retrieve entities of sprites of unit info/portraits
//     WarEntity* imgUnitInfo = findUIEntity("imgUnitInfo");
//     assert(imgUnitInfo);

//     WarEntity* imgUnitInfoLife = findUIEntity("imgUnitInfoLife");
//     assert(imgUnitInfoLife);

//     char uiEntityName[20];
//     WarEntity* imgUnitPortraits[5];
//     WarEntity* rectLifeBars[5];
//     for (s32 i = 0; i < 5; i++)
//     {
//         sprintf(uiEntityName, "imgUnitPortrait%d", i);
//         imgUnitPortraits[i] = findUIEntity(uiEntityName);
//         assert(imgUnitPortraits[i]);

//         sprintf(uiEntityName, "rectLifeBar%d", i);
//         rectLifeBars[i] = findUIEntity(uiEntityName);
//         assert(rectLifeBars[i]);
//     }

//     WarEntity* rectMagicBar = findUIEntity("rectMagicBar");
//     assert(rectMagicBar);

//     WarEntity* rectPercentBar = findUIEntity("rectPercentBar");
//     assert(rectPercentBar);

//     WarEntity* rectPercentText = findUIEntity("rectPercentText");
//     assert(rectPercentText);

//     WarEntity* txtUnitName = findUIEntity("txtUnitName");
//     assert(txtUnitName);

//     // reset frame index of the sprites of unit info/portraits
//     setUIImage(imgUnitInfo, -1);
//     setUIImage(imgUnitInfoLife, -1);

//     for (s32 i = 0; i < 5; i++)
//     {
//         setUIImage(imgUnitPortraits[i], -1);
//         setUIRectWidth(rectLifeBars[i], 0);
//     }

//     setUIRectWidth(rectMagicBar, 0);
//     setUIRectWidth(rectPercentBar, 0);
//     setUIImage(rectPercentText, -1);
//     setUIText(txtUnitName, NULL);
//     setUITextHighlight(txtUnitName, NO_HIGHLIGHT, 0);

//     // update the frame index of unit info/portraits
//     // based on the number of entities selected
//     //
//     // TODO: the max number of selected entities shouldn't greater than 4 but
//     // that's not implemented right now, so put a min call to guard for that.
//     s32 selectedEntitiesCount = min(map->selectedEntities.count, 4);
//     if (selectedEntitiesCount > 1)
//     {
//         // for 4 units selected -> frame indices 5, 8
//         // for 3 units selected -> frame indices 4, 7
//         // for 2 units selected -> frame indices 3, 6
//         setUIImage(imgUnitInfo, selectedEntitiesCount + 1);
//         setUIImage(imgUnitInfoLife, selectedEntitiesCount + 4);

//         for (s32 i = 1; i <= selectedEntitiesCount; i++)
//         {
//             WarEntityId selectedEntityId = map->selectedEntities.items[i - 1];
//             WarEntity* selectedEntity = findEntity(selectedEntityId);
//             if (selectedEntity && isUnit(selectedEntity))
//             {
//                 WarUnitComponent* unit = &selectedEntity->unit;
//                 WarUnitData unitsData = getUnitData(unit->type);
//                 setUIImage(imgUnitPortraits[i], unitsData.portraitFrameIndex);
//                 setLifeBar(rectLifeBars[i], unit);
//             }
//         }
//     }
//     else if (selectedEntitiesCount == 1)
//     {
//         WarEntityId selectedEntityId = map->selectedEntities.items[0];
//         WarEntity* selectedEntity = findEntity(selectedEntityId);
//         if (selectedEntity && isUnit(selectedEntity))
//         {
//             WarUnitComponent* unit = &selectedEntity->unit;

//             if (isDudeUnit(selectedEntity))
//             {
//                 if (isMagicUnit(selectedEntity))
//                 {
//                     setUIImage(imgUnitInfo, 1);
//                     setManaBar(rectMagicBar, unit);
//                 }
//                 else
//                 {
//                     setUIImage(imgUnitInfo, 0);
//                 }
//             }
//             else if (isBuildingUnit(selectedEntity))
//             {
//                 if (unit->building)
//                 {
//                     setUIImage(imgUnitInfo, 2);
//                     setPercentBar(rectPercentBar, rectPercentText, unit);
//                 }
//                 else
//                 {
//                     setUIImage(imgUnitInfo, 0);
//                 }
//             }

//             WarUnitData unitsData = getUnitData(unit->type);
//             setUIImage(imgUnitPortraits[0], unitsData.portraitFrameIndex);
//             setUIText(txtUnitName, unitsData.name);
//             setUITextHighlight(txtUnitName, NO_HIGHLIGHT, 0);
//             setLifeBar(rectLifeBars[0], unit);
//         }
//     }
// }

setStatus :: (highlightIndex: s32, highlightCount: s32, gold: s32, wood: s32, textFormat: string, args: ..Any) {
    txtStatus := findUIEntity("txtStatus");
    assert(txtStatus != null);

    imgStatusWood := findUIEntity("imgStatusWood");
    assert(imgStatusWood != null);

    imgStatusGold := findUIEntity("imgStatusGold");
    assert(imgStatusGold != null);

    txtStatusWood := findUIEntity("txtStatusWood");
    assert(txtStatusWood != null);

    txtStatusGold := findUIEntity("txtStatusGold");
    assert(txtStatusGold != null);

    setUITextFormat(txtStatus, textFormat, args);
    setUITextHighlight(txtStatus, highlightIndex, highlightCount);

    if (gold == 0 && wood == 0) {
        setComponentStatus(imgStatusWood, SpriteComponent, false);
        setComponentStatus(imgStatusGold, SpriteComponent, false);
        clearUIText(txtStatusWood);
        clearUIText(txtStatusGold);
    } else {
        setComponentStatus(imgStatusWood, SpriteComponent, true);
        setComponentStatus(imgStatusGold, SpriteComponent, true);
        setUITextFormat(txtStatusWood, "%", wood);
        setUITextHighlight(txtStatusWood, NO_HIGHLIGHT, 0);
        setUITextFormat(txtStatusGold, "%", gold);
        setUITextHighlight(txtStatusGold, NO_HIGHLIGHT, 0);
    }
}

setLifeBar :: (rectLifeBar: *Entity, unit: *UnitComponent) {
    LIFE_BAR_RED_THRESHOLD :: 0.35;
    LIFE_BAR_YELLOW_THRESHOLD :: 0.70;
    LIFE_BAR_WIDTH_PX :: 27;

    hpPercent := cast(f32) unit.hp / unit.maxhp;

    if (hpPercent <= LIFE_BAR_RED_THRESHOLD) {
        setUIRectColor(rectLifeBar, COLOR_RED);
    } else if (hpPercent <= LIFE_BAR_YELLOW_THRESHOLD) {
        setUIRectColor(rectLifeBar, COLOR_YELLOW);
    } else {
        setUIRectColor(rectLifeBar, COLOR_GREEN);
    }

    setUIRectWidth(rectLifeBar, cast(s32) (hpPercent * LIFE_BAR_WIDTH_PX));
}

setManaBar :: (rectMagicBar: *Entity, unit: *UnitComponent) {
    MAGIC_BAR_WIDTH_PX :: 27;

    magicPercent := cast(f32) unit.mana / unit.maxMana;
    setUIRectWidth(rectMagicBar, cast(s32) (magicPercent * MAGIC_BAR_WIDTH_PX));
}

setPercentBar :: (rectPercentBar: *Entity, rectPercentText: *Entity, unit: *UnitComponent) {
    PERCENT_BAR_WIDTH_PX :: 64;

    setUIRectWidth(rectPercentBar, cast(s32) (unit.buildPercent * PERCENT_BAR_WIDTH_PX));
    setUIImage(rectPercentText, 0);
}

renderSelectionRect :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    nvgSave(ctx.gfx);

    if (isDragging()) {
        pointerRect := getDragRect();
        nvgStrokeRect(ctx.gfx, pointerRect, NVG_GREEN_SELECTION, 1.0);
    }

    nvgRestore(ctx.gfx);
}

// void renderUICommand(WarContext* context)
// {
//     WarMap* map = context->map;
//     WarInput* input = &context->input;
//     WarUICommand* uiCommand = &map->uiCommand;

//     if (map->observer)
//     {
//         // NOTE: If there is an observer there is no ui command to be rendered
//         return;
//     }

//     WarPlayerInfo* uiPlayer = getMapUIPlayer(map);
//     assert(uiPlayer);

//     NVGcontext* gfx = context->gfx;

//     nvgSave(gfx);

//     switch (uiCommand->type)
//     {
//         case WAR_UI_COMMAND_BUILD_FARM_HUMANS:
//         case WAR_UI_COMMAND_BUILD_FARM_ORCS:
//         case WAR_UI_COMMAND_BUILD_BARRACKS_HUMANS:
//         case WAR_UI_COMMAND_BUILD_BARRACKS_ORCS:
//         case WAR_UI_COMMAND_BUILD_CHURCH:
//         case WAR_UI_COMMAND_BUILD_TEMPLE:
//         case WAR_UI_COMMAND_BUILD_TOWER_HUMANS:
//         case WAR_UI_COMMAND_BUILD_TOWER_ORCS:
//         case WAR_UI_COMMAND_BUILD_TOWNHALL_HUMANS:
//         case WAR_UI_COMMAND_BUILD_TOWNHALL_ORCS:
//         case WAR_UI_COMMAND_BUILD_LUMBERMILL_HUMANS:
//         case WAR_UI_COMMAND_BUILD_LUMBERMILL_ORCS:
//         case WAR_UI_COMMAND_BUILD_STABLE:
//         case WAR_UI_COMMAND_BUILD_KENNEL:
//         case WAR_UI_COMMAND_BUILD_BLACKSMITH_HUMANS:
//         case WAR_UI_COMMAND_BUILD_BLACKSMITH_ORCS:
//         {
//             vec2 position = vec2ScreenToMapCoordinates(input->pos);
//             position = vec2MapToTileCoordinates(position);

//             WarUnitType unitType = uiCommand->build.unitType;
//             WarUnitData data = getUnitData(unitType);

//             NVGcolor fillColor = checkRectToBuild(uiPlayer, position.x, position.y, data.sizex, data.sizey)
//                 ? NVG_GRAY_TRANSPARENT : NVG_RED_TRANSPARENT;

//             position = vec2TileToMapCoordinates(position, false);
//             position = vec2MapToScreenCoordinates(position);
//             vec2 size = vec2i(data.sizex * MEGA_TILE_WIDTH, data.sizey * MEGA_TILE_HEIGHT);
//             rect buildingRect = rectv(position, size);
//             nvgFillRect(gfx, buildingRect, fillColor);

//             break;
//         }

//         case WAR_UI_COMMAND_BUILD_WALL:
//         case WAR_UI_COMMAND_BUILD_ROAD:
//         {
//             vec2 position = vec2ScreenToMapCoordinates(input->pos);
//             position = vec2MapToTileCoordinates(position);

//             NVGcolor fillColor = checkRectToBuild(uiPlayer, position.x, position.y, 1, 1)
//                 ? NVG_GRAY_TRANSPARENT : NVG_RED_TRANSPARENT;

//             position = vec2TileToMapCoordinates(position, false);
//             position = vec2MapToScreenCoordinates(position);
//             vec2 size = vec2i(MEGA_TILE_WIDTH, MEGA_TILE_HEIGHT);
//             rect buildingRect = rectv(position, size);
//             nvgFillRect(gfx, buildingRect, fillColor);

//             break;
//         }

//         default:
//         {
//             // don't render the rest of the commands
//             break;
//         }
//     }

//     nvgRestore(gfx);
// }