extends Node2D

@onready var basic_bgm = $audio/basic_bgm
@onready var next_level_sound = $audio/next_level
@onready var dont_leave_barrier = $dont_leave
@onready var ap = $AnimationPlayer

var already_next_level = false

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	basic_bgm.play()
	dont_leave_barrier.set_collision_layer_value(1, false)

func _on_player_stop_music():
	basic_bgm.stop()

func _on_next_level_body_entered(_body):
	if already_next_level == false:
		already_next_level = true
		dont_leave_barrier.set_collision_layer_value(1, true)
		ap.play("next_level_fade_black")
		next_level_sound.play()
		await next_level_sound.finished
		get_tree().change_scene_to_file("res://level/level2/level2.tscn")
