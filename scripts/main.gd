extends Node
var is_slomo = false

func _input(event):
	if event.is_action_pressed("ui_select"):
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
		
