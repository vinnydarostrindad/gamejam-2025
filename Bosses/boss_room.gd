extends Node2D

func _on_leave_area_body_entered(_wbody: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://base_level.tscn")
