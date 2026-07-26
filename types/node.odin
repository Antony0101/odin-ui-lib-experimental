package types
import rl "vendor:raylib"

Cid :: u32

UIState :: struct {
	// element is active in a sense that mouse is pressed down on this element
	active: Cid,
	// element is focused or currently active in a sense that interaction from keyboard other is will result on this element
	focus:  Cid,
	// hot or hover state
	hover:  Cid,
}

PrimitiveDrawProc :: proc(
	id: Cid,
	node: ^UI_Tree_Node,
	content: ^UI_NODE,
	uiState: ^UIState = nil,
	debug_border: bool = false,
)


PrimitiveLayoutProc :: proc(
	id: Cid,
	node: ^UI_NODE,
	content: ^UI_NODE,
	uiState: ^UIState = nil,
) -> PrimitiveLayoutResult

PrimitiveLayoutResult :: struct {
	container_rect: rl.Rectangle,
	border_rect:    rl.Rectangle,
	content_rect:   rl.Rectangle,
}
