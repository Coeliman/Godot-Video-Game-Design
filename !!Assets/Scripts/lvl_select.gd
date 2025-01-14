extends Node




func platformer_pressed() -> void: #tutorial
	queue_free()
	# loads comic, make sure to change it to the comic scene you want
	var Comic = load("res://!!Build/0.1.3/Menus/Comics/PlatformerComic.tscn").instantiate()
	get_tree().current_scene.add_child(Comic)


func zerog_pressed() -> void: #level1
	queue_free()
	var Comic = load("res://!!Build/0.1.3/Menus/Comics/Comic Example.tscn").instantiate()
	get_tree().current_scene.add_child(Comic)


func _close_pressed() -> void:
	queue_free()


func _on_button_3_pressed() -> void: #level2
	queue_free()
	# loads comic, make sure to change it to the comic scene you want
	var Comic = load("res://!!Build/0.1.3/Menus/Comics/level2comic.tscn").instantiate()
	get_tree().current_scene.add_child(Comic)
