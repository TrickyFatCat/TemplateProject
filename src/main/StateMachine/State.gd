extends Node
class_name State, "res://assets/EngineIcons/icon_state.svg"

onready var stateMachine: Node = _get_state_machine(self)


# warning-ignore:unused_argument
func unhandled_input(event: InputEvent) -> void:
	return


# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
	return


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _get_state_machine(node: Node) -> Node:
	if node != null and !node.is_in_group("state_machine"):
		return  _get_state_machine(node.get_parent())
	return node


func is_previous_state(state_name: String) -> bool:
	return stateMachine.previous_state.name == state_name