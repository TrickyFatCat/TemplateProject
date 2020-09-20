extends WeaponController

const WEAPONS := [
	preload("res://content/Weapons/TestWeapon0.tres"),
	preload("res://content/Weapons/TestWeapon1.tres")
]

var weapon_id : int = 0
var is_shooting : bool = false
var ammo_id_current : int = 0
var ammo_cost_current : int = 0

var ammo : Array = [
	[10, 10],
	[10, 10]
]

onready var weapon : Weapon = $BaseWeapon


func _ready() -> void:
	weapon.connect("shoot", self, "_process_shoot")
	weapon.connect("switched", self, "_process_switch")
	_switch_weapon(0)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot") and _is_enough_ammo():
		is_shooting = true

	if event.is_action_released("shoot") and weapon.mode == Weapon.shoot_mode.AUTO and _is_enough_ammo():
		is_shooting = false
		# TODO Add charge logic here

	_process_weapon_switch_wheel(event) 


func _physics_process(delta: float) -> void:
	match InputManager.current_input_device:
		InputManager.input_device.KEYBOARD:
			look_at(get_global_mouse_position())
			pass
		InputManager.input_device.GAMEPAD:
			if InputManager.get_analog_right_direction(InputManager.joy_id_current) != Vector2.ZERO:
				rotation = _get_joystick_rotation()
			pass
	
	flip_weapon()
	switch_z_index()


func _process(delta: float) -> void:
	if not _is_enough_ammo() and is_shooting:
		is_shooting = false
		return

	if is_shooting and _is_enough_ammo():
		weapon.process_shoot()

		if weapon.mode == Weapon.shoot_mode.SEMI_AUTO:
			is_shooting = false


func get_ammo_current(ammo_id: int) -> int:
	return ammo[ammo_id][0]


func get_ammo_max(ammo_id: int) -> int:
	return ammo[ammo_id][1]


func increase_ammo_current(ammo_id: int, amount: int) -> void:
	ammo[ammo_id][0] += amount
	ammo[ammo_id][0] = min(ammo[ammo_id][0], ammo[ammo_id][1])


func decrease_ammo_current(ammo_id: int, amount: int) -> void:
	ammo[ammo_id][0] -= amount
	ammo[ammo_id][0] = max(ammo[ammo_id][0], 0)


func set_ammo_max(ammo_id: int, new_max: int) -> void:
	if new_max <= 0:
		push_error("Max ammo can't be less or equal 0")
		return
	
	ammo[ammo_id][1] = new_max


func _process_shoot() -> void:
	decrease_ammo_current(ammo_id_current, ammo_cost_current)
	Events.emit_signal("shake_camera")
	Events.emit_signal("player_shoot", ammo_id_current, get_ammo_current(ammo_id_current))


func _switch_weapon(new_weapon_id: int) -> void:
	if new_weapon_id < 0 or new_weapon_id > WEAPONS.size() - 1:
		var error_text := "A weapon with id %s hasn't been found." % new_weapon_id
		push_error(error_text)
		return
	
	weapon.apply_parameters(WEAPONS[new_weapon_id])


func _process_switch() -> void:
	ammo_id_current = weapon.ammo_id
	ammo_cost_current = weapon.ammo_cost
	Events.emit_signal("player_switched_weapon", ammo_id_current, get_ammo_current(ammo_id_current), get_ammo_max(ammo_id_current))


func _process_weapon_switch_wheel(event: InputEvent) -> void:
	if event.is_action_pressed("choose_weapon_next"):
		weapon_id += 1
		
		if weapon_id == WEAPONS.size():
			weapon_id = 0
		
		_switch_weapon(weapon_id)
	
	if event.is_action_pressed("choose_weapon_previous"):
		weapon_id -= 1

		if weapon_id < 0:
			weapon_id = WEAPONS.size() - 1
		
		_switch_weapon(weapon_id)


func _get_joystick_rotation() -> float:
	return InputManager.get_analog_right_direction(InputManager.joy_id_current).angle()


func _is_enough_ammo() -> bool:
	var ammo_current = get_ammo_current(ammo_id_current)
	return ammo_current > 0 and ammo_current >= ammo_cost_current