extends Node

#sets the max distance they can go from eachother
var max_distance: float = 425.0
var bounce: float = 100.0
#calls characters
@onready var Char1 = $Test_Character
@onready var Char2 = $Test_Character_2

func _process(_delta: float) -> void:
	#calculates distance between them
	var distance = Char1.position.distance_to(Char2.position)
	
	#sees if over max distance
	if distance > max_distance:
		#gets the vector of the other char
		var direction1to2 = (Char2.position - Char1.position).normalized()
		var direction2to1 = (Char1.position - Char2.position).normalized()
		
		#sets velocity towards eachother if char hits the max dist
		Char1.velocity = direction1to2 * bounce
		Char2.velocity = direction2to1 * bounce
		
		#debug check
		#print("Rope limit hit, bouncing characters")
