extends Node

@onready var player: Player = get_tree().get_first_node_in_group('player')

# Called when the node enters the scene tree for the first time.
func _ready():
	__track_player()
	
func _process(_delta):
	if not player:
		player = get_tree().get_first_node_in_group('player')
		__track_player()


func __track_player():
	var remote_transform: RemoteTransform2D = N.create_native(
		RemoteTransform2D,
		player,
		player
	)

	remote_transform.remote_path = self.get_path()
