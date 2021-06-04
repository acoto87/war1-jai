updateMap :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    map := cast(*WarMap) ctx.scene;
    assert(map != null);

    // updateViewport(context);
    // updateDragRect(context);

    if (!map.playing)
    {
        // updateUIButtons(true);
        // updateMapCursor(context);
        return;
    }

    // if (!executeUICommand(context))
    // {
    //     // only update the selection if the current command doesn't get
    //     // executed or there is no command at all.
    //     // the reason is because some commands are executed by the left click
    //     // as well as the selection, and if a command get executed the current
    //     // selection shouldn't be lost
    //     updateSelection(context);
    // }

    // updateAIPlayers(context);

    // updateStateMachines(context);
    // updateActions(context);
    // updateAnimations(context);
    // updateProjectiles(context);
    // updateMagic(context);
    // updateSpells(context);
    // updateSquads(context);

    // updateFoW(context);
    // determineFoWTypes(context);

    updateGoldText();
    updateWoodText();
    // updateSelectedUnitsInfo(context);
    // updateCommandButtons(context);

    updateCheatsPanel();
    updateFlashText(isCheatsPanelVisible());

    updateUIButtons(!isCheatsPanelVisible());

    // updateCommandFromRightClick(context);
    updateStatus();

    // updateMapCursor(context);

    // updateTreesEdit(context);
    // updateRoadsEdit(context);
    // updateWallsEdit(context);
    // updateRuinsEdit(context);
    // updateRainOfFireEdit(context);
    // updateAddUnit(context);

    // updateObjectives(context);
}

#scope_file

Basic :: #import "Basic";
formatInt :: Basic.formatInt;

updateGoldText :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    map := cast(*WarMap) ctx.scene;
    assert(map != null);

    txtGold := findUIEntity("txtGold");
    assert(txtGold != null);

    gold := map.players[0].resources[cast(s32) WarResourceKind.Gold];
    setUITextFormat(txtGold, "GOLD:%", formatInt(gold, minimum_digits = 6));
    setUITextHighlight(txtGold, NO_HIGHLIGHT, 0);
}

updateWoodText :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    map := cast(*WarMap) ctx.scene;
    assert(map != null);

    txtWood := findUIEntity("txtWood");
    assert(txtWood != null);

    wood := map.players[0].resources[cast(s32) WarResourceKind.Wood];
    setUITextFormat(txtWood, "LUMBER:%", formatInt(wood, minimum_digits = 6));
    setUITextHighlight(txtWood, NO_HIGHLIGHT, 0);
}

updateStatus :: () {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    map := cast(*WarMap) ctx.scene;
    assert(map != null);

    if (isCheatsPanelVisible() || isFlashTextVisible()) {
        return;
    }

    statusText := "";
    highlightIndex: s32 = NO_HIGHLIGHT;
    highlightCount: s32 = 0;
    goldCost: s32 = 0;
    woodCost: s32 = 0;

    for entityId : map.selectedEntities {
        selectedEntity := findEntity(entityId);
        assert(selectedEntity != null);

        if (isBuildingUnit(selectedEntity)) {
            if (isTraining(selectedEntity) || isGoingToTrain(selectedEntity)) {
                trainState := getTrainState(selectedEntity);
                unitToBuild := trainState.unitToBuild;
                commandMapping := getCommandMappingFromUnitType(unitToBuild);
                commandData := getCommandBaseData(commandMapping.type);

                statusText = commandData.tooltip2;
            } else if (isUpgrading(selectedEntity) || isGoingToUpgrade(selectedEntity)) {
                upgradeState := getUpgradeState(selectedEntity);
                upgradeToBuild := upgradeState.upgradeToBuild;
                commandMapping := getCommandMappingFromUpgradeType(upgradeToBuild);
                commandData := getCommandBaseData(commandMapping.type);

                statusText = commandData.tooltip2;
            } else {
                unit := getComponent(selectedEntity, UnitComponent);
                assert(unit != null);

                hp := unit.hp;
                maxhp := unit.maxhp;
                if (unit.hp < unit.maxhp) {
                    // to calculate the amount of wood and gold needed to repair a
                    // building I'm taking the 12% of the damage of the building,
                    // so for the a FARM if it has a damage of 200, the amount of
                    // wood and gold would be 200 * 0.12 = 24.
                    //
                    repairCost = cast(s32) ceil((unit.maxhp - unit.hp) * 0.12);
                    statusText = sprint("FULL REPAIRS WILL COST % GOLD & LUMBER", repairCost);
                }
            }
        } else if (isWorkerUnit(selectedEntity)) {
            if (isCarryingResources(selectedEntity)) {
                unit := getComponent(selectedEntity, UnitComponent);
                assert(unit != null);

                if (unit.resourceKind == WAR_RESOURCE_GOLD) {
                    statusText = "CARRYING GOLD";
                } else if (unit.resourceKind == WAR_RESOURCE_WOOD) {
                    statusText = "CARRYING LUMBER";
                }
            }
        }
    }

    buttons := getEntitiesOfType(EntityTypes.Button);
    defer uninit(*buttons);

    for button : buttons {
        uiComponent := getComponent(button, UIComponent);
        assert(uiComponent != null);

        if (uiComponent.enabled) {
            buttonComponent := getComponent(button, ButtonComponent);
            assert(buttonComponent != null);

            if (buttonComponent.enabled && buttonComponent.interactive && buttonComponent.hot) {
                statusText := buttonComponent.tooltip;
                goldCost = buttonComponent.gold;
                woodCost = buttonComponent.wood;
                highlightIndex = buttonComponent.highlightIndex;
                highlightCount = buttonComponent.highlightCount;
            }
        }
    }

    setStatus(highlightIndex, highlightCount, goldCost, woodCost, statusText);
}