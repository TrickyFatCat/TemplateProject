extends KinematicBody2D
class_name Player

export(int) var hitpoints_max := 100

var is_invulnerable : bool = false

onready var hitPoints : HitPoints = $HitPoints
onready var damageDetector : DamageDetector = $DamageDetector


func _on_DamageDetector_get_damage(damage: int) -> void:
	Events.emit_signal("shake_camera")
	hitPoints.decrease_value(damage)


func _on_HitPoints_value_decreased() -> void:
	Events.emit_signal("player_took_damage")
	$AnimatedSprite.start_flash()


func _on_HitPoints_value_zero() -> void:
	Events.emit_signal("player_dead")


func _init() -> void:
	GameManager.player = self


func _ready() -> void:
	hitPoints.value_max = hitpoints_max
	pass