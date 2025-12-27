extends Node2D

func _on_area_body_entered(body: Node2D, area: Area2D) -> void:
	if not body.is_in_group("Player"):
		return
		
	match area.name:
		"AreaRU":
			print("AreaRU")
		"AreaCantina":
			print("AreaCantina")
		"AreaBiblioteca":
			get_tree().call_deferred("change_scene_to_file", "res://fight-prototype.tscn")
		"AreaSalaDoBoss":
			print("AreaSalaDoBoss")
