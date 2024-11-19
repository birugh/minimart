extends Area2D

var bodyMasuk = false

func _on_body_entered(body: CharacterBody2D) -> void:
	print("Body memasuki noda")
	if body.is_in_group("Player"):
		Dirt.bodyMasuk = true

func _on_body_exited(body: CharacterBody2D) -> void:
	Dirt.bodyMasuk = false
