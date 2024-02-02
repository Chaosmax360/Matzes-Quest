extends CharacterBody3D

@export var jump_force = 12
@export var speed = 10
@export var sensitivity = 0.003
@export var gravity = 30

@onready var camera_node = $camera_node
@onready var camera = $camera_node/Camera3D

var has_double_jumped = false

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(- event.relative.x * sensitivity)
		camera.rotate_x(- event.relative.y * sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	if is_on_floor():
		has_double_jumped = false
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_force
	elif Input.is_action_just_pressed("jump") && has_double_jumped == false:
		velocity.y = jump_force
		has_double_jumped = true

	var input_dir = Input.get_vector("left", "right", "forwards", "backwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction && Input.is_action_pressed("sprint"):
		velocity.x = direction.x * speed * 1.4
		velocity.z = direction.z * speed * 1.4
	elif direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0
		velocity.z = 0
		
	move_and_slide()
