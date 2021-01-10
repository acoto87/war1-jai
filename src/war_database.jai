DatabaseEntryType :: enum {
    Unknown;
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

DatabaseEntry :: struct {
    index: u32;
    type: DatabaseEntryType;
    name: string;
    param1: u16;
    param2: u16;
    param3: u16;
}

assets :: DatabaseEntry.[
    // Music
    .{   0, DatabaseEntryType.Xmid,              "00",                                           0, 0, 0 },
    .{   1, DatabaseEntryType.Xmid,              "01",                                           0, 0, 0 },
    .{   2, DatabaseEntryType.Xmid,              "02",                                           0, 0, 0 }, // demo
    .{   3, DatabaseEntryType.Xmid,              "03",                                           0, 0, 0 },
    .{   4, DatabaseEntryType.Xmid,              "04",                                           0, 0, 0 }, // demo
    .{   5, DatabaseEntryType.Xmid,              "05",                                           0, 0, 0 },
    .{   6, DatabaseEntryType.Xmid,              "06",                                           0, 0, 0 },
    .{   7, DatabaseEntryType.Xmid,              "07",                                           0, 0, 0 },
    .{   8, DatabaseEntryType.Xmid,              "08",                                           0, 0, 0 },
    .{   9, DatabaseEntryType.Xmid,              "09",                                           0, 0, 0 },
    .{  10, DatabaseEntryType.Xmid,              "10",                                           0, 0, 0 },
    .{  11, DatabaseEntryType.Xmid,              "11",                                           0, 0, 0 },
    .{  12, DatabaseEntryType.Xmid,              "12",                                           0, 0, 0 },
    .{  13, DatabaseEntryType.Xmid,              "13",                                           0, 0, 0 },
    .{  14, DatabaseEntryType.Xmid,              "14",                                           0, 0, 0 },
    .{  15, DatabaseEntryType.Xmid,              "15",                                           0, 0, 0 },
    .{  16, DatabaseEntryType.Xmid,              "16",                                           0, 0, 0 },
    .{  17, DatabaseEntryType.Xmid,              "17",                                           0, 0, 0 }, // demo
    .{  18, DatabaseEntryType.Xmid,              "18",                                           0, 0, 0 },
    .{  19, DatabaseEntryType.Xmid,              "19",                                           0, 0, 0 }, // demo
    .{  20, DatabaseEntryType.Xmid,              "20",                                           0, 0, 0 },
    .{  21, DatabaseEntryType.Xmid,              "21",                                           0, 0, 0 },
    .{  22, DatabaseEntryType.Xmid,              "22",                                           0, 0, 0 },
    .{  23, DatabaseEntryType.Xmid,              "23",                                           0, 0, 0 },
    .{  24, DatabaseEntryType.Xmid,              "24",                                           0, 0, 0 },
    .{  25, DatabaseEntryType.Xmid,              "25",                                           0, 0, 0 },
    .{  26, DatabaseEntryType.Xmid,              "26",                                           0, 0, 0 },
    .{  27, DatabaseEntryType.Xmid,              "27",                                           0, 0, 0 },
    .{  28, DatabaseEntryType.Xmid,              "28",                                           0, 0, 0 },
    .{  29, DatabaseEntryType.Xmid,              "29",                                           0, 0, 0 },
    .{  30, DatabaseEntryType.Xmid,              "30",                                           0, 0, 0 },
    .{  31, DatabaseEntryType.Xmid,              "31",                                           0, 0, 0 },
    .{  32, DatabaseEntryType.Xmid,              "32",                                           0, 0, 0 }, // demo
    .{  33, DatabaseEntryType.Xmid,              "33",                                           0, 0, 0 },
    .{  34, DatabaseEntryType.Xmid,              "34",                                           0, 0, 0 }, // demo
    .{  35, DatabaseEntryType.Xmid,              "35",                                           0, 0, 0 },
    .{  36, DatabaseEntryType.Xmid,              "36",                                           0, 0, 0 },
    .{  37, DatabaseEntryType.Xmid,              "37",                                           0, 0, 0 },
    .{  38, DatabaseEntryType.Xmid,              "38",                                           0, 0, 0 },
    .{  39, DatabaseEntryType.Xmid,              "39",                                           0, 0, 0 },
    .{  40, DatabaseEntryType.Xmid,              "40",                                           0, 0, 0 },
    .{  41, DatabaseEntryType.Xmid,              "41",                                           0, 0, 0 },
    .{  42, DatabaseEntryType.Xmid,              "42",                                           0, 0, 0 },
    .{  43, DatabaseEntryType.Xmid,              "43",                                           0, 0, 0 },
    .{  44, DatabaseEntryType.Xmid,              "44",                                           0, 0, 0 },

    // Levels info
    .{  45, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  46, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  47, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  48, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  49, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  50, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  51, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  52, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  53, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  54, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  55, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  56, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  57, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  58, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  59, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  60, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  61, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  62, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  63, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  64, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  65, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  66, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  67, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  68, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  69, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  70, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  71, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  72, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  73, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  74, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  75, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  76, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  77, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  78, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  79, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  80, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  81, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  82, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  83, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  84, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  85, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  86, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  87, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  88, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  89, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  90, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  91, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  92, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  93, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 }, // demo
    .{  94, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 }, // demo
    .{  95, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  96, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  97, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{  98, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{  99, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 100, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{ 101, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 102, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{ 103, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 104, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{ 105, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 106, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{ 107, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 108, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{ 109, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 110, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{ 111, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 112, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{ 113, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 114, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },
    .{ 115, DatabaseEntryType.LevelVisual,      "FileLevelVisual",                              0, 0, 0 },
    .{ 116, DatabaseEntryType.LeveLPassable,    "FileLevelPassable",                            0, 0, 0 },

    // Levels
    .{ 117, DatabaseEntryType.LevelInfo,        "humans_01",                                    0, 0, 0 }, // demo
    .{ 118, DatabaseEntryType.LevelInfo,        "orcs_01",                                      1, 0, 0 }, // demo
    .{ 119, DatabaseEntryType.LevelInfo,        "humans_02",                                    0, 0, 0 }, // demo
    .{ 120, DatabaseEntryType.LevelInfo,        "orcs_02",                                      1, 0, 0 }, // demo
    .{ 121, DatabaseEntryType.LevelInfo,        "humans_03",                                    1, 0, 0 }, // demo
    .{ 122, DatabaseEntryType.LevelInfo,        "orcs_03",                                      0, 0, 0 }, // demo
    .{ 123, DatabaseEntryType.LevelInfo,        "humans_04",                                    2, 0, 0 },
    .{ 124, DatabaseEntryType.LevelInfo,        "orcs_04",                                      2, 0, 0 },
    .{ 125, DatabaseEntryType.LevelInfo,        "humans_05",                                    0, 0, 0 },
    .{ 126, DatabaseEntryType.LevelInfo,        "orcs_05",                                      1, 0, 0 },
    .{ 127, DatabaseEntryType.LevelInfo,        "humans_06",                                    0, 0, 0 },
    .{ 128, DatabaseEntryType.LevelInfo,        "orcs_06",                                      0, 0, 0 },
    .{ 129, DatabaseEntryType.LevelInfo,        "humans_07",                                    0, 0, 0 },
    .{ 130, DatabaseEntryType.LevelInfo,        "orcs_07",                                      1, 0, 0 },
    .{ 131, DatabaseEntryType.LevelInfo,        "humans_08",                                    2, 0, 0 },
    .{ 132, DatabaseEntryType.LevelInfo,        "orcs_08",                                      2, 0, 0 },
    .{ 133, DatabaseEntryType.LevelInfo,        "humans_09",                                    1, 0, 0 },
    .{ 134, DatabaseEntryType.LevelInfo,        "orcs_09",                                      1, 0, 0 },
    .{ 135, DatabaseEntryType.LevelInfo,        "humans_10",                                    1, 0, 0 },
    .{ 136, DatabaseEntryType.LevelInfo,        "orcs_10",                                      0, 0, 0 },
    .{ 137, DatabaseEntryType.LevelInfo,        "humans_11",                                    1, 0, 0 },
    .{ 138, DatabaseEntryType.LevelInfo,        "orcs_11",                                      0, 0, 0 },
    .{ 139, DatabaseEntryType.LevelInfo,        "humans_12",                                    1, 0, 0 },
    .{ 140, DatabaseEntryType.LevelInfo,        "orcs_12",                                      0, 0, 0 },

    // Custom
    .{ 141, DatabaseEntryType.Unknown,           "battle_test_map_1",                            1, 0, 0 }, // test map, just several footmans and archers against grunts and spearmans, player control humans
    .{ 142, DatabaseEntryType.Unknown,           "battle_test_map_2",                            1, 0, 0 }, // test map, several footmans and archers attacking an orc camp with few grunts and spearmans, player controls humans
    .{ 143, DatabaseEntryType.Unknown,           "battle_test_map_3",                            1, 0, 0 }, // test map, several footmans and archers attacking an orc camp with few grunts and spearmans, player controls orcs
    .{ 144, DatabaseEntryType.Unknown,           "battle_test_map_4",                            1, 0, 0 }, // test map, several grunts and spearmans attacking a human camp with few footmans and archers, player controls orcs
    .{ 147, DatabaseEntryType.LevelInfo,        "forest_1",                                     0, 1, 0 },
    .{ 148, DatabaseEntryType.LevelInfo,        "forest_2",                                     0, 1, 0 },
    .{ 149, DatabaseEntryType.LevelInfo,        "forest_3",                                     0, 1, 0 },
    .{ 150, DatabaseEntryType.LevelInfo,        "forest_4",                                     0, 1, 0 },
    .{ 151, DatabaseEntryType.LevelInfo,        "forest_5",                                     0, 1, 0 },
    .{ 152, DatabaseEntryType.LevelInfo,        "forest_6",                                     0, 1, 0 },
    .{ 153, DatabaseEntryType.LevelInfo,        "forest_7",                                     0, 1, 0 },
    .{ 154, DatabaseEntryType.LevelInfo,        "swamp_6",                                      1, 1, 0 },
    .{ 155, DatabaseEntryType.LevelInfo,        "swamp_7",                                      1, 1, 0 },
    .{ 156, DatabaseEntryType.LevelInfo,        "swamp_1",                                      1, 1, 0 },
    .{ 157, DatabaseEntryType.LevelInfo,        "swamp_2",                                      1, 1, 0 },
    .{ 158, DatabaseEntryType.LevelInfo,        "swamp_3",                                      1, 1, 0 },
    .{ 159, DatabaseEntryType.LevelInfo,        "swamp_4",                                      1, 1, 0 },
    .{ 160, DatabaseEntryType.LevelInfo,        "swamp_5",                                      1, 1, 0 },
    .{ 161, DatabaseEntryType.LevelInfo,        "dungeon_1",                                    2, 1, 0 },
    .{ 162, DatabaseEntryType.LevelInfo,        "dungeon_2",                                    2, 1, 0 },
    .{ 163, DatabaseEntryType.LevelInfo,        "dungeon_3",                                    2, 1, 0 },
    .{ 164, DatabaseEntryType.LevelInfo,        "dungeon_4",                                    2, 1, 0 },
    .{ 165, DatabaseEntryType.LevelInfo,        "dungeon_5",                                    2, 1, 0 },
    .{ 166, DatabaseEntryType.LevelInfo,        "dungeon_6",                                    2, 1, 0 },
    .{ 167, DatabaseEntryType.LevelInfo,        "dungeon_7",                                    2, 1, 0 },

    .{ 168, DatabaseEntryType.LevelInfo,        "forest_1_big_enemy",                           0, 1, 0 },
    .{ 169, DatabaseEntryType.LevelInfo,        "forest_2_big_enemy",                           0, 1, 0 },
    .{ 170, DatabaseEntryType.LevelInfo,        "forest_3_big_enemy",                           0, 1, 0 },
    .{ 171, DatabaseEntryType.LevelInfo,        "forest_4_big_enemy",                           0, 1, 0 },
    .{ 172, DatabaseEntryType.LevelInfo,        "forest_5_big_enemy",                           0, 1, 0 },
    .{ 173, DatabaseEntryType.LevelInfo,        "forest_6_big_enemy",                           0, 1, 0 },
    .{ 174, DatabaseEntryType.LevelInfo,        "forest_7_big_enemy",                           0, 1, 0 },
    .{ 175, DatabaseEntryType.LevelInfo,        "swamp_6_big_enemy",                            1, 1, 0 },
    .{ 176, DatabaseEntryType.LevelInfo,        "swamp_7_big_enemy",                            1, 1, 0 },
    .{ 177, DatabaseEntryType.LevelInfo,        "swamp_1_big_enemy",                            1, 1, 0 },
    .{ 178, DatabaseEntryType.LevelInfo,        "swamp_2_big_enemy",                            1, 1, 0 },
    .{ 179, DatabaseEntryType.LevelInfo,        "swamp_3_big_enemy",                            1, 1, 0 },
    .{ 180, DatabaseEntryType.LevelInfo,        "swamp_4_big_enemy",                            1, 1, 0 },
    .{ 181, DatabaseEntryType.LevelInfo,        "swamp_5_big_enemy",                            1, 1, 0 },
    .{ 182, DatabaseEntryType.LevelInfo,        "dungeon_1_big_enemy",                          2, 1, 0 },
    .{ 183, DatabaseEntryType.LevelInfo,        "dungeon_2_big_enemy",                          2, 1, 0 },
    .{ 184, DatabaseEntryType.LevelInfo,        "dungeon_3_big_enemy",                          2, 1, 0 },
    .{ 185, DatabaseEntryType.LevelInfo,        "dungeon_4_big_enemy",                          2, 1, 0 },
    .{ 186, DatabaseEntryType.LevelInfo,        "dungeon_5_big_enemy",                          2, 1, 0 },
    .{ 187, DatabaseEntryType.LevelInfo,        "dungeon_6_big_enemy",                          2, 1, 0 },
    .{ 188, DatabaseEntryType.LevelInfo,        "dungeon_7_big_enemy",                          2, 1, 0 },

    // Palettes
    .{ 191, DatabaseEntryType.Palette,           "forest",                                       0, 0, 0 }, // demo
    .{ 194, DatabaseEntryType.Palette,           "swamp",                                        0, 0, 0 }, // demo
    .{ 197, DatabaseEntryType.Palette,           "dungeon",                                      0, 0, 0 },
    .{ 217, DatabaseEntryType.Palette,           "background",                                   0, 0, 0 }, // demo
    .{ 255, DatabaseEntryType.Palette,           "humans",                                       0, 0, 0 }, // demo
    .{ 260, DatabaseEntryType.Palette,           "ui",                                           0, 0, 0 }, // demo
    .{ 262, DatabaseEntryType.Palette,           "pointer",                                      0, 0, 0 }, // demo
    .{ 413, DatabaseEntryType.Palette,           "summary",                                      0, 0, 0 }, // demo
    .{ 416, DatabaseEntryType.Palette,           "for 415",                                      0, 0, 0 }, // demo
    .{ 418, DatabaseEntryType.Palette,           "for 417",                                      0, 0, 0 }, // demo
    .{ 423, DatabaseEntryType.Palette,           "briefing",                                     0, 0, 0 }, // demo
    .{ 424, DatabaseEntryType.Palette,           "briefing",                                     0, 0, 0 }, // demo
    .{ 457, DatabaseEntryType.Palette,           "for 456",                                      0, 0, 0 },
    .{ 459, DatabaseEntryType.Palette,           "for 458",                                      0, 0, 0 },

    // Tiles
    .{ 190, DatabaseEntryType.Tiles,             "forest",                                       191, 217, 0 }, // demo
    .{ 193, DatabaseEntryType.Tiles,             "swamp",                                        194, 217, 0 }, // demo
    .{ 196, DatabaseEntryType.Tiles,             "dungeon",                                      197, 217, 0 },

    // Tilesets
    .{ 189, DatabaseEntryType.Tileset,           "forest",                                       190, 0, 0 }, // demo
    .{ 192, DatabaseEntryType.Tileset,           "swamp",                                        193, 0, 0 }, // demo
    .{ 195, DatabaseEntryType.Tileset,           "dungeon",                                      196, 0, 0 },

    // Cursors
    .{ 263, DatabaseEntryType.Cursor,            "arrow",                                        262, 0, 0 }, // demo
    .{ 264, DatabaseEntryType.Cursor,            "invalid_command",                              262, 0, 0 }, // demo
    .{ 265, DatabaseEntryType.Cursor,            "yellow_crosshair",                             262, 0, 0 }, // demo
    .{ 266, DatabaseEntryType.Cursor,            "red_crosshair",                                262, 0, 0 }, // demo
    .{ 267, DatabaseEntryType.Cursor,            "yellow_crosshair_2",                           262, 0, 0 }, // demo
    .{ 268, DatabaseEntryType.Cursor,            "magnifying_glass",                             262, 0, 0 }, // demo
    .{ 269, DatabaseEntryType.Cursor,            "small_green_crosshair",                        262, 0, 0 }, // demo
    .{ 270, DatabaseEntryType.Cursor,            "watch",                                        262, 0, 0 }, // demo
    .{ 271, DatabaseEntryType.Cursor,            "up_arrow",                                     262, 0, 0 }, // demo
    .{ 272, DatabaseEntryType.Cursor,            "upper_right_arrow",                            262, 0, 0 }, // demo
    .{ 273, DatabaseEntryType.Cursor,            "right_arrow",                                  262, 0, 0 }, // demo
    .{ 274, DatabaseEntryType.Cursor,            "lower_right_arrow",                            262, 0, 0 }, // demo
    .{ 275, DatabaseEntryType.Cursor,            "down_arrow",                                   262, 0, 0 }, // demo
    .{ 276, DatabaseEntryType.Cursor,            "lower_left_arrow",                             262, 0, 0 }, // demo
    .{ 277, DatabaseEntryType.Cursor,            "left_arrow",                                   262, 0, 0 }, // demo
    .{ 278, DatabaseEntryType.Cursor,            "upper_left_arrow",                             262, 0, 0 }, // demo

    // Sprites
    .{ 279, DatabaseEntryType.Sprite,            "footman_humans",                               191, 217, 0 }, // demo
    .{ 280, DatabaseEntryType.Sprite,            "grunt_orcs",                                   191, 217, 0 }, // demo
    .{ 281, DatabaseEntryType.Sprite,            "peasant_humans",                               191, 217, 0 }, // demo
    .{ 282, DatabaseEntryType.Sprite,            "peon_orcs",                                    191, 217, 0 }, // demo
    .{ 283, DatabaseEntryType.Sprite,            "catapult_humans",                              191, 217, 0 },
    .{ 284, DatabaseEntryType.Sprite,            "catapult_orcs",                                191, 217, 0 },
    .{ 285, DatabaseEntryType.Sprite,            "knight_humans",                                191, 217, 0 },
    .{ 286, DatabaseEntryType.Sprite,            "raider_orcs",                                  191, 217, 0 },
    .{ 287, DatabaseEntryType.Sprite,            "archer_humans",                                191, 217, 0 }, // demo
    .{ 288, DatabaseEntryType.Sprite,            "axethrower_orcs",                              191, 217, 0 }, // demo
    .{ 289, DatabaseEntryType.Sprite,            "wizard_humans",                                191, 217, 0 },
    .{ 290, DatabaseEntryType.Sprite,            "wizard_orcs",                                  191, 217, 0 },
    .{ 291, DatabaseEntryType.Sprite,            "priest_humans",                                191, 217, 0 }, // demo
    .{ 292, DatabaseEntryType.Sprite,            "necrolyte_orcs",                               191, 217, 0 }, // demo
    .{ 293, DatabaseEntryType.Sprite,            "medivh",                                       191, 217, 0 },
    .{ 294, DatabaseEntryType.Sprite,            "lothar",                                       191, 217, 0 },
    .{ 295, DatabaseEntryType.Sprite,            "wounded",                                      191, 217, 0 },
    .{ 296, DatabaseEntryType.Sprite,            "garona",                                       191, 217, 0 },
    .{ 297, DatabaseEntryType.Sprite,            "ogre",                                         191, 217, 0 },
    .{ 298, DatabaseEntryType.Sprite,            "spider",                                       191, 217, 0 },
    .{ 299, DatabaseEntryType.Sprite,            "slime",                                        191, 217, 0 },
    .{ 300, DatabaseEntryType.Sprite,            "fire_elemental",                               191, 217, 0 },
    .{ 301, DatabaseEntryType.Sprite,            "scorpion",                                     191, 217, 0 },
    .{ 302, DatabaseEntryType.Sprite,            "brigand",                                      191, 217, 0 },
    .{ 303, DatabaseEntryType.Sprite,            "the_dead",                                     191, 217, 0 }, // demo
    .{ 304, DatabaseEntryType.Sprite,            "skeleton_02",                                  191, 217, 0 },
    .{ 305, DatabaseEntryType.Sprite,            "demon",                                        191, 217, 0 },
    .{ 306, DatabaseEntryType.Sprite,            "water_elemental",                              191, 217, 0 },
    .{ 307, DatabaseEntryType.Sprite,            "farm_humans",                                  191, 217, 0 }, // demo
    .{ 308, DatabaseEntryType.Sprite,            "farm_orcs",                                    191, 217, 0 }, // demo
    .{ 309, DatabaseEntryType.Sprite,            "barracks_humans",                              191, 217, 0 }, // demo
    .{ 310, DatabaseEntryType.Sprite,            "barracks_orcs",                                191, 217, 0 }, // demo
    .{ 311, DatabaseEntryType.Sprite,            "church_humans",                                191, 217, 0 }, // demo
    .{ 312, DatabaseEntryType.Sprite,            "temple_orcs",                                  191, 217, 0 }, // demo
    .{ 313, DatabaseEntryType.Sprite,            "tower_humns",                                  191, 217, 0 },
    .{ 314, DatabaseEntryType.Sprite,            "skull_orcs",                                   191, 217, 0 },
    .{ 315, DatabaseEntryType.Sprite,            "town_hall_humans",                             191, 217, 0 }, // demo
    .{ 316, DatabaseEntryType.Sprite,            "town_hall_orcs",                               191, 217, 0 }, // demo
    .{ 317, DatabaseEntryType.Sprite,            "lumbermill_humans",                            191, 217, 0 }, // demo
    .{ 318, DatabaseEntryType.Sprite,            "lumbermill_orcs",                              191, 217, 0 }, // demo
    .{ 319, DatabaseEntryType.Sprite,            "stable_humans",                                191, 217, 0 },
    .{ 320, DatabaseEntryType.Sprite,            "stable_orcs",                                  191, 217, 0 },
    .{ 321, DatabaseEntryType.Sprite,            "blacksmith_humans",                            191, 217, 0 },
    .{ 322, DatabaseEntryType.Sprite,            "blacksmith_orcs",                              191, 217, 0 },
    .{ 323, DatabaseEntryType.Sprite,            "stormwind_humans",                             191, 217, 0 },
    .{ 324, DatabaseEntryType.Sprite,            "black_spire_orcs",                             191, 217, 0 },
    .{ 325, DatabaseEntryType.Sprite,            "goldmine",                                     191, 217, 0 }, // demo
    .{ 326, DatabaseEntryType.Sprite,            "corpse",                                       191, 217, 0 }, // demo
    .{ 327, DatabaseEntryType.Sprite,            "peasant_with_lumber_humans",                   191, 217, 0 }, // demo
    .{ 328, DatabaseEntryType.Sprite,            "peon_with_lumber_orcs",                        191, 217, 0 }, // demo
    .{ 329, DatabaseEntryType.Sprite,            "peasant_with_gold_humans",                     191, 217, 0 }, // demo
    .{ 330, DatabaseEntryType.Sprite,            "peon_with_gold_orcs",                          191, 217, 0 }, // demo
    .{ 331, DatabaseEntryType.Sprite,            "farm_construction_humans",                     191, 217, 0 }, // demo
    .{ 332, DatabaseEntryType.Sprite,            "farm_construction_orcs",                       191, 217, 0 }, // demo
    .{ 333, DatabaseEntryType.Sprite,            "barracks_construction_humans",                 191, 217, 0 }, // demo
    .{ 334, DatabaseEntryType.Sprite,            "barracks_construction_orcs",                   191, 217, 0 }, // demo
    .{ 335, DatabaseEntryType.Sprite,            "church_construction_humans",                   191, 217, 0 }, // demo
    .{ 336, DatabaseEntryType.Sprite,            "temple_construction_orcs",                     191, 217, 0 }, // demo
    .{ 337, DatabaseEntryType.Sprite,            "tower_construction_humans",                    191, 217, 0 },
    .{ 338, DatabaseEntryType.Sprite,            "tower_construction_orcs",                      191, 217, 0 },
    .{ 339, DatabaseEntryType.Sprite,            "town_hall_construction_humans",                191, 217, 0 }, // demo
    .{ 340, DatabaseEntryType.Sprite,            "town_hall_construction_orcs",                  191, 217, 0 }, // demo
    .{ 341, DatabaseEntryType.Sprite,            "lumber_mill_construction_humans",              191, 217, 0 }, // demo
    .{ 342, DatabaseEntryType.Sprite,            "lumber_mill_construction_orcs",                191, 217, 0 }, // demo
    .{ 343, DatabaseEntryType.Sprite,            "stable_construction_humans",                   191, 217, 0 },
    .{ 344, DatabaseEntryType.Sprite,            "stable_construction_orcs",                     191, 217, 0 },
    .{ 345, DatabaseEntryType.Sprite,            "blacksmith_construction_humans",               191, 217, 0 },
    .{ 346, DatabaseEntryType.Sprite,            "blacksmith_construction_orcs",                 191, 217, 0 },
    .{ 350, DatabaseEntryType.Sprite,            "poison_cloud",                                 191, 217, 0 },
    .{ 352, DatabaseEntryType.Sprite,            "small_fire",                                   191, 217, 0 }, // demo
    .{ 353, DatabaseEntryType.Sprite,            "large_fire",                                   191, 217, 0 }, // demo
    .{ 354, DatabaseEntryType.Sprite,            "explosion",                                    191, 217, 0 },
    .{ 355, DatabaseEntryType.Sprite,            "healing",                                      191, 217, 0 }, // demo
    .{ 356, DatabaseEntryType.Sprite,            "building_collapse",                            191, 217, 0 }, // demo
    .{ 359, DatabaseEntryType.Sprite,            "ui_pictures_orcs",                             191, 217, 0 }, // demo
    .{ 360, DatabaseEntryType.Sprite,            "ui_pictures_humans",                           255,   0, 0 }, // demo
    .{ 361, DatabaseEntryType.Sprite,            "ui_pictures_icons",                            191, 217, 0 }, // demo
    .{ 425, DatabaseEntryType.Sprite,            "burning_fire",                                 424,   0, 0 },
    .{ 426, DatabaseEntryType.Sprite,            "talking_orc_01",                               424,   0, 0 }, // demo
    .{ 427, DatabaseEntryType.Sprite,            "talking_orc_02",                               424,   0, 0 }, // demo
    .{ 428, DatabaseEntryType.Sprite,            "eating_human",                                 423,   0, 0 }, // demo
    .{ 429, DatabaseEntryType.Sprite,            "human_wizard",                                 423,   0, 0 }, // demo
    .{ 430, DatabaseEntryType.Sprite,            "anim_01",                                      423,   0, 0 }, // demo
    .{ 431, DatabaseEntryType.Sprite,            "anim_02",                                      423,   0, 0 }, // demo
    .{ 460, DatabaseEntryType.Sprite,            "anim_03",                                      459,   0, 0 },

    // Projectiles
    .{ 347, DatabaseEntryType.Sprite,            "missiles_fireball",                            191, 217, 0 }, // demo
    .{ 348, DatabaseEntryType.Sprite,            "missiles_catapult_projectile",                 191, 217, 0 },
    .{ 349, DatabaseEntryType.Sprite,            "missiles_arrow",                               191, 217, 0 }, // demo
    .{ 351, DatabaseEntryType.Sprite,            "missiles_rain_of_fire",                        191, 217, 0 },
    .{ 357, DatabaseEntryType.Sprite,            "missiles_water_elemental_projectile",          191, 217, 0 },
    .{ 358, DatabaseEntryType.Sprite,            "missiles_fireball_2",                          191, 217, 0 },

    // Images
    .{ 216, DatabaseEntryType.Image,             "background 'Blizzard'",                        217,   0, 0 }, // demo
    .{ 218, DatabaseEntryType.Image,             "topbar_humans",                                255,   0, 0 }, // demo
    .{ 219, DatabaseEntryType.Image,             "topbar_orcs",                                  191, 217, 0 }, // demo
    .{ 220, DatabaseEntryType.Image,             "sidebar_right_humans",                         255,   0, 0 }, // demo
    .{ 221, DatabaseEntryType.Image,             "sidebar_right_orcs",                           217,   0, 0 }, // demo
    .{ 222, DatabaseEntryType.Image,             "lower_bar_humans",                             255,   0, 0 }, // demo
    .{ 223, DatabaseEntryType.Image,             "lower_bar_orcs",                               217,   0, 0 }, // demo
    .{ 224, DatabaseEntryType.Image,             "sidebar_left_minimap_empty_humans",            255,   0, 0 }, // demo
    .{ 225, DatabaseEntryType.Image,             "sidebar_left_minimap_empty_orcs",              217,   0, 0 }, // demo
    .{ 226, DatabaseEntryType.Image,             "sidebar_left_humans",                          255,   0, 0 }, // demo
    .{ 227, DatabaseEntryType.Image,             "sidebar_left_orcs",                            217,   0, 0 }, // demo
    .{ 228, DatabaseEntryType.Image,             "sidebar_left_minimap_black_humans",            255,   0, 0 }, // demo
    .{ 229, DatabaseEntryType.Image,             "sidebar_left_minimap_black_orcs",              217,   0, 0 }, // demo
    .{ 233, DatabaseEntryType.Image,             "large_box_humans",                             255,   0, 0 }, // demo
    .{ 234, DatabaseEntryType.Image,             "large_box_orcs",                               217,   0, 0 }, // demo
    .{ 235, DatabaseEntryType.Image,             "small_box_humans",                             255,   0, 0 }, // demo
    .{ 236, DatabaseEntryType.Image,             "smal_box_orcs",                                217,   0, 0 }, // demo
    .{ 237, DatabaseEntryType.Image,             "large_button",                                 260,   0, 0 }, // demo
    .{ 238, DatabaseEntryType.Image,             "large_button_pressed",                         260,   0, 0 }, // demo
    .{ 239, DatabaseEntryType.Image,             "medium_button",                                260,   0, 0 }, // demo
    .{ 240, DatabaseEntryType.Image,             "medium_button_pressed",                        260,   0, 0 }, // demo
    .{ 241, DatabaseEntryType.Image,             "small_button",                                 260,   0, 0 }, // demo
    .{ 242, DatabaseEntryType.Image,             "small_button_pressed",                         260,   0, 0 }, // demo
    .{ 243, DatabaseEntryType.Image,             "menu_background_lower",                        260,   0, 0 }, // demo
    .{ 244, DatabaseEntryType.Image,             "arrow_left_button",                            255,   0, 0 }, // demo
    .{ 245, DatabaseEntryType.Image,             "arrow_left_button_grey",                       255,   0, 0 }, // demo
    .{ 246, DatabaseEntryType.Image,             "arrow_right_button",                           255,   0, 0 }, // demo
    .{ 247, DatabaseEntryType.Image,             "arrow_right_button_grey",                      255,   0, 0 }, // demo
    .{ 248, DatabaseEntryType.Image,             "window_border",                                255,   0, 0 }, // demo
    .{ 249, DatabaseEntryType.Image,             "saving_loading_humans",                        255,   0, 0 }, // demo
    .{ 250, DatabaseEntryType.Image,             "saving_loading_orcs",                          217,   0, 0 }, // demo
    .{ 254, DatabaseEntryType.Image,             "hot_keys",                                     255,   0, 0 }, // demo
    .{ 256, DatabaseEntryType.Image,             "ok1_button",                                   255,   0, 0 }, // demo
    .{ 257, DatabaseEntryType.Image,             "ok2_button",                                   255,   0, 0 }, // demo
    .{ 258, DatabaseEntryType.Image,             "warcraft_text",                                260,   0, 0 }, // demo
    .{ 261, DatabaseEntryType.Image,             "menu_background",                              260,   0, 0 }, // demo
    .{ 362, DatabaseEntryType.Image,             "menu_button",                                  217,   0, 0 }, // demo
    .{ 363, DatabaseEntryType.Image,             "menu_button_pressed",                          217,   0, 0 }, // demo
    .{ 364, DatabaseEntryType.Image,             "empty_button",                                 255,   0, 0 }, // demo
    .{ 365, DatabaseEntryType.Image,             "empty_button_pressed",                         217,   0, 0 }, // demo
    .{ 406, DatabaseEntryType.Image,             "gold_1",                                       191, 217, 0 }, // demo
    .{ 407, DatabaseEntryType.Image,             "lumber_1",                                     217,   0, 0 }, // demo
    .{ 408, DatabaseEntryType.Image,             "gold_2",                                       191, 217, 0 }, // demo
    .{ 409, DatabaseEntryType.Image,             "lumber_2",                                     217,   0, 0 }, // demo
    .{ 410, DatabaseEntryType.Image,             "percent_complete",                             191, 217, 0 }, // demo
    .{ 411, DatabaseEntryType.Image,             "points_summary_humans",                        413,   0, 0 }, // demo
    .{ 412, DatabaseEntryType.Image,             "points_summary_orcs",                          413,   0, 0 }, // demo
    .{ 415, DatabaseEntryType.Image,             "victory_background",                           416,   0, 0 }, // demo
    .{ 417, DatabaseEntryType.Image,             "defeat_background",                            418,   0, 0 }, // demo
    .{ 419, DatabaseEntryType.Image,             "victory_text",                                 423,   0, 0 }, // demo
    .{ 420, DatabaseEntryType.Image,             "defeat_text",                                  423,   0, 0 }, // demo
    .{ 421, DatabaseEntryType.Image,             "briefing_humans",                              423,   0, 0 }, // demo
    .{ 422, DatabaseEntryType.Image,             "briefing_orcs",                                424,   0, 0 }, // demo
    .{ 456, DatabaseEntryType.Image,             "win_humans",                                   457,   0, 0 },
    .{ 458, DatabaseEntryType.Image,             "win_orcs",                                     459,   0, 0 },
    .{ 470, DatabaseEntryType.Image,             "win_anim_humans",                              457,   0, 0 },
    .{ 471, DatabaseEntryType.Image,             "win_anim_orcs",                                260,   0, 0 },

    // Text
    .{ 432, DatabaseEntryType.Text,              "01_intro_orcs",                                0, 0, 0 }, // demo
    .{ 433, DatabaseEntryType.Text,              "02_intro_orcs",                                0, 0, 0 }, // demo
    .{ 434, DatabaseEntryType.Text,              "03_intro_orcs",                                0, 0, 0 }, // demo
    .{ 435, DatabaseEntryType.Text,              "04_intro_orcs",                                0, 0, 0 }, // demo
    .{ 436, DatabaseEntryType.Text,              "05_intro_orcs",                                0, 0, 0 },
    .{ 437, DatabaseEntryType.Text,              "06_intro_orcs",                                0, 0, 0 },
    .{ 438, DatabaseEntryType.Text,              "07_intro_orcs",                                0, 0, 0 },
    .{ 439, DatabaseEntryType.Text,              "08_intro_orcs",                                0, 0, 0 },
    .{ 440, DatabaseEntryType.Text,              "09_intro_orcs",                                0, 0, 0 },
    .{ 441, DatabaseEntryType.Text,              "10_intro_orcs",                                0, 0, 0 },
    .{ 442, DatabaseEntryType.Text,              "11_intro_orcs",                                0, 0, 0 },
    .{ 443, DatabaseEntryType.Text,              "12_intro_orcs",                                0, 0, 0 },
    .{ 444, DatabaseEntryType.Text,              "01_intro_humans",                              0, 0, 0 }, // demo
    .{ 445, DatabaseEntryType.Text,              "02_intro_humans",                              0, 0, 0 }, // demo
    .{ 446, DatabaseEntryType.Text,              "03_intro_humans",                              0, 0, 0 }, // demo
    .{ 447, DatabaseEntryType.Text,              "04_intro_humans",                              0, 0, 0 }, // demo
    .{ 448, DatabaseEntryType.Text,              "05_intro_humans",                              0, 0, 0 },
    .{ 449, DatabaseEntryType.Text,              "06_intro_humans",                              0, 0, 0 },
    .{ 450, DatabaseEntryType.Text,              "07_intro_humans",                              0, 0, 0 },
    .{ 451, DatabaseEntryType.Text,              "08_intro_humans",                              0, 0, 0 },
    .{ 452, DatabaseEntryType.Text,              "09_intro_humans",                              0, 0, 0 },
    .{ 453, DatabaseEntryType.Text,              "10_intro_humans",                              0, 0, 0 },
    .{ 454, DatabaseEntryType.Text,              "11_intro_humans",                              0, 0, 0 },
    .{ 455, DatabaseEntryType.Text,              "12_intro_humans",                              0, 0, 0 },
    .{ 461, DatabaseEntryType.Text,              "ending_1_humans",                              0, 0, 0 },
    .{ 462, DatabaseEntryType.Text,              "ending_1_orcs",                                0, 0, 0 },
    .{ 463, DatabaseEntryType.Text,              "ending_2_humans",                              0, 0, 0 },
    .{ 464, DatabaseEntryType.Text,              "ending_2_orcs",                                0, 0, 0 },
    .{ 465, DatabaseEntryType.Text,              "credits",                                      0, 0, 0 },
    .{ 466, DatabaseEntryType.Text,              "victory_dialog_1",                             0, 0, 0 }, // demo
    .{ 467, DatabaseEntryType.Text,              "victory_dialog_2",                             0, 0, 0 }, // demo
    .{ 468, DatabaseEntryType.Text,              "defeat_dialog_1",                              0, 0, 0 }, // demo
    .{ 469, DatabaseEntryType.Text,              "defeat_dialog_2",                              0, 0, 0 }, // demo

    // Sounds
    .{ 472, DatabaseEntryType.Wave,              "logo",                                         0, 0, 0 }, // demo
    .{ 473, DatabaseEntryType.Wave,              "intro_door",                                   0, 0, 0 },
    .{ 474, DatabaseEntryType.Voc,               "misc_building",                                0, 0, 0 }, // demo
    .{ 475, DatabaseEntryType.Voc,               "misc_explosion",                               0, 0, 0 }, // demo
    .{ 476, DatabaseEntryType.Voc,               "missiles_catapult_rock_fired",                 0, 0, 0 },
    .{ 477, DatabaseEntryType.Voc,               "misc_tree_chopping_1",                         0, 0, 0 }, // demo
    .{ 478, DatabaseEntryType.Voc,               "misc_tree_chopping_2",                         0, 0, 0 }, // demo
    .{ 479, DatabaseEntryType.Voc,               "misc_tree_chopping_3",                         0, 0, 0 }, // demo
    .{ 480, DatabaseEntryType.Voc,               "misc_tree_chopping_4",                         0, 0, 0 }, // demo
    .{ 481, DatabaseEntryType.Voc,               "misc_building_collapse_1",                     0, 0, 0 },
    .{ 482, DatabaseEntryType.Voc,               "misc_building_collapse_2",                     0, 0, 0 },
    .{ 483, DatabaseEntryType.Voc,               "misc_building_collapse_3",                     0, 0, 0 },
    .{ 484, DatabaseEntryType.Voc,               "ui_chime",                                     0, 0, 0 }, // demo
    .{ 485, DatabaseEntryType.Wave,              "ui_click",                                     0, 0, 0 }, // demo
    .{ 486, DatabaseEntryType.Voc,               "ui_cancel",                                    0, 0, 0 }, // demo
    .{ 487, DatabaseEntryType.Voc,               "missiles_sword_attack_1",                      0, 0, 0 }, // demo
    .{ 488, DatabaseEntryType.Voc,               "missiles_sword_attack_2",                      0, 0, 0 }, // demo
    .{ 489, DatabaseEntryType.Voc,               "missiles_sword_attack_3",                      0, 0, 0 }, // demo
    .{ 490, DatabaseEntryType.Voc,               "missiles_fist_attack",                         0, 0, 0 },
    .{ 491, DatabaseEntryType.Voc,               "missiles_catapult_fire_explosion",             0, 0, 0 }, // demo
    .{ 492, DatabaseEntryType.Voc,               "missiles_fireball",                            0, 0, 0 }, // demo
    .{ 493, DatabaseEntryType.Voc,               "missiles_arrow_spear",                         0, 0, 0 }, // demo
    .{ 494, DatabaseEntryType.Voc,               "missiles_arrow_spear_hit",                     0, 0, 0 }, // demo
    .{ 495, DatabaseEntryType.Voc,               "orc_help_1",                                   0, 0, 0 }, // demo
    .{ 496, DatabaseEntryType.Voc,               "orc_help_2",                                   0, 0, 0 },
    .{ 497, DatabaseEntryType.Wave,              "human_help_2",                                 0, 0, 0 }, // demo
    .{ 498, DatabaseEntryType.Wave,              "human_help_1",                                 0, 0, 0 },
    .{ 499, DatabaseEntryType.Voc,               "orc_dead",                                     0, 0, 0 }, // demo
    .{ 500, DatabaseEntryType.Voc,               "human_dead",                                   0, 0, 0 }, // demo
    .{ 501, DatabaseEntryType.Voc,               "orc_work_complete",                            0, 0, 0 }, // demo
    .{ 502, DatabaseEntryType.Wave,              "human_work_complete",                          0, 0, 0 }, // demo
    .{ 503, DatabaseEntryType.Voc,               "orc_help_3",                                   0, 0, 0 }, // demo
    .{ 504, DatabaseEntryType.Wave,              "orc_help_4",                                   0, 0, 0 },
    .{ 505, DatabaseEntryType.Wave,              "human_help_3",                                 0, 0, 0 }, // demo
    .{ 506, DatabaseEntryType.Wave,              "human_help_4",                                 0, 0, 0 }, // demo
    .{ 507, DatabaseEntryType.Voc,               "orc_ready",                                    0, 0, 0 }, // demo
    .{ 508, DatabaseEntryType.Wave,              "human_ready",                                  0, 0, 0 }, // demo
    .{ 509, DatabaseEntryType.Voc,               "orc_acknowledgement_1",                        0, 0, 0 }, // demo
    .{ 510, DatabaseEntryType.Voc,               "orc_acknowledgement_2",                        0, 0, 0 }, // demo
    .{ 511, DatabaseEntryType.Voc,               "orc_acknowledgement_3",                        0, 0, 0 }, // demo
    .{ 512, DatabaseEntryType.Voc,               "orc_acknowledgement_4",                        0, 0, 0 }, // demo
    .{ 513, DatabaseEntryType.Wave,              "human_acknowledgement_1",                      0, 0, 0 }, // demo
    .{ 514, DatabaseEntryType.Wave,              "human_acknowledgement_2",                      0, 0, 0 }, // demo
    .{ 515, DatabaseEntryType.Voc,               "orc_selected_1",                               0, 0, 0 }, // demo
    .{ 516, DatabaseEntryType.Voc,               "orc_selected_2",                               0, 0, 0 }, // demo
    .{ 517, DatabaseEntryType.Voc,               "orc_selected_3",                               0, 0, 0 }, // demo
    .{ 518, DatabaseEntryType.Voc,               "orc_selected_4",                               0, 0, 0 }, // demo
    .{ 519, DatabaseEntryType.Voc,               "orc_selected_5",                               0, 0, 0 }, // demo
    .{ 520, DatabaseEntryType.Wave,              "human_selected_1",                             0, 0, 0 }, // demo
    .{ 521, DatabaseEntryType.Wave,              "human_selected_2",                             0, 0, 0 }, // demo
    .{ 522, DatabaseEntryType.Wave,              "human_selected_3",                             0, 0, 0 }, // demo
    .{ 523, DatabaseEntryType.Wave,              "human_selected_4",                             0, 0, 0 }, // demo
    .{ 524, DatabaseEntryType.Wave,              "human_selected_5",                             0, 0, 0 }, // demo
    .{ 525, DatabaseEntryType.Voc,               "orc_annoyed_1",                                0, 0, 0 }, // demo
    .{ 526, DatabaseEntryType.Voc,               "orc_annoyed_2",                                0, 0, 0 }, // demo
    .{ 527, DatabaseEntryType.Wave,              "orc_annoyed_3",                                0, 0, 0 },
    .{ 528, DatabaseEntryType.Wave,              "human_annoyed_1",                              0, 0, 0 }, // demo
    .{ 529, DatabaseEntryType.Wave,              "human_annoyed_2",                              0, 0, 0 }, // demo
    .{ 530, DatabaseEntryType.Wave,              "human_annoyed_3",                              0, 0, 0 },
    .{ 531, DatabaseEntryType.Wave,              "dead_spider_scorpion",                         0, 0, 0 },
    .{ 532, DatabaseEntryType.Wave,              "normal_spell",                                 0, 0, 0 }, // demo
    .{ 533, DatabaseEntryType.Wave,              "misc_build_road",                              0, 0, 0 }, // demo
    .{ 534, DatabaseEntryType.Wave,              "orc_temple",                                   0, 0, 0 },
    .{ 535, DatabaseEntryType.Wave,              "human_church",                                 0, 0, 0 },
    .{ 536, DatabaseEntryType.Wave,              "orc_kennel",                                   0, 0, 0 },
    .{ 537, DatabaseEntryType.Wave,              "human_stable",                                 0, 0, 0 },
    .{ 538, DatabaseEntryType.Wave,              "blacksmith",                                   0, 0, 0 },
    .{ 539, DatabaseEntryType.Wave,              "misc_fire_crackling",                          0, 0, 0 },
    .{ 540, DatabaseEntryType.Wave,              "cannon",                                       0, 0, 0 },
    .{ 541, DatabaseEntryType.Wave,              "cannon2",                                      0, 0, 0 },
    .{ 542, DatabaseEntryType.Wave,              "campaigns_human_ending_1",                     0, 0, 0 },
    .{ 543, DatabaseEntryType.Wave,              "campaigns_human_ending_2",                     0, 0, 0 },
    .{ 544, DatabaseEntryType.Wave,              "campaigns_orc_ending_1",                       0, 0, 0 },
    .{ 545, DatabaseEntryType.Wave,              "campaigns_orc_ending_2",                       0, 0, 0 },
    .{ 546, DatabaseEntryType.Wave,              "intro_1",                                      0, 0, 0 },
    .{ 547, DatabaseEntryType.Wave,              "intro_2",                                      0, 0, 0 },
    .{ 548, DatabaseEntryType.Wave,              "intro_3",                                      0, 0, 0 },
    .{ 549, DatabaseEntryType.Wave,              "intro_4",                                      0, 0, 0 },
    .{ 550, DatabaseEntryType.Wave,              "intro_5",                                      0, 0, 0 },
    .{ 551, DatabaseEntryType.Wave,              "campaigns_human_01_intro",                     0, 0, 0 },
    .{ 552, DatabaseEntryType.Wave,              "campaigns_human_02_intro",                     0, 0, 0 },
    .{ 553, DatabaseEntryType.Wave,              "campaigns_human_03_intro",                     0, 0, 0 },
    .{ 554, DatabaseEntryType.Wave,              "campaigns_human_04_intro",                     0, 0, 0 },
    .{ 555, DatabaseEntryType.Wave,              "campaigns_human_05_intro",                     0, 0, 0 },
    .{ 556, DatabaseEntryType.Wave,              "campaigns_human_06_intro",                     0, 0, 0 },
    .{ 557, DatabaseEntryType.Wave,              "campaigns_human_07_intro",                     0, 0, 0 },
    .{ 558, DatabaseEntryType.Wave,              "campaigns_human_08_intro",                     0, 0, 0 },
    .{ 559, DatabaseEntryType.Wave,              "campaigns_human_09_intro",                     0, 0, 0 },
    .{ 560, DatabaseEntryType.Wave,              "campaigns_human_10_intro",                     0, 0, 0 },
    .{ 561, DatabaseEntryType.Wave,              "campaigns_human_11_intro",                     0, 0, 0 },
    .{ 562, DatabaseEntryType.Wave,              "campaigns_human_12_intro",                     0, 0, 0 },
    .{ 563, DatabaseEntryType.Wave,              "campaigns_orc_01_intro",                       0, 0, 0 },
    .{ 564, DatabaseEntryType.Wave,              "campaigns_orc_02_intro",                       0, 0, 0 },
    .{ 565, DatabaseEntryType.Wave,              "campaigns_orc_03_intro",                       0, 0, 0 },
    .{ 566, DatabaseEntryType.Wave,              "campaigns_orc_04_intro",                       0, 0, 0 },
    .{ 567, DatabaseEntryType.Wave,              "campaigns_orc_05_intro",                       0, 0, 0 },
    .{ 568, DatabaseEntryType.Wave,              "campaigns_orc_06_intro",                       0, 0, 0 },
    .{ 569, DatabaseEntryType.Wave,              "campaigns_orc_07_intro",                       0, 0, 0 },
    .{ 570, DatabaseEntryType.Wave,              "campaigns_orc_08_intro",                       0, 0, 0 },
    .{ 571, DatabaseEntryType.Wave,              "campaigns_orc_09_intro",                       0, 0, 0 },
    .{ 572, DatabaseEntryType.Wave,              "campaigns_orc_10_intro",                       0, 0, 0 },
    .{ 573, DatabaseEntryType.Wave,              "campaigns_orc_11_intro",                       0, 0, 0 },
    .{ 574, DatabaseEntryType.Wave,              "campaigns_orc_12_intro",                       0, 0, 0 },
    .{ 575, DatabaseEntryType.Wave,              "human_defeat",                                 0, 0, 0 },
    .{ 576, DatabaseEntryType.Wave,              "orc_defeat",                                   0, 0, 0 },
    .{ 577, DatabaseEntryType.Wave,              "orc_victory_1",                                0, 0, 0 },
    .{ 578, DatabaseEntryType.Wave,              "orc_victory_2",                                0, 0, 0 },
    .{ 579, DatabaseEntryType.Wave,              "orc_victory_3",                                0, 0, 0 },
    .{ 580, DatabaseEntryType.Wave,              "human_victory_1",                              0, 0, 0 },
    .{ 581, DatabaseEntryType.Wave,              "human_victory_2",                              0, 0, 0 },
    .{ 582, DatabaseEntryType.Wave,              "human_victory_3",                              0, 0, 0 },

    // NOTE: these are resources included in the demo version
    // not sure what are they, a little investigation is required
    //

    .{ 198, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 199, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 200, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 201, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 202, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 203, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 204, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 205, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 206, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 207, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 208, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 209, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 210, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 211, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 212, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 213, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 214, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 215, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 230, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 251, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 252, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 253, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 259, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 366, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 367, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 368, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 369, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 370, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 371, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 372, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 373, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 374, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 375, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 376, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 377, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 378, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 379, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 380, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 381, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 382, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 383, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 384, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 385, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 386, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 387, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 388, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 389, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 390, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 391, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 392, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 393, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 394, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 395, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 396, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 397, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 398, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 399, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 400, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 401, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 402, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 403, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 404, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 405, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
    .{ 414, DatabaseEntryType.Unknown,           "",                                             0, 0, 0 },
];
