package engine;

 import  "rogue:utils" 
import rl"vendor:raylib"

Vec3D :: utils.Vec3D;

Entity :: struct {
    RelativeID: i8,
    Pos: Vec3D,
    Shape: Vec3D,
    Colors: [2]rl.Color,
    
}

EMove::proc(e: ^Entity, m: ^Map, v: Vec3D) {
    if(e.RelativeID < 0) {
        return;
    }
    c := m[int(e.Pos.z)][int(e.Pos.y)][int(e.Pos.x)]; 
    for i := 0; i < len(c.entities); i += 1 {
        if(c.entities[i].RelativeID == e.RelativeID) {

        }
    }
       
}