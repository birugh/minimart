extends Node2D

func _ready():
	# Ambil node Area2D
	var area_node = $Area2D
	# Hubungkan sinyal dari Area2D
	area_node.connect("change_scene", Callable(self, "_on_change_scene"))

func _on_change_scene():
	print("Changing to Map2 scene...")
	get_tree().change_scene("res://scene/Map2.tscn")
