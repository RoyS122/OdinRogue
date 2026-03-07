package render
import "rogue:engine"

RenderCell3D :: proc(c: engine.Cell) {
    for i: int = 0; i < len(c.entities); i += 1  {
        RenderEntity3D(c.entities[i]^);
    }
}