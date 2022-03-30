extends StaticBody2D

var pinned

func pinn_object(obj: Node2D):
	pinned = obj
	$PinJoint2D.node_b=obj.get_path()
	obj.connect("died", self, "obj_died")
	$Line2D.add_point($PinJoint2D.global_position)

func pinn_location(loc: Vector2):
	$Line2D.add_point($PinJoint2D.position)
	$PinJoint2D.global_position = loc

func obj_died(obj):
	queue_free()

func _process(delta):
	if pinned:
		$Line2D.set_point_position(0, pinned.global_position)
