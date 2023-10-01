extends Node2D
class_name State

signal transitioner

func _enter_tree():
	print('FSM(%s): %s entered tree' % [owner, name])

func _ready():
	print('FSM(%s): new %s' % [owner, name])
	__on_ready()

func process(delta):
	__on_process(delta)
	
func physics_process(delta):
	__on_physics_process(delta)

func enter():
	print('FSM: enter %s' % [name])
	__on_enter()

func exit():
	# print('exiting state %s' % [name])	
	__on_exit()

func finished_animation():
	__on_animation_finished()

func __on_ready():
	pass

func __on_enter_tree():
	pass

func __on_process(_delta: float):
	pass

func __on_physics_process(_delta: float):
	pass

func __on_enter():
	pass
	
func __on_exit():
	pass
	
func __on_animation_finished():
	pass
