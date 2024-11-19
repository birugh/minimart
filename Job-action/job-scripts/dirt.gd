extends Area2D

var bodyMasuk = false
var bersihkanDone = false

func _process(delta: float) -> void:
	if bersihkanDone:
		queue_free()

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		body.on_enter_dirt(self)  # Panggil fungsi di Player
		bodyMasuk = true

func _on_body_exited(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		body.on_exit_dirt(self)  # Panggil fungsi di Player
		bodyMasuk = false
