extends CharacterBody2D
class_name BaseEnemy

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("Player")
@onready var attack_cooldown: Timer = $AttackCooldown

@export_category("Variables")
@export var _move_speed: float = 100.0
@export var knockback_force: float = 2000.0
@export var knockback_decay: float = 10000.0
@export var _enemy_life: float = 4
@export var distance_of_player: int = 60
@export var _enemy_xp: int = 25

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _sprite2d: Sprite2D
@export var _hitbox_area2d: Area2D

var knockback_velocity: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if player == null:
		return

	apply_knockback(delta)
	move()
	animate()

	move_and_slide()

func move() -> void:
	# Se estiver sofrendo knockback, não controla movimento
	if knockback_velocity.length() > 0:
		velocity = knockback_velocity
		return

	if global_position.distance_to(player.global_position) < distance_of_player:
		velocity = Vector2.ZERO
		return

	var direction = (player.global_position - global_position).normalized()
	velocity = direction * _move_speed

func apply_knockback(delta: float) -> void:
	if knockback_velocity.length() > 0:
		knockback_velocity = knockback_velocity.move_toward(
			Vector2.ZERO,
			knockback_decay * delta
		)

func animate() -> void:
	if velocity.x > 0:
		_sprite2d.flip_h = false
	elif velocity.x < 0:
		_sprite2d.flip_h = true

	if knockback_velocity.length() > 0:
		_animation.play("hurt")
		return

	if global_position.distance_to(player.global_position) < distance_of_player:
		_animation.play("idle")
	else:
		_animation.play("run")

func get_hit(from_position: Vector2, damage: float) -> void:
	var direction = (global_position - from_position).normalized()
	knockback_velocity = direction * knockback_force
	
	_enemy_life -= damage
	if _enemy_life <= 0:
		if !PlayerState.current_mission.is_empty() and PlayerState.current_mission.type == "kill":
			PlayerState.advance_on_mission()
		PlayerState.add_xp(_enemy_xp)
		queue_free()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	var damage: float = 0.25
	
	match area.name:
		"AxeAttack":
			damage = 0.5
		"Dynamite":
			damage = 1.5

	get_hit(area.global_position, damage * PlayerState.player_strength)

func _on_hitbox_area_entered(_area: Area2D) -> void:
	reset_hitbox()
	attack_cooldown.start()

func _on_attack_cooldown_timeout() -> void:
	reset_hitbox()

func reset_hitbox() -> void:
	_hitbox_area2d.set_deferred("monitoring", false)
	await get_tree().create_timer(1).timeout
	_hitbox_area2d.set_deferred("monitoring", true)
