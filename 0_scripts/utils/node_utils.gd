class_name NodeUtils

static func get_child(node: Node, type):
	if is_instance_of(node, type):
		return node
  
	for child in node.get_children():
		var result = get_child(child, type)
		if result:
			return result

	return null
