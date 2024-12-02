extends Control


func _on_button_pressed() -> void:
	queue_free()


func _2player_pressed() -> void:
	Global.Players = 2.0
	print(Global.Players)


func _3player_pressed() -> void:
	Global.Players = 3.0
	print(Global.Players)


func _4player_pressed() -> void:
	Global.Players = 4.0
	print(Global.Players)
