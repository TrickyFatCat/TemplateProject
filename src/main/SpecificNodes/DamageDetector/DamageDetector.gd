extends Area2D
class_name DamageDetector

signal get_damage(damage)

var is_invulnerable : bool = false


func _on_area_entered(area: Area2D) -> void:
	# TODO rethink this part of the code.
	pass


func _on_body_entered(body: KinematicBody2D) -> void:
	if body.is_damaging and not is_invulnerable:
		emit_signal("get_damage", body.damage)


func get_damage(damage: int) -> void:
	if not is_invulnerable:
		emit_signal("get_damage", damage)
