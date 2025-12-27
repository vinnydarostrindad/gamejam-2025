extends Area2D

@onready var collision: CollisionShape2D = $Collision

func _on_animation_animation_finished(_anim_name: StringName) -> void:
	collision.disabled = false
	await get_tree().create_timer(0.3).timeout
	queue_free()
