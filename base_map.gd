extends Node2D

func _on_area_body_entered(body: Node2D, area: Area2D) -> void:
	if not body.is_in_group("Player"):
		return
		
	match area.name:
		"AreaRU":
			get_tree().call_deferred("change_scene_to_file", "res://Rooms/ru.tscn")
		"AreaCantina":
			print("AreaCantina")
		"AreaBiblioteca":
			get_tree().call_deferred("change_scene_to_file", "res://fight-prototype.tscn")
		"AreaSalaDoBoss":
			get_tree().call_deferred("change_scene_to_file", "res://Bosses/boss_room.tscn")
