extends CanvasLayer


func _input(event: InputEvent) -> void:
	# TODO update pause controls
	if event.is_action_pressed("ui_exit"):
		if Utility.is_game_paused():
			Utility.unpause_game()
			Events.emit_signal("close_menu_pause")
		else:
			Utility.pause_game()
			Events.emit_signal("open_menu_pause")
			

func _ready() -> void:
	Events.connect("restart_level", self, "_deactivate_input")    
	Events.connect("level_exit", self, "_deactivate_input")   
	Events.connect("level_finished", self, "_deactivate_input")


func _deactivate_input() -> void:
	set_process_input(false)
