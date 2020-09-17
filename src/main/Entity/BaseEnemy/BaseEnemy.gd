extends Entity
class_name Enemy

var target


func ready() -> void:
	# TODO add ready logic for the player character
	pass


func on_get_damage(damage: int) -> void:
	# TODO add logic on get damage
	pass


func on_hitpoints_decreased() -> void:
	sprite.start_flash(true)
	pass


func on_zero_hitpoints() -> void:
	# TODO add logic on zero hitpoints
	# TODO rework this code
	# self.is_active = false
	queue_free()
	pass
