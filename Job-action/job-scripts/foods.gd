extends Area2D

var bodyEntered = false
var stockingItem1 = false

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player") and Foods.stockingItem1:
		print("Player memasuki area display makanan")
		Foods.bodyEntered = true


func _on_body_exited(body: CharacterBody2D) -> void:
	Foods.bodyEntered = false
