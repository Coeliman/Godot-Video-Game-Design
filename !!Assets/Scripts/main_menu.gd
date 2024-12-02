extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_start_pressed() -> void:
	var lvlslc = load("res://!!Build/0.1.3/Menus/Level Select.tscn").instantiate()
	get_tree().current_scene.add_child(lvlslc)


func _on_options_pressed() -> void:
	var options = load("res://!!Build/0.1.3/Menus/Options.tscn").instantiate()
	get_tree().current_scene.add_child(options)


func _on_quit_pressed() -> void:
	get_tree().quit()
