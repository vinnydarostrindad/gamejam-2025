extends Control

@onready var fill: ColorRect = $CanvasLayer/Fill

func _ready():
	update_bar()

func set_health(value: int) -> void:
	PlayerState._player_health = clamp(value, 0, PlayerState._player_max_health)
	update_bar()

func update_bar() -> void:
	var percent := float(PlayerState._player_health) / PlayerState._player_max_health
	fill.size.x = 500 * percent
