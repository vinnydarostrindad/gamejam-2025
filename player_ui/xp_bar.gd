extends Control

@onready var fill: ColorRect = $CanvasLayer/Fill
@onready var level_text: Label = $CanvasLayer/LevelText

func _ready() -> void:
	PlayerState.xp_changed.connect(_on_xp_changed)
	_on_xp_changed(PlayerState.player_xp, PlayerState.xp_to_next_level)

func _on_xp_changed(current_xp: float, max_xp: float) -> void:
	var percent = (current_xp / max_xp) * 500
	fill.size.x = percent
	showLevel()
	
func showLevel() -> void:
	level_text.text = "%d QI" % PlayerState.player_level
