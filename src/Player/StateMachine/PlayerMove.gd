extends State

# TODO make base movement state for all entities
# TODO make these parameter applyable from the owner
var move_direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var velocity_max : float = 400.0
var acceleration : float = 2500.0
var friction : float = 2500.0

onready var sprite : AnimatedSprite = get_parent().get_parent().get_node("AnimatedSprite")


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	pass


func _physics_process(delta: float) -> void:
	_calculate_move_direction()
	calculate_velocity_y(delta, move_direction)
	calculate_velocity_x(delta, move_direction)
	velocity = owner.move_and_slide(velocity)


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _calculate_move_direction() -> void:
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction.normalized()


func calculate_velocity_x(delta: float, direction: Vector2) -> void:
	if direction.x != 0 and abs(velocity.x) <= velocity_max:
		velocity.x += acceleration * direction.x * delta
		velocity.x = clamp(velocity.x, -velocity_max, velocity_max)
	elif velocity.x != 0 or abs(velocity.x) > velocity_max:
		var friction_direction = -sign(velocity.x)
		velocity.x += friction * friction_direction * delta
		
		if friction_direction < 0:
			velocity.x = max(velocity.x, 0)
		elif friction_direction > 0:
			velocity.x = min(velocity.x, 0)


func calculate_velocity_y(delta: float, direction: Vector2) -> void:
	if direction.y != 0 and abs(velocity.y) <= velocity_max:
		velocity.y += acceleration * direction.y * delta
		velocity.y = clamp(velocity.y, -velocity_max, velocity_max)
	elif velocity.y != 0 or abs(velocity.y) > velocity_max:
		var friction_direction = -sign(velocity.y)
		velocity.y += friction * friction_direction * delta
		
		if friction_direction < 0:
			velocity.y = max(velocity.y, 0)
		elif friction_direction > 0:
			velocity.y = min(velocity.y, 0)