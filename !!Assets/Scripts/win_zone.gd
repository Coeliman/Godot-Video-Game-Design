extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Astro" or body.name == "Astro2" or body.name == "Astro3" or body.name == "Astro4":
		var Win = load("res://!!Build/0.1.3/Menus/End Level.tscn").instantiate()
		get_tree().current_scene.add_child(Win)
		Engine.time_scale =0.01
