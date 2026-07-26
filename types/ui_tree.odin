package types
import rl "vendor:raylib"

NODE_TYPE :: enum {
	primitive,
	content,
	component,
	// component children placeholder a special type
	ccp,
}

CONTENT_TYPE :: enum {
	text,
	texture,
}

NODE_LAYOUT :: struct {
	container_box: rl.Rectangle,
	border_box:    rl.Rectangle,
	content_box:   rl.Rectangle,
}

// ui node types content, primitive, component

UI_NODE :: struct {
	type:           NODE_TYPE,
	cid:            Cid,
	children_count: int,
	children:       [10]^UI_NODE,
	// for content
	c_type:         CONTENT_TYPE,
	c_data:         rawptr,
	// for primitive
	style:          string,
	p_draw:         PrimitiveDrawProc,
	p_listen:       proc(),
	p_layout:       PrimitiveLayoutProc,
	// for component
	comp_proc:      proc(props: rawptr) -> ^UI_NODE,
	comp_props:     rawptr,
}

UI_Tree_Node :: struct {
	node:           ^UI_NODE,
	layout:         NODE_LAYOUT,
	children_count: int,
	children:       [10]^UI_Tree_Node,
}

UI_Tree :: struct {
	root:       ^UI_Tree_Node,
	node_count: int,
	degree:     int,
	height:     int,
}
