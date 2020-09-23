extends KinematicBody2D
class_name Entity

export(int) var hitpoints_max := 100
export(int) var hitpoints_initial := 100
export(float) var velocity_max := 400
export(float) var acceleration := 2500
export(float) var friction := 2500

var is_invulnerable : bool = false setget set_is_invulnerable
var is_active : bool = true setget set_is_active
var weaponController : WeaponController

onready var hitPoints : HitPoints = $HitPoints
onready var damageDetector : DamageDetector = $DamageDetector
onready var stateMachine : StateMachine = $StateMachine
onready var sprite : FlashingAnimatedSprite = $AnimatedSprite


func set_is_active(value: bool) -> void:
	is_active = value
	sprite.visible = value
	damageDetector.is_active = value
	stateMachine.set_process_unhandled_input(value)
	switch_logic(value)
	
	if weaponController:
		weaponController.is_active = value
		weaponController.visible = false



func switch_logic(value: bool) -> void:
	# Add any logic for set_is_active
	pass


func set_is_invulnerable(value: bool) -> void:
	is_invulnerable = value
	damageDetector.is_invulnerable = value


func activate_damage_detection() -> void:
	damageDetector.is_active = true


func deactivate_damage_detection() -> void:
	damageDetector.is_active = false


func _ready() -> void:
	_connect_signals()
	_apply_parameters()
	ready()
	pass


func ready() -> void:
	# Add any logic on ready
	pass


func on_get_damage(damage: int) -> void:
	# Add any logic on getting damage
	pass


func on_hitpoints_decreased() -> void:
	# Add any logic on hitpoints decreasing
	pass


func on_zero_hitpoints() -> void:
	# Add any logic on zero hitpoints
	pass


func get_current_hitpoints() -> int:
	return hitPoints.value


func _connect_signals() -> void:
	damageDetector.connect("get_damage", self, "_decrease_hitpoints")
	damageDetector.connect("get_damage", self, "on_get_damage")
	hitPoints.connect("value_decreased", self, "on_hitpoints_decreased")
	hitPoints.connect("value_zero", self, "on_zero_hitpoints")


func _apply_parameters() -> void:
	hitPoints.value_max = hitpoints_max
	hitPoints.value = hitpoints_initial

	if has_node("WeaponController"):
		weaponController = get_node("WeaponController")
	else:
		push_warning("Entity >> %s << doesn't have a WeaponController node, if it must have one, check its scene" % name)


func _decrease_hitpoints(damage: int) -> void:
	hitPoints.decrease_value(damage)
