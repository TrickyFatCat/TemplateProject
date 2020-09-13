extends Position2D
class_name PlayerCamera

const CAMERA_FOLLOW_SPEED : float = 0.3

onready var camera: Camera2D = $PlayerCamera
onready var cameraShaker := $PlayerCamera/CameraShaker

export var offset: = Vector2(200.0, 200.0)
export var camera_range: = Vector2(0.0, 400.0)

var is_active: = true


func _init() -> void:
	GameManager.playerCamera = self


func _physics_process(delta: float) -> void:
	_update_position()


func _update_position(velocity: Vector2 = Vector2.ZERO) -> void:
	if not is_active:
		return
	
	var distance_ratio : float
	var target_position : Vector2

	match InputManager.current_input_device:
		InputManager.input_device.KEYBOARD:
			var mouse_position := get_local_mouse_position()
			distance_ratio = clamp(mouse_position.length(), camera_range.x, camera_range.y) / camera_range.y
			target_position = distance_ratio * mouse_position.normalized() * offset
			pass
		InputManager.input_device.GAMEPAD:
			distance_ratio = InputManager.get_analog_right_direction(0).length()
			target_position = distance_ratio * InputManager.get_analog_right_direction(0) * offset
			pass

	camera.position = lerp(camera.position, target_position, CAMERA_FOLLOW_SPEED)


func apply_camera_shake(
	duration: float = 0.2,
	frequency: float = 15.0,
	amplitude: int = 16,
	priority: int = 0
	) -> void:
	cameraShaker.start(duration, frequency, amplitude, priority)
