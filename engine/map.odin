package engine;



Map :: struct {
    cells: [][][]Cell,
    origin: Vec3D,
    size: [2]Vec3D,
}


BuildMap :: proc(size: Vec3D, origin: Vec3D) -> (m: Map) {
    m.cells = make([][][]Cell, u32(size.x));
    for i :u32; i < u32(size.x); i += 1 {
        m.cells[i] = make([][]Cell, u32(size.y));
        for j: u32; j < u32(size.y); j += 1 {
            m.cells[i][j] = make([]Cell, u32(size.z));
        }
    } 
    m.origin = origin;
    m.size = {{0, 0, 0}, size} 
    return m;
}

  
AddObject :: proc (m: ^Map, cnt: CellContent) {
    o: ^CellAttributes = GetCellAttributes(cnt);
    adjustedPos: Vec3D = o.Pos + m.origin;

    o.RelativeID = GetAvailableID(m.cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)])
    append(&m.cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)].Objects, cnt);
} 