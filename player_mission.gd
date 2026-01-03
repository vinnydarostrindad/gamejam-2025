extends Control

@onready var mission_name: Label = $CanvasLayer/VBoxContainer/mission_name
@onready var mission_progess: Label = $CanvasLayer/VBoxContainer/mission_progess
@onready var v_box_container: VBoxContainer = $CanvasLayer/VBoxContainer

var mission_objective: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerState.mission_change.connect(_on_mission_advance)
	_on_mission_advance()


func _on_mission_advance() -> void:
	if PlayerState.current_mission.is_empty():
		v_box_container.visible = false
		return
		
	v_box_container.visible = true
	mission_objective = PlayerState.current_mission.objective
	mission_name.text = PlayerState.current_mission.name
	mission_progess.text = "%d / %d" % [PlayerState.current_mission.progress, mission_objective]
