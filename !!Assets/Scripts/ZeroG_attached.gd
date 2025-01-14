extends Node

#sets the max distance they can go from eachother

var max_distance: float = 410.0
var bounce: float = 50.0
var pcount = Global.Players

var loading : PackedScene
var timer: Timer
var loading_instance : Node
#calls characters


func _ready() -> void:
	##CHARACTER IMPORTS
	loading = load("res://!!Assets/Scenes/Loading.tscn")
	loading_instance = loading.instantiate()
	add_child(loading_instance)
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.connect("timeout",Callable(self,"_on_Timer_timeout"))
	add_child(timer)
	timer.start()
	# loads char1 into scene
	var p1char = load("res://!!Assets/Characters/astro.tscn").instantiate()
	get_tree().current_scene.add_child(p1char)
	p1char.global_position = Vector2(-420,0)
	Global.g_Player1Character = p1char
	Global.g_P1_Path = p1char.get_child(1).get_path()
	#THE # IN GET_CHILD MUST ALIGN WITH WHICHEVER SPOT THE STATICBODY 2D IS IN, COUNTING AS IF ITS A LIST (SO 0,1,2,ETC)
	print(p1char.get_child(1).get_path())
	# loads char2 into scene
	var p2char = load("res://!!Assets/Characters/astro_2.tscn").instantiate()
	get_tree().current_scene.add_child(p2char)
	p2char.global_position = Vector2(0,0)
	Global.g_Player2Character = p2char
	Global.g_P2_Path = p2char.get_child(1).get_path()
	print(p2char.get_child(1).get_path())
	if pcount == 3 or pcount == 4:
		# loads char3 into scene
		var p3char = load("res://!!Assets/Characters/astro_3.tscn").instantiate()
		get_tree().current_scene.add_child(p3char)
		p3char.global_position = Vector2(420,0)
		Global.g_Player3Character = p3char
		Global.g_P3_Path = p3char.get_child(1).get_path()
		print(p3char.get_child(1).get_path())
	if pcount == 4:
		#loads char4 into scene
		var p4char = load("res://!!Assets/Characters/astro_4.tscn").instantiate()
		get_tree().current_scene.add_child(p4char)
		p4char.global_position = Vector2(840,0)
		Global.g_Player4Character = p4char
		Global.g_P4_Path = p4char.get_child(1).get_path()
		print(p4char.get_child(1).get_path())
		
	## ROPE IMPORTS
	# For Starting Locs (LocS/CamLocS) you must change NodeA
	# For Ending Locks (LocE/CamLocE) you must change NodeB
	if pcount ==2:
		# loads rope player 1 to 2
		var R12 = load("res://!!Assets/3D Models/Cam_rope.tscn").instantiate()
		get_tree().current_scene.add_child(R12)
		R12.global_position = Vector2(-652,-266)
		var atc12S = R12.get_node("CamLocS")
		var atc12E = R12.get_node("CamLocE")
		atc12S.node_a = Global.g_P1_Path
		atc12E.node_b = Global.g_P2_Path

	if pcount ==3:
		# loads rope player 1 to 2
		var R12 = load("res://!!Assets/3D Models/Cam_rope.tscn").instantiate()
		get_tree().current_scene.add_child(R12)
		R12.global_position = Vector2(-652,-266)
		var atc12S = R12.get_node("CamLocS")
		var atc12E = R12.get_node("CamLocE")
		atc12S.node_a = Global.g_P1_Path
		atc12E.node_b = Global.g_P2_Path
		var R23 =load("res://!!Assets/3D Models/Better_rope.tscn").instantiate()
		get_tree().current_scene.add_child(R23)
		R23.global_position=Vector2(-232,-266)
		var atc23S = R23.get_node("CamLocS")
		var atc23E = R23.get_node("CamLocE")
		atc23S.node_a =  Global.g_P2_Path
		atc23E.node_b = Global.g_P3_Path
	if pcount ==4:
		# loads rope player 1 to 2
		var R12 = load("res://!!Assets/3D Models/Better_rope.tscn").instantiate()
		get_tree().current_scene.add_child(R12)
		R12.global_position = Vector2(-652,-266)
		var atc12S = R12.get_node("CamLocS")
		var atc12E = R12.get_node("CamLocE")
		atc12S.node_a = Global.g_P1_Path
		atc12E.node_b = Global.g_P2_Path
		var R23 =load("res://!!Assets/3D Models/Cam_rope.tscn").instantiate()
		get_tree().current_scene.add_child(R23)
		R23.global_position=Vector2(-232,-266)
		var atc23S = R23.get_node("CamLocS")
		var atc23E = R23.get_node("CamLocE")
		atc23S.node_a = Global.g_P2_Path
		atc23E.node_b = Global.g_P3_Path
		# loads rope player 3 to 4
		var R34 =load("res://!!Assets/3D Models/Better_rope.tscn").instantiate()
		get_tree().current_scene.add_child(R34)
		R34.global_position=Vector2(188,-266)
		var atc34S = R34.get_node("CamLocS")
		var atc34E = R34.get_node("CamLocE")
	
		atc34S.node_a = Global.g_P3_Path
		atc34E.node_b = Global.g_P4_Path
		
func _on_Timer_timeout():
	loading_instance.call_deferred("queue_free")
func _process(_delta: float) -> void:
	# pause menu calculations
	
	if Input.is_action_pressed("Menu") and Global.paused == false:
		Global.paused = true
		var Pause = load("res://!!Build/0.1.3/Menus/PauseMenu.tscn").instantiate()
		get_tree().current_scene.add_child(Pause)
		Engine.time_scale =0.01
	
	#calculates distance between them
	var distance12 = Global.g_Player1Character.position.distance_to(Global.g_Player2Character.position)
	#sees if over max distance
	if distance12 > max_distance:
		#gets the vector of the other char
		var direction2to1 = (Global.g_Player1Character.position - Global.g_Player2Character.position).normalized()
		var direction1to2 = (Global.g_Player2Character.position - Global.g_Player1Character.position).normalized()
		
		#sets velocity towards eachother if char hits the max dist
		Global.g_Player1Character.velocity = direction1to2 * bounce
		Global.g_Player2Character.velocity = direction2to1 * bounce
	if pcount ==3 or pcount==4:
		var distance23 = Global.g_Player2Character.position.distance_to(Global.g_Player3Character.position)
		if distance23 > max_distance:
			#gets the vector of the other char
			var direction3to2 = (Global.g_Player2Character.position - Global.g_Player3Character.position).normalized()
			var direction2to3 = (Global.g_Player3Character.position - Global.g_Player2Character.position).normalized()
			
			#sets velocity towards eachother if char hits the max dist
			Global.g_Player2Character.velocity = direction2to3 * bounce
			Global.g_Player3Character.velocity = direction3to2 * bounce
	if pcount==4:
		var distance34 = Global.g_Player3Character.position.distance_to(Global.g_Player4Character.position)
		if distance34 > max_distance:
			#gets the vector of the other char
			var direction4to3 = (Global.g_Player3Character.position - Global.g_Player4Character.position).normalized()
			var direction3to4 = (Global.g_Player4Character.position - Global.g_Player3Character.position).normalized()
			
			#sets velocity towards eachother if char hits the max dist
			Global.g_Player3Character.velocity = direction3to4 * bounce
			Global.g_Player4Character.velocity = direction4to3 * bounce
		#debug check
		#print("Rope limit hit, bouncing characters")
