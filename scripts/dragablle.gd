extends RigidBody2D

var is_held = false
export var follow_mouse_strength = 50
signal clicked

func _ready():
	input_pickable = true
	add_to_group("dragablle", true)

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

func _physics_process(_delta):
	var mp = get_global_mouse_position()
	if is_held:
		var dir_force = (mp-global_position)*follow_mouse_strength
		linear_damp = 20
		set_axis_velocity(dir_force)
	else:
		linear_damp = -1

func pickup():
	if is_held:
		return
	is_held = true

func drop():
	is_held = false
