extends GutTest

var fsm

func before_each():
	fsm = FSM.new()
	fsm.start_state = TestStateA
	add_child_autofree(fsm)

func test_adds_start_state():
	var state = NodeUtils.get_child(fsm, TestStateA)
	assert_eq(fsm.current_state, state)
	assert_true(state != null)
	assert_true(is_instance_of(state, TestStateA))

class TestStateA extends State:
	var ready_called = false
	var enter_tree_called = false
	var enter_called = false
	var exit_called = false
	var animation_finished_called = false
	var physics_called = false

	func __on_ready():
		ready_called = true

	func __on_enter_tree():
		enter_tree_called = true

	func __on_process(_delta: float):
		transitioner.emit(TestStateB)

	func __on_physics_process(_delta: float):
		physics_called = true

	func __on_enter():
		enter_called = true
		
	func __on_exit():
		exit_called = true
		
	func __on_animation_finished():
		animation_finished_called = true


class TestStateB extends State:
	var ready_called = false
	var enter_tree_called = false
	var enter_called = false
	var exit_called = false
	var animation_finished_called = false
	var physics_called = false
	
	func __on_ready():
		ready_called = true
	
	func __on_enter_tree():
		enter_tree_called = true
	
	func __on_process(_delta: float):
		transitioner.emit(TestStateA)
	
	func __on_physics_process(_delta: float):
		physics_called = true
	
	func __on_enter():
		enter_called = true
		
	func __on_exit():
		exit_called = true
		
	func __on_animation_finished():
		animation_finished_called = true
