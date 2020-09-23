#* Player character main script

extends Entity
class_name Player

export(float) var dash_velocity := 700


func _init() -> void:
	GameManager.player = self


func switch_logic(value: bool) -> void:
	$CameraRig.set_physics_process(value)


func ready() -> void:
	# TODO add ready logic for the player character
	pass


func on_spawn() -> void:
	# TODO add spawn logic on player
	Events.emit_signal("player_spawned")
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
	stateMachine.transition_to("Death")
	pass


func get_scent_trail() -> Array:
	return $ScentSpawner.scent_trail