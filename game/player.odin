package game

import "rogue:utils"
import "rogue:engine"
import rl "vendor:raylib"
import "core:fmt"

Vec3D :: utils.Vec3D;

PlayerGetDirection :: proc() -> (move: Vec3D) {
        if rl.IsKeyPressed(.RIGHT) {
            move.x += 1;
        }
        if rl.IsKeyPressed(.LEFT) {
            move.x -= 1;
        }
        if rl.IsKeyPressed(.UP) {
            move.z -= 1;
        }
        if rl.IsKeyPressed(.DOWN) {
            move.z += 1;
        }
        return move;
}

PlayerCheckMove :: proc (m: ^engine.Map, e: ^engine.Entity, move: Vec3D) -> bool {
    
    adjustedPos: Vec3D = m.Origin + e.Pos + move;
    inboud_map: bool =  m.Size[0].x <= adjustedPos.x && adjustedPos.x < m.Size[1].x && 
                        m.Size[0].y <= adjustedPos.y && adjustedPos.y < m.Size[1].y && 
                        m.Size[0].z <= adjustedPos.z && adjustedPos.z < m.Size[1].z;
    if ! inboud_map {
        return true
    }

    checkCell: ^engine.Cell = &m.Cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)];
    for i: int = 0; i < len(checkCell.Objects); i += 1 {
        #partial switch v in checkCell.Objects[i]  {
            case ^engine.Material:
                if (.Solid in v.props) {
                    if v.Pos.y + v.Shape.y > e.Climb.StepHeight + e.Pos.y {
                        return false
                    }
                }
        }
    }


    return true;
}

PlayerMoveAdaptation :: proc (m: ^engine.Map, e: ^engine.Entity, move: Vec3D) -> (nmv: Vec3D) {
    
    adjustedPos: Vec3D = m.Origin + e.Pos + move;
    inboud_map: bool =  m.Size[0].x <= adjustedPos.x && adjustedPos.x < m.Size[1].x && 
                        m.Size[0].y <= adjustedPos.y && adjustedPos.y < m.Size[1].y && 
                        m.Size[0].z <= adjustedPos.z && adjustedPos.z < m.Size[1].z;
    if ! inboud_map {
        return move
    }
    
    VertScanScope: int = int((adjustedPos.y + e.Shape.y) / m.CellShape.y +0.999);

    for i: int = VertScanScope; i >= 0; i -= 1 {
        checkCell: ^engine.Cell = &m.Cells[int(adjustedPos.x)][i][int(adjustedPos.z)]
        for j: int = 0; j < len(checkCell.Objects); j += 1 {
            #partial switch v in checkCell.Objects[j]  {
                case ^engine.Material:
                    if (.Solid in v.props) {
                        
                        obstacleNonClimbable: bool = v.Pos.y + v.Shape.y > e.Climb.StepHeight + e.Pos.y &&
                                                    v.Pos.y < e.Pos.y + e.Shape.y; 

                        obstacleClimbable: bool =  v.Pos.y + v.Shape.y <= e.Climb.StepHeight + e.Pos.y && 
                                                v.Pos.y + v.Shape.y >= e.Pos.y;                            
                        
                        if obstacleNonClimbable {
                            return {0, 0, 0};
                        }
                        if obstacleClimbable {
                            nmv.y = v.Pos.y + v.Shape.y - e.Pos.y
                            return nmv + move;
                        }

                        if e.Pos.y > v.Pos.y + v.Shape.y {
                            nmv.y = - e.Pos.y + v.Pos.y + v.Shape.y;
                        }else{
                            continue
                        }
                        return nmv + move;
                    }
            }
        }
    }
    
    nmv.y = - e.Pos.y;
    return nmv + move;
    
    
}

