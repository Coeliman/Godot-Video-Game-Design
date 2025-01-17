extends Control
@export var audio_player: AudioStreamPlayer2D 
var activated = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not audio_player.playing:
		audio_player.play()
		activated = true

func _on_start_pressed() -> void:
	if Global.FirstTimePlaying == false:
		var lvlslc = load("res://!!Build/0.1.3/Menus/Level Select.tscn").instantiate()
		get_tree().current_scene.add_child(lvlslc)
	else:
		var FirstTime = load("res://!!Build/0.1.3/Menus/First Time Warning.tscn").instantiate()
		get_tree().current_scene.add_child(FirstTime)

func _on_options_pressed() -> void:
	var options = load("res://!!Build/0.1.3/Menus/Options.tscn").instantiate()
	get_tree().current_scene.add_child(options)

func _process(_delta: float) -> void:
	if not activated:
		if not audio_player.playing:
			audio_player.play()
			activated = true
