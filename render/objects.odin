package render;

import "rogue:engine"
import rl"vendor:raylib"
import "rogue:utils"
Vec3D :: utils.Vec3D;

ORIGIN_TRANSITION :: Vec3D{0.5, 0, 0.5}

RenderObject3D :: proc(e: engine.CellContent) {
        o: ^engine.CellAttributes = engine.GetCellAttributes(e);
        
        if o.Model != nil {
            renderPos: Vec3D = {o.Pos.x + (o.Shape.x / 2), o.Pos.y , o.Pos.z + (o.Shape.z / 2)}
            rl.DrawModelEx(o.Model^, renderPos, {0, 1, 0}, 0.0, {0.1, 0.1, 0.1}, rl.WHITE)
            // rl.DrawSphere(o.Pos, 0.2, rl.RED)
            return
        } 
       
        renderPos: Vec3D = {o.Pos.x + (o.Shape.x / 2), o.Pos.y + (o.Shape.y / 2), o.Pos.z + (o.Shape.z / 2)}
        rl.DrawCube(renderPos, o.Shape.x, o.Shape.y, o.Shape.z, o.Colors[0]);
		rl.DrawCubeWires(renderPos, o.Shape.x, o.Shape.y, o.Shape.z, o.Colors[1]);
} 