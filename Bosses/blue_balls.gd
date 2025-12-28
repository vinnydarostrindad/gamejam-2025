extends Area2D

var _direction_x
var _direction_y
var damage: int = 10

func _ready() -> void:
	_direction_x = randf_range(-1, 1)
	_direction_y = randf_range(-1, 1)
	
func _physics_process(delta: float) -> void:
	global_position += Vector2(_direction_x, _direction_y).normalized() * 400 * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Elevasion":
		queue_free()
