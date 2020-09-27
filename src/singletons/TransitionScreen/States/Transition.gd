extends State


func unhandled_input(event: InputEvent) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	Events.emit_signal("transition_screen_started_transition")


func exit() -> void:
	return