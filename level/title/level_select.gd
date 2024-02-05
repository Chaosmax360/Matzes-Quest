extends Control

@onready var choose_level_bgm = $choose_level_bgm

func _ready():
	choose_level_bgm.play()
	
func _physics_process(_delta):
	
	if Input.is_action_just_pressed("escape"):
		get_tree().change_scene_to_file("res://level/title/title.tscn")
		
	if Input.is_action_just_pressed("test_level"):
		get_tree().change_scene_to_file("res://level/level3/level3.tscn")

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://level/level1/level1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://level/level2/level2.tscn")
	
