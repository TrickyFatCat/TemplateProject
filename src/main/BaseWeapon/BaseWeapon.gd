extends Node2D
class_name Weapon

signal shoot()

const RECOIL_POWER : float = 25.0
const RECOVERY_SPEED : float = 0.2

var weapon_name : String
var mode : int
var bullet_type : int
var damage : int
var rate_of_fire : float
var bullets_count : int
var spread : float

onready var sprite : Sprite = $Sprite
onready var sprite_init_pos : Vector2 = sprite.position


func _process(delta: float) -> void:
    _recover_sprite_position()


func process_shoot() -> void:
    # TODO Implement shooting logic
    _apply_recoil()
    emit_signal("shoot")
    pass


func _apply_recoil() -> void:
    sprite.position.x -= RECOIL_POWER


func _recover_sprite_position() -> void:
    sprite.position = lerp(sprite.position, sprite_init_pos, RECOVERY_SPEED)