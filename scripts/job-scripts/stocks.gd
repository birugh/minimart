extends Area2D

var bodyEntered = false
var StockAvailable = true
func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player") and Stocks.StockAvailable == true:
		print("Body memasuki area stocker")
		Stocks.bodyEntered = true
		


func _on_body_exited(body: CharacterBody2D) -> void:
	Stocks.bodyEntered = false
