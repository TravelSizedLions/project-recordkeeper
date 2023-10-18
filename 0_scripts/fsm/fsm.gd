extends Node2D
class_name FSM

@export var start_state: GDScript = null;

var states: Dictionary = {}
var current_state: State = null;
var __started: bool = false

func start():
	owner = get_parent()
	if start_state:
		on_state_transition(start_state)
	else:
		push_error('no start state found for FSM "%s" on "%s"' % [self, owner])

func _process(delta):
	if current_state:
		current_state.process(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_process(delta)

func on_state_transition(target_state: GDScript):
	var next_state = states.get(
		StringUtils.file_name(target_state.get_path())
	)

	if not next_state:
		next_state = add_state_node(target_state)

	if current_state:
		current_state.exit()

	current_state = next_state
	current_state.enter()

func get_state_key(script: GDScript):
	return StringUtils.file_name(script.get_path())
	
func add_state_node(script: GDScript):
	var node = N.create(script, self, owner)
	node.name = get_state_key(script)
	node.transitioner.connect(on_state_transition)
	states[node.name] = node
	return node

func on_animation_finished():
	current_state.finished_animation()
