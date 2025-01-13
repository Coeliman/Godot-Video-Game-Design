extends Control
var pause_menu: Node = null
func _ready() -> void:
	pause_menu = $"."
func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://!!Build/0.1.3/Menus/0.1.3.tscn")
	Global.paused = false
	Engine.time_scale=1
	


func _on_resume_pressed() -> void:
	call_deferred("queue_free")
	Global.paused = false
	Engine.time_scale=1
	


func _on_restart_level_pressed() -> void:
	get_tree().reload_current_scene()
	Global.paused = false
	Engine.time_scale=1
