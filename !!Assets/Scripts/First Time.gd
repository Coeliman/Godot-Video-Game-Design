extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.FirstTimePlaying = false


func _on_options_pressed() -> void:
	queue_free()
	var options = load("res://!!Build/0.1.3/Menus/Options.tscn").instantiate()
	get_tree().current_scene.add_child(options)


func _on_lvl_slc_pressed() -> void:
	queue_free()
	var lvlslc = load("res://!!Build/0.1.3/Menus/Level Select.tscn").instantiate()
	get_tree().current_scene.add_child(lvlslc)
