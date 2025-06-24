extends CharacterBody3D

@onready var sprite := $AnimatedSprite3D
@onready var cam = $Camera3D

# Movement Vars
const BASE_SPEED = 0.75
const SPRINT_SPEED = 1.4
const JUMP_VELOCITY = 1

# FOV Vars
@export var normal_fov: float = 62.0
@export var walk_fov: float = 68.0
@export var sprint_fov: float = 75.0
@export var fov_speed: float = 4.0

# Sprint logic
var current_speed := BASE_SPEED

# Gravity
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Movement Input
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	# Sprint Logic
	var is_attempting_to_sprint = Input.is_action_pressed("sprint") and direction != Vector3.ZERO
	if is_attempting_to_sprint:
		current_speed = lerp(current_speed, SPRINT_SPEED, delta * 6.0)
	else:
		current_speed = lerp(current_speed, BASE_SPEED, delta * 6.0)

	# Movement
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, BASE_SPEED)
		velocity.z = move_toward(velocity.z, 0, BASE_SPEED)

	move_and_slide()

	# Sprite Facing & Animation
	if Input.is_action_pressed("walk_left"):
		sprite.play("walk")
		sprite.flip_h = true
	elif Input.is_action_pressed("walk_right"):
		sprite.play("walk")
		sprite.flip_h = false
	elif Input.is_action_pressed("walk_down"):
		sprite.play("walk")
		sprite.flip_h = false
	elif Input.is_action_pressed("walk_up"):
		sprite.play("walk")
		sprite.flip_h = false
	else:
		sprite.play("default")

	# FOV Logic: walk = small boost, sprint = big boost, idle = normal
	var target_fov: float
	if is_attempting_to_sprint:
		target_fov = sprint_fov
	elif direction != Vector3.ZERO:
		target_fov = walk_fov
	else:
		target_fov = normal_fov

	cam.fov = lerp(cam.fov, target_fov, delta * fov_speed)
