extends Node
class_name TreeAccess

static var root: Node
static var tree: SceneTree

func _enter_tree():
	tree = get_tree()
	root = tree.root

