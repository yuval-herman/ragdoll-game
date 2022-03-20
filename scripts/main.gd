extends Node
var is_slomo = false
var mouseMode = 1
onready var pin = load("res://scenes/worldPin.tscn")

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			if mouseMode == 1:
				var newPin = pin.instance()
				newPin.global_position = $Camera2D.get_global_mouse_position()
				add_child(newPin)
	
	elif event.is_action_pressed("ui_select"):
		if is_slomo:
			Engine.time_scale = 1
			is_slomo = false
		else:
			Engine.time_scale = .1
			is_slomo = true
	elif event.is_action_pressed("zoom_in"):
		$Camera2D.global_position = $Camera2D.get_global_mouse_position()
		$Camera2D.zoom /= 2
	elif event.is_action_pressed("zoom_out"):
		$Camera2D.global_position = $Camera2D.get_global_mouse_position()
		$Camera2D.zoom *= 2
