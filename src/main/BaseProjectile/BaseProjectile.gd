extends KinematicBody2D
class_name Projectile

var damage : int
var velocity_initial : float
var velocity_max : float
var acceleration : float
var friction : float
var is_bounceable : bool
var instance_on_destroy : String
var instance_damage : int

onready var sprite : Sprite = $Sprite


func _ready() -> void:
	set_as_toplevel(true)


func apply_parameters(parameters: ProjectileParameters) -> void:
	# TODO implement parameters
	sprite.texture = parameters.sprite
