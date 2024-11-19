extends Node2D

@export var PlayerScene : PackedScene
#var gameScene : bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#if gameScene == false:
		#get_tree().change_scene_to_file("res://cutscene/cutscene_intro.tscn")
	#else:
		var index = 0
		for i in GameManager.Player:
			var currentPlayer = PlayerScene.instantiate()
			currentPlayer.name =  str(GameManager.Player[i].id)
			add_child(currentPlayer)
			for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
				if spawn.name == str(index):
					currentPlayer.global_position = spawn.global_position
			index += 1
	#pass 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
