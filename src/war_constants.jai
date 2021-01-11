MAX_RESOURCES_COUNT                 : s32 : 583;
MAX_TEXTURES_COUNT                  : s32 : 583;
MAX_ENTITIES_COUNT                  : s32 : 200;
MAX_SPRITE_FRAME_COUNT              : s32 : 100;
MAX_CONSTRUCTS_COUNT                : s32 : 200;
MAX_CUSTOM_MAP_GOLDMINES_COUNT      : s32 : 10;
MAX_CUSTOM_MAP_CONFIGURATIONS_COUNT : s32 : 10;
MAX_CUSTOM_MAP_ENTITIES_COUNT       : s32 : 200;
MAX_UNIT_SELECTION_COUNT            : s32 : 4;
MAX_SQUAD_COUNT                     : s32 : 10;

// all palettes have 768 colors
PALETTE_LENGTH                      : s32 : 768;

// size of mini-tiles from the tiles resources
MINI_TILE_WIDTH                     : s32 : 8;
MINI_TILE_HEIGHT                    : s32 : 8;

// size of the mega-tiles (2x2 mini-tiles) from the tileset
MEGA_TILE_WIDTH                     : s32 : MINI_TILE_WIDTH * 2;
MEGA_TILE_HEIGHT                    : s32 : MINI_TILE_HEIGHT * 2;

// size of the map in pixels
MAP_WIDTH                           : s32 : MEGA_TILE_WIDTH * 64;
MAP_HEIGHT                          : s32 : MEGA_TILE_HEIGHT * 64;

// size of the map in tiles
MAP_TILES_WIDTH                     : s32 : MAP_WIDTH / MEGA_TILE_WIDTH;
MAP_TILES_HEIGHT                    : s32 : MAP_HEIGHT / MEGA_TILE_HEIGHT;

// size of the viewport of the map in pixels
MAP_VIEWPORT_WIDTH                  : s32 : 240;
MAP_VIEWPORT_HEIGHT                 : s32 : 176;

// size of the minimap in pixels
MINIMAP_WIDTH                       : s32 : 64;
MINIMAP_HEIGHT                      : s32 : 64;

// ratio of the minimap and map sizes
MINIMAP_MAP_WIDTH_RATIO             : f32 : cast(f32) MINIMAP_WIDTH / cast(f32) MAP_WIDTH;
MINIMAP_MAP_HEIGHT_RATIO            : f32 : cast(f32) MINIMAP_HEIGHT / cast(f32) MAP_HEIGHT;

// size of the viewport of the minimap in pixels
MINIMAP_VIEWPORT_WIDTH              : s32 : cast(s32) (MAP_VIEWPORT_WIDTH * MINIMAP_MAP_WIDTH_RATIO);
MINIMAP_VIEWPORT_HEIGHT             : s32 : cast(s32) (MAP_VIEWPORT_HEIGHT * MINIMAP_MAP_HEIGHT_RATIO);

// size of the tileset for the terrain of the maps
TILESET_WIDTH                       : s32 : 512;
TILESET_HEIGHT                      : s32 : 256;
TILESET_TILES_PER_ROW               : s32 : TILESET_WIDTH / MEGA_TILE_WIDTH;

MAX_OBJECTIVES_LENGTH               : s32 : 512;
MAX_PLAYERS_COUNT                   : s32 : 5;
MAX_FEATURES_COUNT                  : s32 : 22;
MAX_UPGRADES_COUNT                  : s32 : 10;
MAX_TILES_COUNT                     : s32 : 1024;

FRAMES_PER_SECONDS :: 60;
SECONDS_PER_FRAME :: (1.0/FRAMES_PER_SECONDS);

MOVE_EPSILON :: 0.5;
MOVE_WAIT_INTENTS :: 2;
MOVE_WAIT_TIME :: 1.0;

MAP_EDGE_SCROLL_GAP :: 5.0;

TREE_MAX_WOOD :: 100;
GOLDMINE_MAX_GOLD :: 300;
UNIT_MAX_CARRY_WOOD :: 100;
UNIT_MAX_CARRY_GOLD :: 100;

NEAR_ENEMY_RADIUS :: 5;
NEAR_CATAPULT_RADIUS :: 2;
NEAR_RAIN_OF_FIRE_RADIUS :: 1;

RAIN_OF_FIRE_PROJECTILE_DAMAGE :: 10;
POISON_CLOUD_DAMAGE :: 10;

PLAYBACK_FREQ :: 44100;

FOG_OF_WAR_UPDATE_TIME :: 1.0;

DATAWAR_FILE_PATH :: "./DATA.WAR";
ONLINE_DEMO_DATAWAR_FILE_URL :: "http://ia801608.us.archive.org/view_archive.php?archive=/11/items/WarcraftOrcsHumansDemo/WCRFT.ZIP&file=DEMODATA%2FDATA.WAR";
