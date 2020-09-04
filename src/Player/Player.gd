extends KinematicBody2D
class_name Player

export(int) var hitpoints_max := 100

var is_invulnerable : bool = false
var is_active : bool = true setget set_is_active

onready var hitPoints : HitPoints = $HitPoints
onready var damageDetector : DamageDetector = $DamageDetector
onready var stateMachine : StateMachine = $StateMachine


func _on_DamageDetector_get_damage(damage: int) -> void:
	hitPoints.decrease_value(damage)
	
	
func _on_HitPoints_value_decreased() -> void:
	Events.emit_signal("player_took_damage")
	Events.emit_signal("shake_camera")
	$AnimatedSprite.start_flash()


func _on_HitPoints_value_zero() -> void:
	Events.emit_signal("player_dead")
	self.is_active = false


func _init() -> void:
	GameManager.player = self


func _ready() -> void:
	hitPoints.value_max = hitpoints_max


func set_is_active(value: bool) -> void:
	is_active = value 
	damageDetector.monitoring = value
	damageDetector.monitorable = value
	stateMachine.set_process_unhandled_input(value)