extends State

var velocity : float = 0.0
var velocity_max : float = 500.0
var acceleration : float = 100.0
var friction : float = 100.0
var motion : Vector2 = Vector2.ZERO

onready var sprite : AnimatedSprite = get_parent().get_parent().get_node("AnimatedSprite")


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	pass


func _physics_process(delta: float) -> void:
	motion = calculate_motion(delta, calculate_move_direction())
	owner.move_and_slide(motion)


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func calculate_move_direction() -> Vector2:
	var direction := Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return direction.normalized() if stateMachine.is_processing_unhandled_input() else Vector2.ZERO


func calculate_motion(delta: float, direction: Vector2) -> Vector2:
	if direction != Vector2.ZERO and velocity <= velocity_max:
		velocity += acceleration * delta
		velocity = min(velocity, velocity_max)
	elif velocity != 0 or velocity > velocity_max:
		velocity -= friction * delta
		velocity = max(velocity, 0)
	
	if direction == Vector2.ZERO and velocity > 0:
		direction = motion.normalized() * -1
	
	return velocity * direction