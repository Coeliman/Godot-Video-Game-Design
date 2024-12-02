extends Node2D
var pcount = Global.Players
var avg_pos = Vector2(0,0)
var avg_maxy = Vector2(0,0)
var avg_miny = Vector2(0,0)
var avg_y = Vector2(0,0)
var avg_maxx = Vector2(0,0)
var avg_minx = Vector2(0,0)
var avg_x = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var p1char = load("res://!!Assets/Characters/char_1_pl.tscn").instantiate()
	get_tree().current_scene.add_child(p1char)
	p1char.global_position = Vector2(-100,0)
	Global.pf_Player1Character = p1char
	# loads 2 char
	var p2char = load("res://!!Assets/Characters/char_2_pl.tscn").instantiate()
	get_tree().current_scene.add_child(p2char)
	p2char.global_position = Vector2(-250,0)
	Global.pf_Player2Character = p2char
	if pcount == 3 or pcount == 4:
		var p3char = load("res://!!Assets/Characters/char_3_pl.tscn").instantiate()
		get_tree().current_scene.add_child(p3char)
		p3char.global_position = Vector2(0,0)
		Global.pf_Player3Character = p3char
		print("p3loaded")
	if pcount == 4:
		var p4char = load("res://!!Assets/Characters/char_4_pl.tscn").instantiate()
		get_tree().current_scene.add_child(p4char)
		p4char.global_position = Vector2(100,0)
		Global.pf_Player4Character = p4char
		print("p4loaded")
	
func _process(delta: float) -> void:
	if pcount ==2:
		pass
	if pcount ==3:
		pass
	if pcount ==4:
		pass

	
