extends CharacterBody2D
class_name BaseCharacter

const DYNAMITE = preload("uid://bd6yuubutpfyl")

var _can_attack: bool = true
var _attack_animation_name: String = ""
var _direction: Vector2

@onready var health_bar: Control = $"../PlayerUI/HealthBar"
@onready var items: Control = $"../PlayerUI/Items"

@export_category("Variables")
@export var _move_speed: float = 1500.0
@export var _left_attack_name: String = ""
@export var _right_attack_name: String = ""
@export var _Q_attack: String = ""

@export_category("Objects")
@export var _animation: AnimationPlayer
@export var _sprite2D: Sprite2D
@export var _axe_collision: CollisionShape2D
@export var _hammer_collision: CollisionShape2D

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("use_item"):
		if items.item_img.texture:
			if PlayerState.player_item == "heal_potion":
				heal(100)
			items.item_img.texture = null
			PlayerState.player_item = ""
			PlayerState.player_item_texture = null
	_move()
	_attack()
	_animate()

func _attack() -> void:
	if Input.is_action_just_pressed("left_attack") and _can_attack:
		_can_attack = false
		_attack_animation_name = _left_attack_name
		set_physics_process(false)
	elif Input.is_action_just_pressed("right_attack") and _can_attack:
		_can_attack = false
		_attack_animation_name = _right_attack_name
		set_physics_process(false)
	elif Input.is_action_just_pressed("throw"):
		_can_attack = false
		_attack_animation_name = _Q_attack
		set_physics_process(false)
	
func _move() -> void:
	_direction = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down"
	)
	
	if _direction != Vector2.ZERO:
		_axe_collision.position = _direction * 35
		if _direction.y > 0 or _direction.y < 0:
			_axe_collision.rotation_degrees = 90
		else:
			_axe_collision.rotation_degrees = 0
	
	velocity = _direction * (_move_speed * PlayerState.player_speed)
	move_and_slide()
	
func _animate() -> void:
	if velocity.x > 0:
		_sprite2D.flip_h = false
	elif velocity.x < 0:
		_sprite2D.flip_h = true
		
	if !_can_attack:
		_animation.play(_attack_animation_name)
		return
		
	if velocity:
		_animation.play("run")
		return
	
	_animation.play("idle")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_axe" or anim_name == "attack_hammer" or anim_name == "throw":
		_can_attack = true
		set_physics_process(true)
		
		if anim_name == "throw":
			throw()

func enable_attack() -> void:
	match _attack_animation_name:
		"attack_axe":
			_axe_collision.disabled = false
		"attack_hammer":
			_hammer_collision.disabled = false

func disable_attack() -> void:
	match _attack_animation_name:
		"attack_axe":
			_axe_collision.disabled = true
		"attack_hammer":
			_hammer_collision.disabled = true

func get_hit(damage: int):
	PlayerState.player_health -= damage
	health_bar.set_health(PlayerState.player_health)
	
	if PlayerState.player_health <= 0:
		print("PERDEU")
		get_tree().reload_current_scene()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.get("damage"):
		print("TEM RAPAz")
		get_hit(area.damage)
		return
		
	get_hit(1)

func throw() -> void:
	var dynamite = DYNAMITE.instantiate()
	dynamite.global_position = global_position
	get_parent().add_child(dynamite)
	
	var tween = create_tween()
	tween.tween_property(dynamite, "global_position", (_direction * 500) + global_position, 0.6)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_OUT)

func get_item(item: CompressedTexture2D) -> void:
	PlayerState.player_item_texture = item
	PlayerState.player_item = PlayerState.player_item_texture.resource_path.get_file().get_basename()
	items.put_item(PlayerState.player_item_texture)

func heal(porcentage: float) -> void:
	PlayerState.player_health = min(PlayerState.player_max_health * (porcentage/100), 100)
	health_bar.set_health(PlayerState.player_health)
