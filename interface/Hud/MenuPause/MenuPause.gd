#* Simple pause menu logic

extends Menu

const MAIN_MENU_PATH : String = "res://levels/Menus/MainMenu.tscn"


func _ready() -> void:
	$Menu/MenuBody/Buttons/ButtonResume.connect("button_up", self, "_on_resume_up")
	$Menu/MenuBody/Buttons/ButtonHelp.connect("button_up", self, "_on_help_up")
	$Menu/MenuBody/Buttons/ButtonExit.connect("button_up", self, "_on_exit_up")
	_set_menu_buttons($Menu/MenuBody/Buttons)
	Events.connect("open_menu_pause", self, "_open_menu")
	Events.connect("close_menu_pause", self, "_close_menu")


func _on_resume_up() -> void:
	# TODO add menu pause close logic
	self.is_active = false
	Events.emit_signal("menu_pause_closed")
	Utility.unpause_game()
	pass


func _on_help_up() ->  void:
	# TODO add help screen call here
	pass


func _on_exit_up() -> void:
	_set_buttons_active(false)
	Events.emit_signal("load_level", { "target_level": MAIN_MENU_PATH })
	# TODO add exit to main menu here
	pass


func _open_menu() -> void:
	self.is_active = true
	_focus_first_button()



func _close_menu() -> void:
	self.is_active = false
	_release_focus()
	

