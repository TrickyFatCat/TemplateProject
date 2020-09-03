extends Position2D
class_name PlayerCamera

const CAMERA_FOLLOW_SPEED : float = 0.3

onready var camera: Camera2D = $PlayerCamera
onready var cameraShaker := $PlayerCamera/CameraShaker

export var offset: = Vector2(200.0, 200.0)
export var mouse_range: = Vector2(0.0, 400.0)

var is_active: = true


func _init() -> void:
	GameManager.playerCamera = self


func _physics_process(delta: float) -> void:
	_update_position()


func _update_position(velocity: Vector2 = Vector2.ZERO) -> void:
	if not is_active:
		return

	var mouse_position: = get_local_mouse_position()
	var distance_ratio: = clamp(mouse_position.length(), mouse_range.x, mouse_range.y) / mouse_range.y
	# camera.position = distance_ratio * mouse_position.normalized() * offset
	var target_position = distance_ratio * mouse_position.normalized() * offset
	camera.position = lerp(camera.position, target_position, CAMERA_FOLLOW_SPEED)


func apply_shake(
	duration: float = 0.2,
	frequency: float = 15.0,
	amplitude: int = 16,
	priority: int = 0
	) -> void:
	cameraShaker.start(duration, frequency, amplitude, priority)