extends Node

class_name Draggable

signal clicked(obj)

var is_held := false
var held_dump := 20

onready var parent := get_parent()

export var follow_mouse_strength := 50

func _ready() -> void:
	parent.input_pickable = true
	parent.can_sleep = false
	parent.add_to_group("dragablle", true)
	parent.connect("input_event", self, "input_event")
	connect("clicked", Singleton.main, "_on_clicked")

func input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

func _physics_process(_delta) -> void:
	if is_held:
		var dir_force: Vector2 = (parent.get_global_mouse_position()-parent.global_position)\
		*follow_mouse_strength
		
		parent.linear_damp = held_dump
		parent.set_axis_velocity(dir_force)
	else:
		parent.linear_damp = -1

func pickup():
	if is_held:
		return
	is_held = true

func drop():
	is_held = false
