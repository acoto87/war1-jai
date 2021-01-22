// this value is the distance squared to avoid dynamic units
// so if the dynamic entity at a distance squared less than this value,
// treat it like a static one, so the unit can get around it and the risk of
// overlapping units is less
DISTANCE_SQR_AVOID_DYNAMIC_POSITIONS : f32 : 2.0;

dirC: s32 : 8;
dirX: [] s32 : s32.[ 0,  1, 1, 1, 0, -1, -1, -1];
dirY: [] s32 : s32.[-1, -1, 0, 1, 1,  1,  0, -1];

WarMapPath :: struct {
    nodes: List(Vec2);
}

WarPathFindingType :: enum {
    Bfs;
    Astar;
}

WarPathFinderDataType :: enum u16 {
    Empty   :: 0;
    Static  :: 1;
    Dynamic :: 2;
}

WarPathFinder :: struct {
    type: WarPathFindingType;
    width, height: s32;
    data: *u16;
}

getTileValue :: (finder: WarPathFinder, x: s32, y: s32) -> u16 {
    assert(x >= 0 && x < finder.width);
    assert(y >= 0 && y < finder.height);
    return finder.data[y * finder.width + x];
}

setTilesValue :: (finder: WarPathFinder, startX: s32, startY: s32, width: s32, height: s32, value: u16) {
    if (startX < 0 || startX >= finder.width) return;
    if (startY < 0 || startY >= finder.height) return;

    if (startX + width >= finder.width) {
        width = finder.width - startX;
    }

    if (startY + height >= finder.height) {
        height = finder.height - startY;
    }

    endX := startX + width;
    endY := startY + height;

    for y : range(s32, startY, endY) {
        for x : range(s32, startX, endX) {
            finder.data[y * finder.width + x] = value;
        }
    }
}

setFreeTiles :: inline (finder: WarPathFinder, startX: s32, startY: s32, width: s32, height: s32) {
    setTilesValue(finder, startX, startY, width, height, cast(u16) WarPathFinderDataType.Empty);
}

setStaticEntity :: inline (finder: WarPathFinder, startX: s32, startY: s32, width: s32, height: s32, id: WarEntityId) {
    setTilesValue(finder, startX, startY, width, height, (id << 4) | cast(u16) WarPathFinderDataType.Static);
}

setDynamicEntity :: inline (finder: WarPathFinder, startX: s32, startY: s32, width: s32, height: s32, id: WarEntityId) {
    setTilesValue(finder, startX, startY, width, height, (id << 4) | cast(u16) WarPathFinderDataType.Dynamic);
}

getTileValueType :: inline (finder: WarPathFinder, x: s32, y: s32) -> u16 {
    return getTileValue(finder, x, y) & 0x000F;
}

getTileEntityId :: inline (finder: WarPathFinder, x: s32, y: s32) -> WarEntityId {
    return (getTileValue(finder, x, y) & 0xFFF0) >> 4;
}

isEmpty :: inline (finder: WarPathFinder, x: s32, y: s32) -> bool {
    return getTileValueType(finder, x, y) == cast(u16) WarPathFinderDataType.Empty;
}

isStatic :: inline (finder: WarPathFinder, x: s32, y: s32) -> bool {
    return getTileValueType(finder, x, y) == cast(u16) WarPathFinderDataType.Static;
}

isDynamic :: inline (finder: WarPathFinder, x: s32, y: s32) -> bool {
    return getTileValueType(finder, x, y) == cast(u16) WarPathFinderDataType.Dynamic;
}

isDynamicOfEntity :: inline (finder: WarPathFinder, x: s32, y: s32, id: WarEntityId) -> bool {
    return getTileEntityId(finder, x, y) == id;
}

#scope_file

WarMapNode :: struct {
    id: s32;     // id of the node
    x, y: s32;   // the coordinates of the node
    level: s32;  // the length of the path from the start to this node
    parent: s32; // the previous node in the path from start to end passing through this node
    gScore: s32; // the cost from the start to this node
    fScore: s32; // the cost from start to end passing through this node
}