package sample

P_NODE :: struct {
	p_draw:   proc(),
	p_listen: proc(),
	p_layout: proc(),
}

primitive_node :: proc() {

}

sample_node := P_NODE {
	p_draw   = primitive_node,
	p_listen = primitive_node,
	p_layout = primitive_node,
}

component_node :: proc() {

}
