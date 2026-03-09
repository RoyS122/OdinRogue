package render
import "rogue:engine"
import "core:fmt"

RenderCell3D :: proc(c: engine.Cell) {
    for i: int = 0; i < len(c.Objects); i += 1  {
        RenderObject3D(c.Objects[i]);
    }
}