extends Resource
class_name WeaponParameters

enum shoot_mode {
    AUTO,
    SEMI_AUTO
}

enum bullet {
    PROJECTILE,
    RAYCAST,
    BEAM
}

export(String) var weapon_name := "Name"
export(Texture) var sprite : Texture
export(shoot_mode) var mode := shoot_mode.AUTO
export(bullet) var bullet_type := bullet.PROJECTILE
export(String, FILE, "*.tscn") var projectile_recourse
export(int) var damage := 1
export(float) var rate_of_fire := 1
export(int) var bullets_count := 1
export(bool) var is_spread_dynamic := false
export(float) var spread_min := 10
export(float) var spread_max := 10
export(float) var spread_increase_shift := 10
export(float) var spread_decrease_shift := 10
