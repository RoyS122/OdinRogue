package engine

import rl "vendor:raylib"

CellAttributes :: struct {
    RelativeID: i8,
    Pos: Vec3D,
    Shape: Vec3D,
    Colors: [2]rl.Color,
}


CellContent :: union {
    ^Entity,
    ^Material,
}



Cell :: struct {
    Objects: [dynamic]CellContent,
}   


GetCellAttributes :: proc (c: CellContent) -> ^CellAttributes {
    switch v in c {
        case ^Entity:   return &v.header
        case ^Material: return &v.header
    }
    return nil
}

GetAvailableID :: proc (c: Cell) -> (id: i8) {
    id_unavailable: [max(i8)]bool; 

    for i: int = 0; i < len(c.Objects); i += 1 {
        checkObj: ^CellAttributes = GetCellAttributes(c.Objects[i]);
        id_unavailable[checkObj.RelativeID] = true;
    } 

    nid: i8;
    for nid = 0; nid < len(id_unavailable) - 1 ; nid += 1 { if !id_unavailable[nid] {id = nid; break;} id = -1;}
    return id
}