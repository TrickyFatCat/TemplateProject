extends State

onready var state_move : State = get_parent()


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	state_move.physics_process(delta)


func enter(msg: Dictionary = {}) -> void:
	state_move.enter()


func exit() -> void:
	state_move.exit()
