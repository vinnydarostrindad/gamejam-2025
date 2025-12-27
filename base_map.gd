extends Node2D

func _on_area_body_entered(body: Node2D, area: Area2D) -> void:
	if not body.is_in_group("Player"):
		return
		
	match area.name:
		"AreaRU":
			pass
		"AreaCantina":
			pass
		"AreaBiblioteca":
			pass
		"AreaSalaDoBoss":
			pass
