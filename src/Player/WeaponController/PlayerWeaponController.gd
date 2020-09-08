extends WeaponController

onready var active_weapon : Weapon = $BaseWeapon


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		active_weapon.process_shoot()


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	flip_weapon()
	switch_z_index()