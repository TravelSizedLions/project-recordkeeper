class_name N

static func find(type, name: String = ""):
	return N.get_child(TreeAccess.root, type, name)

static func get_ancestor(node: Node, type, name: String = ""):
	if not node:
		return

	if __is_correct_node(node, type, name):
		return node

	var ancestor = node.get_parent()
	while ancestor and not __is_correct_node(ancestor, type, name):
		ancestor = ancestor.get_parent()

	return ancestor

static func get_immediate_child(node: Node, type):
	if not node: 
		return null

	if is_instance_of(node, type):
		return node
	
	for child in node.get_children():
		if is_instance_of(node, type):
			return node

	return null

static func get_child(node: Node, type, name: String = ""):
	if not node:
		return null
	
	if __is_correct_node(node, type, name):
		return node
  
	for child in node.get_children():
		var result = N.get_child(child, type, name)
		if result:
			return result

	return null

static func get_all_children(node: Node, type):
	if not node:
		return []
	
	var result = []

	if __is_correct_node(node, type):
		result.append(node)

	for child in node.get_children():
		result += N.get_all_children(child, type)

	return result

static func __is_correct_node(node: Node, type, name: String = ""):
	return is_instance_of(node, type) and (not name or node.name == name)

static func create(script: GDScript, parent: Node2D = null, owner: Node2D = null, name: String = ""):
	var node = Node2D.new()
	node.set_script(script)
	return __create(node, parent, owner, (name if name else StringUtils.file_name(script.get_path())))

static func create_native(nativeClass, parent: Node2D = null, owner: Node2D = null, name: String = ""):
	return __create(nativeClass.new(), parent, owner, name if name else ('%s' % [nativeClass]))

static func create_scene(scene: PackedScene, parent: Node = null, owner: Node = null, name: String = ""):
	return __create(scene.instantiate(), parent, owner, (name if name else StringUtils.file_name(scene.get_path())))

static func __create(node: Node,  parent: Node2D = null, owner: Node2D = null, name: String = ""):
	node.set_name(name)
	if owner:
		node.connect('tree_entered', (func(): node.set_owner(owner)))
	elif parent:
		node.connect('tree_entered', (func(): node.set_owner(parent)))
	else:
		print('node:', node, ' added to root. has path: ', node.get_path())
		node.connect('tree_entered', (func(): node.set_owner(TreeAccess.root)))
	
	if parent:
		parent.add_child(node)
	else:
		TreeAccess.root.add_child(node)

	return node
