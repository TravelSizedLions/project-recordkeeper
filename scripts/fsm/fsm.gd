extends Node2D
class_name FSM

@export var start_state: State = null;

var states: Dictionary = {}
var current_state: State = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = start_state
	current_state.transitioned.connect(transition_to)
	states[current_state.name.to_lower()] = current_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	pass

func transition_to(next_state_name: String):
	var next_state = states.get(next_state_name.to_lower())
	if not next_state:
		pass # create it
	else:
		current_state.on_exit()
		current_state = next_state
		current_state.on_enter()
		
	
		
