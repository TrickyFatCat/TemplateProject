extends KinematicBody2D
class_name Enemy

export(int) var hitpoints_max := 100

onready var hitPoints : HitPoints = $HitPoints
onready var damageDetector : DamageDetector = $DamageDetector


func _on_DamageDetector_get_damage(damage: int) -> void:
	print_debug("Damage")
	hitPoints.decrease_value(damage)


func _on_HitPoints_value_decreased() -> void:
	# TODO add logic on getting damage
	pass


func _on_HitPoints_value_zero() -> void:
	print_debug(hitPoints.value_current)
	# TODO place here enemy death logic
	queue_free()
	pass


func _ready() -> void:
	hitPoints.value_max = hitpoints_max
	pass
