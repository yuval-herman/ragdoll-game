extends Node
var is_slomo = false
var held_object = null
enum MouseModes {DRAG, PIN}
var mouseMode = MouseModes.DRAG
onready var pin = load("res://scenes/worldPin.tscn")

func _ready():
	for n in get_tree().get_nodes_in_group("dragablle"):
		n.connect("clicked", self, "_on_clicked")

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
	elif event.is_action_released("left click"):
		if is_instance_valid(held_object) and held_object:
			held_object.drop()
			held_object = null

func _on_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()

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
