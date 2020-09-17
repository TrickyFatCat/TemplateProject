extends Entity
class_name Player


func _init() -> void:
	GameManager.player = self


func ready() -> void:
	# TODO add ready logic for the player character
	pass


func on_get_damage(damage: int) -> void:
	# TODO add logic on get damage
	pass


func on_hitpoints_decreased() -> void:
	Events.emit_signal("player_took_damage")
	Events.emit_signal("shake_camera")
	sprite.start_flash(true)
	pass


func on_zero_hitpoints() -> void:
	# TODO add logic on zero hitpoints
	Events.emit_signal("player_dead")
	self.is_active = false
	pass


func get_scent_trail() -> Array:
	return $ScentSpawner.scent_trail