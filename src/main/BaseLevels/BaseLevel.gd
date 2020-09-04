extends Node
class_name BaseLevel


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		var explosion_scene = load("res://src/main/BaseExplosion/BaseExplosion.tscn")
		var explosion_instance = explosion_scene.instance()
		GameManager.current_level.add_child(explosion_instance)
		explosion_instance.position = get_viewport().get_mouse_position()


func _init() -> void:
	GameManager.current_level = self


func _ready() -> void:
	Events.emit_signal("level_loaded")
