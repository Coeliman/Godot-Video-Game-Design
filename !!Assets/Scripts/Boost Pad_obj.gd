extends Node
var bounce:float = 1000.0
var bounce_pad_direction
var rotation
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func body_entered(body: Node2D) -> void:
	rotation = self.rotation
	bounce_pad_direction = ($Area2D/Right.position - $Area2D/Center.position).normalized()
	
	if body.name != "Astro" and body.name != "Astro2" and body.name != "Astro3" and body.name != "Astro4":
		body.linear_velocity = bounce_pad_direction.rotated(rotation) * bounce #only works for rigidbodies
	
