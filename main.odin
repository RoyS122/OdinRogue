package main
 
import "core:fmt"
import rl "vendor:raylib"
import "test"
import engine "engine"
import render "render"
import game "game";

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
    testCam.position = Vec3D{-10, 10, 10};
    testCam.target = Vec3D{0, 0, 0};
    testCam.up = Vec3D{0, 1, 0};
    testCam.fovy = f32(45);
    testCam.projection = .PERSPECTIVE;

    testMap: engine.Map = engine.BuildMap({20, 20, 20}, {10, 0, 10});
    testEntity: engine.Entity = {Pos = {-9, 0, 0}, Shape = {1, 1, 1}, Colors={rl.YELLOW, rl.GRAY}};

    testWall: engine.Material = {Pos = {7, 0, -5}, Shape = {1, 1, 1}, Colors={rl.DARKGRAY, rl.GRAY}, props={.Solid}};
    engine.AddObject(&testMap, &testWall);
    engine.AddObject(&testMap, &testEntity);
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
        


        move: Vec3D = game.PlayerGetDirection();

        if(move != 0 && game.PlayerCheckMove(&testMap, &testEntity, move)) {
            fmt.println("move called")
            engine.EMove(&testMap, &testEntity, move);
        }
       

        rl.BeginDrawing();

	    rl.ClearBackground(rl.RAYWHITE);
        
        rl.BeginMode3D(testCam);
        render.RenderMap3D(testMap);
       
        
        rl.DrawGrid(20, 1)
    
  
		rl.EndMode3D()

		rl.DrawFPS(10, 10)
        rl.EndDrawing();
        
    }
  
  
}
