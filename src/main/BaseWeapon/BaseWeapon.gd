extends Node2D
class_name Weapon

signal shoot()

const RECOIL_POWER : float = 25.0
const RECOVERY_SPEED : float = 0.2
const PROJECTILE_DEFAULT : String = "res://src/main/BaseProjectile/BaseProjectile.tscn"

var weapon_name : String
var mode : int
var spawn_point : Vector2 = Vector2.ZERO
var bullet_type : int
var projectile_resource : String
var projectile_scene_path : String
var damage : int
var rate_of_fire : float
var bullets_count : int
var is_spread_dynamic : bool
var spread_min : float
var spread_max : float
var spread : float
var spread_increase_shift : float
var spread_decrease_shift : float

onready var sprite : Sprite = $Sprite
onready var sprite_init_pos : Vector2 = sprite.position
 

func _physics_process(delta: float) -> void:
	_recover_sprite_position()

	if is_spread_dynamic and spread != spread_min:
		_decrease_spread()
		update()


func process_shoot() -> void:
	# TODO Implement shooting logic
	for _i in range(bullets_count):
		_spawn_projectile()

	if is_spread_dynamic:
		_increase_spread()
	
	_apply_recoil()
	emit_signal("shoot")
	pass


func apply_parameters(parameters: WeaponParameters) -> void:
	weapon_name = parameters.weapon_name
	sprite.texture = parameters.sprite
	sprite.position = parameters.sprite_offset
	sprite_init_pos = parameters.sprite_offset
	spawn_point.x = parameters.spawn_offset_x
	mode = parameters.mode
	bullet_type = parameters.bullet_type
	
	if parameters.projectile_resource:
		projectile_resource = parameters.projectile_resource
	else:
		push_error("Projectile paramentrs hasn't been found in %s" % weapon_name)
	
	if parameters.projectile_scene_path:
		projectile_scene_path = parameters.projectile_scene_path
	else:
		projectile_scene_path = PROJECTILE_DEFAULT
		
	damage = parameters.damage
	rate_of_fire = parameters.rate_of_fire
	bullets_count = parameters.bullets_count
	is_spread_dynamic = parameters.is_spread_dynamic
	spread_min = parameters.spread_min
	spread_max = parameters.spread_max
	spread = spread_min
	spread_increase_shift = parameters.spread_increase_shift
	spread_decrease_shift = parameters.spread_decrease_shift


func _spawn_projectile() -> void:
	var projectile_scene := load(projectile_scene_path)
	var projectile_instance = projectile_scene.instance()
	var projectile_rotation = _calculate_procjectile_rotation()
	var projectile_spawn_position := global_position + spawn_point.rotated(deg2rad(projectile_rotation))
	var projectile_parameters := load(projectile_resource)
	GameManager.current_level.objects_node.add_child(projectile_instance)
	projectile_instance.global_position = projectile_spawn_position
	projectile_instance.rotation_degrees = projectile_rotation
	projectile_parameters.damage = damage
	projectile_instance.apply_parameters(projectile_parameters)


func _apply_recoil() -> void:
	sprite.position.x -= RECOIL_POWER


func _recover_sprite_position() -> void:
	sprite.position = lerp(sprite.position, sprite_init_pos, RECOVERY_SPEED)


func _calculate_procjectile_rotation() -> float:
	randomize()
	var sperad_noise = rand_range(-spread/2, spread/2)
	return global_rotation_degrees + sperad_noise


func _increase_spread() -> void:
	spread += spread_increase_shift
	spread = min(spread, spread_max)
	print_debug(spread)


func _decrease_spread() -> void:
	spread -= spread_decrease_shift
	spread = max(spread, spread_min)


func _draw() -> void:
	var debug_color = Color.aqua
	var line_width = 3
	var line_length = (Utility.get_facing_direction(self) * 1000)
	var spread_threshhold = deg2rad(spread/2)
	print_debug("Spread threshhold %s" % spread_threshhold)
	var spawn_pos = global_position + spawn_point #.rotated(spread_threshhold)
	var target_point_a = spawn_pos + line_length.rotated(spread_threshhold)
	var target_point_b = spawn_pos + line_length.rotated(-spread_threshhold)
	draw_line(spawn_pos, target_point_a, debug_color, line_width)
	draw_line(spawn_pos, target_point_b, debug_color, line_width)
