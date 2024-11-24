extends Area2D

var bodyEntered = false
var stockingItem2 = false

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player") and Items.stockingItem2:
		print("Player memasuki area display Items")
		Items.bodyEntered = true


func _on_body_exited(body: CharacterBody2D) -> void:
	Items.bodyEntered = false
