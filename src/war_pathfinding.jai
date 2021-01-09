WarMapPath :: struct {
    nodes: List(Vec2);
}

WarPathFindingType :: enum {
    Bfs;
    Astar;
}

WarPathFinderDataType :: enum {
    Empty   :: 0;
    Static  :: 1;
    Dynamic :: 2;
}

WarPathFinder :: struct {
    type: WarPathFindingType;
    width, height: s32;
    data: *u16;
}