extends Area2D

signal change_scene
var player_inside = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
	print("Sinyal sudah terhubung")

func _on_body_entered(body):
	if body.is_in_group("Player"):
		player_inside = true
		print("Player ada di dalam area")

func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_inside = false
		print("Player keluar dari area")
