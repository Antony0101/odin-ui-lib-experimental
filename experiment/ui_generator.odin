package sample

GeneratorContext :: struct {
    cur_parent: ^UI_NODE,
	stack: [dynamic]rawptr,
    root: ^UI_NODE,
}

generatorContext: GeneratorContext

begin_ui :: proc(){
    generatorContext.root
}

begin_c :: proc(c_type: CONTENT_TYPE, c_data: rawptr) -> ^UI_NODE {
	ui_node := new(UI_NODE)
	ui_node.type = .content
	ui_node.c_data = c_data
	ui_node.c_type = c_type
	return ui_node
}
begin_p :: proc(name: string) -> ^UI_NODE {
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
begin_comp :: proc(component_proc:() -> UI_NODE, props: rawptr) -> ^UI_NODE {
	ui_node := new(UI_NODE)
	ui_node.type = .component
	ui_node.comp_proc = component_proc
	ui_node.comp_props = props
	return ui_node
}
