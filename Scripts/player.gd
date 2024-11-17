extends CharacterBody2D


var SPEED = 300.0
var can_interact = false
func _process(delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("move-up"):
		$AnimatedSprite2D.play("up")
		direction.y -= 1
		print(direction)
	elif Input.is_action_pressed("move-down"):
		$AnimatedSprite2D.play("down")
		direction.y += 1
	elif Input.is_action_pressed("move-right"):
		$AnimatedSprite2D.play('right')
		direction.x += 1
	elif Input.is_action_pressed("move-left"):
		$AnimatedSprite2D.play("left")
		direction.x -= 1
	else:
		$AnimatedSprite2D.stop()
		
	direction = direction.normalized()
	velocity = direction * SPEED 
	move_and_slide()
