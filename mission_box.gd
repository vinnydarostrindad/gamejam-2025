extends Control

@onready var mission_name_label: Label = $BoxContainer/MissionName
@onready var mission_objective_label: Label = $BoxContainer/MissionObjective
@onready var mission_earns_label: Label = $BoxContainer/MissionEarns

@export_category("MissionInfo")
@export var mission_name: String = ""
@export var mission_objective_text: String = ""
@export var mission_earns_text: String = ""

@export_category("MissionStats")
@export var mission_type: String = ""
@export var mission_objective: int = 25
@export var mission_earns: int = 10

func _ready() -> void:
	mission_name_label.text = mission_name
	mission_objective_label.text = mission_objective_text
	mission_earns_label.text = mission_earns_text

func _on_accept_btn_pressed() -> void:
	PlayerState.add_mission(mission_name, mission_type, mission_objective, mission_earns)
