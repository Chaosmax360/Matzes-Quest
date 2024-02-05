extends CharacterBody3D

@export var speed = 5

@onready var nav = $NavigationAgent3D

func _physics_process(_delta):
	
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = new_velocity
	look_at(next_location)
	
	move_and_slide()

func update_target_location(target_location):
	
	nav.target_position = target_location
	
