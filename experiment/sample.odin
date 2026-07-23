package sample

import rl "vendor:raylib"

setup :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT, .WINDOW_RESIZABLE})
	rl.InitWindow(900, 900, "prototype")
	rl.SetTargetFPS(60)
}

loop :: proc() {
	rl.BeginDrawing()
	rl.ClearBackground(rl.WHITE)
	rl.DrawRectangle(10, 10, 100, 100, rl.RED)
	rl.EndDrawing()

}

main :: proc() {
	setup()
	for !rl.WindowShouldClose() {
		loop()
	}
}
