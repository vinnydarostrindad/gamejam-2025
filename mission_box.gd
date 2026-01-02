extends Control

@onready var mission_name_label: Label = $BoxContainer/MissionName
@onready var mission_objective_label: Label = $BoxContainer/MissionObjective
@onready var mission_earns_label: Label = $BoxContainer/MissionEarns

@export_category("MissionInfo")
@export var mission_name: String = ""
@export var mission_objective: String = ""
@export var mission_earns: String = ""

func _ready() -> void:
	mission_name_label.text = mission_name
	mission_objective_label.text = mission_objective
	mission_earns_label.text = mission_earns
