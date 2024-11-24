extends Area2D

var bodyEntered = false

func _on_body_entered(body: CharacterBody2D) -> void:
	bodyEntered = true
	if body.is_in_group("Player"):
		print("Body memasuki area")


func _on_body_exited(body: CharacterBody2D) -> void:
	bodyEntered = false
