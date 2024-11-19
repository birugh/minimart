extends CharacterBody2D

var SPEED = 0
var bersihkanDur = 50  # Durasi pembersihan (angka ini bisa diatur sesuai kebutuhan)
var bersihkan = 0  # Progres pembersihan
var is_cleaning = false  # Status apakah sedang dalam proses pembersihan
var current_dirt = null  # Referensi ke instance Dirt yang aktif

func _process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Kontrol Gerakan
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
		var CashierSpots = get_parent().get_node("CashierSpots")
		if CashierSpots.bodyEntered:
			$AnimatedSprite2D.play("working")

		if not is_cleaning and current_dirt and current_dirt.bodyMasuk:
			is_cleaning = true
			$AnimatedSprite2D.play("working")
			print("Pembersihan dimulai...")
		elif is_cleaning:
			bersihkan += 1
			if bersihkan >= bersihkanDur:
				current_dirt.bersihkanDone = true
				is_cleaning = false
				bersihkan = 0
				print("Pembersihan selesai!")
	else:
		$AnimatedSprite2D.stop()

	# Hentikan proses jika tombol dilepas
	if Input.is_action_just_released("action"):
		if is_cleaning:
			is_cleaning = false
			bersihkan = 0
			print("Pembersihan dibatalkan.")

	# Kontrol Sprint
	if Input.is_action_pressed("sprint"):
		SPEED = 220.0
	else:
		SPEED = 150.0

	# Update kecepatan pemain
	velocity = direction * SPEED
	move_and_slide()

# Tambahkan metode untuk menangani enter/exit dirt
func on_enter_dirt(dirt):
	current_dirt = dirt

func on_exit_dirt(dirt):
	if current_dirt == dirt:
		current_dirt = null
