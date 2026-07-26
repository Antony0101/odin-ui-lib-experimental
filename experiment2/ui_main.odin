package sample

import "../types"
import "core:fmt"


ui_tree: types.UI_Tree

// function preorder(node) {
//     if (!node) return;

//     console.log(node.value);
//     preorder(node.left);
//     preorder(node.right);
// }

ui_tree_preorder :: proc(node: ^types.UI_NODE) -> ^types.UI_Tree_Node {
	if node == nil do return nil
	tree_node := new(types.UI_Tree_Node)
	if node.type == .content {
		tree_node.node = node
		tree_node.children_count = 0
		return tree_node
	}
	if node.type == .primitive {
		children: [10]^types.UI_Tree_Node
		for c in 0 ..< node.children_count {
			children[c] = ui_tree_preorder(node.children[c])
		}
		tree_node.children = children
		tree_node.children_count = node.children_count
		tree_node.node = node
		return tree_node
	}
	re := node.comp_proc(node.comp_props)
	re1 := ui_tree_preorder(re)
	tree_node.children[0] = re1
	tree_node.children_count = 1
	return tree_node
}

create_ui_tree :: proc(root: ^types.UI_NODE) -> ^types.UI_Tree_Node {
	// root := new(UI_Tree_Node)
	// ui_tree.root = root
	tree_root := ui_tree_preorder(root)
	ui_tree.root = tree_root
	return tree_root
}

update_ui_tree :: proc() {

}

layout_preorder :: proc(tree_node: ^types.UI_Tree_Node) {
	if tree_node == nil do return
	if tree_node.node.type == .primitive {
		child := tree_node.node.children[0]
		fmt.println("layout_preorder", tree_node.node.cid, tree_node.node.style, child.cid)
		rr := tree_node.node.p_layout(tree_node.node.cid, tree_node.node, child)
		tree_node.layout.container_box = rr.container_rect
		tree_node.layout.border_box = rr.border_rect
		tree_node.layout.content_box = rr.content_rect
	}
	// for c in 0 ..< tree_node.children_count {
	// 	layout_preorder(tree_node.children[c])
	// }
}

calculate_ui_layout :: proc() {
	tree_node := ui_tree.root
	fmt.println("hhhh")
	layout_preorder(tree_node)
}

draw_preorder :: proc(tree_node: ^types.UI_Tree_Node) {
	if tree_node == nil do return
	if tree_node.node.type == .primitive {
		child := tree_node.node.children[0]
		tree_node.node.p_draw(tree_node.node.cid, tree_node, child)
	}
	// for c in 0 ..< tree_node.children_count {
	// 	draw_preorder(tree_node.children[c])
	// }
}

draw_ui :: proc() {
	tree_node := ui_tree.root
	draw_preorder(tree_node)
}

render_ui :: proc() {
	calculate_ui_layout()
	draw_ui()
}
