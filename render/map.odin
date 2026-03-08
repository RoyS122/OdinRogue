package render
import "rogue:engine"
import "core:fmt"
RenderMap3D :: proc (m: engine.Map) {
    for i :int; i < len(m.cells); i += 1 {
        for j :int; j < len(m.cells[i]); j += 1 {
            for k: int; k < len(m.cells[i][j]); k += 1 {
                RenderCell3D(m.cells[i][j][k]);
            }
        }
    }
}