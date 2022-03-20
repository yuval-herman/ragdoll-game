extends Node
var is_slomo = false
enum MouseModes {DRAG, PIN}
var mouseMode = MouseModes.DRAG
onready var pin = load("res://scenes/worldPin.tscn")

func _input(event):
	if event.is_action_pressed("mode drag"):
		change_mouse_mode(MouseModes.DRAG)
	elif event.is_action_pressed("mode pin"):
		change_mouse_mode(MouseModes.PIN)
	elif event.is_action_pressed("slomo"):
		toggle_slomo()
	elif event.is_action_released("slomo"):
		toggle_slomo()
	elif event.is_action_released("pause"):
		get_tree().paused = !get_tree().paused;
	elif event.is_action_pressed("zoom_in"):
		zoom(.5)
	elif event.is_action_pressed("zoom_out"):
		zoom(2)
	elif event.is_action_pressed("left click") and mouseMode == MouseModes.PIN:
		spawn_pin()

func change_mouse_mode(mode):
	mouseMode = mode
	$CanvasLayer/mouseModeLable.text = MouseModes.keys()[mode]

func spawn_pin():
	var newPin = pin.instance()
	newPin.global_position = $Camera2D.get_global_mouse_position()
	add_child(newPin)

func zoom(zoom):
	$Camera2D.global_position = $Camera2D.get_global_mouse_position()
	$Camera2D.zoom *= zoom

func toggle_slomo():
	if is_slomo:
		Engine.time_scale = 1
	else:
		Engine.time_scale = .1
	is_slomo = !is_slomo
