extends Node

const LEVEL_NEXT : String = "next"
const LEVEL_RESTART : String = "restart"
const QUIT_GAME : String = "quit"

var player : Player
var playerCamera : PlayerCamera
var current_level : BaseLevel
var objects_node : YSort
var transition_command : String


func _unhandled_input(event: InputEvent) -> void:
	# TODO update pause controls
	if event.is_action_pressed("ui_cancel"):
		get_tree().paused = !get_tree().paused
	pass


func _ready() -> void:
	Events.connect("load_level", self, "_start_level_loading")
	Events.connect("restart_level", self, "_start_level_restart")
	Events.connect("quit_game", self, "_start_quitting_game")
	Events.connect("transition_screen_closed", self, "_process_transition_command")
	Events.connect("level_loaded", self, "_start_opening_screen")
	Events.connect("shake_camera", self, "_apply_camera_shake")


func _process_transition_command() -> void:
	match transition_command:
		LEVEL_NEXT:
			# TODO implement level loading by ID
			pass
		LEVEL_RESTART:
			# TODO implement level restart
			pass
		QUIT_GAME:
			get_tree().quit()
			pass
		_:
			LevelController.load_level_by_path(transition_command)
			pass


func _start_level_loading(msg: Dictionary = {}) -> void:
	if "target_level" in msg:
		transition_command = msg.target_level
	else:
		transition_command = LEVEL_NEXT

	TransitionScreen.start_transition()


func _start_quitting_game() -> void:
	transition_command = QUIT_GAME
	TransitionScreen.start_transition()


func _start_level_restart() -> void:
	transition_command = LEVEL_RESTART
	TransitionScreen.start_transition()


func _start_opening_screen() -> void:
	TransitionScreen.start_transition()


func _apply_camera_shake(
	duration: float = 0.2,
	frequency: float = 15.0,
	amplitude: int = 16,
	priority: int = 0):
	playerCamera.apply_camera_shake(duration, frequency, amplitude, priority)
