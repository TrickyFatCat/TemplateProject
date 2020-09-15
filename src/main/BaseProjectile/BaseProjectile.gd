extends KinematicBody2D
class_name Projectile

var damage : int
var velocity_initial : float
var velocity_max : float
var velocity : float = 2
var direction : Vector2
var acceleration : float
var friction : float
var is_bounceable : bool
var spawned_scene_path : String
var spawned_scene_damage : int

onready var sprite : Sprite = $Sprite


func _physics_process(delta: float) -> void:
	# TODO add procjectile movement logic
	var collision = move_and_collide(velocity * direction)
	
	if is_bounceable and collision:
		_process_bounce(collision)


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


func _process_bounce(collision: KinematicCollision2D) -> void:
	# TODO update bounce logic
	direction = direction.bounce(collision.normal)
	rotation = direction.angle()
