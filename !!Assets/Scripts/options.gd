extends Control

func _ready() -> void:
	Global.FirstTimePlaying = false
	

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://!!Build/0.1.3/Menus/0.1.3.tscn")


func _2player_pressed() -> void:
	Global.Players = 2.0
	print(Global.Players)


func _3player_pressed() -> void:
	Global.Players = 3.0
	print(Global.Players)


func _4player_pressed() -> void:
	Global.Players = 4.0
	print(Global.Players)
