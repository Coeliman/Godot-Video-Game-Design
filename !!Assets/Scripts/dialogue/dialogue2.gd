extends Node

var Dia
var Active = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if Active == false:
		Active = true
		if body.name == "Astro" or body.name == "Astro2" or body.name == "Astro3" or body.name == "Astro4":
			Dia = load("res://!!Build/0.1.3/Menus/dialogue/dialogue2.tscn").instantiate()
			get_tree().current_scene.add_child(Dia)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if Active == true:
		Active = false
		if body.name == "Astro" or body.name == "Astro2" or body.name == "Astro3" or body.name == "Astro4":
			Dia.call_deferred("queue_free")
