extends Control

@onready var item_img: TextureRect = $CanvasLayer/ItemImg

func put_item(item) -> void:
	item_img.texture = item
