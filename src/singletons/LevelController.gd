extends Node

func load_level_by_path(path: String) -> void:
	get_tree().change_scene(path)