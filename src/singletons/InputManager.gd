extends Node

enum input_device {
	KEYBOARD,
	GAMEPAD
}

enum joy_analog{
	LEFT,
	RIGHT
}

const JOY_DEADZONE : float = 0.25

var current_input_device : int = input_device.KEYBOARD


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey or event is InputEventMouse:
		current_input_device = input_device.KEYBOARD
		Events.emit_signal("input_device_changed", current_input_device)
		return
		
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		current_input_device = input_device.GAMEPAD
		Events.emit_signal("input_device_changed", current_input_device)
		# TODO Add checking gamepad index
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


static func get_analog_right_direction(joy_index: int) -> Vector2:
	return get_joy_analog_direction(joy_index, JOY_ANALOG_RX, JOY_ANALOG_RY)
