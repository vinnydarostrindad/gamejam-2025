extends Control

@onready var fill: ColorRect = $CanvasLayer/Fill

func _ready() -> void:
	PlayerState.happiness_change.connect(_on_happiness_change)
	if PlayerState.player_happiness == 0:
		fill.size.x = 0
		return
	PlayerState.happiness_update()

func _on_happiness_change(current_happiness: float, max_happiness: float):
	var percent = (current_happiness / max_happiness) * 500
	fill.size.x = percent

func _on_happiness_fall_timer_timeout() -> void:
	PlayerState.happiness_update()
