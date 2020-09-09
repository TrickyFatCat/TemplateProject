extends Node2D
class_name Weapon

signal shoot()

const RECOIL_POWER : float = 25.0
const RECOVERY_SPEED : float = 0.2

var weapon_name : String
var mode : int
var bullet_type : int
var projectile_recourse : String
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
    _apply_recoil()
    emit_signal("shoot")
    pass


func apply_parameters(parameters: WeaponParameters) -> void:
    weapon_name = parameters.weapon_name
    sprite.texture = parameters.sprite
    mode = parameters.mode
    bullet_type = parameters.bullet_type
    projectile_recourse = parameters.projectile_recourse
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