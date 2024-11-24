extends CharacterBody2D

var SPEED = 0
var bersihkanDur = 50  
var bersihkan = 0  
var is_cleaning = false  
var current_dirt = null 
var randNum = null

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
	elif Input.is_action_pressed("action"):
		var CashierSpots = get_parent().get_node("CashierSpots")
		if CashierSpots.bodyEntered:
			$AnimatedSprite2D.play("working")

		if Stocks.bodyEntered and Stocks.StockAvailable and Input.is_action_just_pressed("action"):
			randomNumberGen()
			print("Trigering")
			if randNum == 1:
				Foods.stockingItem1 = true
				Stocks.StockAvailable = false
			elif randNum == 2:
				Items.stockingItem2 = true
				Stocks.StockAvailable = false
			else :
				Foods.stockingItem1 = false
				Items.stockingItem2 = false
				Stocks.StockAvailable = false
			print("Angka random: ", randNum)
	
		if Foods.bodyEntered and Input.is_action_just_pressed('action'):
			displayingItem()
			Foods.stockingItem1 = false
			Stocks.StockAvailable = true
		elif Items.bodyEntered and Input.is_action_just_pressed('action'):
			displayingItem()
			Items.stockingItem2 = false
			Stocks.StockAvailable = true
			

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

	if Input.is_action_just_released("action"):
		if is_cleaning:
			is_cleaning = false
			bersihkan = 0
			print("Pembersihan dibatalkan.")

	if Input.is_action_pressed("sprint"):
		SPEED = 220.0
	else:
		SPEED = 150.0

	velocity = direction * SPEED
	move_and_slide()

func on_enter_dirt(dirt):
	current_dirt = dirt

func randomNumberGen():
	var rng = RandomNumberGenerator.new()
	randNum = rng.randi_range(1, 2)

func displayingItem():
	print("Mendisplay item...")

func on_exit_dirt(dirt):
	if current_dirt == dirt:
		current_dirt = null
