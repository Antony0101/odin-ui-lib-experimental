package sample

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

ui_tree: UI_Tree

// function preorder(node) {
//     if (!node) return;

//     console.log(node.value);
//     preorder(node.left);
//     preorder(node.right);
// }

ui_tree_preorder :: proc(node: ^UI_NODE) -> ^UI_Tree_Node {
	if node == nil do return nil
	tree_node := new(UI_Tree_Node)
	if node.type == .content {
		tree_node.node = node
		tree_node.children_count = 0
		return tree_node
	}
	if node.type == .primitive {
		children: [10]^UI_Tree_Node
		for c in 0 ..< node.children_count {
			children[c] = ui_tree_preorder(node.children[c])
		}
		tree_node.children = children
		tree_node.children_count = node.children_count
		tree_node.node = node
		return tree_node
	}
	re := node.comp_draw(node.comp_props, node.children)
	re1 := ui_tree_preorder(re)
	tree_node.children[0] = re1
	tree_node.children_count = 1
	return tree_node
}

create_ui_tree :: proc(root: UI_NODE) -> ^UI_Tree_Node {
	root := new(UI_Tree_Node)
	ui_tree.root = root

	return root
}

update_ui_tree :: proc() {

}

calculate_ui_layout :: proc() {

}

draw_ui :: proc() {

}

render_ui :: proc() {
	calculate_ui_layout()
	draw_ui()
}
