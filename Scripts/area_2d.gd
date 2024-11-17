extends Area2D

var entered = false

func _on_body_entered(body: PhysicsBody2D):
	entered = true
	if body.is_in_group("Player"):
		print("Player ada di dalam area")

func _on_body_exited(body):
	entered = false
	
func _process(delta):
	if entered == true:
		if Input.is_action_pressed("interaction"):
			get_tree().change_scene_to_file("res://Scene/Map2.tscn")
