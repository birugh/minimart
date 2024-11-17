extends CharacterBody2D


const SPEED = 300.0

var syncPos = Vector2(0,0)

func _ready() -> void:
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func _physics_process(delta: float) -> void:
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
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
	else:
		global_position = global_position.lerp(syncPos, .5)
