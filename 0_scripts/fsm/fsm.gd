extends Node2D
class_name FSM

@export var start_state: GDScript = null;

var states: Dictionary = {}
var current_state: State = null;

func _ready():
	current_state = add_state_node(start_state)

func _process(delta):
	current_state.process(delta)

func _physics_process(delta):
	current_state.physics_process(delta)

func on_state_transition(state_script):
	var next_state = states.get(get_state_key(state_script))

	if not next_state:
		next_state = add_state_node(state_script)

	current_state.exit()
	current_state = next_state
	current_state.enter()

func get_state_key(script: GDScript):
	return StringUtils.file_name(script.get_path())
	
func add_state_node(script: GDScript):
	var key = get_state_key(script)
	var node = Node2D.new()
	node.set_script(script)
	node.set_name(key)
	node.transitioner.connect(on_state_transition)
	add_child(node)
	states[key] = node
	return node

func on_animation_finished():
	current_state.finished_animation()
