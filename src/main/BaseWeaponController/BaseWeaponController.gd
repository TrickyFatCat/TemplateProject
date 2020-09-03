extends Node2D
class_name WeaponController


func flip_weapon() -> void:
	var abs_rotation = fmod(abs(rotation_degrees), 360.0)
	
	if abs_rotation > 90 and abs_rotation < 270:
		scale.y = -1
	else:
		scale.y = 1


func switch_z_index() -> void:
	var abs_rotation = fmod(abs(rotation_degrees), 360.0)
	
	if abs_rotation > 180 and abs_rotation < 360:
		z_index = 0
	else:
		z_index = -1
	pass