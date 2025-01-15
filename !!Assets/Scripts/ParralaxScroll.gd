extends Node2D

@export var scrolling_speed : float = 100.0 # Scrolling speed of the background
var parallax_background : ParallaxBackground

func _ready() -> void:
	parallax_background= get_child(0)# Reference to the ParallaxBackground node
	# Ensure the ParallaxBackground node is valid
	if parallax_background == null:
		push_error("ParallaxBackground node not assigned!")
	

func _process(delta: float) -> void:
	parallax_background.scroll_base_offset -= Vector2(0,1)
