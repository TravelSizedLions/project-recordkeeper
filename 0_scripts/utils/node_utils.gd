class_name NodeUtils

static func get_immediate_child(node: Node, type):
	if not node: 
		return null

	if is_instance_of(node, type):
		return node
	
	for child in node.get_children():
		if is_instance_of(node, type):
			return node

	return null

static func get_child(node: Node, type):
	if not node:
		return null
	
	if is_instance_of(node, type):
		return node
  
	for child in node.get_children():
		var result = NodeUtils.get_child(child, type)
		if result:
			return result

	return null

static func create(script: GDScript, parent: Node2D = null, owner: Node2D = null, name: String = ""):
	var node = Node2D.new()
	node.set_script(script)
	return __create(node, parent, owner, (name if name else StringUtils.file_name(script.get_path())))

static func create_native(nativeClass, parent: Node2D = null, owner: Node2D = null, name: String = ""):
	return __create(
		nativeClass.new(),
		parent,
		owner,
		name if name else ('%s' % [nativeClass])
	)

static func __create(node: Node2D,  parent: Node2D = null, owner: Node2D = null, name: String = ""):
	node.set_name(name)

	if owner:
		node.connect('tree_entered', (func(): node.set_owner(owner)))
	
	if parent:
		parent.add_child(node)

	return node
