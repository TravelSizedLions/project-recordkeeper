class_name DeathState extends State

@onready var player: Player = Player.retrieve()

func __on_enter():
	player.animator.play('death')

func __on_animation_finished():
	get_tree().create_timer(3).timeout.connect(player.respawn)
