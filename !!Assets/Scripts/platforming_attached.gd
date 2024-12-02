extends Node2D
var pcount = Global.Players
var avg_pos = Vector2(0,0)
var avg_maxy = Vector2(0,0)
var avg_miny = Vector2(0,0)
var avg_y = Vector2(0,0)
var avg_maxx = Vector2(0,0)
var avg_minx = Vector2(0,0)
var avg_x = Vector2(0,0)
var max_distance: float = 425.0
var bounce: float = 100.0

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
	
#func _process(delta: float) -> void:
	#if pcount == 2:
	#	var distance1to2 = Global.pf_Player1Character.position.distance_to(Global.pf_Player2Character.position)
	#	
	#	#sees if over max distance
	#	if distance1to2 > max_distance:
	#		#gets the vector of the other char
	#		var direction1to2 = (Global.pf_Player1Character.position - Global.pf_Player2Character.position).normalized()
	#		var direction2to1 = (Global.pf_Player2Character.position - Global.pf_Player1Character.position).normalized()
	#		
	#		#sets velocity towards eachother if char hits the max dist
	#		Global.pf_Player1Character.velocity = direction1to2 * bounce
	#		Global.pf_Player2Character.velocity = direction2to1 * bounce
	#		
	#if pcount ==3:
	#	
	#	var distance1to2 = Global.pf_Player1Character.position.distance_to(Global.pf_Player2Character.position)
	#	var distance2to3= Global.pf_Player2Character.position.distance_to(Global.pf_Player3Character.position)
	#	#sees if over max distance
	#	if distance1to2 > max_distance:
	#		#gets the vector of the other char
	#		#sets velocity towards eachother if char hits the max dist
	#		var direction1to2 = (Global.pf_Player1Character.position - Global.pf_Player2Character.position).normalized()
	#		var direction2to1 = (Global.pf_Player2Character.position - Global.pf_Player1Character.position).normalized()
	#		Global.pf_Player1Character.velocity = direction1to2 * bounce
	#		Global.pf_Player2Character.velocity = direction2to1 * bounce
	#	if distance2to3 > max_distance:
	#		var direction2to3= (Global.pf_Player2Character.position - Global.pf_Player3Character.position).normalized()
	#		var direction3to2 = (Global.pf_Player3Character.position - Global.pf_Player2Character.position).normalized()
	#		#sets velocity towards eachother if char hits the max dist
	#		Global.pf_Player2Character.velocity = direction2to3 * bounce
	#		Global.pf_Player3Character.velocity = direction3to2 * bounce
	#		
	#if pcount ==4: 
	#	
	#	var distance1to2 = Global.pf_Player1Character.position.distance_to(Global.pf_Player2Character.position)
	#	var distance2to3= Global.pf_Player2Character.position.distance_to(Global.pf_Player3Character.position)
	#	var distance3to4= Global.pf_Player3Character.position.distance_to(Global.pf_Player4Character.position)
	#	#sees if over max distance
	#	if distance1to2 > max_distance:
	#		#gets the vector of the other char
	#		#sets velocity towards eachother if char hits the max dist
	#		var direction1to2 = (Global.pf_Player1Character.position - Global.pf_Player2Character.position).normalized()
	#		var direction2to1 = (Global.pf_Player2Character.position - Global.pf_Player1Character.position).normalized()
	#		Global.pf_Player1Character.velocity = direction1to2 * bounce
	#		Global.pf_Player2Character.velocity = direction2to1 * bounce
	#	if distance2to3 > max_distance:
	#		var direction2to3= (Global.pf_Player2Character.position - Global.pf_Player3Character.position).normalized()
	#		var direction3to2 = (Global.pf_Player3Character.position - Global.pf_Player2Character.position).normalized()
	#		#sets velocity towards eachother if char hits the max dist
	#		Global.pf_Player2Character.velocity = direction2to3 * bounce
	#		Global.pf_Player3Character.velocity = direction3to2 * bounce
	#	if distance3to4 > max_distance:
	#		var direction3to4= (Global.pf_Player3Character.position - Global.pf_Player4Character.position).normalized()
	#		var direction4to3 = (Global.pf_Player4Character.position - Global.pf_Player3Character.position).normalized()
	#		#sets velocity towards eachother if char hits the max dist
	#		Global.pf_Player3Character.velocity = direction3to4 * bounce
	#		Global.pf_Player4Character.velocity = direction4to3 * bounce
#
