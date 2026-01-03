extends Node

func _ready() -> void:
	get_tree().scene_changed.connect(_on_scene_changed)

func _on_scene_changed() -> void:
	var scene := get_tree().current_scene
	if scene:
		var player = get_tree().get_first_node_in_group("Player")
		if PlayerState.player_item_texture:
			print(player)
			player.get_item(PlayerState.player_item_texture)
