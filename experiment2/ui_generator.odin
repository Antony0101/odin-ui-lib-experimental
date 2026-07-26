package sample

import "../types"

GeneratorContext :: struct {
	cur_parent: ^types.UI_NODE,
	stack:      [dynamic]^types.UI_NODE,
	root:       ^types.UI_NODE,
}

generatorContext: GeneratorContext

begin_primitive :: proc(
	draw: types.PrimitiveDrawProc,
	layout: types.PrimitiveLayoutProc,
	cid: types.Cid,
	style: string,
) -> ^types.UI_NODE {
	ui_node := new(types.UI_NODE)
	ui_node.type = .primitive
	ui_node.p_draw = draw
	ui_node.p_layout = layout
	ui_node.style = style
	ui_node.cid = cid

	if generatorContext.cur_parent != nil {
		append(&generatorContext.stack, ui_node)
		parent := generatorContext.cur_parent
		parent.children[parent.children_count] = ui_node
		parent.children_count += 1
	}
	if generatorContext.root == nil {
		generatorContext.root = ui_node
	}
	generatorContext.cur_parent = ui_node
	return ui_node
}

end_primitive :: proc() {
	if generatorContext.cur_parent == nil do panic("No current parent to end")
	if generatorContext.cur_parent.type != .primitive do panic("Current parent is not a primitive node")
	if len(generatorContext.stack) == 0 {
		generatorContext.cur_parent = nil
		return
	}
	generatorContext.cur_parent = pop(&generatorContext.stack)
}

content_text :: proc(data: cstring) -> ^types.UI_NODE {
	ui_node := new(types.UI_NODE)
	ui_node.type = .content
	ui_node.c_type = .text
	ui_node.c_data = cast(rawptr)data

	if generatorContext.cur_parent == nil do panic("No current parent to add content to")
	parent := generatorContext.cur_parent
	parent.children[parent.children_count] = ui_node
	parent.children_count += 1
	return ui_node
}
