extends CharacterBody2D

var SPEED = 0

func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("move-up"):
		$AnimatedSprite2D.play("Up")
		direction.y -= 1
	elif Input.is_action_pressed("move-down"):
		$AnimatedSprite2D.play("Down")
		direction.y += 1
	elif Input.is_action_pressed("move-right"):
		$AnimatedSprite2D.play("Right")
		direction.x += 1
	elif Input.is_action_pressed("move-left"):
		$AnimatedSprite2D.play("Left")
		direction.x -= 1
	else:
		$AnimatedSprite2D.stop()
	
	if Input.is_action_pressed("sprint"):
		SPEED = 220.0
	else:
		SPEED = 150.0

	velocity = direction * SPEED
	move_and_slide()
