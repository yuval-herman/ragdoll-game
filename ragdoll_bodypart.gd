extends RigidBody2D
var is_held = false
var follow_mouse_strength = 50
export var life = 100

signal clicked
signal died

func _process(delta):
	if life <= 0:
		die()

func _ready():
	add_to_group("body_part", true)
	connect("body_entered", self, "hit_object")
	
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)
			
func _physics_process(delta):
	if is_held:
		set_axis_velocity(
			(get_global_mouse_position()-self.global_position)
			* follow_mouse_strength)

func die():
	emit_signal("died", self)
	queue_free()

func pickup():
	if is_held:
		return
	is_held = true

func drop():
	is_held = false

func sum(arr):
	var ret=0
	for i in arr:
		ret+=i
	return ret

func hit_object(body):
	if not body.is_in_group("body_part"):
		var strength = sum(linear_velocity)/500
		life-=strength
		print(name,strength,life)
