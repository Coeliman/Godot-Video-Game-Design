class_name P1_Hotkey
extends Control

@onready var button = $Container/HotkeyB as Button
@onready var label = $Container/HotkeyB/HotkeyL as Label


@export var U_Action_Name : String = "p1_up" #which player input do you wish to use, should be p1_up, p2_left, etc


func _ready():
	set_process_unhandled_input(false)
	set_text_for_key()
	

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(U_Action_Name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text ="%s" % action_keycode # pretty much this is the fancy stuff that actually sets the key text to the action

func _on_hotkey_b_toggled(toggled_on: bool):
	if toggled_on == true:
		button.text = ". . ."
		set_process_unhandled_key_input(toggled_on)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.U_Action_Name != self.U_Action_Name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.U_Action_Name != self.U_Action_Name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(true)
			
		set_text_for_key()
		#this is what stops you from pressing like 5 buttons at once
		
func _unhandled_key_input(event: InputEvent):
	rebind_action_key(event)
	button.button_pressed = false
	#pending input


func rebind_action_key(event) -> void:
	var is_duplicate=false
	var action_event=event
	var action_keycode=OS.get_keycode_string(action_event.physical_keycode)
	for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.U_Action_Name!=self.U_Action_Name:
				if i.button.text=="%s" %action_keycode:
					is_duplicate=true
					break
	if not is_duplicate:
		InputMap.action_erase_events(U_Action_Name)
		InputMap.action_add_event(U_Action_Name,event)
		set_process_unhandled_key_input(false)
		set_text_for_key()
	#actually rebinds, and checks for duplicates. If the duplicate thing is not on it it will shit itself
