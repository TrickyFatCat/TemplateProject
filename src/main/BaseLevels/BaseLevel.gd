extends Node
class_name BaseLevel


func _ready() -> void:
	Events.emit_signal("level_loaded")