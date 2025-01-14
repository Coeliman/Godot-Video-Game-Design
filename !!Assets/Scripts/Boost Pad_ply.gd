extends Node
var bounce:float = 200.0
var bounce_pad_direction
var rotation
var P1 
var P2
var P3
var P4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func body_entered(body: Node2D) -> void:
	rotation = self.rotation
	bounce_pad_direction = ($Area2D/Right.position - $Area2D/Center.position).normalized()
	var root = get_tree().current_scene
	P1 = root.get_node("Astro")
	P2 = root.get_node("Astro2")
	P3 = root.get_node("Astro3")
	P4 = root.get_node("Astro4")

	if body.name == "Astro" or body.name == "Astro2" or body.name == "Astro3" or body.name == "Astro4":
		if Global.Players ==2:
			P1.velocity = bounce_pad_direction.rotated(rotation) * bounce #only works for rigidbodies
			P2.velocity = bounce_pad_direction.rotated(rotation) * bounce 
		if Global.Players ==3:
			P3.velocity = bounce_pad_direction.rotated(rotation) * bounce 
		if Global.Players ==4:
			P4.velocity = bounce_pad_direction.rotated(rotation) * bounce 
		
