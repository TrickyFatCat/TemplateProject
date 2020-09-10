extends Timer

onready var parent = get_parent()


func _on_timeout() -> void:
    parent.queue_free()


func _init() -> void:
    one_shot = true
    autostart = true