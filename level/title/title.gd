extends Control

@onready var title_bgm = $audio/title_bgm

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	title_bgm.play()

func _on_texture_button_pressed():
	get_tree().change_scene_to_file("res://level/title/level_select.tscn")
	
func _on_leave_game_pressed():
	get_tree().quit()
