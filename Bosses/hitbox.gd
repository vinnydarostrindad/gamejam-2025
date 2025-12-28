extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("bodyALOW")


func _on_area_entered(area: Area2D) -> void:
	print("ALOW")
	print(area)
