extends CharacterBody2D

const BLUE_BALLS = preload("uid://c6coiyoij14h4")
enum {
	VULNERABLE,
	ATTACKING
}

var state = ATTACKING

@onready var marker_2d: Marker2D = $Marker2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shoot_blue_ball_timer: Timer = $ShootBlueBallTimer
@onready var base_attack_timer: Timer = $BaseAttackTimer
@onready var hurtbox: Area2D = $Hurtbox
@onready var hitbox: Area2D = $Hitbox

var _direction: Vector2
var _state_timer: float
var _boss_life: int = 200

func _physics_process(delta: float) -> void:
	if _state_timer <= 0:
		if state == ATTACKING:
			state = VULNERABLE
			animation_player.play("idle")
			shoot_blue_ball_timer.stop()
			base_attack_timer.stop()
			hurtbox.monitoring = true
			hitbox.get_node("HitboxCollision").disabled = true
		elif state == VULNERABLE:
			state = ATTACKING
			animation_player.play("spin")
			_new_direction()
			shoot_blue_ball_timer.start()
			base_attack_timer.start()
			hitbox.get_node("HitboxCollision").disabled = false
			hurtbox.monitoring = false
		
		_state_timer = 7
	
	_state_timer -= delta
	if state == ATTACKING:
		velocity = _direction * 2000
		
		var collision = move_and_collide(velocity * delta)
		if collision:
			_new_direction()
		
	elif state == VULNERABLE:
		velocity = Vector2.ZERO

func _new_direction() -> void:
	var angle = randf_range(0, TAU)
	_direction = Vector2(cos(angle), sin(angle))

func _shoot():
	var blue_ball = BLUE_BALLS.instantiate()
	blue_ball.global_position = marker_2d.global_position
	add_sibling(blue_ball)

func _on_shoot_blue_ball_timer_timeout() -> void:
	_shoot()

func get_hit(damage: int) -> void:
	_boss_life -= damage
	print("BOSS HEALTH: ", _boss_life)
	if _boss_life <= 0:
		queue_free()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	var damage: int = 1
	
	match area.name:
		"AxeAttack":
			damage = 2
		"Dynamite":
			damage = 40

	get_hit(damage)

func _on_hitbox_area_entered(_area: Area2D) -> void:
	reset_hitbox()
	base_attack_timer.start()

func reset_hitbox() -> void:
	hitbox.set_deferred("monitoring", false)
	await get_tree().create_timer(1).timeout
	hurtbox.set_deferred("monitoring", true)

func _on_base_attack_timer_timeout() -> void:
	reset_hitbox()
