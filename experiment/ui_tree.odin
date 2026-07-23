package sample

NODE_TYPE :: enum {
	primitive,
	content,
	component,
	// component children placeholder a special type
	ccp,
}

CONTENT_TYPE :: enum {
	text,
}

NODE_LAYOUT :: struct {
	using pos: [2]f32,
	width:     f32,
	height:    f32,
}

// ui node types content, primitive, component

UI_NODE :: struct {
	type:           NODE_TYPE,
	children_count: int,
	children:       [10]^UI_NODE,
	// for content
	c_type:         CONTENT_TYPE,
	c_data:         rawptr,
	// for primitive
	p_draw:         proc(),
	p_listen:       proc(),
	p_layout:       proc(),
	// for component
	comp_proc:      proc(props: rawptr) -> ^UI_NODE,
	comp_props:     rawptr,
}

odx_c :: proc(c_type: CONTENT_TYPE, c_data: rawptr) -> ^UI_NODE {
	ui_node := new(UI_NODE)
	ui_node.type = .content
	ui_node.c_data = c_data
	ui_node.c_type = c_type
	return ui_node
}
odx_p :: proc(name: string) -> ^UI_NODE {
	ui_node := new(UI_NODE)
	if name == "children" {
		ui_node.type = .ccp
		return ui_node
	}
	ui_node.type = .primitive
	ui_node.p_draw = primitive_node
	ui_node.p_layout = primitive_node
	ui_node.p_listen = primitive_node
	return ui_node
}
odx_comp :: proc(component_proc:() -> UI_NODE, props: rawptr) -> ^UI_NODE {
	ui_node := new(UI_NODE)
	ui_node.type = .component
	ui_node.comp_proc = component_proc
	ui_node.comp_props = props
	return ui_node
}
