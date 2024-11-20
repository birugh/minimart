extends CharacterBody2D

var SPEED = 0

func _ready() -> void:
	set_multiplayer_authority(name.to_int())
	#%DisplayAuthority.visible = is_multiplayer_authority()

func _process(delta: float) -> void:
	if not is_multiplayer_authority(): return
	
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
	else:
		$AnimatedSprite2D.stop()
	
	if Input.is_action_pressed("sprint"):
		SPEED = 220.0
	else:
		SPEED = 150.0
	
	velocity = direction * SPEED
	move_and_slide()
