extends State
class_name StateInactive


func unhandled_input(event: InputEvent) -> void:
	pass


func physics_process(delta: float) -> void:
	pass    


func enter(msg: Dictionary = {}) -> void:
	owner.is_active = false
	pass


func exit() -> void:
	pass

