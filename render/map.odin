package render
import "rogue:engine"
import "core:fmt"
RenderMap3D :: proc (m: engine.Map) {
    for i :int; i < len(m.Cells); i += 1 {
        for j :int; j < len(m.Cells[i]); j += 1 {
            for k: int; k < len(m.Cells[i][j]); k += 1 {
                RenderCell3D(m.Cells[i][j][k]);
            }
        }
    }
}