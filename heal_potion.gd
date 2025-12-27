extends Area2D

@export_category("Variables")
@export var heal_amount: int = 100

const HEAL_POTION = preload("uid://bc741twwpvg1s")

func _on_body_entered(body: Node2D) -> void:
	body.get_item(HEAL_POTION)
	queue_free()
