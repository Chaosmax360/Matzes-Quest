extends Node3D

@onready var player = $player_lvl3
@onready var lvl3_bgm = $audio/lvl3_bgm

func _ready():
	lvl3_bgm.play()

func _process(_delta):
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)


