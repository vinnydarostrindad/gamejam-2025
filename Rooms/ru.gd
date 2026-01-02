extends Node2D

@onready var label: Label = $Label

var can_eat: bool = false

func _process(_delta: float) -> void:
	if can_eat and Input.is_action_just_pressed("interact"):
		eat()

func _on_leave_area_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://base_level.tscn")

func _on_get_food_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_eat = true
		label.visible = true

func _on_get_food_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		can_eat = false
		label.visible = false

func eat() -> void:
	PlayerState.happiness_update(100)
