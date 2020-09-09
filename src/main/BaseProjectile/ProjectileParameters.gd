extends Resource
class_name ProjectileParameters


export(Texture) var sprite : Texture
export(float) var velocity_initial := 100
export(float) var velocity_max := 100
export(float) var acceleration := 100
export(float) var friction := 100
export(bool) var is_bounceable := false
export(String, FILE, "*.tscn") var instantiate_on_destroy
export(int) var instance_damage := 100
