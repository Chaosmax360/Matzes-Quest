extends CharacterBody3D

@export var speed = 8

@onready var nav = $NavigationAgent3D
@onready var player = get_parent().get_node("player_lvl3")

func _physics_process(_delta):
	
	move_and_slide()
