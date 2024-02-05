extends Node3D

@onready var player = $player_lvl3

func _process(_delta):
	
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
