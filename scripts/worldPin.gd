extends Node2D

func _draw():
	draw_circle(Vector2(), 10, Color(1,1,1))

func _ready():
	if get_tree().paused:
		yield(Helpers.wait_for_unpause(get_tree()), "completed")
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	var pinned_object = $Area2D.get_overlapping_bodies()
	if not pinned_object:
		queue_free()
		return
	reparentPinned(pinned_object[0])

func reparentPinned(obj: Node2D):
	$PinJoint2D.node_b=obj.get_path()
	pass

func rem_area2D(): #just a tiny free and easy performance save ;-)
	var rem = $Area2D
	remove_child($Area2D)
	rem.queue_free()
