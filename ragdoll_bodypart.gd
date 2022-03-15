extends RigidBody2D
var is_held = false
var follow_strength = 10

signal clicked

func _ready():
	add_to_group("body_part", true)
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)
			
func _physics_process(delta):
	if is_held:
		set_axis_velocity(
			(get_global_mouse_position()-self.global_position)
			* follow_strength)

func pickup():
	if is_held:
		return
	is_held = true

func drop():
	is_held = false
