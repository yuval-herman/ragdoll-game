extends RigidBody2D

var is_held = false
var held_dump = 20
export var follow_mouse_strength = 50
signal clicked
var dir_force
var mp

func _ready():
	input_pickable = true
	can_sleep = false
	add_to_group("dragablle", true)
	connect("clicked", Singleton.main, "_on_clicked")

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

func _physics_process(_delta):
	mp = get_global_mouse_position()
	if is_held:
		dir_force = (mp-global_position)*follow_mouse_strength
		linear_damp = held_dump
		set_axis_velocity(dir_force)
	else:
		linear_damp = -1

func pickup():
	if is_held:
		return
	is_held = true

func drop():
	is_held = false