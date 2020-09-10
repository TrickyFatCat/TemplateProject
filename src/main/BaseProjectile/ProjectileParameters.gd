extends Resource
class_name ProjectileParameters


export(Texture) var sprite : Texture
export(float) var velocity_initial := 100.0
export(float) var velocity_max := 100.0
export(float) var acceleration := 100.0
export(float) var friction := 100.0
export(bool) var is_bounceable := false
export(String, FILE, "*.tscn") var spawned_scene_path
export(int) var spawned_scene_damage := 100

var damage : int = 1