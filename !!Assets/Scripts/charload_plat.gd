extends Node2D
var pcount = Global.Players

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p2char = load("res://!!Assets/Characters/char_2_pl.tscn").instantiate()
	get_tree().current_scene.add_child(p2char)
	p2char.global_position = Vector2(-250,0)
	if pcount == 3 or pcount == 4:
		var p3char = load("res://!!Assets/Characters/char_3_pl.tscn").instantiate()
		get_tree().current_scene.add_child(p3char)
		p3char.global_position = Vector2(0,0)
		print("p3loaded")
	if pcount == 4:
		var p4char = load("res://!!Assets/Characters/char_4_pl.tscn").instantiate()
		get_tree().current_scene.add_child(p4char)
		p4char.global_position = Vector2(100,0)
		print("p4loaded")
	
	
	
