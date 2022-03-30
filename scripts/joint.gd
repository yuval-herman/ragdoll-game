extends StaticBody2D

var pinned: RigidBody2D
var done := false

func pinn_object(obj: RigidBody2D):
	pinned = obj
	obj.mode = RigidBody2D.MODE_STATIC
	obj.connect("died", self, "obj_died")
	$Line2D.add_point($PinJoint2D.position)
	$Line2D.add_point($PinJoint2D.position)

func pinn_location(loc: Vector2):
	pinned.mode = RigidBody2D.MODE_RIGID
	$PinJoint2D.global_position = loc
	$PinJoint2D.node_b = pinned.get_path()
	done = true
	set_process_unhandled_input(false)

func obj_died(obj):
	queue_free()

func _unhandled_input(event):
	if event.is_action_released("left click"):
		pinn_location(get_global_mouse_position())

func _process(delta):
	if pinned:
		if done:
			$Line2D.set_point_position(1, to_local(pinned.global_position))
		else:
			$Line2D.set_point_position(0, get_local_mouse_position())
