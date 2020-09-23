extends Area2D
class_name DamageDetector

signal get_damage(damage)

var is_active : bool = true setget _set_is_active
var is_invulnerable : bool = false setget _set_is_invulnerable


func _on_area_entered(area: Area2D) -> void:
	# TODO rethink this part of the code.
	pass


func _on_body_entered(body: KinematicBody2D) -> void:
	if not is_invulnerable:
		emit_signal("get_damage", body.damage)
	
	# TODO rethink destroying projectiles
	body.queue_free()


func get_damage(damage: int) -> void:
	if not is_invulnerable:
		emit_signal("get_damage", damage)


func _set_is_active(value: bool) -> void:
	is_active = value
	monitorable = value
	monitoring = value


func _set_is_invulnerable(value: bool) -> void:
	is_invulnerable = value