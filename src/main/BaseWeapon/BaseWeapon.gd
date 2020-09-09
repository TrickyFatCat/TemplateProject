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
var projectile_scene : String
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


func _process(delta: float) -> void:
	_recover_sprite_position()


func process_shoot() -> void:
	# TODO Implement shooting logic
	var projectile = load(projectile_scene)
	var projectile_instance = projectile.instance()
	add_child(projectile_instance)
	projectile_instance.position = spawn_point
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
		projectile_scene = parameters.projectile_scene_path
	else:
		projectile_scene = PROJECTILE_DEFAULT
		
	damage = parameters.damage
	rate_of_fire = parameters.rate_of_fire
	bullets_count = parameters.bullets_count
	is_spread_dynamic = parameters.is_spread_dynamic
	spread_min = parameters.spread_min
	spread_max = parameters.spread_max
	spread = spread_min
	spread_increase_shift = parameters.spread_increase_shift
	spread_decrease_shift = parameters.spread_decrease_shift


func _apply_recoil() -> void:
	sprite.position.x -= RECOIL_POWER


func _recover_sprite_position() -> void:
	sprite.position = lerp(sprite.position, sprite_init_pos, RECOVERY_SPEED)
