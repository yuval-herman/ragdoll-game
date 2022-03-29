extends PinJoint2D

class_name HoldPin
var pinned

func _draw():
	draw_line(Vector2(), Vector2.UP*10, Color(1,1,1), 2)

func _ready():
	hide()
	node_a = get_parent().get_path()

func toggle():
	if visible:
		hide()
		if pinned:
			release()
	else:
		show()

func hide():
	$Area2D.set_deferred("monitoring", false)
	.hide()

func show():
	$Area2D.set_deferred("monitoring", true)
	.show()

func pinn_object(obj: Node2D):
	if pinned:
		return
	pinned = obj
	obj.global_transform.origin = global_position
	node_b=obj.get_path()
	if obj.has_signal("died"):
		obj.connect("died", self, "obj_died")
	if obj.has_method("attach"):
		obj.attach(self)
	

func release():
	pinned.disconnect("died", self, "obj_died")
	pinned = false
	node_b=""
	$Area2D.set_deferred("monitoring", true)
	show()

func obj_died(obj):
	queue_free()

func _on_Area2D_body_entered(body):
	if body.is_in_group("body_part"):
		return
	pinn_object(body)
	hide()

func _on_holdPin_tree_exited():
	if pinned and pinned.has_method("dittach"):
		pinned.dittach()
