extends CharacterBody2D

var SPEED = 0
func _process(delta: float) -> void:
	var bersihkanDur = 50
	var bersihkan = 0
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move-up"):
		$AnimatedSprite2D.play("up")
		direction.y -= 1
	elif Input.is_action_pressed("move-down"):
		$AnimatedSprite2D.play("down")
		direction.y += 1
	elif Input.is_action_pressed("move-right"):
		$AnimatedSprite2D.play("right")
		direction.x += 1
	elif Input.is_action_pressed("move-left"):
		$AnimatedSprite2D.play("left")
		direction.x -= 1
	elif Input.is_action_pressed("action"):
		var cashierSpots = get_parent().get_node("CashierSpots")
		if cashierSpots.bodyEntered and Input.is_action_pressed("action"):
			print("Ditekan")
			$AnimatedSprite2D.play("working")
		if Dirt.bodyMasuk and Input.is_action_pressed("action"):
			$AnimatedSprite2D.play("working")
	else:
		$AnimatedSprite2D.stop()
	
	
	
	if Input.is_action_pressed("sprint"):
		SPEED = 220.0
	else:
		SPEED = 150.0
	
	
	
	velocity = direction * SPEED
	move_and_slide()
