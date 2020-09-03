extends Node

const SPLASH_DURATION : float = 0.5
const LOAD_DELAY : float = 0.5

export(String, FILE, "*.tscn") var next_level

onready var splashTimer : Timer = $SplashTimer


func _on_SplashTimer_timeout() -> void:
	Events.emit_signal("load_level", {"target_level": next_level})
	pass


func _ready() -> void:
	splashTimer.wait_time = SPLASH_DURATION
	Events.connect("transition_screen_opened", splashTimer, "start")
	yield(get_tree().create_timer(LOAD_DELAY), "timeout")
	Events.emit_signal("level_loaded")