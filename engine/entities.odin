package engine;

import "core:fmt"
import rl"vendor:raylib"
import  "rogue:utils" 

Vec3D :: utils.Vec3D;

Entity :: struct {
    using header: CellAttributes,

}

EMove::proc(m: ^Map, e: ^Entity, v: Vec3D) {
    o: ^CellAttributes = GetCellAttributes(e);

    adjustedPos: Vec3D = m.origin + o.Pos;
    if(o.RelativeID >= 0) {
        c := &m.cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)]; 
        for i: int = 0; i < len(c.Objects); i += 1 {
            checkObj: ^CellAttributes = GetCellAttributes(c.Objects[i])
            if(checkObj.RelativeID == o.RelativeID) {
                unordered_remove(&c.Objects, i);
                o.RelativeID = -1;
            }
        }
        
    }
   
    o.Pos += v;
    adjustedPos += v;
    inboud_map: bool =  m.size[0].x <= adjustedPos.x && adjustedPos.x < m.size[1].x && 
                        m.size[0].y <= adjustedPos.y && adjustedPos.y < m.size[1].y && 
                        m.size[0].z <= adjustedPos.z && adjustedPos.z < m.size[1].z;
          
    if !inboud_map {
        o.RelativeID = -1;
        return;
    }

    nc := &m.cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)];
    
    o.RelativeID = GetAvailableID(nc^);
    
    append(&nc.Objects, e);
}