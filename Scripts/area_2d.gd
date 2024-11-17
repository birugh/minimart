extends Area2D

signal change_scene
var player_inside = false 

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	print("Badan masuk")
	if body == "player":
		player_inside = true

func _on_body_exited(body):
	print("Badan keluar")
	if body == "player":
		player_inside = false
