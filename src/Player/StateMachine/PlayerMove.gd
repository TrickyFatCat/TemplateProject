extends State

# TODO make base movement state for all entities
# TODO make these parameter applyable from the owner
var move_direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var velocity_max : float = 400.0
var acceleration : float = 2500.0
var friction : float = 2500.0


func _ready() -> void:
	pass


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	_calculate_move_direction()
	_calculate_velocity(delta, move_direction)
	velocity = owner.move_and_slide(velocity)


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _calculate_move_direction() -> void:
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction.normalized()


func _calculate_velocity(delta: float, direction: Vector2) -> void:
	if direction != Vector2.ZERO and (abs(velocity.x) <= velocity_max or abs(velocity.y) <= velocity_max):
		velocity += Vector2(acceleration, acceleration) * direction * delta
		velocity.x = _clamp_velocity(velocity.x)
		velocity.y = _clamp_velocity(velocity.y)
	elif velocity != Vector2.ZERO or (abs(velocity.x) > velocity_max or abs(velocity.y) > velocity_max):
		var friction_direction := velocity.normalized() * -1
		velocity += friction * friction_direction * delta
		velocity.x = _limit_velocity(velocity.x, friction_direction.x)
		velocity.y = _limit_velocity(velocity.y, friction_direction.y)


func _clamp_velocity(velocity_axis: float) -> float:
	return clamp(velocity_axis, -velocity_max, velocity_max)

		
func _limit_velocity(velocity_axis: float, direction_axis: float) -> float:
	if direction_axis < 0:
		velocity_axis = max(velocity_axis, 0)
	elif direction_axis > 0:
		velocity_axis = min(velocity_axis, 0)

	return velocity_axis