extends Node
class_name BaseLevel

const LOAD_DEALAY_TIME : float = 0.5
const YSORT_NODE_NAME : String = "Objects"

var objects_node : YSort


func _init() -> void:
	GameManager.current_level = self
	init()


func _ready() -> void:
	objects_node = get_node(YSORT_NODE_NAME)if has_node(YSORT_NODE_NAME) else null
	ready()
	yield(get_tree().create_timer(LOAD_DEALAY_TIME), "timeout")
	Events.emit_signal("level_loaded")


func init() -> void:
	pass


func ready() -> void:
	pass