extends Node2D

func _draw():
	draw_circle(Vector2(), 10, Color(1,1,1))

func pinn_object(obj: Node2D):
	print(obj)
	$PinJoint2D.node_b=obj.get_path()
	obj.connect("died", self, "obj_died")

func obj_died(obj):
	queue_free()
