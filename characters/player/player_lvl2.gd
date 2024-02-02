extends CharacterBody2D

@export var speed = 100
@export var damage = 1
@export var health = 6

@onready var attack_area = $attack_area
@onready var ap = $AnimationPlayer
@onready var attack_sound = $audio/attack_sound
@onready var info_enemy = $CanvasLayer/info_enemy
@onready var info_player = $CanvasLayer/info_player
@onready var band_aid1 = $band_aid1
@onready var band_aid2 = $band_aid2
@onready var band_aid3 = $band_aid3
@onready var band_aid4 = $band_aid4
@onready var band_aid5 = $band_aid5
@onready var damage_taken_sound = $audio/damage_taken
@onready var can_take_damage_timer = $can_take_damage_timer
@onready var sprite = $Sprite2D

var can_attack = true
var can_take_damage = true

signal game_pause

func _ready():
	attack_area.monitoring = false
	info_enemy.hide()
	info_player.hide()
	band_aid1.hide()
	band_aid2.hide()
	band_aid3.hide()
	band_aid4.hide()
	band_aid5.hide()

func _physics_process(_delta):
	
	var horizontal_movement = Input.get_axis("left", "right")
	var vertical_movement = Input.get_axis("up", "down")
	
	velocity.x = horizontal_movement * speed
	velocity.y = vertical_movement * speed
	
	if Input.is_action_just_pressed("lvl2_attack") && can_attack == true:
		can_attack = false
		ap.play("attack")
		attack_sound.play()
		await ap.animation_finished
		can_attack = true
	
	if Input.is_action_just_pressed("info"):
		info_enemy.show()
		info_player.show()
	elif Input.is_action_just_released("info"):
		info_enemy.hide()
		info_player.hide()
		
	if Input.is_action_just_pressed("upside_down_mode"):
		sprite.scale.x = -0.015
		sprite.scale.y = -0.015
	elif Input.is_action_just_released("upside_down_mode"):
		sprite.scale.x = 0.015
		sprite.scale.y = 0.015
		
	if Input.is_action_just_pressed("escape"):
		emit_signal("game_pause")
		
	move_and_slide()

func _on_attack_area_body_entered(body):
	body.hit(damage)
	
func hit(damage_taken):
	
	if can_take_damage == true:
		
		can_take_damage = false
		can_take_damage_timer.start()
		
		health -= damage_taken
		
		damage_taken_sound.play()
		
		if health < 0:
			health = 0
			
		if health == 5:
			band_aid1.show()
			
		if health == 4:
			band_aid2.show()
			
		if health == 3:
			band_aid3.show()
			
		if health == 2:
			band_aid4.show()
			
		if health == 1:
			band_aid5.show()
			
		if health == 0:
			get_tree().change_scene_to_file("res://level/title/title.tscn")

func _on_can_take_damage_timer_timeout():
	can_take_damage = true
