extends CanvasLayer

onready var menuPause := $MenuPause
onready var dataPanelPlayer := $DataPanelPlayer


func _notification(what: int) -> void:
	if what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		Utility.pause_game()
		menuPause.open_menu()
		dataPanelPlayer.is_active = false
		Events.emit_signal("open_menu_pause")


func _input(event: InputEvent) -> void:
	# TODO update pause controls
	if event.is_action_pressed("ui_exit"):
		if Utility.is_game_paused():
			Utility.unpause_game()
			menuPause.close_menu()
			dataPanelPlayer.is_active = true
			Events.emit_signal("close_menu_pause")
		else:
			Utility.pause_game()
			menuPause.open_menu()
			dataPanelPlayer.is_active = false
			Events.emit_signal("open_menu_pause")
			

func _ready() -> void:
	Events.connect("restart_level", self, "_deactivate_input")    
	Events.connect("level_exit", self, "_deactivate_input")   
	Events.connect("level_finished", self, "_deactivate_input")


func _deactivate_input() -> void:
	set_process_input(false)
