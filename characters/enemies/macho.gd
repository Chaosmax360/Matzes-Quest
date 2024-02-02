extends CharacterBody2D

@export var health = 3
@export var speed = 90

@onready var until_attack_timer = $until_attack
@onready var damage_taken_sound = $audio/damage_taken
@onready var band_aid1 = $band_aid1
@onready var band_aid2 = $band_aid2
@onready var player = get_parent().get_node("player_lvl2")

var can_attack = true
var player_position
var target_position
var chaaarge = false

signal open_ne_noor

func _ready():
	band_aid1.hide()
	band_aid2.hide()

func _physics_process(_delta):
	
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	if chaaarge == true:
		velocity = Vector2(target_position * speed)
	
	move_and_slide()
	
func hit(damage_taken):
	
	health -= damage_taken
	
	damage_taken_sound.play()
	
	if health < 0:
		health = 0
		
	if health == 2:
		band_aid1.show()
		
	if health == 1:
		band_aid2.show()
		
	if health == 0:
		emit_signal("open_ne_noor")
		queue_free()

func _on_area_2d_body_entered(body):
	for child in body.get_children():
		if child is Camera2D && can_attack == true:
			body.hit(1)
			can_attack = false
			until_attack_timer.start()

func _on_until_attack_timeout():
	can_attack = true

func _on_level_2_commit_charge_macho():
	chaaarge = true
