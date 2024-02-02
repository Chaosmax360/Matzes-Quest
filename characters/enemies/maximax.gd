extends CharacterBody2D



@export var speed = 200
@export var gravity = 8

@onready var walk_timer = $walk_timer
@onready var sprite = $Sprite2D

var walk_end = true

func _physics_process(_delta):

	if !is_on_floor():
		velocity.y += gravity
	
	if velocity.y > 1000:
		velocity.y = 1000
	
	if walk_end:
		walk_end = false
		walk_timer.start()
		velocity.x = 50
		await walk_timer.timeout
		walk_timer.start()
		velocity.x = 0
		await walk_timer.timeout
		walk_timer.start()
		velocity.x = -50
		await walk_timer.timeout
		walk_timer.start()
		velocity.x = 0
		await walk_timer.timeout
		walk_end = true
	
	move_and_slide()

func _on_death_body_entered(body):
	for child in body.get_children():
		if child is Camera2D:
			body.maximax_death()

func _on_jump_body_entered(body):
	for child in body.get_children():
		if child is Camera2D:
			body.maximax_jump()
