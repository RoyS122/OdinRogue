package game

import "rogue:utils"
import "rogue:engine"
import rl "vendor:raylib"

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
    
    adjustedPos: Vec3D = m.origin + e.Pos + move;
    inboud_map: bool =  m.size[0].x <= adjustedPos.x && adjustedPos.x < m.size[1].x && 
                        m.size[0].y <= adjustedPos.y && adjustedPos.y < m.size[1].y && 
                        m.size[0].z <= adjustedPos.z && adjustedPos.z < m.size[1].z;
    if ! inboud_map {
        return true
    }
    checkCell: ^engine.Cell = &m.cells[int(adjustedPos.x)][int(adjustedPos.y)][int(adjustedPos.z)];
    for i: int = 0; i < len(checkCell.Objects); i += 1 {
        #partial switch v in checkCell.Objects[i]  {
            case ^engine.Material:
                if (.Solid in v.props) {
                    return false;
                }
        }
    }
    return true;
}