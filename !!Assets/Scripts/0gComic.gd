extends Node


# Called when the node enters the scene tree for the first time.
func _on_continue_pressed() -> void:
	get_tree().change_scene_to_file("res://!!Build/0.1.3/Levels/Tutorial.tscn")
