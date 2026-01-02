extends Control

@onready var fill: ColorRect = $CanvasLayer/Fill

func _ready():
	update_bar()

func set_health(value: int) -> void:
	PlayerState.player_health = clamp(value, 0, PlayerState.player_max_health)
	update_bar()

func update_bar() -> void:
	var percent := float(PlayerState.player_health) / PlayerState.player_max_health
	fill.size.x = 500 * percent
