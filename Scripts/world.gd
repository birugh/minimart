extends Node2D

func _ready():
	var area_node = $Area2D
	area_node.connect("change_scene", Callable(self, "_on_change_scene"))

func _on_change_scene():
	print("Changing to Map2 scene...")
	get_tree().change_scene("res://Scene/Map2.tscn")
