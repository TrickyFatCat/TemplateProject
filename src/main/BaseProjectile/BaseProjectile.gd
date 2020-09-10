extends KinematicBody2D
class_name Projectile

var damage : int
var velocity_initial : float
var velocity_max : float
var velocity : float
var acceleration : float
var friction : float
var is_bounceable : bool
var spawned_scene_path : String
var spawned_scene_damage : int

onready var sprite : Sprite = $Sprite


func _physics_process(delta: float) -> void:
	# TODO add procjectile movement logic  
	var velocity = Vector2(5.0, 0).rotated(global_rotation)
	move_and_collide(velocity)


func apply_parameters(parameters: ProjectileParameters) -> void:
	sprite.texture = parameters.sprite
	damage = parameters.damage
	velocity_initial = parameters.velocity_initial
	velocity_max = parameters.velocity_max
	acceleration = parameters.acceleration
	friction = parameters.friction
	is_bounceable = parameters.is_bounceable
	spawned_scene_path = parameters.spawned_scene_path
	spawned_scene_damage = parameters.spawned_scene_damage
