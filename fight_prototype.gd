extends Node2D

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var camera := player.get_node("Camera2D")
@onready var health_bar: Control = $HealthBar
@onready var enemies: Node2D = $Enemies
@onready var items: Control = $Items
@onready var spawn_area: Area2D = $SpawnArea
@onready var spawn_area_collision: CollisionShape2D = $SpawnArea/SpawnAreaCollision

const HEAL_POTION = preload("uid://hsl52e3q126b")
const TNT_ENEMY = preload("uid://f5jgcmce41ei")

func _process(_delta: float) -> void:
	if has_node("HealPotion") or items.item_img.texture:
		return
		
	if PlayerState._player_health < 101:
		print("BOTEI")
		var heal_potion = HEAL_POTION.instantiate()
		

		heal_potion.global_position = get_spawn_position()
		add_child(heal_potion)

func _on_tnt_enemy_timer_timeout() -> void:
	var tnt_enemy = TNT_ENEMY.instantiate()
	tnt_enemy.global_position = get_spawn_position()
	enemies.add_child(tnt_enemy)

func get_spawn_position() -> Vector2:
	var shape = spawn_area_collision.shape as RectangleShape2D

	var half_size = shape.size / 2
	var center = spawn_area_collision.global_position

	return Vector2(
		randf_range(center.x - half_size.x, center.x + half_size.x),
		randf_range(center.y - half_size.y, center.y + half_size.y)
	)

func _on_leave_area_body_entered(_body: Node2D) -> void:
	get_tree().call_deferred("change_scene_to_file", "res://base_level.tscn")
