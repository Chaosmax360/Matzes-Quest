extends Control

@onready var canvas = $CanvasLayer

var paused = false

func _ready():
	canvas.hide()
	
func _physics_process(_delta):
	if Input.is_action_just_pressed("escape") && paused == true:
		_on_resume_pressed()

func _on_quit_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://level/title/title.tscn")

func _on_resume_pressed():
	canvas.hide()
	paused = false
	get_tree().paused = false
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)

func _on_player_game_pause():
	canvas.show()
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	await get_tree().physics_frame
	paused = true
	
func _on_player_lvl_2_game_pause():
	canvas.show()
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	await get_tree().physics_frame
	paused = true
