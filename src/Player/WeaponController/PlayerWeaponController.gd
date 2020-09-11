extends WeaponController

var weapons := [
	load("res://content/Weapons/TestWeapon0.tres"),
	load("res://content/Weapons/TestWeapon1.tres")
]

var weapon_id : int = 0
var is_shooting : bool = false

onready var weapon : Weapon = $BaseWeapon


func _on_Weapon_shoot():
	Events.emit_signal("shake_camera")


func _ready() -> void:
	_switch_weapon(0)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		is_shooting = true

	if event.is_action_released("shoot") and weapon.mode == WeaponParameters.shoot_mode.AUTO:
		is_shooting = false
		# TODO Add charge logic here

	_process_weapon_switch_wheel(event) 


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	flip_weapon()
	switch_z_index()


func _process(delta: float) -> void:
	if is_shooting:
		weapon.process_shoot()

		if weapon.mode == WeaponParameters.shoot_mode.SEMI_AUTO:
			is_shooting = false


func _switch_weapon(new_weapon_id: int) -> void:
	if new_weapon_id < 0 or new_weapon_id > weapons.size() - 1:
		var error_text := "A weapon with id %s hasn't been found." % new_weapon_id
		push_error(error_text)
		return
	
	weapon.apply_parameters(weapons[new_weapon_id])


func _process_weapon_switch_wheel(event: InputEvent) -> void:
	if event.is_action_pressed("choose_weapon_next"):
		weapon_id += 1
		
		if weapon_id == weapons.size():
			weapon_id = 0
		
		_switch_weapon(weapon_id)
	
	if event.is_action_pressed("choose_weapon_previous"):
		weapon_id -= 1

		if weapon_id < 0:
			weapon_id = weapons.size() - 1
		
		_switch_weapon(weapon_id)
