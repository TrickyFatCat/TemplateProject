extends Resource
class_name ProjectileParameters


export(float) var speed_initial := 100
export(float) var speed_max := 100
export(float) var acceleration := 100
export(float) var friction := 100
export(bool) var is_bounceable := false
export(String, FILE, "*.tscn") var instantiate_on_destroy
export(int) var instance_damage := 100
