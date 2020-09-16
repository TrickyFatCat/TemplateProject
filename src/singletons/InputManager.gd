extends Node

enum input_device {
	KEYBOARD,
	GAMEPAD
}

const JOY_DEADZONE : float = 0.25
const JOY_ID_DEFAULT : int = 0

var current_input_device : int = input_device.KEYBOARD
var joy_id_current : int = JOY_ID_DEFAULT


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouse:
		current_input_device = input_device.KEYBOARD
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		Events.emit_signal("input_device_changed", current_input_device)
		return

	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		joy_id_current = event.device
		current_input_device = input_device.GAMEPAD
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Events.emit_signal("input_device_changed", current_input_device)
		return


static func get_joy_analog_direction(joy_index: int, axis_x: int, axis_y: int) -> Vector2:
	if joy_index < 0:
		push_error("Gamepad with index %s not found" % joy_index)
		return Vector2.ZERO

	var joy_x = Input.get_joy_axis(joy_index, axis_x)
	var joy_y = Input.get_joy_axis(joy_index, axis_y)
	var joy_direction = Vector2(joy_x, joy_y)

	if joy_direction.length() <= JOY_DEADZONE:
		joy_direction = Vector2.ZERO

	return joy_direction


static func get_analog_right_direction(joy_index: int = JOY_ID_DEFAULT) -> Vector2:
	return get_joy_analog_direction(joy_index, JOY_ANALOG_RX, JOY_ANALOG_RY)