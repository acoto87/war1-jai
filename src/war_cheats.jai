WarCheat :: enum u16 {
    // original cheats
    Gold;           // Pot of Gold: Gives 10000 gold and 5000 lumber to the player
    Spells;         // Eye of newt: All spells are now be able to be casted
    Upgrades;       // Iron forge: Research all upgrades
    End;            // Ides of March: Brings player to final campaign sequence
    Enable;         // Corwin of Amber: Enables cheats
    GodMode;        // There can be only one: Your units stop taking damage and deal 255 Damage
    Win;            // Yours truly: Win current mission
    Loss;           // Crushing defeat: Instant loss
    Fog;            // Sally Shears: Disables fog of war
    SkipHuman;      // Human #: Skip to human level (enter 1-12 for #)
    SkipOrc;        // Orc #: Skip to orc level (enter 1-12 for #)
    Speed;          // Hurry up guys: Speeds up building/unit production

    // custom cheats
    Music;          // Music #: Set volume music (enter 1-45 for #)
    Edit;           // Edit #: Make things editable (enter trees, walls, ruins, roads for #)
    AddUnit;        // Add unit #: Add unit to the map (enter unit name for #)
    RainOfFire;     // Rain of fire: Player can throw rain of fire projectiles

    // debug cheats
    DebugGrid;      // render debug grid in the map
    DebugPassable;  // render debug passable info
    DebugPaths;     // render debug unit paths
}

registerCheats :: () {
    for desc : cheatDescriptors {
        registerCheat(desc.id, desc);
    }
}

#scope_file

Basic :: #import "Basic";
parseInt :: Basic.string_to_int;

cheatDescriptors : [] CheatDescriptor = .[
    // original cheats
    .{ cast(u16) WarCheat.Gold,             "Pot of gold",              false,  applyGoldCheat        },
    .{ cast(u16) WarCheat.Spells,           "Eye of newt",              false,  applySpellsCheat      },
    .{ cast(u16) WarCheat.Upgrades,         "Iron forge",               false,  applyUpgradesCheat    },
    .{ cast(u16) WarCheat.End,              "Ides of march",            false,  applyEndCheat         },
    .{ cast(u16) WarCheat.Enable,           "Corwin of Amber",          false,  applyEnableCheat      },
    .{ cast(u16) WarCheat.GodMode,          "There can be only one",    false,  applyGodModeCheat     },
    .{ cast(u16) WarCheat.Win,              "Yours truly",              false,  applyWinCheat         },
    .{ cast(u16) WarCheat.Loss,             "Crushing defeat",          false,  applyLossCheat        },
    .{ cast(u16) WarCheat.Fog,              "Sally Shears",             false,  applyFogOfWarCheat    },
    .{ cast(u16) WarCheat.SkipHuman,        "Human",                    true,   applySkipHumanCheat   },
    .{ cast(u16) WarCheat.SkipOrc,          "Orc",                      true,   applySkipOrcCheat     },
    .{ cast(u16) WarCheat.Speed,            "Hurry up guys",            false,  applySpeedCheat       },

    // custom cheats
    .{ cast(u16) WarCheat.Music,            "Music",                    true,   applyMusicCheat       },
    .{ cast(u16) WarCheat.Edit,             "Edit",                     true,   applyEditCheat        },
    .{ cast(u16) WarCheat.AddUnit,          "Add unit",                 true,   applyAddUnitCheat     },
    .{ cast(u16) WarCheat.RainOfFire,       "Rain of fire",             false,  applyRainOfFireCheat  },

    // debug cheats
    .{ cast(u16) WarCheat.DebugGrid,        "Debug grid",               false,  applyDebugGrid        },
    .{ cast(u16) WarCheat.DebugPassable,    "Debug passable",           false,  applyDebugPassable    },
    .{ cast(u16) WarCheat.DebugPaths,       "Debug paths",              false,  applyDebugPaths       },
];

applyGoldCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // increasePlayerResource(context, &map->players[0], WAR_RESOURCE_GOLD, CHEAT_GOLD_INCREASE);
    // increasePlayerResource(context, &map->players[0], WAR_RESOURCE_WOOD, CHEAT_WOOD_INCREASE);

    // setCheatsFeedback(context, CHEAT_FEEDBACK_WASCALLY_WABBIT);
}

applySpellsCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // WarPlayerInfo* player = &map->players[0];

    // WarFeatureType features[] =
    // {
    //     WAR_FEATURE_SPELL_HEALING,
    //     WAR_FEATURE_SPELL_RAISE_DEAD,
    //     WAR_FEATURE_SPELL_FAR_SIGHT,
    //     WAR_FEATURE_SPELL_DARK_VISION,
    //     WAR_FEATURE_SPELL_INVISIBILITY,
    //     WAR_FEATURE_SPELL_UNHOLY_ARMOR,
    //     WAR_FEATURE_SPELL_SCORPION,
    //     WAR_FEATURE_SPELL_SPIDER,
    //     WAR_FEATURE_SPELL_RAIN_OF_FIRE,
    //     WAR_FEATURE_SPELL_POISON_CLOUD,
    //     WAR_FEATURE_SPELL_WATER_ELEMENTAL,
    //     WAR_FEATURE_SPELL_DAEMON,
    // };

    // for (s32 i = 0; i < arrayLength(features); i++)
    // {
    //     setFeatureAllowed(player, features[i], true);
    // }

    // WarUpgradeType spells[] =
    // {
    //     WAR_UPGRADE_SCORPIONS,
    //     WAR_UPGRADE_SPIDERS,
    //     WAR_UPGRADE_RAIN_OF_FIRE,
    //     WAR_UPGRADE_POISON_CLOUD,
    //     WAR_UPGRADE_WATER_ELEMENTAL,
    //     WAR_UPGRADE_DAEMON,
    //     WAR_UPGRADE_HEALING,
    //     WAR_UPGRADE_RAISE_DEAD,
    //     WAR_UPGRADE_FAR_SIGHT,
    //     WAR_UPGRADE_DARK_VISION,
    //     WAR_UPGRADE_INVISIBILITY,
    //     WAR_UPGRADE_UNHOLY_ARMOR
    // };

    // for (s32 i = 0; i < arrayLength(spells); i++)
    // {
    //     WarUpgradeData upgradeData = getUpgradeData(spells[i]);
    //     setUpgradeAllowed(player, spells[i], upgradeData.maxLevelAllowed);
    //     while (hasRemainingUpgrade(player, spells[i]))
    //     {
    //         increaseUpgradeLevel(context, player, spells[i]);
    //     }
    // }

    // setCheatsFeedback(context, CHEAT_FEEDBACK_WASCALLY_WABBIT);
}

applyUpgradesCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // WarPlayerInfo* player = &map->players[0];

    // WarUpgradeType upgrades[] =
    // {
    //     WAR_UPGRADE_ARROWS,
    //     WAR_UPGRADE_SPEARS,
    //     WAR_UPGRADE_SWORDS,
    //     WAR_UPGRADE_AXES,
    //     WAR_UPGRADE_SHIELD
    // };

    // for (s32 i = 0; i < arrayLength(upgrades); i++)
    // {
    //     WarUpgradeData upgradeData = getUpgradeData(upgrades[i]);
    //     setUpgradeAllowed(player, upgrades[i], upgradeData.maxLevelAllowed);
    //     while (hasRemainingUpgrade(player, upgrades[i]))
    //     {
    //         increaseUpgradeLevel(context, player, upgrades[i]);
    //     }
    // }

    // setCheatsFeedback(context, CHEAT_FEEDBACK_WASCALLY_WABBIT);
}

applyEndCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->playing = false;

    // showDemoEndMenu(context, true);
}

applyEnableCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    ctx.cheatsEnabled = !ctx.cheatsEnabled;

    if (ctx.cheatsEnabled) {
        setCheatsFeedback("cheats enabled");
    } else {
        setCheatsFeedback("cheats disabled");
    }
}

applyGodModeCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // WarPlayerInfo* player = &map->players[0];
    // player->godMode = !player->godMode;

    // setCheatsFeedback(context, CHEAT_FEEDBACK_WASCALLY_WABBIT);
}

applyWinCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->result = WAR_LEVEL_RESULT_WIN;

    // setCheatsFeedback(context, CHEAT_FEEDBACK_WASCALLY_WABBIT);
}

applyLossCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->result = WAR_LEVEL_RESULT_LOSE;

    // setCheatsFeedback(context, CHEAT_FEEDBACK_WASCALLY_WABBIT);
}

applyFogOfWarCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->fowEnabled = !map->fowEnabled;

    // setCheatsFeedback(context, CHEAT_FEEDBACK_WASCALLY_WABBIT);
}

applySkipHumanCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // s32 level;
    // if (strTryParseS32(argument, &level))
    // {
    //     // TODO: remove this check when more levels are allowed
    //     if (level <= 0 || level > 2)
    //         return;

    //     WarScene* scene = createScene(context, WAR_SCENE_BRIEFING);
    //     scene->briefing.race = WAR_RACE_HUMANS;
    //     scene->briefing.mapType = WAR_CAMPAIGN_HUMANS_01 + 2 * (level - 1);
    //     setNextScene(context, scene, 1.0f);
    // }
}

applySkipOrcCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // s32 level;
    // if (strTryParseS32(argument, &level))
    // {
    //     // TODO: remove this check when more levels are allowed
    //     if (level <= 0 || level > 2)
    //         return;

    //     WarScene* scene = createScene(context, WAR_SCENE_BRIEFING);
    //     scene->briefing.race = WAR_RACE_ORCS;
    //     scene->briefing.mapType = WAR_CAMPAIGN_ORCS_01 + 2 * (level - 1);
    //     setNextScene(context, scene, 1.0f);
    // }
}

applySpeedCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->hurryUp = !map->hurryUp;

    // setCheatsFeedback(context, CHEAT_FEEDBACK_WASCALLY_WABBIT);
}

applyEditCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->editingTrees = false;
    // map->editingWalls = false;
    // map->editingRoads = false;
    // map->editingRuins = false;
    // map->editingRainOfFire = false;
    // map->addingUnit = false;

    // if (strCaseEquals(argument, "off", true))
    // {
    //     setCheatsFeedback(context, "Edit off");
    //     return;
    // }

    // if (strCaseEquals(argument, "trees", true))
    // {
    //     map->editingTrees = true;
    //     setCheatsFeedback(context, "Edit trees on");
    // }
    // else if (strCaseEquals(argument, "walls", true))
    // {
    //     map->editingWalls = true;
    //     setCheatsFeedback(context, "Edit walls on");
    // }
    // else if (strCaseEquals(argument, "roads", true))
    // {
    //     map->editingRoads = true;
    //     setCheatsFeedback(context, "Edit roads on");
    // }
    // else if (strCaseEquals(argument, "ruins", true))
    // {
    //     map->editingRuins = true;
    //     setCheatsFeedback(context, "Edit ruins on");
    // }
}

