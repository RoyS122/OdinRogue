package render;

import "rogue:engine"
import rl"vendor:raylib"
import "rogue:utils"
Vec3D :: utils.Vec3D;

ORIGIN_TRANSITION :: Vec3D{0.5, 0.5, 0.5}

RenderObject3D :: proc(e: engine.CellContent) {
        o: ^engine.CellAttributes = engine.GetCellAttributes(e);

        rl.DrawCube(o.Pos + ORIGIN_TRANSITION, o.Shape.x, o.Shape.y, o.Shape.z, o.Colors[0]);
		rl.DrawCubeWires(o.Pos + ORIGIN_TRANSITION, o.Shape.x, o.Shape.y, o.Shape.z, o.Colors[1]);
} 