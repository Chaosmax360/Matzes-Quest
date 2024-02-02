extends StaticBody2D

signal has_been_broken

func hit(_none):
	emit_signal("has_been_broken")
	queue_free()
