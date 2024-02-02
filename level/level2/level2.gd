extends Node2D

@onready var lvl2_bgm = $audio/lvl2_bgm
@onready var lock1 = $TileMap_ysort/lock
@onready var lock2 = $TileMap_ysort/lock2
@onready var lock3 = $TileMap_ysort/lock3
@onready var lock4 = $TileMap_ysort/lock4
@onready var lock5 = $TileMap_ysort/lock5
@onready var lock6 = $TileMap_ysort/lock6
@onready var dont_leave_barrier = $dont_leave
@onready var next_level_sound = $audio/next_level
@onready var ap = $AnimationPlayer

var open_ne_noor_count = 0
var already_next_level = false

signal commit_charge_macho
signal commit_charge_macho_white
signal commit_charge_tyron
signal commit_charge_marvin
signal commit_charge_marlon
signal commit_charge_emem

func _ready():
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_HIDDEN)
	lvl2_bgm.play()
	dont_leave_barrier.set_collision_layer_value(1, false)

func _physics_process(_delta):
	
	if open_ne_noor_count == 2:
		lock1.queue_free()
		open_ne_noor_count += 1
		emit_signal("commit_charge_macho_white")
	if open_ne_noor_count == 5:
		lock2.queue_free()
		open_ne_noor_count += 1
		emit_signal("commit_charge_tyron")
	if open_ne_noor_count == 8:
		lock3.queue_free()
		open_ne_noor_count += 1
		emit_signal("commit_charge_marvin")
	if open_ne_noor_count == 11:
		lock4.queue_free()
		open_ne_noor_count += 1
		emit_signal("commit_charge_marlon")
		lvl2_bgm.stop()
	if open_ne_noor_count == 14:
		lvl2_bgm.play()
		lock5.queue_free()
		open_ne_noor_count += 1
		emit_signal("commit_charge_emem")
	if open_ne_noor_count == 17:
		lock6.queue_free()
		open_ne_noor_count += 1
	
func _on_next_level_body_entered(_body):
	if already_next_level == false:
		already_next_level = true
		dont_leave_barrier.set_collision_layer_value(1, true)
		ap.play("next_level_fade_black")
		next_level_sound.play()
		await next_level_sound.finished
		get_tree().change_scene_to_file("res://level/title/title.tscn")
	
func _on_wall_has_been_broken():
	emit_signal("commit_charge_macho")

func _on_macho_open_ne_noor():
	open_ne_noor_count += 1

func _on_macho_2_open_ne_noor():
	open_ne_noor_count += 1

func _on_macho_white_open_ne_noor():
	open_ne_noor_count += 1

func _on_macho_white_2_open_ne_noor():
	open_ne_noor_count += 1

func _on_tyron_open_ne_noor():
	open_ne_noor_count += 1

func _on_tyron_2_open_ne_noor():
	open_ne_noor_count += 1

func _on_marvin_open_ne_noor():
	open_ne_noor_count += 1

func _on_marvin_2_open_ne_noor():
	open_ne_noor_count += 1

func _on_marlon_open_ne_noor():
	open_ne_noor_count += 1

func _on_marlon_2_open_ne_noor():
	open_ne_noor_count += 1

func _on_emem_open_ne_noor():
	open_ne_noor_count += 1

func _on_emem_2_open_ne_noor():
	open_ne_noor_count += 1
