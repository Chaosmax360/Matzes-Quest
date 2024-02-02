extends CharacterBody2D

@export var speed = 300
@export var gravity = 8
@export var jump_force = 300

@onready var camera = $Camera2D
@onready var sprite = $Sprite2D
@onready var ap = $AnimationPlayer
@onready var void_sound = $audio/void
@onready var moon_sound = $audio/moon
@onready var matze_jumpscare = $CanvasLayer/matze_jumpscare
@onready var jumpscare_scream = $audio/jumpscare
@onready var humpscare_label = $CanvasLayer/humpscare_label
@onready var camera_minus_timer = $timer/camera_minus
@onready var escarie_alert_sound = $audio/escarie_alert
@onready var maximax_death_image = $CanvasLayer/maximax_death
@onready var escarie_alert_label = $CanvasLayer/escarie_alert_label
@onready var info_enemy = $CanvasLayer/info_enemy
@onready var info_player = $CanvasLayer/info_player
@onready var pause_screen = $pause

var has_double_jumped = false
var bro_is_dying_rn = false

signal stop_music
signal game_pause

func _ready():
	matze_jumpscare.hide()
	humpscare_label.hide()
	maximax_death_image.hide()
	escarie_alert_label.hide()
	info_enemy.hide()
	info_player.hide()
	
func _physics_process(_delta):
	
	if !is_on_floor():
		velocity.y += gravity

	if velocity.y > 1000:
		velocity.y = 1000
		
	var horizontal_direction = Input.get_axis("left", "right")
	velocity.x = horizontal_direction * speed
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y += -jump_force
	elif Input.is_action_just_pressed("jump") && has_double_jumped == false:
		velocity.y = 0
		velocity.y += -jump_force
		has_double_jumped = true
		
	if is_on_floor():
		has_double_jumped = false
		
	if Input.is_action_just_pressed("wide_mode"):
		sprite.scale.x = 0.04
		sprite.scale.y = 0.008
	elif Input.is_action_just_released("wide_mode"):
		sprite.scale.x = 0.015
		sprite.scale.y = 0.015
		
	if is_on_floor() && camera.position.y > -15:
		camera.position.y -= 1
	if !is_on_floor() && camera.position.y < 20:
		camera.position.y += 1
		
	if Input.is_action_just_pressed("info"):
		info_enemy.show()
		info_player.show()
	elif Input.is_action_just_released("info"):
		info_enemy.hide()
		info_player.hide()
		
	if Input.is_action_just_pressed("escape"):
		emit_signal("game_pause")
		
	move_and_slide()
	
func death_to_a_matze():
	if bro_is_dying_rn == false:
		bro_is_dying_rn = true
		jumpscare_scream.play()
		matze_jumpscare.show()
		humpscare_label.show()
		await jumpscare_scream.finished
		get_tree().change_scene_to_file("res://level/title/title.tscn")

func _on_moon_body_entered(_body):
	if bro_is_dying_rn == false:
		bro_is_dying_rn = true
		emit_signal("stop_music")
		ap.play("moon")
		moon_sound.play()
		await moon_sound.finished
		get_tree().change_scene_to_file("res://level/title/title.tscn")

func _on_void_body_entered(_body):
	if bro_is_dying_rn == false:
		bro_is_dying_rn = true
		emit_signal("stop_music")
		ap.play("void")
		void_sound.play()
		await void_sound.finished
		get_tree().change_scene_to_file("res://level/title/title.tscn")
		
func maximax_death():
	if bro_is_dying_rn == false:
		bro_is_dying_rn = true
		emit_signal("stop_music")
		maximax_death_image.show()
		escarie_alert_label.show()
		escarie_alert_sound.play()
		await escarie_alert_sound.finished
		get_tree().change_scene_to_file("res://level/title/title.tscn")
	
func maximax_jump():
	velocity.y -= 1000
	camera.zoom.x = -3
	camera.zoom.y = -3
	camera_minus_timer.start()
	
func _on_camera_minus_timeout():
	camera.zoom.x = 3
	camera.zoom.y = 3
