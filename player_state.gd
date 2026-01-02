extends Node

# PLAYER HEALTH
var player_max_health: int = 100
var player_health: int = 100

# PLAYER ITEMS
var player_item: String = ""
var player_item_texture: CompressedTexture2D

# PLAYER XP
signal xp_changed(current_xp: float, max_xp: float)

var player_level: int = 0
var player_xp: float = 0
var xp_to_next_level: float = 100

func add_xp(xp: int) -> void:
	player_xp += xp

	if player_xp >= xp_to_next_level:
		level_up()
	emit_signal("xp_changed", player_xp, xp_to_next_level)
	
func level_up():
	player_level += 1
	xp_to_next_level *= 1.25
	player_xp = 0
	player_strength *= 1.2
	player_points += 1

# PLAYER STATS
var player_strength: float = 1
var player_speed: float = 1

# PLAYER POINTS
var player_points: int = 0

# PLAYER HAPPINESS
signal happiness_change(current_happiness: float, max_happiness: float)

var player_happiness: float = 100
var player_max_happiness: float = 100

func happiness_update(percentage = null) -> void:
	if percentage != null:
		player_happiness = percentage
	else:
		if player_happiness <= 0:
			return
		player_happiness -= 0.025
		
	player_speed = max(player_happiness / 100, 0.2)
	player_strength = max(player_happiness / 80, 0.4)
	
	emit_signal("happiness_change", player_happiness, player_max_happiness)
