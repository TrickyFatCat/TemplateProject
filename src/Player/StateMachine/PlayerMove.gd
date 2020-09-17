extends State

var velocity : float
var velocity_max : Vector2
var friction : float = 0.0

onready var sprite : AnimatedSprite = get_parent().get_parent().get_node("AnimatedSprite")


func _ready() -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	pass


func _physics_process(delta: float) -> void:
	pass


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func calculate_move_direction() -> Vector2:
	var direction := Vector2.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return direction.normalized() if stateMachine.is_processing_unhandled_input() else Vector2.ZERO
