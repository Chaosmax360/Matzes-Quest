extends CharacterBody3D

@export var speed = 5
@export var gravity = 30

@onready var nav = $NavigationAgent3D
@onready var player = get_parent().get_node("player_lvl3")
@onready var enemy_music = $MeshInstance3D/enemy_music

func _ready():
	enemy_music.play()

func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	var current_location = global_transform.origin
	var next_location = nav.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * speed
	
	velocity = new_velocity
	look_at(player.global_transform.origin)
	
	
	
	move_and_slide()

func update_target_location(target_location):
	
	nav.target_position = target_location
	
	
func _on_area_3d_body_entered(body):
	for child in body.get_children():
		if child is player_only:
			body.hit(1)
			queue_free()
