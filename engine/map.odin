package engine;



Map :: struct {
    Cells: [][][]Cell,
    Origin: Vec3D,
    Size: [2]Vec3D,
    CellShape: Vec3D,
}


BuildMap :: proc(size: Vec3D, origin: Vec3D) -> (m: Map) {
    m.Cells = make([][][]Cell, u32(size.x));
    for i :u32; i < u32(size.x); i += 1 {
        m.Cells[i] = make([][]Cell, u32(size.y));
        for j: u32; j < u32(size.y); j += 1 {
            m.Cells[i][j] = make([]Cell, u32(size.z));
        }
    } 
    m.Origin = origin;
    m.Size = {{0, 0, 0}, size} 
    m.CellShape = {1, 1, 1};
    return m;
}

  
AddObject :: proc (m: ^Map, cnt: CellContent) {
    o: ^CellAttributes = GetCellAttributes(cnt);
    adjustedPos: Vec3D = o.Pos + m.Origin;

    o.RelativeID = GetAvailableID(m.Cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)])
    append(&m.Cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)].Objects, cnt);
} 