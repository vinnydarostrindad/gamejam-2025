extends Node2D

@onready var pawn: BaseCharacter = $Pawn
@onready var missions: Control = $CanvasLayer/Missions

func _on_shop_area_body_entered(_body: Node2D) -> void:
	missions.visible = true
	pawn.is_in_shop = true

func _on_shop_area_body_exited(_body: Node2D) -> void:
	missions.visible = false
	pawn.is_in_shop = false

func _on_leave_area_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://base_level.tscn")
