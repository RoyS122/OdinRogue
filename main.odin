package main
 
import "core:fmt"
import rl "vendor:raylib"
import "test"
import engine "engine"
import render "render"

import "utils"

Vec3D :: utils.Vec3D;

Cube :: struct {
    Pos: Vec3D,
    Mesh: Vec3D,
}

main :: proc() {

    a: u8 = 255;
    fmt.println("Hellope!", a);

    fmt.println(test.TestProc(int(a), 2));

    testCam: rl.Camera3D;
    testCam.position = Vec3D{0, 10, 10};
    // testCam.target = Vec3D{0, 0, 0};
    testCam.up = Vec3D{0, 1, 0};
    testCam.fovy = f32(45);
    testCam.projection = .PERSPECTIVE;

    testCell: engine.Cell;
    testEntity: engine.Entity = {Pos = {0, 0, -1}, Shape = {1, 1, 1}, Colors={rl.YELLOW, rl.GRAY}};
    append(&testCell.entities, &testEntity)
    targetFPS: i32 = 60;
    
    
   
    rl.InitWindow(1200, 600, "test raylib");
    defer rl.CloseWindow();

    rl.SetTargetFPS(targetFPS);
    
    bounced: i8 = 1;
    for !rl.WindowShouldClose() {

        // if abs(testCam.up.x) > 0.5 {
        //   bounced *= -1;
        //   fmt.println("bounce ! ")
        // }     
        // fmt.println(abs(testCam.up.x))
        // testCam.up[0] += 0.001 * f32(bounced)
        // testCam.position[0] += 0.01* f32(bounced)
        

        move: Vec3D = {0, 0, 0}

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
        
        testEntity.Pos += move;

        rl.BeginDrawing();

	    rl.ClearBackground(rl.RAYWHITE);
        
        rl.BeginMode3D(testCam);
        render.RenderCell3D(testCell);
        rl.DrawGrid(20, 1)        // Draw a grid
        
		

		rl.EndMode3D()

		rl.DrawFPS(10, 10)
	    rl.EndDrawing();
        

    }
  
  
}