applyMusicCheat :: (arguments: string) {
    ctx := cast(*GameContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    if (!isDemo()) {
        musicId, success := parseInt(arguments);
        if (success) {
            // argument is expected in the range 1-45, so convert it to the range 0-44
            musicId -= 1;

            if (musicId >= cast(u32) WarAudioId.Music00 && musicId <= cast(u32) WarAudioId.Music44) {
                // before changing the music, remove the current one
                // almost all the time there should only one active
                // but I really don't if that will hold true in the future
                //
                // for now remove all the active music (audios of type WAR_AUDIO_MIDI)
                // and the create the new one
                //
                // removeAudiosOfType(WAR_AUDIO_MIDI);
                // createAudio(musicId, true);
                setCheatsFeedbackFormat("Music % set", musicId + 1);
            }
        }
    }
}

applyAddUnitCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->editingTrees = false;
    // map->editingWalls = false;
    // map->editingRoads = false;
    // map->editingRuins = false;
    // map->editingRainOfFire = false;

    // map->addingUnit = false;

    // if (strCaseStartsWith(argument, "off", true))
    // {
    //     setCheatsFeedback(context, "Add unit off");
    //     return;
    // }

    // if (strCaseStartsWith(argument, "CATAPULT", true))
    // {
    //     const char* part2 = strSkipUntil(argument + strlen("CATAPULT"), " ");
    //     if (strCaseStartsWith(part2, "HUMANS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_CATAPULT_HUMANS;
    //     }
    //     else if (strCaseStartsWith(part2, "ORCS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_CATAPULT_ORCS;
    //     }
    // }
    // else if (strCaseStartsWith(argument, "FARM", true))
    // {
    //     const char* part2 = strSkipUntil(argument + strlen("FARM"), " ");
    //     if (strCaseStartsWith(part2, "HUMANS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_FARM_HUMANS;
    //     }
    //     else if (strCaseStartsWith(part2, "ORCS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_FARM_ORCS;
    //     }
    // }
    // else if (strCaseStartsWith(argument, "BARRACkS", true))
    // {
    //     const char* part2 = strSkipUntil(argument + strlen("BARRACkS"), " ");
    //     if (strCaseStartsWith(part2, "HUMANS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_BARRACKS_HUMANS;
    //     }
    //     else if (strCaseStartsWith(part2, "ORCS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_BARRACKS_ORCS;
    //     }
    // }
    // else if (strCaseStartsWith(argument, "TOWER", true))
    // {
    //     const char* part2 = strSkipUntil(argument + strlen("TOWER"), " ");
    //     if (strCaseStartsWith(part2, "HUMANS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_TOWER_HUMANS;
    //     }
    //     else if (strCaseStartsWith(part2, "ORCS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_TOWER_ORCS;
    //     }
    // }
    // else if (strCaseStartsWith(argument, "TOWN HALL", true))
    // {
    //     const char* part2 = strSkipUntil(argument + strlen("TOWN HALL"), " ");
    //     if (strCaseStartsWith(part2, "HUMANS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_TOWNHALL_HUMANS;
    //     }
    //     else if (strCaseStartsWith(part2, "ORCS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_TOWNHALL_ORCS;
    //     }
    // }
    // else if (strCaseStartsWith(argument, "MILL", true))
    // {
    //     const char* part2 = strSkipUntil(argument + strlen("MILL"), " ");
    //     if (strCaseStartsWith(part2, "HUMANS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_LUMBERMILL_HUMANS;
    //     }
    //     else if (strCaseStartsWith(part2, "ORCS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_LUMBERMILL_ORCS;
    //     }
    // }
    // else if (strCaseStartsWith(argument, "BLACKSMITH", true))
    // {
    //     const char* part2 = strSkipUntil(argument + strlen("BLACKSMITH"), " ");
    //     if (strCaseStartsWith(part2, "HUMANS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_BLACKSMITH_HUMANS;
    //     }
    //     else if (strCaseStartsWith(part2, "ORCS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_BLACKSMITH_ORCS;
    //     }
    // }
    // else if (strCaseStartsWith(argument, "CORPSE", true))
    // {
    //     const char* part2 = strSkipUntil(argument + strlen("CORPSE"), " ");
    //     if (strCaseStartsWith(part2, "HUMANS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_HUMAN_CORPSE;
    //     }
    //     else if (strCaseStartsWith(part2, "ORCS", true))
    //     {
    //         map->addingUnit = true;
    //         map->addingUnitType = WAR_UNIT_ORC_CORPSE;
    //     }
    // }
    // else
    // {
    //     for (s32 i = 0; i < arrayLength(unitsData); i++)
    //     {
    //         if (strCaseEquals(argument, unitsData[i].name, true))
    //         {
    //             map->addingUnit = true;
    //             map->addingUnitType = unitsData[i].type;
    //             break;
    //         }
    //     }
    // }

    // if (map->addingUnit)
    // {
    //     setCheatsFeedbackFormat(context, "Add unit %s", argument);
    // }
}

applyRainOfFireCheat :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->editingTrees = false;
    // map->editingWalls = false;
    // map->editingRoads = false;
    // map->editingRuins = false;
    // map->editingRainOfFire = !map->editingRainOfFire;
    // map->addingUnit = false;

    // if (map->editingRainOfFire)
    //     setCheatsFeedback(context, "Rain of fire on");
    // else
    //     setCheatsFeedback(context, "Rain of fire off");
}

applyDebugGrid :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->renderDebugGrid = !map->renderDebugGrid;

    // if (map->renderDebugGrid)
    //     setCheatsFeedback(context, "Render debug grid on");
    // else
    //     setCheatsFeedback(context, "Render debug grid off");
}

applyDebugPassable :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->renderDebugPassable = !map->renderDebugPassable;

    // if (map->renderDebugPassable)
    //     setCheatsFeedback(context, "Render debug passable info on");
    // else
    //     setCheatsFeedback(context, "Render debug passable info off");
}

applyDebugPaths :: (arguments: string) {
    ctx := cast(*WarContext) context.gameContext;
    assert(ctx != null);

    if (!ctx.cheatsEnabled) {
        return;
    }

    // WarMap* map = context->map;
    // if (!map)
    //     return;

    // map->renderDebugPaths = !map->renderDebugPaths;

    // if (map->renderDebugPaths)
    //     setCheatsFeedback(context, "Render debug paths on");
    // else
    //     setCheatsFeedback(context, "Render debug paths off");
}
