extends Node


static func get_facing_direction(target: Node2D) -> Vector2:
	return Vector2.RIGHT.rotated(target.rotation)


static func get_player_position() -> Vector2:
	return GameManager.player.global_position


static func get_direction_to_player(target: Node2D) -> Vector2:
	return (get_player_position() - target.global_position).normalized()


static func get_distance_to_player(target: Node2D) -> float:
    return get_player_position().distance_to(target.global_position)
    

static func approachf(value_initial: float, value_target: float, shift: float) -> float:
    if value_initial < value_target:
        return min(value_initial + shift, value_target)
    else:
        return max(value_initial - shift, value_target)


static func approachi(value_initial: int, value_target: int, shift: int) -> int:
    if value_initial < value_target:
        return int(min(value_initial + shift, value_target))
    else:
        return int(max(value_initial - shift, value_target))

