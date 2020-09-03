extends Sprite

signal flash_finished()


func _on_FlashAnimation_animation_finished(anim_name: String) -> void:
	if anim_name == "SpriteFlash":
		emit_signal("flash_finished")


func start_flash() -> void:
	$FlashAnimation.play("SpriteFlash")


func set_flash_color(new_colour: Color) -> void:
	material.set_shader_param("u_colour", new_colour)