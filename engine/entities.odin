package engine;

import "core:fmt"
import rl"vendor:raylib"
import  "rogue:utils" 

Vec3D :: utils.Vec3D;

ClimbCapacities :: struct {
    StepHeight: f32,
    ClimbMax: f32,
}

Entity :: struct {
    using header: CellAttributes,
    Climb: ClimbCapacities,
}

EMove::proc(m: ^Map, e: ^Entity, v: Vec3D) {
    o: ^CellAttributes = GetCellAttributes(e);

    adjustedPos: Vec3D = m.Origin + o.Pos;
    if(o.RelativeID >= 0) {
        c := &m.Cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)]; 
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
    inboud_map: bool =  m.Size[0].x <= adjustedPos.x && adjustedPos.x < m.Size[1].x && 
                        m.Size[0].y <= adjustedPos.y && adjustedPos.y < m.Size[1].y && 
                        m.Size[0].z <= adjustedPos.z && adjustedPos.z < m.Size[1].z;
          
    if !inboud_map {
        o.RelativeID = -1;
        return;
    }

    nc := &m.Cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)];
    
    o.RelativeID = GetAvailableID(nc^);
    
    append(&nc.Objects, e);
}