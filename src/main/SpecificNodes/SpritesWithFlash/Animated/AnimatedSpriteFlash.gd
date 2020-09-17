extends AnimatedSprite
class_name FlashingAnimatedSprite

signal flash_finished()

const ANIMATION_NAME : String = "SpriteFlash"


func _on_FlashAnimation_animation_finished(anim_name: String) -> void:
	if anim_name == ANIMATION_NAME:
		emit_signal("flash_finished")


func start_flash() -> void:
	if not $FlashAnimation.is_playing():
		$FlashAnimation.play(ANIMATION_NAME)


func set_flash_color(new_colour: Color) -> void:
	material.set_shader_param("u_colour", new_colour)
