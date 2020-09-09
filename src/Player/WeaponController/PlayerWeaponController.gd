extends WeaponController

const WEAPONS := [
	"res://content/Weapons/TestWeapon0.tres",
	"res://content/Weapons/TestWeapon1.tres"
]

var weapon_id : int = 0

onready var weapon : Weapon = $BaseWeapon


func _ready() -> void:
	_switch_weapon(3)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		weapon.process_shoot()

	_process_weapon_switch_wheel(event) 


func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	flip_weapon()
	switch_z_index()


func _switch_weapon(new_weapon_id: int) -> void:
	if new_weapon_id < 0 or new_weapon_id > WEAPONS.size() - 1:
		var error_text := "A weapon with id %s hasn't been found." % new_weapon_id
		push_error(error_text)
		return
	
	var weapon_data = load(WEAPONS[new_weapon_id])
	weapon.apply_parameters(weapon_data)


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