extends CharacterBody2D

@export var is_flipped_h: bool

@export_category("Locomotion")
@export var _speed: float = 8.0
@export var _acceleration: float = 16.0
@export var _deceleration: float = 32.0

@export_category("Jump")
@export var _jump_height: float = 2.5
@export var _air_control: float = 0.5
@export var _jump_dust: PackedScene

@onready var _sprite: Sprite2D = $Sprite2D

var _jump_velocity: float
var _direction: float

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	_sprite.flip_h = is_flipped_h
	_speed *= Global.ppt
	_acceleration *= Global.ppt
	_deceleration *= Global.ppt
	_jump_height *= Global.ppt
	_jump_velocity = sqrt(_jump_height * gravity * 2) * -1


func _physics_process(delta: float) -> void:
	if is_on_floor():
		_ground_physics(delta)
	else:
		_air_physics(delta)
	
	move_and_slide()


func _ground_physics(delta: float) -> void:
	if sign(_direction) == -1:
		face_left()
	elif sign(_direction) == 1:
		face_right()

	if _direction == 0:
		velocity.x = move_toward(velocity.x, 0, _deceleration * delta)
	elif velocity.x == 0 || sign(_direction) == sign(velocity.x):
		velocity.x = move_toward(velocity.x, _direction * _speed, _acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, _direction * _speed, _deceleration * delta)


func _air_physics(delta: float) -> void:
	if sign(_direction) == -1:
		face_left()
	elif sign(_direction) == 1:
		face_right()

	velocity.y += gravity * delta
	if _direction:
		velocity.x = move_toward(velocity.x, _direction * _speed, _acceleration * _air_control * delta)


func _spawn_dust(dust: PackedScene) -> void:
	var _dust = dust.instantiate()
	_dust.position = position
	_dust.flip_h = _sprite.flip_h
	get_parent().add_child(_dust)


func face_left():
	_sprite.flip_h = not is_flipped_h


func face_right():
	_sprite.flip_h = is_flipped_h


func run(direction: float):
	_direction = direction


func jump():
	if is_on_floor():
		velocity.y = _jump_velocity
		_spawn_dust(_jump_dust)

func stop_jump():
	if velocity.y < 0:
		velocity.y = 0
