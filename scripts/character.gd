extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var _direction: float

func face_left():
	pass

func face_right():
	pass

func run(direction: float):
	_direction = direction

func jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if _direction:
		velocity.x = _direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	# 	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	# var direction := Input.get_axis("ui_left", "ui_right")
	# if direction:
	# 	velocity.x = direction * SPEED
	# else:
	# 	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
