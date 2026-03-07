package render;

import "rogue:engine"
import rl"vendor:raylib"
import "rogue:utils"
Vec3D :: utils.Vec3D;

ORIGIN_TRANSITION :: Vec3D{0.5, 0.5, 0.5}

RenderEntity3D :: proc(e: engine.Entity) {
    
        rl.DrawCube(e.Pos + ORIGIN_TRANSITION, e.Shape.x, e.Shape.y, e.Shape.z, e.Colors[0]);
		rl.DrawCubeWires(e.Pos + ORIGIN_TRANSITION, e.Shape.x, e.Shape.y, e.Shape.z, e.Colors[1]);
} 