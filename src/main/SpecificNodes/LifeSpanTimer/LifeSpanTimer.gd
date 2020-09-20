extends Timer

onready var parent = get_parent()


func _init() -> void:
    one_shot = true
    autostart = true


func _ready() -> void:
    yield(get_parent(), "ready")
    connect("timeout", parent, "queue_free")
