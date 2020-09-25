#* This script contains logic of the main menu.

tool
extends CanvasLayer

export(String, FILE, "*.tscn") var starting_level


func _get_configuration_warning() -> String:
	var warning: String = "Starting level must be defined in %s." % name
	return warning if !starting_level else ""


func _on_ButtonStart_button_up() -> void:
    Events.emit_signal("load_level", {"target_level": starting_level})
    pass


func _on_ButtonHelp_button_up() -> void:
    # TODO add help screen
    pass


func _on_ButtonCredits_button_up() -> void:
    # TODO add credits screen
    pass


func _on_ButtonQuit_button_up() -> void:
    Events.emit_signal("quit_game")
    pass