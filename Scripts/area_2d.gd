extends Area2D

signal change_scene  # Sinyal untuk berpindah scene

var player_inside = false  # Apakah player berada di dalam area ini

func _ready():
	# Menghubungkan event body_entered dan body_exited dengan fungsi
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "Player":  # Cek apakah yang masuk adalah Player
		player_inside = true

func _on_body_exited(body):
	if body.name == "Player":
		player_inside = false
