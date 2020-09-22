extends MoveState

# TODO make base movement state for all entities
# TODO make these parameter applyable from the owner


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	_calculate_move_direction()
	_calculate_velocity(delta, move_direction)
	_apply_movemnt()


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _calculate_move_direction() -> void:
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction = move_direction.normalized()