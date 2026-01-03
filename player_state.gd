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
	
func level_up(times: int = 1):
	player_level += times
	xp_to_next_level *= pow(1.25, times)
	player_xp = 0
	player_max_strength *= pow(1.2, times)
	player_points += times

# PLAYER STATS
var player_strength: float = 1
var player_max_strength: float = 1
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
	player_strength = max((player_happiness / 80) * player_max_strength, 0.4)
	
	emit_signal("happiness_change", player_happiness, player_max_happiness)

# MISSION
signal mission_change(current_mission: Dictionary)

var current_mission: Dictionary = {}

func add_mission(mission_name: String, type: String, objective: int, earns: int) -> void:
	current_mission = {
		"name": mission_name,
		"type": type,
		"objective": objective,
		"progress": 0,
		"earns": earns
	}
	emit_signal("mission_change")

func advance_on_mission() -> void:
	current_mission.progress += 1
	if current_mission.objective == current_mission.progress:
		mission_complete()
	
	emit_signal("mission_change")

func mission_complete():
	level_up(current_mission.earns)
	emit_signal("xp_changed", player_xp, xp_to_next_level)
	current_mission = {}
