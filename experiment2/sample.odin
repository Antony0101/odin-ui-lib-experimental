package sample

import p "../ui-lib/primitive"
import rl "vendor:raylib"

setup :: proc() {
	rl.SetConfigFlags({.VSYNC_HINT, .WINDOW_RESIZABLE})
	rl.InitWindow(900, 900, "prototype")
	rl.SetTargetFPS(60)
	generatorContext.root = nil
	generatorContext.cur_parent = nil
	clear(&generatorContext.stack)
	ui_register()
	create_ui_tree(generatorContext.root)
}

// simple: UI_NODE = UI_NODE {
// 	type   = .primitive,
// 	p_draw = simple_primitive_node_draw,
// }
tt: cstring = "Hello, World!"
// content: UI_NODE = UI_NODE {
// 	type   = .content,
// 	c_type = .text,
// 	c_data = cast(rawptr)tt,
// }

ui_register :: proc() {
	begin_primitive(
		p.ElementDraw,
		p.ElementLayout,
		2,
		"m-10 pt-10 pb-25 bg-yellow hover:bg-#1122ff",
	)
	content_text(tt)
	end_primitive()
}

loop :: proc() {
	rl.BeginDrawing()
	rl.ClearBackground(rl.WHITE)
	render_ui()
	// rl.DrawRectangle(10, 10, 100, 100, rl.RED)
	// simple.p_draw(&simple, &content)

	rl.EndDrawing()

}

main :: proc() {
	setup()
	for !rl.WindowShouldClose() {
		loop()
	}
}
